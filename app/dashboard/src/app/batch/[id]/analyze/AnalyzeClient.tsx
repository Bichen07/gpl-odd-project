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
  trajectory_projection_pairs?: Array<{
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

type SplitClusterCard = {
  cluster: number;
  aggregate: Record<string, unknown> | null;
  summaryYaml: string;
  summaryMeta?: Record<string, unknown> | null;
  medoidYaml: string;
  medoidMeta?: Record<string, unknown> | null;
  touchingIcPairs?: string[];
  missingIcContrasts?: string[];
  readyForSummary?: boolean;
};

type IcPairEntry = {
  name: string;
  yaml: string;
  folder?: string;
  facts?: Record<string, unknown> | null;
  syncedBev?: string[];
  contrastMeta?: Record<string, unknown> | null;
  mergedTimeline?: string;
  processContext?: string;
  hasProcessContext?: boolean;
  hasSyncedBev?: boolean;
  hasContrast?: boolean;
  medoidReady?: boolean;
  readyForLlm?: boolean;
  missing?: string[];
};

type SplitAnalysis = {
  clusters: SplitClusterCard[];
  icPairs: IcPairEntry[];
  crossEval?: Record<string, unknown> | null;
  selectionEval?: Record<string, unknown> | null;
  quality?: Record<string, unknown> | null;
};

type Config = {
  batchId: string;
  folder: string;
  clusters: ClusterEntry[];
  prompts: Record<string, string>;
  models: ModelOption[];
  results?: ResultEntry[];
  splitAnalysis?: SplitAnalysis | null;
};

const PROMPT_LABELS: Array<{ key: string; label: string; help: string }> = [
  { key: "system", label: "System prompt", help: "Persona + CoT/YAML output contract for all products." },
  { key: "common_sense", label: "Domain rules / glossary", help: "Metrics glossary + motive labels shared by all products." },
  { key: "medoid", label: "Medoid trial prompt", help: "Motive / decision timeline for one medoid trial." },
  { key: "summary", label: "Cluster summary prompt", help: "Caption over enriched TTC/IC digests." },
  { key: "parameter_space_pair", label: "Parameter-space closest-pair prompt", help: "Contrast two near-identical parameter-space trials across clusters." },
  {
    key: "cross_eval",
    label: "Cross-cluster eval prompt",
    help: "Grades the whole partition from the medoid + Parameter-space pair cards and the deterministic checks.",
  },
];

// Each tab shows only the prompts its own product actually sends, so the prompt
// on screen is the prompt that runs.
const PROMPT_GROUPS: Record<number, string[]> = {
  0: ["system", "common_sense", "medoid"],
  1: ["system", "common_sense", "parameter_space_pair"],
  2: ["system", "common_sense", "summary"],
};

const TAB_PRODUCTS: Record<number, string> = {
  0: "medoid",
  1: "parameter-space-pairs",
  2: "summary",
};

// Shared typography for contrast-card narrative fields.
const CONTRAST_FIELD_LABEL_SX = { fontSize: 20, fontWeight: 700 };
const CONTRAST_FIELD_BODY_SX = { whiteSpace: "pre-wrap", fontSize: 13, lineHeight: 1.7 };

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
  const [selectedPairs, setSelectedPairs] = useState<Set<string>>(new Set());
  const [autoCount, setAutoCount] = useState<number>(10);

  // --- run state ---
  const [running, setRunning] = useState<boolean>(false);
  const [activeClusters, setActiveClusters] = useState<number[]>([]);
  const [results, setResults] = useState<ResultEntry[]>([]);
  const [splitAnalysis, setSplitAnalysis] = useState<SplitAnalysis | null>(null);
  const [splitSubTab, setSplitSubTab] = useState(0);
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
      setSplitAnalysis(cfg.splitAnalysis ?? null);
      const readyPairs = (cfg.splitAnalysis?.icPairs ?? [])
        .filter((p) => p.folder && p.readyForLlm)
        .map((p) => p.folder as string);
      setSelectedPairs(new Set(readyPairs));
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

  const run = async (
    subset: number[] | undefined,
    productsSpec: string,
    pairFolders?: string[],
  ) => {
    if (!config || running) return;
    const isIcPairs = productsSpec
      .split(",")
      .map((s) => s.trim())
      .includes("parameter-space-pairs");
    const pairsToRun =
      isIcPairs && pairFolders && pairFolders.length > 0
        ? [...pairFolders].sort()
        : undefined;
    const clustersToRun = (subset && subset.length ? subset : [...runClusters]).sort(
      (a, b) => a - b,
    );
    if (!pairsToRun && clustersToRun.length === 0) return;

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
          clusters: pairsToRun ? undefined : clustersToRun,
          pairs: pairsToRun,
          model,
          apiKey,
          temperature,
          review,
          dryRun,
          products: productsSpec,
          prompts,
          selectedImages,
        }),
      });

      // Non-streaming fallback (e.g. error responses are JSON).
      if (!res.body || !res.headers.get("content-type")?.includes("ndjson")) {
        const data = await res.json();
        if (Array.isArray(data.results)) mergeResults(data.results);
        setLogs(data.logs ?? data.error ?? "");
        if (!data.ok && data.error) {
          const detail = Array.isArray(data.details)
            ? `\n${data.details.join("\n")}`
            : "";
          setRunError(`${data.error}${detail}`);
        } else if (!data.ok) {
          setRunError(`Run failed (code ${data.exitCode ?? "?"}).`);
        }
        try {
          await reloadConfig();
        } catch {
          /* ignore */
        }
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
            try {
              await reloadConfig();
            } catch {
              /* keep in-memory results if refresh fails */
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
  const currentBoundaryPairs = currentQuality?.trajectory_projection_pairs ?? [];
  const currentCrossEval = currentQuality?.cross_cluster_eval;

  // "Cluster analysis" prerequisites: medoid + every touching Parameter-space pair contrast.
  const splitClustersForPrereq = splitAnalysis?.clusters ?? [];
  const nClustersNoMedoid = splitClustersForPrereq.filter((c) => !c.medoidYaml).length;
  const icPairsForPrereq = splitAnalysis?.icPairs ?? [];
  const nIcPairsUnbuilt = icPairsForPrereq.filter((p) => !p.hasContrast && !p.yaml).length;
  const clustersMissingIcContrasts = splitClustersForPrereq.filter(
    (c) => (c.missingIcContrasts ?? []).length > 0,
  );
  const summaryBlocked =
    nClustersNoMedoid === splitClustersForPrereq.length ||
    (splitClustersForPrereq.length > 0 &&
      splitClustersForPrereq.every((c) => !c.readyForSummary));
  const anySummaryReady = splitClustersForPrereq.some((c) => c.readyForSummary);

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
        <Tab
          label={`Medoid analysis${
            splitAnalysis?.clusters?.length ? ` (${splitAnalysis.clusters.length})` : ""
          }`}
        />
        <Tab
          label={`Parameter-space pair analysis${
            splitAnalysis?.icPairs?.length ? ` (${splitAnalysis.icPairs.length})` : ""
          }`}
        />
        <Tab
          label={`Cluster analysis${
            currentQuality?.final_score != null
              ? ` (score ${currentQuality.final_score.toFixed(1)})`
              : ""
          }`}
        />
        <Tab label="Run report" />
      </Tabs>

      {/* ===== IC-PAIR ANALYSIS TAB ===== */}
      {activeTab === 1 && (
        <Stack direction={{ xs: "column", md: "row" }} spacing={2} alignItems="flex-start">
          <Stack spacing={2} sx={{ flex: 1, minWidth: 0, width: "100%" }}>
            <PromptsCard
              keys={PROMPT_GROUPS[1]}
              prompts={prompts}
              setPrompts={setPrompts}
              productLabel="parameter-space-pairs"
            />
          </Stack>
          <Stack spacing={2} sx={{ flex: 1.3, minWidth: 0, width: "100%" }}>
            <Paper variant="outlined" sx={{ p: 2 }}>
              <Typography variant="subtitle2" gutterBottom>
                Select Parameter-space pairs to run
              </Typography>
              <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1.5 }}>
                {(splitAnalysis?.icPairs ?? []).map((p) => {
                  const folder = p.folder ?? p.name;
                  const ready = Boolean(p.readyForLlm);
                  const checked = selectedPairs.has(folder);
                  return (
                    <Chip
                      key={folder}
                      label={`${folder}${p.hasContrast ? " ✓" : ""}${ready ? "" : " ⚠"}`}
                      color={checked ? "primary" : "default"}
                      variant={ready ? (checked ? "filled" : "outlined") : "outlined"}
                      disabled={!ready}
                      onClick={() => {
                        if (!ready) return;
                        setSelectedPairs((prev) => {
                          const next = new Set(prev);
                          if (next.has(folder)) next.delete(folder);
                          else next.add(folder);
                          return next;
                        });
                      }}
                      size="small"
                    />
                  );
                })}
              </Stack>
              <Stack direction="row" spacing={1} sx={{ mb: 1.5 }}>
                <Button
                  size="small"
                  onClick={() =>
                    setSelectedPairs(
                      new Set(
                        (splitAnalysis?.icPairs ?? [])
                          .filter((p) => p.folder && p.readyForLlm)
                          .map((p) => p.folder as string),
                      ),
                    )
                  }
                >
                  Select all ready
                </Button>
                <Button size="small" onClick={() => setSelectedPairs(new Set())}>
                  Clear
                </Button>
              </Stack>
              {(splitAnalysis?.icPairs ?? []).some((p) => !p.readyForLlm) && (
                <Alert severity="warning" sx={{ mb: 1.5 }}>
                  Pairs marked ⚠ need both endpoint medoids,{" "}
                  <code>process/context.md</code>, and synced BEVs before LLM.
                  {(splitAnalysis?.icPairs ?? [])
                    .filter((p) => !p.readyForLlm && p.missing?.length)
                    .slice(0, 3)
                    .map((p) => (
                      <Typography key={p.folder} variant="caption" display="block">
                        {p.folder}: {(p.missing ?? []).join(", ")}
                      </Typography>
                    ))}
                </Alert>
              )}
              <Stack direction="row" alignItems="center" spacing={2} flexWrap="wrap">
                <Button
                  variant="contained"
                  disabled={
                    running ||
                    selectedPairs.size === 0 ||
                    ![...selectedPairs].every((f) =>
                      (splitAnalysis?.icPairs ?? []).some(
                        (p) => p.folder === f && p.readyForLlm,
                      ),
                    )
                  }
                  onClick={() =>
                    run(undefined, TAB_PRODUCTS[1], [...selectedPairs])
                  }
                  startIcon={running ? <CircularProgress size={16} color="inherit" /> : undefined}
                >
                  {running
                    ? "Analyzing…"
                    : `Run Parameter-space pair contrast (${selectedPairs.size})`}
                </Button>
                <Typography variant="caption" color="text.secondary">
                  Requires medoid cards for both clusters. Writes{" "}
                  <code>parameter_space_pairs/cA-cB/output/contrast.yaml</code>.
                </Typography>
              </Stack>
              {runError && (
                <Alert severity="error" sx={{ mt: 2 }}>
                  {runError}
                </Alert>
              )}
            </Paper>
            <IcPairPanel
              pairs={splitAnalysis?.icPairs ?? []}
              folder={config.folder}
              batchId={batchId}
              splitClusters={splitAnalysis?.clusters ?? []}
            />
          </Stack>
        </Stack>
      )}

      {/* ===== EVALUATION (inside cluster analysis) ===== */}
      {activeTab === 2 && (
        <Stack spacing={2}>
          {(nClustersNoMedoid > 0 || nIcPairsUnbuilt > 0) && (
            <Alert severity="warning">
              {nClustersNoMedoid > 0 && (
                <Typography variant="body2">
                  {nClustersNoMedoid} of {splitClustersForPrereq.length} clusters have no medoid
                  card yet — run Medoid analysis first.
                </Typography>
              )}
              {nIcPairsUnbuilt > 0 && (
                <Typography variant="body2">
                  {nIcPairsUnbuilt} of {icPairsForPrereq.length} Parameter-space pairs have no contrast card
                  yet — run Parameter-space pair analysis before cluster summary
                  {clustersMissingIcContrasts.length
                    ? ` (blocked for clusters ${clustersMissingIcContrasts
                        .map((c) => c.cluster)
                        .join(", ")})`
                    : ""}
                  .
                </Typography>
              )}
            </Alert>
          )}
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

          <Divider />

          {/* Selection quality: deterministic checks + the LLM verdict */}
          <SelectionQualityPanel
            selectionEval={splitAnalysis?.selectionEval ?? null}
            crossEval={splitAnalysis?.crossEval ?? null}
            quality={splitAnalysis?.quality ?? null}
          />

          <Paper variant="outlined" sx={{ p: 2 }}>
            <Stack direction="row" alignItems="center" spacing={2} flexWrap="wrap">
              <Button
                variant="contained"
                disabled={running || config.clusters.length === 0 || !anySummaryReady}
                onClick={() => {
                  const ready = (splitAnalysis?.clusters ?? [])
                    .filter((c) => c.readyForSummary)
                    .map((c) => c.cluster);
                  run(
                    ready.length ? ready : config.clusters.map((c) => c.cluster),
                    TAB_PRODUCTS[2],
                  );
                }}
                startIcon={running ? <CircularProgress size={16} color="inherit" /> : undefined}
              >
                {running ? "Analyzing…" : "Run cluster summaries"}
              </Button>
              <Typography variant="caption" color="text.secondary">
                Runs <code>--products summary</code>. Hard-requires medoid cards and{" "}
                <code>output/contrast.yaml</code> for every touching Parameter-space pair pack.
              </Typography>
            </Stack>
            {summaryBlocked && (
              <Alert severity="error" sx={{ mt: 1 }}>
                Cluster summary is blocked until medoid + Parameter-space pair contrasts are built for the
                selected clusters.
              </Alert>
            )}
            {runError && (
              <Alert severity="error" sx={{ mt: 2 }}>
                {runError}
              </Alert>
            )}
          </Paper>

          <PromptsCard
            keys={PROMPT_GROUPS[2]}
            prompts={prompts}
            setPrompts={setPrompts}
            productLabel="summary"
          />

          <SplitCardsPanel
            split={splitAnalysis}
            folder={config.folder}
            batchId={batchId}
            subTab={splitSubTab}
            onSubTab={setSplitSubTab}
            mode="summary"
          />
        </Stack>
      )}

      {/* ===== MEDOID ANALYSIS TAB ===== */}
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
              <Stack direction="row" spacing={2} flexWrap="wrap">
                <FormControlLabel
                  control={<Switch checked={review} onChange={(e) => setReview(e.target.checked)} />}
                  label="Reviewer pass"
                />
                <FormControlLabel
                  control={<Switch checked={dryRun} onChange={(e) => setDryRun(e.target.checked)} />}
                  label="Dry run (stub)"
                />
              </Stack>
              <Typography variant="caption" color="text.secondary">
                Model setup applies to every tab. Each tab runs only its own product.
              </Typography>
            </Stack>
          </Paper>

          <PromptsCard
            keys={PROMPT_GROUPS[0]}
            prompts={prompts}
            setPrompts={setPrompts}
            productLabel="medoid"
          />
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
                        onClick={() => run([c.cluster], TAB_PRODUCTS[0])}
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
                onClick={() => run(undefined, TAB_PRODUCTS[0])}
                startIcon={running ? <CircularProgress size={16} color="inherit" /> : undefined}
              >
                {running
                  ? "Analyzing…"
                  : `Run medoid cards (${runClusters.size} cluster${runClusters.size === 1 ? "" : "s"})`}
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

          <SplitCardsPanel
            split={splitAnalysis}
            folder={config.folder}
            batchId={batchId}
            subTab={splitSubTab}
            onSubTab={setSplitSubTab}
            mode="medoid"
          />
        </Stack>
      </Stack>
      )}

      {/* ===== RUN REPORT TAB ===== */}
      {activeTab === 3 && config && (
        <RunReportTab
          batchId={batchId}
          folder={config.folder}
          onNavigateTab={setActiveTab}
        />
      )}

    </Container>
  );
}

function fmtNum(v: unknown, digits = 3): string {
  if (typeof v !== "number" || !Number.isFinite(v)) return "—";
  return v.toFixed(digits);
}

function DigestTable({
  title,
  digest,
}: {
  title: string;
  digest: Record<string, unknown> | null | undefined;
}) {
  if (!digest) return null;
  const keys = ["n", "mean", "std", "min", "p10", "p50", "p90"] as const;
  return (
    <Box sx={{ mb: 2 }}>
      <Typography variant="subtitle2" gutterBottom>
        {title}
      </Typography>
      <Table size="small">
        <TableHead>
          <TableRow>
            {keys.map((k) => (
              <TableCell key={k}>{k}</TableCell>
            ))}
          </TableRow>
        </TableHead>
        <TableBody>
          <TableRow>
            {keys.map((k) => (
              <TableCell key={k}>
                {k === "n" ? String(digest[k] ?? "—") : fmtNum(digest[k])}
              </TableCell>
            ))}
          </TableRow>
        </TableBody>
      </Table>
    </Box>
  );
}

function SplitCardsPanel({
  split,
  folder,
  batchId,
  subTab,
  onSubTab,
  mode,
}: {
  split: SplitAnalysis | null;
  folder: string;
  batchId: string;
  subTab: number;
  onSubTab: (v: number) => void;
  /** Which saved card to show. Omit for the legacy three-tab viewer. */
  mode?: "medoid" | "summary";
}) {
  const clusters = split?.clusters ?? [];
  const [clusterIdx, setClusterIdx] = useState(0);
  const [pairIdx, setPairIdx] = useState(0);
  const card = clusters[Math.min(clusterIdx, Math.max(0, clusters.length - 1))] ?? null;
  const agg = (card?.aggregate ?? null) as Record<string, unknown> | null;
  const summaryParsed = ((card?.summaryMeta as Record<string, unknown> | null | undefined)
    ?.parsed ?? null) as Record<string, unknown> | null;
  const medoidParsed = ((card?.medoidMeta as Record<string, unknown> | null | undefined)
    ?.parsed ?? null) as Record<string, unknown> | null;
  const icPairs = split?.icPairs ?? [];
  const pair = icPairs[Math.min(pairIdx, Math.max(0, icPairs.length - 1))] ?? null;

  // When scoped to one product, pin the sub-tab instead of showing the picker.
  const effectiveSubTab = mode === "medoid" ? 1 : mode === "summary" ? 0 : subTab;

  if (!split || (clusters.length === 0 && icPairs.length === 0)) {
    return (
      <Alert severity="info">
        No saved cards yet for this folder. Run the product above, then reopen this tab.
      </Alert>
    );
  }

  return (
    <Stack spacing={2}>
      {mode == null && (
        <Typography variant="body2" color="text.secondary">
          Numbers-first report for batch {batchId} · {folder}. Explore Highlight stays the trial
          picker; this tab is the saved card viewer.
        </Typography>
      )}

      {mode == null && (
        <Tabs value={subTab} onChange={(_, v) => onSubTab(v)}>
          <Tab label="Summary" />
          <Tab label="Medoid" />
          <Tab label={`Parameter-space pairs${icPairs.length ? ` (${icPairs.length})` : ""}`} />
        </Tabs>
      )}
      {mode != null && (
        <Typography variant="h6">
          {mode === "medoid" ? "Saved medoid cards" : "Saved cluster summary cards"}
        </Typography>
      )}

      {(effectiveSubTab === 0 || effectiveSubTab === 1) && clusters.length > 0 && (
        <Stack direction="row" spacing={1} flexWrap="wrap">
          {clusters.map((c, i) => (
            <Chip
              key={c.cluster}
              label={`cluster ${c.cluster}`}
              color={i === clusterIdx ? "primary" : "default"}
              onClick={() => setClusterIdx(i)}
              size="small"
            />
          ))}
        </Stack>
      )}

      {effectiveSubTab === 0 && card && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 1 }} flexWrap="wrap">
            <Typography variant="h6" sx={{ flexGrow: 1 }}>
              Cluster {card.cluster}
              {summaryParsed?.label ? ` — ${String(summaryParsed.label)}` : ""}
            </Typography>
            {summaryParsed?.risk_level != null && (
              <Chip size="small" label={`risk: ${String(summaryParsed.risk_level)}`} />
            )}
            {agg?.collision_rate != null && (
              <Chip
                size="small"
                variant="outlined"
                label={`collision rate ${fmtNum(agg.collision_rate, 3)} (n=${String(agg.n_trials ?? "—")})`}
              />
            )}
          </Stack>
          <DigestTable title="TTC (all)" digest={agg?.ttc as Record<string, unknown>} />
          <DigestTable
            title="TTC (collide)"
            digest={agg?.ttc_collide as Record<string, unknown>}
          />
          <DigestTable
            title="TTC (survive)"
            digest={agg?.ttc_survive as Record<string, unknown>}
          />
          {typeof agg?.ic === "object" && agg?.ic !== null && (
            <Box sx={{ mb: 2 }}>
              <Typography variant="subtitle2" gutterBottom>
                Initial conditions
              </Typography>
              <Table size="small">
                <TableHead>
                  <TableRow>
                    <TableCell>param</TableCell>
                    <TableCell>mean</TableCell>
                    <TableCell>std</TableCell>
                    <TableCell>p10</TableCell>
                    <TableCell>p90</TableCell>
                    <TableCell>range</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {Object.entries(agg.ic as Record<string, Record<string, unknown>>).map(
                    ([name, d]) => (
                      <TableRow key={name}>
                        <TableCell>{name}</TableCell>
                        <TableCell>{fmtNum(d.mean)}</TableCell>
                        <TableCell>{fmtNum(d.std)}</TableCell>
                        <TableCell>{fmtNum(d.p10)}</TableCell>
                        <TableCell>{fmtNum(d.p90)}</TableCell>
                        <TableCell>
                          {Array.isArray(d.range)
                            ? `[${fmtNum(d.range[0])}, ${fmtNum(d.range[1])}]`
                            : "—"}
                        </TableCell>
                      </TableRow>
                    ),
                  )}
                </TableBody>
              </Table>
            </Box>
          )}
          {summaryParsed?.caption != null && (
            <Typography variant="body1" sx={{ whiteSpace: "pre-wrap", mb: 1 }}>
              {String(summaryParsed.caption)}
            </Typography>
          )}
          {summaryParsed?.consistency_note != null && (
            <Typography variant="body2" color="text.secondary" sx={{ whiteSpace: "pre-wrap" }}>
              {String(summaryParsed.consistency_note)}
            </Typography>
          )}
          {summaryParsed?.motive_consistency_note != null &&
            String(summaryParsed.motive_consistency_note).trim() !== "" && (
              <Alert severity="warning" sx={{ mt: 1 }}>
                {String(summaryParsed.motive_consistency_note)}
              </Alert>
            )}
          {Array.isArray(summaryParsed?.neighbor_comparison) &&
            (summaryParsed!.neighbor_comparison as any[]).length > 0 && (
              <Box sx={{ mt: 1.5 }}>
                <Typography variant="subtitle2" gutterBottom>
                  vs. parameter-space-matched neighbors
                  {summaryParsed?.distinct_from_neighbors != null && (
                    <Chip
                      size="small"
                      sx={{ ml: 1 }}
                      color={summaryParsed.distinct_from_neighbors ? "success" : "warning"}
                      label={
                        summaryParsed.distinct_from_neighbors
                          ? "distinct from all neighbors"
                          : "not distinct from every neighbor"
                      }
                    />
                  )}
                </Typography>
                <Stack spacing={0.5}>
                  {(summaryParsed!.neighbor_comparison as any[]).map((nc, i) => (
                    <Stack key={i} direction="row" spacing={1} alignItems="baseline" flexWrap="wrap">
                      <Chip
                        size="small"
                        variant="outlined"
                        label={`${nc.parameter_space_pair_folder ?? `cluster${nc.neighbor_cluster}`}: ${nc.verdict ?? "?"}`}
                        color={
                          nc.verdict === "distinct"
                            ? "success"
                            : nc.verdict === "similar"
                              ? "warning"
                              : "default"
                        }
                      />
                      <Typography variant="caption" color="text.secondary">
                        {nc.reason}
                      </Typography>
                    </Stack>
                  ))}
                </Stack>
              </Box>
            )}
          {!summaryParsed && card.summaryYaml && (
            <Box
              component="pre"
              sx={{ m: 0, p: 1.5, bgcolor: "grey.50", borderRadius: 1, fontSize: 12, overflow: "auto" }}
            >
              {card.summaryYaml}
            </Box>
          )}
        </Paper>
      )}

      {effectiveSubTab === 1 && card && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="h6" gutterBottom>
            Medoid trial
            {medoidParsed?.trial_id != null ? ` ${String(medoidParsed.trial_id)}` : ""}
          </Typography>
          {medoidParsed != null &&
            (medoidParsed.conflict_metrics != null || medoidParsed.outcome != null) && (
            <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 2 }}>
              {medoidParsed.outcome != null && (
                <Chip size="small" label={`outcome: ${String(medoidParsed.outcome)}`} />
              )}
              {typeof medoidParsed.conflict_metrics === "object" &&
                medoidParsed.conflict_metrics !== null &&
                Object.entries(medoidParsed.conflict_metrics as Record<string, unknown>).map(
                  ([k, v]) => (
                    <Chip
                      key={k}
                      size="small"
                      variant="outlined"
                      label={`${k}=${typeof v === "number" ? fmtNum(v) : String(v)}`}
                    />
                  ),
                )}
            </Stack>
          )}
          {medoidParsed?.motive_summary != null &&
            String(medoidParsed.motive_summary) !== "parse_failed" && (
            <Typography variant="body1" sx={{ whiteSpace: "pre-wrap", mb: 2 }}>
              {String(medoidParsed.motive_summary)}
            </Typography>
          )}
          {Array.isArray(medoidParsed?.decision_timeline) &&
            (medoidParsed.decision_timeline as unknown[]).length > 0 && (
            <Box sx={{ mb: 2 }}>
              <Typography variant="subtitle2" gutterBottom>
                Decision timeline
              </Typography>
              <Stack spacing={1}>
                {(medoidParsed.decision_timeline as Array<Record<string, unknown>>).map(
                  (ev, i) => (
                    <Box key={i} sx={{ pl: 1, borderLeft: "2px solid", borderColor: "divider" }}>
                      <Typography variant="caption" color="text.secondary">
                        t={fmtNum(ev.timestamp ?? ev.t, 2)}s
                        {ev.motive != null &&
                        String(ev.motive) !== "" &&
                        String(ev.motive) !== "null"
                          ? ` · ${String(ev.motive)}`
                          : ""}
                      </Typography>
                      <Typography variant="body2">{String(ev.description ?? "")}</Typography>
                    </Box>
                  ),
                )}
              </Stack>
            </Box>
          )}
          {(!medoidParsed ||
            String(medoidParsed.motive_summary ?? "") === "parse_failed" ||
            !(Array.isArray(medoidParsed.decision_timeline) &&
              (medoidParsed.decision_timeline as unknown[]).length)) &&
            card.medoidYaml && (
            <Box
              component="pre"
              sx={{ m: 0, p: 1.5, bgcolor: "grey.50", borderRadius: 1, fontSize: 12, overflow: "auto", whiteSpace: "pre-wrap" }}
            >
              {card.medoidYaml}
            </Box>
          )}
          {medoidParsed &&
            String(medoidParsed.motive_summary ?? "") !== "parse_failed" &&
            Array.isArray(medoidParsed.decision_timeline) &&
            (medoidParsed.decision_timeline as unknown[]).length > 0 &&
            card.medoidYaml && (
            <Accordion disableGutters elevation={0}>
              <AccordionSummary expandIcon={<ExpandMore />}>
                <Typography fontSize={13}>Raw medoid_trial.yaml</Typography>
              </AccordionSummary>
              <AccordionDetails>
                <Box component="pre" sx={{ m: 0, fontSize: 11, overflow: "auto" }}>
                  {card.medoidYaml}
                </Box>
              </AccordionDetails>
            </Accordion>
          )}
        </Paper>
      )}

      {effectiveSubTab === 2 && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          {icPairs.length === 0 ? (
            <Alert severity="info">No Parameter-space pair YAMLs under parameter_space_pairs/ yet.</Alert>
          ) : (
            <>
              <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 2 }}>
                {icPairs.map((p, i) => (
                  <Chip
                    key={p.name}
                    label={p.name.replace(/\.yaml$/, "")}
                    color={i === pairIdx ? "primary" : "default"}
                    onClick={() => setPairIdx(i)}
                    size="small"
                  />
                ))}
              </Stack>
              <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
                Trial ids in the YAML can be highlighted from Explore → Highlight.
              </Typography>
              <Box
                component="pre"
                sx={{
                  m: 0,
                  p: 1.5,
                  bgcolor: "grey.50",
                  borderRadius: 1,
                  fontSize: 12,
                  overflow: "auto",
                  whiteSpace: "pre-wrap",
                }}
              >
                {pair?.yaml ?? ""}
              </Box>
            </>
          )}
        </Paper>
      )}
    </Stack>
  );
}

// ─── Per-tab prompt viewer/editor ───────────────────────────────────────────

function PromptsCard({
  keys,
  prompts,
  setPrompts,
  productLabel,
}: {
  keys: string[];
  prompts: Record<string, string>;
  setPrompts: React.Dispatch<React.SetStateAction<Record<string, string>>>;
  productLabel: string;
}) {
  const entries = PROMPT_LABELS.filter((p) => keys.includes(p.key));
  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>
        Prompts sent by this analysis
      </Typography>
      <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
        These are the exact templates <code>--products {productLabel}</code> sends, in order.
        Edits apply to the next run from this tab only.
      </Typography>
      {entries.map(({ key, label, help }) => (
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
  );
}

// ─── Parameter-space pair analysis panel ─────────────────────────────────────────────────

function IcPairPanel({
  pairs,
  folder,
  batchId,
  splitClusters = [],
}: {
  pairs: IcPairEntry[];
  folder: string;
  batchId: string;
  splitClusters?: SplitClusterCard[];
}) {
  const [idx, setIdx] = useState(0);
  const [frame, setFrame] = useState(0);
  const pair = pairs[Math.min(idx, Math.max(0, pairs.length - 1))] ?? null;
  const facts = (pair?.facts ?? null) as Record<string, any> | null;
  const frames = pair?.syncedBev ?? [];
  const shown = frames[Math.min(frame, Math.max(0, frames.length - 1))];
  const contrastParsed = (pair?.contrastMeta as Record<string, any> | null)?.parsed as
    | Record<string, any>
    | undefined;
  const leftMotive = contrastParsed?.left?.primary_motive;
  const rightMotive = contrastParsed?.right?.primary_motive;
  const leftMedoid = splitClusters.find(
    (c) => String(c.cluster) === String(facts?.cluster_a),
  );
  const rightMedoid = splitClusters.find(
    (c) => String(c.cluster) === String(facts?.cluster_b),
  );

  if (pairs.length === 0) {
    return (
      <Alert severity="info">
        No Parameter-space pair packs under <code>parameter_space_pairs/</code>. Rebuild the dataset with{" "}
        <code>--param-boundaries all</code>. Packs only exist for cluster pairs whose closest
        trials sit within the parameter caliper (param_dist ≤ tau).
      </Alert>
    );
  }

  return (
    <Stack spacing={2}>
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 2 }}>
          {pairs.map((p, i) => (
            <Chip
              key={p.name}
              label={`${p.folder ?? p.name.replace(/\.yaml$/, "")}${
                p.readyForLlm ? "" : " ⚠"
              }`}
              color={i === idx ? "primary" : "default"}
              variant={p.hasContrast || p.yaml ? "filled" : "outlined"}
              onClick={() => {
                setIdx(i);
                setFrame(0);
              }}
              size="small"
            />
          ))}
        </Stack>
        <Typography variant="caption" color="text.secondary">
          Filled chips have an LLM contrast card; ⚠ = not ready for LLM (medoid / process /
          BEV).
        </Typography>
        {pair && !pair.readyForLlm && (
          <Alert severity="warning" sx={{ mt: 1 }}>
            Not ready: {(pair.missing ?? []).join(", ") || "missing inputs"}
          </Alert>
        )}

        {facts && (
          <Table size="small" sx={{ mt: 2 }}>
            <TableBody>
              <TableRow>
                <TableCell>clusters</TableCell>
                <TableCell>
                  cluster {String(facts.cluster_a)} vs cluster {String(facts.cluster_b)}
                </TableCell>
              </TableRow>
              <TableRow>
                <TableCell>param_dist</TableCell>
                <TableCell>
                  {fmtNum(facts.param_dist, 4)} (tau {String(facts.param_dist_tau)}) ·{" "}
                  {String(facts.card_role)}
                </TableCell>
              </TableRow>
              <TableRow>
                <TableCell>outcomes</TableCell>
                <TableCell>
                  <Chip
                    size="small"
                    label={facts.collided_a ? "collision" : "safe"}
                    color={facts.collided_a ? "error" : "success"}
                    sx={{ mr: 1 }}
                  />
                  <Chip
                    size="small"
                    label={facts.collided_b ? "collision" : "safe"}
                    color={facts.collided_b ? "error" : "success"}
                  />
                </TableCell>
              </TableRow>
              {(leftMotive || rightMotive) && (
                <TableRow>
                  <TableCell>primary_motive</TableCell>
                  <TableCell>
                    <Chip size="small" variant="outlined" label={`left: ${leftMotive ?? "?"}`} sx={{ mr: 1 }} />
                    <Chip size="small" variant="outlined" label={`right: ${rightMotive ?? "?"}`} />
                  </TableCell>
                </TableRow>
              )}
              <TableRow>
                <TableCell>trials</TableCell>
                <TableCell>
                  {String(facts.trial_a)} (idx {String(facts.trial_index_a)}) vs{" "}
                  {String(facts.trial_b)} (idx {String(facts.trial_index_b)})
                </TableCell>
              </TableRow>
            </TableBody>
          </Table>
        )}
      </Paper>

      {(leftMedoid?.medoidYaml || rightMedoid?.medoidYaml) && (
        <Accordion disableGutters elevation={0} variant="outlined">
          <AccordionSummary expandIcon={<ExpandMore />}>
            <Typography variant="subtitle2">Endpoint medoid cards (required inputs)</Typography>
          </AccordionSummary>
          <AccordionDetails>
            <Stack spacing={1}>
              {leftMedoid?.medoidYaml && (
                <Box>
                  <Typography variant="caption" color="text.secondary">
                    cluster{String(facts?.cluster_a)} medoid
                  </Typography>
                  <Box
                    component="pre"
                    sx={{ m: 0, p: 1, bgcolor: "grey.50", fontSize: 11, maxHeight: 180, overflow: "auto", whiteSpace: "pre-wrap" }}
                  >
                    {leftMedoid.medoidYaml.slice(0, 1200)}
                    {leftMedoid.medoidYaml.length > 1200 ? "\n…" : ""}
                  </Box>
                </Box>
              )}
              {rightMedoid?.medoidYaml && (
                <Box>
                  <Typography variant="caption" color="text.secondary">
                    cluster{String(facts?.cluster_b)} medoid
                  </Typography>
                  <Box
                    component="pre"
                    sx={{ m: 0, p: 1, bgcolor: "grey.50", fontSize: 11, maxHeight: 180, overflow: "auto", whiteSpace: "pre-wrap" }}
                  >
                    {rightMedoid.medoidYaml.slice(0, 1200)}
                    {rightMedoid.medoidYaml.length > 1200 ? "\n…" : ""}
                  </Box>
                </Box>
              )}
            </Stack>
          </AccordionDetails>
        </Accordion>
      )}

      {(pair?.processContext || pair?.mergedTimeline) && (
        <Accordion disableGutters elevation={0} variant="outlined">
          <AccordionSummary expandIcon={<ExpandMore />}>
            <Typography variant="subtitle2">
              Pair context (process/context.md — shared clock)
            </Typography>
          </AccordionSummary>
          <AccordionDetails>
            <Box
              component="pre"
              sx={{
                m: 0,
                p: 1.5,
                bgcolor: "grey.50",
                borderRadius: 1,
                fontSize: 12,
                overflow: "auto",
                whiteSpace: "pre-wrap",
                maxHeight: 400,
              }}
            >
              {pair.processContext ?? pair.mergedTimeline}
            </Box>
          </AccordionDetails>
        </Accordion>
      )}

      {frames.length > 0 && pair?.folder && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="subtitle2" gutterBottom>
            Synced BEV — left = cluster {String(facts?.cluster_a)}, right = cluster{" "}
            {String(facts?.cluster_b)}, same shared clock
          </Typography>
          <Slider
            size="small"
            min={0}
            max={frames.length - 1}
            step={1}
            value={Math.min(frame, frames.length - 1)}
            onChange={(_, v) => setFrame(v as number)}
            marks
          />
          <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
            frame {Math.min(frame, frames.length - 1) + 1} / {frames.length} — {shown}
          </Typography>
          {shown && (
            <Box
              component="img"
              src={`/api/cluster-analyze?batchId=${encodeURIComponent(batchId)}&folder=${encodeURIComponent(folder)}&icPair=${encodeURIComponent(pair.folder)}&file=${encodeURIComponent(shown)}`}
              alt={shown}
              sx={{ width: "100%", borderRadius: 1, border: "1px solid #eee" }}
            />
          )}
        </Paper>
      )}

      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="subtitle2" gutterBottom sx={{ fontSize: 20, fontWeight: 700 }}>
          Contrast card (output/contrast.yaml)
        </Typography>
        <Stack direction="row" spacing={1} sx={{ mb: 2, flexWrap: "wrap", rowGap: 1 }}>
          {contrastParsed?.motive_contrast && (
            <Chip
              size="small"
              color={String(contrastParsed.motive_contrast) === "different" ? "warning" : "default"}
              label={`motive_contrast: ${String(contrastParsed.motive_contrast)}`}
            />
          )}
          {contrastParsed?.separation_call && (
            <Chip
              size="small"
              color={
                String(contrastParsed.separation_call) === "justified"
                  ? "success"
                  : String(contrastParsed.separation_call) === "over_fine"
                    ? "warning"
                    : "default"
              }
              label={`separation_call: ${String(contrastParsed.separation_call)}`}
            />
          )}
        </Stack>
        {Array.isArray(contrastParsed?.contrast_timeline) &&
          (contrastParsed.contrast_timeline as unknown[]).length > 0 && (
            <Box sx={{ mb: 2 }}>
              <Typography variant="caption" color="text.secondary" display="block" gutterBottom sx={CONTRAST_FIELD_LABEL_SX}>
                contrast_timeline
              </Typography>
              <Stack spacing={1}>
                {(contrastParsed.contrast_timeline as Array<Record<string, unknown>>).map(
                  (phase, i) => (
                    <Box
                      key={i}
                      sx={{ p: 1, bgcolor: "grey.50", borderRadius: 1, border: "1px solid", borderColor: "divider" }}
                    >
                      <Typography variant="caption" fontWeight={600} display="block">
                        t={String(phase.t_start ?? "?")}–{String(phase.t_end ?? "?")}
                        {phase.bev_frame ? ` · ${String(phase.bev_frame)}` : ""}
                      </Typography>
                      <Typography variant="body2" sx={{ whiteSpace: "pre-wrap", mt: 0.5 }}>
                        {String(phase.interpretation ?? "")}
                      </Typography>
                    </Box>
                  ),
                )}
              </Stack>
            </Box>
          )}
        {contrastParsed?.critical_divergence && (
          <Box sx={{ mb: 2 }}>
            {contrastParsed.critical_divergence &&
              typeof contrastParsed.critical_divergence === "object" && (
                <Typography variant="body2" color="text.secondary" sx={{fontSize: 20, lineHeight: 2.5 }}>
                  critical_divergence @ t=
                  {String(
                    (contrastParsed.critical_divergence as Record<string, unknown>).at ?? "?",
                  )}
                  :{" "}
                  {String(
                    (contrastParsed.critical_divergence as Record<string, unknown>).description ??
                      "",
                  )}
                </Typography>
              )}
          </Box>
        )}
        {contrastParsed?.contrast_explanation && (
          <Box sx={{ mb: 2 }}>
            <Typography
              variant="caption"
              color="text.secondary"
              display="block"
              gutterBottom
              sx={CONTRAST_FIELD_LABEL_SX}
            >
              contrast_explanation
            </Typography>
            <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
              {String(contrastParsed.contrast_explanation)}
            </Typography>
          </Box>
        )}
        {contrastParsed?.separation_reason && (
          <Box sx={{ mb: 2 }}>
            <Typography
              variant="caption"
              color="text.secondary"
              display="block"
              gutterBottom
              sx={CONTRAST_FIELD_LABEL_SX}
            >
              separation_reason
            </Typography>
            <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
              {String(contrastParsed.separation_reason)}
            </Typography>
          </Box>
        )}
        {pair?.yaml ? (
          <Accordion disableGutters elevation={0} variant="outlined">
            <AccordionSummary expandIcon={<ExpandMore />}>
              <Typography variant="subtitle2" sx={{ fontSize: 15, fontWeight: 700 }}>Raw contrast.yaml</Typography>
            </AccordionSummary>
            <AccordionDetails>
              <Box
                component="pre"
                sx={{
                  m: 0,
                  p: 1.5,
                  bgcolor: "grey.50",
                  borderRadius: 1,
                  fontSize: 12,
                  overflow: "auto",
                  whiteSpace: "pre-wrap",
                }}
              >
                {pair.yaml}
              </Box>
            </AccordionDetails>
          </Accordion>
        ) : (
          <Alert severity="info">
            No <code>output/contrast.yaml</code> yet for this pack — select it above and run
            Parameter-space pair analysis.
          </Alert>
        )}
      </Paper>
    </Stack>
  );
}

// ─── Cluster-selection quality panel ────────────────────────────────────────

const SELECTION_COMPONENT_HELP: Record<string, string> = {
  outcome_purity:
    "Share of clusters whose collision rate sits at 0% or 100%. Mixed clusters usually hide two behaviors.",
  motive_distinctness:
    "Distinct primary_motive values divided by the number of captioned clusters. Repeats hint at over-splitting.",
  parameter_space_pair_decisiveness:
    "Share of near-identical-Parameter-space pairs whose outcome flips across the boundary. Low means the boundary rarely changes anything.",
  no_merge_candidates:
    "1.0 when no two clusters share a motive with similar collision rate and overlapping parameter ranges.",
};

function SelectionQualityPanel({
  selectionEval,
  crossEval,
  quality,
}: {
  selectionEval: Record<string, unknown> | null;
  crossEval: Record<string, unknown> | null;
  quality: Record<string, unknown> | null;
}) {
  const sel = (selectionEval ?? null) as Record<string, any> | null;
  const cross = (crossEval ?? null) as Record<string, any> | null;
  const qual = (quality ?? null) as Record<string, any> | null;
  const components = (sel?.components ?? {}) as Record<string, number | null>;
  const findings = (sel?.findings ?? []) as string[];
  const crossIsStub = cross?.stub === true;

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>
        Is this cluster selection good?
      </Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
        Two independent halves. The deterministic checks are measured from the artifacts on disk
        and need no LLM; the cross-cluster verdict is the LLM reading the medoid and Parameter-space pair cards.
        Silhouette is deliberately not the arbiter here — it scores geometry in FPC space, not
        whether the clusters describe different behaviors.
      </Typography>

      <Stack direction="row" spacing={2} flexWrap="wrap" sx={{ mb: 2 }}>
        <Chip
          label={`deterministic ${sel?.selection_score ?? "n/a"}`}
          color={sel?.selection_score != null ? "primary" : "default"}
        />
        <Chip
          label={`LLM separation ${cross?.behavioral_separation_score ?? "n/a"}/10`}
          color={cross?.behavioral_separation_score != null ? "primary" : "default"}
        />
        <Chip
          label={`LLM boundary clarity ${cross?.boundary_clarity_score ?? "n/a"}/10`}
          color={cross?.boundary_clarity_score != null ? "primary" : "default"}
        />
        <Chip
          label={`composite ${qual?.final_score ?? "n/a"}`}
          variant="outlined"
        />
      </Stack>

      {!sel && (
        <Alert severity="info" sx={{ mb: 2 }}>
          No <code>cluster_selection_eval.json</code> yet. It is written by any pipeline run, or
          standalone with <code>python -m llm_pipeline.cli selection-eval --run-dir …</code> (no
          LLM required).
        </Alert>
      )}

      {sel && (
        <>
          <Table size="small" sx={{ mb: 2 }}>
            <TableHead>
              <TableRow>
                <TableCell>deterministic component</TableCell>
                <TableCell>score</TableCell>
                <TableCell>weight</TableCell>
                <TableCell>what it measures</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {Object.entries(components).map(([key, value]) => (
                <TableRow key={key}>
                  <TableCell>{key}</TableCell>
                  <TableCell>{value == null ? "n/a" : fmtNum(value, 3)}</TableCell>
                  <TableCell>
                    {fmtNum((sel.weights as Record<string, number>)?.[key], 2)}
                  </TableCell>
                  <TableCell>
                    <Typography variant="caption" color="text.secondary">
                      {SELECTION_COMPONENT_HELP[key] ?? ""}
                    </Typography>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>

          {findings.length > 0 && (
            <Stack spacing={0.5} sx={{ mb: 2 }}>
              {findings.map((f, i) => (
                <Typography key={i} variant="body2">
                  • {f}
                </Typography>
              ))}
            </Stack>
          )}

          {(sel.merge_candidates ?? []).length > 0 && (
            <Alert severity="warning" sx={{ mb: 2 }}>
              <Typography variant="body2" fontWeight="bold">
                Merge candidates
              </Typography>
              {(sel.merge_candidates as Array<Record<string, any>>).map((m, i) => (
                <Typography key={i} variant="caption" display="block">
                  cluster{m.clusters?.[0]} + cluster{m.clusters?.[1]} — shared motive{" "}
                  {m.shared_motive}, param overlap {m.param_overlap}
                </Typography>
              ))}
            </Alert>
          )}
        </>
      )}

      <Divider sx={{ my: 2 }} />

      <Typography variant="subtitle2" gutterBottom>
        Cross-cluster verdict (LLM)
      </Typography>
      {!cross || crossIsStub ? (
        <Alert severity="info">
          {crossIsStub
            ? `Stub only — ${String(cross?.inter_notes ?? "no LLM run yet")}.`
            : "No cross_cluster_eval.json yet. Run the cluster analysis above."}
        </Alert>
      ) : (
        <Stack spacing={1}>
          {cross.selection_verdict && (
            <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
              {String(cross.selection_verdict)}
            </Typography>
          )}
          {cross.recommended_action && (
            <Typography variant="body2">
              <strong>Recommended action:</strong> {String(cross.recommended_action)}
              {cross.recommended_action_detail
                ? ` — ${String(cross.recommended_action_detail)}`
                : ""}
            </Typography>
          )}
        </Stack>
      )}
    </Paper>
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

// ─── Run Report Tab ─────────────────────────────────────────────────────────

type RunReportData = {
  header: {
    batchId: string;
    folder: string;
    k: number | null;
    silhouette: number | null;
    qualityScore: number | null;
    qualityRuleScore: number | null;
    selectionScore: number | null;
  };
  clusters: Array<{
    id: number;
    label: string | null;
    n: number;
    collisionRate: number | null;
    collisionCount: number | null;
    parameterRanges: Record<string, [number, number]> | null;
    neighborhoodSeparation: string | null;
    medoidMotive: string | null;
    medoidOutcome: string | null;
    medoidResolution: string | null;
    summaryCaption: string | null;
    riskLevel: string | null;
    consistencyNote: string | null;
    hasMedoid: boolean;
    hasSummary: boolean;
  }>;
  pairs: Array<{
    folder: string;
    clusters: [number, number];
    paramDist: number | null;
    outcomeFlip: boolean;
    separationCall: string | null;
    separationReason: string | null;
    contrastExplanation: string | null;
    hasContrast: boolean;
  }>;
  selectionFindings: string[];
  mergeCandidates: Array<{
    clusters: [number, number];
    sharedMotive: string;
    collisionRate: [number, number];
    paramOverlap: number;
  }>;
  boundaryExport: {
    generatedAt: string | null;
    kNN: number | null;
    kpiName: string | null;
    clustersIncluded: string[];
    nTrialsConsidered: number | null;
    nTrialsWithoutClusterLabel: number | null;
    collisionBoundaryCount: number;
    clusterBoundaryCount: number;
  } | null;
  parameterRules: {
    generatedAt: string | null;
    maxDepth: number | null;
    features: string[];
    nTrialsUsed: number | null;
    trainAcc: number | null;
    cvAcc: number | null;
    rules: Array<{
      id: string;
      predicate: string;
      predicted: string;
      support: number;
      precision: number;
      boundaryTrialHits: number | null;
    }>;
  } | null;
  boundaryPairsJoin: {
    nPairs: number;
    nPairsTouchingBoundary: number;
  } | null;
};

function RunReportTab({
  batchId,
  folder,
  onNavigateTab,
}: {
  batchId: string;
  folder: string;
  onNavigateTab: (tab: number) => void;
}) {
  const [data, setData] = useState<RunReportData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setLoading(true);
    setError(null);
    fetch(`/api/cluster-run-report?batchId=${batchId}&folder=${encodeURIComponent(folder)}`)
      .then((r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then((d) => setData(d as RunReportData))
      .catch((e) => setError(String(e)))
      .finally(() => setLoading(false));
  }, [batchId, folder]);

  if (loading) {
    return (
      <Stack alignItems="center" sx={{ py: 6 }}>
        <CircularProgress />
        <Typography sx={{ mt: 1 }}>Loading run report…</Typography>
      </Stack>
    );
  }
  if (error || !data) {
    return <Alert severity="error">{error ?? "Failed to load report"}</Alert>;
  }

  const { header, clusters, pairs } = data;

  // Motive histogram: count primary motives across high-collision clusters
  const motiveCount: Record<string, number> = {};
  for (const c of clusters) {
    if (c.medoidMotive && (c.collisionRate ?? 0) > 5) {
      motiveCount[c.medoidMotive] = (motiveCount[c.medoidMotive] ?? 0) + 1;
    }
  }
  const sortedMotives = Object.entries(motiveCount).sort(([, a], [, b]) => b - a);

  // Outcome-flip pairs
  const flipPairs = pairs.filter((p) => p.outcomeFlip);
  const justifiedPairs = pairs.filter((p) => p.separationCall === "justified");

  // Next tests recommendations (deterministic)
  const highFailNoContrast = clusters.filter(
    (c) => (c.collisionRate ?? 0) > 10 && !pairs.some((p) => p.clusters.includes(c.id) && p.hasContrast),
  );
  const inconclusivePairs = pairs.filter(
    (p) => p.separationCall === "inconclusive" || (p.hasContrast && !p.separationCall),
  );

  return (
    <Stack spacing={3}>
      {/* ── A. Header ─────────────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Run Report
        </Typography>
        <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1 }}>
          <Chip label={`batch ${header.batchId}`} size="small" />
          <Chip label={header.folder} size="small" variant="outlined" />
          {header.k != null && <Chip label={`k = ${header.k}`} size="small" />}
          {header.silhouette != null && (
            <Chip label={`silhouette = ${header.silhouette.toFixed(4)}`} size="small" />
          )}
        </Stack>
        <Stack direction="row" spacing={1} flexWrap="wrap">
          {header.selectionScore != null && (
            <Chip
              label={`selection score: ${header.selectionScore}`}
              color="primary"
              size="small"
            />
          )}
          {header.qualityScore != null && (
            <Chip
              label={`quality: ${header.qualityScore.toFixed(1)}`}
              size="small"
              variant="outlined"
            />
          )}
        </Stack>
        <Typography variant="caption" color="text.secondary" sx={{ mt: 1, display: "block" }}>
          Selection score measures behavioral usefulness of this partition, not geometric correctness alone.
        </Typography>
      </Paper>

      {/* ── B. Risk Table ─────────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Cluster Risk Overview
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Sorted by collision rate (descending). Click a cluster to view its analysis.
        </Typography>
        <Table size="small">
          <TableHead>
            <TableRow>
              <TableCell>Cluster</TableCell>
              <TableCell>Label</TableCell>
              <TableCell>n</TableCell>
              <TableCell>Collision Rate</TableCell>
              <TableCell>Medoid Motive</TableCell>
              <TableCell>Outcome</TableCell>
              <TableCell>Risk</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {clusters.map((c) => (
              <TableRow
                key={c.id}
                hover
                sx={{ cursor: "pointer" }}
                onClick={() => onNavigateTab(0)}
              >
                <TableCell>
                  <Chip label={`C${c.id}`} size="small" />
                </TableCell>
                <TableCell>{c.label ?? "—"}</TableCell>
                <TableCell>{c.n}</TableCell>
                <TableCell>
                  <Chip
                    label={c.collisionRate != null ? `${c.collisionRate.toFixed(1)}%` : "—"}
                    color={
                      (c.collisionRate ?? 0) > 50
                        ? "error"
                        : (c.collisionRate ?? 0) > 10
                          ? "warning"
                          : "success"
                    }
                    size="small"
                  />
                </TableCell>
                <TableCell>
                  <Chip
                    label={c.medoidMotive ?? "—"}
                    size="small"
                    variant="outlined"
                  />
                </TableCell>
                <TableCell>{c.medoidOutcome ?? "—"}</TableCell>
                <TableCell>
                  {c.riskLevel ? (
                    <Chip
                      label={c.riskLevel}
                      color={riskColor(c.riskLevel)}
                      size="small"
                    />
                  ) : (
                    "—"
                  )}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </Paper>

      {/* ── C. Failure Modes ──────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Behavioral Failure Modes
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Primary motives ranked by frequency across clusters with collision rate &gt; 5%.
        </Typography>
        {sortedMotives.length > 0 ? (
          <Stack spacing={1}>
            {sortedMotives.map(([motive, count]) => (
              <Stack key={motive} direction="row" spacing={1} alignItems="center">
                <Box
                  sx={{
                    width: `${Math.min(100, (count / clusters.length) * 100 * 2)}%`,
                    minWidth: 40,
                    height: 24,
                    bgcolor: "error.main",
                    borderRadius: 1,
                    opacity: 0.7 + 0.3 * (count / Math.max(...sortedMotives.map(([, c]) => c))),
                  }}
                />
                <Typography variant="body2" fontWeight={600}>
                  {motive}
                </Typography>
                <Typography variant="caption" color="text.secondary">
                  ({count} cluster{count > 1 ? "s" : ""})
                </Typography>
              </Stack>
            ))}
          </Stack>
        ) : (
          <Typography variant="body2" color="text.secondary">
            No high-collision clusters with motives found.
          </Typography>
        )}
      </Paper>

      {/* ── D. Pair Evidence ──────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Matched-Parameter ODD Evidence
        </Typography>
        <Stack direction="row" spacing={1} sx={{ mb: 2 }} flexWrap="wrap">
          <Chip
            label={`${flipPairs.length} outcome flip${flipPairs.length !== 1 ? "s" : ""}`}
            color={flipPairs.length > 0 ? "warning" : "default"}
            size="small"
          />
          <Chip
            label={`${justifiedPairs.length} justified separation${justifiedPairs.length !== 1 ? "s" : ""}`}
            color={justifiedPairs.length > 0 ? "success" : "default"}
            size="small"
          />
          <Chip label={`${pairs.length} total pair${pairs.length !== 1 ? "s" : ""}`} size="small" variant="outlined" />
        </Stack>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Near-identical scenario parameters with different outcomes → candidate ODD edge.
        </Typography>
        {pairs.length > 0 ? (
          <Table size="small">
            <TableHead>
              <TableRow>
                <TableCell>Pack</TableCell>
                <TableCell>Param Distance</TableCell>
                <TableCell>Outcome Flip</TableCell>
                <TableCell>Separation</TableCell>
                <TableCell>Explanation</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {pairs.map((p) => (
                <TableRow
                  key={p.folder}
                  hover
                  sx={{ cursor: "pointer" }}
                  onClick={() => onNavigateTab(1)}
                >
                  <TableCell>
                    <Chip label={p.folder} size="small" variant="outlined" />
                  </TableCell>
                  <TableCell>{p.paramDist != null ? p.paramDist.toFixed(4) : "—"}</TableCell>
                  <TableCell>
                    <Chip
                      label={p.outcomeFlip ? "Yes" : "No"}
                      color={p.outcomeFlip ? "warning" : "default"}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>
                    {p.separationCall ? (
                      <Chip
                        label={p.separationCall}
                        color={
                          p.separationCall === "justified"
                            ? "success"
                            : p.separationCall === "over_fine"
                              ? "warning"
                              : "default"
                        }
                        size="small"
                      />
                    ) : (
                      "—"
                    )}
                  </TableCell>
                  <TableCell>
                    <Typography
                      variant="caption"
                      sx={{
                        display: "-webkit-box",
                        WebkitLineClamp: 2,
                        WebkitBoxOrient: "vertical",
                        overflow: "hidden",
                        maxWidth: 400,
                      }}
                    >
                      {p.contrastExplanation ?? (p.hasContrast ? "(see contrast)" : "Not yet analyzed")}
                    </Typography>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        ) : (
          <Alert severity="info">No parameter-space pairs in this run.</Alert>
        )}
      </Paper>

      {/* ── E. Rules / Boundary (S2 + S3 + S4) ──────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          ODD Boundary Export &amp; Parameter Rules
        </Typography>
        {data.boundaryExport ? (
          <>
            <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1 }}>
              <Chip size="small" label={`kNN = ${data.boundaryExport.kNN ?? "—"}`} />
              {data.boundaryExport.kpiName && (
                <Chip size="small" variant="outlined" label={`KPI: ${data.boundaryExport.kpiName}`} />
              )}
              <Chip
                size="small"
                color="warning"
                label={`${data.boundaryExport.collisionBoundaryCount} on collision boundary`}
              />
              <Chip
                size="small"
                color="info"
                label={`${data.boundaryExport.clusterBoundaryCount} on cluster boundary`}
              />
              {data.boundaryExport.nTrialsConsidered != null && (
                <Chip
                  size="small"
                  variant="outlined"
                  label={`n=${data.boundaryExport.nTrialsConsidered} trials considered`}
                />
              )}
              {data.boundaryExport.nTrialsWithoutClusterLabel != null &&
                data.boundaryExport.nTrialsWithoutClusterLabel > 0 && (
                  <Chip
                    size="small"
                    variant="outlined"
                    color="default"
                    label={`${data.boundaryExport.nTrialsWithoutClusterLabel} trials outside clustering fit`}
                  />
                )}
              {data.boundaryPairsJoin && (
                <Chip
                  size="small"
                  variant="outlined"
                  label={`${data.boundaryPairsJoin.nPairsTouchingBoundary}/${data.boundaryPairsJoin.nPairs} pairs touch the boundary`}
                />
              )}
            </Stack>
            <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
              From <code>odd_boundary_export.json</code>
              {data.boundaryExport.generatedAt
                ? ` (generated ${new Date(data.boundaryExport.generatedAt).toLocaleString()})`
                : ""}
              . Same min–max normalized kd-tree metric as Explore &rsquo;s Filtering panel — not
              comparable to parameter-space pair z-score distances. Can be (re)written from a
              terminal via <code>python -m llm_pipeline.cli odd-export --run-dir …</code> instead
              of the Explore UI button.
            </Typography>
          </>
        ) : (
          <Alert severity="info" sx={{ mb: 1 }}>
            <Typography variant="body2">
              <strong>Not yet exported.</strong> Open Explore → Filtering and click &ldquo;Export
              ODD boundary&rdquo;, or run{" "}
              <code>python -m llm_pipeline.cli odd-export --run-dir …</code> from a terminal.
            </Typography>
          </Alert>
        )}

        {data.parameterRules && data.parameterRules.rules.length > 0 ? (
          <>
            <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mt: 2, mb: 1 }}>
              <Chip size="small" label={`CART depth ≤ ${data.parameterRules.maxDepth ?? "—"}`} />
              <Chip
                size="small"
                variant="outlined"
                label={`n=${data.parameterRules.nTrialsUsed ?? "—"} trials trained on`}
              />
              {data.parameterRules.trainAcc != null && (
                <Chip size="small" variant="outlined" label={`train acc ${data.parameterRules.trainAcc}`} />
              )}
              {data.parameterRules.cvAcc != null && (
                <Chip size="small" variant="outlined" label={`cv acc ${data.parameterRules.cvAcc}`} />
              )}
            </Stack>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>Rule</TableCell>
                  <TableCell>Predicate</TableCell>
                  <TableCell>Predicts</TableCell>
                  <TableCell align="right">Support</TableCell>
                  <TableCell align="right">Precision</TableCell>
                  <TableCell align="right">Boundary hits</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {data.parameterRules.rules.map((r) => (
                  <TableRow key={r.id}>
                    <TableCell>
                      <Chip size="small" label={r.id} />
                    </TableCell>
                    <TableCell>
                      <Typography variant="body2" component="code" sx={{ fontSize: "0.8rem" }}>
                        {r.predicate}
                      </Typography>
                    </TableCell>
                    <TableCell>
                      <Chip
                        size="small"
                        color={r.predicted === "collision" ? "error" : "success"}
                        label={r.predicted}
                      />
                    </TableCell>
                    <TableCell align="right">{r.support}</TableCell>
                    <TableCell align="right">{r.precision}</TableCell>
                    <TableCell align="right">{r.boundaryTrialHits ?? "—"}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
            <Typography variant="caption" color="text.secondary" display="block" sx={{ mt: 1 }}>
              From <code>odd_parameter_rules.json</code>
              {data.parameterRules.generatedAt
                ? ` (generated ${new Date(data.parameterRules.generatedAt).toLocaleString()})`
                : ""}
              . Auditable hypotheses about the sampled trials only — not a certified SAE J3016 ODD
              boundary. Trained via <code>python -m llm_pipeline.cli odd-rules --run-dir …</code>.
            </Typography>
          </>
        ) : (
          <Alert severity="info" sx={{ mt: 2 }}>
            <Typography variant="body2">
              <strong>Parameter rules not yet available (S3).</strong> Run{" "}
              <code>python -m llm_pipeline.cli odd-rules --run-dir …</code> (needs S2&rsquo;s{" "}
              <code>odd_all_trials.json</code> first) to get auditable predicates like
              &ldquo;OncomingSpeed &gt; 12.4 AND OncomingStartDelay &lt; 0.8 →
              collision&rdquo; with precision/support.
            </Typography>
          </Alert>
        )}
      </Paper>

      {/* ── F. Merge / Split Advice ───────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Clustering Trust
        </Typography>
        {data.mergeCandidates.length > 0 ? (
          <>
            <Alert severity="warning" sx={{ mb: 1 }}>
              <Typography variant="body2" fontWeight={600}>
                Merge candidates detected
              </Typography>
              {data.mergeCandidates.map((mc, i) => (
                <Typography key={i} variant="caption" display="block">
                  cluster{mc.clusters[0]} + cluster{mc.clusters[1]} — shared motive{" "}
                  <strong>{mc.sharedMotive}</strong>, param overlap {mc.paramOverlap.toFixed(2)}
                </Typography>
              ))}
            </Alert>
          </>
        ) : (
          <Alert severity="success" sx={{ mb: 1 }}>
            No merge candidates — all clusters appear sufficiently distinct.
          </Alert>
        )}
        {data.selectionFindings.length > 0 && (
          <Stack spacing={0.5} sx={{ mt: 1 }}>
            {data.selectionFindings.map((f, i) => (
              <Typography key={i} variant="body2">
                • {f}
              </Typography>
            ))}
          </Stack>
        )}
        <Button
          variant="text"
          size="small"
          sx={{ mt: 1 }}
          onClick={() => onNavigateTab(2)}
        >
          View detailed cluster analysis →
        </Button>
      </Paper>

      {/* ── G. Recommended Next Tests ─────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Recommended Next Tests
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Deterministic priorities based on current analysis gaps.
        </Typography>
        <Stack spacing={1}>
          {highFailNoContrast.length > 0 && (
            <Alert severity="warning">
              <Typography variant="body2">
                <strong>High-collision clusters without pair contrast:</strong>{" "}
                {highFailNoContrast.map((c) => `cluster${c.id} (${c.collisionRate?.toFixed(1)}%)`).join(", ")}
              </Typography>
              <Typography variant="caption">
                These clusters have high failure rates but no parameter-space pair analysis yet.
              </Typography>
            </Alert>
          )}
          {inconclusivePairs.length > 0 && (
            <Alert severity="info">
              <Typography variant="body2">
                <strong>Inconclusive pair separations:</strong>{" "}
                {inconclusivePairs.map((p) => p.folder).join(", ")}
              </Typography>
              <Typography variant="caption">
                Re-examine these pairs — the current analysis could not determine if the separation is justified.
              </Typography>
            </Alert>
          )}
          {highFailNoContrast.length === 0 && inconclusivePairs.length === 0 && (
            <Alert severity="success">
              All high-collision clusters have pair contrasts and all separations are resolved.
            </Alert>
          )}
        </Stack>
      </Paper>

      {/* ── Captions (per-cluster expandable) ─────────────────────────── */}
      {clusters.some((c) => c.summaryCaption) && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="h6" gutterBottom>
            Cluster Summaries
          </Typography>
          {clusters.map((c) =>
            c.summaryCaption ? (
              <Accordion key={c.id} disableGutters elevation={0} variant="outlined" sx={{ mb: 0.5 }}>
                <AccordionSummary expandIcon={<ExpandMore />}>
                  <Stack direction="row" spacing={1} alignItems="center">
                    <Chip label={`C${c.id}`} size="small" />
                    <Typography variant="subtitle2">{c.label ?? `Cluster ${c.id}`}</Typography>
                    {c.riskLevel && (
                      <Chip label={c.riskLevel} color={riskColor(c.riskLevel)} size="small" />
                    )}
                  </Stack>
                </AccordionSummary>
                <AccordionDetails>
                  <Typography
                    variant="body2"
                    sx={{ whiteSpace: "pre-wrap", lineHeight: 1.7 }}
                  >
                    {c.summaryCaption}
                  </Typography>
                  {c.consistencyNote && (
                    <Typography variant="caption" color="text.secondary" sx={{ mt: 1, display: "block" }}>
                      Consistency: {c.consistencyNote}
                    </Typography>
                  )}
                </AccordionDetails>
              </Accordion>
            ) : null,
          )}
        </Paper>
      )}

      {/* ── H. ODD Q&A (S5 part 2) ────────────────────────────────────── */}
      <OddChatPanel batchId={batchId} folder={folder} />
    </Stack>
  );
}

// ─── ODD Q&A panel (S5 part 2) ─────────────────────────────────────────────
//
// Thin UI over POST/GET /api/odd-chat, which itself shells out to the exact
// same `python -m llm_pipeline.cli odd-chat` CLI documented in
// implementation_plan.md §7 / §9.1 and app/llm_pipeline/README.md — there is
// intentionally only one place the grounded-chat logic lives. Conversation
// history is NOT component/browser state: every turn is appended by the CLI
// to `odd_chat_log.jsonl` inside the run folder, and this panel simply reads
// it back on mount — so re-opening the dashboard (even in a different
// browser) shows the same history, and the same history is shared with
// anyone asking questions from a terminal.
type ChatTurn = {
  timestamp?: string;
  question: string;
  answer: string;
  citations: string[];
  model: string;
  dry_run?: boolean;
};

const CHAT_MODEL_OPTIONS = [
  "gemini-2.5-flash",
  "gemini-2.5-pro",
  "gemini-2.5-flash-lite",
  "gpt-4o",
  "gpt-4o-mini",
  "gpt-4-turbo",
];

function OddChatPanel({ batchId, folder }: { batchId: string; folder: string }) {
  const [history, setHistory] = useState<ChatTurn[]>([]);
  const [briefingAvailable, setBriefingAvailable] = useState<boolean | null>(null);
  const [missing, setMissing] = useState<string[]>([]);
  const [loadingHistory, setLoadingHistory] = useState(true);
  const [question, setQuestion] = useState("");
  const [asking, setAsking] = useState(false);
  const [askError, setAskError] = useState<string | null>(null);
  const [chatModel, setChatModel] = useState("gemini-2.5-flash");
  const [chatApiKey, setChatApiKey] = useState("");
  const logRef = useRef<HTMLDivElement>(null);

  const loadHistory = useCallback(() => {
    setLoadingHistory(true);
    fetch(`/api/odd-chat?batchId=${batchId}&folder=${encodeURIComponent(folder)}`)
      .then((r) => r.json())
      .then((d) => {
        setBriefingAvailable(Boolean(d.briefingAvailable));
        setMissing(d.missing ?? []);
        setHistory(d.history ?? []);
      })
      .catch(() => setBriefingAvailable(false))
      .finally(() => setLoadingHistory(false));
  }, [batchId, folder]);

  useEffect(() => {
    loadHistory();
  }, [loadHistory]);

  useEffect(() => {
    if (logRef.current) logRef.current.scrollTop = logRef.current.scrollHeight;
  }, [history]);

  const ask = async () => {
    const q = question.trim();
    if (!q || asking) return;
    setAsking(true);
    setAskError(null);
    try {
      const res = await fetch("/api/odd-chat", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          batchId: Number(batchId),
          folder,
          question: q,
          model: chatModel,
          apiKey: chatApiKey || undefined,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      setHistory((h) => [
        ...h,
        {
          timestamp: new Date().toISOString(),
          question: q,
          answer: data.answer,
          citations: data.citations ?? [],
          model: data.model ?? chatModel,
          dry_run: Boolean(data.dry_run),
        },
      ]);
      setQuestion("");
    } catch (e) {
      setAskError(e instanceof Error ? e.message : String(e));
    } finally {
      setAsking(false);
    }
  };

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>
        ODD Q&amp;A
      </Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
        Ask a question about this one run (e.g. &ldquo;What is the weakness of this AV
        system?&rdquo;, &ldquo;Which condition leads to high failure probability?&rdquo;,
        &ldquo;Why keep these clusters separate?&rdquo;). Answers are grounded only in this
        run&rsquo;s deterministic stats + LLM-authored cluster/pair products (
        <code>odd_chat_briefing.json</code>) — never invented. History below is stored in{" "}
        <code>odd_chat_log.jsonl</code> in the run folder, so it is still here next time this
        dashboard is opened (by anyone), and is shared with the same command run from a terminal.
      </Typography>

      {loadingHistory ? (
        <Stack alignItems="center" sx={{ py: 2 }}>
          <CircularProgress size={22} />
        </Stack>
      ) : !briefingAvailable ? (
        <Alert severity="info">
          <Typography variant="body2">
            <strong>Not available yet.</strong> Build the briefing first (needs S2 boundary
            export):
          </Typography>
          <Typography variant="body2" component="pre" sx={{ fontSize: "0.78rem", mt: 0.5 }}>
            {`python -m llm_pipeline.cli odd-export --run-dir results/batch${batchId}/${folder}\npython -m llm_pipeline.cli odd-rules --run-dir results/batch${batchId}/${folder}\npython -m llm_pipeline.cli odd-join --run-dir results/batch${batchId}/${folder}\npython -m llm_pipeline.cli odd-briefing --run-dir results/batch${batchId}/${folder}`}
          </Typography>
        </Alert>
      ) : (
        <>
          {missing.length > 0 && (
            <Alert severity="warning" sx={{ mb: 1 }}>
              <Typography variant="body2">
                Briefing has gaps — the chat will say &ldquo;unknown&rdquo; rather than guess for:{" "}
                {missing.join("; ")}
              </Typography>
            </Alert>
          )}

          <Box
            ref={logRef}
            sx={{
              maxHeight: 380,
              overflowY: "auto",
              mb: 2,
              border: "1px solid",
              borderColor: "divider",
              borderRadius: 1,
              p: 1.5,
            }}
          >
            {history.length === 0 ? (
              <Typography variant="body2" color="text.secondary">
                No questions asked yet for this run.
              </Typography>
            ) : (
              history.map((t, i) => (
                <Box key={i} sx={{ mb: 2 }}>
                  <Typography variant="subtitle2">You: {t.question}</Typography>
                  <Typography variant="body2" sx={{ whiteSpace: "pre-wrap", mt: 0.5 }}>
                    {t.answer}
                  </Typography>
                  <Stack direction="row" spacing={0.5} flexWrap="wrap" sx={{ mt: 0.5 }}>
                    {(t.citations ?? []).map((c, j) => (
                      <Chip key={j} label={c} size="small" variant="outlined" />
                    ))}
                    {t.dry_run && (
                      <Chip label="dry-run (no API key)" size="small" color="warning" />
                    )}
                    <Chip label={t.model} size="small" variant="outlined" />
                  </Stack>
                  {i < history.length - 1 && <Divider sx={{ mt: 1.5 }} />}
                </Box>
              ))
            )}
          </Box>

          {askError && (
            <Alert severity="error" sx={{ mb: 1 }}>
              {askError}
            </Alert>
          )}

          <Stack direction="row" spacing={1} sx={{ mb: 1 }} flexWrap="wrap">
            <Select
              size="small"
              value={chatModel}
              onChange={(e) => setChatModel(e.target.value)}
              sx={{ minWidth: 190 }}
            >
              {CHAT_MODEL_OPTIONS.map((m) => (
                <MenuItem key={m} value={m}>
                  {m}
                </MenuItem>
              ))}
            </Select>
            <TextField
              size="small"
              label={`${chatModel.startsWith("gpt") || chatModel.startsWith("o") ? "OpenAI" : "Google"} API key (ephemeral)`}
              type="password"
              value={chatApiKey}
              onChange={(e) => setChatApiKey(e.target.value)}
              sx={{ flex: 1, minWidth: 220 }}
              helperText="Sent only to this server process env for one call, never stored"
            />
          </Stack>

          <Stack direction="row" spacing={1}>
            <TextField
              size="small"
              fullWidth
              placeholder='e.g. "Which scenario should we test next?"'
              value={question}
              onChange={(e) => setQuestion(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === "Enter" && !e.shiftKey) {
                  e.preventDefault();
                  ask();
                }
              }}
            />
            <Button variant="contained" onClick={ask} disabled={asking || !question.trim()}>
              {asking ? <CircularProgress size={18} /> : "Ask"}
            </Button>
          </Stack>
          <Typography variant="caption" color="text.secondary" sx={{ mt: 0.5, display: "block" }}>
            No key entered → server falls back to the <code>GOOGLE_API_KEY</code> /{" "}
            <code>OPENAI_API_KEY</code> environment variables it was started with, or answers in
            dry-run mode (no LLM call) if neither is set. No AI-provider account login is required
            — only an API key.
          </Typography>
        </>
      )}
    </Paper>
  );
}
