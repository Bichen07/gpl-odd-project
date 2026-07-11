"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Alert,
  Box,
  Button,
  Checkbox,
  Chip,
  CircularProgress,
  Container,
  Divider,
  FormControlLabel,
  IconButton,
  LinearProgress,
  MenuItem,
  Paper,
  Select,
  Slider,
  Stack,
  Switch,
  Tab,
  Tabs,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  TextField,
  Typography,
} from "@mui/material";
import { ArrowBack, ExpandMore } from "@mui/icons-material";
import { selectDefaultSnapshots, snapshotTimestamp } from "@/app/_shared/utils/snapshotSelection";

type ClusterEntry = {
  cluster: number;
  stats: Record<string, unknown> | null;
  medoid: Record<string, unknown> | null;
  intraVariance: Record<string, unknown> | null;
  snapshots: string[];
};

type ClusteringQuality = {
  folder: string;
  k: number | null;
  silhouette: number | null;
  rule_score: number;
  llm_score: number | null;
  final_score: number;
  rank: number | null;
  has_llm_eval: boolean;
  sub_scores: Record<string, unknown>;
  cross_cluster_eval?: {
    behavioral_separation_score: number | null;
    boundary_clarity_score: number | null;
    inter_notes: string;
    cluster_summaries: Array<{cluster_id: number; archetype: string; intra_score?: number}>;
    merge_candidates?: string[];
    split_candidates?: string[];
  } | null;
  boundary_pairs?: Array<{
    cluster_a: number; trial_a: string; collided_a: boolean;
    cluster_b: number; trial_b: string; collided_b: boolean;
    embedding_dist: number;
  }>;
};

type ModelOption = { id: string; provider: string };

type ResultEntry = {
  cluster: number;
  meta: Record<string, unknown> | null;
  rawYaml: string;
};

type Config = {
  batchId: string;
  folder: string;
  clusters: ClusterEntry[];
  prompts: Record<string, string>;
  models: ModelOption[];
  results?: ResultEntry[];
};

const PROMPT_LABELS: Array<{ key: string; label: string; help: string }> = [
  { key: "system", label: "System Prompt (Analyzer)", help: "Persona + output contract for Pass 1." },
  { key: "common_sense", label: "Common-Sense / Domain Rules", help: "Right-of-way, TTC thresholds, behavior taxonomy." },
  { key: "interaction", label: "Interaction Task Prompt", help: "Main task. Placeholders: {cluster_stats} {agent_actions_log} {map_description}" },
  { key: "reviewer", label: "Reviewer Prompt (Pass 2)", help: "Skeptical audit. Placeholders: {cluster_stats} {agent_actions_log} {preliminary_yaml}" },
];

function snapshotLabel(name: string): string {
  return `t=${snapshotTimestamp(name)}s`;
}

type EgoEvent = { t: number | null; text: string };

function normalizeEgoSummary(raw: unknown): EgoEvent[] {
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

function riskColor(level?: unknown): "error" | "warning" | "success" | "default" {
  const l = String(level ?? "").toLowerCase();
  if (l === "high") return "error";
  if (l === "medium") return "warning";
  if (l === "low") return "success";
  return "default";
}

function stringifyValue(v: unknown): string {
  if (Array.isArray(v)) return v.map((x) => String(x)).join(" – ");
  if (v && typeof v === "object") return JSON.stringify(v);
  return String(v);
}

function ResultCard({
  r,
  onDownload,
}: {
  r: ResultEntry;
  onDownload: (cluster: number, raw: string) => void;
}) {
  const meta = (r.meta ?? {}) as Record<string, any>;
  const tokens = meta.token_usage as Record<string, number> | undefined;
  const safety = (meta.safety_assessment ?? {}) as Record<string, any>;
  const params = (meta.parameter_conditions ?? {}) as Record<string, any>;
  const events = useMemo(
    () => normalizeEgoSummary(meta.ego_perspective_summary),
    [meta],
  );
  const timed = useMemo(
    () => events.filter((e) => e.t != null) as { t: number; text: string }[],
    [events],
  );
  const tMin = timed.length ? Math.min(...timed.map((e) => e.t)) : 0;
  const tMax = timed.length ? Math.max(...timed.map((e) => e.t)) : 0;
  const [scrub, setScrub] = useState(tMin);
  useEffect(() => setScrub(tMin), [tMin]);

  const activeEvent = useMemo(() => {
    let cur: { t: number; text: string } | null = null;
    for (const e of timed) {
      if (e.t <= scrub + 1e-6) cur = e;
      else break;
    }
    return cur ?? (timed.length ? timed[0] : null);
  }, [timed, scrub]);

  const collisionRate = safety.collision_rate ?? safety.collision_rate_pct;

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Stack direction="row" alignItems="center" spacing={1} sx={{ mb: 1 }} flexWrap="wrap">
        <Typography variant="h6" sx={{ flexGrow: 1 }}>
          Cluster {r.cluster}
          {meta.cluster_label ? `: ${meta.cluster_label}` : ""}
        </Typography>
        {meta.confidence && <Chip size="small" label={`confidence: ${meta.confidence}`} />}
        {safety.risk_level && (
          <Chip size="small" color={riskColor(safety.risk_level)} label={`risk: ${safety.risk_level}`} />
        )}
        {collisionRate != null && (
          <Chip
            size="small"
            color={Number(String(collisionRate).replace("%", "")) > 0 ? "error" : "default"}
            label={`collision ${collisionRate}${String(collisionRate).includes("%") ? "" : "%"}`}
          />
        )}
        {tokens?.Total != null && <Chip size="small" variant="outlined" label={`${tokens.Total} tokens`} />}
        <Button size="small" onClick={() => onDownload(r.cluster, r.rawYaml)}>
          Download YAML
        </Button>
      </Stack>

      {meta.behavior_description && (
        <Typography variant="body2" sx={{ whiteSpace: "pre-line", mb: 1.5 }}>
          {meta.behavior_description}
        </Typography>
      )}

      {safety.failure_mode && String(safety.failure_mode).toLowerCase() !== "none" && (
        <Alert severity="warning" variant="outlined" sx={{ mb: 1.5, py: 0 }}>
          <Typography variant="caption">
            <strong>Failure mode:</strong> {String(safety.failure_mode)}
          </Typography>
        </Alert>
      )}

      {Object.keys(params).length > 0 && (
        <Box sx={{ mb: 1.5 }}>
          <Typography variant="subtitle2" gutterBottom>
            Parameter conditions
          </Typography>
          <Stack spacing={0.25}>
            {Object.entries(params).map(([key, val]) => (
              <Typography key={key} variant="caption" color="text.secondary">
                <strong>{key}:</strong> {stringifyValue(val)}
              </Typography>
            ))}
          </Stack>
        </Box>
      )}

      {timed.length > 0 && (
        <Box sx={{ mb: 1.5 }}>
          <Typography variant="subtitle2" gutterBottom>
            Ego-perspective timeline (scrub to replay)
          </Typography>
          <Box
            sx={{
              p: 1.25,
              mb: 1,
              minHeight: 52,
              borderRadius: 1,
              bgcolor: "primary.main",
              color: "primary.contrastText",
            }}
          >
            <Typography variant="caption" sx={{ opacity: 0.85 }}>
              t = {activeEvent ? activeEvent.t.toFixed(2) : scrub.toFixed(2)} s
            </Typography>
            <Typography variant="body2">{activeEvent?.text ?? "—"}</Typography>
          </Box>
          <Slider
            size="small"
            min={tMin}
            max={tMax === tMin ? tMin + 1 : tMax}
            step={0.05}
            value={scrub}
            marks={timed.map((e) => ({ value: e.t }))}
            valueLabelDisplay="auto"
            valueLabelFormat={(v) => `${Number(v).toFixed(1)}s`}
            onChange={(_, v) => setScrub(v as number)}
          />
          <Stack spacing={0.25} sx={{ mt: 0.5 }}>
            {timed.map((e, i) => {
              const isActive = activeEvent != null && e.t === activeEvent.t && e.text === activeEvent.text;
              return (
                <Typography
                  key={`${e.t}-${i}`}
                  variant="caption"
                  onClick={() => setScrub(e.t)}
                  sx={{
                    cursor: "pointer",
                    px: 0.5,
                    borderRadius: 0.5,
                    bgcolor: isActive ? "action.selected" : "transparent",
                    fontWeight: isActive ? 700 : 400,
                  }}
                >
                  <strong>t={e.t.toFixed(2)}s</strong> — {e.text}
                </Typography>
              );
            })}
          </Stack>
        </Box>
      )}

      <Accordion disableGutters elevation={0} square>
        <AccordionSummary expandIcon={<ExpandMore />}>
          <Typography fontSize={13}>Raw YAML</Typography>
        </AccordionSummary>
        <AccordionDetails>
          <Box
            component="pre"
            sx={{
              m: 0,
              p: 1.5,
              bgcolor: "action.hover",
              borderRadius: 1,
              fontSize: 12,
              overflowX: "auto",
              whiteSpace: "pre-wrap",
            }}
          >
            {r.rawYaml || "(empty)"}
          </Box>
        </AccordionDetails>
      </Accordion>
    </Paper>
  );
}

export default function AnalyzeClient({
  batchId,
  ego,
  k,
  s,
}: {
  batchId: string;
  ego: string;
  k: string;
  s: string;
}) {
  const router = useRouter();

  const [config, setConfig] = useState<Config | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [needsBuild, setNeedsBuild] = useState(false);
  const [availableFolders, setAvailableFolders] = useState<string[]>([]);
  const [requestedFolder, setRequestedFolder] = useState(
    s ? `${k}_cluster_s=${s}` : `${k}_cluster`,
  );

  // --- build-dataset state (when preprocess folder is missing) ---
  const [building, setBuilding] = useState(false);
  const [buildJobId, setBuildJobId] = useState<string | null>(null);
  const [buildPct, setBuildPct] = useState(0);
  const [buildStage, setBuildStage] = useState("");
  const [buildLogs, setBuildLogs] = useState("");
  const [buildError, setBuildError] = useState<string | null>(null);
  const buildLogRef = useRef<HTMLPreElement>(null);

  // --- model setup ---
  const [model, setModel] = useState<string>("gemini-2.5-flash");
  const [apiKey, setApiKey] = useState<string>("");
  const [temperature, setTemperature] = useState<number>(0.1);
  const [review, setReview] = useState<boolean>(true);
  const [dryRun, setDryRun] = useState<boolean>(false);

  // --- evaluation tab ---
  const [activeTab, setActiveTab] = useState<number>(0);
  const [evalConfigs, setEvalConfigs] = useState<ClusteringQuality[]>([]);
  const [evalLoading, setEvalLoading] = useState(false);
  const [evalRunning, setEvalRunning] = useState(false);
  const [evalError, setEvalError] = useState<string | null>(null);

  // --- prompts (editable) ---
  const [prompts, setPrompts] = useState<Record<string, string>>({});
  const [models, setModels] = useState<ModelOption[]>([]);

  // --- per-cluster image selection + which clusters to run ---
  const [selected, setSelected] = useState<Record<number, string[]>>({});
  const [runClusters, setRunClusters] = useState<Set<number>>(new Set());
  const [autoCount, setAutoCount] = useState<number>(10);

  // --- run state ---
  const [running, setRunning] = useState<boolean>(false);
  const [activeClusters, setActiveClusters] = useState<number[]>([]);
  const [results, setResults] = useState<ResultEntry[]>([]);
  const [logs, setLogs] = useState<string>("");
  const [logFile, setLogFile] = useState<string>("");
  const [runError, setRunError] = useState<string | null>(null);
  const logBoxRef = useRef<HTMLPreElement>(null);

  const applyConfig = useCallback(
    (cfg: Config) => {
      setConfig(cfg);
      setNeedsBuild(false);
      setPrompts(cfg.prompts ?? {});
      if (cfg.models?.length) {
        setModels(cfg.models);
        setModel(cfg.models[0].id);
      }
      const sel: Record<number, string[]> = {};
      for (const c of cfg.clusters) {
        sel[c.cluster] = selectDefaultSnapshots(c.snapshots, autoCount, c.medoid);
      }
      setSelected(sel);
      setRunClusters(new Set(cfg.clusters.map((c) => c.cluster)));
      if (cfg.results?.length) setResults(cfg.results);
    },
    [autoCount],
  );

  const reloadConfig = useCallback(async () => {
    const res = await fetch(
      `/api/cluster-analyze?batchId=${encodeURIComponent(batchId)}&k=${encodeURIComponent(k)}&s=${encodeURIComponent(s)}`,
    );
    const data = await res.json();
    if (!res.ok) {
      if (data?.missing) {
        setNeedsBuild(true);
        setConfig(null);
        setAvailableFolders(data.availableFolders ?? []);
        setRequestedFolder(data.requestedFolder ?? `${k}_cluster_s=${s}`);
        setPrompts(data.prompts ?? {});
        if (data.models?.length) {
          setModels(data.models);
          setModel(data.models[0].id);
        }
        return;
      }
      throw new Error(data.error ?? `HTTP ${res.status}`);
    }
    applyConfig(data as Config);
  }, [applyConfig, batchId, k, s]);

  // Load evaluation configs
  useEffect(() => {
    if (!batchId) return;
    fetch(`/api/cluster-evaluate?batchId=${encodeURIComponent(batchId)}`)
      .then((r) => r.json())
      .then((d) => setEvalConfigs(d.configs ?? []))
      .catch(() => {});
  }, [batchId]);

  const runCrossClusterEval = async () => {
    if (!config?.folder) return;
    setEvalRunning(true);
    setEvalError(null);
    try {
      const res = await fetch("/api/cluster-evaluate/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ batchId: Number(batchId), folder: config.folder, model, apiKey: apiKey || undefined }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      // Refresh eval configs
      const r2 = await fetch(`/api/cluster-evaluate?batchId=${encodeURIComponent(batchId)}`);
      const d2 = await r2.json();
      setEvalConfigs(d2.configs ?? []);
    } catch (err) {
      setEvalError(String(err));
    } finally {
      setEvalRunning(false);
    }
  };

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        setLoadError(null);
        const res = await fetch(
          `/api/cluster-analyze?batchId=${encodeURIComponent(batchId)}&k=${encodeURIComponent(k)}&s=${encodeURIComponent(s)}`,
        );
        const data = await res.json();
        if (cancelled) return;
        if (!res.ok) {
          if (data?.missing) {
            setNeedsBuild(true);
            setConfig(null);
            setAvailableFolders(data.availableFolders ?? []);
            setRequestedFolder(data.requestedFolder ?? `${k}_cluster_s=${s}`);
            setPrompts(data.prompts ?? {});
            if (data.models?.length) {
              setModels(data.models);
              setModel(data.models[0].id);
            }
            return;
          }
          throw new Error(data.error ?? `HTTP ${res.status}`);
        }
        applyConfig(data as Config);
      } catch (err) {
        if (!cancelled) setLoadError(String(err));
      }
    })();
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [batchId, k, s]);

  useEffect(() => {
    const el = buildLogRef.current;
    if (el) el.scrollTop = el.scrollHeight;
  }, [buildLogs]);

  const stopBuild = useCallback(async () => {
    if (!buildJobId) return;
    try {
      await fetch("/api/cluster-build/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "stop", jobId: buildJobId }),
      });
    } catch {
      /* best-effort */
    }
  }, [buildJobId]);

  const startBuild = useCallback(async () => {
    if (building) return;
    setBuilding(true);
    setBuildError(null);
    setBuildLogs("");
    setBuildPct(0);
    setBuildStage("starting");
    setBuildJobId(null);
    try {
      const res = await fetch("/api/cluster-build/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ batchId, k, s }),
      });
      if (!res.ok || !res.body) {
        const data = await res.json().catch(() => ({}));
        throw new Error(data.error ?? `HTTP ${res.status}`);
      }
      const reader = res.body.getReader();
      const decoder = new TextDecoder();
      let buf = "";
      while (true) {
        const { done, value } = await reader.read();
        if (done) break;
        buf += decoder.decode(value, { stream: true });
        const lines = buf.split("\n");
        buf = lines.pop() ?? "";
        for (const line of lines) {
          if (!line.trim()) continue;
          let msg: Record<string, unknown>;
          try {
            msg = JSON.parse(line);
          } catch {
            continue;
          }
          if (msg.type === "start" && msg.jobId) {
            setBuildJobId(String(msg.jobId));
          } else if (msg.type === "log" && typeof msg.data === "string") {
            setBuildLogs((prev) => prev + msg.data);
          } else if (msg.type === "progress") {
            if (typeof msg.pct === "number") setBuildPct(msg.pct);
            if (typeof msg.stage === "string") setBuildStage(msg.stage);
          } else if (msg.type === "done") {
            if (msg.stopped) {
              setBuildError("Build stopped by user.");
            } else if (!msg.ok) {
              setBuildError(`Build exited with code ${msg.exitCode}. Check the log below.`);
            } else {
              // Reload the exact folder now that preprocess exists.
              await reloadConfig();
            }
          }
        }
      }
    } catch (err) {
      setBuildError(String(err));
    } finally {
      setBuilding(false);
      setBuildJobId(null);
    }
  }, [batchId, building, k, reloadConfig, s]);

  const imgUrl = useCallback(
    (cluster: number, file: string) =>
      `/api/cluster-analyze?batchId=${encodeURIComponent(batchId)}&folder=${encodeURIComponent(
        config?.folder ?? "",
      )}&cluster=${cluster}&file=${encodeURIComponent(file)}`,
    [batchId, config?.folder],
  );

  const toggleImage = (cluster: number, file: string) => {
    setSelected((prev) => {
      const cur = new Set(prev[cluster] ?? []);
      if (cur.has(file)) cur.delete(file);
      else cur.add(file);
      return { ...prev, [cluster]: Array.from(cur) };
    });
  };

  const applyAuto = (cluster: number, snapshots: string[], medoid?: Record<string, unknown> | null) => {
    setSelected((prev) => ({
      ...prev,
      [cluster]: selectDefaultSnapshots(snapshots, autoCount, medoid),
    }));
  };

  const toggleRunCluster = (cluster: number) => {
    setRunClusters((prev) => {
      const next = new Set(prev);
      if (next.has(cluster)) next.delete(cluster);
      else next.add(cluster);
      return next;
    });
  };

  const provider = useMemo(
    () => (model.startsWith("gpt") || model.startsWith("o") ? "OpenAI" : "Google"),
    [model],
  );

  const analyzedClusters = useMemo(
    () => new Set(results.map((r) => r.cluster)),
    [results],
  );

  // Progress: count completed clusters ("✓ clusterN →") against the active run.
  const completedCount = useMemo(
    () => (logs.match(/✓ cluster\d+ →/g) ?? []).length,
    [logs],
  );
  const progressPct =
    activeClusters.length > 0
      ? Math.min(100, (completedCount / activeClusters.length) * 100)
      : 0;

  // Keep the live log scrolled to the bottom as it streams.
  useEffect(() => {
    const el = logBoxRef.current;
    if (el) el.scrollTop = el.scrollHeight;
  }, [logs]);

  // Merge incoming results into existing ones (per-cluster runs accumulate).
  const mergeResults = useCallback((incoming: ResultEntry[]) => {
    setResults((prev) => {
      const map = new Map<number, ResultEntry>();
      for (const r of prev) map.set(r.cluster, r);
      for (const r of incoming) map.set(r.cluster, r);
      return [...map.values()].sort((a, b) => a.cluster - b.cluster);
    });
  }, []);

  const run = async (subset?: number[]) => {
    if (!config || running) return;
    const clustersToRun = (subset && subset.length ? subset : [...runClusters]).sort(
      (a, b) => a - b,
    );
    if (clustersToRun.length === 0) return;

    setRunning(true);
    setActiveClusters(clustersToRun);
    setLogs("");
    setLogFile("");
    setRunError(null);
    try {
      const selectedImages: Record<string, string[]> = {};
      for (const c of clustersToRun) selectedImages[String(c)] = selected[c] ?? [];
      const res = await fetch("/api/cluster-analyze/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          batchId,
          folder: config.folder,
          clusters: clustersToRun,
          model,
          apiKey,
          temperature,
          review,
          dryRun,
          prompts,
          selectedImages,
        }),
      });

      // Non-streaming fallback (e.g. error responses are JSON).
      if (!res.body || !res.headers.get("content-type")?.includes("ndjson")) {
        const data = await res.json();
        if (Array.isArray(data.results)) mergeResults(data.results);
        setLogs(data.logs ?? data.error ?? "");
        if (!data.ok) setRunError(`Run failed (code ${data.exitCode ?? "?"}).`);
        return;
      }

      const reader = res.body.getReader();
      const decoder = new TextDecoder();
      let buf = "";
      let live = "";
      for (;;) {
        const { value, done } = await reader.read();
        if (done) break;
        buf += decoder.decode(value, { stream: true });
        let nl: number;
        while ((nl = buf.indexOf("\n")) >= 0) {
          const line = buf.slice(0, nl);
          buf = buf.slice(nl + 1);
          if (!line.trim()) continue;
          let msg: any;
          try {
            msg = JSON.parse(line);
          } catch {
            continue;
          }
          if (msg.type === "log") {
            live += msg.data;
            setLogs(live);
          } else if (msg.type === "done") {
            if (Array.isArray(msg.results)) mergeResults(msg.results);
            if (msg.logFile) setLogFile(String(msg.logFile));
            if (!msg.ok) {
              setRunError(`Run exited with code ${msg.exitCode}. Check the live log below.`);
            }
          }
        }
      }
    } catch (err) {
      setRunError(String(err));
    } finally {
      setRunning(false);
      setActiveClusters([]);
    }
  };

  const downloadYaml = (cluster: number, raw: string) => {
    const blob = new Blob([raw], { type: "text/yaml" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `cluster${cluster}_interpretation.yaml`;
    a.click();
    URL.revokeObjectURL(url);
  };

  if (loadError) {
    return (
      <Container sx={{ py: 4 }}>
        <Button startIcon={<ArrowBack />} onClick={() => router.push(`/batch/${batchId}`)}>
          Back to batch
        </Button>
        <Alert severity="error" sx={{ mt: 2 }}>
          Failed to load analysis config: {loadError}
        </Alert>
      </Container>
    );
  }

  // Preprocess folder missing for this exact k + silhouette — offer Build dataset.
  // Do NOT fall back to another silhouette's BEV / interpretation.
  if (needsBuild && !config) {
    return (
      <Container maxWidth="md" sx={{ py: 4 }}>
        <Stack direction="row" alignItems="center" spacing={2} sx={{ mb: 2 }}>
          <IconButton onClick={() => router.push(`/batch/${batchId}`)} aria-label="back">
            <ArrowBack />
          </IconButton>
          <Box>
            <Typography variant="h5">LLM Cluster Analysis</Typography>
            <Typography variant="body2" color="text.secondary">
              batch {batchId} · ego {ego} · {requestedFolder}
            </Typography>
          </Box>
        </Stack>

        <Alert severity="info" sx={{ mb: 2 }}>
          No preprocess dataset for <strong>{requestedFolder}</strong>. Build
          snapshots / action.yaml / cluster.json first before LLM analysis.
          {availableFolders.length > 0 && (
            <>
              <br />
              Other k={k} folders on disk:{" "}
              <code>{availableFolders.join(", ")}</code> — these are different
              silhouette results and will not be shown here.
            </>
          )}
        </Alert>

        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="body2" color="text.secondary" sx={{ mb: 1.5 }}>
            Runs{" "}
            <Box component="code" sx={{ fontSize: 12 }}>
              {`python3 app/analyzer/src/dataset_builder.py --batch-id ${batchId} --k ${k} --silhouette ${s}`}
            </Box>
          </Typography>
          <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 1.5 }}>
            <Button
              variant="contained"
              disabled={building}
              onClick={startBuild}
              startIcon={building ? <CircularProgress size={16} color="inherit" /> : undefined}
            >
              {building ? "Building dataset…" : "Build dataset"}
            </Button>
            {building && (
              <Button variant="outlined" color="error" onClick={stopBuild}>
                Stop
              </Button>
            )}
          </Stack>
          {(building || buildPct > 0) && (
            <Box sx={{ mb: 1.5 }}>
              <Stack direction="row" justifyContent="space-between" sx={{ mb: 0.5 }}>
                <Typography variant="caption" color="text.secondary">
                  {buildStage || "working…"}
                </Typography>
                <Typography variant="caption" color="text.secondary">
                  {Math.round(buildPct)}%
                </Typography>
              </Stack>
              <LinearProgress variant="determinate" value={buildPct} />
            </Box>
          )}
          {buildError && (
            <Alert severity="error" sx={{ mb: 1.5 }}>
              {buildError}
            </Alert>
          )}
          {buildLogs && (
            <Box
              component="pre"
              ref={buildLogRef}
              sx={{
                m: 0,
                p: 1.5,
                maxHeight: 320,
                overflow: "auto",
                bgcolor: "grey.900",
                color: "grey.100",
                borderRadius: 1,
                fontSize: 11,
                whiteSpace: "pre-wrap",
              }}
            >
              {buildLogs}
            </Box>
          )}
        </Paper>
      </Container>
    );
  }

  if (!config) {
    return (
      <Stack alignItems="center" justifyContent="center" sx={{ height: "60vh" }}>
        <CircularProgress />
        <Typography sx={{ mt: 2 }}>Loading clustering result…</Typography>
      </Stack>
    );
  }

  // Find quality entry for current folder
  const currentQuality = evalConfigs.find((c) => c.folder === config.folder);
  const currentBoundaryPairs = currentQuality?.boundary_pairs ?? [];
  const currentCrossEval = currentQuality?.cross_cluster_eval;

  return (
    <Container maxWidth="xl" sx={{ py: 3 }}>
      {/* Header */}
      <Stack direction="row" alignItems="center" spacing={2} sx={{ mb: 2 }}>
        <IconButton onClick={() => router.push(`/batch/${batchId}`)} aria-label="back">
          <ArrowBack />
        </IconButton>
        <Box>
          <Typography variant="h5">LLM Cluster Analysis</Typography>
          <Typography variant="body2" color="text.secondary">
            batch {batchId} · ego {ego} · {config.folder}
          </Typography>
        </Box>
      </Stack>

      <Tabs value={activeTab} onChange={(_, v) => setActiveTab(v)} sx={{ mb: 2 }}>
        <Tab label="Analysis" />
        <Tab label={`Evaluation${currentQuality ? ` (score ${currentQuality.final_score?.toFixed(1)})` : ""}`} />
      </Tabs>

      {/* ===== EVALUATION TAB ===== */}
      {activeTab === 1 && (
        <Stack spacing={2}>
          {/* Run button */}
          <Paper variant="outlined" sx={{ p: 2 }}>
            <Stack direction="row" alignItems="center" spacing={2} flexWrap="wrap">
              <Button
                variant="contained"
                disabled={evalRunning}
                onClick={runCrossClusterEval}
                startIcon={evalRunning ? <CircularProgress size={16} color="inherit" /> : undefined}
              >
                {evalRunning ? "Running LLM eval…" : "Run Cross-Cluster Eval (LLM)"}
              </Button>
              <Typography variant="caption" color="text.secondary">
                Requires a valid API key (set in the Analysis tab). Updates the composite score with the LLM behavioral layer.
              </Typography>
            </Stack>
            {evalError && <Alert severity="error" sx={{ mt: 1 }}>{evalError}</Alert>}
          </Paper>

          {/* All configs ranking table */}
          {evalConfigs.length > 0 && (
            <Paper variant="outlined" sx={{ p: 2 }}>
              <Typography variant="h6" gutterBottom>All Clustering Configurations (ranked)</Typography>
              <Table size="small">
                <TableHead>
                  <TableRow>
                    <TableCell>Rank</TableCell>
                    <TableCell>Config</TableCell>
                    <TableCell align="right">k</TableCell>
                    <TableCell align="right">Silhouette</TableCell>
                    <TableCell align="right">Rule Score</TableCell>
                    <TableCell align="right">LLM Score</TableCell>
                    <TableCell align="right">Final Score</TableCell>
                    <TableCell>LLM Eval?</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {evalConfigs.map((c) => (
                    <TableRow
                      key={c.folder}
                      sx={{ bgcolor: c.folder === config.folder ? "action.selected" : undefined }}
                    >
                      <TableCell><strong>#{c.rank ?? "—"}</strong></TableCell>
                      <TableCell sx={{ fontFamily: "monospace", fontSize: 12 }}>{c.folder}</TableCell>
                      <TableCell align="right">{c.k ?? "—"}</TableCell>
                      <TableCell align="right">{c.silhouette?.toFixed(4) ?? "—"}</TableCell>
                      <TableCell align="right">{c.rule_score?.toFixed(1)}</TableCell>
                      <TableCell align="right">{c.llm_score != null ? c.llm_score.toFixed(1) : "—"}</TableCell>
                      <TableCell align="right"><strong>{c.final_score?.toFixed(1)}</strong></TableCell>
                      <TableCell>
                        <Chip
                          size="small"
                          label={c.has_llm_eval ? "Yes" : "Rule only"}
                          color={c.has_llm_eval ? "primary" : "default"}
                        />
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </Paper>
          )}

          {/* Current config: per-cluster intra panel */}
          {config.clusters.length > 0 && (
            <Paper variant="outlined" sx={{ p: 2 }}>
              <Typography variant="h6" gutterBottom>Per-Cluster Intra Variance</Typography>
              <Stack spacing={1}>
                {config.clusters.map((cl) => {
                  const iv = cl.intraVariance as Record<string, unknown> | null;
                  if (!iv) return null;
                  const outlierIds = (iv.outlier_trial_ids as string[] | undefined) ?? [];
                  const outlierColl = (iv.outlier_collision as boolean[] | undefined) ?? [];
                  const meta = results.find((r) => r.cluster === cl.cluster);
                  const intraScore = (meta?.meta as Record<string, unknown> | null)?.intra_consistency_score;
                  return (
                    <Paper key={cl.cluster} variant="outlined" sx={{ p: 1.5 }}>
                      <Stack direction="row" alignItems="center" spacing={1} flexWrap="wrap">
                        <Typography fontWeight="bold">Cluster {cl.cluster}</Typography>
                        {Boolean((meta?.meta as Record<string, unknown> | null)?.cluster_label) && (
                          <Chip size="small" label={String((meta!.meta as Record<string,unknown>).cluster_label)} />
                        )}
                        {intraScore != null && (
                          <Chip
                            size="small"
                            color={Number(intraScore) >= 7 ? "success" : Number(intraScore) >= 5 ? "warning" : "error"}
                            label={`consistency ${intraScore}/10`}
                          />
                        )}
                      </Stack>
                      <Stack direction="row" spacing={2} sx={{ mt: 0.5 }} flexWrap="wrap">
                        <Typography variant="caption">mean dist: {String(iv.mean_dist_to_medoid ?? "—")}</Typography>
                        <Typography variant="caption">std: {String(iv.std_dist_to_medoid ?? "—")}</Typography>
                        <Typography variant="caption">max: {String(iv.max_dist_to_medoid ?? "—")}</Typography>
                        <Typography variant="caption">n_members: {String(iv.n_members ?? "—")}</Typography>
                      </Stack>
                      {outlierIds.length > 0 && (
                        <Typography variant="caption" sx={{ mt: 0.5, display: "block" }}>
                          Outliers: {outlierIds.map((tid, i) => (
                            <span key={tid}>{tid}{outlierColl[i] ? " (COLLISION)" : ""}{i < outlierIds.length - 1 ? ", " : ""}</span>
                          ))}
                        </Typography>
                      )}
                    </Paper>
                  );
                })}
              </Stack>
            </Paper>
          )}

          {/* Inter-cluster notes from cross_cluster_eval.json */}
          {currentCrossEval && (
            <Paper variant="outlined" sx={{ p: 2 }}>
              <Typography variant="h6" gutterBottom>Inter-Cluster Analysis (LLM)</Typography>
              <Stack direction="row" spacing={2} sx={{ mb: 1 }} flexWrap="wrap">
                <Chip
                  label={`Behavioral separation: ${currentCrossEval.behavioral_separation_score ?? "?"}/10`}
                  color="primary"
                  variant="outlined"
                />
                <Chip
                  label={`Boundary clarity: ${currentCrossEval.boundary_clarity_score ?? "?"}/10`}
                  color="secondary"
                  variant="outlined"
                />
              </Stack>
              <Typography variant="body2" sx={{ whiteSpace: "pre-wrap", mb: 1 }}>
                {currentCrossEval.inter_notes}
              </Typography>
              {(currentCrossEval.merge_candidates?.length ?? 0) > 0 && (
                <Alert severity="warning" sx={{ mb: 1 }}>
                  <Typography variant="body2" fontWeight="bold">Merge candidates:</Typography>
                  {currentCrossEval.merge_candidates!.map((m, i) => (
                    <Typography key={i} variant="caption" display="block">{m}</Typography>
                  ))}
                </Alert>
              )}
              {(currentCrossEval.split_candidates?.length ?? 0) > 0 && (
                <Alert severity="info">
                  <Typography variant="body2" fontWeight="bold">Split candidates:</Typography>
                  {currentCrossEval.split_candidates!.map((m, i) => (
                    <Typography key={i} variant="caption" display="block">{m}</Typography>
                  ))}
                </Alert>
              )}
            </Paper>
          )}

          {/* Boundary comparison (Phase J) */}
          {currentBoundaryPairs.length > 0 && (
            <BoundaryComparePanel
              batchId={batchId}
              folder={config.folder}
              boundaryPairs={currentBoundaryPairs}
              crossEval={currentCrossEval}
            />
          )}
        </Stack>
      )}

      {/* ===== ANALYSIS TAB (existing content) ===== */}
      {activeTab === 0 && (
      <Stack direction={{ xs: "column", md: "row" }} spacing={2} alignItems="flex-start">
        {/* LEFT: model + prompts */}
        <Stack spacing={2} sx={{ flex: 1, minWidth: 0, width: "100%" }}>
          <Paper variant="outlined" sx={{ p: 2 }}>
            <Typography variant="h6" gutterBottom>
              Model setup
            </Typography>
            <Stack spacing={2}>
              <Box>
                <Typography variant="body2" gutterBottom>
                  Model ({provider})
                </Typography>
                <Select size="small" fullWidth value={model} onChange={(e) => setModel(String(e.target.value))}>
                  {config.models.map((m) => (
                    <MenuItem key={m.id} value={m.id}>
                      {m.id} — {m.provider}
                    </MenuItem>
                  ))}
                </Select>
              </Box>
              <TextField
                size="small"
                fullWidth
                type="password"
                label={`${provider} API Key (ephemeral)`}
                value={apiKey}
                onChange={(e) => setApiKey(e.target.value)}
                helperText="Sent only for this run; never stored. Leave blank + Dry run to test wiring."
              />
              <Box>
                <Typography variant="body2" gutterBottom>
                  Temperature: {temperature.toFixed(2)}
                </Typography>
                <Slider
                  size="small"
                  min={0}
                  max={1}
                  step={0.1}
                  value={temperature}
                  onChange={(_, v) => setTemperature(v as number)}
                />
              </Box>
              <Stack direction="row" spacing={2}>
                <FormControlLabel
                  control={<Switch checked={review} onChange={(e) => setReview(e.target.checked)} />}
                  label="Reviewer pass"
                />
                <FormControlLabel
                  control={<Switch checked={dryRun} onChange={(e) => setDryRun(e.target.checked)} />}
                  label="Dry run (stub)"
                />
              </Stack>
            </Stack>
          </Paper>

          <Paper variant="outlined" sx={{ p: 2 }}>
            <Typography variant="h6" gutterBottom>
              Prompts
            </Typography>
            {PROMPT_LABELS.map(({ key, label, help }) => (
              <Accordion key={key} disableGutters elevation={0} square>
                <AccordionSummary expandIcon={<ExpandMore />}>
                  <Typography fontSize={14}>{label}</Typography>
                </AccordionSummary>
                <AccordionDetails>
                  <TextField
                    multiline
                    fullWidth
                    minRows={5}
                    maxRows={18}
                    value={prompts[key] ?? ""}
                    onChange={(e) => setPrompts((p) => ({ ...p, [key]: e.target.value }))}
                    helperText={help}
                    slotProps={{ htmlInput: { style: { fontFamily: "monospace", fontSize: 12 } } }}
                  />
                </AccordionDetails>
              </Accordion>
            ))}
          </Paper>
        </Stack>

        {/* RIGHT: clusters + BEV selection + run + results */}
        <Stack spacing={2} sx={{ flex: 1.3, minWidth: 0, width: "100%" }}>
          <Paper variant="outlined" sx={{ p: 2 }}>
            <Stack direction="row" alignItems="center" spacing={2} sx={{ mb: 1 }} flexWrap="wrap">
              <Typography variant="h6" sx={{ flexGrow: 1 }}>
                Clusters &amp; snapshots
              </Typography>
              <Stack direction="row" alignItems="center" spacing={1}>
                <Typography variant="body2">Auto count</Typography>
                <Select size="small" value={autoCount} onChange={(e) => setAutoCount(Number(e.target.value))}>
                  {[3, 5, 8, 10, 12, 16, 20].map((n) => (
                    <MenuItem key={n} value={n}>
                      {n}
                    </MenuItem>
                  ))}
                </Select>
                <Typography variant="caption" color="text.secondary">
                  Default: ±2 frames around NEAR_MISS / COLLISION, rest evenly spaced
                </Typography>
              </Stack>
            </Stack>

            <Stack spacing={2}>
              {config.clusters.map((c) => {
                const sel = new Set(selected[c.cluster] ?? []);
                const collisionRate = (c.stats as any)?.collision_rate;
                const nTrials = (c.stats as any)?.n_trials ?? (c.stats as any)?.size;
                const medoidTrial = (c.medoid as any)?.trial_id;
                return (
                  <Box key={c.cluster}>
                    <Stack direction="row" alignItems="center" spacing={1} flexWrap="wrap">
                      <FormControlLabel
                        control={
                          <Checkbox
                            checked={runClusters.has(c.cluster)}
                            onChange={() => toggleRunCluster(c.cluster)}
                          />
                        }
                        label={<Typography fontWeight={600}>Cluster {c.cluster}</Typography>}
                      />
                      {collisionRate != null && (
                        <Chip
                          size="small"
                          color={Number(collisionRate) > 0 ? "error" : "default"}
                          label={`collision ${collisionRate}%`}
                        />
                      )}
                      {nTrials != null && <Chip size="small" label={`${nTrials} trials`} />}
                      {medoidTrial != null && <Chip size="small" variant="outlined" label={`medoid ${medoidTrial}`} />}
                      {analyzedClusters.has(c.cluster) && (
                        <Chip size="small" color="success" variant="outlined" label="analyzed" />
                      )}
                      <Box sx={{ flexGrow: 1 }} />
                      <Typography variant="caption" color="text.secondary">
                        {sel.size}/{c.snapshots.length} selected
                      </Typography>
                      <Button size="small" onClick={() => applyAuto(c.cluster, c.snapshots, c.medoid)}>
                        Auto
                      </Button>
                      <Button
                        size="small"
                        onClick={() => setSelected((p) => ({ ...p, [c.cluster]: [] }))}
                      >
                        None
                      </Button>
                      <Button
                        size="small"
                        variant="outlined"
                        disabled={running || (selected[c.cluster] ?? []).length === 0}
                        onClick={() => run([c.cluster])}
                        startIcon={
                          running && activeClusters.length === 1 && activeClusters[0] === c.cluster ? (
                            <CircularProgress size={14} color="inherit" />
                          ) : undefined
                        }
                      >
                        Analyze
                      </Button>
                    </Stack>
                    <Box
                      sx={{
                        display: "grid",
                        gridTemplateColumns: "repeat(auto-fill, minmax(150px, 1fr))",
                        gap: 1,
                        mt: 1,
                        maxHeight: 320,
                        overflowY: "auto",
                        p: 0.5,
                      }}
                    >
                      {c.snapshots.map((file) => {
                        const isSel = sel.has(file);
                        return (
                          <Box
                            key={file}
                            onClick={() => toggleImage(c.cluster, file)}
                            sx={{
                              position: "relative",
                              cursor: "pointer",
                              border: "2px solid",
                              borderColor: isSel ? "primary.main" : "transparent",
                              borderRadius: 1,
                              overflow: "hidden",
                              opacity: isSel ? 1 : 0.55,
                            }}
                          >
                            {/* eslint-disable-next-line @next/next/no-img-element */}
                            <img
                              src={imgUrl(c.cluster, file)}
                              alt={file}
                              loading="lazy"
                              style={{ width: "100%", display: "block" }}
                            />
                            <Checkbox
                              size="small"
                              checked={isSel}
                              sx={{ position: "absolute", top: 0, left: 0, p: 0.25 }}
                            />
                            <Typography
                              variant="caption"
                              sx={{
                                position: "absolute",
                                bottom: 0,
                                width: "100%",
                                bgcolor: "rgba(0,0,0,0.55)",
                                color: "#fff",
                                px: 0.5,
                              }}
                            >
                              {snapshotLabel(file)}
                            </Typography>
                          </Box>
                        );
                      })}
                    </Box>
                    <Divider sx={{ mt: 1 }} />
                  </Box>
                );
              })}
            </Stack>
          </Paper>

          <Paper variant="outlined" sx={{ p: 2 }}>
            <Stack direction="row" alignItems="center" spacing={2} flexWrap="wrap">
              <Button
                variant="contained"
                disabled={running || runClusters.size === 0}
                onClick={() => run()}
                startIcon={running ? <CircularProgress size={16} color="inherit" /> : undefined}
              >
                {running
                  ? "Analyzing…"
                  : `Run all selected (${runClusters.size} cluster${runClusters.size === 1 ? "" : "s"})`}
              </Button>
              <Typography variant="caption" color="text.secondary">
                Tip: use a cluster&apos;s <strong>Analyze</strong> button to run one at a time and save API quota.
              </Typography>
              {!apiKey && !dryRun && (
                <Typography variant="caption" color="warning.main">
                  No API key entered — server env key will be used if present, else a stub is written.
                </Typography>
              )}
            </Stack>

            {(running || logs) && (
              <Box sx={{ mt: 2 }}>
                <Stack direction="row" alignItems="center" spacing={1} sx={{ mb: 0.5 }}>
                  <Typography variant="body2" sx={{ flexGrow: 1 }}>
                    {running
                      ? `Running ${activeClusters.length} cluster${activeClusters.length === 1 ? "" : "s"}` +
                        (activeClusters.length ? ` — ${completedCount}/${activeClusters.length} done` : "")
                      : "Last run output"}
                  </Typography>
                </Stack>
                <LinearProgress
                  variant={running && progressPct === 0 ? "indeterminate" : "determinate"}
                  value={progressPct}
                  sx={{ mb: 1, borderRadius: 1 }}
                />
                <Box
                  component="pre"
                  ref={logBoxRef}
                  sx={{
                    m: 0,
                    p: 1,
                    bgcolor: "#0b0b0b",
                    color: "#d6e2c4",
                    borderRadius: 1,
                    fontSize: 11,
                    lineHeight: 1.5,
                    maxHeight: 260,
                    overflow: "auto",
                    whiteSpace: "pre-wrap",
                  }}
                >
                  {logs || "(waiting for output…)"}
                </Box>
                {logFile && (
                  <Typography variant="caption" color="text.secondary">
                    Log saved to <code>{logFile}</code>
                  </Typography>
                )}
              </Box>
            )}

            {runError && (
              <Alert severity="error" sx={{ mt: 2 }}>
                {runError}
              </Alert>
            )}
          </Paper>

          {results.length > 0 && (
            <Stack direction="row" alignItems="center" spacing={1}>
              <Typography variant="h6" sx={{ flexGrow: 1 }}>
                Results
              </Typography>
              {!running && (
                <Typography variant="caption" color="text.secondary">
                  {`${results.length} saved interpretation${results.length === 1 ? "" : "s"} loaded from disk — re-run to refresh`}
                </Typography>
              )}
            </Stack>
          )}
          {results.map((r) => (
            <ResultCard key={r.cluster} r={r} onDownload={downloadYaml} />
          ))}
        </Stack>
      </Stack>
      )}
    </Container>
  );
}

// ─── BoundaryCompare Panel (Phase J) ────────────────────────────────────────

type BoundaryPair = {
  cluster_a: number; trial_a: string; collided_a: boolean;
  cluster_b: number; trial_b: string; collided_b: boolean;
  embedding_dist: number;
};

type CrossEvalData = {
  behavioral_separation_score: number | null;
  boundary_clarity_score: number | null;
  inter_notes: string;
  cluster_summaries: Array<{cluster_id: number; archetype: string; intra_score?: number}>;
  merge_candidates?: string[];
  split_candidates?: string[];
} | null | undefined;

function BoundaryComparePanel({
  batchId,
  folder,
  boundaryPairs,
  crossEval,
}: {
  batchId: string;
  folder: string;
  boundaryPairs: BoundaryPair[];
  crossEval?: CrossEvalData;
}) {
  const [selectedPairIdx, setSelectedPairIdx] = useState(0);
  const [descA, setDescA] = useState<string | null>(null);
  const [descB, setDescB] = useState<string | null>(null);
  const [loadingDesc, setLoadingDesc] = useState(false);

  const pair = boundaryPairs[selectedPairIdx];

  useEffect(() => {
    if (!pair) return;
    setLoadingDesc(true);
    // Fetch descriptions from the boundary sub-dirs via a lightweight text API
    const baseUrl = `/api/cluster-analyze?batchId=${batchId}&batchFolder=${folder}`;
    const fetchDesc = (side: "a" | "b") => {
      const clLabel = side === "a" ? pair.cluster_a : pair.cluster_b;
      const otherLabel = side === "a" ? pair.cluster_b : pair.cluster_a;
      const trialId = side === "a" ? pair.trial_a : pair.trial_b;
      return fetch(
        `${baseUrl}&boundaryDesc=1&cluster=${clLabel}&boundaryWith=${otherLabel}`
      )
        .then((r) => r.text())
        .catch(() => "(description not available)");
    };
    Promise.all([fetchDesc("a"), fetchDesc("b")]).then(([a, b]) => {
      setDescA(a || "(description not available)");
      setDescB(b || "(description not available)");
      setLoadingDesc(false);
    });
  }, [pair, batchId, folder]);

  if (!pair) return null;

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>Boundary Trial Comparison</Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
        Trials at the cluster boundary — similar initial conditions, potentially different outcomes.
      </Typography>

      {/* Pair selector */}
      <Select
        size="small"
        value={selectedPairIdx}
        onChange={(e) => setSelectedPairIdx(Number(e.target.value))}
        sx={{ mb: 2, minWidth: 280 }}
      >
        {boundaryPairs.map((bp, i) => (
          <MenuItem key={i} value={i}>
            {`C${bp.cluster_a} ↔ C${bp.cluster_b} — embedding dist ${bp.embedding_dist.toFixed(3)}`}
          </MenuItem>
        ))}
      </Select>

      {/* Outcome badges */}
      <Stack direction="row" spacing={1} sx={{ mb: 2 }}>
        <Chip
          label={`C${pair.cluster_a} trial ${pair.trial_a}${pair.collided_a ? " 💥 COLLISION" : " ✓ safe"}`}
          color={pair.collided_a ? "error" : "success"}
          size="small"
        />
        <Chip
          label={`C${pair.cluster_b} trial ${pair.trial_b}${pair.collided_b ? " 💥 COLLISION" : " ✓ safe"}`}
          color={pair.collided_b ? "error" : "success"}
          size="small"
        />
      </Stack>

      {/* Side-by-side description diff */}
      {loadingDesc ? (
        <CircularProgress size={24} />
      ) : (
        <Stack direction={{ xs: "column", md: "row" }} spacing={2}>
          <Box sx={{ flex: 1 }}>
            <Typography variant="subtitle2" gutterBottom>
              Cluster {pair.cluster_a} — trial {pair.trial_a}
            </Typography>
            <Box
              component="pre"
              sx={{
                p: 1, bgcolor: "background.paper", borderRadius: 1,
                border: "1px solid", borderColor: "divider",
                fontSize: 11, lineHeight: 1.5, whiteSpace: "pre-wrap",
                maxHeight: 320, overflowY: "auto",
              }}
            >
              {descA ?? "(loading…)"}
            </Box>
          </Box>
          <Box sx={{ flex: 1 }}>
            <Typography variant="subtitle2" gutterBottom>
              Cluster {pair.cluster_b} — trial {pair.trial_b}
            </Typography>
            <Box
              component="pre"
              sx={{
                p: 1, bgcolor: "background.paper", borderRadius: 1,
                border: "1px solid", borderColor: "divider",
                fontSize: 11, lineHeight: 1.5, whiteSpace: "pre-wrap",
                maxHeight: 320, overflowY: "auto",
              }}
            >
              {descB ?? "(loading…)"}
            </Box>
          </Box>
        </Stack>
      )}

      {/* LLM caption from cross_cluster_eval */}
      {crossEval?.inter_notes && (
        <Box sx={{ mt: 2 }}>
          <Typography variant="subtitle2">LLM Boundary Analysis:</Typography>
          <Typography variant="body2" color="text.secondary">
            {crossEval.inter_notes}
          </Typography>
        </Box>
      )}
    </Paper>
  );
}
