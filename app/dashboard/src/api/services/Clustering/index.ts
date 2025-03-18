import { analyzerHttp } from "src/api/http-common";
import { TrajectoryQuery } from "../Trials";
import { Trial } from "../Batches";

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
  anova: { [clusterLabel: string]: { fvalue: number; pvalue: number }[] };
};
export type UmapProjection = {
  parameters: { minDist: number; nNeighbors: number };
  data: { [trialId: string]: number[] };
};

export type BoundaryDiff = {
  umapProjections: {
    [failurePatternClusterLabel: string]: UmapProjection[] | null;
  };
  representations: {
    [failurePatternClusterLabel: string]: {
      [trialId: string]: number[];
    } | null;
  };
  results: { [failurePatternClusterLabel: string]: ClusteringResult[] | null };
};

export type Fpcs = {
  nComponents: number;
  data: number[][][];
  mean: number[][];
  attributes: {
    name: string;
  }[];
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
  umapProjections: UmapProjection[];
};

// @dataclass
// class State:
// ▏   trialId: str
// ▏   timeInTrajectoryQuery: float
// ▏   attributes: Dict[str, float]
//
//
// @dataclass
// class Pca:
// ▏   states: List[State]
// ▏   attributes: List[str]
// ▏   cos2Vars: List[List[float]]
// ▏   explainedVarianceRatio: List[float]
// ▏   results: List[ClusteringResult]
// ▏   projections: List[List[float]]

export type State = {
  trialId: string;
  timeInTrajectoryQuery: number;
  attributes: { [name: string]: number };
};
export type Pca = {
  states: { [trialId: string]: State };
  attributes: string[];
  cos2Vars: number[][];
  loadings: number[][];
  explainedVarianceRatio: number[];
  results: ClusteringResult[];
  projections: { [trialId: string]: number[] };
  umapProjections: UmapProjection[];
};

export type ClusteringResponse = {
  request: ClusteringRequest;
  batchTrials: { [batchId: string]: string[] };
  trials: { [trialId: string]: Trial & { batchId: string } };
  trajectoryQueries: { [trailId: string]: TrajectoryQuery };
  boundaryPairs: {
    passed: { [passedTrialId: string]: string };
    failed: { [failedTrialId: string]: string };
  };
  failureClustering: Mfpca;
  boundaryDiffClustering: Mfpca;
  criticalStateClustering: Pca;
  safetyMarginViolationStateClustering: Pca;
  lastEgoDiffClustering: Pca;
};

export const getClustering = (query: ClusteringRequest) => {
  return analyzerHttp.post<ClusteringResponse>("/clustering", query);
};

export const getSuperPoints = (query: {
  clusterResult: ClusteringResult;
  representations: number[][];
  ratio: number;
}) => {
  return analyzerHttp.post<{ [trialId: string]: string[] }>(
    "/superpoints",
    query,
  );
};
