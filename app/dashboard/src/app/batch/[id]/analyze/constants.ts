export const PROMPT_LABELS: Array<{ key: string; label: string; help: string }> = [
  { key: "system", label: "System prompt", help: "Persona + CoT/YAML output contract for all products." },
  { key: "common_sense", label: "Domain rules / glossary", help: "Metrics glossary + motive labels shared by all products." },
  { key: "medoid", label: "Medoid trial prompt", help: "Motive / decision timeline for one medoid trial." },
  { key: "summary", label: "Cluster summary prompt", help: "Caption over enriched TTC/IC digests." },
  { key: "parameter_space_pair", label: "Parameter-space closest-pair prompt", help: "Contrast two near-identical parameter-space trials across clusters." },
  {
    key: "cross_eval",
    label: "Cross-cluster eval prompt",
    help: "Grades the whole partition from the medoid + Parameter-space pair cards and the deterministic checks.",
  },
];

// Prompt groups keyed by product (tabs no longer share indices with products).
export const PROMPT_KEYS: Record<string, string[]> = {
  medoid: ["system", "common_sense", "medoid"],
  "parameter-space-pairs": ["system", "common_sense", "parameter_space_pair"],
  summary: ["system", "common_sense", "summary"],
};

export const TAB = {
  SETUP: 0,
  MEDOID: 1,
  PAIRS: 2,
  CLUSTER: 3,
  REPORT: 4,
  ODD_QA: 5,
} as const;

export type AnalyzeProduct = "medoid" | "parameter-space-pairs" | "summary";

export type ProductRunState = {
  logs: string;
  logFile: string;
  error: string | null;
  total: number;
  completed: number;
};

export const EMPTY_PRODUCT_RUN: ProductRunState = {
  logs: "",
  logFile: "",
  error: null,
  total: 0,
  completed: 0,
};
