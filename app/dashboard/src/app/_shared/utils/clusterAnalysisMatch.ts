import type { ClusteringResult } from "@/app/_shared/graphql/queries/clustering";

/**
 * Returns true when every manifest medoid trial is assigned to the expected
 * cluster label in this clustering result. Used to distinguish configs that
 * share k + silhouette but differ in HDBSCAN parameters (e.g. epsilon 0 vs 0.3).
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
