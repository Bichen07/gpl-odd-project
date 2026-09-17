/**
 * Resolve on-disk results directory for a batch ego.
 *
 * Default ego ITRI → `results/batch{id}`
 * Other egos (e.g. ITRILatest) → `results/batch{id}_{egoName}`
 */
import fs from "fs";
import path from "path";

export function resultsBatchDirName(
  batchId: string | number,
  egoName?: string | null,
): string {
  const id = String(batchId);
  if (!egoName || egoName === "ITRI") {
    return `batch${id}`;
  }
  return `batch${id}_${egoName}`;
}

export function resultsBatchDir(
  projectRoot: string,
  batchId: string | number,
  egoName?: string | null,
): string {
  return path.join(projectRoot, "results", resultsBatchDirName(batchId, egoName));
}

/** Prefer ego-specific dir; fall back to plain batch{id} if missing. */
export function resolveResultsBatchDir(
  projectRoot: string,
  batchId: string | number,
  egoName?: string | null,
): string {
  const primary = resultsBatchDir(projectRoot, batchId, egoName);
  if (fs.existsSync(primary)) return primary;
  const fallback = resultsBatchDir(projectRoot, batchId, "ITRI");
  if (egoName && egoName !== "ITRI" && fs.existsSync(fallback)) {
    return fallback;
  }
  return primary;
}
