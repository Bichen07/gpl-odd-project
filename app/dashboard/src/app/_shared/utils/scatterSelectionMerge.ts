/**
 * Merge / toggle helpers for Parameter + Projection scatterplots.
 * Plain left-click and left-drag always behave like the former Ctrl+ variants.
 */

export function mergeToggleTrialIds(args: {
  currentIds: string[];
  reportedIds: string[];
  /** Role trials that must stay selected while Highlight mode is active. */
  lockedRoleIds?: string[];
}): string[] {
  const locked = new Set((args.lockedRoleIds ?? []).map(String));
  const next = new Set(args.currentIds.map(String));
  for (const id of locked) next.add(id);

  const reported = args.reportedIds.map(String).filter((id) => id !== "");

  if (reported.length === 1) {
    const id = reported[0];
    if (locked.has(id)) {
      // Medoid / pair / outlier roles stay until background clear or chip toggle.
      return [...next];
    }
    if (next.has(id)) next.delete(id);
    else next.add(id);
    return [...next];
  }

  // Lasso / multi: union (same as former Ctrl+lasso).
  for (const id of reported) next.add(id);
  return [...next];
}
