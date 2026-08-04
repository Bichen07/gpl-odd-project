import fs from "fs";
import path from "path";
import {
  activeProfile,
  loadClipConfig,
  mapIdForBatch,
  mapIdFromOpendriveMeta,
  parseEgoFramesForClip,
  resolveClipStartFromEgoFrames,
} from "./clipConditions";
import { resolveClusterArtifact } from "./clusterPaths";

/**
 * Shared helpers for reading esmini ground-truth CSVs and shaping them into the
 * Replayer's TrajectoryResponseData format. Used by the esmini-trajectory route.
 *
 * Analysis-stage clip: when ``applyAnalysisClip`` is true (default), applies
 * ``app/analyzer/config/clip_conditions.yaml`` so Replayer / LLM share one clock.
 * This does not modify the CSV on disk or simulation upload.
 *
 * Set applyAnalysisClip=false only for debug (full post-spawn timeline).
 */

/** Baked Heatmap PNG clock — always Payload / current_startvalid (not YAML). */
export const HEATMAP_ORIGIN_PROFILE = "current_startvalid";

export const RECORDS_DIR = path.join(
  "simulation",
  "ros",
  ".cache",
  "scenario_search",
  "records",
);

export function findProjectRoot(start: string): string {
  let current = start;
  for (let i = 0; i < 8; i++) {
    if (path.basename(current) === "gpl-odd-project") return current;
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  return path.resolve(start, "..", "..");
}

export function readJsonSafe(p: string): Record<string, unknown> | null {
  try {
    return JSON.parse(fs.readFileSync(p, "utf-8"));
  } catch {
    return null;
  }
}

/** Port of csv_roadid_loader._parse_dimensions_from_cells (width/length). */
function parseDimensions(cells: string[]): { width: number; length: number } {
  for (const base of [19, 20, 21]) {
    if (cells.length <= base + 2) continue;
    const w = Number(cells[base + 1]);
    const ln = Number(cells[base + 2]);
    if (
      Number.isFinite(w) &&
      Number.isFinite(ln) &&
      w >= 0.3 &&
      w <= 3.5 &&
      ln >= 2.0 &&
      ln <= 12.0
    ) {
      return { width: w, length: ln };
    }
  }
  return { width: 2.2, length: 5.14 };
}

type Frame = {
  time: number;
  x: number;
  y: number;
  yaw: number;
  speed: number;
  roadId: number;
  laneId: number;
  width: number;
  length: number;
};

export type EsminiTrajectoryResponse = {
  trialId: number;
  time: number[];
  anchor: { x: number; y: number; h: number };
  trajectory: Record<
    string,
    Array<{
      x: number;
      y: number;
      yaw: number;
      laneHeading: number;
      globalX: number;
      globalY: number;
      width: number;
      length: number;
      s_ratio: number;
    }>
  >;
  source: "esmini";
  /** Absolute esmini seconds used as analysis t=0 (null if clip rule missed). */
  clipStartEsminiS?: number | null;
  /** Absolute esmini seconds for heatmap image t=0 (Payload / current_startvalid). */
  heatmapOriginEsminiS?: number | null;
  /**
   * Seconds to add to Replayer playhead when positioning on the baked heatmap:
   * max(0, clipStartEsminiS - heatmapOriginEsminiS).
   */
  heatmapClipOffsetSec?: number;
  clipProfile?: string | null;
  mapId?: string | null;
};

export type BuildEsminiTrajectoryOptions = {
  framePeriod?: number;
  /** Apply clip_conditions.yaml (default true). */
  applyAnalysisClip?: boolean;
  batchId?: string | number;
  mapId?: string;
  projectRoot?: string;
};

/**
 * Read an esmini CSV and shape it into the Replayer's TrajectoryResponseData.
 * Returns null if the CSV is missing or has no usable Ego frames.
 */
export function buildEsminiTrajectory(
  csvPath: string,
  trialId: number,
  framePeriodOrOpts: number | BuildEsminiTrajectoryOptions = 0.1,
): EsminiTrajectoryResponse | null {
  const opts: BuildEsminiTrajectoryOptions =
    typeof framePeriodOrOpts === "number"
      ? { framePeriod: framePeriodOrOpts }
      : framePeriodOrOpts ?? {};
  const framePeriod = opts.framePeriod ?? 0.1;
  const applyAnalysisClip = opts.applyAnalysisClip !== false;

  if (!fs.existsSync(csvPath)) {
    return null;
  }

  const content = fs.readFileSync(csvPath, "utf-8");
  const lines = content.split(/\r?\n/);
  // lines[0] = version/metadata, lines[1] = column header. Data starts at 2.
  const byName: Record<string, Frame[]> = {};
  for (let i = 2; i < lines.length; i++) {
    const raw = lines[i];
    if (!raw || !raw.trim()) continue;
    const cells = raw.split(",").map((c) => c.trim());
    if (cells.length < 15) continue;
    const name = cells[2];
    if (!name) continue;
    const dims = parseDimensions(cells);
    const frame: Frame = {
      time: Number(cells[0]),
      x: Number(cells[3]),
      y: Number(cells[4]),
      yaw: Number(cells[6]),
      roadId: Number(cells[9]),
      laneId: Number(cells[10]),
      speed: Number(cells[14]),
      width: dims.width,
      length: dims.length,
    };
    if (!Number.isFinite(frame.time)) continue;
    (byName[name] ??= []).push(frame);
  }

  const egoFrames = byName["Ego"];
  if (!egoFrames || egoFrames.length === 0) {
    return null;
  }

  // Drop leading pre-spawn placeholder frames (ego at origin, roadId == -1).
  const spawnIdx = egoFrames.findIndex(
    (f) => f.roadId !== -1 && !(f.x === 0 && f.y === 0),
  );
  let startTime = spawnIdx >= 0 ? egoFrames[spawnIdx].time : egoFrames[0].time;
  const endTime = egoFrames[egoFrames.length - 1].time;

  let clipStartEsminiS: number | null = null;
  let heatmapOriginEsminiS: number | null = null;
  let heatmapClipOffsetSec = 0;
  let clipProfile: string | null = null;
  let mapId: string | null = opts.mapId ?? null;

  if (applyAnalysisClip) {
    try {
      const root = opts.projectRoot ?? findProjectRoot(process.cwd());
      const cfg = loadClipConfig(root);
      const { meta, ego } = parseEgoFramesForClip(content);
      mapId =
        opts.mapId ??
        mapIdFromOpendriveMeta(meta) ??
        (opts.batchId != null ? mapIdForBatch(opts.batchId, cfg) : null);
      const profile = activeProfile(mapId, cfg, opts.batchId);
      clipProfile = profile._profile_name ?? null;
      const resolved = resolveClipStartFromEgoFrames(ego, profile);
      if (resolved != null) {
        clipStartEsminiS = resolved;
        startTime = Math.max(startTime, resolved);
      }
      // Heatmap PNGs are baked on the Payload / current_startvalid clock.
      try {
        const originProf = activeProfile(
          mapId,
          cfg,
          opts.batchId,
          HEATMAP_ORIGIN_PROFILE,
        );
        heatmapOriginEsminiS = resolveClipStartFromEgoFrames(ego, originProf);
      } catch {
        heatmapOriginEsminiS = null;
      }
      if (
        clipStartEsminiS != null &&
        heatmapOriginEsminiS != null &&
        Number.isFinite(clipStartEsminiS) &&
        Number.isFinite(heatmapOriginEsminiS)
      ) {
        heatmapClipOffsetSec = Math.max(
          0,
          Number((clipStartEsminiS - heatmapOriginEsminiS).toFixed(3)),
        );
      }
    } catch (err) {
      console.warn("[esminiTrajectory] analysis clip failed:", err);
    }
  }

  // Build a downsampled target time grid (framePeriod spacing), then rebase to 0.
  const absoluteTimes: number[] = [];
  for (let t = startTime; t <= endTime + 1e-9; t += framePeriod) {
    absoluteTimes.push(Number(t.toFixed(3)));
  }
  if (
    absoluteTimes.length === 0 ||
    absoluteTimes[absoluteTimes.length - 1] < endTime - 1e-9
  ) {
    absoluteTimes.push(Number(endTime.toFixed(3)));
  }

  const origin = absoluteTimes[0] ?? startTime;
  const targetTimes = absoluteTimes.map((t) =>
    Number((t - origin).toFixed(3)),
  );

  // For each actor, sample the frame nearest to each absolute target time.
  function sampleNearest(frames: Frame[], t: number): Frame {
    let lo = 0;
    let hi = frames.length - 1;
    while (lo < hi) {
      const mid = (lo + hi) >> 1;
      if (frames[mid].time < t) lo = mid + 1;
      else hi = mid;
    }
    const cand = lo;
    const prev = Math.max(0, lo - 1);
    return Math.abs(frames[prev].time - t) <= Math.abs(frames[cand].time - t)
      ? frames[prev]
      : frames[cand];
  }

  const trajectory: EsminiTrajectoryResponse["trajectory"] = {};
  for (const [name, frames] of Object.entries(byName)) {
    if (frames.length === 0) continue;
    trajectory[name] = absoluteTimes.map((tAbs) => {
      const f = sampleNearest(frames, tAbs);
      return {
        x: f.x,
        y: f.y,
        yaw: f.yaw,
        laneHeading: f.yaw,
        globalX: f.x,
        globalY: f.y,
        width: f.width,
        length: f.length,
        s_ratio: 0,
      };
    });
  }

  const egoAnchor = sampleNearest(egoFrames, startTime);

  return {
    trialId,
    time: targetTimes,
    anchor: { x: egoAnchor.x, y: egoAnchor.y, h: egoAnchor.yaw },
    trajectory,
    source: "esmini",
    clipStartEsminiS,
    heatmapOriginEsminiS,
    heatmapClipOffsetSec,
    clipProfile,
    mapId,
  };
}

export type HeatmapClipOffsetResult = {
  heatmapClipOffsetSec: number;
  clipStartEsminiS: number | null;
  heatmapOriginEsminiS: number | null;
  clipProfile: string | null;
  heatmapOriginProfile: string | null;
  mapId: string | null;
  csvPath: string;
};

/**
 * Resolve how far the active analysis clip is past the baked Heatmap origin
 * (always ``current_startvalid`` / Payload clock) using one esmini CSV.
 * Does not build a full trajectory.
 */
export function computeHeatmapClipOffset(
  csvPath: string,
  opts: { batchId?: string | number; projectRoot?: string } = {},
): HeatmapClipOffsetResult | null {
  if (!fs.existsSync(csvPath)) return null;
  const content = fs.readFileSync(csvPath, "utf-8");
  const root = opts.projectRoot ?? findProjectRoot(process.cwd());
  try {
    const cfg = loadClipConfig(root);
    const { meta, ego } = parseEgoFramesForClip(content);
    if (!ego.length) return null;
    const mapId =
      mapIdFromOpendriveMeta(meta) ??
      (opts.batchId != null ? mapIdForBatch(opts.batchId, cfg) : null);
    const profile = activeProfile(mapId, cfg, opts.batchId);
    const clipStartEsminiS = resolveClipStartFromEgoFrames(ego, profile);
    let heatmapOriginEsminiS: number | null = null;
    try {
      const originProf = activeProfile(
        mapId,
        cfg,
        opts.batchId,
        HEATMAP_ORIGIN_PROFILE,
      );
      heatmapOriginEsminiS = resolveClipStartFromEgoFrames(ego, originProf);
    } catch {
      heatmapOriginEsminiS = null;
    }
    let heatmapClipOffsetSec = 0;
    if (
      clipStartEsminiS != null &&
      heatmapOriginEsminiS != null &&
      Number.isFinite(clipStartEsminiS) &&
      Number.isFinite(heatmapOriginEsminiS)
    ) {
      heatmapClipOffsetSec = Math.max(
        0,
        Number((clipStartEsminiS - heatmapOriginEsminiS).toFixed(3)),
      );
    }
    return {
      heatmapClipOffsetSec,
      clipStartEsminiS,
      heatmapOriginEsminiS,
      clipProfile: profile._profile_name ?? null,
      heatmapOriginProfile: HEATMAP_ORIGIN_PROFILE,
      mapId,
      csvPath,
    };
  } catch (err) {
    console.warn("[esminiTrajectory] heatmap clip offset failed:", err);
    return null;
  }
}

/** First esmini_<batchId>_*.csv under records/, or null. */
export function findAnyEsminiCsvForBatch(
  projectRoot: string,
  batchId: string | number,
): string | null {
  const dir = path.join(projectRoot, RECORDS_DIR);
  if (!fs.existsSync(dir)) return null;
  const prefix = `esmini_${Number(batchId)}_`;
  const names = fs
    .readdirSync(dir)
    .filter((n) => n.startsWith(prefix) && n.endsWith(".csv"));
  if (!names.length) return null;
  names.sort();
  return path.join(dir, names[0]);
}

/**
 * Resolve an esmini CSV for heatmap offset.
 * Prefer an explicit trial CSV; else records for this batchId; else a medoid
 * under results/batchN (batch9 often reuses batch7 CSVs — no esmini_9_* files).
 */
export function findEsminiCsvForHeatmapOffset(
  projectRoot: string,
  batchId: string | number,
  opts?: {
    csvBatch?: string | number;
    trialIndex?: string | number;
    folder?: string;
    label?: string;
  },
): { csvPath: string; clipBatchId: string } | null {
  const records = path.join(projectRoot, RECORDS_DIR);

  if (opts?.csvBatch != null && opts?.trialIndex != null) {
    const csvPath = path.join(
      records,
      `esmini_${Number(opts.csvBatch)}_${Number(opts.trialIndex)}.csv`,
    );
    if (fs.existsSync(csvPath)) {
      return { csvPath, clipBatchId: String(Number(opts.csvBatch)) };
    }
  }

  if (opts?.folder && opts?.label != null) {
    const clusterDir = path.join(
      projectRoot,
      "results",
      `batch${batchId}`,
      opts.folder,
      `cluster${opts.label}`,
    );
    const cjPath = resolveClusterArtifact(clusterDir, "cluster.json");
    if (cjPath) {
      try {
        const cj = JSON.parse(fs.readFileSync(cjPath, "utf-8")) as {
          medoid?: { batch_id?: number; trial_index?: number };
        };
        const bid = cj.medoid?.batch_id;
        const tix = cj.medoid?.trial_index;
        if (bid != null && tix != null) {
          const csvPath = path.join(records, `esmini_${bid}_${tix}.csv`);
          if (fs.existsSync(csvPath)) {
            return { csvPath, clipBatchId: String(bid) };
          }
        }
      } catch {
        /* fall through */
      }
    }
  }

  const direct = findAnyEsminiCsvForBatch(projectRoot, batchId);
  if (direct) return { csvPath: direct, clipBatchId: String(Number(batchId)) };

  // results/batchN/**/cluster.json medoids (nested raw/ or flat)
  const batchResults = path.join(projectRoot, "results", `batch${batchId}`);
  if (!fs.existsSync(batchResults)) return null;

  const stack = [batchResults];
  while (stack.length) {
    const dir = stack.pop()!;
    let entries: fs.Dirent[];
    try {
      entries = fs.readdirSync(dir, { withFileTypes: true });
    } catch {
      continue;
    }
    for (const ent of entries) {
      if (!ent.isDirectory()) continue;
      const full = path.join(dir, ent.name);
      if (ent.name.startsWith("cluster") && /^cluster\d+$/.test(ent.name)) {
        const cjPath = resolveClusterArtifact(full, "cluster.json");
        if (!cjPath) {
          stack.push(full);
          continue;
        }
        try {
          const cj = JSON.parse(fs.readFileSync(cjPath, "utf-8")) as {
            medoid?: { batch_id?: number; trial_index?: number };
          };
          const bid = cj.medoid?.batch_id;
          const tix = cj.medoid?.trial_index;
          if (bid == null || tix == null) continue;
          const csvPath = path.join(records, `esmini_${bid}_${tix}.csv`);
          if (fs.existsSync(csvPath)) {
            return { csvPath, clipBatchId: String(bid) };
          }
        } catch {
          /* try next */
        }
      } else if (
        ent.name.startsWith("cluster") ||
        /^\d+_cluster/.test(ent.name) ||
        ent.name === "raw"
      ) {
        stack.push(full);
      }
    }
  }
  return null;
}
