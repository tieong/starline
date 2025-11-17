declare module 'three' {
  export class Object3D {
    position: Vector3;
    rotation: Euler;
    scale: Vector3;
    userData: Record<string, any>;
    add(...objects: Object3D[]): void;
    remove(...objects: Object3D[]): void;
    lookAt(x: number, y: number, z: number): void;
    lookAt(vector: Vector3): void;
    clone(): Object3D;
    getWorldPosition(target: Vector3): Vector3;
    castShadow: boolean;
    receiveShadow: boolean;
    traverse(callback: (object: Object3D) => void): void;
  }

  export class Scene extends Object3D {
    background: Color | null;
    fog: Fog | null;
    clear(): void;
  }

  export class Camera extends Object3D {}

  export class PerspectiveCamera extends Camera {
    constructor(fov: number, aspect: number, near: number, far: number);
    aspect: number;
    updateProjectionMatrix(): void;
  }

  export class Vector3 {
    constructor(x?: number, y?: number, z?: number);
    x: number;
    y: number;
    z: number;
    set(x: number, y: number, z: number): this;
    setLength(length: number): this;
    copy(vec: Vector3): this;
    clone(): Vector3;
    add(v: Vector3): this;
    sub(v: Vector3): this;
    multiplyScalar(scalar: number): this;
    subVectors(a: Vector3, b: Vector3): this;
    normalize(): this;
    length(): number;
    project(camera: Camera): this;
  }

  export class Vector2 {
    constructor(x?: number, y?: number);
    x: number;
    y: number;
    set(x: number, y: number): this;
  }

  export class Euler {
    x: number;
    y: number;
    z: number;
  }

  export class Color {
    constructor(color: number | string);
  }

  export class Fog {
    constructor(color: number, near?: number, far?: number);
  }

  export class BufferGeometry {
    setFromPoints(points: Vector3[]): BufferGeometry;
    setAttribute(name: string, attribute: BufferAttribute): void;
    getAttribute(name: string): BufferAttribute;
    attributes: {
      [name: string]: BufferAttribute;
      position?: BufferAttribute;
    };
    clone(): BufferGeometry;
    dispose(): void;
  }

  export class SphereGeometry extends BufferGeometry {
    constructor(radius?: number, widthSegments?: number, heightSegments?: number);
  }

  export class IcosahedronGeometry extends BufferGeometry {
    constructor(radius?: number, detail?: number);
  }

  export class BoxGeometry extends BufferGeometry {
    constructor(width?: number, height?: number, depth?: number);
  }

  export class TetrahedronGeometry extends BufferGeometry {
    constructor(radius?: number, detail?: number);
  }

  export class OctahedronGeometry extends BufferGeometry {
    constructor(radius?: number, detail?: number);
  }

  export class GridHelper extends Object3D {
    constructor(size?: number, divisions?: number, colorCenterLine?: number, colorGrid?: number);
  }

  export class Material {
    dispose(): void;
  }

  export class MeshStandardMaterial extends Material {
    constructor(parameters?: Record<string, any>);
  }

  export class MeshBasicMaterial extends Material {
    constructor(parameters?: Record<string, any>);
  }

  export class LineBasicMaterial extends Material {
    constructor(parameters?: Record<string, any>);
  }

  export class LineDashedMaterial extends Material {
    constructor(parameters?: Record<string, any>);
  }

  export class PointsMaterial extends Material {
    constructor(parameters?: Record<string, any>);
  }

  export class ShaderMaterial extends Material {
    constructor(parameters?: Record<string, any>);
    uniforms: Record<string, { value: any }>;
  }

  export const FrontSide: number;
  export const BackSide: number;
  export const DoubleSide: number;

  export class Mesh<TGeometry extends BufferGeometry = BufferGeometry, TMaterial extends Material = Material> extends Object3D {
    constructor(geometry?: TGeometry, material?: TMaterial);
    geometry: TGeometry;
    material: TMaterial;
  }

  export class Line<TGeometry extends BufferGeometry = BufferGeometry, TMaterial extends Material = Material> extends Object3D {
    constructor(geometry?: TGeometry, material?: TMaterial);
    geometry: TGeometry;
    material: TMaterial;
    computeLineDistances(): this;
  }

  export class LineSegments<TGeometry extends BufferGeometry = BufferGeometry, TMaterial extends Material = Material> extends Line<TGeometry, TMaterial> {}

  export class Group extends Object3D {}

  export class AmbientLight extends Object3D {
    constructor(color: number | string, intensity?: number);
  }

  export class DirectionalLight extends Object3D {
    constructor(color: number | string, intensity?: number);
    castShadow: boolean;
    shadow: {
      mapSize: {
        width: number;
        height: number;
      };
    };
  }

  export class HemisphereLight extends Object3D {
    constructor(skyColor: number | string, groundColor: number | string, intensity?: number);
  }

  export const PCFSoftShadowMap: number;
  export const NoToneMapping: number;
  export const ACESFilmicToneMapping: number;
  export const SRGBColorSpace: number;

  export class WebGLRenderer {
    constructor(parameters?: Record<string, any>);
    domElement: HTMLCanvasElement;
    setSize(width: number, height: number): void;
    setPixelRatio(value: number): void;
    setClearColor(color: string | number, alpha?: number): void;
    render(scene: Scene, camera: Camera): void;
    dispose(): void;
    shadowMap: {
      enabled: boolean;
      type: number;
    };
    toneMapping: number;
    toneMappingExposure: number;
    outputColorSpace: number;
  }

  export interface Intersection {
    object: Object3D;
  }

  export class Raycaster {
    setFromCamera(coords: Vector2, camera: Camera): void;
    intersectObjects(objects: Object3D[], recursive?: boolean): Intersection[];
  }

  export class BufferAttribute {
    constructor(array: Float32Array | number[], itemSize: number);
    array: Float32Array | number[];
    count: number;
    needsUpdate: boolean;
    setXYZ(index: number, x: number, y: number, z: number): this;
  }

  export class WireframeGeometry extends BufferGeometry {
    constructor(geometry: BufferGeometry);
  }

  export class Points<TGeometry extends BufferGeometry = BufferGeometry, TMaterial extends Material = PointsMaterial> extends Object3D {
    constructor(geometry?: TGeometry, material?: TMaterial);
    geometry: TGeometry;
    material: TMaterial;
  }

  export const AdditiveBlending: number;
  export const NormalBlending: number;

  export class QuadraticBezierCurve3 {
    constructor(v0: Vector3, v1: Vector3, v2: Vector3);
    getPoints(divisions: number): Vector3[];
  }
}

declare module 'three/examples/jsm/controls/OrbitControls.js' {
  import { Camera } from 'three';

  export class OrbitControls {
    constructor(object: Camera, domElement?: HTMLElement);
    enableDamping: boolean;
    dampingFactor: number;
    rotateSpeed: number;
    zoomSpeed: number;
    minDistance: number;
    maxDistance: number;
    enablePan: boolean;
    autoRotate: boolean;
    autoRotateSpeed: number;
    update(): void;
    dispose(): void;
  }
}
