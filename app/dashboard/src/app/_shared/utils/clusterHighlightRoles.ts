import type {
  ClusterAnalysisContext,
  ClusterHighlightRole,
} from "@/app/batch/[id]/_tabs/explore/redux/slices/batch";
import { boundaryPairKey } from "@/app/_shared/utils/clusterAnalysisMatch";

/** Visual legend for cluster highlight roles (Parameter / Projection space). */
export const CLUSTER_HIGHLIGHT_STYLE: Record<
  ClusterHighlightRole,
  { label: string; color: string; shape: "circle" | "diamond" | "triangle" }
> = {
  medoid: { label: "Medoid", color: "#FFD54F", shape: "circle" },
  boundary: { label: "Closest pair", color: "#4DD0E1", shape: "diamond" },
  outlier: { label: "Outlier", color: "#FF7043", shape: "triangle" },
};

export function trialsForRole(
  ctx: ClusterAnalysisContext | null | undefined,
  role: ClusterHighlightRole,
): string[] {
  if (!ctx) return [];
  if (role === "medoid") {
    return Object.values(ctx.medoids ?? {});
  }
  if (role === "outlier") {
    return [...new Set(Object.values(ctx.outliers ?? {}))];
  }
  // One entry per unordered cluster pair (not unique trial count).
  const ids: string[] = [];
  for (const bp of ctx.boundaryPairs ?? []) {
    ids.push(String(bp.trial_a), String(bp.trial_b));
  }
  return [...new Set(ids)];
}

export function roleCount(
  ctx: ClusterAnalysisContext | null | undefined,
  role: ClusterHighlightRole,
): number {
  if (!ctx) return 0;
  if (role === "medoid") return Object.keys(ctx.medoids ?? {}).length;
  if (role === "outlier") return Object.keys(ctx.outliers ?? {}).length;
  return (ctx.boundaryPairs ?? []).length;
}

export function primaryRoleForTrial(
  ctx: ClusterAnalysisContext | null | undefined,
  trialId: string,
): ClusterHighlightRole | null {
  if (!ctx) return null;
  const id = String(trialId);
  if (Object.values(ctx.medoids ?? {}).includes(id)) return "medoid";
  const boundary = new Set<string>();
  for (const bp of ctx.boundaryPairs ?? []) {
    boundary.add(String(bp.trial_a));
    boundary.add(String(bp.trial_b));
  }
  for (const ids of Object.values(ctx.boundaryTrials ?? {})) {
    for (const t of ids) boundary.add(String(t));
  }
  if (boundary.has(id)) return "boundary";
  if (Object.values(ctx.outliers ?? {}).includes(id)) return "outlier";
  return null;
}

export function trialsFromHighlightSelection(
  ctx: ClusterAnalysisContext | null | undefined,
  selectedMedoidLabels: Set<string>,
  selectedPairKeys: Set<string>,
  selectedOutlierLabels: Set<string>,
): string[] {
  if (!ctx) return [];
  const ids = new Set<string>();

  for (const label of selectedMedoidLabels) {
    const tid = ctx.medoids?.[label];
    if (tid) ids.add(String(tid));
  }

  for (const bp of ctx.boundaryPairs ?? []) {
    const key = boundaryPairKey(bp.cluster_a, bp.cluster_b);
    if (!selectedPairKeys.has(key)) continue;
    ids.add(String(bp.trial_a));
    ids.add(String(bp.trial_b));
  }

  for (const label of selectedOutlierLabels) {
    const tid = ctx.outliers?.[label];
    if (tid) ids.add(String(tid));
  }

  return [...ids];
}
