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
  rule_score: number;
  llm_score: number | null;
  final_score: number;
  rank: number | null;
  has_llm_eval: boolean;
  sub_scores: Record<string, unknown>;
  cross_cluster_eval?: {
    behavioral_separation_score: number | null;
    boundary_clarity_score: number | null;
    inter_notes: string;
    cluster_summaries: Array<{cluster_id: number; archetype: string; intra_score?: number}>;
    merge_candidates?: string[];
    split_candidates?: string[];
  } | null;
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
  crossEval?: Record<string, unknown> | null;
  selectionEval?: Record<string, unknown> | null;
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

export type CrossEvalData = {
  behavioral_separation_score: number | null;
  boundary_clarity_score: number | null;
  inter_notes: string;
  cluster_summaries: Array<{cluster_id: number; archetype: string; intra_score?: number}>;
  merge_candidates?: string[];
  split_candidates?: string[];
} | null | undefined;

export type ReportData = {
  header: {
    batchId: string;
    folder: string;
    k: number | null;
    silhouette: number | null;
    qualityScore: number | null;
    qualityRuleScore: number | null;
    selectionScore: number | null;
  };
  clusters: Array<{
    id: number;
    label: string | null;
    n: number;
    collisionRate: number | null;
    collisionCount: number | null;
    parameterRanges: Record<string, [number, number]> | null;
    neighborhoodSeparation: string | null;
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
    separationCall: string | null;
    separationReason: string | null;
    contrastExplanation: string | null;
    hasContrast: boolean;
  }>;
  selectionFindings: string[];
  mergeCandidates: Array<{
    clusters: [number, number];
    sharedMotive: string;
    collisionRate: [number, number];
    paramOverlap: number;
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
  } | null;
  boundaryPairsJoin: {
    nPairs: number;
    nPairsTouchingBoundary: number;
  } | null;
};

export type ChatTurn = {
  timestamp?: string;
  conversation_id?: string;
  question: string;
  answer: string;
  citations: string[];
  model: string;
  dry_run?: boolean;
};
