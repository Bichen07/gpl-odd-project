import REGL, { DrawCommand } from "regl";
import { Camera2D } from "./Camera";
import { Matrix4, Vector2 } from "math.gl";
import { TrajectoryAnalysisResponse } from "src/api/services/TrajectoryAnalysis";

export class Drawable {
  // STATIC
  // =============================================================
  // static members
  public static camera: Camera2D | undefined;
  public static canvas: HTMLCanvasElement | undefined;

  protected static regl: REGL.Regl | undefined;
  protected static trajectoryAnalysis: TrajectoryAnalysisResponse | undefined;

  protected static mousePosition: Vector2 = new Vector2();
  protected static uploadViewProjectionUniform = () => {
    if (this.camera == null) {
      return Matrix4.IDENTITY.toArray();
    }
    return this.camera.viewProjectionMatrix.toArray();
  };
  private static onViewUpdate: (camera: Camera2D) => void;

  // static functions
  public static init(
    regl: REGL.Regl,
    canvas: HTMLCanvasElement,
    camera: Camera2D,
    trajectoryAnalysis: TrajectoryAnalysisResponse,
    onViewUpdate: (camera: Camera2D) => void,
  ) {
    this.regl = regl;
    this.canvas = canvas;
    this.camera = camera;
    this.trajectoryAnalysis = trajectoryAnalysis;
    this.onViewUpdate = onViewUpdate;

    this.canvas.addEventListener("mousemove", (event) => {
      this.mousePosition.set(event.offsetX, event.offsetY);
    });

    this.canvas.addEventListener("mousedown", (mouseDownEvent: MouseEvent) => {
      if (
        this.canvas == null ||
        this.camera == null ||
        mouseDownEvent.button !== 1
      ) {
        return;
      }
      const startX = mouseDownEvent.clientX;
      const startY = mouseDownEvent.clientY;
      const initialPosition = this.camera.position.clone();
      const handleMouseMove = (mouseMoveEvent: MouseEvent) => {
        if (this.camera == null) {
          return;
        }
        const dx = mouseMoveEvent.clientX - startX;
        const dy = mouseMoveEvent.clientY - startY;
        this.camera.position = new Vector2(
          initialPosition.x - dx / this.camera.scale,
          initialPosition.y + dy / this.camera.scale,
        );
        onViewUpdate(this.camera);
      };
      const handleMouseUp = () => {
        if (this.canvas == null) {
          return;
        }
        this.canvas.removeEventListener("mousemove", handleMouseMove);
        this.canvas.removeEventListener("mouseup", handleMouseUp);
      };

      this.canvas.addEventListener("mousemove", handleMouseMove);
      this.canvas.addEventListener("mouseup", handleMouseUp);
    });

    this.canvas.addEventListener("wheel", (event: WheelEvent) => {
      if (this.camera == null) {
        return;
      }
      const deltaScale = event.deltaY > 0 ? 0.975 : 1.025; // Zoom out or in
      this.camera.zoom(deltaScale);
      onViewUpdate(this.camera);
    });
  }
  public static resize(width: number, height: number) {
    if (this.camera == null || this.canvas == null) {
      return;
    }
    this.canvas.width = width;
    this.canvas.height = height;
    this.camera.setSize(width, height);
    this.onViewUpdate(this.camera);
  }
  // =============================================================

  // INSTANCED
  // =============================================================
  // instanced members
  protected drawCommand: DrawCommand | undefined;
  public onAttributeSortingAndFiltering: (filteredAttributes: string[]) => void;

  // instanced functions
  public constructor() {
    this.onAttributeSortingAndFiltering = () => {};
    this.config();
  }
  public update(deltaSeconds: number) {
    this.onUpdate(deltaSeconds);
    if (this.drawCommand == null) {
      return;
    }
    this.drawCommand();
  }
  protected config() {}
  protected onUpdate(deltaSeconds: number) {}
  // =============================================================
}
