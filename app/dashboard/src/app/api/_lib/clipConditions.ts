/**
 * Analysis-stage clip from app/analyzer/config/clip_conditions.yaml.
 * Must stay behaviorally aligned with app/analyzer/src/clip_conditions.py.
 */
import fs from "fs";
import path from "path";
import YAML from "yaml";

function findProjectRoot(start: string): string {
  let current = start;
  for (let i = 0; i < 8; i++) {
    if (path.basename(current) === "gpl-odd-project") return current;
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  return path.resolve(start, "..", "..");
}

export type ClipProfile = {
  type?: string;
  road_id?: number;
  s?: number;
  s_tol?: number;
  xy_tol_m?: number;
  frame_offset_s?: number;
  x?: number;
  y?: number;
  fallback_x?: number;
  fallback_y?: number;
  fallback_xy_tol_m?: number;
  description?: string;
  _profile_name?: string;
  _map_id?: string;
};

export type ClipConfig = {
  active?: string;
  profiles?: Record<string, ClipProfile>;
  map_overrides?: Record<string, Partial<ClipProfile>>;
  batch_overrides?: Record<
    string,
    Partial<ClipProfile> | Record<string, Partial<ClipProfile>>
  >;
  batch_map_defaults?: Record<string, string>;
};

export function clipConfigPath(projectRoot: string): string {
  return path.join(
    projectRoot,
    "app",
    "analyzer",
    "config",
    "clip_conditions.yaml",
  );
}

export function loadClipConfig(projectRoot?: string): ClipConfig {
  const root = projectRoot ?? findProjectRoot(process.cwd());
  const p = clipConfigPath(root);
  const raw = fs.readFileSync(p, "utf-8");
  return (YAML.parse(raw) as ClipConfig) ?? {};
}

export function mapIdFromOpendriveMeta(metaLine: string): string | null {
  const m = /([^/\\]+)\.xodr/i.exec(metaLine);
  return m ? m[1] : null;
}

export function mapIdForBatch(
  batchId: string | number,
  config?: ClipConfig,
): string {
  const cfg = config ?? loadClipConfig();
  const key = String(Number(batchId));
  return cfg.batch_map_defaults?.[key] ?? "hct_6";
}

export function activeProfile(
  mapId?: string | null,
  config?: ClipConfig,
  batchId?: string | number | null,
  profileName?: string | null,
): ClipProfile {
  const cfg = config ?? loadClipConfig();
  const name = String(
    profileName ?? cfg.active ?? "current_startvalid",
  );
  const profiles = cfg.profiles ?? {};
  if (!(name in profiles)) {
    throw new Error(
      `clip profile '${name}' missing in clip_conditions.yaml (have: ${Object.keys(profiles).join(", ")})`,
    );
  }
  const prof: ClipProfile = {
    ...profiles[name],
    _profile_name: name,
  };
  const overrides = (cfg.map_overrides ?? {})[mapId ?? ""] ?? {};
  Object.assign(prof, overrides);
  if (batchId != null && batchId !== "") {
    const bkey = String(Number(batchId));
    const batchBlock = (cfg.batch_overrides ?? {})[bkey] ?? {};
    if (batchBlock && typeof batchBlock === "object") {
      const named = (batchBlock as Record<string, unknown>)[name];
      if (named && typeof named === "object") {
        Object.assign(prof, named);
      } else if (
        "type" in batchBlock ||
        "x" in batchBlock ||
        "road_id" in batchBlock
      ) {
        // Flat overlay only when forcing the same active profile semantics;
        // skip flat merge when resolving a non-active named profile.
        if (profileName == null || profileName === cfg.active) {
          Object.assign(prof, batchBlock);
        }
      }
    }
  }
  if (mapId) prof._map_id = mapId;
  return prof;
}

type EgoFrame = {
  time: number;
  x: number;
  y: number;
  roadId: number;
  s: number;
};

function isPlaceholder(f: EgoFrame): boolean {
  if (f.roadId === -1) return true;
  return f.x === 0 && f.y === 0;
}

/**
 * Absolute esmini time for analysis t=0, or null if rule misses.
 */
export function resolveClipStartFromEgoFrames(
  egoFrames: EgoFrame[],
  profile: ClipProfile,
): number | null {
  if (!egoFrames.length) return null;
  const usable = egoFrames.filter((f) => !isPlaceholder(f));
  const rows = usable.length ? usable : egoFrames;
  const ptype = String(profile.type ?? "world_xy");
  let hitTime: number | null = null;

  if (
    (ptype === "road_s" || ptype === "road_s_with_world_fallback") &&
    rows.some((f) => Number.isFinite(f.roadId) && Number.isFinite(f.s))
  ) {
    const roadId = Number(profile.road_id ?? 92);
    const sTol = Number(profile.s_tol ?? 3.0);
    const sTarget = Number(profile.s ?? 0.0);
    const tgtRows = rows.filter(
      (f) => f.roadId === roadId && Math.abs(f.s - sTarget) <= sTol,
    );
    if (tgtRows.length) {
      const tgt = tgtRows[0];
      const xyTol = Number(profile.xy_tol_m ?? 3.0);
      const near = rows.filter((f) => {
        const dx = f.x - tgt.x;
        const dy = f.y - tgt.y;
        return Math.hypot(dx, dy) <= xyTol;
      });
      if (near.length) hitTime = near[0].time;
    }
  }

  if (
    hitTime == null &&
    (ptype === "world_xy" || ptype === "road_s_with_world_fallback")
  ) {
    const tx =
      ptype === "world_xy"
        ? Number(profile.x ?? profile.fallback_x ?? 300)
        : Number(profile.fallback_x ?? 300);
    const ty =
      ptype === "world_xy"
        ? Number(profile.y ?? profile.fallback_y ?? 58)
        : Number(profile.fallback_y ?? 58);
    const tol =
      ptype === "world_xy"
        ? Number(profile.xy_tol_m ?? 3)
        : Number(profile.fallback_xy_tol_m ?? profile.xy_tol_m ?? 5);
    const withDist = rows.map((f) => ({
      f,
      d: Math.hypot(f.x - tx, f.y - ty),
    }));
    const near = withDist.filter((x) => x.d <= tol).sort((a, b) => a.f.time - b.f.time);
    if (near.length) {
      hitTime = near[0].f.time;
    } else if (withDist.length) {
      withDist.sort((a, b) => a.d - b.d);
      if (withDist[0].d <= tol * 2) hitTime = withDist[0].f.time;
    }
  }

  if (hitTime == null) return null;
  const offset = Number(profile.frame_offset_s ?? 0) || 0;
  return Number((hitTime + offset).toFixed(3));
}

/** Parse Ego frames (with s) from esmini CSV text for clip resolution. */
export function parseEgoFramesForClip(csvContent: string): {
  meta: string;
  ego: EgoFrame[];
} {
  const lines = csvContent.split(/\r?\n/);
  const meta = lines[0] ?? "";
  const ego: EgoFrame[] = [];
  for (let i = 2; i < lines.length; i++) {
    const raw = lines[i];
    if (!raw?.trim()) continue;
    const cells = raw.split(",").map((c) => c.trim());
    if (cells.length < 15) continue;
    if (cells[2] !== "Ego") continue;
    const time = Number(cells[0]);
    if (!Number.isFinite(time)) continue;
    ego.push({
      time,
      x: Number(cells[3]),
      y: Number(cells[4]),
      roadId: Number(cells[9]),
      s: Number(cells[13]),
    });
  }
  return { meta, ego };
}
