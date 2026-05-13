"use client";

import {
  Box,
  Button,
  Chip,
  CircularProgress,
  Collapse,
  Divider,
  Grid,
  LinearProgress,
  Stack,
  TextField,
  Tooltip,
  Typography,
} from "@mui/material";
import { useCallback, useEffect, useRef, useState } from "react";
import { useAppSelector } from "../../../../redux/hooks";

import {
  getDataQuality,
  getHealth,
  getLogs,
  getStatus,
  startRun,
  stopRun,
  subscribeToRun,
  type DataQualitySummary,
  type HealthResponse,
  type SimStatus,
  type StatusSnapshot,
  type WsMessage,
} from "@/app/_shared/api/missionControl";

// ── Helpers ───────────────────────────────────────────────────────────────────

const STATUS_COLOR: Record<SimStatus, string> = {
  idle: "default",
  starting: "info",
  running: "primary",
  stopping: "warning",
  completed: "success",
  failed: "error",
};

function fmtSeconds(s: number | null): string {
  if (s == null || s < 0) return "—";
  const h = Math.floor(s / 3600);
  const m = Math.floor((s % 3600) / 60);
  const sec = Math.floor(s % 60);
  if (h > 0) return `${h}h ${m}m`;
  if (m > 0) return `${m}m ${sec}s`;
  return `${sec}s`;
}

// ── Sub-components ────────────────────────────────────────────────────────────

function HealthBadge({ health }: { health: HealthResponse | null }) {
  if (!health) return null;
  const { services } = health;
  return (
    <Stack direction="row" spacing={1} flexWrap="wrap">
      {(
        [
          ["Payload", services.payload?.ok],
          ["Sampling", services.sampling?.ok],
          ["Docker", services.docker?.available],
          ["Container", services.docker?.container_status === "running"],
        ] as [string, boolean | undefined][]
      ).map(([label, ok]) => (
        <Chip
          key={label}
          label={label}
          size="small"
          color={ok ? "success" : "error"}
          variant="outlined"
        />
      ))}
    </Stack>
  );
}

function ProgressPanel({ snap }: { snap: StatusSnapshot }) {
  const { progress, timing } = snap;
  const finished = progress.completed + progress.failed;
  const pct = progress.total_trials > 0
    ? Math.round((finished / progress.total_trials) * 100)
    : 0;

  return (
    <Stack spacing={1}>
      <Box sx={{ display: "flex", justifyContent: "space-between" }}>
        <Typography variant="body2">
          Trial {progress.current_trial} / {progress.total_trials}
          &nbsp;({pct}%)
        </Typography>
        <Tooltip
          title="Rough estimate: (elapsed ÷ finished trials) × trials left. Resets as success/fail mix changes; not wall-clock guaranteed."
          placement="top"
          arrow
        >
          <Typography variant="body2" color="text.secondary" component="span" sx={{ cursor: "help" }}>
            ETA: {fmtSeconds(timing.eta_seconds)}
          </Typography>
        </Tooltip>
      </Box>
      <LinearProgress variant="determinate" value={pct} />
      <Stack direction="row" spacing={2}>
        <Typography variant="caption" color="success.main">
          ✅ {progress.completed} ok
        </Typography>
        <Typography variant="caption" color="error.main">
          ❌ {progress.failed} failed
        </Typography>
        <Typography variant="caption" color="text.secondary">
          Elapsed: {fmtSeconds(timing.elapsed_seconds)}
        </Typography>
      </Stack>
    </Stack>
  );
}

function LogViewer({ logs }: { logs: string[] }) {
  const containerRef = useRef<HTMLDivElement>(null);
  const stickToBottomRef = useRef(true);

  useEffect(() => {
    const el = containerRef.current;
    if (!el || !stickToBottomRef.current) return;
    el.scrollTop = el.scrollHeight;
  }, [logs]);

  return (
    <Box
      ref={containerRef}
      onScroll={() => {
        const el = containerRef.current;
        if (!el) return;
        stickToBottomRef.current =
          el.scrollHeight - el.scrollTop - el.clientHeight < 24;
      }}
      sx={{
        background: "#111",
        borderRadius: 1,
        p: 1,
        maxHeight: 180,
        overflowY: "auto",
        fontFamily: "monospace",
        fontSize: 11,
      }}
    >
      {logs.length === 0 ? (
        <Typography variant="caption" color="text.disabled">
          No logs yet.
        </Typography>
      ) : (
        logs.map((line, i) => (
          <Box key={i} component="div" sx={{ color: line.includes("ERROR") ? "#f44" : "#ccc" }}>
            {line}
          </Box>
        ))
      )}
    </Box>
  );
}

function DataQualityPanel({
  batchId,
  refreshIntervalMs,
}: {
  batchId: number;
  refreshIntervalMs?: number;
}) {
  const [q, setQ] = useState<DataQualitySummary | null>(null);
  const [loading, setLoading] = useState(false);

  const fetch = useCallback(async () => {
    setLoading(true);
    try {
      const data = await getDataQuality(batchId);
      setQ(data);
    } catch {
      setQ(null);
    } finally {
      setLoading(false);
    }
  }, [batchId]);

  useEffect(() => {
    fetch();
  }, [fetch]);

  useEffect(() => {
    if (!refreshIntervalMs) return;
    const id = setInterval(fetch, refreshIntervalMs);
    return () => clearInterval(id);
  }, [fetch, refreshIntervalMs]);

  if (loading && !q) return <CircularProgress size={16} />;
  if (!q) return <Typography variant="caption">Could not load data quality.</Typography>;

  return (
    <Stack spacing={0.5}>
      <Typography variant="caption">
        Local CSVs: <b>{q.local_csv_count}</b> &nbsp;|&nbsp; Payload trials:{" "}
        <b>{q.payload_trial_count < 0 ? "?" : q.payload_trial_count}</b>
      </Typography>
      {q.in_sync === false && (
        <Typography variant="caption" color="warning.main">
          ⚠️ Counts differ — some trials may be missing CSVs or not yet posted to Payload.
        </Typography>
      )}
      {q.in_sync === true && (
        <Typography variant="caption" color="success.main">
          ✅ Local CSVs and Payload are in sync.
        </Typography>
      )}
      {q.in_sync === null && (
        <Typography variant="caption" color="text.secondary">
          Payload unreachable — cannot compare.
        </Typography>
      )}
      <Button size="small" variant="text" onClick={fetch} sx={{ alignSelf: "flex-start" }}>
        Refresh
      </Button>
    </Stack>
  );
}

// ── Main Panel ────────────────────────────────────────────────────────────────

export default function MissionControl({ batchId }: { batchId?: string }) {
  const batch = useAppSelector((s) => s.batch.batch);
  const effectiveBatchId = batchId ? Number(batchId) : batch?.id ?? 0;
  const scenarioId = batch?.scenario?.id ?? 0;

  // Form state
  const [nTrials, setNTrials] = useState(100);
  const [retryFailed, setRetryFailed] = useState(true);
  const [maxDuration, setMaxDuration] = useState(120);

  // Run state
  const [runId, setRunId] = useState<string | null>(null);
  const [snap, setSnap] = useState<StatusSnapshot | null>(null);
  const [logs, setLogs] = useState<string[]>([]);
  const [health, setHealth] = useState<HealthResponse | null>(null);
  const [starting, setStarting] = useState(false);
  const [showLogs, setShowLogs] = useState(false);

  const unsub = useRef<(() => void) | null>(null);

  // Poll health on mount
  useEffect(() => {
    const check = () => getHealth().then(setHealth).catch(() => setHealth(null));
    check();
    const id = setInterval(check, 15_000);
    return () => clearInterval(id);
  }, []);

  // Poll logs when a run is active
  useEffect(() => {
    if (!runId || !showLogs) return;
    const id = setInterval(() => {
      getLogs(runId).then((r) => setLogs(r.logs)).catch(() => {});
    }, 3_000);
    return () => clearInterval(id);
  }, [runId, showLogs]);

  // Keep status, elapsed time, and logs in sync while a run is active
  useEffect(() => {
    if (!runId) return;

    let cancelled = false;
    const sync = () => {
      getStatus(runId)
        .then((status) => {
          if (cancelled) return;
          setSnap(status);
          if (status.logs_tail.length > 0) {
            setLogs(status.logs_tail);
          }
        })
        .catch(() => {});
    };

    sync();
    const id = setInterval(sync, 2_000);
    return () => {
      cancelled = true;
      clearInterval(id);
    };
  }, [runId]);

  // WebSocket subscription
  const connectWs = useCallback((id: string) => {
    unsub.current?.();
    unsub.current = subscribeToRun(
      id,
      (msg: WsMessage) => {
        if (msg.type === "status_update" || msg.type === "completed") {
          const payload = msg.payload as StatusSnapshot;
          if (payload.progress && payload.timing) {
            setSnap(payload);
            if (payload.logs_tail?.length) {
              setLogs(payload.logs_tail);
            }
          }
        }
      },
    );
  }, []);

  // ── Actions ──

  const handleStart = async () => {
    if (!effectiveBatchId || !scenarioId) {
      alert("No batch/scenario selected.");
      return;
    }
    setStarting(true);
    try {
      const res = await startRun({
        batch_id: effectiveBatchId,
        scenario_id: scenarioId,
        n_trials: nTrials,
        retry_failed: retryFailed,
        max_trial_duration_seconds: maxDuration,
      });
      setRunId(res.run_id);
      setShowLogs(true);
      connectWs(res.run_id);
      // Fetch initial snapshot
      getStatus(res.run_id).then(setSnap).catch(() => {});
    } catch (e: any) {
      alert(`Failed to start: ${e.message}`);
    } finally {
      setStarting(false);
    }
  };

  const handleStop = async () => {
    if (!runId) return;
    await stopRun(runId).catch(() => {});
    getStatus(runId).then(setSnap).catch(() => {});
  };

  const handleReset = () => {
    unsub.current?.();
    unsub.current = null;
    setRunId(null);
    setSnap(null);
    setLogs([]);
  };

  const currentStatus: SimStatus = snap?.status ?? "idle";
  // "stopping" is intentionally excluded — once the user clicked Stop they should
  // be able to start a new run immediately without waiting for cleanup.
  const isActive = ["starting", "running"].includes(currentStatus);

  return (
    <Stack spacing={2} sx={{ p: 2 }}>
      <Typography variant="h6">Mission Control</Typography>
      <Typography variant="body2" color="text.secondary">
        One-click simulation orchestration — triggers Sampling, Docker/ROS, and esmini.
      </Typography>

      {/* Service health */}
      <Box>
        <Typography variant="caption" color="text.secondary" sx={{ mb: 0.5, display: "block" }}>
          Service health
        </Typography>
        <HealthBadge health={health} />
      </Box>

      <Divider />

      {/* Config */}
      <Grid container spacing={1} alignItems="center">
        <Grid size={{ xs: 12, sm: 4 }}>
          <TextField
            label="Batch ID"
            size="small"
            value={effectiveBatchId || ""}
            slotProps={{ input: { readOnly: true } }}
            fullWidth
          />
        </Grid>
        <Grid size={{ xs: 12, sm: 4 }}>
          <TextField
            label="Scenario ID"
            size="small"
            value={scenarioId || ""}
            slotProps={{ input: { readOnly: true } }}
            fullWidth
          />
        </Grid>
        <Grid size={{ xs: 12, sm: 4 }}>
          <TextField
            label="Number of trials"
            size="small"
            type="number"
            value={nTrials}
            onChange={(e) => setNTrials(Number(e.target.value))}
            disabled={isActive}
            fullWidth
            slotProps={{ htmlInput: { min: 1, max: 10000 } }}
          />
        </Grid>
        <Grid size={{ xs: 12, sm: 6 }}>
          <TextField
            label="Max trial duration (s)"
            size="small"
            type="number"
            value={maxDuration}
            onChange={(e) => setMaxDuration(Number(e.target.value))}
            disabled={isActive}
            fullWidth
            helperText="Clock starts after ROS is up. Ego + esmini often need 60–120s; reference-model CSVs use a longer name (supported server-side)."
            slotProps={{ htmlInput: { min: 60, max: 600 } }}
          />
        </Grid>
        <Grid size={{ xs: 12, sm: 6 }}>
          <Stack direction="row" alignItems="center" spacing={1}>
            <Typography variant="body2">Auto-retry:</Typography>
            <Chip
              label={retryFailed ? "On" : "Off"}
              color={retryFailed ? "success" : "default"}
              size="small"
              clickable
              onClick={() => !isActive && setRetryFailed((v) => !v)}
            />
          </Stack>
        </Grid>
      </Grid>

      {/* Action buttons */}
      <Stack direction="row" spacing={1}>
        <Tooltip
          title={
            !health?.services?.docker?.available
              ? "Docker not available on this machine — run on ITRI lab server"
              : isActive
              ? "Simulation already running"
              : "Start simulation"
          }
        >
          <span>
            <Button
              variant="contained"
              color="primary"
              disabled={isActive || starting || !health?.services?.docker?.available}
              onClick={handleStart}
              startIcon={starting ? <CircularProgress size={16} color="inherit" /> : undefined}
            >
              ▶ Run Simulation
            </Button>
          </span>
        </Tooltip>

        <Button
          variant="outlined"
          color="warning"
          disabled={!isActive}
          onClick={handleStop}
        >
          ⏹ Stop
        </Button>

        <Button
          variant="text"
          size="small"
          onClick={() => setShowLogs((v) => !v)}
          disabled={!runId}
        >
          {showLogs ? "Hide Logs" : "📋 Logs"}
        </Button>

        {/* Show reset only when a previous run exists and is no longer starting/running */}
        {runId && !isActive && (
          <Button
            variant="text"
            size="small"
            color="inherit"
            onClick={handleReset}
          >
            ↺ New Run
          </Button>
        )}
      </Stack>

      {/* Status display */}
      {snap && (
        <>
          <Divider />
          <Stack direction="row" spacing={1} alignItems="center">
            <Chip
              label={currentStatus.toUpperCase()}
              color={STATUS_COLOR[currentStatus] as any}
              size="small"
            />
            <Typography variant="caption" color="text.secondary">
              Run: {snap.run_id}
            </Typography>
          </Stack>

          <ProgressPanel snap={snap} />

          {snap.errors.length > 0 && (
            <Box sx={{ background: "#2d0a0a", p: 1, borderRadius: 1 }}>
              <Typography variant="caption" color="error.main">
                {snap.errors.slice(-3).join(" | ")}
              </Typography>
            </Box>
          )}
        </>
      )}

      {/* Log viewer */}
      <Collapse in={showLogs}>
        <Divider sx={{ mb: 1 }} />
        <Typography variant="caption" color="text.secondary">
          Live logs (last 50 lines)
        </Typography>
        <LogViewer logs={logs} />
      </Collapse>

      <Divider />

      {/* Data quality */}
      {effectiveBatchId > 0 && (
        <Box>
          <Typography variant="caption" color="text.secondary" sx={{ mb: 0.5, display: "block" }}>
            Data quality — batch {effectiveBatchId}
          </Typography>
          <DataQualityPanel
            batchId={effectiveBatchId}
            refreshIntervalMs={isActive ? 10_000 : undefined}
          />
        </Box>
      )}
    </Stack>
  );
}
