import chroma from "chroma-js";
import { Drawable } from "../";
import vertexShader from "./vertex.glsl?raw";
import fragmentShader from "./fragment.glsl?raw";
import { ClusterInfo } from "src/redux/slices/session";
import { ClusteringResult } from "src/api/services/TrajectoryAnalysis";
import REGL from "regl";

export class ScatterDrawable extends Drawable {
  protected offsetBuffer: REGL.Buffer | null = null;
  protected colorBuffer: REGL.Buffer | null = null;

  public onChangeAxis(axes: string[], filteredTrialIds: string[]) {
    const trajectoryAnalysis = Drawable.trajectoryAnalysis;
    if (trajectoryAnalysis == null) {
      return;
    }
    const filtered = new Set<string>(filteredTrialIds);
    const offsets: [number, number][] = [];
    if (axes[0].includes("PC")) {
      const index0 = Number(axes[0].split("PC")[1]);
      const index1 = Number(axes[1].split("PC")[1]);
      for (const [trialId, scores] of Object.entries(
        trajectoryAnalysis.clustering.gradients.clustering.projections,
      )) {
        if (filtered.size > 0 && !filtered.has(trialId)) {
          continue;
        }
        offsets.push([scores[index0], scores[index1]]);
      }
    } else if (axes[0].includes("UMAP")) {
      let projections =
        trajectoryAnalysis.clustering.gradients.umapProjections[0].data;
      for (const [trialId, projection] of Object.entries(projections)) {
        if (filtered.size > 0 && !filtered.has(trialId)) {
          continue;
        }
        offsets.push([projection[0], projection[1]]);
      }
    }
    if (filtered.size > 0) {
      for (const [trialId, _scores] of Object.entries(
        trajectoryAnalysis.clustering.gradients.clustering.projections,
      )) {
        if (filtered.has(trialId)) {
          continue;
        }
        offsets.push([100000, 100000]);
      }
    }
    this.offsetBuffer?.subdata(offsets);
  }

  public onChangeClustering(
    clusteringResult: ClusteringResult,
    clusterInfo: ClusterInfo,
    filteredTrialIds: string[],
  ) {
    const trajectoryAnalysis = Drawable.trajectoryAnalysis;
    if (trajectoryAnalysis == null) {
      return;
    }
    const filtered = new Set<string>(filteredTrialIds);
    const colors: [number, number, number][] = [];
    for (const [trialId, _scores] of Object.entries(
      trajectoryAnalysis.clustering.gradients.clustering.projections,
    )) {
      if (filtered.size > 0 && !filtered.has(trialId)) {
        continue;
      }
      const clusterLabel = clusteringResult.data[trialId].label;
      const color = clusterInfo[clusterLabel].color;
      colors.push(
        chroma(color)
          .rgb()
          .map((v) => v / 255) as [number, number, number],
      );
    }
    this.colorBuffer?.subdata(colors);
  }

  public constructor() {
    super();

    const regl = Drawable.regl;
    const trajectoryAnalysis = Drawable.trajectoryAnalysis;
    if (
      regl == null ||
      trajectoryAnalysis == null ||
      Drawable.camera == null ||
      Drawable.canvas == null
    ) {
      return;
    }

    const offsets: [number, number][] = [];
    const colors: [number, number, number][] = [];
    for (const [_trialId, scores] of Object.entries(
      trajectoryAnalysis.clustering.gradients.clustering.projections,
    )) {
      colors.push(
        chroma("black")
          .rgb()
          .map((v) => v / 255) as [number, number, number],
      );
      offsets.push([scores[0], scores[1]]);
    }
    this.offsetBuffer = regl.buffer({
      data: offsets,
      type: "float",
      usage: "dynamic",
    });
    this.colorBuffer = regl.buffer({
      data: colors,
      type: "float",
      usage: "dynamic",
    });

    const RADIUS = 3;
    const NUM_SEGMENTS = 30;
    const circleVertices = [[0, 0]];
    for (let i = 0; i <= NUM_SEGMENTS; i++) {
      const theta = (i / NUM_SEGMENTS) * 2 * Math.PI; // Angle in radians
      circleVertices.push([RADIUS * Math.cos(theta), RADIUS * Math.sin(theta)]); // Unit circle coordinates
    }

    this.drawCommand = regl({
      vert: vertexShader,
      frag: fragmentShader,
      attributes: {
        a_Position: circleVertices,
        a_Offset: {
          buffer: this.offsetBuffer,
          divisor: 1,
        },
        a_Color: {
          buffer: this.colorBuffer,
          divisor: 1,
        },
      },
      uniforms: {
        u_ViewProjection: Drawable.uploadViewProjectionUniform,
        u_CameraScale: () => Drawable.camera?.scale ?? 1.0,
      },
      depth: {
        enable: false,
      },
      count: NUM_SEGMENTS + 2,
      primitive: "triangle fan",
      instances: Object.keys(trajectoryAnalysis.clustering.scores).length,
    });
  }
}
