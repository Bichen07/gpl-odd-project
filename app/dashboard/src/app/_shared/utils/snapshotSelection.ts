/** Default BEV snapshot picks for LLM cluster analysis. */

const CONFLICT_FILENAME_RE = /NEAR_MISS|COLLISION|CLOSEST_APPROACH/i;

export function snapshotTimestamp(name: string): number {
  const m = name.match(/_t_(\d+(?:\.\d+)?)/i);
  return m ? parseFloat(m[1]) : 0;
}

export function evenlySpacedSnapshots(items: string[], n: number): string[] {
  if (n <= 0 || items.length === 0) return [];
  if (items.length <= n) return [...items];
  if (n === 1) return [items[0]];
  const out: string[] = [];
  for (let i = 0; i < n; i += 1) {
    out.push(items[Math.round((i * (items.length - 1)) / (n - 1))]);
  }
  return Array.from(new Set(out));
}

function collisionTimeFromMedoid(medoid?: Record<string, unknown> | null): number | null {
  const collision = medoid?.collision;
  if (!collision || typeof collision !== "object") return null;
  const t = (collision as { time_s?: unknown }).time_s;
  if (typeof t === "number" && !Number.isNaN(t)) return t;
  if (t != null && !Number.isNaN(Number(t))) return Number(t);
  return null;
}

function findAnchorIndices(
  sorted: string[],
  medoid?: Record<string, unknown> | null,
): Set<number> {
  const anchors = new Set<number>();

  sorted.forEach((name, idx) => {
    if (CONFLICT_FILENAME_RE.test(name)) anchors.add(idx);
  });

  const collisionT = collisionTimeFromMedoid(medoid);
  if (collisionT != null) {
    let bestIdx = 0;
    let bestDiff = Infinity;
    sorted.forEach((name, idx) => {
      const diff = Math.abs(snapshotTimestamp(name) - collisionT);
      if (diff < bestDiff) {
        bestDiff = diff;
        bestIdx = idx;
      }
    });
    anchors.add(bestIdx);
  }

  return anchors;
}

function windowIndices(anchor: number, neighbors: number, length: number): number[] {
  const out: number[] = [];
  for (let d = -neighbors; d <= neighbors; d += 1) {
    const idx = anchor + d;
    if (idx >= 0 && idx < length) out.push(idx);
  }
  return out;
}

function trimToTotal(sorted: string[], chosen: Set<string>, total: number): string[] {
  const list = sorted.filter((s) => chosen.has(s));
  if (list.length <= total) return list;

  const mustKeep = list.filter((s) => CONFLICT_FILENAME_RE.test(s));
  const rest = list.filter((s) => !CONFLICT_FILENAME_RE.test(s));
  const slots = total - mustKeep.length;
  if (slots <= 0) {
    return sorted.filter((s) => mustKeep.slice(0, total).includes(s));
  }
  const picked = new Set(evenlySpacedSnapshots(rest, slots));
  return sorted.filter((s) => mustKeep.includes(s) || picked.has(s));
}

function fillToTotal(sorted: string[], chosen: Set<string>, total: number): string[] {
  if (chosen.size >= total) return trimToTotal(sorted, chosen, total);

  const remaining = sorted.filter((s) => !chosen.has(s));
  const need = total - chosen.size;
  for (const name of evenlySpacedSnapshots(remaining, need)) {
    chosen.add(name);
  }
  return sorted.filter((s) => chosen.has(s));
}

function buildConflictWindowSelection(
  sorted: string[],
  medoid: Record<string, unknown> | null | undefined,
  neighborsEachSide: number,
): string[] {
  const anchors = findAnchorIndices(sorted, medoid);
  if (anchors.size === 0) return [];

  const indices = new Set<number>();
  for (const anchor of anchors) {
    for (const idx of windowIndices(anchor, neighborsEachSide, sorted.length)) {
      indices.add(idx);
    }
  }
  return sorted.filter((_, idx) => indices.has(idx));
}

/**
 * Pick ``total`` snapshots for the LLM: windows around NEAR_MISS / COLLISION
 * frames (±``neighborsEachSide``), then fill the rest evenly across the timeline.
 */
export function selectDefaultSnapshots(
  snapshots: string[],
  total: number = 10,
  medoid?: Record<string, unknown> | null,
  neighborsEachSide: number = 2,
): string[] {
  if (total <= 0 || snapshots.length === 0) return [];
  const sorted = [...snapshots].sort(
    (a, b) => snapshotTimestamp(a) - snapshotTimestamp(b),
  );
  if (sorted.length <= total) return sorted;

  let neighbors = neighborsEachSide;
  while (neighbors >= 0) {
    const windowed = buildConflictWindowSelection(sorted, medoid, neighbors);
    if (windowed.length > 0) {
      const chosen = new Set(windowed);
      const filled = fillToTotal(sorted, chosen, total);
      if (filled.length <= total || neighbors === 0) {
        return filled.slice(0, total);
      }
    }
    neighbors -= 1;
  }

  return evenlySpacedSnapshots(sorted, total);
}
