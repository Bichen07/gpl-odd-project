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
  TextField,
  Typography,
} from "@mui/material";
import { ArrowBack, ExpandMore } from "@mui/icons-material";

type ClusterEntry = {
  cluster: number;
  stats: Record<string, unknown> | null;
  medoid: Record<string, unknown> | null;
  snapshots: string[];
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

function evenlySpaced(items: string[], n: number): string[] {
  if (n <= 0 || items.length === 0) return [];
  if (items.length <= n) return [...items];
  if (n === 1) return [items[0]];
  const out: string[] = [];
  for (let i = 0; i < n; i += 1) {
    out.push(items[Math.round((i * (items.length - 1)) / (n - 1))]);
  }
  return Array.from(new Set(out));
}

function snapshotLabel(name: string): string {
  const m = name.match(/_t_(\d+(?:\.\d+)?)/i);
  return m ? `t=${m[1]}s` : name;
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

  // --- model setup ---
  const [model, setModel] = useState<string>("gemini-2.5-flash");
  const [apiKey, setApiKey] = useState<string>("");
  const [temperature, setTemperature] = useState<number>(0.1);
  const [review, setReview] = useState<boolean>(true);
  const [dryRun, setDryRun] = useState<boolean>(false);

  // --- prompts (editable) ---
  const [prompts, setPrompts] = useState<Record<string, string>>({});

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

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch(
          `/api/cluster-analyze?batchId=${encodeURIComponent(batchId)}&k=${encodeURIComponent(k)}&s=${encodeURIComponent(s)}`,
        );
        const data = await res.json();
        if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
        if (cancelled) return;
        const cfg = data as Config;
        setConfig(cfg);
        setPrompts(cfg.prompts ?? {});
        if (cfg.models?.length) setModel(cfg.models[0].id);
        const sel: Record<number, string[]> = {};
        for (const c of cfg.clusters) sel[c.cluster] = evenlySpaced(c.snapshots, autoCount);
        setSelected(sel);
        setRunClusters(new Set(cfg.clusters.map((c) => c.cluster)));
        // Show previously-saved interpretations so a re-run isn't required.
        if (cfg.results?.length) setResults(cfg.results);
      } catch (err) {
        if (!cancelled) setLoadError(String(err));
      }
    })();
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [batchId, k, s]);

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

  const applyAuto = (cluster: number, snapshots: string[]) => {
    setSelected((prev) => ({ ...prev, [cluster]: evenlySpaced(snapshots, autoCount) }));
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

  if (!config) {
    return (
      <Stack alignItems="center" justifyContent="center" sx={{ height: "60vh" }}>
        <CircularProgress />
        <Typography sx={{ mt: 2 }}>Loading clustering result…</Typography>
      </Stack>
    );
  }

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
                      <Button size="small" onClick={() => applyAuto(c.cluster, c.snapshots)}>
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
    </Container>
  );
}
