import chroma from "chroma-js";
import { List } from "ts-toolbelt";
import { RootState } from "../store";
import { KeyPerformanceIndicator } from "src/__generated__/graphql";
import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import {
  ClusteringResponse,
  ClusteringResult,
} from "src/api/services/Clustering";
import { TrajectoryQuery } from "src/api/services/Trials";
import { generateColors } from "src/utils";
import { mangoFusionPaletteDark } from "@mui/x-charts";
import { TrajectoryAnalysisResponse } from "src/api/services/TrajectoryAnalysis";
import { kdTree } from "kd-tree-javascript";
import { StateAnalysisResponse } from "src/api/services/StateAnalysis";
import { DEG2RAD, RAD2DEG } from "three/src/math/MathUtils.js";

export type ClusteringMode = "boundaryDiff" | "critical" | "lastEgoDiff";

export const viewerModes = [
  // "criticality",
  "pass/fail",
  "interaction-cluster",
] as const;
export type ViewerMode = (typeof viewerModes)[number];

export type ClusterInfo = {
  [clusterLabel: string]: {
    count: number;
    color: string;
  };
};

export type CriticalityMetric = {
  threshold: number;
  kpi: {
    id: string;
    name: string;
    rule: "greaterThan" | "lessThan";
    unit: string;
  };
  min?: number;
  max?: number;
};

export interface SessionState {
  selectedTrialId: string | null;
  selectedPairTrialId: string | null;
  pairMode: boolean;
  reverseBoundaryMode: boolean;
  pairTrialMapping: { [metric: string]: { [trialId: string]: string | null } };
  selectedTrialIds: string[];
  hoveredTrialId: string | null;
  metrics: { [kpiName: string]: CriticalityMetric } | null;
  selectedMetric: CriticalityMetric | null;
  selectedSafetyBoundaryMetric: CriticalityMetric | null;
  shapeStrings: string[];
  criticalityHalfs: {
    [name: string]: { [trialId: string]: number };
  } | null;
  cluster2clusterSelectedLabel: string;
  cluster2cluster: {
    [label: string]: { [saferTrialId: string]: string };
  } | null;
  viewerMode: ViewerMode;

  selectedStateId: string | null;
  pairedStateId: string | null;
  safe2unsafeMappings: { [safer: string]: string };

  boundaryFilteringEnabled: boolean;
  boundaryKNeighbors: number;
  boundaryKpi: KeyPerformanceIndicator | null;
  clusteringDurationMode: boolean;
  groupComparationMode: boolean;
  metricGradientFilterEnabled: boolean;
  metricGradientFilterThreshold: number;
  fpcGradientFilterEnabled: boolean;
  fpcGradientFilterThreshold: number;
  filteredTrialIds: string[];
  freeformTrialIds: string[];
  pairedTrialIds: string[];
  boundaryTrialIds: string[];

  savedTrajectoryAnalysis: string[];
  trajectoryAnalysisResponse: TrajectoryAnalysisResponse | null;
  stateAnalysisResponse: StateAnalysisResponse | null;
  tree: kdTree<{ [key: string]: number }> | null;
  treePoints:
    | {
        trial: any;
        parameters: { [key: string]: number };
      }[]
    | null;

  trajectoryAnalysisClusterInfos: ClusterInfo[] | null;
  selectedTrajectoryAnalysisClusteringResult: ClusteringResult | null;
  selectedTrajectoryAnalysisClusterInfo: ClusterInfo | null;

  gradientClusterInfos: ClusterInfo[] | null;
  selectedGradientClusteringResult: ClusteringResult | null;
  selectedGradientClusterInfo: ClusterInfo | null;
  selectedGradientCluster: string | null;

  savedClusterings: string[];
  clusteringResponse: ClusteringResponse | null;

  failureClusterInfos: ClusterInfo[] | null;
  boundaryDiffClusterInfos: ClusterInfo[] | null;
  criticalStateClusterInfos: ClusterInfo[] | null;
  safetyMarginViolationStateClusterInfos: ClusterInfo[] | null;
  lastEgoDiffClusterInfos: ClusterInfo[] | null;

  selectedFailureClusteringResult: ClusteringResult | null;
  selectedBoundaryDiffClusteringResult: ClusteringResult | null;
  selectedCriticalStateClusteringResult: ClusteringResult | null;
  selectedSafetyMarginViolationStateClusteringResult: ClusteringResult | null;
  selectedLastEgoDiffClusteringResult: ClusteringResult | null;

  selectedFailureClusterInfo: ClusterInfo | null;
  selectedBoundaryDiffClusterInfo: ClusterInfo | null;
  selectedCriticalStateClusterInfo: ClusterInfo | null;
  selectedSafetyMarginViolationStateClusterInfo: ClusterInfo | null;
  selectedLastEgoDiffClusterInfo: ClusterInfo | null;

  selectedFailureCluster: string | null;
  selectedBoundaryDiffCluster: string | null;
  selectedCriticalStateCluster: string | null;
  selectedSafetyMarginViolationStateCluster: string | null;
  selectedLastEgoDiffCluster: string | null;

  // selectedBoundarySafeCluster: string | null;
  // selectedBoundarySafeClusterTrialIds: { [clusterLabel: string]: Set<string> };

  passedClusterTrialIds: { [clusterLabel: string]: Set<string> };
  failedClusterTrialIds: { [clusterLabel: string]: Set<string> };
  failedClusterPassedIds: { [clusterLabel: string]: Set<string> };

  replayerKpi: KeyPerformanceIndicator | null;
  replayerTrajectoryQuery: TrajectoryQuery | null;
  replayerDuration: number;
  clipTimeManualOverride: number | null;
  clipPaused: boolean;
}

const initialState: SessionState = {
  selectedTrialId: null,
  selectedPairTrialId: null,
  pairMode: false,
  reverseBoundaryMode: false,
  pairTrialMapping: {},
  selectedTrialIds: [],
  hoveredTrialId: null,
  metrics: null,
  selectedMetric: null,
  selectedSafetyBoundaryMetric: null,
  boundaryTrialIds: [],
  shapeStrings: [
    "circle",
    "triangle",
    "square",
    "star",
    "diamond",
    "cross",
    "wye",
  ],
  criticalityHalfs: null,
  cluster2cluster: null,
  cluster2clusterSelectedLabel: "all",
  viewerMode: "pass/fail",

  selectedStateId: null,
  pairedStateId: null,
  safe2unsafeMappings: {},

  boundaryFilteringEnabled: false,
  boundaryKNeighbors: 5,
  boundaryKpi: null,
  clusteringDurationMode: true,
  groupComparationMode: true,
  metricGradientFilterEnabled: false,
  metricGradientFilterThreshold: 0,
  fpcGradientFilterEnabled: false,
  fpcGradientFilterThreshold: 0,
  filteredTrialIds: [],
  freeformTrialIds: [],
  pairedTrialIds: [],

  savedTrajectoryAnalysis: [],
  trajectoryAnalysisResponse: null,
  stateAnalysisResponse: null,
  tree: null,

  trajectoryAnalysisClusterInfos: null,
  selectedTrajectoryAnalysisClusteringResult: null,
  selectedTrajectoryAnalysisClusterInfo: null,

  gradientClusterInfos: null,
  selectedGradientClusteringResult: null,
  selectedGradientClusterInfo: null,
  selectedGradientCluster: null,

  savedClusterings: [],
  clusteringResponse: null,
  failureClusterInfos: null,
  boundaryDiffClusterInfos: null,
  criticalStateClusterInfos: null,
  safetyMarginViolationStateClusterInfos: null,
  lastEgoDiffClusterInfos: null,

  selectedFailureClusteringResult: null,
  selectedBoundaryDiffClusteringResult: null,
  selectedCriticalStateClusteringResult: null,
  selectedSafetyMarginViolationStateClusteringResult: null,
  selectedLastEgoDiffClusteringResult: null,

  selectedFailureCluster: null,
  selectedBoundaryDiffCluster: null,
  selectedCriticalStateCluster: null,
  selectedSafetyMarginViolationStateCluster: null,
  selectedLastEgoDiffCluster: null,

  selectedFailureClusterInfo: null,
  selectedBoundaryDiffClusterInfo: null,
  selectedCriticalStateClusterInfo: null,
  selectedSafetyMarginViolationStateClusterInfo: null,
  selectedLastEgoDiffClusterInfo: null,

  passedClusterTrialIds: {},
  failedClusterTrialIds: {},
  failedClusterPassedIds: {},

  replayerKpi: null,
  replayerTrajectoryQuery: null,
  replayerDuration: 0,
  clipTimeManualOverride: null,
  clipPaused: false,
};

export const sessionSlice = createSlice({
  name: "session",
  initialState,
  reducers: {
    reset: (state: SessionState) => {
      state = initialState;
    },
    setBoundaryTrialIds: (state: SessionState) => {
      let trials = state.trajectoryAnalysisResponse?.trials;
      const batches = state.trajectoryAnalysisResponse?.batches;
      const tree = state.tree;

      if (trials == null || batches == null || tree == null) {
        return;
      }

      const trialArray = Object.values(trials);
      // if (
      //   state.selectedTrajectoryAnalysisClusteringResult?.task.method ===
      //   "hierarchy"
      // ) {
      //   const usedIds = new Set(
      //     Object.keys(
      //       state.trajectoryAnalysisResponse?.clustering.dendrogram[
      //         "hierarchy"
      //       ] ?? {},
      //     ),
      //   );
      //   console.log(usedIds.size);
      //   console.log(trialArray.length);
      //   for (const trial of trialArray) {
      //     if (!usedIds.has(trial.id ?? "")) {
      //       delete trials[trial.id ?? ""];
      //     }
      //   }
      // }

      const allTrialIds = new Set<string>(Object.keys(trials));
      const boundaryTrialIds = new Set<string>();

      const boundaryKNeighbors = state.boundaryKNeighbors;
      const boundaryKpi = state.selectedSafetyBoundaryMetric?.kpi;

      if (
        boundaryKNeighbors > 0 &&
        boundaryKpi != null &&
        state.boundaryFilteringEnabled
      ) {
        for (const [index, trial] of Object.values(trials).entries()) {
          const query: { [key: string]: number } = {};
          query["index"] = index;
          for (const parameter of trial.parameters) {
            query[parameter.parameterId as string] = parameter.value as number;
          }
          const nearests = tree.nearest(query, boundaryKNeighbors + 1);
          const neighbors = nearests.map(([item, _distance]) => {
            const index = item["index"];
            return trialArray[index];
          });
          // console.log(neighbors);

          let isBoundary = false;
          const currentPassed = trial.testObjectives?.criticalityMetrics.find(
            (c) => c.keyPerformanceIndicator.id === boundaryKpi.id,
          )?.passed;
          for (const neighbor of neighbors) {
            const neighborPassed =
              neighbor.testObjectives?.criticalityMetrics.find(
                (c) => c.keyPerformanceIndicator.id === boundaryKpi.id,
              )?.passed;
            isBoundary = currentPassed !== neighborPassed;
            if (isBoundary) {
              break;
            }
          }

          if (isBoundary) {
            for (const id of [
              trial.id ?? "",
              ...neighbors.map((n) => n.id ?? ""),
            ]) {
              boundaryTrialIds.add(id);
            }
          }
        }
      }

      if (boundaryTrialIds.size === 0) {
        for (const id in state.trajectoryAnalysisResponse?.trials) {
          boundaryTrialIds.add(id);
        }
      }
      // console.log(boundaryTrialIds);

      // if (
      //   state.metricGradientFilterEnabled &&
      //   state.boundaryKpi != null &&
      //   state.trajectoryAnalysisResponse != null
      // ) {
      //   const grads =
      //     state.trajectoryAnalysisResponse.clustering.metricGradients[
      //       state.boundaryKpi.name
      //     ].data;
      //   const gradTrialIds = new Set<string>();
      //   for (const [trialId, grad] of Object.entries(grads)) {
      //     gradTrialIds.add(trialId);
      //   }
      //   for (const id of filteredTrialIds) {
      //     if (!gradTrialIds.has(id)) {
      //       filteredTrialIds.delete(id);
      //     }
      //   }
      //   for (const [trialId, grad] of Object.entries(grads)) {
      //     if (!filteredTrialIds.has(trialId)) {
      //       continue;
      //     }
      //     let sum = 0;
      //     for (const value of grad) {
      //       sum += value * value;
      //     }
      //     let mag = Math.sqrt(sum);
      //     if (mag < state.metricGradientFilterThreshold) {
      //       filteredTrialIds.delete(trialId);
      //     }
      //   }
      // }
      // if (
      //   state.fpcGradientFilterEnabled &&
      //   state.trajectoryAnalysisResponse != null
      // ) {
      //   const grads =
      //     state.trajectoryAnalysisResponse.clustering.gradients.data;
      //   const gradTrialIds = new Set<string>();
      //   for (const [trialId, grad] of Object.entries(grads)) {
      //     gradTrialIds.add(trialId);
      //   }
      //   for (const id of filteredTrialIds) {
      //     if (!gradTrialIds.has(id)) {
      //       filteredTrialIds.delete(id);
      //     }
      //   }
      //   for (const [trialId, grad] of Object.entries(grads)) {
      //     if (!filteredTrialIds.has(trialId)) {
      //       continue;
      //     }
      //     let sum = 0;
      //     for (const row of grad) {
      //       for (const value of row) {
      //         sum += value * value;
      //       }
      //     }
      //     let mag = Math.sqrt(sum);
      //     if (mag < state.fpcGradientFilterThreshold) {
      //       filteredTrialIds.delete(trialId);
      //     }
      //   }
      // }

      if (state.reverseBoundaryMode) {
        state.boundaryTrialIds = [...allTrialIds.difference(boundaryTrialIds)];
      } else {
        state.boundaryTrialIds = [...boundaryTrialIds];
      }
    },
    setMetricGradientFilterEnabled: (
      state: SessionState,
      action: PayloadAction<typeof initialState.metricGradientFilterEnabled>,
    ) => {
      state.metricGradientFilterEnabled = action.payload;
    },
    setMetricGradientFilterThreshold: (
      state: SessionState,
      action: PayloadAction<typeof initialState.metricGradientFilterThreshold>,
    ) => {
      state.metricGradientFilterThreshold = action.payload;
    },
    setFpcGradientFilterEnabled: (
      state: SessionState,
      action: PayloadAction<typeof initialState.fpcGradientFilterEnabled>,
    ) => {
      state.fpcGradientFilterEnabled = action.payload;
    },
    setFpcGradientFilterThreshold: (
      state: SessionState,
      action: PayloadAction<typeof initialState.fpcGradientFilterThreshold>,
    ) => {
      state.fpcGradientFilterThreshold = action.payload;
    },
    setViewerMode: (
      state: SessionState,
      action: PayloadAction<typeof initialState.viewerMode>,
    ) => {
      state.viewerMode = action.payload;
    },
    setCriticalityHalfs: (
      state: SessionState,
      action: PayloadAction<typeof initialState.criticalityHalfs>,
    ) => {
      state.criticalityHalfs = action.payload;
    },
    setSelectedCluster2ClusterLabel: (
      state: SessionState,
      action: PayloadAction<typeof initialState.cluster2clusterSelectedLabel>,
    ) => {
      state.cluster2clusterSelectedLabel = action.payload;
    },
    setCluster2Cluster: (
      state: SessionState,
      action: PayloadAction<typeof initialState.cluster2cluster>,
    ) => {
      state.cluster2cluster = action.payload;
    },
    setSelectedStateId: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedStateId>,
    ) => {
      state.selectedStateId = action.payload;

      if (state.stateAnalysisResponse && state.selectedStateId) {
        const gradientObj =
          state.stateAnalysisResponse.states[state.selectedStateId]
            .metricGradients["dce_min"];
        const gradient: number[] = [];
        for (const key of Object.keys(gradientObj)) {
          gradient.push(gradientObj[key]);
        }
        let selectedPoint: number[] = [];
        const points: number[][] = [];
        for (const s of Object.values(state.stateAnalysisResponse.states)) {
          const point: number[] = [];
          for (const key of Object.keys(gradientObj)) {
            point.push(s.data[key]);
          }
          points.push(point);
          if (s.id === state.selectedStateId) {
            selectedPoint = point;
          }
        }
        const pairedIndex = findClosestPointAlongGradient(
          selectedPoint,
          gradient,
          points,
        );
        if (pairedIndex != null) {
          state.pairedStateId = Object.entries(
            state.stateAnalysisResponse.states,
          )[pairedIndex][0];
          console.log(state.pairedStateId);
        }
      }
    },
    setFilteredTrialIds: (
      state: SessionState,
      action: PayloadAction<typeof initialState.filteredTrialIds>,
    ) => {
      state.filteredTrialIds = action.payload;
    },
    setFreeformTrialIds: (
      state: SessionState,
      action: PayloadAction<typeof initialState.freeformTrialIds>,
    ) => {
      state.freeformTrialIds = action.payload;
    },
    setPairedTrialIds: (
      state: SessionState,
      action: PayloadAction<typeof initialState.pairedTrialIds>,
    ) => {
      state.pairedTrialIds = action.payload;
    },
    setGroupComparationMode: (
      state: SessionState,
      action: PayloadAction<typeof initialState.groupComparationMode>,
    ) => {
      state.groupComparationMode = action.payload;
    },
    setClusteringDurationMode: (
      state: SessionState,
      action: PayloadAction<typeof initialState.clusteringDurationMode>,
    ) => {
      state.clusteringDurationMode = action.payload;
    },
    setBoundaryFilteringEnabled: (
      state: SessionState,
      action: PayloadAction<typeof initialState.boundaryFilteringEnabled>,
    ) => {
      state.boundaryFilteringEnabled = action.payload;
    },
    setBoundaryKNeighbors: (
      state: SessionState,
      action: PayloadAction<typeof initialState.boundaryKNeighbors>,
    ) => {
      state.boundaryKNeighbors = action.payload;
    },
    setBoundaryKpi: (
      state: SessionState,
      action: PayloadAction<typeof initialState.boundaryKpi>,
    ) => {
      state.boundaryKpi = action.payload;
    },
    setSavedTrajectoryAnalysis: (
      state: SessionState,
      action: PayloadAction<string[]>,
    ) => {
      state.savedTrajectoryAnalysis = action.payload;
    },
    setStateAnalysisResponse: (
      state: SessionState,
      action: PayloadAction<typeof initialState.stateAnalysisResponse>,
    ) => {
      state.stateAnalysisResponse = action.payload;
    },
    setTrajectoryAnalysisResponse: (
      state: SessionState,
      action: PayloadAction<typeof initialState.trajectoryAnalysisResponse>,
    ) => {
      state.trajectoryAnalysisResponse = action.payload;

      const trials = state.trajectoryAnalysisResponse?.trials;
      const trialArray = Object.values(trials ?? {});
      const batches = state.trajectoryAnalysisResponse?.batches;
      const points: {
        trial: (typeof trialArray)[number];
        parameters: { [key: string]: number };
      }[] = [];
      state.filteredTrialIds = [];
      state.boundaryTrialIds = Object.keys(trials ?? {});

      state.tree = null;
      if (batches != null && trials != null) {
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
        state.treePoints = points;

        const calculateDistance = (
          a: { [key: string]: number },
          b: { [key: string]: number },
        ) => {
          let sum = 0;
          for (const usedParameter of trialArray[0].parameters) {
            const id = usedParameter.parameterId as string;
            const parameter = batches[
              trialArray[0].batchId
            ]?.scenario.parameters.find((p) => p.id === id);
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

        state.tree = new kdTree<{ [key: string]: number }>(
          points.map((p, i) => ({ ...p.parameters, index: i })),
          calculateDistance,
          trialArray[0].parameters.map((p: any) => p.parameterId as string),
        );
      }

      const updateClusterInfos = (isGradinet = false) => {
        const updated: ClusterInfo[] = [];
        const target = isGradinet
          ? state.trajectoryAnalysisResponse?.clustering.gradients.clustering
              .results
          : state.trajectoryAnalysisResponse?.clustering.results;
        for (const result of target ?? []) {
          if (result == null) {
            continue;
          }
          const clusters: ClusterInfo = {};

          for (const item of Object.values(result.data)) {
            if (!(item.label in clusters)) {
              clusters[item.label] = {
                color: "#000000",
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
              continue;
            }
            clusters[clusterLabel].color =
              palette[hasNoise ? index - 1 : index];
          }
          updated.push(clusters);
        }
        if (isGradinet) {
          state.gradientClusterInfos = updated;
        } else {
          state.trajectoryAnalysisClusterInfos = updated;
        }
      };

      const selectFirst = (isGradinet = false) => {
        const results = isGradinet
          ? state.trajectoryAnalysisResponse?.clustering.gradients.clustering
              .results
          : state.trajectoryAnalysisResponse?.clustering.results;
        const clusterInfos = state.trajectoryAnalysisClusterInfos;
        if (
          results == null ||
          results.length === 0 ||
          clusterInfos == null ||
          clusterInfos.length === 0
        ) {
          if (isGradinet) {
            state.selectedGradientClusteringResult = null;
            state.selectedGradientClusterInfo = null;
          } else {
            state.selectedTrajectoryAnalysisClusteringResult = null;
            state.selectedTrajectoryAnalysisClusterInfo = null;
          }
          return;
        }
        if (isGradinet) {
          state.selectedGradientClusteringResult = results[0];
          state.selectedGradientClusterInfo = clusterInfos[0];
        } else {
          state.selectedTrajectoryAnalysisClusteringResult = results[0];
          state.selectedTrajectoryAnalysisClusterInfo = clusterInfos[0];
        }
      };

      updateClusterInfos();
      selectFirst();
      updateClusterInfos(true);
      selectFirst(true);

      const trajectoryAnalysis = state.trajectoryAnalysisResponse;
      // const trials = Object.values(trajectoryAnalysis?.trials ?? {});
      if (
        trials == null ||
        trajectoryAnalysis?.batches == null ||
        Object.keys(trajectoryAnalysis.batches).length === 0
      ) {
        return;
      }
      const batch = Object.values(trajectoryAnalysis.batches ?? {})[0];
      if (batch == null) {
        return;
      }
      const dend = new Set(
        trajectoryAnalysis.clustering.dendrogram["hierarchy"].trialIds,
      );
      const usedTrials = Object.values(trials ?? {}).filter((t) =>
        dend.has(t.id ?? ""),
      );
      const updated: { [kpiId: string]: CriticalityMetric } = {};
      for (const metric of batch.scenario.testObjectives?.criticalityMetrics ??
        []) {
        const values: number[] = [];
        for (const trial of usedTrials) {
          const trialMetric = trial.testObjectives?.criticalityMetrics.find(
            (m) =>
              m.keyPerformanceIndicator.id ===
              metric.keyPerformanceIndicator?.id,
            // `${m.keyPerformanceIndicator}` ===
            // metric.keyPerformanceIndicator?.id,
          );
          if (trialMetric == null) {
            continue;
          }
          // if (metric.keyPerformanceIndicator?.name === "dce_min") {
          //   console.log(trialMetric);
          // }
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
        updated[metric.keyPerformanceIndicator?.name ?? "unknown"] = {
          threshold: metric.threshold ?? 0,
          kpi: {
            rule: metric.keyPerformanceIndicator?.rule ?? "greaterThan",
            name: metric.keyPerformanceIndicator?.name ?? "unknown",
            unit: metric.keyPerformanceIndicator?.unit ?? "unknown",
            id: metric.keyPerformanceIndicator?.id ?? "unknown",
          },
          min,
          max,
        };
      }
      state.metrics = updated;
      state.selectedMetric = Object.values(state.metrics)[0];
      state.selectedSafetyBoundaryMetric = Object.values(state.metrics)[0];

      // ----------------------------------------------------------------------
      const newPairs: typeof state.pairTrialMapping = {};
      for (const metric of Object.values(state.metrics)) {
        const metricName = metric.kpi.name;
        newPairs[metricName] = {};
      }
      if (state.trajectoryAnalysisResponse && state.tree && state.treePoints) {
        for (const [index, trial] of Object.values(trials ?? {}).entries()) {
          for (const metric of Object.values(state.metrics)) {
            const metricName = metric.kpi.name;
            if (
              !(
                metricName in
                state.trajectoryAnalysisResponse.clustering.metricGradients
              )
            ) {
              continue;
            }

            const parameters =
              state.trajectoryAnalysisResponse.clustering.parameters;
            if (parameters == null) {
              console.log("no parameters");
              continue;
            }

            if (state.treePoints == null) {
              continue;
            }

            if (
              !(
                (trial.id ?? "unknown") in
                state.trajectoryAnalysisResponse.clustering.metricGradients[
                  metricName
                ].data
              )
            ) {
              continue;
            }

            const selectedTreePoint = state.treePoints.find(
              (p) => p.trial.id === trial.id,
            );
            if (selectedTreePoint == null) {
              continue;
            }

            const nNeighbors = 10;
            const nearestTreePointIndices = state.tree
              ?.nearest(selectedTreePoint.parameters, nNeighbors)
              .map((item) => item[0]["treeIndex"]);
            const nearestTreePoints = nearestTreePointIndices
              .map((i) =>
                state.treePoints != null ? state.treePoints[i] : null,
              )
              .sort((a, b) => {
                const aMetricValue = a?.trial["testObjectives"][
                  "criticalityMetrics"
                ].find(
                  (item: any) =>
                    item["keyPerformanceIndicator"]["name"] == metricName,
                )["value"];

                const bMetricValue = b?.trial["testObjectives"][
                  "criticalityMetrics"
                ].find(
                  (item: any) =>
                    item["keyPerformanceIndicator"]["name"] == metricName,
                )["value"];
                return metric.kpi.rule == "lessThan"
                  ? aMetricValue - bMetricValue
                  : bMetricValue - aMetricValue;
              });

            // find pair
            const gradient =
              state.trajectoryAnalysisResponse.clustering.metricGradients[
                metricName
              ].data[trial.id ?? ""].map((row) => row[0]);
            // const gradientNorm = Math.sqrt(gradient[0] ** 2 + gradient[1] ** 2);
            const gradientUnit: Point = [gradient[0], gradient[1]];

            let minDistance = Infinity;
            let minTrialId = null;
            let minAngleDiff = Infinity;

            const selectedPoint: number[] = [];
            for (const parameter of parameters) {
              selectedPoint.push(
                selectedTreePoint.parameters[parameter.id ?? ""],
              );
            }
            for (const [i, treePoint] of nearestTreePoints.entries()) {
              if (
                treePoint == null ||
                treePoint.trial["id"] === state.selectedTrialId
              ) {
                continue;
              }
              const point: number[] = [];
              for (const parameter of parameters) {
                point.push(treePoint.parameters[parameter.id ?? ""]);
              }
              const v: Point = [
                point[0] - selectedPoint[0],
                point[1] - selectedPoint[1],
              ];
              const gradAng = Math.atan2(gradientUnit[1], gradientUnit[0]);
              const vAng = Math.atan2(v[1], v[0]);
              const angDiff = Math.abs(vAng - gradAng);
              if (angDiff < minAngleDiff && Math.abs(angDiff) < 90 * DEG2RAD) {
                minTrialId = treePoint.trial.id ?? "";
                minAngleDiff = angDiff;
              }
              // if (Math.abs(angDiff) < 30 * DEG2RAD) {
              //   minTrialId = treePoint.trial.id ?? "";
              //   minAngleDiff = angDiff;
              //   break;
              // }

              // console.log("selectedPoint");
              // console.log(selectedPoint);
              // console.log("point");
              // console.log(point);
              // console.log("v");
              // console.log(v);
              // console.log("gradient");
              // console.log(gradient);
              // console.log("gradAng");
              // console.log(gradAng * RAD2DEG);
              // console.log("vang");
              // console.log(vAng * RAD2DEG);
              // console.log("angDiff");
              // console.log(angDiff * RAD2DEG);
            }

            newPairs[metricName][trial.id ?? ""] = minTrialId;
            // console.log(minTrialId);
          }
          state.pairTrialMapping = newPairs;
          // console.log(newPairs);
        }
      }
    },
    setPairMode: (
      state: SessionState,
      action: PayloadAction<typeof initialState.pairMode>,
    ) => {
      state.pairMode = action.payload;
    },
    setReverseBoundaryMode: (
      state: SessionState,
      action: PayloadAction<typeof initialState.reverseBoundaryMode>,
    ) => {
      state.reverseBoundaryMode = action.payload;
    },
    setSelectedSafetyBoundaryMetric: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedSafetyBoundaryMetric>,
    ) => {
      state.selectedSafetyBoundaryMetric = action.payload;
    },
    setSelectedMetric: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedMetric>,
    ) => {
      state.selectedMetric = action.payload;
    },
    setSelectedTrajectoryAnalysisClusteringResult: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedTrajectoryAnalysisClusteringResult
      >,
    ) => {
      state.selectedTrajectoryAnalysisClusteringResult = action.payload;
    },
    setSelectedTrajectoryAnalysisClusterInfo: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedTrajectoryAnalysisClusterInfo
      >,
    ) => {
      state.selectedTrajectoryAnalysisClusterInfo = action.payload;
    },
    setSelectedGradientCluster: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedGradientCluster>,
    ) => {
      state.selectedGradientCluster = action.payload;
    },
    setSelectedGradientClusteringResult: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedGradientClusteringResult
      >,
    ) => {
      state.selectedGradientClusteringResult = action.payload;
    },
    setSelectedGradientClusterInfo: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedGradientClusterInfo>,
    ) => {
      state.selectedGradientClusterInfo = action.payload;
    },
    setSavedClusterings: (
      state: SessionState,
      action: PayloadAction<string[]>,
    ) => {
      state.savedClusterings = action.payload;
    },
    setClusteringResponse: (
      state: SessionState,
      action: PayloadAction<typeof initialState.clusteringResponse>,
    ) => {
      state.clusteringResponse = action.payload;

      const updateClusterInfos = (targetMode: ClusteringMode) => {
        const updated: ClusterInfo[] = [];
        const target =
          targetMode === "boundaryDiff"
            ? state.clusteringResponse?.boundaryDiffClustering.results
            : targetMode == "critical"
              ? state.clusteringResponse?.criticalStateClustering.results
              : state.clusteringResponse?.lastEgoDiffClustering.results;
        for (const result of target ?? []) {
          if (result == null) {
            continue;
          }
          const clusters: ClusterInfo = {};

          for (const item of Object.values(result.data)) {
            if (!(item.label in clusters)) {
              clusters[item.label] = {
                color: "#000000",
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
              continue;
            }
            clusters[clusterLabel].color =
              palette[hasNoise ? index - 1 : index];
          }
          updated.push(clusters);
        }
        if (targetMode === "boundaryDiff") {
          state.boundaryDiffClusterInfos = updated;
        } else if (targetMode === "critical") {
          state.criticalStateClusterInfos = updated;
        } else {
          state.lastEgoDiffClusterInfos = updated;
        }
      };

      const selectFirst = (targetMode: ClusteringMode) => {
        const results =
          targetMode === "boundaryDiff"
            ? state.clusteringResponse?.boundaryDiffClustering.results
            : targetMode === "critical"
              ? state.clusteringResponse?.criticalStateClustering.results
              : state.clusteringResponse?.lastEgoDiffClustering.results;
        const clusterInfos =
          targetMode === "boundaryDiff"
            ? state.boundaryDiffClusterInfos
            : targetMode === "critical"
              ? state.criticalStateClusterInfos
              : state.lastEgoDiffClusterInfos;
        if (
          results == null ||
          results.length === 0 ||
          clusterInfos == null ||
          clusterInfos.length === 0
        ) {
          if (targetMode === "boundaryDiff") {
            state.selectedBoundaryDiffClusteringResult = null;
            state.selectedBoundaryDiffClusterInfo = null;
          } else if (targetMode === "critical") {
            state.selectedCriticalStateClusteringResult = null;
            state.selectedCriticalStateClusterInfo = null;
          } else {
            state.selectedLastEgoDiffClusteringResult = null;
            state.selectedLastEgoDiffClusterInfo = null;
          }
          return;
        }
        if (targetMode === "boundaryDiff") {
          state.selectedBoundaryDiffClusteringResult = results[0];
          state.selectedBoundaryDiffClusterInfo = clusterInfos[0];
        } else if (targetMode === "critical") {
          state.selectedCriticalStateClusteringResult = results[0];
          state.selectedCriticalStateClusterInfo = clusterInfos[0];
        } else {
          state.selectedLastEgoDiffClusteringResult = results[0];
          state.selectedLastEgoDiffClusterInfo = clusterInfos[0];
        }
      };

      updateClusterInfos("boundaryDiff");
      // updateClusterInfos("critical");
      // updateClusterInfos("lastEgoDiff");
      selectFirst("boundaryDiff");
      // selectFirst("critical");
      // selectFirst("lastEgoDiff");

      if (state.selectedFailureClusteringResult) {
        state.passedClusterTrialIds = {};
        state.failedClusterTrialIds = {};
        for (const clusterItem of Object.values(
          state.selectedFailureClusteringResult.data,
        )) {
          const passed =
            clusterItem.trialId in
            (state.clusteringResponse?.boundaryPairs.passed ?? {});
          const targetMappings = passed
            ? state.passedClusterTrialIds
            : state.failedClusterTrialIds;
          if (!(clusterItem.label in targetMappings)) {
            targetMappings[clusterItem.label] = new Set<string>();
          }
          targetMappings[clusterItem.label].add(clusterItem.trialId);
        }
      }
    },
    findAndSetSelectedPairTrialId: (state: SessionState) => {
      if (
        state.selectedTrialId &&
        state.selectedMetric &&
        state.selectedTrialId in
          state.pairTrialMapping[state.selectedMetric.kpi.name] &&
        state.pairTrialMapping[state.selectedMetric.kpi.name][
          state.selectedTrialId
        ] != ""
      ) {
        state.selectedPairTrialId =
          state.pairTrialMapping[state.selectedMetric.kpi.name][
            state.selectedTrialId
          ];
      }
      // if (
      //   state.trajectoryAnalysisResponse &&
      //   state.selectedTrialId &&
      //   state.tree &&
      //   state.treePoints
      // ) {
      //   if (state.selectedMetric == null) {
      //     return;
      //   }
      //   const metricName = state.selectedMetric.kpi.name;
      //   const parameters =
      //     state.trajectoryAnalysisResponse.clustering.parameters;
      //   if (parameters == null) {
      //     console.log("no parameters");
      //     return;
      //   }
      //   if (state.treePoints == null) {
      //     return;
      //   }
      //   const selectedTreePoint = state.treePoints.find(
      //     (p) => p.trial.id === state.selectedTrialId,
      //   );
      //   if (selectedTreePoint == null) {
      //     return;
      //   }
      //
      //   console.log("selectedTreePointIndices");
      //   console.log(selectedTreePoint);
      //   console.log(state.tree);
      //   const nearestTreePointIndices = state.tree
      //     ?.nearest(selectedTreePoint.parameters, 7)
      //     .map((item) => item[0]["treeIndex"]);
      //   console.log("nearestTreePointsIndices");
      //   console.log(nearestTreePointIndices);
      //   const gradTrialIds = new Set(
      //     Object.keys(
      //       state.trajectoryAnalysisResponse.clustering.metricGradients[
      //         metricName
      //       ].data,
      //     ),
      //   );
      //   const nearestTreePoints = nearestTreePointIndices.map((i) =>
      //     state.treePoints != null ? state.treePoints[i] : null,
      //   );
      //   console.log("nearestTreePoints");
      //   console.log(nearestTreePoints);
      //
      //   // find pair
      //   const gradient =
      //     state.trajectoryAnalysisResponse.clustering.metricGradients[
      //       metricName
      //     ].data[state.selectedTrialId].map((row) => row[0]);
      //   // const gradientNorm = Math.sqrt(gradient[0] ** 2 + gradient[1] ** 2);
      //   const gradientUnit: Point = [gradient[0], gradient[1]];
      //
      //   let minDistance = Infinity;
      //   let minTrialId = null;
      //   let minAngleDiff = Infinity;
      //
      //   const selectedPoint: number[] = [];
      //   for (const parameter of parameters) {
      //     selectedPoint.push(selectedTreePoint.parameters[parameter.id ?? ""]);
      //   }
      //   for (const [i, treePoint] of nearestTreePoints.entries()) {
      //     if (
      //       treePoint == null ||
      //       treePoint.trial["id"] === state.selectedTrialId
      //     ) {
      //       continue;
      //     }
      //     const point: number[] = [];
      //     for (const parameter of parameters) {
      //       point.push(treePoint.parameters[parameter.id ?? ""]);
      //     }
      //
      //     console.log(treePoint.trial.id);
      //     // Compute vector from p to q
      //     const v: Point = [
      //       point[0] - selectedPoint[0],
      //       point[1] - selectedPoint[1],
      //     ];
      //     // const vMag = Math.sqrt(v[0] ** 2 + v[1] ** 2);
      //     // const vUnit: Point = [v[0] / vMag, v[1] / vMag];
      //     const gradAng = Math.atan2(gradientUnit[1], gradientUnit[0]);
      //     // const vAng = Math.atan2(vUnit[1], vUnit[0]);
      //     const vAng = Math.atan2(v[1], v[0]);
      //     const angDiff = Math.abs(vAng - gradAng);
      //
      //     if (angDiff < minAngleDiff) {
      //       minTrialId = treePoint.trial.id ?? "";
      //       console.log("NEW MINMINMIN");
      //       console.log(minTrialId);
      //       minAngleDiff = angDiff;
      //     }
      //
      //     console.log("selectedPoint");
      //     console.log(selectedPoint);
      //     console.log("point");
      //     console.log(point);
      //     console.log("v");
      //     console.log(v);
      //     console.log("gradient");
      //     console.log(gradient);
      //     console.log("gradAng");
      //     console.log(gradAng * RAD2DEG);
      //     console.log("vang");
      //     console.log(vAng * RAD2DEG);
      //     console.log("angDiff");
      //     console.log(angDiff * RAD2DEG);
      //     // console.log("vMag");
      //     // console.log(vMag);
      //     // if (Math.abs(ang) * RAD2DEG > 90) {
      //     //   console.log("GREATER THAN 90");
      //     //   continue;
      //     // }
      //     // const dist = vMag * Math.sin(ang);
      //     // console.log("dist");
      //     // console.log(dist);
      //     // if (dist < minDistance) {
      //     //   minTrialId = treePoint.trial.id ?? "";
      //     //   console.log("NEW MINMINMIN");
      //     //   console.log(minTrialId);
      //     //   minDistance = dist;
      //     // }
      //   }
      //
      //   state.selectedPairTrialId = minTrialId;
      //   console.log("FINAL PAIR");
      //   console.log(state.selectedPairTrialId);
      // }
    },
    setSelectedPairTrialId: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedPairTrialId>,
    ) => {
      state.selectedPairTrialId = action.payload;
    },
    setSelectedTrialId: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedTrialId>,
    ) => {
      state.selectedTrialId = action.payload;
    },
    setSelectedTrialIds: (
      state: SessionState,
      action: PayloadAction<typeof state.selectedTrialIds>,
    ) => {
      state.selectedTrialIds = action.payload;
    },
    setSelectedFailureCluster: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedFailureCluster>,
    ) => {
      state.selectedFailureCluster = action.payload;
    },
    setSelectedCriticalStateCluster: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedCriticalStateCluster>,
    ) => {
      state.selectedCriticalStateCluster = action.payload;
    },
    setSelectedBoundaryDiffCluster: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedBoundaryDiffCluster>,
    ) => {
      state.selectedBoundaryDiffCluster = action.payload;
    },
    setSelectedFailureClusteringResult: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedFailureClusteringResult
      >,
    ) => {
      state.selectedFailureClusteringResult = action.payload;
    },
    setSelectedBoundaryDiffClusteringResult: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedBoundaryDiffClusteringResult
      >,
    ) => {
      state.selectedBoundaryDiffClusteringResult = action.payload;
    },
    setSelectedBoundaryDiffClusterInfo: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedBoundaryDiffClusterInfo
      >,
    ) => {
      state.selectedBoundaryDiffClusterInfo = action.payload;
    },
    setSelectedSafetyMarginViolationStateClusterInfo: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedSafetyMarginViolationStateClusterInfo
      >,
    ) => {
      state.selectedSafetyMarginViolationStateClusterInfo = action.payload;
    },
    setSelectedSafetyMarginViolationStateClusteringResult: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedSafetyMarginViolationStateClusteringResult
      >,
    ) => {
      state.selectedSafetyMarginViolationStateClusteringResult = action.payload;
    },
    setSelectedSafetyMarginViolationStateCluster: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedSafetyMarginViolationStateCluster
      >,
    ) => {
      state.selectedSafetyMarginViolationStateCluster = action.payload;
    },
    setSelectedCriticalStateClusteringResult: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedCriticalStateClusteringResult
      >,
    ) => {
      state.selectedCriticalStateClusteringResult = action.payload;
    },
    setSelectedCriticalStateClusterInfo: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedCriticalStateClusterInfo
      >,
    ) => {
      state.selectedCriticalStateClusterInfo = action.payload;
    },
    setSelectedLastEgoDiffClusteringResult: (
      state: SessionState,
      action: PayloadAction<
        typeof initialState.selectedLastEgoDiffClusteringResult
      >,
    ) => {
      state.selectedLastEgoDiffClusteringResult = action.payload;
    },
    setSafe2UnsafeMappings: (
      state: SessionState,
      action: PayloadAction<typeof initialState.safe2unsafeMappings>,
    ) => {
      state.safe2unsafeMappings = action.payload;
    },
    setSelectedLastEgoDiffClusterInfo: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedLastEgoDiffClusterInfo>,
    ) => {
      state.selectedLastEgoDiffClusterInfo = action.payload;
    },
    setSelectedLastEgoDiffCluster: (
      state: SessionState,
      action: PayloadAction<typeof initialState.selectedLastEgoDiffCluster>,
    ) => {
      state.selectedLastEgoDiffCluster = action.payload;
    },
    setHoveredTrialId: (
      state: SessionState,
      action: PayloadAction<typeof initialState.hoveredTrialId>,
    ) => {
      state.hoveredTrialId = action.payload;
    },
    setReplayerKpi: (
      state: SessionState,
      action: PayloadAction<typeof initialState.replayerKpi>,
    ) => {
      state.replayerKpi = action.payload;
    },
    setReplayerDuration: (
      state: SessionState,
      action: PayloadAction<typeof initialState.replayerDuration>,
    ) => {
      state.replayerDuration = action.payload;
    },
    setReplayerTrajectoryQuery: (
      state: SessionState,
      action: PayloadAction<typeof initialState.replayerTrajectoryQuery>,
    ) => {
      state.replayerTrajectoryQuery = action.payload;
    },
    setClipTimeManualOverride: (
      state: SessionState,
      action: PayloadAction<typeof initialState.clipTimeManualOverride>,
    ) => {
      state.clipTimeManualOverride = action.payload;
    },
    setClipPaused: (
      state: SessionState,
      action: PayloadAction<typeof initialState.clipPaused>,
    ) => {
      state.clipPaused = action.payload;
    },
  },
});

export const sessionActions = sessionSlice.actions;
export default sessionSlice.reducer;

export function findPairsFromTwoGroups(
  selectedMetric: CriticalityMetric | null,
  trajectoryAnalysisResponse: TrajectoryAnalysisResponse | null,
  tree: kdTree<{ [key: string]: number }> | null,
  treePoints:
    | {
        trial: any;
        parameters: { [key: string]: number };
      }[]
    | null,
  groups: { safer: string[]; unsafer: string[] },
) {
  const trials = trajectoryAnalysisResponse?.trials;

  const result: { [saferTrialId: string]: string } = {};
  if (selectedMetric && trajectoryAnalysisResponse && trials && tree) {
    for (const [index, trial] of Object.values(trials ?? {}).entries()) {
      if (!groups.safer.includes(trial.id ?? "")) {
        continue;
      }

      const metric = selectedMetric;
      const metricName = selectedMetric.kpi.name;
      if (
        !(metricName in trajectoryAnalysisResponse.clustering.metricGradients)
      ) {
        continue;
      }

      const parameters = trajectoryAnalysisResponse.clustering.parameters;
      if (parameters == null) {
        console.log("no parameters");
        continue;
      }

      if (treePoints == null) {
        console.log("treepoints == null, conitnue");
        continue;
      }

      if (
        !(
          (trial.id ?? "unknown") in
          trajectoryAnalysisResponse.clustering.metricGradients[metricName].data
        )
      ) {
        console.log("trial id not in metric gradients data, conitnue");
        continue;
      }

      const selectedTreePoint = treePoints.find((p) => p.trial.id === trial.id);
      if (selectedTreePoint == null) {
        console.log("selectedTreePoint is null, conitnue..");
        continue;
      }

      const nNeighbors = 15;
      const nearestTreePointIndices = tree
        ?.nearest(selectedTreePoint.parameters, nNeighbors)
        .map((item) => item[0]["treeIndex"]);
      const nearestTreePoints = nearestTreePointIndices.map((i) =>
        treePoints != null ? treePoints[i] : null,
      );
      // .sort((a, b) => {
      //   const aMetricValue = a?.trial["testObjectives"][
      //     "criticalityMetrics"
      //   ].find(
      //     (item: any) =>
      //       item["keyPerformanceIndicator"]["name"] == metricName,
      //   )["value"];
      //
      //   const bMetricValue = b?.trial["testObjectives"][
      //     "criticalityMetrics"
      //   ].find(
      //     (item: any) =>
      //       item["keyPerformanceIndicator"]["name"] == metricName,
      //   )["value"];
      //   return metric.kpi.rule == "lessThan"
      //     ? aMetricValue - bMetricValue
      //     : bMetricValue - aMetricValue;
      // });

      const gradient = trajectoryAnalysisResponse.clustering.metricGradients[
        metricName
      ].data[trial.id ?? ""].map((row) => row[0]);
      const gradientUnit: Point = [gradient[0], gradient[1]];

      let minDistance = Infinity;
      let minTrialId = null;
      let minAngleDiff = Infinity;

      const selectedPoint: number[] = [];
      for (const parameter of parameters) {
        selectedPoint.push(selectedTreePoint.parameters[parameter.id ?? ""]);
      }
      for (const [i, treePoint] of nearestTreePoints.entries()) {
        if (
          treePoint == null ||
          groups.safer.includes(treePoint.trial["id"]) ||
          !groups.unsafer.includes(treePoint.trial["id"])
        ) {
          continue;
        }
        const point: number[] = [];
        for (const parameter of parameters) {
          point.push(treePoint.parameters[parameter.id ?? ""]);
        }
        const v: Point = [
          point[0] - selectedPoint[0],
          point[1] - selectedPoint[1],
        ];
        const gradAng = Math.atan2(gradientUnit[1], gradientUnit[0]);
        const vAng = Math.atan2(v[1], v[0]);
        const angDiff = Math.abs(vAng - gradAng);
        // if (Math.abs(angDiff) < 30 * DEG2RAD) {
        //   minTrialId = treePoint.trial.id ?? "";
        //   minAngleDiff = angDiff;
        //   break;
        // }
        if (angDiff < minAngleDiff && Math.abs(angDiff) < 30 * DEG2RAD) {
          minTrialId = treePoint.trial.id ?? "";
          minAngleDiff = angDiff;
        }
      }

      if (minTrialId && minTrialId != "" && trial?.id != null) {
        result[trial.id] = minTrialId;
      } else {
        console.log("not found min trial id, continue");
      }
    }
  }
  return result;
}

type Point = [number, number];

function findClosestPointAlongGradient(
  p: number[],
  gradient: number[],
  points: number[][],
): number | null {
  // Normalize the gradient direction
  // const gradientNorm = Math.sqrt(gradient[0] ** 2 + gradient[1] ** 2);
  const gradientUnit: Point = [gradient[0], gradient[1]];
  // console.log("gradientUnit");
  // console.log(gradientUnit);

  let minDistance = Infinity;
  let closestIndex: number | null = null;

  for (const [i, q] of points.entries()) {
    // Compute vector from p to q
    const v: Point = [q[0] - p[0], q[1] - p[1]];

    // Project v onto the gradient direction
    const projection = v[0] * gradientUnit[0] + v[1] * gradientUnit[1];

    // Check if the projection is positive
    if (projection > 0) {
      // Compute distance
      const distance = Math.sqrt(v[0] ** 2 + v[1] ** 2);
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }
  }

  console.log("closest point");
  console.log(closestIndex ? points[closestIndex] : null);
  return closestIndex;
}
