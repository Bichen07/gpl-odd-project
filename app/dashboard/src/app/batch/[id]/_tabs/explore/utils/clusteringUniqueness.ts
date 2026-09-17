/**
 * Clustering uniqueness — parity with analyzer clustering_uniqueness.py / PerEgoSelection.
 * algorithm: perEgoSelection-v2 (same-k only; v1 could collapse k=4 into earlier k=2/3)
 */

import type { ClusteringResult } from "@/app/_shared/graphql/queries/clustering";

export const UNIQUENESS_ALGORITHM = "perEgoSelection-v2";
export const DEFAULT_DUPLICATED_FILTER_RATIO = 0.005;
/** Default max non-noise clusters shown / uniqueness-scanned unless user opts in. */
export const DEFAULT_MAX_CLUSTER_COUNT = 8;

export type UniquenessMeta = {
  duplicatedFilterRatio: number;
  algorithm: string;
  /** When set, uniqueResultIndices only cover candidates with k ≤ this value. */
  maxClusterCount?: number | null;
};

export type UniquenessResult = {
  uniqueResultIndices: number[];
  noiseRatioByIndex: { [index: string]: number };
  uniquenessMeta: UniquenessMeta;
};

/** Non-noise cluster count from result.data (does not need Redux clusterInfos). */
export function clusterCountFromResult(
  result: ClusteringResult | null | undefined,
): number {
  if (result?.data == null) return 0;
  const labels = new Set<string>();
  for (const item of Object.values(result.data)) {
    if (item?.label == null) continue;
    const label = String(item.label);
    if (label === "-1") continue;
    labels.add(label);
  }
  return labels.size;
}

/**
 * Prefer a clustering with 2 ≤ k ≤ maxK (default 8) so Heatmap/Replayer do not
 * open ~20 cluster windows on load.
 */
export function pickPreferredClustering(
  clustering: Array<ClusteringResult | null | undefined>,
  maxK: number = DEFAULT_MAX_CLUSTER_COUNT,
): { result: ClusteringResult | null; index: number } {
  let best: { result: ClusteringResult; index: number; k: number } | null =
    null;
  for (let i = 0; i < clustering.length; i++) {
    const r = clustering[i];
    if (r == null) continue;
    const k = clusterCountFromResult(r);
    if (k < 2 || k > maxK) continue;
    if (best == null || k < best.k) {
      best = { result: r, index: i, k };
    }
  }
  if (best != null) return { result: best.result, index: best.index };

  for (let i = 0; i < clustering.length; i++) {
    const r = clustering[i];
    if (r == null) continue;
    const k = clusterCountFromResult(r);
    if (k >= 1 && k <= maxK) return { result: r, index: i };
  }

  const idx = clustering.findIndex((r) => r != null);
  return {
    result: idx >= 0 ? (clustering[idx] as ClusteringResult) : null,
    index: idx,
  };
}

function labelToTrials(
  result: ClusteringResult,
): { [label: string]: Set<string> } {
  const mapping: { [label: string]: Set<string> } = {};
  for (const [trialId, item] of Object.entries(result.data ?? {})) {
    if (item == null) continue;
    const label = String(item.label);
    if (!(label in mapping)) {
      mapping[label] = new Set<string>();
    }
    mapping[label].add(String(trialId));
  }
  return mapping;
}

/**
 * Same nested set-diff uniqueness as PerEgoSelection.
 * Pass null slots (or null-out high-k rows) to skip candidates while keeping indices.
 */
export function computeClusteringUniqueness(
  clustering: Array<ClusteringResult | null | undefined>,
  trialOrderLen: number,
  duplicatedFilterRatio: number = DEFAULT_DUPLICATED_FILTER_RATIO,
  rankForIndex?: (result: ClusteringResult, index: number) => number,
  maxClusterCount?: number | null,
): UniquenessResult {
  const n = trialOrderLen > 0 ? trialOrderLen : 1;
  const rankFn = rankForIndex ?? ((_r: ClusteringResult, _i: number) => 0);

  const noiseRatioByIndex: { [index: string]: number } = {};
  const uniqueMappings: {
    [index: number]: { [label: string]: Set<string> };
  } = {};

  for (const [i, result] of clustering.entries()) {
    if (result == null) continue;

    const k = clusterCountFromResult(result);
    if (
      maxClusterCount != null &&
      maxClusterCount > 0 &&
      k > maxClusterCount
    ) {
      continue;
    }

    const mapping = labelToTrials(result);
    noiseRatioByIndex[String(i)] =
      "-1" in mapping ? mapping["-1"].size / n : 0;

    let foundDuplicated = false;
    let duplicateOf: number | null = null;
    const candK = Object.keys(mapping).filter((l) => l !== "-1").length;

    for (const [uniqueIndexStr, unique] of Object.entries(uniqueMappings)) {
      // Only compare against the same non-noise cluster count. Otherwise a
      // refined k=4 partition can be treated as a "duplicate" of an earlier
      // k=2/3 unique (greedy diffs only walk the unique's labels), wiping
      // Cluster Counts: 4 from the list.
      const uniqK = Object.keys(unique).filter((l) => l !== "-1").length;
      if (uniqK !== candK) continue;

      let differentCounts = 0;
      const visited = new Set<string>();
      for (const [, setU] of Object.entries(unique)) {
        let minSetDifferenceCounts = Infinity;
        let minSetDifferenceLabel: string | null = null;
        for (const [label2, set2] of Object.entries(mapping)) {
          if (visited.has(label2)) continue;
          const setDifferenceCounts = setU.difference(set2).size;
          if (setDifferenceCounts < minSetDifferenceCounts) {
            minSetDifferenceCounts = setDifferenceCounts;
            minSetDifferenceLabel = label2;
          }
        }
        if (minSetDifferenceLabel) {
          visited.add(minSetDifferenceLabel);
        }
        if (minSetDifferenceCounts === Infinity) {
          minSetDifferenceCounts = 0;
        }
        differentCounts += minSetDifferenceCounts;
      }
      const differentRatio = differentCounts / n;
      if (differentRatio < duplicatedFilterRatio) {
        foundDuplicated = true;
        duplicateOf = Number(uniqueIndexStr);
      }
      if (foundDuplicated) break;
    }

    if (foundDuplicated && duplicateOf != null) {
      const curRank = rankFn(result, i);
      const dup = clustering[duplicateOf];
      const dupRank = dup != null ? rankFn(dup, duplicateOf) : 0;
      if (curRank > dupRank) {
        delete uniqueMappings[duplicateOf];
        uniqueMappings[i] = mapping;
      }
      continue;
    }
    if (foundDuplicated) continue;

    uniqueMappings[i] = mapping;
  }

  return {
    uniqueResultIndices: Object.keys(uniqueMappings).map((k) => Number(k)),
    noiseRatioByIndex,
    uniquenessMeta: {
      duplicatedFilterRatio,
      algorithm: UNIQUENESS_ALGORITHM,
      maxClusterCount: maxClusterCount ?? null,
    },
  };
}

/** True when save/API mfpca uniqueness can be used for the current UI settings. */
export function canUsePrecomputedUniqueness(
  mfpca: {
    uniqueResultIndices?: number[];
    uniquenessMeta?: UniquenessMeta;
    noiseRatioByIndex?: { [index: string]: number };
  } | null | undefined,
  duplicatedFilterRatio: number,
  opts?: { includeHighK?: boolean },
): boolean {
  if (mfpca?.uniqueResultIndices == null || mfpca.uniquenessMeta == null) {
    return false;
  }
  if (mfpca.uniquenessMeta.algorithm !== UNIQUENESS_ALGORITHM) {
    return false;
  }
  if (mfpca.uniquenessMeta.duplicatedFilterRatio !== duplicatedFilterRatio) {
    return false;
  }
  // Precompute capped at k≤8 cannot serve "Show k > 8" mode.
  if (opts?.includeHighK) {
    const capped = mfpca.uniquenessMeta.maxClusterCount;
    if (capped != null && capped > 0) return false;
  }
  return true;
}

/**
 * Ensure uniqueness fields exist. By default only scans k ≤ 8 (fast path for
 * paper saves with ~488 × thousands of trials). Mutates in place.
 * Returns whether any mfpca mode was recomputed (for auto-save of derivatives).
 */
export function ensureTrajectoryAnalysisUniqueness<T extends Record<string, any>>(
  trajectoryAnalysis: T,
  duplicatedFilterRatio: number = DEFAULT_DUPLICATED_FILTER_RATIO,
  options?: { maxClusterCount?: number | null; force?: boolean },
): { analysis: T; didCompute: boolean } {
  const maxClusterCount =
    options?.maxClusterCount === undefined
      ? DEFAULT_MAX_CLUSTER_COUNT
      : options.maxClusterCount;
  const force = options?.force === true;
  let didCompute = false;

  for (const egoData of Object.values(trajectoryAnalysis ?? {})) {
    if (egoData == null || typeof egoData !== "object") continue;
    const mfpcaRoot = (egoData as any).mfpca;
    if (mfpcaRoot == null || typeof mfpcaRoot !== "object") continue;
    for (const mode of Object.keys(mfpcaRoot)) {
      const mfpca = mfpcaRoot[mode];
      if (mfpca == null || !Array.isArray(mfpca.clustering)) continue;
      if (
        !force &&
        canUsePrecomputedUniqueness(mfpca, duplicatedFilterRatio, {
          includeHighK: maxClusterCount == null,
        }) &&
        mfpca.noiseRatioByIndex != null &&
        (maxClusterCount == null ||
          mfpca.uniquenessMeta?.maxClusterCount === maxClusterCount ||
          mfpca.uniquenessMeta?.maxClusterCount == null)
      ) {
        // If existing precompute has no max cap but we want k≤8, still usable
        // (filter indices client-side). If missing entirely, compute below.
        if (mfpca.uniqueResultIndices != null) continue;
      }
      if (
        !force &&
        mfpca.uniqueResultIndices != null &&
        mfpca.uniquenessMeta?.algorithm === UNIQUENESS_ALGORITHM &&
        mfpca.uniquenessMeta?.duplicatedFilterRatio === duplicatedFilterRatio
      ) {
        // Already has uniqueness (possibly uncapped). Keep it.
        continue;
      }

      const trialOrderLen = Array.isArray(mfpca.trialOrder)
        ? mfpca.trialOrder.length
        : 0;
      const computed = computeClusteringUniqueness(
        mfpca.clustering,
        trialOrderLen,
        duplicatedFilterRatio,
        undefined,
        maxClusterCount,
      );
      mfpca.uniqueResultIndices = computed.uniqueResultIndices;
      mfpca.noiseRatioByIndex = {
        ...(mfpca.noiseRatioByIndex ?? {}),
        ...computed.noiseRatioByIndex,
      };
      mfpca.uniquenessMeta = computed.uniquenessMeta;
      didCompute = true;
    }
  }
  return { analysis: trajectoryAnalysis, didCompute };
}

/** Filename for the uniqueness-enhanced sibling of a raw paper/analysis zip. */
export const UNIQUENESS_SAVE_SUFFIX = ".with-uniqueness";

export function uniquenessDerivativeFilename(
  sourceFilename: string | null | undefined,
): string {
  const raw = (sourceFilename ?? "analysis").trim() || "analysis";
  const base = raw.replace(/\.zip$/i, "").replace(/\.json$/i, "");
  if (base.endsWith(UNIQUENESS_SAVE_SUFFIX)) {
    return `${base}.zip`;
  }
  return `${base}${UNIQUENESS_SAVE_SUFFIX}.zip`;
}

export function isUniquenessDerivativeFilename(
  filename: string | null | undefined,
): boolean {
  if (filename == null) return false;
  return filename.replace(/\.zip$/i, "").endsWith(UNIQUENESS_SAVE_SUFFIX);
}
