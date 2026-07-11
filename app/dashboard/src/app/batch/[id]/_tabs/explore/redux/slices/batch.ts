import chroma from "chroma-js";
import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import {
  ClusteringResult,
  TrajectoryAnalysisResponse,
} from "@/app/_shared/graphql/queries/clustering";
import { noiseColor } from "@/app/_shared/utils";
import { kdTree } from "kd-tree-javascript";
import { Trial } from "@/app/_shared/graphql/queries/trials";
import { Batch } from "@/app/_shared/graphql/queries/batches";
import { O } from "ts-toolbelt";

export const viewerModes = ["pass/fail", "interaction-cluster"] as const;
export type ViewerMode = (typeof viewerModes)[number];

export const colorModes = [...viewerModes, "criticality"] as const;
export type ColorMode = (typeof colorModes)[number];

export type ClusterInfo = {
  [clusterLabel: string]: {
    count: number;
    color: string;
  };
};

export type CriticalityMetric = {
  threshold: number;
  kpi: {
    id: number;
    name: string;
    rule: "greaterThan" | "lessThan";
    unit: string;
  };
  min?: number;
  max?: number;
  gradMin?: number;
  gradMax?: number;
};

export type Bound = {
  [attribute: string]: {
    range: [number, number];
    colorscale: chroma.Scale;
    domain: number[];
    colorStops: { stop: number; color: string }[];
    alphaStops: { stop: number; alpha: number }[];
  };
} | null;

export function generateColors(numColors: number) {
  const colors = [
    chroma.brewer.Set2[2],
    chroma.brewer.Set2[0],
    chroma.brewer.Set2[3],
    chroma.brewer.Set2[4],
    // chroma.brewer.Set2[6],
    // chroma.brewer.Accent[0],
    chroma.brewer.Accent[4],
    chroma.brewer.Set1[3],
    // chroma.brewer.Set3[9],
    chroma.brewer.Set3[7],
    chroma.brewer.Set3[10],
    chroma.brewer.Accent[1],
    chroma.brewer.Accent[4],
    chroma.brewer.Set1[3],
    chroma.brewer.Set3[4],
    chroma.brewer.Dark2[0],
  ];
  // const colors = [...chroma.brewer.Dark2];
  // const colors = [
  //   chroma.brewer.Dark2[0],
  //   chroma.brewer.Dark2[2],
  //   chroma.brewer.Dark2[4],
  //   ...chroma.brewer.Set2,
  // ];

  // const colors = [
  //   chroma("darkturquoise").darken(0.4).hex(),
  //   chroma.brewer.Set1[1],
  //   chroma.brewer.Dark2[0],
  //   // chroma.brewer.Set2[3],
  //   // chroma("darkviolet").brighten(0.3).desaturate(0.3).hex(),
  //   // chroma(chroma.brewer.Set2[3]).desaturate(0.2).darken(0.4).hex(),
  //   // chroma(chroma.brewer.Set2[3]).desaturate(0.2).darken(0.4).hex(),
  //   // chroma.brewer.Accent[5],
  //   chroma(chroma.brewer.Dark2[2]).brighten(0.2).hex(),
  //   chroma.brewer.Dark2[3],
  //   ...chroma.brewer.Set2,
  // ];
  // const colors = [
  //   chroma("darkturquoise").darken(0.4).hex(),
  //   chroma.brewer.Set2[0],
  //   chroma.brewer.Set2[2],
  //   chroma.brewer.Set2[3],
  //   chroma.brewer.Set2[4],
  // ];
  // colors.splice(1, 1);
  // const colors = [...chroma.brewer.Set1];
  // colors.splice(0, 1);
  if (numColors > colors.length) {
    return chroma.scale(colors).mode("lab").colors(numColors);
  }
  return colors;
}

export interface ClusterInterpretationSummary {
  cluster_label?: string;
  ego_perspective_summary?: unknown;
}

export type ClusterHighlightRole = "medoid" | "boundary" | "outlier";

export interface ClusterBoundaryPair {
  cluster_a: number | string;
  trial_a: string;
  cluster_b: number | string;
  trial_b: string;
  embedding_dist?: number;
}

export interface ClusterAnalysisContext {
  folder: string;
  hasAnalysis: boolean;
  /** Medoid + closest-pair + outlier artifacts present under results/ */
  hasPreprocess: boolean;
  medoids: Record<string, string>;
  /** Primary (materialized) outlier trial_id per cluster label */
  outliers: Record<string, string>;
  /** Per-cluster closest-pair (boundary) trial IDs */
  boundaryTrials: Record<string, string[]>;
  boundaryPairs: ClusterBoundaryPair[];
  /** Saved HDBSCAN task params for exact config matching */
  task: {
    method?: string;
    nClusters?: number;
    minClusterSize?: number;
    minSamples?: number;
    clusterSelectionEpsilon?: number;
    clusterSelectionMethod?: string;
  } | null;
  interpretations: Record<string, ClusterInterpretationSummary>;
}

export interface BatchState {
  batch: Batch;
  egos: string[];
  trials: { [ego: string]: Trial[] };
  selectedTrialId: string | null;
  selectedTrialIds: { by: string; value: string[] };
  hoveredTrialId: string | null;
  freeformTrialIds: string[];
  metrics: { [kpiName: string]: CriticalityMetric } | null;
  selectedMetric: CriticalityMetric | null;
  selectedSafetyBoundaryMetric: CriticalityMetric | null;
  shapeStrings: string[];
  viewerMode: ViewerMode;
  bound: Bound;
  attributes: string[];
  filteredAttributes: string[];
  replayerRedrawHandled: boolean;
  durationMode: string;
  gridMode: string;
  baselineMode: boolean;

  timeOrS: "s" | "time";

  heatmapGlobalScaleX: number;
  heatmapGlobalScaleY: number;
  heatmapLocalScaleY: { [windowName: string]: number };

  clusteringDurationMode: boolean;
  filteredTrialIds: string[];
  showFullHeatmap: boolean;

  trajectoryAnalysis: { [egoName: string]: TrajectoryAnalysisResponse } | null;
  clusterInfos: {
    [egoName: string]: { [durationMode: string]: ClusterInfo[] };
  };

  selectedClusteringResults: {
    [egoName: string]: ClusteringResult | null;
  } | null;
  selectedClusterInfos: { [egoName: string]: ClusterInfo | null } | null;

  /** LLM analysis + medoids for the currently selected clustering config per ego */
  clusterAnalysisByEgo: {
    [egoName: string]: ClusterAnalysisContext | null;
  } | null;

  selectedClusteringResult: ClusteringResult | null;
  selectedClusterInfo: ClusterInfo | null;
  selectedClusteringResult2: ClusteringResult | null;
  selectedClusterInfo2: ClusterInfo | null;

  clipTimeManualOverride: number | null;
  clipPaused: boolean;

  tree: { [egoName: string]: kdTree<{ [key: string]: number }> };
  treePoints: {
    [egoName: string]: {
      trial: Trial;
      parameters: { [key: string]: number };
    }[];
  };

  heatmapSortedBy: string;
}

const initialState: BatchState = {
  heatmapSortedBy: "umap",
  timeOrS: "time",

  batch: null,
  egos: [],
  trials: {},

  selectedTrialId: null,
  selectedTrialIds: { by: "", value: [] },
  freeformTrialIds: [],
  hoveredTrialId: null,
  metrics: null,
  selectedMetric: null,
  selectedSafetyBoundaryMetric: null,
  shapeStrings: [
    "circle",
    "triangle",
    "square",
    "star",
    "diamond",
    "cross",
    "wye",
  ],
  viewerMode: "interaction-cluster",
  bound: null,
  attributes: [],
  filteredAttributes: [],
  replayerRedrawHandled: true,
  durationMode: "full",
  gridMode: "prediction",
  baselineMode: false,

  heatmapGlobalScaleX: 0.1,
  heatmapGlobalScaleY: 0.05,
  heatmapLocalScaleY: {},

  clusteringDurationMode: false,
  showFullHeatmap: false,
  filteredTrialIds: [],

  trajectoryAnalysis: null,
  clusterInfos: {},
  selectedClusteringResult: null,
  selectedClusterInfo: null,
  selectedClusteringResults: null,
  selectedClusterInfos: null,
  clusterAnalysisByEgo: null,

  selectedClusteringResult2: null,
  selectedClusterInfo2: null,

  clipTimeManualOverride: null,
  clipPaused: true,

  tree: {},
  treePoints: {},
};

export const batchSlice = createSlice({
  name: "batch",
  initialState,
  reducers: {
    reset: (state: BatchState) => {
      state = initialState;
    },
    setHeamtapSortedBy: (
      state: BatchState,
      action: PayloadAction<typeof initialState.heatmapSortedBy>
    ) => {
      state.heatmapSortedBy = action.payload;
    },
    setBatch: (
      state: BatchState,
      action: PayloadAction<typeof initialState.batch>
    ) => {
      state.batch = action.payload;
      state.egos = state.batch?.egos?.map((e) => e.name) ?? [];
    },
    setEgos: (
      state: BatchState,
      action: PayloadAction<typeof initialState.egos>
    ) => {
      state.egos = action.payload;
    },
    setTimeOrS: (
      state: BatchState,
      action: PayloadAction<typeof initialState.timeOrS>
    ) => {
      state.timeOrS = action.payload;
    },
    setTrials: (
      state: BatchState,
      action: PayloadAction<typeof initialState.trials>
    ) => {
      state.trials = action.payload;
    },
    setMetrics: (
      state: BatchState,
      action: PayloadAction<typeof initialState.metrics>
    ) => {
      state.metrics = action.payload;
    },
    setViewerMode: (
      state: BatchState,
      action: PayloadAction<typeof initialState.viewerMode>
    ) => {
      state.viewerMode = action.payload;
    },
    setGridMode: (
      state: BatchState,
      action: PayloadAction<typeof initialState.gridMode>
    ) => {
      state.gridMode = action.payload;
    },
    setFilteredTrialIds: (
      state: BatchState,
      action: PayloadAction<typeof initialState.filteredTrialIds>
    ) => {
      state.filteredTrialIds = action.payload;
    },
    setFreeformTrialIds: (
      state: BatchState,
      action: PayloadAction<typeof initialState.freeformTrialIds>
    ) => {
      state.freeformTrialIds = action.payload;
    },
    setReplayerRedrawHandled: (
      state: BatchState,
      action: PayloadAction<typeof initialState.replayerRedrawHandled>
    ) => {
      state.replayerRedrawHandled = action.payload;
    },
    setClusteringDurationMode: (
      state: BatchState,
      action: PayloadAction<typeof initialState.clusteringDurationMode>
    ) => {
      state.clusteringDurationMode = action.payload;
    },
    setBaselineMode: (
      state: BatchState,
      action: PayloadAction<typeof initialState.baselineMode>
    ) => {
      state.baselineMode = action.payload;
    },
    setBound: (
      state: BatchState,
      action: PayloadAction<typeof initialState.bound>
    ) => {
      state.bound = action.payload;
    },
    setFilteredAttributes: (
      state: BatchState,
      action: PayloadAction<typeof initialState.filteredAttributes>
    ) => {
      state.filteredAttributes = action.payload;
    },
    setAttributes: (
      state: BatchState,
      action: PayloadAction<typeof initialState.attributes>
    ) => {
      state.attributes = action.payload;
    },
    setShowFullHeatmap: (
      state: BatchState,
      action: PayloadAction<typeof initialState.showFullHeatmap>
    ) => {
      state.showFullHeatmap = action.payload;
    },
    setHeatmapGlobalScaleX: (
      state: BatchState,
      action: PayloadAction<typeof initialState.heatmapGlobalScaleX>
    ) => {
      state.heatmapGlobalScaleX = action.payload;
    },
    setHeatmapGlobalScaleY: (
      state: BatchState,
      action: PayloadAction<typeof initialState.heatmapGlobalScaleY>
    ) => {
      state.heatmapGlobalScaleY = action.payload;
    },
    setHeatmapLocalScaleY: (
      state: BatchState,
      action: PayloadAction<typeof initialState.heatmapLocalScaleY>
    ) => {
      state.heatmapLocalScaleY = action.payload;
    },
    setTrajectoryAnalysis: (
      state: BatchState,
      action: PayloadAction<typeof initialState.trajectoryAnalysis>
    ) => {
      state.filteredTrialIds = [];
      state.trajectoryAnalysis = action.payload;
      if (state.trajectoryAnalysis == null) {
        state.selectedClusteringResults = null;
        state.selectedClusteringResult = null;
        state.selectedClusteringResult2 = null;
        state.selectedClusterInfos = null;
        state.selectedClusterInfo = null;
        state.selectedClusterInfo2 = null;
        state.clusterInfos = {};
        return;
      }

      const updateClusterInfos = () => {
        if (state.trajectoryAnalysis == null) {
          return;
        }
        const newClusterInfos: typeof state.clusterInfos = {};
        for (const egoName of Object.keys(state.trajectoryAnalysis ?? {})) {
          newClusterInfos[egoName] = {};
          const trajectoryAnalysis = state.trajectoryAnalysis[egoName];
          for (const durationMode of Object.keys(
            trajectoryAnalysis.mfpca ?? {}
          )) {
            const updated: ClusterInfo[] = [];
            const target = trajectoryAnalysis.mfpca[durationMode].clustering;
            for (const result of target ?? []) {
              if (result == null) {
                continue;
              }
              const clusters: ClusterInfo = {};

              for (const item of Object.values(result.data)) {
                if (item == null) {
                  continue;
                }
                if (!(item.label in clusters)) {
                  clusters[item.label] = {
                    color: noiseColor,
                    count: 0,
                  };
                }
                clusters[item.label].count += 1;
              }
              let hasNoise = false;
              let uniqueClusterCount = Object.keys(clusters).length;
              if ("-1" in clusters) {
                uniqueClusterCount -= 1;
                hasNoise = true;
              }

              const palette = generateColors(uniqueClusterCount);

              const clusterLabels = Object.keys(clusters).sort();
              for (const [index, clusterLabel] of clusterLabels.entries()) {
                if (clusterLabel === "-1") {
                  clusters[clusterLabel].color = noiseColor;
                } else {
                  clusters[clusterLabel].color =
                    palette[hasNoise ? index - 1 : index];
                }
              }
              updated.push(clusters);
            }
            newClusterInfos[egoName][durationMode] = updated;
          }
        }

        state.clusterInfos = newClusterInfos;
      };
      updateClusterInfos();

      state.tree = {};
      state.treePoints = {};
      state.metrics = null;

      const updated: { [kpiId: string]: CriticalityMetric } = {};
      for (const egoName of Object.keys(state.trajectoryAnalysis)) {
        const trajectoryAnalysis: TrajectoryAnalysisResponse =
          state.trajectoryAnalysis[egoName];
        const trials = trajectoryAnalysis.trials;
        const batches = state.trajectoryAnalysis[egoName].batches;
        if (
          trials == null ||
          batches == null ||
          Object.keys(batches).length === 0
        ) {
          continue;
        }
        const batch = Object.values(trajectoryAnalysis.batches ?? {})[0];
        if (batch == null) {
          return;
        }

        // kdtree
        const trialArray = Object.values(trials ?? {});
        const points: {
          trial: (typeof trialArray)[number];
          parameters: { [key: string]: number };
        }[] = [];
        if (batch != null && trials != null) {
          for (const [index, trial] of Object.values(trials ?? {}).entries()) {
            const point: (typeof points)[number] = {
              trial: trial,
              parameters: {},
            };
            point.parameters["treeIndex"] = index;
            for (const parameter of trial.parameters) {
              point.parameters[parameter.parameterId as string] =
                parameter.value as number;
            }
            points.push(point);
          }
          state.treePoints[egoName] = points;

          const calculateDistance = (
            a: { [key: string]: number },
            b: { [key: string]: number }
          ) => {
            let sum = 0;
            for (const usedParameter of trialArray[0].parameters) {
              const id = usedParameter.parameterId as string;
              const parameter = batch.scenario.parameters.find(
                (p) => p.id === id
              );
              if (
                parameter == null ||
                parameter.min == null ||
                parameter.max == null
              ) {
                sum += Math.pow(a[id] - b[id], 2);
              } else {
                const bound = [parameter.min, parameter.max];
                const aValue = a[id] / (bound[1] - bound[0]);
                const bValue = b[id] / (bound[1] - bound[0]);
                sum += Math.pow(aValue - bValue, 2);
              }
            }

            return Math.sqrt(sum);
          };

          state.tree[egoName] = new kdTree<{ [key: string]: number }>(
            points.map((p, i) => ({ ...p.parameters, index: i })),
            calculateDistance,
            trialArray[0].parameters.map((p: any) => p.parameterId as string)
          );
        }

        const durationMode = state.durationMode;
        const usedTrials = Object.values(trials ?? {}).filter((t) =>
          trajectoryAnalysis.mfpca[durationMode].trialOrder.includes(
            String(t.id ?? "")
          )
        );

        for (const metric of batch.scenario.testObjectives
          ?.criticalityMetrics ?? []) {
          if (
            metric != null &&
            !Object.keys(trajectoryAnalysis.metricGradients ?? {}).includes(
              metric.keyPerformanceIndicator?.name ?? ""
            )
          ) {
            // console.log("continue")
            // console.log(metric);
            continue;
          }
          const values: number[] = [];
          for (const trial of usedTrials) {
            const trialMetric = trial.testObjectives?.criticalityMetrics.find(
              (m) =>
                m.keyPerformanceIndicator.id ===
                metric.keyPerformanceIndicator?.id
            );
            if (trialMetric == null) {
              continue;
            }
            values.push(trialMetric.value as number);
          }
          let min = undefined;
          let max = undefined;
          if (values.length > 0) {
            min = Math.min(...values);
            max = Math.max(...values);
            if (min - max === 0) {
              min = undefined;
              max = undefined;
            }
          }

          if (
            metric.keyPerformanceIndicator?.name === "spret_min" &&
            (max ?? 0) > 9
          ) {
            max = 9;
          }

          let gradMin = undefined;
          let gradMax = undefined;
          if (
            (metric.keyPerformanceIndicator?.name ?? "") in
            (trajectoryAnalysis.metricGradients ?? {})
          ) {
            const gradMags: number[] = [];
            let gradients =
              trajectoryAnalysis.metricGradients[
                metric?.keyPerformanceIndicator?.name ?? ""
              ];
            for (const trial of usedTrials) {
              let gradient =
                gradients != null && (trial.id ?? "") in gradients
                  ? gradients[trial.id ?? ""]
                  : [0, 0];
              const gradientMag = Math.sqrt(
                gradient[0] * gradient[0] + gradient[1] * gradient[1]
              );
              gradMags.push(gradientMag as number);
            }
            gradMin = Math.min(...gradMags);
            gradMax = Math.max(...gradMags);
          }

          const metricName = metric.keyPerformanceIndicator?.name ?? "unknown";
          updated[metric.keyPerformanceIndicator?.name ?? "unknown"] = {
            threshold: metric.threshold ?? 0,
            kpi: {
              rule: metric.keyPerformanceIndicator?.rule ?? "greaterThan",
              name: metric.keyPerformanceIndicator?.name ?? "unknown",
              unit: metric.keyPerformanceIndicator?.unit ?? "unknown",
              id: metric.keyPerformanceIndicator?.id ?? -1,
            },
            min,
            max,
            gradMin,
            gradMax,
          };
          if (updated != null && updated[metricName].min != null) {
            updated[metricName].min = Math.min(
              min ?? Infinity,
              updated[metricName].min
            );
          }
          if (updated != null && updated[metricName].max != null) {
            updated[metricName].max = Math.max(
              max ?? -Infinity,
              updated[metricName].max
            );
          }
          if (updated != null && updated[metricName].gradMax != null) {
            updated[metricName].gradMax = Math.max(
              gradMax ?? -Infinity,
              updated[metricName].gradMax
            );
          }
          if (updated != null && updated[metricName].gradMin != null) {
            updated[metricName].gradMin = Math.max(
              gradMin ?? Infinity,
              updated[metricName].gradMin
            );
          }
        }
      }

      state.metrics = updated;

      // const selectFirst = () => {
      //   if (state.trajectoryAnalysis == null) {
      //     return;
      //   }
      //   for (const egoName of Object.keys(state.trajectoryAnalysis)) {
      //     const trajectoryAnalysis = state.trajectoryAnalysis[egoName];
      //     const durationMode = state.durationMode;
      //     const results = trajectoryAnalysis.mfpca[durationMode].clustering;
      //     const clusterInfos = state.clusterInfos;
      //     if (
      //       results == null ||
      //       results.length === 0 ||
      //       clusterInfos == null ||
      //       clusterInfos[egoName][durationMode].length === 0
      //     ) {
      //       if (egoName === "ITRI") {
      //         state.selectedClusteringResult = null;
      //         state.selectedClusterInfo = null;
      //       } else {
      //         state.selectedClusteringResult2 = null;
      //         state.selectedClusterInfo2 = null;
      //       }
      //       return;
      //     }
      //     if (egoName === "ITRI") {
      //       state.selectedClusteringResult = results[0];
      //       state.selectedClusterInfo = clusterInfos[egoName][durationMode][0];
      //     } else {
      //       state.selectedClusteringResult2 = results[0];
      //       state.selectedClusterInfo2 = clusterInfos[egoName][durationMode][0];
      //     }
      //   }
      // };
      // selectFirst();

      console.log(state.metrics);
      if (state.metrics == null) {
        return;
      }

      const collisionIndex = Object.keys(state.metrics).findIndex(
        (key) => key === "collision"
      );
      const spretMinIndex = Object.keys(state.metrics).findIndex(
        (key) => key === "spret_min"
      );
      const ttcMinIndex = Object.keys(state.metrics).findIndex(
        (key) => key === "ttc_min"
      );

      if (spretMinIndex >= 0) {
        state.selectedMetric =
          spretMinIndex === -1
            ? Object.values(state.metrics)[1]
            : Object.values(state.metrics)[spretMinIndex];
      } else {
        state.selectedMetric =
          ttcMinIndex === -1
            ? Object.values(state.metrics)[1]
            : Object.values(state.metrics)[ttcMinIndex];
      }
      state.selectedSafetyBoundaryMetric =
        collisionIndex === -1
          ? Object.values(state.metrics)[0]
          : Object.values(state.metrics)[collisionIndex];
    },
    // setDurationMode: (
    //   state: BatchState,
    //   action: PayloadAction<typeof initialState.durationMode>,
    // ) => {
    //   const durationMode = action.payload;
    //   state.durationMode = durationMode;
    //   state.selectedClusteringResult = null;
    //   // state.selectedClusteringResult =
    //   //   state.trajectoryAnalysis?.mfpca[durationMode].clustering[0] ?? null;
    //   state.selectedClusterInfo = state.clusterInfos[durationMode][0];
    // },
    setSelectedClusteringResults: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedClusteringResults>
    ) => {
      state.selectedClusteringResults = action.payload;
    },
    setSelectedClusterInfos: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedClusterInfos>
    ) => {
      state.selectedClusterInfos = action.payload;
    },
    setClusterAnalysisByEgo: (
      state: BatchState,
      action: PayloadAction<typeof initialState.clusterAnalysisByEgo>
    ) => {
      state.clusterAnalysisByEgo = action.payload;
    },
    setSelectedClusteringResult: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedClusteringResult>
    ) => {
      state.selectedClusteringResult = action.payload;
    },
    setSelectedClusterInfo: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedClusterInfo>
    ) => {
      state.selectedClusterInfo = action.payload;
    },
    setSelectedClusteringResult2: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedClusteringResult2>
    ) => {
      state.selectedClusteringResult2 = action.payload;
    },
    setSelectedClusterInfo2: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedClusterInfo2>
    ) => {
      state.selectedClusterInfo2 = action.payload;
    },
    setSelectedSafetyBoundaryMetric: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedSafetyBoundaryMetric>
    ) => {
      state.selectedSafetyBoundaryMetric = action.payload;
    },
    setSelectedMetric: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedMetric>
    ) => {
      state.selectedMetric = action.payload;
    },
    setSelectedTrialId: (
      state: BatchState,
      action: PayloadAction<typeof initialState.selectedTrialId>
    ) => {
      state.selectedTrialId = action.payload;
    },
    setSelectedTrialIds: (
      state: BatchState,
      action: PayloadAction<typeof state.selectedTrialIds>
    ) => {
      state.selectedTrialIds = action.payload;
    },
    setHoveredTrialId: (
      state: BatchState,
      action: PayloadAction<typeof initialState.hoveredTrialId>
    ) => {
      state.hoveredTrialId = action.payload;
    },
    setClipTimeManualOverride: (
      state: BatchState,
      action: PayloadAction<typeof initialState.clipTimeManualOverride>
    ) => {
      state.clipTimeManualOverride = action.payload;
    },
    setClipPaused: (
      state: BatchState,
      action: PayloadAction<typeof initialState.clipPaused>
    ) => {
      state.clipPaused = action.payload;
    },
  },
});

export const batchActions = batchSlice.actions;
export default batchSlice.reducer;
