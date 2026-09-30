/** Keep aligned with app/analyzer/src/agent_labels.py `_LEGACY_NAME_ALIASES`. */
const LEGACY_NAME_ALIASES: Record<string, string> = {
  opposite: "Oncoming",
  oncoming: "Oncoming",
  parked: "Parking",
  parking: "Parking",
  cuttingin: "CuttingIn",
};

const DECIDED = new Set(["pass_first", "yield"]);

export function displayAgentName(name: unknown): string {
  const raw = String(name ?? "").trim();
  if (!raw) return "";
  return LEGACY_NAME_ALIASES[raw.toLowerCase()] ?? raw;
}

export type AgentInteractionRow = { agent: string; resolution: string };

/** One row per display name. Opposite and Oncoming are one vehicle. */
export function collapseAgentInteractions(
  rows: unknown,
  partner: unknown,
): AgentInteractionRow[] {
  const grouped = new Map<string, string>();
  const order: string[] = [];
  const rawIsDisplay = new Map<string, boolean>();
  const list = Array.isArray(rows) ? rows : [];
  for (const row of list) {
    if (row == null || typeof row !== "object") continue;
    const rec = row as { agent?: unknown; resolution?: unknown; interaction_resolution?: unknown };
    const raw = String(rec.agent ?? "").trim();
    if (!raw) continue;
    const shown = displayAgentName(raw);
    const res = String(rec.resolution ?? rec.interaction_resolution ?? "unresolved").trim() || "unresolved";
    if (!grouped.has(shown)) {
      grouped.set(shown, res);
      order.push(shown);
      rawIsDisplay.set(shown, raw === shown);
      continue;
    }
    const prev = grouped.get(shown) ?? "unresolved";
    const prevDecided = DECIDED.has(prev);
    const newDecided = DECIDED.has(res);
    const takeNew =
      (newDecided && !prevDecided) ||
      (newDecided === prevDecided && raw === shown && !rawIsDisplay.get(shown));
    if (takeNew) {
      grouped.set(shown, res);
      rawIsDisplay.set(shown, raw === shown);
    }
  }
  const shownPartner = displayAgentName(partner);
  const names =
    shownPartner && grouped.has(shownPartner)
      ? [shownPartner, ...order.filter((name) => name !== shownPartner)]
      : order;
  return names.map((name) => ({ agent: name, resolution: grouped.get(name) ?? "unresolved" }));
}
