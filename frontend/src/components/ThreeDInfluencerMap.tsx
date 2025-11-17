import { useEffect, useRef, useCallback, useMemo } from 'react';
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { graphNodes, relationships } from '../data/mockData';
import { Influencer } from '../types';
import './ThreeDInfluencerMap.css';

interface ThreeDInfluencerMapProps {
  onSelectInfluencer: (id: string) => void;
}

interface NodeMesh extends THREE.Mesh {
  nodeData: {
    id: string;
    type: string;
    name: string;
    userData: Influencer;
  velocity: THREE.Vector3;
    targetPosition: THREE.Vector3;
    connections: string[];
  };
}

interface LinkLine extends THREE.Line {
  linkData: {
    source: string;
    target: string;
    type: string;
  };
}

// Configuration following GUIDELINES.md design tokens
const CONFIG = {
  colors: {
    influencer: 0x8b5cf6,  // --primary-purple
    agency: 0xf59e0b,      // --primary-yellow
    brand: 0x3b82f6,       // --primary-blue
    event: 0x10b981,       // --primary-green
    background: 0xffffff,   // --bg-main (white for brutalist aesthetic)
    link: 0x000000,        // --black for contrast
    hover: 0xef4444,       // --primary-red for emphasis
    glow: 0x8b5cf6,        // Purple glow
  },
  physics: {
    repulsionStrength: 2500,
    attractionStrength: 0.0015,
    centeringStrength: 0.0008,
    damping: 0.94,
    idealDistance: 100,
    maxVelocity: 4,
  },
  visual: {
    nodeScale: 0.12,
    linkOpacity: 0.95,
    hoverScale: 1.4,
    animationSpeed: 0.008,
  },
  camera: {
    fov: 60,
    near: 0.1,
    far: 2000,
    initialDistance: 350,
  }
};

// Brutalist/Editorial vertex shader with geometric distortion
const nodeVertexShader = `
  uniform float uTime;
  uniform float uHover;
  uniform float uDistortion;
  
  varying vec3 vNormal;
  varying vec3 vPosition;
  varying vec2 vUv;
  varying vec3 vWorldPosition;
  
  void main() {
    vUv = uv;
    vNormal = normalize(normalMatrix * normal);
    vPosition = position;
    
    // Geometric distortion for brutalist aesthetic
    vec3 pos = position;
    float distortion = sin(position.x * 3.0 + uTime) * cos(position.y * 3.0 + uTime) * 0.02;
    pos += normal * distortion * uDistortion;
    
    // Hover expansion with angular distortion
    pos *= 1.0 + uHover * 0.15 * sin(position.z * 10.0 + uTime * 2.0);
    
    vec4 worldPosition = modelMatrix * vec4(pos, 1.0);
    vWorldPosition = worldPosition.xyz;
    
    gl_Position = projectionMatrix * viewMatrix * worldPosition;
  }
`;

// High contrast fragment shader with gradient mesh effect
const nodeFragmentShader = `
  uniform vec3 uColor;
  uniform float uTime;
  uniform float uHover;
  uniform float uGlitch;
  uniform vec3 uAccentColor;
  
  varying vec3 vNormal;
  varying vec3 vPosition;
  varying vec2 vUv;
  varying vec3 vWorldPosition;
  
  // Noise function for texture
  float noise(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
  }
  
  void main() {
    // Editorial gradient mesh
    vec3 gradient1 = mix(uColor, uAccentColor, vUv.y);
    vec3 gradient2 = mix(vec3(1.0), uColor, vUv.x);
    vec3 meshGradient = mix(gradient1, gradient2, 0.5);
    
    // High contrast lighting
    vec3 light = normalize(vec3(0.5, 0.5, 1.0));
    float diffuse = max(0.0, dot(vNormal, light));
    diffuse = smoothstep(0.3, 0.7, diffuse); // Hard edge for brutalist look
    
    // Fresnel with hard edge
    vec3 viewDirection = normalize(cameraPosition - vWorldPosition);
    float fresnel = 1.0 - max(0.0, dot(viewDirection, vNormal));
    fresnel = pow(fresnel, 1.5);
    fresnel = step(0.3, fresnel); // Binary fresnel for contrast
    
    // Color mixing with editorial palette
    vec3 color = meshGradient;
    color = mix(color, vec3(0.0), diffuse * 0.3); // Dark shadows
    color = mix(color, vec3(1.0), fresnel * 0.5); // White highlights
    
    // Hover state with color inversion
    float hoverEffect = uHover * step(0.5, noise(vUv * 10.0 + uTime));
    color = mix(color, 1.0 - color, hoverEffect * 0.3);
    
    // Glitch effect for digital aesthetic
    float glitch = step(0.98, noise(vUv * 100.0 + uTime * 10.0)) * uGlitch;
    color = mix(color, uAccentColor, glitch);
    
    // Animated scan line
    float scanLine = sin(vWorldPosition.y * 30.0 + uTime * 5.0) * 0.03;
    color += scanLine * uHover;
    
    gl_FragColor = vec4(color, 1.0);
  }
`;

// Grid particle shader for brutalist background
const gridVertexShader = `
  uniform float uTime;
  attribute float size;
  attribute vec3 customColor;
  
  varying vec3 vColor;
  varying float vAlpha;
  
  void main() {
    vColor = customColor;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    
    // Grid-aligned movement
    vec3 pos = position;
    pos.x += sin(uTime * 0.5 + position.y * 0.01) * 10.0;
    pos.y += cos(uTime * 0.3 + position.x * 0.01) * 10.0;
    pos.z += sin(uTime * 0.4) * 5.0;
    
    mvPosition = modelViewMatrix * vec4(pos, 1.0);
    
    // Distance-based alpha
    vAlpha = 1.0 - smoothstep(300.0, 800.0, length(mvPosition.xyz));
    
    gl_PointSize = size * (300.0 / -mvPosition.z) * vAlpha;
    gl_Position = projectionMatrix * mvPosition;
  }
`;

const gridFragmentShader = `
  uniform float uTime;
  varying vec3 vColor;
  varying float vAlpha;
  
  void main() {
    // Square particles for grid aesthetic
    vec2 center = gl_PointCoord - vec2(0.5);
    float dist = max(abs(center.x), abs(center.y));
    float alpha = 1.0 - smoothstep(0.4, 0.5, dist);
    
    // Monochrome with accent colors
    vec3 color = mix(vec3(0.0), vColor, 0.3);
    
    gl_FragColor = vec4(color, alpha * vAlpha * 0.5);
  }
`;

export const ThreeDInfluencerMap = ({ onSelectInfluencer }: ThreeDInfluencerMapProps) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const sceneRef = useRef<THREE.Scene | null>(null);
  const rendererRef = useRef<THREE.WebGLRenderer | null>(null);
  const cameraRef = useRef<THREE.PerspectiveCamera | null>(null);
  const controlsRef = useRef<OrbitControls | null>(null);
  const nodesRef = useRef<NodeMesh[]>([]);
  const linksRef = useRef<LinkLine[]>([]);
  const animationFrameRef = useRef<number>(0);
  const hoveredNodeRef = useRef<NodeMesh | null>(null);
  const raycasterRef = useRef<THREE.Raycaster>(new THREE.Raycaster());
  const mouseRef = useRef<THREE.Vector2>(new THREE.Vector2());
  const timeRef = useRef<number>(0);
  const gridRef = useRef<THREE.Points | null>(null);
  const nodeMaterialsRef = useRef<Map<string, THREE.ShaderMaterial>>(new Map());
  const nodeLabelsRef = useRef<HTMLDivElement[]>([]);
  
  // Memoize node connections
  const nodeConnections = useMemo(() => {
    const connections = new Map<string, Set<string>>();
    
    graphNodes.forEach(node => {
      connections.set(node.id, new Set());
    });
    
    relationships.forEach(rel => {
      const source = rel.source as string;
      const target = rel.target as string;
      
      connections.get(source)?.add(target);
      connections.get(target)?.add(source);
    });
    
    return connections;
  }, []);

  // Initialize Three.js scene with brutalist aesthetic
  const initScene = useCallback(() => {
    if (!containerRef.current) return;

    const container = containerRef.current;
    const width = container.clientWidth;
    const height = container.clientHeight;

    // Scene with white background (brutalist)
    const scene = new THREE.Scene();
    scene.background = new THREE.Color(CONFIG.colors.background);
    scene.fog = new THREE.Fog(CONFIG.colors.background, 600, 1500);
    sceneRef.current = scene;

    // Camera with editorial framing
    const camera = new THREE.PerspectiveCamera(
      CONFIG.camera.fov,
      width / height,
      CONFIG.camera.near,
      CONFIG.camera.far
    );
    camera.position.set(100, 150, CONFIG.camera.initialDistance);
    camera.lookAt(0, 0, 0);
    cameraRef.current = camera;

    // Renderer with high contrast settings
    const renderer = new THREE.WebGLRenderer({
      antialias: true,
      alpha: false,
      powerPreference: 'high-performance'
    });
    renderer.setSize(width, height);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    renderer.toneMapping = THREE.NoToneMapping; // Raw colors for brutalist look
    renderer.outputColorSpace = THREE.SRGBColorSpace;
    container.appendChild(renderer.domElement);
    rendererRef.current = renderer;

    // Controls with smooth damping
    const controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.03;
    controls.rotateSpeed = 0.4;
    controls.zoomSpeed = 0.6;
    controls.minDistance = 150;
    controls.maxDistance = 700;
    controls.enablePan = true;
    controls.autoRotate = true;
    controls.autoRotateSpeed = 0.2;
    controlsRef.current = controls;

    // High contrast lighting setup
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.3);
    scene.add(ambientLight);

    // Key light with harsh shadows
    const directionalLight1 = new THREE.DirectionalLight(0xffffff, 0.7);
    directionalLight1.position.set(200, 300, 100);
    directionalLight1.castShadow = true;
    directionalLight1.shadow.mapSize.width = 2048;
    directionalLight1.shadow.mapSize.height = 2048;
    scene.add(directionalLight1);

    // Colored rim light
    const directionalLight2 = new THREE.DirectionalLight(CONFIG.colors.influencer, 0.3);
    directionalLight2.position.set(-150, -100, -150);
    scene.add(directionalLight2);

    // Create grid background particles
    const gridCount = 500;
    const gridGeometry = new THREE.BufferGeometry();
    const gridPositions = new Float32Array(gridCount * 3);
    const gridColors = new Float32Array(gridCount * 3);
    const gridSizes = new Float32Array(gridCount);

    const gridSpacing = 50;

    for (let i = 0; i < gridCount; i++) {
      const i3 = i * 3;
      
      // Create grid pattern
      const gridX = (Math.floor(Math.random() * 20) - 10) * gridSpacing;
      const gridY = (Math.floor(Math.random() * 20) - 10) * gridSpacing;
      const gridZ = (Math.floor(Math.random() * 20) - 10) * gridSpacing;
      
      gridPositions[i3] = gridX + (Math.random() - 0.5) * 20;
      gridPositions[i3 + 1] = gridY + (Math.random() - 0.5) * 20;
      gridPositions[i3 + 2] = gridZ + (Math.random() - 0.5) * 20;

      // Monochrome with accent colors
      const colorChoice = Math.random();
      if (colorChoice < 0.7) {
        // Black/gray
        gridColors[i3] = 0;
        gridColors[i3 + 1] = 0;
        gridColors[i3 + 2] = 0;
      } else if (colorChoice < 0.85) {
        // Purple accent
        gridColors[i3] = 0.545;
        gridColors[i3 + 1] = 0.361;
        gridColors[i3 + 2] = 0.965;
      } else {
        // Blue accent
        gridColors[i3] = 0.231;
        gridColors[i3 + 1] = 0.510;
        gridColors[i3 + 2] = 0.965;
      }

      gridSizes[i] = Math.random() * 4 + 1;
    }

    gridGeometry.setAttribute('position', new THREE.BufferAttribute(gridPositions, 3));
    gridGeometry.setAttribute('customColor', new THREE.BufferAttribute(gridColors, 3));
    gridGeometry.setAttribute('size', new THREE.BufferAttribute(gridSizes, 1));

    const gridMaterial = new THREE.ShaderMaterial({
      uniforms: {
        uTime: { value: 0 }
      },
      vertexShader: gridVertexShader,
      fragmentShader: gridFragmentShader,
      transparent: true,
      depthWrite: false,
      blending: THREE.NormalBlending
    });

    const grid = new THREE.Points(gridGeometry, gridMaterial);
    scene.add(grid);
    gridRef.current = grid;

    // Add geometric grid lines for brutalist structure
    const gridHelper = new THREE.GridHelper(800, 20, 0x000000, 0xeeeeee);
    if ((gridHelper as any).material) {
      (gridHelper as any).material.opacity = 0.1;
      (gridHelper as any).material.transparent = true;
    }
    gridHelper.position.y = -150;
    scene.add(gridHelper);

    return { scene, camera, renderer, controls };
  }, []);

  // Create nodes and links with editorial aesthetic
  const createNodesAndLinks = useCallback(() => {
    if (!sceneRef.current) return;

    const scene = sceneRef.current;
    const nodes: NodeMesh[] = [];
    const nodeMap = new Map<string, NodeMesh>();

    // Create nodes with custom brutalist shader
    graphNodes.forEach((nodeData, index) => {
      // Use geometric shapes for different types
      let geometry: THREE.BufferGeometry;
      
      if (nodeData.type === 'influencer') {
        geometry = new THREE.IcosahedronGeometry(nodeData.size * CONFIG.visual.nodeScale, 0);
      } else if (nodeData.type === 'brand') {
        geometry = new THREE.BoxGeometry(
          nodeData.size * CONFIG.visual.nodeScale * 1.5,
          nodeData.size * CONFIG.visual.nodeScale * 1.5,
          nodeData.size * CONFIG.visual.nodeScale * 1.5
        );
      } else if (nodeData.type === 'agency') {
        geometry = new THREE.TetrahedronGeometry(nodeData.size * CONFIG.visual.nodeScale * 1.2, 0);
      } else {
        geometry = new THREE.OctahedronGeometry(nodeData.size * CONFIG.visual.nodeScale, 0);
      }

      // Get colors based on type
      const mainColor = new THREE.Color(
        CONFIG.colors[nodeData.type as keyof typeof CONFIG.colors] || CONFIG.colors.event
      );
      
      const accentColor = new THREE.Color(
        nodeData.type === 'influencer' ? CONFIG.colors.brand :
        nodeData.type === 'brand' ? CONFIG.colors.influencer :
        nodeData.type === 'agency' ? CONFIG.colors.hover :
        CONFIG.colors.event
      );

      // Create brutalist shader material
      const material = new THREE.ShaderMaterial({
        uniforms: {
          uColor: { value: mainColor },
          uAccentColor: { value: accentColor },
          uTime: { value: 0 },
          uHover: { value: 0 },
          uDistortion: { value: nodeData.type === 'influencer' ? 1.0 : 0.3 },
          uGlitch: { value: 0 }
        },
        vertexShader: nodeVertexShader,
        fragmentShader: nodeFragmentShader,
        wireframe: false
      });

      nodeMaterialsRef.current.set(nodeData.id, material);

      const mesh = new THREE.Mesh(geometry, material);

      // Position in structured grid with offset
      const angle = (index / graphNodes.length) * Math.PI * 2;
      const radius = 150 + Math.random() * 150;
      const height = (Math.random() - 0.5) * 200;
      
      mesh.position.set(
        Math.cos(angle) * radius,
        height,
        Math.sin(angle) * radius
      );

      // Add wireframe overlay for selected nodes
      if (nodeData.type === 'influencer') {
        const wireframeGeometry = geometry.clone();
        const wireframeMaterial = new THREE.MeshBasicMaterial({
          color: 0x000000,
          wireframe: true,
          transparent: true,
          opacity: 0.1
        });
        const wireframeMesh = new THREE.Mesh(wireframeGeometry, wireframeMaterial);
        wireframeMesh.scale.set(1.05, 1.05, 1.05);
        mesh.add(wireframeMesh);
      }

      (mesh as unknown as NodeMesh).nodeData = {
        id: nodeData.id,
        type: nodeData.type,
        name: nodeData.name,
        userData: nodeData as any,
        velocity: new THREE.Vector3(),
        targetPosition: mesh.position.clone(),
        connections: Array.from(nodeConnections.get(nodeData.id) || []),
      };

      mesh.castShadow = true;
      mesh.receiveShadow = true;

      scene.add(mesh);
      nodes.push(mesh as unknown as NodeMesh);
      nodeMap.set(nodeData.id, mesh as unknown as NodeMesh);
    });

    // Create links with brutalist line style
    const links: LinkLine[] = [];
    const linkGroup = new THREE.Group();

    relationships.forEach(rel => {
      const sourceNode = nodeMap.get(rel.source as string);
      const targetNode = nodeMap.get(rel.target as string);

      if (!sourceNode || !targetNode) return;

      // Create curved connection for visual interest
      const curve = new THREE.QuadraticBezierCurve3(
        sourceNode.position,
        new THREE.Vector3(
          (sourceNode.position.x + targetNode.position.x) / 2,
          (sourceNode.position.y + targetNode.position.y) / 2 + 50,
          (sourceNode.position.z + targetNode.position.z) / 2
        ),
        targetNode.position
      );

      const points = curve.getPoints(20);
      const geometry = new THREE.BufferGeometry().setFromPoints(points);
      
      // Colored lines with different dash patterns for types (following GUIDELINES.md: high contrast)
      const linkColors = {
        agency: 0xf59e0b,      // Orange
        collaboration: 0x10b981, // Green
        friendship: 0x8b5cf6,   // Purple
        brand: 0x3b82f6,        // Blue
      };
      const linkColor = linkColors[rel.type as keyof typeof linkColors] || 0x000000;
      
      const material = new THREE.LineDashedMaterial({
        color: linkColor,
        transparent: true,
        opacity: CONFIG.visual.linkOpacity,
        linewidth: 3,
        dashSize: rel.type === 'collaboration' ? 10 : 5,
        gapSize: rel.type === 'collaboration' ? 5 : 10
      });

      const line = new THREE.Line(geometry, material) as LinkLine;
      line.computeLineDistances();
      
      line.linkData = {
        source: rel.source as string,
        target: rel.target as string,
        type: rel.type,
      };

      linkGroup.add(line);
      links.push(line);
    });

    scene.add(linkGroup);

    nodesRef.current = nodes;
    linksRef.current = links;

    return { nodes, links, nodeMap };
  }, [nodeConnections]);

  // Physics simulation with structured movement
  const updatePhysics = useCallback((deltaTime: number) => {
    const nodes = nodesRef.current;
    const maxDelta = Math.min(deltaTime, 0.05);

    // Apply forces between node pairs
    for (let i = 0; i < nodes.length; i++) {
      for (let j = i + 1; j < nodes.length; j++) {
        const nodeA = nodes[i];
        const nodeB = nodes[j];
        
        const diff = new THREE.Vector3().subVectors(nodeB.position, nodeA.position);
        const distance = diff.length();
        
        if (distance > 0.1 && distance < 400) {
          // Repulsion force
          const repulsionForce = CONFIG.physics.repulsionStrength / (distance * distance);
          diff.normalize().multiplyScalar(repulsionForce * maxDelta);
          
          nodeA.nodeData.velocity.sub(diff);
          nodeB.nodeData.velocity.add(diff);
          
          // Stronger attraction for connected nodes (editorial clustering)
          if (nodeA.nodeData.connections.includes(nodeB.nodeData.id)) {
            const attractionForce = (distance - CONFIG.physics.idealDistance) * 
                                  CONFIG.physics.attractionStrength * 2;
            diff.normalize().multiplyScalar(attractionForce * maxDelta);
            
            nodeA.nodeData.velocity.add(diff);
            nodeB.nodeData.velocity.sub(diff);
          }
        }
      }
    }

    // Update positions with geometric constraints
    nodes.forEach((node) => {
      // Centering force
      const centerForce = node.position.clone()
        .multiplyScalar(-CONFIG.physics.centeringStrength * maxDelta);
      node.nodeData.velocity.add(centerForce);

      // Limit velocity
      const velocityMagnitude = node.nodeData.velocity.length();
      if (velocityMagnitude > CONFIG.physics.maxVelocity) {
        node.nodeData.velocity.normalize()
          .multiplyScalar(CONFIG.physics.maxVelocity);
      }

      // Apply velocity with damping
      node.position.add(
        node.nodeData.velocity.clone().multiplyScalar(maxDelta * 60)
      );
      node.nodeData.velocity.multiplyScalar(CONFIG.physics.damping);

      // Geometric rotation for visual interest
      if (node.nodeData.type === 'influencer') {
        node.rotation.x += 0.003;
        node.rotation.y += 0.005;
      } else if (node.nodeData.type === 'brand') {
        node.rotation.y += 0.002;
      }
    });

    // Update curved link positions
    linksRef.current.forEach(link => {
      const sourceNode = nodes.find(n => n.nodeData.id === link.linkData.source);
      const targetNode = nodes.find(n => n.nodeData.id === link.linkData.target);

      if (sourceNode && targetNode) {
        const curve = new THREE.QuadraticBezierCurve3(
          sourceNode.position,
          new THREE.Vector3(
            (sourceNode.position.x + targetNode.position.x) / 2,
            (sourceNode.position.y + targetNode.position.y) / 2 + 30,
            (sourceNode.position.z + targetNode.position.z) / 2
          ),
          targetNode.position
        );
        
        const points = curve.getPoints(20);
        const positions = link.geometry.attributes.position as THREE.BufferAttribute;
        
        for (let i = 0; i < points.length; i++) {
          positions.setXYZ(i, points[i].x, points[i].y, points[i].z);
        }
        positions.needsUpdate = true;
        link.computeLineDistances();
      }
    });
  }, []);

  // Handle mouse interactions
  const handleMouseMove = useCallback((event: MouseEvent) => {
    if (!containerRef.current || !cameraRef.current || !rendererRef.current) return;

    const rect = containerRef.current.getBoundingClientRect();
    mouseRef.current.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
    mouseRef.current.y = -((event.clientY - rect.top) / rect.height) * 2 + 1;

    // Raycast for hover
    raycasterRef.current.setFromCamera(mouseRef.current, cameraRef.current);
    const intersects = raycasterRef.current.intersectObjects(nodesRef.current, false);

    const previousHovered = hoveredNodeRef.current;
    
    if (intersects.length > 0) {
      const hoveredMesh = intersects[0].object as NodeMesh;
      
      if (hoveredMesh && hoveredMesh.nodeData) {
        hoveredNodeRef.current = hoveredMesh;
        
        // Update cursor
        rendererRef.current.domElement.style.cursor = 'pointer';

        // Update hover uniforms with glitch effect
        if (hoveredMesh !== previousHovered) {
          // Reset previous hover
          if (previousHovered && previousHovered.nodeData) {
            const prevMaterial = nodeMaterialsRef.current.get(previousHovered.nodeData.id);
            if (prevMaterial) {
              prevMaterial.uniforms.uHover.value = 0;
              prevMaterial.uniforms.uGlitch.value = 0;
            }
          }
          
          // Set new hover with glitch
          const material = nodeMaterialsRef.current.get(hoveredMesh.nodeData.id);
          if (material) {
            material.uniforms.uHover.value = 1;
            material.uniforms.uGlitch.value = 0.5;
            
            // Animate glitch off
            setTimeout(() => {
              if (material) material.uniforms.uGlitch.value = 0;
            }, 100);
          }
        }
      }
    } else {
      // No hover - clear everything
      if (previousHovered && previousHovered.nodeData) {
        const material = nodeMaterialsRef.current.get(previousHovered.nodeData.id);
        if (material) {
          material.uniforms.uHover.value = 0;
          material.uniforms.uGlitch.value = 0;
        }
      }
      
      hoveredNodeRef.current = null;
      rendererRef.current.domElement.style.cursor = 'grab';
    }
  }, []);

  // Handle click
  const handleClick = useCallback(() => {
    if (hoveredNodeRef.current && hoveredNodeRef.current.nodeData.type === 'influencer') {
      // Stop auto rotation on selection
      if (controlsRef.current) {
        controlsRef.current.autoRotate = false;
      }
      
      // Trigger glitch effect on click
      const material = nodeMaterialsRef.current.get(hoveredNodeRef.current.nodeData.id);
      if (material) {
        material.uniforms.uGlitch.value = 1;
        setTimeout(() => {
          if (material) material.uniforms.uGlitch.value = 0;
        }, 200);
      }
      
      onSelectInfluencer(hoveredNodeRef.current.nodeData.id);
    }
  }, [onSelectInfluencer]);

  // Animation loop
  const animate = useCallback(() => {
    if (!sceneRef.current || !cameraRef.current || !rendererRef.current || !controlsRef.current) {
      return;
    }

    const currentTime = Date.now() * 0.001;
    const deltaTime = currentTime - timeRef.current;
    timeRef.current = currentTime;

    // Update shader uniforms
    nodeMaterialsRef.current.forEach((material) => {
      material.uniforms.uTime.value = currentTime;
    });

    // Update grid shader
    if (gridRef.current && gridRef.current.material instanceof THREE.ShaderMaterial) {
      gridRef.current.material.uniforms.uTime.value = currentTime;
      gridRef.current.rotation.y += 0.0002;
    }

    // Update physics
    updatePhysics(deltaTime);

    // Update all node labels to follow their nodes - only show on hover
    if (containerRef.current && rendererRef.current && cameraRef.current) {
      const canvas = rendererRef.current.domElement;
      const widthHalf = canvas.width / 2;
      const heightHalf = canvas.height / 2;
      const camera = cameraRef.current;
      
      nodesRef.current.forEach((node, index) => {
        const label = nodeLabelsRef.current[index];
        if (label && node) {
          // Convert 3D position to 2D screen position
          const vector = new THREE.Vector3();
          node.getWorldPosition(vector);
          vector.project(camera);
          
          const x = (vector.x * widthHalf) + widthHalf;
          const y = -(vector.y * heightHalf) + heightHalf;
          
          // Position label above the node
          label.style.left = `${x}px`;
          label.style.top = `${y - 40}px`;
          
          // Check if this node is being hovered
          const isHovered = hoveredNodeRef.current === node;
          
          // Show ONLY if being hovered
          if (isHovered) {
            label.style.opacity = '1';
            label.style.background = 'rgba(139, 92, 246, 0.95)';
            label.style.borderColor = '#ffffff';
            label.style.transform = 'translateX(-50%) scale(1.1)';
          } else {
            label.style.opacity = '0';
          }
        }
      });
    }

    // Update controls
    controlsRef.current.update();

    // Render
    rendererRef.current.render(sceneRef.current, cameraRef.current);

    animationFrameRef.current = requestAnimationFrame(animate);
  }, [updatePhysics]);

  // Handle resize
  const handleResize = useCallback(() => {
    if (!containerRef.current || !cameraRef.current || !rendererRef.current) return;

    const width = containerRef.current.clientWidth;
    const height = containerRef.current.clientHeight;

    cameraRef.current.aspect = width / height;
    cameraRef.current.updateProjectionMatrix();

    rendererRef.current.setSize(width, height);
  }, []);

  // Create labels for all nodes
  const createNodeLabels = useCallback(() => {
    if (!containerRef.current) return;
    
    // Clear existing labels
    nodeLabelsRef.current.forEach(label => {
      if (containerRef.current?.contains(label)) {
        containerRef.current.removeChild(label);
      }
    });
    nodeLabelsRef.current = [];
    
    // Create a label for each node
    graphNodes.forEach((nodeData) => {
      const label = document.createElement('div');
      label.className = 'node-label-3d';
      label.textContent = nodeData.name;
      
      // Style the label
      label.style.position = 'absolute';
      label.style.background = 'rgba(0, 0, 0, 0.85)';
      label.style.color = '#ffffff';
      label.style.padding = '4px 10px';
      label.style.borderRadius = '3px';
      label.style.fontSize = '12px';
      label.style.fontFamily = 'var(--font-sans)';
      label.style.fontWeight = '600';
      label.style.pointerEvents = 'none';
      label.style.userSelect = 'none';
      label.style.whiteSpace = 'nowrap';
      label.style.transform = 'translateX(-50%)';
      label.style.zIndex = '1000';
      label.style.border = '1px solid rgba(139, 92, 246, 0.5)';
      label.style.boxShadow = '0 2px 8px rgba(0, 0, 0, 0.3)';
      label.style.transition = 'opacity 0.2s ease, background 0.2s ease, transform 0.2s ease, border-color 0.2s ease';
      label.style.opacity = '0';

      if (containerRef.current) {
        containerRef.current.appendChild(label);
      }
      nodeLabelsRef.current.push(label);
    });
  }, []);
  
  // Initialize labels
  useEffect(() => {
    createNodeLabels();
    
    return () => {
      // Cleanup labels
      nodeLabelsRef.current.forEach(label => {
        if (containerRef.current?.contains(label)) {
          containerRef.current.removeChild(label);
        }
      });
      nodeLabelsRef.current = [];
    };
  }, [createNodeLabels]);

  // Initialize scene
  useEffect(() => {
    const components = initScene();
    if (!components) return;

    createNodesAndLinks();

    // Start animation
    timeRef.current = Date.now() * 0.001;
    animate();

    // Add event listeners
    const container = containerRef.current;
    if (container && rendererRef.current) {
      rendererRef.current.domElement.addEventListener('mousemove', handleMouseMove);
      rendererRef.current.domElement.addEventListener('click', handleClick);
      window.addEventListener('resize', handleResize);
    }

    // Cleanup
    return () => {
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current);
      }

      if (rendererRef.current) {
        rendererRef.current.domElement.removeEventListener('mousemove', handleMouseMove);
        rendererRef.current.domElement.removeEventListener('click', handleClick);
      }
      window.removeEventListener('resize', handleResize);

      // Dispose Three.js resources
      if (controlsRef.current) {
        controlsRef.current.dispose();
      }

      // Dispose shader materials
      nodeMaterialsRef.current.forEach((material) => {
        material.dispose();
      });
      nodeMaterialsRef.current.clear();

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
        if (container && rendererRef.current.domElement.parentNode === container) {
          container.removeChild(rendererRef.current.domElement);
        }
      }
    };
  }, [initScene, createNodesAndLinks, animate, handleMouseMove, handleClick, handleResize]);

  return (
    <div 
      ref={containerRef}
      className="three-d-container"
      style={{ 
        width: '100%', 
        height: '100%', 
        position: 'relative',
        cursor: 'grab',
        background: 'var(--bg-main)'
      }}
    >
      <div className="three-d-overlay-brutalist">
        <div className="overlay-header">
          <span className="overlay-label">NETWORK</span>
          <span className="overlay-version">V.3.0</span>
        </div>
        <h3 className="overlay-title">Relational Mapping</h3>
        <p className="overlay-description">
          Three-dimensional visualization of relationships between entities.
          Intuitive spatial navigation.
        </p>
        <div className="overlay-controls">
          <div className="control-item">
            <span className="control-key">[DRAG]</span>
            <span className="control-action">ROTATE</span>
          </div>
          <div className="control-item">
            <span className="control-key">[SCROLL]</span>
            <span className="control-action">ZOOM</span>
          </div>
          <div className="control-item">
            <span className="control-key">[CLICK]</span>
            <span className="control-action">SELECT</span>
          </div>
        </div>
      </div>

      <div className="three-d-legend-brutalist">
        <div className="legend-grid">
          <div className="legend-item">
            <div className="legend-shape legend-influencer"></div>
            <span className="legend-label">INFLUENCER</span>
          </div>
          <div className="legend-item">
            <div className="legend-shape legend-agency"></div>
            <span className="legend-label">AGENCY</span>
          </div>
          <div className="legend-item">
            <div className="legend-shape legend-brand"></div>
            <span className="legend-label">BRAND</span>
          </div>
          <div className="legend-item">
            <div className="legend-shape legend-event"></div>
            <span className="legend-label">EVENT</span>
          </div>
        </div>
      </div>
    </div>
  );
};
