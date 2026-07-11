import type {
  ClusterAnalysisContext,
  ClusterHighlightRole,
} from "@/app/batch/[id]/_tabs/explore/redux/slices/batch";
import { boundaryPairKey } from "@/app/_shared/utils/clusterAnalysisMatch";

/** Visual legend for cluster highlight roles (Parameter / Projection space). */
export const CLUSTER_HIGHLIGHT_STYLE: Record<
  ClusterHighlightRole,
  {
    label: string;
    color: string;
    shape: "circle" | "diamond" | "square" | "triangle";
  }
> = {
  medoid: { label: "Medoid", color: "#FFD54F", shape: "circle" },
  boundary: { label: "Closest pair (emb)", color: "#4DD0E1", shape: "diamond" },
  param_boundary: {
    label: "Closest pair (IC)",
    color: "#81C784",
    shape: "square",
  },
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
  if (role === "param_boundary") {
    const ids: string[] = [];
    for (const bp of ctx.paramBoundaryPairs ?? []) {
      ids.push(String(bp.trial_a), String(bp.trial_b));
    }
    return [...new Set(ids)];
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
  if (role === "param_boundary") return (ctx.paramBoundaryPairs ?? []).length;
  return (ctx.boundaryPairs ?? []).length;
}

export function primaryRoleForTrial(
  ctx: ClusterAnalysisContext | null | undefined,
  trialId: string,
): ClusterHighlightRole | null {
  if (!ctx) return null;
  const id = String(trialId);
  if (Object.values(ctx.medoids ?? {}).includes(id)) return "medoid";
  const embBoundary = new Set<string>();
  for (const bp of ctx.boundaryPairs ?? []) {
    embBoundary.add(String(bp.trial_a));
    embBoundary.add(String(bp.trial_b));
  }
  for (const ids of Object.values(ctx.boundaryTrials ?? {})) {
    for (const t of ids) embBoundary.add(String(t));
  }
  if (embBoundary.has(id)) return "boundary";
  const paramBoundary = new Set<string>();
  for (const bp of ctx.paramBoundaryPairs ?? []) {
    paramBoundary.add(String(bp.trial_a));
    paramBoundary.add(String(bp.trial_b));
  }
  for (const ids of Object.values(ctx.paramBoundaryTrials ?? {})) {
    for (const t of ids) paramBoundary.add(String(t));
  }
  if (paramBoundary.has(id)) return "param_boundary";
  if (Object.values(ctx.outliers ?? {}).includes(id)) return "outlier";
  return null;
}

/** Roles keyed by trial from the user's highlight picks (not cluster membership). */
export function rolesFromHighlightSelection(
  ctx: ClusterAnalysisContext | null | undefined,
  selectedMedoidLabels: Set<string>,
  selectedPairKeys: Set<string>,
  selectedParamPairKeys: Set<string>,
  selectedOutlierLabels: Set<string>,
): Record<string, ClusterHighlightRole[]> {
  if (!ctx) return {};
  const map: Record<string, ClusterHighlightRole[]> = {};
  const add = (trialId: string, role: ClusterHighlightRole) => {
    const id = String(trialId);
    if (!map[id]) map[id] = [];
    if (!map[id].includes(role)) map[id].push(role);
  };

  for (const label of selectedMedoidLabels) {
    const tid = ctx.medoids?.[label];
    if (tid) add(tid, "medoid");
  }

  for (const bp of ctx.boundaryPairs ?? []) {
    const key = boundaryPairKey(bp.cluster_a, bp.cluster_b);
    if (!selectedPairKeys.has(key)) continue;
    add(String(bp.trial_a), "boundary");
    add(String(bp.trial_b), "boundary");
  }

  for (const bp of ctx.paramBoundaryPairs ?? []) {
    const key = boundaryPairKey(bp.cluster_a, bp.cluster_b);
    if (!selectedParamPairKeys.has(key)) continue;
    add(String(bp.trial_a), "param_boundary");
    add(String(bp.trial_b), "param_boundary");
  }

  for (const label of selectedOutlierLabels) {
    const tid = ctx.outliers?.[label];
    if (tid) add(tid, "outlier");
  }

  return map;
}

export function trialsFromHighlightSelection(
  ctx: ClusterAnalysisContext | null | undefined,
  selectedMedoidLabels: Set<string>,
  selectedPairKeys: Set<string>,
  selectedParamPairKeys: Set<string>,
  selectedOutlierLabels: Set<string>,
): string[] {
  return Object.keys(
    rolesFromHighlightSelection(
      ctx,
      selectedMedoidLabels,
      selectedPairKeys,
      selectedParamPairKeys,
      selectedOutlierLabels,
    ),
  );
}
