/**
 * Mission Control API client.
 *
 * Talks to the Mission Control service (default: http://localhost:8282).
 * All functions return plain objects so components can render directly.
 */

const BASE = process.env.NEXT_PUBLIC_MISSION_CONTROL_API ?? "http://localhost:8282";

// ── Types ────────────────────────────────────────────────────────────────────

export type SimStatus =
  | "idle"
  | "starting"
  | "running"
  | "stopping"
  | "completed"
  | "failed";

export interface RunRequest {
  batch_id: number;
  scenario_id: number;
  n_trials?: number;
  retry_failed?: boolean;
  max_trial_duration_seconds?: number;
}

export interface RunResponse {
  run_id: string;
  status: SimStatus;
  websocket_url: string;
}

export interface ProgressInfo {
  current_trial: number;
  total_trials: number;
  completed: number;
  failed: number;
  success_rate: number;
}

export interface TimingInfo {
  started_at: string | null;
  elapsed_seconds: number;
  eta_seconds: number | null;
}

export interface StatusSnapshot {
  run_id: string;
  status: SimStatus;
  batch_id: number;
  scenario_id: number;
  progress: ProgressInfo;
  timing: TimingInfo;
  last_trial: Record<string, unknown> | null;
  errors: string[];
  logs_tail: string[];
}

export interface ServiceHealth {
  payload: { ok: boolean };
  sampling: { ok: boolean };
  docker: { available: boolean; container_status: string };
  ros: Record<string, unknown>;
}

export interface HealthResponse {
  status: string;
  services: ServiceHealth;
  active_runs: number;
}

export interface DataQualitySummary {
  batch_id: number;
  local_csv_count: number;
  payload_trial_count: number;
  in_sync: boolean | null;
}

export type WsMessage =
  | { type: "status_update"; payload: StatusSnapshot }
  | { type: "trial_completed"; payload: Record<string, unknown> }
  | { type: "completed"; payload: StatusSnapshot }
  | { type: "error"; payload: { message: string } }
  | { type: "log"; payload: { message: string } }
  | { type: "ping" };

// ── HTTP helpers ─────────────────────────────────────────────────────────────

async function apiFetch<T>(path: string, init?: RequestInit): Promise<T> {
  const res = await fetch(`${BASE}${path}`, {
    headers: { "Content-Type": "application/json" },
    ...init,
  });
  if (!res.ok) {
    const text = await res.text().catch(() => res.statusText);
    throw new Error(`Mission Control ${path}: ${res.status} ${text}`);
  }
  return res.json() as Promise<T>;
}

// ── Public API ────────────────────────────────────────────────────────────────

/** Start a simulation run. */
export async function startRun(req: RunRequest): Promise<RunResponse> {
  return apiFetch<RunResponse>("/simulation/run", {
    method: "POST",
    body: JSON.stringify(req),
  });
}

/** Stop a running simulation. */
export async function stopRun(runId: string): Promise<{ run_id: string; status: string }> {
  return apiFetch(`/simulation/stop/${runId}`, { method: "POST" });
}

/** Get a status snapshot for a specific run. */
export async function getStatus(runId: string): Promise<StatusSnapshot> {
  return apiFetch<StatusSnapshot>(`/simulation/status/${runId}`);
}

/** Get status snapshots for all active runs. */
export async function getAllStatuses(): Promise<StatusSnapshot[]> {
  return apiFetch<StatusSnapshot[]>("/simulation/status");
}

/** Get service health. */
export async function getHealth(): Promise<HealthResponse> {
  return apiFetch<HealthResponse>("/simulation/health");
}

/** Get log lines for a run. */
export async function getLogs(runId: string): Promise<{ run_id: string; logs: string[] }> {
  return apiFetch(`/simulation/logs/${runId}`);
}

/** Get data quality summary for a batch. */
export async function getDataQuality(batchId: number): Promise<DataQualitySummary> {
  return apiFetch<DataQualitySummary>(`/simulation/data-quality/${batchId}`);
}

// ── WebSocket subscription ────────────────────────────────────────────────────

/**
 * Connect to the real-time WebSocket stream for *runId*.
 *
 * @param runId    The run_id returned by `startRun`.
 * @param onMessage  Called with each parsed WsMessage.
 * @param onError  Called on connection error.
 * @returns        A cleanup function that closes the socket.
 */
export function subscribeToRun(
  runId: string,
  onMessage: (msg: WsMessage) => void,
  onError?: (err: Event) => void
): () => void {
  const wsBase = BASE.replace(/^http/, "ws");
  const ws = new WebSocket(`${wsBase}/simulation/stream/${runId}`);

  ws.addEventListener("message", (ev) => {
    try {
      const parsed = JSON.parse(ev.data) as WsMessage;
      onMessage(parsed);
    } catch {
      // ignore malformed frames
    }
  });

  if (onError) {
    ws.addEventListener("error", onError);
  }

  return () => {
    ws.close();
  };
}
