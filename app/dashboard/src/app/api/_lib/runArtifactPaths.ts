/**
 * Run-level artifact layout.
 *
 * New writers use organized subfolders. Readers resolve the organized path
 * first and then the historical root path so older runs remain readable.
 */
import fs from "fs";
import path from "path";

const ARTIFACTS: Record<string, { directory: string; name: string }> = {
  selectionEval: {
    directory: path.join("cross_cluster", "input"),
    name: "cluster_selection_eval.json",
  },
  crossEval: {
    directory: path.join("cross_cluster", "output"),
    name: "cross_cluster_eval.json",
  },
  quality: { directory: path.join("analysis", "quality"), name: "clustering_quality.json" },
  splitSummary: { directory: path.join("analysis", "logs"), name: "split_analysis_summary.json" },
  oddAllTrials: {
    directory: path.join("analysis", "odd", "input"),
    name: "odd_all_trials.json",
  },
  oddBoundaryExport: {
    directory: path.join("analysis", "odd", "output"),
    name: "odd_boundary_export.json",
  },
  oddRules: {
    directory: path.join("analysis", "odd", "output"),
    name: "odd_parameter_rules.json",
  },
  oddJoin: {
    directory: path.join("analysis", "odd", "output"),
    name: "odd_boundary_pairs_join.json",
  },
  oddBriefing: {
    directory: path.join("analysis", "odd", "output"),
    name: "odd_chat_briefing.json",
  },
  paperSource: {
    directory: path.join("analysis", "metadata"),
    name: "PAPER_SOURCE.json",
  },
  oddChatLog: { directory: path.join("analysis", "logs"), name: "odd_chat_log.jsonl" },
};

const PREVIOUS_DIRECTORIES: Partial<Record<RunArtifact, string>> = {
  quality: "quality",
  splitSummary: "logs",
  oddAllTrials: path.join("odd", "input"),
  oddBoundaryExport: path.join("odd", "output"),
  oddRules: path.join("odd", "output"),
  oddJoin: path.join("odd", "output"),
  oddBriefing: path.join("odd", "output"),
  oddChatLog: "logs",
  paperSource: "metadata",
};

export type RunArtifact =
  | "selectionEval"
  | "crossEval"
  | "quality"
  | "splitSummary"
  | "oddAllTrials"
  | "oddBoundaryExport"
  | "oddRules"
  | "oddJoin"
  | "oddBriefing"
  | "paperSource"
  | "oddChatLog";

export function runSourceDir(runDir: string, options: { forWrite?: boolean } = {}): string {
  const legacy = path.join(runDir, "source");
  if (options.forWrite) return runDir;
  if (fs.existsSync(path.join(runDir, "manifest.json"))) return runDir;
  if (fs.existsSync(legacy) && fs.statSync(legacy).isDirectory()) return legacy;
  return runDir;
}

export function runSourcePath(
  runDir: string,
  parts: string[],
  options: { forWrite?: boolean } = {},
): string {
  const direct = path.join(runDir, ...parts);
  if (options.forWrite) return direct;
  if (fs.existsSync(direct)) return direct;
  const legacy = path.join(runDir, "source", ...parts);
  if (fs.existsSync(legacy)) return legacy;
  return direct;
}

export function runArtifactPath(
  runDir: string,
  artifact: RunArtifact,
  options: { forWrite?: boolean } = {},
): string {
  const spec = ARTIFACTS[artifact];
  const organized = path.join(runDir, spec.directory, spec.name);
  if (options.forWrite) return organized;

  if (fs.existsSync(organized)) return organized;
  const legacy = path.join(runDir, spec.name);
  if (fs.existsSync(legacy)) return legacy;
  const previousDirectory = PREVIOUS_DIRECTORIES[artifact];
  if (previousDirectory) {
    const previous = path.join(runDir, previousDirectory, spec.name);
    if (fs.existsSync(previous)) return previous;
  }
  return organized;
}

export function runOddSnapshotPath(
  runDir: string,
  knn: number,
  options: { forWrite?: boolean } = {},
): string {
  const name = `odd_boundary_export.kNN${knn}.json`;
  const organized = path.join(runDir, "analysis", "odd", "snapshots", name);
  if (options.forWrite) return organized;
  if (fs.existsSync(organized)) return organized;
  const legacy = path.join(runDir, name);
  if (fs.existsSync(legacy)) return legacy;
  const previous = path.join(runDir, "odd", "snapshots", name);
  if (fs.existsSync(previous)) return previous;
  return organized;
}
