import { analyzerApi } from "../../api";
import { Trial } from "./trials";
import { gql } from "../__generated__/gql";
import { Object } from "ts-toolbelt";
import {
  Document,
  GetBatchesQuery,
  GetBatchInfoQuery,
} from "@/app/_shared/graphql/__generated__/graphql";
import { TrajectoryResponseData } from "./trials";

const GET_BATCH_INFO = gql(/* GraphQL */ `
  query GetBatchInfo($id: Int!) {
    Batch(id: $id) {
      id
      scenario {
        parameters {
          id
          name
          min
          max
          unit
        }
        testObjectives {
          criticalityMetrics {
            id
            threshold
            keyPerformanceIndicator {
              id
              name
              rule
              unit
            }
          }
        }
      }
    }
  }
`);

export type BatchInfo = Object.Path<GetBatchInfoQuery, ["Batch"]>;
export type ScenarioParameters = Object.Path<
  GetBatchInfoQuery,
  ["Batch", "scenario", "parameters"]
>;

export type TrajectoryAnalysisRequest = {
  batchIds: string[];
  framePeriod: number;
  tasks: ClusteringTask[];
};
export type UmapProjection = {
  parameters: { minDist: number; nNeighbors: number };
  data: { [trialId: string]: number[] };
};

export type Dendrogram = {
  iCoord: number[][];
  dCoord: number[][];
  trialIds: string[];
};

export const clusteringMethods = [
  "hdbscan+mfpca",
  "dbscan+mfpca",
  "hierarchy+mfpca",
] as const;
export type ClusteringMethod = (typeof clusteringMethods)[number];
export type ClusteringTask = {
  method: ClusteringMethod;
  nClusters?: number;
  minClusterSize?: number;
  minSamples?: number;
  clusterSelectionEpsilon?: number;
  clusterSelectionMethod?: "eom" | "leaf";
};
export type ClusteringRequest = {
  kpiId: string;
  batchIds: string[];
  nFrames: number;
  duration: number;
  tasks: ClusteringTask[];
};
export type TrialClusterItem = {
  trialId: string;
  label: string;
  // probabilities: { [clusterLabel: string]: number };
  // probability: number;
};
export type ClusteringScore = {
  calinskiHarabazScore: number;
  silhouetteScore: number;
  daviesBouldinScore: number;
  dbcvScore: number;
  sDbwScore: number;
};
export type ClusteringResult = {
  task: ClusteringTask;
  scores: { [scoreName: string]: number };
  data: { [trialId: string]: TrialClusterItem };
  trialOrder: { [label: string]: string[] };
  // trialOrder: string[];
};

export type Pca = {
  loadings: number[][];
  explainedVarianceRatio: number[];
  results: ClusteringResult[];
  projections: { [trialId: string]: number[] };
};

export type Mfpca = {
  attributes: string[];
  scores: { [trialId: string]: number[] };
  timePoints: number[];
  fpcs: number[][][];
  means: number[][];
  explainedVarianceRatio: number[];
  clustering: ClusteringResult[];
  // dendrogram: { [dendrogramMethod: string]: Dendrogram };
  umapProjections: UmapProjection[];
  durationIndices: { [trialId: string]: [number, number] } | null;
  trialOrder: string[];
  moreToVizTrialOrder: string[];
  moreToVizSeconds: number;
};

export type TrajectoryAnalysisResponse = {
  id: string;
  request: TrajectoryAnalysisRequest;
  trials: { [trialId: string]: Trial & { batchId: string } };
  batches: { [batchId: string]: BatchInfo };
  mfpca: { [name: string]: Mfpca };
  attributes: string[];
  parameters: ScenarioParameters;
  metricGradients: { [metricName: string]: { [trialId: string]: number[] } };
  metricGridPredictions: {
    [metricName: string]: { z: number[][] };
  };
  metricGridGradients?: {
    [metricName: string]: { z: number[][] };
  };
  heatmapFileinfo: Document;
  trajectoriesFileinfo: Document;
  fullHeatmaps: Document[];
  // trajectories: { [trailId: string]: { [attribute: string]: number }[] };
  // rawTrajectories: {
  //   [trailId: string]: TrajectoryResponseData;
  // };
  // fullTrialOrder: string[];
};

export const getTrajectoryAnalysis = (query: TrajectoryAnalysisRequest) => {
  return analyzerApi.post<TrajectoryAnalysisResponse>(
    "/trajectory_analysis",
    query
  );
};

export type AnalysisProgress = {
  active: boolean;
  batchIds: string[];
  phase: string;
  current: number;
  total: number;
  percent: number;
  message: string;
  elapsedSec: number;
};

export const getAnalysisProgress = () => {
  return analyzerApi.get<AnalysisProgress>("/analysis_progress");
};
