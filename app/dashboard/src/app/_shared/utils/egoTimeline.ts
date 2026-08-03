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

export type EgoKinematics = {
  velocityMps: number | null;
  accelMps2: number | null;
};

export type EgoPoseSample = {
  x: number;
  y: number;
  speed?: number;
};

/** Method G: Gaussian σ≈2 frames on speed (@0.1 s ≈ 0.2 s). */
const SPEED_SMOOTH_SIGMA_FRAMES = 2;

function gaussianSmooth(values: number[], sigmaFrames: number): number[] {
  if (values.length === 0) return [];
  const sigma = Math.max(0.5, sigmaFrames);
  const radius = Math.max(1, Math.ceil(3 * sigma));
  const kernel: number[] = [];
  let kSum = 0;
  for (let i = -radius; i <= radius; i++) {
    const w = Math.exp(-0.5 * (i / sigma) ** 2);
    kernel.push(w);
    kSum += w;
  }
  for (let i = 0; i < kernel.length; i++) kernel[i] /= kSum;

  const out = new Array<number>(values.length);
  for (let i = 0; i < values.length; i++) {
    let num = 0;
    let den = 0;
    for (let k = 0; k < kernel.length; k++) {
      const j = i + k - radius;
      if (j < 0 || j >= values.length) continue;
      num += values[j] * kernel[k];
      den += kernel[k];
    }
    out[i] = den > 0 ? num / den : values[i];
  }
  return out;
}

function buildSpeedSeries(time: number[], egoPoses: EgoPoseSample[]): number[] {
  const speeds = new Array<number>(egoPoses.length);
  let haveSpeedField = true;
  for (let k = 0; k < egoPoses.length; k++) {
    const s = egoPoses[k].speed;
    if (typeof s === "number" && Number.isFinite(s)) {
      speeds[k] = s;
    } else {
      haveSpeedField = false;
      break;
    }
  }
  if (haveSpeedField) return speeds;

  // Fallback when analysis zip omitted speed: Δx/Δy (≈ CSV speed on medoids).
  speeds[0] = 0;
  for (let k = 1; k < egoPoses.length; k++) {
    const dt = time[k] - time[k - 1];
    if (dt > 1e-6) {
      const dx = egoPoses[k].x - egoPoses[k - 1].x;
      const dy = egoPoses[k].y - egoPoses[k - 1].y;
      speeds[k] = Math.hypot(dx, dy) / dt;
    } else {
      speeds[k] = speeds[k - 1];
    }
  }
  if (egoPoses.length > 1) speeds[0] = speeds[1];
  return speeds;
}

function centralAccel(time: number[], speed: number[]): number[] {
  const n = speed.length;
  const a = new Array<number>(n).fill(0);
  if (n < 2) return a;
  for (let i = 1; i < n - 1; i++) {
    const dt = time[i + 1] - time[i - 1];
    a[i] = dt > 1e-6 ? (speed[i + 1] - speed[i - 1]) / dt : 0;
  }
  const dt0 = time[1] - time[0];
  a[0] = dt0 > 1e-6 ? (speed[1] - speed[0]) / dt0 : 0;
  const dtn = time[n - 1] - time[n - 2];
  a[n - 1] = dtn > 1e-6 ? (speed[n - 1] - speed[n - 2]) / dtn : 0;
  return a;
}

function lerp(a: number, b: number, u: number): number {
  return a + (b - a) * u;
}

/**
 * Method G + CSV speed + linear playhead interp.
 * Prefer pose ``speed``; Gaussian-smooth; central-difference accel; lerp at timeSec.
 */
export function sampleEgoKinematicsAtTime(
  time: number[] | undefined,
  egoPoses: EgoPoseSample[] | undefined,
  timeSec: number,
): EgoKinematics {
  if (!time?.length || !egoPoses?.length || time.length !== egoPoses.length) {
    return { velocityMps: null, accelMps2: null };
  }

  const rawSpeed = buildSpeedSeries(time, egoPoses);
  const smoothSpeed = gaussianSmooth(rawSpeed, SPEED_SMOOTH_SIGMA_FRAMES);
  const accel = centralAccel(time, smoothSpeed);

  if (timeSec <= time[0]) {
    return {
      velocityMps: Number.isFinite(smoothSpeed[0]) ? smoothSpeed[0] : null,
      accelMps2: Number.isFinite(accel[0]) ? accel[0] : null,
    };
  }
  if (timeSec >= time[time.length - 1]) {
    const last = time.length - 1;
    return {
      velocityMps: Number.isFinite(smoothSpeed[last]) ? smoothSpeed[last] : null,
      accelMps2: Number.isFinite(accel[last]) ? accel[last] : null,
    };
  }

  let lo = 0;
  let hi = time.length - 1;
  while (lo < hi) {
    const mid = (lo + hi + 1) >> 1;
    if (time[mid] <= timeSec + 1e-9) lo = mid;
    else hi = mid - 1;
  }
  const i0 = lo;
  const i1 = Math.min(i0 + 1, time.length - 1);
  const dt = time[i1] - time[i0];
  const u = dt > 1e-9 ? (timeSec - time[i0]) / dt : 0;

  const velocityMps = lerp(smoothSpeed[i0], smoothSpeed[i1], u);
  const accelMps2 = lerp(accel[i0], accel[i1], u);

  return {
    velocityMps: Number.isFinite(velocityMps) ? velocityMps : null,
    accelMps2: Number.isFinite(accelMps2) ? accelMps2 : null,
  };
}
