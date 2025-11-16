import { useRef, useEffect, useCallback } from 'react';
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer.js';
import { RenderPass } from 'three/examples/jsm/postprocessing/RenderPass.js';
import { UnrealBloomPass } from 'three/examples/jsm/postprocessing/UnrealBloomPass.js';
import { ShaderPass } from 'three/examples/jsm/postprocessing/ShaderPass.js';
import { FXAAShader } from 'three/examples/jsm/shaders/FXAAShader.js';

interface UseThreeAnimationOptions {
  container: HTMLDivElement | null;
  onHover?: (nodeId: string | null) => void;
  onClick?: (nodeId: string) => void;
  enablePostProcessing?: boolean;
}

export const useThreeAnimation = ({
  container,
  onHover,
  onClick,
  enablePostProcessing = true
}: UseThreeAnimationOptions) => {
  const sceneRef = useRef<THREE.Scene | null>(null);
  const cameraRef = useRef<THREE.PerspectiveCamera | null>(null);
  const rendererRef = useRef<THREE.WebGLRenderer | null>(null);
  const composerRef = useRef<EffectComposer | null>(null);
  const controlsRef = useRef<OrbitControls | null>(null);
  const particlesRef = useRef<THREE.Points | null>(null);
  const animationIdRef = useRef<number>(0);

  // Create animated background particles
  const createParticles = useCallback((scene: THREE.Scene) => {
    const particleCount = 1000;
    const geometry = new THREE.BufferGeometry();
    const positions = new Float32Array(particleCount * 3);
    const colors = new Float32Array(particleCount * 3);
    const sizes = new Float32Array(particleCount);

    for (let i = 0; i < particleCount; i++) {
      const i3 = i * 3;
      positions[i3] = (Math.random() - 0.5) * 1000;
      positions[i3 + 1] = (Math.random() - 0.5) * 1000;
      positions[i3 + 2] = (Math.random() - 0.5) * 1000;

      // Random purple/blue gradient colors
      colors[i3] = 0.5 + Math.random() * 0.5; // R
      colors[i3 + 1] = 0.3 + Math.random() * 0.4; // G
      colors[i3 + 2] = 0.8 + Math.random() * 0.2; // B

      sizes[i] = Math.random() * 2;
    }

    geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3));
    geometry.setAttribute('size', new THREE.BufferAttribute(sizes, 1));

    const material = new THREE.PointsMaterial({
      size: 2,
      sizeAttenuation: true,
      vertexColors: true,
      transparent: true,
      opacity: 0.6,
      blending: THREE.AdditiveBlending,
      depthWrite: false,
    });

    const particles = new THREE.Points(geometry, material);
    scene.add(particles);
    particlesRef.current = particles;

    return particles;
  }, []);

  // Animate particles
  const animateParticles = useCallback(() => {
    if (!particlesRef.current) return;

    const positions = particlesRef.current.geometry.attributes.position as THREE.BufferAttribute;
    const count = positions.count;

    for (let i = 0; i < count; i++) {
      const i3 = i * 3;
      const x = positions.array[i3];
      const y = positions.array[i3 + 1];
      const z = positions.array[i3 + 2];

      // Slow drift animation
      positions.array[i3 + 1] = y + Math.sin(Date.now() * 0.0001 + i) * 0.1;
      
      // Wrap around when particles go too far
      if (Math.abs(x) > 500) positions.array[i3] *= -0.9;
      if (Math.abs(y) > 500) positions.array[i3 + 1] *= -0.9;
      if (Math.abs(z) > 500) positions.array[i3 + 2] *= -0.9;
    }

    positions.needsUpdate = true;
    particlesRef.current.rotation.y += 0.0001;
  }, []);

  // Setup post-processing
  const setupPostProcessing = useCallback((
    renderer: THREE.WebGLRenderer,
    scene: THREE.Scene,
    camera: THREE.PerspectiveCamera
  ) => {
    if (!enablePostProcessing) return null;

    const composer = new EffectComposer(renderer);
    
    // Main render pass
    const renderPass = new RenderPass(scene, camera);
    composer.addPass(renderPass);

    // Bloom effect
    const bloomPass = new UnrealBloomPass(
      new THREE.Vector2(window.innerWidth, window.innerHeight),
      0.5,  // Strength
      0.4,  // Radius
      0.85  // Threshold
    );
    composer.addPass(bloomPass);

    // Anti-aliasing
    const fxaaPass = new ShaderPass(FXAAShader);
    fxaaPass.uniforms['resolution'].value.set(
      1 / window.innerWidth,
      1 / window.innerHeight
    );
    composer.addPass(fxaaPass);

    composerRef.current = composer;
    return composer;
  }, [enablePostProcessing]);

  // Initialize scene
  const init = useCallback(() => {
    if (!container) return;

    const width = container.clientWidth;
    const height = container.clientHeight;

    // Scene
    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0x01030f);
    scene.fog = new THREE.Fog(0x01030f, 300, 1000);
    sceneRef.current = scene;

    // Camera
    const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 2000);
    camera.position.set(0, 50, 300);
    cameraRef.current = camera;

    // Renderer
    const renderer = new THREE.WebGLRenderer({
      antialias: true,
      alpha: true,
      powerPreference: 'high-performance'
    });
    renderer.setSize(width, height);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    renderer.toneMapping = THREE.ACESFilmicToneMapping;
    renderer.toneMappingExposure = 1.2;
    container.appendChild(renderer.domElement);
    rendererRef.current = renderer;

    // Controls
    const controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.05;
    controls.minDistance = 100;
    controls.maxDistance = 600;
    controls.autoRotate = true;
    controls.autoRotateSpeed = 0.3;
    controlsRef.current = controls;

    // Particles
    createParticles(scene);

    // Post-processing
    setupPostProcessing(renderer, scene, camera);

    return { scene, camera, renderer, controls };
  }, [container, createParticles, setupPostProcessing]);

  // Animation loop
  const animate = useCallback(() => {
    if (!sceneRef.current || !cameraRef.current) return;

    animateParticles();

    if (controlsRef.current) {
      controlsRef.current.update();
    }

    if (composerRef.current && enablePostProcessing) {
      composerRef.current.render();
    } else if (rendererRef.current) {
      rendererRef.current.render(sceneRef.current, cameraRef.current);
    }

    animationIdRef.current = requestAnimationFrame(animate);
  }, [animateParticles, enablePostProcessing]);

  // Handle resize
  const handleResize = useCallback(() => {
    if (!container || !cameraRef.current || !rendererRef.current) return;

    const width = container.clientWidth;
    const height = container.clientHeight;

    cameraRef.current.aspect = width / height;
    cameraRef.current.updateProjectionMatrix();

    rendererRef.current.setSize(width, height);

    if (composerRef.current) {
      composerRef.current.setSize(width, height);
    }
  }, [container]);

  // Setup and cleanup
  useEffect(() => {
    if (!container) return;

    const components = init();
    if (!components) return;

    animate();

    window.addEventListener('resize', handleResize);

    return () => {
      if (animationIdRef.current) {
        cancelAnimationFrame(animationIdRef.current);
      }

      window.removeEventListener('resize', handleResize);

      // Cleanup Three.js
      if (controlsRef.current) {
        controlsRef.current.dispose();
      }

      if (sceneRef.current) {
        sceneRef.current.traverse((child) => {
          if (child instanceof THREE.Mesh) {
            child.geometry.dispose();
            if (Array.isArray(child.material)) {
              child.material.forEach(m => m.dispose());
            } else {
              child.material.dispose();
            }
          }
        });
        sceneRef.current.clear();
      }

      if (rendererRef.current) {
        rendererRef.current.dispose();
        if (container.contains(rendererRef.current.domElement)) {
          container.removeChild(rendererRef.current.domElement);
        }
      }

      if (composerRef.current) {
        composerRef.current.dispose();
      }
    };
  }, [container, init, animate, handleResize]);

  return {
    scene: sceneRef.current,
    camera: cameraRef.current,
    renderer: rendererRef.current,
    controls: controlsRef.current,
    composer: composerRef.current,
  };
};
