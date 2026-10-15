export type ClusterEntry = {
  cluster: number;
  stats: Record<string, unknown> | null;
  medoid: Record<string, unknown> | null;
  intraVariance: Record<string, unknown> | null;
  snapshots: string[];
  /** Medoid process context (`processed/context_medoid.md`), if present. */
  contextMedoid?: string;
};

export type ClusteringQuality = {
  folder: string;
  k: number | null;
  silhouette: number | null;
  score: number;
  rank: number | null;
  sub_scores: Record<string, unknown>;
  trajectory_projection_pairs?: Array<{
    cluster_a: number; trial_a: string; collided_a: boolean;
    cluster_b: number; trial_b: string; collided_b: boolean;
    embedding_dist: number;
  }>;
};

export type ModelOption = { id: string; provider: string };

export type ResultEntry = {
  cluster: number;
  meta: Record<string, unknown> | null;
  rawYaml: string;
};

export type SplitClusterCard = {
  cluster: number;
  aggregate: Record<string, unknown> | null;
  summaryYaml: string;
  summaryMeta?: Record<string, unknown> | null;
  medoidYaml: string;
  medoidMeta?: Record<string, unknown> | null;
  contextMedoid?: string;
  touchingIcPairs?: string[];
  missingIcContrasts?: string[];
  readyForSummary?: boolean;
};

export type IcPairEntry = {
  name: string;
  yaml: string;
  folder?: string;
  facts?: Record<string, unknown> | null;
  syncedBev?: string[];
  contrastMeta?: Record<string, unknown> | null;
  mergedTimeline?: string;
  processContext?: string;
  hasProcessContext?: boolean;
  hasSyncedBev?: boolean;
  hasContrast?: boolean;
  medoidReady?: boolean;
  readyForLlm?: boolean;
  missing?: string[];
};

export type SplitAnalysis = {
  clusters: SplitClusterCard[];
  icPairs: IcPairEntry[];
  quality?: Record<string, unknown> | null;
};

export type Config = {
  batchId: string;
  folder: string;
  clusters: ClusterEntry[];
  prompts: Record<string, string>;
  models: ModelOption[];
  results?: ResultEntry[];
  splitAnalysis?: SplitAnalysis | null;
};

export type EgoEvent = { t: number | null; text: string };

export type BoundaryPair = {
  cluster_a: number; trial_a: string; collided_a: boolean;
  cluster_b: number; trial_b: string; collided_b: boolean;
  embedding_dist: number;
};

export type ReportData = {
  header: {
    batchId: string;
    folder: string;
    k: number | null;
    silhouette: number | null;
    qualityScore: number | null;
  };
  clusters: Array<{
    id: number;
    label: string | null;
    n: number;
    collisionRate: number | null;
    collisionCount: number | null;
    parameterRanges: Record<string, [number, number]> | null;
    neighborBehavior: string | null;
    medoidMotive: string | null;
    medoidOutcome: string | null;
    medoidResolution: string | null;
    summaryCaption: string | null;
    riskLevel: string | null;
    consistencyNote: string | null;
    hasMedoid: boolean;
    hasSummary: boolean;
  }>;
  pairs: Array<{
    folder: string;
    clusters: [number, number];
    paramDist: number | null;
    outcomeFlip: boolean;
    behaviorSimilarity: string | null;
    behaviorSimilarityReason: string | null;
    contrastExplanation: string | null;
    hasContrast: boolean;
  }>;
  boundaryExport: {
    generatedAt: string | null;
    kNN: number | null;
    kpiName: string | null;
    clustersIncluded: string[];
    nTrialsConsidered: number | null;
    nTrialsWithoutClusterLabel: number | null;
    collisionBoundaryCount: number;
    clusterBoundaryCount: number;
  } | null;
  parameterRules: {
    generatedAt: string | null;
    maxDepth: number | null;
    features: string[];
    nTrialsUsed: number | null;
    trainAcc: number | null;
    cvAcc: number | null;
    rules: Array<{
      id: string;
      predicate: string;
      predicted: string;
      support: number;
      precision: number;
      boundaryTrialHits: number | null;
    }>;
    plot: {
      xName: string;
      yName: string;
      points: Array<{ x: number; y: number; passed: boolean; cluster: number | null }>;
    } | null;
  } | null;
};

export type ChatTurn = {
  timestamp?: string;
  conversation_id?: string;
  question: string;
  answer: string;
  citations: string[];
  requested?: { need?: string; cluster?: number; folder?: string; trial_id?: string; clusters?: number[] } | null;
  asked?: string | null;
  sent?: string | null;
  images?: { rel: string; t?: number | null; label?: string | null }[];
  build_trial_ids?: string[];
  model: string;
  dry_run?: boolean;
};
