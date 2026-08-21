import { kdTree } from "kd-tree-javascript";
import { Trial } from "@/app/_shared/graphql/queries/trials";

/**
 * Deterministic kNN boundary detection — mirrors the semantics implemented in
 * ``Controls/Filtering/index.tsx`` ("On Collision Boundary" / "On Cluster
 * Boundary" checkboxes) and the tree built in ``redux/slices/batch.ts``.
 *
 * This module does not build the tree itself — it reuses whatever
 * ``state.batch.tree[egoName]`` / ``state.batch.treePoints[egoName]`` already
 * built, so the distance metric (min-max normalized L2 over scenario
 * parameters) is guaranteed identical to what the Filtering UI highlights.
 *
 * Kept UI-agnostic on purpose: it is called from the Filtering "Export ODD
 * boundary" button, but takes no React/Redux types so it can be unit tested
 * or reused from a report/CLI context later.
 *
 * 2026-08-21 fix (see implementation_plan.md §2.2 "S2 bugfix pass"):
 *  - Parameter keys used to be the raw Payload parameter *id* (a Mongo
 *    ObjectId hash, e.g. "68b78058fc128b00506e6a54"). Now translated to the
 *    scenario's human parameter name (e.g. "OncomingSpeed") via
 *    ``paramNameById``, falling back to the raw id only if no name is known.
 *  - Collision-boundary now requires **both** trials to have a non-null
 *    cluster label, matching Filtering's own gate
 *    (`clusterChecked.has(currentLabel ?? "")`, which never contains ""). Not
 *    every trial fetched into Explore is part of the clustering fit (MFPCA
 *    requires a minimum trajectory duration) — those are now reported
 *    separately in ``n_trials_without_cluster_label`` instead of silently
 *    appearing in the export with `cluster_label: null`.
 */

export type TreePoint = {
  trial: Trial;
  parameters: { [key: string]: number };
};

export type BoundaryTrialRecord = {
  trial_id: string;
  parameters: Record<string, number>;
  passed: boolean | null;
  cluster_label: string | null;
  /** Neighbor trial ids (within kNN) that caused this trial to be flagged. */
  neighbor_ids: string[];
};

export type BoundaryEdge = {
  trial_a: string;
  trial_b: string;
  param_dist: number;
};

export type BoundarySide = {
  boundary_trials: BoundaryTrialRecord[];
  edges: BoundaryEdge[];
};

export type AllTrialRecord = {
  trial_id: string;
  parameters: Record<string, number>;
  passed: boolean | null;
  cluster_label: string | null;
};

export type BoundaryComputeResult = {
  kNN: number;
  n_trials_considered: number;
  /** Trials present in Explore but absent from the clustering fit (label is null). */
  n_trials_without_cluster_label: number;
  collision_boundary: BoundarySide;
  cluster_boundary: BoundarySide;
  /** Every trial with a tree point — input for S3 CART training (needs ALL trials, not just boundary ones). */
  all_trials: AllTrialRecord[];
};

function trialParams(
  point: TreePoint,
  paramNameById: Record<string, string>,
): Record<string, number> {
  const out: Record<string, number> = {};
  for (const [k, v] of Object.entries(point.parameters)) {
    if (k === "treeIndex" || k === "index") continue;
    out[paramNameById[k] ?? k] = v;
  }
  return out;
}

/**
 * Compute both boundary sets across ALL trials that have a tree point,
 * regardless of any UI cluster/pass-fail checkbox state. This is the
 * canonical export used for ``odd_boundary_export.json`` (S2) — a UI filter
 * subset would not be reproducible from the file alone.
 */
export function computeBoundaries(params: {
  treePoints: TreePoint[];
  tree: kdTree<{ [key: string]: number }>;
  kNN: number;
  /** Payload parameterId -> human scenario parameter name (batch.scenario.parameters). */
  paramNameById: Record<string, string>;
  /** trialId -> cluster label (string), same source as clusteringResult.data[id].label */
  labelByTrialId: (trialId: string) => string | null;
  /** trialId -> KPI passed (same criticalityMetrics lookup used by Filtering) */
  passedByTrialId: (trialId: string) => boolean | null;
}): BoundaryComputeResult {
  const {
    treePoints,
    tree,
    kNN,
    paramNameById,
    labelByTrialId,
    passedByTrialId,
  } = params;

  const collisionTrials = new Map<string, BoundaryTrialRecord>();
  const clusterTrials = new Map<string, BoundaryTrialRecord>();
  const collisionEdgeKeys = new Set<string>();
  const clusterEdgeKeys = new Set<string>();
  const collisionEdges: BoundaryEdge[] = [];
  const clusterEdges: BoundaryEdge[] = [];
  const allTrials: AllTrialRecord[] = [];
  let nWithoutLabel = 0;

  const edgeKey = (a: string, b: string) => (a < b ? `${a}|${b}` : `${b}|${a}`);

  for (const point of treePoints) {
    const trialId = String(point.trial?.id ?? "");
    if (!trialId) continue;

    const nearest = tree.nearest(point.parameters, kNN + 1);
    const currentLabel = labelByTrialId(trialId);
    const currentPassed = passedByTrialId(trialId);
    if (currentLabel == null) nWithoutLabel += 1;

    allTrials.push({
      trial_id: trialId,
      parameters: trialParams(point, paramNameById),
      passed: currentPassed,
      cluster_label: currentLabel,
    });

    const collisionNeighbors: string[] = [];
    const clusterNeighbors: string[] = [];

    for (const [node, dist] of nearest) {
      // Nodes only carry the parameter values used to build the tree (plus
      // ``treeIndex``), so we resolve the neighbor's original trial via that
      // index into ``treePoints`` — same lookup Filtering/index.tsx uses.
      const treeIndex = (node as Record<string, unknown>)?.["treeIndex"] as
        | number
        | undefined;
      const neighborPoint =
        treeIndex != null ? treePoints[treeIndex] : undefined;
      const neighborTrialId = String(neighborPoint?.trial?.id ?? "");
      if (!neighborTrialId || neighborTrialId === trialId) continue;

      const neighborLabel = labelByTrialId(neighborTrialId);
      const neighborPassed = passedByTrialId(neighborTrialId);

      // Matches Filtering's `clusterChecked["ITRI"].has(currentLabel ?? "")`
      // gate: a trial that was never part of the clustering fit (label ==
      // null) would never satisfy that check in the UI either, so it must
      // not appear as a collision-boundary hit here.
      if (
        currentLabel != null &&
        neighborLabel != null &&
        currentPassed !== null &&
        neighborPassed !== null &&
        currentPassed !== neighborPassed
      ) {
        collisionNeighbors.push(neighborTrialId);
        const key = edgeKey(trialId, neighborTrialId);
        if (!collisionEdgeKeys.has(key)) {
          collisionEdgeKeys.add(key);
          collisionEdges.push({
            trial_a: trialId,
            trial_b: neighborTrialId,
            param_dist: dist,
          });
        }
      }

      if (
        currentLabel != null &&
        neighborLabel != null &&
        currentLabel !== neighborLabel
      ) {
        clusterNeighbors.push(neighborTrialId);
        const key = edgeKey(trialId, neighborTrialId);
        if (!clusterEdgeKeys.has(key)) {
          clusterEdgeKeys.add(key);
          clusterEdges.push({
            trial_a: trialId,
            trial_b: neighborTrialId,
            param_dist: dist,
          });
        }
      }
    }

    if (collisionNeighbors.length > 0) {
      collisionTrials.set(trialId, {
        trial_id: trialId,
        parameters: trialParams(point, paramNameById),
        passed: currentPassed,
        cluster_label: currentLabel,
        neighbor_ids: [...new Set(collisionNeighbors)],
      });
    }
    if (clusterNeighbors.length > 0) {
      clusterTrials.set(trialId, {
        trial_id: trialId,
        parameters: trialParams(point, paramNameById),
        passed: currentPassed,
        cluster_label: currentLabel,
        neighbor_ids: [...new Set(clusterNeighbors)],
      });
    }
  }

  return {
    kNN,
    n_trials_considered: treePoints.length,
    n_trials_without_cluster_label: nWithoutLabel,
    collision_boundary: {
      boundary_trials: [...collisionTrials.values()],
      edges: collisionEdges,
    },
    cluster_boundary: {
      boundary_trials: [...clusterTrials.values()],
      edges: clusterEdges,
    },
    all_trials: allTrials,
  };
}
