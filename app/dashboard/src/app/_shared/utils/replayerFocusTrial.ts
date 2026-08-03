import type {
  ClusterAnalysisContext,
  ClusterHighlightRole,
} from "@/app/batch/[id]/_tabs/explore/redux/slices/batch";
import { CAPTION_ROLE_PRIORITY } from "@/app/_shared/utils/replayerCaption";

/**
 * Pick which ego the Replayer camera should follow.
 *
 * Priority:
 *   1. Explicit right-click trace for this cluster pane (or last global)
 *   2. Cluster medoid (split / cluster window)
 *   3. Highlight role ladder (medoid > emb boundary > IC boundary > outlier)
 *   4. First selected trial in this viewer
 *   5. First available trial
 */
export function resolveReplayerFocusTrial(args: {
  availableTrialIds: Iterable<string>;
  /** Per-cluster follow targets from right-click. */
  replayerTraceByCluster?: Record<string, string> | null;
  /** Last right-clicked trial (fallback for single / main pane). */
  replayerTraceTrialId: string | null | undefined;
  viewerClusterLabel: string | null | undefined;
  clusterAnalysis: ClusterAnalysisContext | null | undefined;
  selectedTrialIds: { by: string; value: string[] };
  highlightRolesByTrialId: Record<string, ClusterHighlightRole[]>;
}): string | null {
  const available = new Set(
    [...args.availableTrialIds].map(String).filter((id) => id !== ""),
  );
  if (available.size === 0) return null;

  const label =
    args.viewerClusterLabel != null &&
    args.viewerClusterLabel !== "main" &&
    args.viewerClusterLabel !== "pass" &&
    args.viewerClusterLabel !== "fail" &&
    args.viewerClusterLabel !== "head" &&
    args.viewerClusterLabel !== "tail"
      ? String(args.viewerClusterLabel)
      : null;

  const byCluster = args.replayerTraceByCluster ?? {};
  if (label != null && byCluster[label] != null) {
    const tid = String(byCluster[label]);
    if (available.has(tid)) return tid;
  }

  // Main / unclustered pane: prefer last right-click, else any per-cluster
  // target that is still drawn here.
  const last = args.replayerTraceTrialId
    ? String(args.replayerTraceTrialId)
    : null;
  if (last && available.has(last)) return last;
  for (const tid of Object.values(byCluster)) {
    if (available.has(String(tid))) return String(tid);
  }

  if (label && args.clusterAnalysis?.medoids) {
    const medoid = args.clusterAnalysis.medoids[label];
    if (medoid != null && available.has(String(medoid))) {
      return String(medoid);
    }
  }

  const selected = args.selectedTrialIds.value
    .map(String)
    .filter((id) => available.has(id));

  if (selected.length > 0) {
    if (args.selectedTrialIds.by === "highlight") {
      let bestId = selected[0];
      let bestPri = Number.POSITIVE_INFINITY;
      for (const id of selected) {
        const roles = args.highlightRolesByTrialId[id];
        let pri = CAPTION_ROLE_PRIORITY.trial;
        if (roles?.length) {
          for (const r of roles) {
            pri = Math.min(pri, CAPTION_ROLE_PRIORITY[r]);
          }
        }
        if (pri < bestPri) {
          bestPri = pri;
          bestId = id;
        }
      }
      return bestId;
    }
    return selected[0];
  }

  return [...available][0] ?? null;
}

/** Cluster label for a trial, or "main" when clustering is absent. */
export function clusterLabelForTrial(
  clusteringResult: {
    data?: Record<string, { label?: string | number | null } | undefined>;
  } | null | undefined,
  trialId: string,
): string {
  const data = clusteringResult?.data;
  if (data == null) return "main";
  const entry =
    data[trialId] ??
    data[String(trialId)] ??
    data[String(Number(trialId))];
  if (entry?.label == null) return "main";
  return String(entry.label);
}
