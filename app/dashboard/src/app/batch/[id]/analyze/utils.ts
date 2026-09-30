import { snapshotTimestamp } from "@/app/_shared/utils/snapshotSelection";
import { collapseAgentInteractions, displayAgentName } from "@/app/api/_lib/agentNames";
import type { AnalyzeProduct } from "./constants";
import type { EgoEvent } from "./types";

export function productFromSpec(productsSpec: string): AnalyzeProduct {
  const parts = productsSpec.split(",").map((s) => s.trim());
  if (parts.includes("parameter-space-pairs")) return "parameter-space-pairs";
  if (parts.includes("summary")) return "summary";
  return "medoid";
}

export function countProductCompletions(product: AnalyzeProduct, logs: string): number {
  if (product === "medoid") {
    return (logs.match(/✓ medoid_trial\.yaml/g) ?? []).length;
  }
  if (product === "parameter-space-pairs") {
    return (logs.match(/✓ c\d+-c\d+\/output\/contrast\.yaml/g) ?? []).length;
  }
  return (logs.match(/✓ cluster_summary\.yaml/g) ?? []).length;
}

// Shared typography for contrast-card narrative fields.
export const CONTRAST_FIELD_LABEL_SX = { fontSize: 20, fontWeight: 700 };
export const CONTRAST_FIELD_BODY_SX = { whiteSpace: "pre-wrap" as const, fontSize: 13, lineHeight: 1.7 };

export function snapshotLabel(name: string): string {
  return `t=${snapshotTimestamp(name)}s`;
}

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

export function riskColor(level?: unknown): "error" | "warning" | "success" | "default" {
  const l = String(level ?? "").toLowerCase();
  if (l === "high") return "error";
  if (l === "medium") return "warning";
  if (l === "low") return "success";
  return "default";
}

export function stringifyValue(v: unknown): string {
  if (Array.isArray(v)) return v.map((x) => String(x)).join(" – ");
  if (v && typeof v === "object") return JSON.stringify(v);
  return String(v);
}

/** Named-vehicle row uses the prose name. Opposite and Oncoming are one vehicle. */
export function agentInteractionRows(
  parsed: Record<string, unknown> | null | undefined,
): Record<string, unknown>[] {
  if (parsed == null) return [];
  const cm = parsed.conflict_metrics;
  const partner =
    cm && typeof cm === "object"
      ? (cm as { vehicle?: unknown; partner?: unknown }).vehicle ??
        (cm as { vehicle?: unknown; partner?: unknown }).partner
      : "";
  const collapsed = collapseAgentInteractions(parsed.agent_interactions, partner);
  if (collapsed.length > 0) return collapsed;
  const shown = displayAgentName(partner);
  if (shown) {
    return [
      {
        agent: shown,
        resolution: parsed.interaction_resolution,
      },
    ];
  }
  return [];
}

export function fmtNum(v: unknown, digits = 3): string {
  if (typeof v !== "number" || !Number.isFinite(v)) return "—";
  return v.toFixed(digits);
}
