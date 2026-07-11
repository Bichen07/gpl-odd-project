import type { ClusteringResult, ClusteringTask } from "@/app/_shared/graphql/queries/clustering";

/**
 * Returns true when every manifest medoid trial is assigned to the expected
 * cluster label in this clustering result.
 */
export function clusteringMatchesManifestMedoids(
  result: ClusteringResult,
  manifestMedoids: Record<string, string>,
): boolean {
  const entries = Object.entries(manifestMedoids);
  if (entries.length === 0) return false;
  return entries.every(([label, trialId]) => {
    const item = result.data?.[trialId];
    return item != null && String(item.label) === String(label);
  });
}

function numEq(a: unknown, b: unknown): boolean {
  const na = Number(a);
  const nb = Number(b);
  if (Number.isNaN(na) && Number.isNaN(nb)) return true;
  if (Number.isNaN(na) || Number.isNaN(nb)) return false;
  return Math.abs(na - nb) < 1e-9;
}

/**
 * Match a dashboard clustering candidate to a saved results folder.
 * Medoid labels alone are not enough: many HDBSCAN epsilon variants share the
 * same silhouette / medoid placement. Prefer the task params written to
 * ``clustering/selectedClusteringResult.json``.
 */
export function clusteringMatchesSavedResult(
  result: ClusteringResult,
  manifestMedoids: Record<string, string>,
  savedTask?: ClusteringTask | null,
  requestTask?: ClusteringTask | null,
): boolean {
  if (!clusteringMatchesManifestMedoids(result, manifestMedoids)) {
    return false;
  }

  const candidate = result.task ?? requestTask ?? null;
  if (savedTask == null || candidate == null) {
    // Legacy folders without a saved task: medoid match only (ambiguous).
    return true;
  }

  return (
    numEq(savedTask.minClusterSize, candidate.minClusterSize) &&
    numEq(savedTask.minSamples, candidate.minSamples) &&
    numEq(
      savedTask.clusterSelectionEpsilon,
      candidate.clusterSelectionEpsilon,
    ) &&
    String(savedTask.clusterSelectionMethod ?? "eom") ===
      String(candidate.clusterSelectionMethod ?? "eom") &&
    String(savedTask.method ?? "") === String(candidate.method ?? "")
  );
}

/** Stable pair key with lower label first: "0-1". */
export function boundaryPairKey(
  clusterA: number | string,
  clusterB: number | string,
): string {
  const a = Number(clusterA);
  const b = Number(clusterB);
  return a <= b ? `${a}-${b}` : `${b}-${a}`;
}

export function formatBoundaryPairLabel(key: string): string {
  const [a, b] = key.split("-");
  return `c${a}-c${b}`;
}
