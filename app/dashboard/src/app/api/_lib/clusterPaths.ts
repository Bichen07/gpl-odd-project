/**
 * Cluster pack path contract: nested raw/processed/output, with flat legacy fallback.
 *
 * Writers always use nested layout. Readers resolve nested first, then flat.
 */
import fs from "fs";
import path from "path";

type Kind = "raw" | "processed" | "output";

const ARTIFACTS: Record<string, { kind: Kind; name: string }> = {
  "trajectory.csv": { kind: "raw", name: "trajectory.csv" },
  "cluster.json": { kind: "raw", name: "cluster.json" },
  "action.yaml": { kind: "processed", name: "action.yaml" },
  "description.txt": { kind: "processed", name: "description.txt" },
  "context.md": { kind: "processed", name: "context.md" },
  "cluster_aggregate.json": { kind: "processed", name: "cluster_aggregate.json" },
  "map_overview.jpg": { kind: "processed", name: "map_overview.jpg" },
  "medoid_trial.yaml": { kind: "output", name: "medoid_trial.yaml" },
  "cluster_summary.yaml": { kind: "output", name: "cluster_summary.yaml" },
};

function kindDir(clusterDir: string, kind: Kind): string {
  return path.join(clusterDir, kind);
}

/** Resolve artifact: nested first, then flat under clusterDir. */
export function resolveClusterArtifact(
  clusterDir: string,
  artifact: string,
): string | null {
  if (artifact === "snapshots" || artifact === "snapshots/") {
    const nested = path.join(clusterDir, "processed", "snapshots");
    const legacy = path.join(clusterDir, "snapshots");
    if (fs.existsSync(nested) && fs.statSync(nested).isDirectory()) return nested;
    if (fs.existsSync(legacy) && fs.statSync(legacy).isDirectory()) return legacy;
    return null;
  }

  const spec = ARTIFACTS[artifact];
  if (spec) {
    const nested = path.join(kindDir(clusterDir, spec.kind), spec.name);
    const flat = path.join(clusterDir, spec.name);
    if (fs.existsSync(nested)) return nested;
    if (fs.existsSync(flat)) return flat;
    return null;
  }

  const nested = path.join(clusterDir, "processed", artifact);
  const flat = path.join(clusterDir, artifact);
  if (fs.existsSync(nested)) return nested;
  if (fs.existsSync(flat)) return flat;
  return null;
}

export function clusterArtifactExists(
  clusterDir: string,
  artifact: string,
): boolean {
  return resolveClusterArtifact(clusterDir, artifact) != null;
}

/**
 * Resolve aux highlight folder (outlier_trials / legacy boundary_cM).
 * Prefers ``highlight_trials/<name>``, then legacy ``clusterDir/<name>``.
 * MFPCA pairs now live under ``trajectory_projection_pairs/cA-cB/`` (see dataset_builder).
 */
export function resolveHighlightSubdir(
  clusterDir: string,
  folderName: string,
): string | null {
  const nested = path.join(clusterDir, "highlight_trials", folderName);
  const legacy = path.join(clusterDir, folderName);
  if (fs.existsSync(nested) && fs.statSync(nested).isDirectory()) return nested;
  if (fs.existsSync(legacy) && fs.statSync(legacy).isDirectory()) return legacy;
  return null;
}
