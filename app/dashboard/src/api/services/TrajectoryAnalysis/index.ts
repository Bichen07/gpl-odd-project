import { analyzerHttp } from "src/api/http-common";
import { Trial } from "../Batches";
import { gql } from "src/__generated__/gql";
import { Object } from "ts-toolbelt";
import { GetBatchInfoQuery } from "src/__generated__/graphql";
import { TrajectoryResponseData } from "../Trials";

const GET_BATCH_INFO = gql(/* GraphQL */ `
  query GetBatchInfo($id: String!) {
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
  "hdbscan",
  "hdbscanFlat",
  "kmeans",
  "hierarchy",
] as const;
export type ClusteringMethod = (typeof clusteringMethods)[number];
export type ClusteringTask = {
  method: ClusteringMethod;
  nClusters: number;
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
  probability: number;
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
  scores: ClusteringScore;
  data: { [trialId: string]: TrialClusterItem };
};

export type Pca = {
  loadings: number[][];
  explainedVarianceRatio: number[];
  results: ClusteringResult[];
  projections: { [trialId: string]: number[] };
};

export type Mfpca = {
  scores: { [trialId: string]: number[] };
  timePoints: number[];
  attributes: string[];
  fpcs: number[][][];
  means: number[][];
  explainedVarianceRatio: number[];
  nComponents: number;
  results: ClusteringResult[];
  dendrogram: { [dendrogramMethod: string]: Dendrogram };
  durationIndices: { [trialId: string]: [number, number] };
  umapProjections: UmapProjection[];
  gradients: {
    data: { [trialId: string]: number[][] };
    isosurface: { x: number; y: number; z: number; value: number }[];
    clustering: Pca;
    umapProjections: UmapProjection[];
  };
  metricGradients: {
    [metricName: string]: {
      metricValue: { [trialId: string]: number };
      data: { [trialId: string]: number[] };
    };
  };
  parameters: ScenarioParameters;
};

export type TrajectoryAnalysisResponse = {
  request: TrajectoryAnalysisRequest;
  trials: { [trialId: string]: Trial & { batchId: string } };
  batches: { [batchId: string]: BatchInfo };
  trajectories: { [trailId: string]: { [attribute: string]: number }[] };
  rawTrajectories: {
    [trailId: string]: TrajectoryResponseData;
  };
  columns: string[];
  clustering: Mfpca;
  metricGridPredictions: {
    [metricName: string]: { z: number[][] };
  };
  boundaryGrid: {
    [metricName: string]: { z: number[][] };
  };
  boundaryPaths: {
    [metricName: string]: number[][][];
  };
};

export const getTrajectoryAnalysis = (query: TrajectoryAnalysisRequest) => {
  return analyzerHttp.post<TrajectoryAnalysisResponse>(
    "/trajectory_analysis",
    query,
  );
};
