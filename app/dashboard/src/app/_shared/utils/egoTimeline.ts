export type EgoEvent = { t: number | null; text: string };

export function normalizeEgoSummary(raw: unknown): EgoEvent[] {
  if (!Array.isArray(raw)) return [];
  return raw.map((e) => {
    if (e && typeof e === "object") {
      const o = e as Record<string, unknown>;
      const rawT = o.timestamp ?? o.time ?? o.t;
      const t =
        typeof rawT === "number"
          ? rawT
          : rawT != null && !Number.isNaN(Number(rawT))
            ? Number(rawT)
            : null;
      const text = String(o.description ?? o.text ?? o.summary ?? JSON.stringify(o));
      return { t, text };
    }
    const s = String(e);
    const m = s.match(/(\d+(?:\.\d+)?)/);
    return { t: m ? Number(m[1]) : null, text: s };
  });
}

export function getTimedEvents(raw: unknown): { t: number; text: string }[] {
  return normalizeEgoSummary(raw).filter(
    (e): e is { t: number; text: string } => e.t != null,
  );
}

export function getActiveEventAtTime(
  timed: { t: number; text: string }[],
  timeSec: number,
): { t: number; text: string } | null {
  if (timed.length === 0) return null;
  let cur: { t: number; text: string } | null = null;
  for (const e of timed) {
    // Only show an event once replay time has reached its timestamp.
    if (e.t <= timeSec + 1e-6) cur = e;
    else break;
  }
  return cur;
}
