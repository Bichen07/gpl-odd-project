import { Matrix4, Vector3, toRadians, Vector2, Vector4 } from "math.gl";

export class Camera2D {
  public constructor(
    x: number = 0,
    y: number = 0,
    width: number = 0,
    height: number = 0,
    scale: number = 1.0,
  ) {
    this._projectionMatrix = new Matrix4();
    this._viewMatrix = new Matrix4();
    this._viewProjectionMatrix = new Matrix4();
    this._position = new Vector2(x, y);
    this._width = width;
    this._height = height;
    this._scale = scale;
    this.recalculateViewMatrix();
    this.recalculateProjectionMatrix();
  }

  public move(offsetX: number, offsetY: number) {
    this._position.x += offsetX;
    this._position.y += offsetY;
    this.recalculateViewMatrix();
  }

  public zoom(deltaScale: number) {
    this._scale *= deltaScale;
    this._scale = Math.max(this._scale, 0.001);
    this._scale = Math.min(this._scale, 1000);
    this.recalculateViewMatrix();
  }

  // Function to convert mouse screen position to world coordinates
  public screenToWorld(mouseX: number, mouseY: number) {
    // Normalize mouse position to [-1, 1]
    const normalizedX = (mouseX / this._width) * 2 - 1;
    const normalizedY = 1 - (mouseY / this._height) * 2;

    // Create a Vector4 for the clip space position (x, y, z, w = 1)
    const clipPos = new Vector3(normalizedX, normalizedY, 0);
    const clipPos4 = new Vector4(clipPos.x, clipPos.y, 0, 1);

    // Apply the inverse of the projection and view matrices to transform to world coordinates
    const inverseProjection = this._projectionMatrix.clone().invert();
    const inverseView = this._viewMatrix.clone().invert();

    // Transform clip space position to world coordinates
    const worldPos4 = clipPos4
      .clone()
      .transform(inverseProjection)
      .transform(inverseView);

    // Convert back to a Vector3 by dividing by w
    return new Vector2(worldPos4.x / worldPos4.w, worldPos4.y / worldPos4.w);
  }

  public get viewMatrix(): Matrix4 {
    return this._viewMatrix.clone();
  }

  public get projectionMatrix(): Matrix4 {
    return this._projectionMatrix.clone();
  }

  public get viewProjectionMatrix(): Matrix4 {
    return this._viewProjectionMatrix.clone();
  }

  public get position(): Vector2 {
    return this._position.clone();
  }

  public set position(updated: Vector2) {
    this._position.set(updated.x, updated.y);
    this.recalculateViewMatrix();
  }

  public get width(): number {
    return this._width;
  }

  public set width(width: number) {
    this._width = width;
    this.recalculateViewMatrix();
    this.recalculateProjectionMatrix();
  }

  public get height(): number {
    return this._height;
  }

  public set height(height: number) {
    this._height = height;
    this.recalculateViewMatrix();
    this.recalculateProjectionMatrix();
  }

  public setSize(width: number, height: number) {
    this._width = width;
    this._height = height;
    this.recalculateViewMatrix();
    this.recalculateProjectionMatrix();
  }

  public get scale(): number {
    return this._scale;
  }

  public set scale(scale: number) {
    this._scale = scale;
  }

  private recalculateViewMatrix(): void {
    this._viewMatrix.identity();
    this._viewMatrix.scale(this._scale);
    this._viewMatrix.translate([-this._position.x, -this._position.y, 1.0]);
    this._viewProjectionMatrix.identity();
    this._viewProjectionMatrix.multiplyRight(this._projectionMatrix);
    this._viewProjectionMatrix.multiplyRight(this._viewMatrix);
  }

  private recalculateProjectionMatrix(): void {
    const x = this._position.x;
    const y = this._position.y;
    const left = x - this._width / 2.0;
    const right = x + this._width / 2.0;
    const bottom = y - this._height / 2.0;
    const top = y + this._height / 2.0;
    const near = -1000.0;
    const far = 1000.0;
    this._projectionMatrix = new Matrix4().ortho({
      left,
      right,
      bottom,
      top,
      near,
      far,
    });
    this._viewProjectionMatrix.identity();
    this._viewProjectionMatrix.multiplyRight(this._projectionMatrix);
    this._viewProjectionMatrix.multiplyRight(this._viewMatrix);
  }

  private _viewMatrix: Matrix4;
  private _projectionMatrix: Matrix4;
  private _viewProjectionMatrix: Matrix4;
  private _position: Vector2;
  private _width: number;
  private _height: number;
  private _scale: number;
}
