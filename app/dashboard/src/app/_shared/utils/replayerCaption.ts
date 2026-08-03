import type {
  ClusterAnalysisContext,
  ClusterHighlightRole,
} from "@/app/batch/[id]/_tabs/explore/redux/slices/batch";

/** Lower = higher priority for the single caption box per cluster window. */
export const CAPTION_ROLE_PRIORITY: Record<
  ClusterHighlightRole | "trial",
  number
> = {
  medoid: 0,
  boundary: 1, // Closest pair (emb)
  param_boundary: 2, // Closest pair (IC)
  outlier: 3,
  trial: 4,
};

export type ReplayerCaptionRole = ClusterHighlightRole | "trial";

export type ReplayerClusterCaption = {
  label: string;
  /** Full title before " — t = …" */
  title: string;
  /** Trial whose trajectory drives velocity / accel */
  trialId: string;
  role: ReplayerCaptionRole;
  /**
   * Medoid LLM ego timeline only. Empty for pair / outlier / plain trial
   * so the box shows kinematics without event text.
   */
  summary: unknown;
  motiveSummary: string | null;
};

function clusterName(
  ctx: ClusterAnalysisContext | null | undefined,
  clusterLabel: string,
): string | null {
  const name = ctx?.interpretations?.[clusterLabel]?.cluster_label;
  return typeof name === "string" && name.trim() ? name.trim() : null;
}

function baseClusterTitle(
  clusterLabel: string,
  name: string | null,
): string {
  return name
    ? `Cluster ${clusterLabel}: ${name}`
    : `Cluster ${clusterLabel}`;
}

function pairOtherCluster(
  clusterLabel: string,
  trialId: string,
  pairs: Array<{
    cluster_a: number | string;
    trial_a: string;
    cluster_b: number | string;
    trial_b: string;
  }>,
): string | null {
  const label = String(clusterLabel);
  const tid = String(trialId);
  for (const bp of pairs) {
    const a = String(bp.cluster_a);
    const b = String(bp.cluster_b);
    if (String(bp.trial_a) === tid && a === label) return b;
    if (String(bp.trial_b) === tid && b === label) return a;
  }
  return null;
}

function primaryRole(
  roles: ClusterHighlightRole[] | undefined,
): ClusterHighlightRole | "trial" {
  if (!roles?.length) return "trial";
  let best: ClusterHighlightRole = roles[0];
  for (const r of roles) {
    if (CAPTION_ROLE_PRIORITY[r] < CAPTION_ROLE_PRIORITY[best]) best = r;
  }
  return best;
}

function buildTitle(
  clusterLabel: string,
  name: string | null,
  role: ReplayerCaptionRole,
  trialId: string,
  ctx: ClusterAnalysisContext | null | undefined,
): string {
  const base = baseClusterTitle(clusterLabel, name);
  if (role === "medoid") return base;
  if (role === "boundary") {
    const other = pairOtherCluster(
      clusterLabel,
      trialId,
      ctx?.boundaryPairs ?? [],
    );
    return other != null
      ? `${base}, Closest pair c${clusterLabel} to c${other}`
      : `${base}, Closest pair (emb)`;
  }
  if (role === "param_boundary") {
    const other = pairOtherCluster(
      clusterLabel,
      trialId,
      ctx?.paramBoundaryPairs ?? [],
    );
    return other != null
      ? `${base}, Closest pair (IC) c${clusterLabel} to c${other}`
      : `${base}, Closest pair (IC)`;
  }
  if (role === "outlier") {
    return `${base}, Outlier`;
  }
  return `${base}, trial ${trialId}`;
}

/**
 * Pick one caption per cluster window.
 *
 * Priority (if several selected trials fall in this cluster):
 *   medoid > Closest pair (emb) > Closest pair (IC) > Outlier > other trial
 *
 * - Highlight mode: only trials with roles (or in selection) for this cluster.
 * - Non-highlight multi-select: first selected trial that belongs to this cluster.
 * - Event / motive text only for medoid (LLM summary).
 */
export function resolveReplayerClusterCaption(args: {
  clusterLabel: string;
  ctx: ClusterAnalysisContext | null | undefined;
  selectedTrialIds: { by: string; value: string[] };
  highlightRolesByTrialId: Record<string, ClusterHighlightRole[]>;
  /** trialId → cluster label from clusteringResult */
  trialClusterLabel: (trialId: string) => string | null;
}): ReplayerClusterCaption | null {
  const {
    clusterLabel,
    ctx,
    selectedTrialIds,
    highlightRolesByTrialId,
    trialClusterLabel,
  } = args;

  if (selectedTrialIds.value.length === 0) return null;

  type Candidate = {
    trialId: string;
    role: ReplayerCaptionRole;
    /** Stable order among equal priority: earlier in selection wins */
    selectIndex: number;
  };

  const candidates: Candidate[] = [];
  for (let i = 0; i < selectedTrialIds.value.length; i++) {
    const trialId = String(selectedTrialIds.value[i]);
    const membership = trialClusterLabel(trialId);
    if (membership == null || String(membership) !== String(clusterLabel)) {
      continue;
    }

    if (selectedTrialIds.by === "highlight") {
      const role = primaryRole(highlightRolesByTrialId[trialId]);
      candidates.push({ trialId, role, selectIndex: i });
    } else {
      candidates.push({ trialId, role: "trial", selectIndex: i });
    }
  }

  if (candidates.length === 0) return null;

  candidates.sort((a, b) => {
    const pd =
      CAPTION_ROLE_PRIORITY[a.role] - CAPTION_ROLE_PRIORITY[b.role];
    if (pd !== 0) return pd;
    return a.selectIndex - b.selectIndex;
  });

  const winner = candidates[0];
  const name = clusterName(ctx, clusterLabel);
  const title = buildTitle(
    clusterLabel,
    name,
    winner.role,
    winner.trialId,
    ctx,
  );

  const interp = ctx?.interpretations?.[clusterLabel];
  const isMedoid = winner.role === "medoid";

  return {
    label: clusterLabel,
    title,
    trialId: winner.trialId,
    role: winner.role,
    summary: isMedoid ? (interp?.ego_perspective_summary ?? []) : [],
    motiveSummary:
      isMedoid &&
      typeof interp?.motive_summary === "string" &&
      interp.motive_summary.trim()
        ? interp.motive_summary
        : null,
  };
}
