import fs from "fs";
import path from "path";

/**
 * Shared helpers for reading esmini ground-truth CSVs and shaping them into the
 * Replayer's TrajectoryResponseData format. Used by the esmini-trajectory route,
 * which resolves the CSV either via cluster.json (medoid mode) or a
 * trialId -> trialIndex lookup (trial mode).
 *
 * Why esmini instead of the Payload observation trajectories: the LLM
 * interpretation, BEV snapshots and action.yaml are all generated from the
 * authoritative esmini CSV (0 .. scenario end). The clustering pipeline's
 * Payload trajectories are start-clipped / time-rebased, so replaying them puts
 * the video on a different clock than the interpretation caption. Feeding the
 * esmini timeline back into the replayer puts everything on ONE clock.
 */

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
};

/**
 * Read an esmini CSV and shape it into the Replayer's TrajectoryResponseData.
 * Returns null if the CSV is missing or has no usable Ego frames.
 */
export function buildEsminiTrajectory(
  csvPath: string,
  trialId: number,
  framePeriod = 0.1,
): EsminiTrajectoryResponse | null {
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
  const startTime = spawnIdx >= 0 ? egoFrames[spawnIdx].time : egoFrames[0].time;
  const endTime = egoFrames[egoFrames.length - 1].time;

  // Build a downsampled target time grid (framePeriod spacing).
  const targetTimes: number[] = [];
  for (let t = startTime; t <= endTime + 1e-9; t += framePeriod) {
    targetTimes.push(Number(t.toFixed(3)));
  }
  if (
    targetTimes.length === 0 ||
    targetTimes[targetTimes.length - 1] < endTime - 1e-9
  ) {
    targetTimes.push(Number(endTime.toFixed(3)));
  }

  // For each actor, sample the frame nearest to each target time.
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
    trajectory[name] = targetTimes.map((t) => {
      const f = sampleNearest(frames, t);
      return {
        x: f.x,
        y: f.y,
        yaw: f.yaw,
        laneHeading: f.yaw,
        globalX: f.x,
        globalY: f.y,
        width: f.width,
        length: f.length,
        // s_ratio is only used in "s" playback mode; the road-network global-s
        // mapping is unavailable here, so leave it at 0 (time mode is default).
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
  };
}
