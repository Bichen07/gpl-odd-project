"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import {
  Alert,
  Box,
  Button,
  CircularProgress,
  Container,
  IconButton,
  LinearProgress,
  MenuItem,
  Paper,
  Stack,
  Tab,
  Tabs,
  Typography,
} from "@mui/material";
import { ArrowBack } from "@mui/icons-material";
import { selectDefaultSnapshots } from "@/app/_shared/utils/snapshotSelection";
import type {
  ClusteringQuality,
  Config,
  ModelOption,
  ResultEntry,
  SplitAnalysis,
} from "./types";
import {
  EMPTY_PRODUCT_RUN,
  TAB,
  type AnalyzeProduct,
  type ProductRunState,
} from "./constants";
import { countProductCompletions, productFromSpec } from "./utils";
import ModelSetup from "./panels/ModelSetup";
import MedoidAnalysis from "./panels/MedoidAnalysis";
import ParameterSpacePairs from "./panels/ParameterSpacePairs";
import ClusterAnalysis from "./panels/ClusterAnalysis";
import CrossClusterAnalysis from "./panels/CrossClusterAnalysis";
import Report from "./panels/Report";
import OddQA from "./panels/OddQA";

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
  const [evalLogs, setEvalLogs] = useState("");
  const [evalLogFile, setEvalLogFile] = useState("");
  const [evalCompleted, setEvalCompleted] = useState(0);
  const [evalTotal, setEvalTotal] = useState(0);
  const evalJobIdRef = useRef<string | null>(null);
  const evalAbortRef = useRef<AbortController | null>(null);

  // --- prompts (editable) ---
  const [prompts, setPrompts] = useState<Record<string, string>>({});
  const [models, setModels] = useState<ModelOption[]>([]);

  // --- per-cluster image selection + which clusters to run ---
  const [selected, setSelected] = useState<Record<number, string[]>>({});
  const [runClusters, setRunClusters] = useState<Set<number>>(new Set());
  const [summaryRunClusters, setSummaryRunClusters] = useState<Set<number>>(new Set());
  const [selectedPairs, setSelectedPairs] = useState<Set<string>>(new Set());
  const [autoCount] = useState<number>(0); // 0 = all BEV (no skip)
  const [perClusterMax, setPerClusterMax] = useState<Record<number, number>>({}); // 0 = all; per cluster

  // --- run state (per product: medoid / pairs / summary) ---
  const [runningProduct, setRunningProduct] = useState<AnalyzeProduct | null>(null);
  const [activeClusters, setActiveClusters] = useState<number[]>([]);
  const [results, setResults] = useState<ResultEntry[]>([]);
  const [splitAnalysis, setSplitAnalysis] = useState<SplitAnalysis | null>(null);
  const [splitSubTab, setSplitSubTab] = useState(0);
  const [productRuns, setProductRuns] = useState<Record<AnalyzeProduct, ProductRunState>>({
    medoid: { ...EMPTY_PRODUCT_RUN },
    "parameter-space-pairs": { ...EMPTY_PRODUCT_RUN },
    summary: { ...EMPTY_PRODUCT_RUN },
  });
  const analyzeJobIdRef = useRef<string | null>(null);
  const analyzeAbortRef = useRef<AbortController | null>(null);
  const running = runningProduct != null;

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
        sel[c.cluster] = [...c.snapshots]; // default: all BEV, no skip
      }
      setSelected(sel);
      setRunClusters(new Set(cfg.clusters.map((c) => c.cluster)));
      const readySummary = (cfg.splitAnalysis?.clusters ?? [])
        .filter((c) => c.readyForSummary)
        .map((c) => c.cluster);
      setSummaryRunClusters(
        new Set(readySummary.length ? readySummary : cfg.clusters.map((c) => c.cluster)),
      );
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

  const stopCrossClusterEval = useCallback(async () => {
    evalAbortRef.current?.abort();
    const jobId = evalJobIdRef.current;
    if (!jobId) return;
    try {
      await fetch("/api/cluster-evaluate/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "stop", jobId }),
      });
    } catch {
      /* best-effort */
    }
  }, []);

  const runCrossClusterEval = async () => {
    if (!config?.folder || evalRunning) return;
    setEvalRunning(true);
    setEvalError(null);
    setEvalLogs("");
    setEvalLogFile("");
    setEvalCompleted(0);
    setEvalTotal(3); // selection-eval → LLM → rescore
    evalJobIdRef.current = null;
    const abort = new AbortController();
    evalAbortRef.current = abort;
    try {
      const res = await fetch("/api/cluster-evaluate/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        signal: abort.signal,
        body: JSON.stringify({
          batchId: Number(batchId),
          folder: config.folder,
          model,
          apiKey: apiKey || undefined,
        }),
      });

      if (!res.body || !res.headers.get("content-type")?.includes("ndjson")) {
        const data = await res.json().catch(() => ({}));
        const detail = [data.error, data.stderr].filter(Boolean).join("\n");
        throw new Error(detail || `HTTP ${res.status}`);
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
          let msg: Record<string, unknown>;
          try {
            msg = JSON.parse(line);
          } catch {
            continue;
          }
          if (msg.type === "start" && msg.jobId) {
            evalJobIdRef.current = String(msg.jobId);
          } else if (msg.type === "log" && typeof msg.data === "string") {
            live += msg.data;
            setEvalLogs(live);
          } else if (msg.type === "progress") {
            if (typeof msg.pct === "number") {
              setEvalCompleted(Math.max(1, Math.round((msg.pct / 100) * 3)));
            }
          } else if (msg.type === "done") {
            if (msg.logFile) setEvalLogFile(String(msg.logFile));
            setEvalCompleted(3);
            if (msg.stopped) {
              setEvalError("Cross-cluster eval stopped by user.");
            } else if (!msg.ok) {
              setEvalError(
                `Cross-cluster eval failed (exit ${msg.exitCode ?? "?"}). See log below.`,
              );
            }
          }
        }
      }

      const r2 = await fetch(`/api/cluster-evaluate?batchId=${encodeURIComponent(batchId)}`);
      const d2 = await r2.json();
      setEvalConfigs(d2.configs ?? []);
    } catch (err) {
      if ((err as Error)?.name === "AbortError") {
        setEvalError("Cross-cluster eval stopped by user.");
      } else {
        setEvalError(String(err));
      }
    } finally {
      setEvalRunning(false);
      evalJobIdRef.current = null;
      evalAbortRef.current = null;
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

  const stopAnalyze = useCallback(async () => {
    analyzeAbortRef.current?.abort();
    const jobId = analyzeJobIdRef.current;
    if (!jobId) return;
    try {
      await fetch("/api/cluster-analyze/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "stop", jobId }),
      });
    } catch {
      /* best-effort */
    }
  }, []);

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
    const max = perClusterMax[cluster] ?? 0; // 0 = all; remembered per cluster
    setSelected((prev) => ({
      ...prev,
      [cluster]: max <= 0 || max >= snapshots.length
        ? [...snapshots]
        : selectDefaultSnapshots(snapshots, max, medoid),
    }));
  };

  const toggleSummaryRunCluster = (cluster: number) => {
    setSummaryRunClusters((prev) => {
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

  const patchProductRun = useCallback(
    (product: AnalyzeProduct, patch: Partial<ProductRunState>) => {
      setProductRuns((prev) => ({
        ...prev,
        [product]: { ...prev[product], ...patch },
      }));
    },
    [],
  );

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
    const product = productFromSpec(productsSpec);
    const isIcPairs = product === "parameter-space-pairs";
    const pairsToRun =
      isIcPairs && pairFolders && pairFolders.length > 0
        ? [...pairFolders].sort()
        : undefined;
    const clustersToRun = (subset && subset.length ? subset : [...runClusters]).sort(
      (a, b) => a - b,
    );
    if (!pairsToRun && clustersToRun.length === 0) return;
    if (!dryRun && !String(apiKey).trim()) {
      patchProductRun(product, {
        error:
          "Enter the API key in Model setup. Server env keys are not used, so another user's key cannot leak into this run.",
      });
      setActiveTab(TAB.SETUP);
      return;
    }

    const total = pairsToRun?.length ?? clustersToRun.length;
    setRunningProduct(product);
    setActiveClusters(clustersToRun);
    patchProductRun(product, {
      logs: "",
      logFile: "",
      error: null,
      total,
      completed: 0,
    });
    const abort = new AbortController();
    analyzeAbortRef.current = abort;
    analyzeJobIdRef.current = null;
    try {
      const selectedImages: Record<string, string[]> = {};
      for (const c of clustersToRun) selectedImages[String(c)] = selected[c] ?? [];
      const res = await fetch("/api/cluster-analyze/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        signal: abort.signal,
        body: JSON.stringify({
          batchId,
          folder: config.folder,
          clusters: pairsToRun ? undefined : clustersToRun,
          pairs: pairsToRun,
          model,
          apiKey: String(apiKey).trim(),
          temperature,
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
        const text = String(data.logs ?? data.error ?? "");
        const err =
          !data.ok && data.error
            ? `${data.error}${
                Array.isArray(data.details) ? `\n${data.details.join("\n")}` : ""
              }`
            : !data.ok
              ? `Run failed (code ${data.exitCode ?? "?"}).`
              : null;
        patchProductRun(product, {
          logs: text,
          completed: countProductCompletions(product, text),
          error: err,
        });
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
          if (msg.type === "start" && msg.jobId) {
            analyzeJobIdRef.current = String(msg.jobId);
          } else if (msg.type === "log") {
            live += msg.data;
            patchProductRun(product, {
              logs: live,
              completed: countProductCompletions(product, live),
            });
          } else if (msg.type === "done") {
            if (Array.isArray(msg.results)) mergeResults(msg.results);
            const donePatch: Partial<ProductRunState> = {
              logs: live,
              completed: countProductCompletions(product, live),
            };
            if (msg.logFile) donePatch.logFile = String(msg.logFile);
            if (msg.stopped) {
              donePatch.error = "Analysis stopped by user.";
            } else if (!msg.ok) {
              donePatch.error = `Run exited with code ${msg.exitCode}. Check the live log below.`;
            }
            patchProductRun(product, donePatch);
            try {
              await reloadConfig();
            } catch {
              /* keep in-memory results if refresh fails */
            }
          }
        }
      }
    } catch (err) {
      const aborted =
        (err instanceof DOMException && err.name === "AbortError") ||
        (err instanceof Error && err.name === "AbortError");
      patchProductRun(product, {
        error: aborted ? "Analysis stopped by user." : String(err),
      });
    } finally {
      analyzeJobIdRef.current = null;
      analyzeAbortRef.current = null;
      setRunningProduct(null);
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

      <Tabs value={activeTab} onChange={(_, v) => setActiveTab(v)} sx={{ mb: 2 }} variant="scrollable" scrollButtons="auto">
        <Tab label="Model setup" />
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
        <Tab label="Cluster analysis" />
        <Tab
          label={`Cross-cluster analysis${
            currentQuality?.final_score != null
              ? ` (score ${currentQuality.final_score.toFixed(1)})`
              : ""
          }`}
        />
        <Tab label="Report" />
        <Tab label="ODD Q&A" />
      </Tabs>


      {activeTab === TAB.SETUP && (
        <ModelSetup
          provider={provider}
          model={model}
          setModel={setModel}
          models={config.models}
          apiKey={apiKey}
          setApiKey={setApiKey}
          temperature={temperature}
          setTemperature={setTemperature}
          review={review}
          setReview={setReview}
          dryRun={dryRun}
          setDryRun={setDryRun}
        />
      )}

      {activeTab === TAB.PAIRS && (
        <ParameterSpacePairs
          prompts={prompts}
          setPrompts={setPrompts}
          splitAnalysis={splitAnalysis}
          selectedPairs={selectedPairs}
          setSelectedPairs={setSelectedPairs}
          running={running}
          runningProduct={runningProduct}
          productRuns={productRuns}
          run={run}
          stopAnalyze={stopAnalyze}
          folder={config.folder}
          batchId={batchId}
          apiKey={apiKey}
          dryRun={dryRun}
        />
      )}

      {activeTab === TAB.CLUSTER && (
        <ClusterAnalysis
          config={config}
          batchId={batchId}
          splitAnalysis={splitAnalysis}
          prompts={prompts}
          setPrompts={setPrompts}
          summaryRunClusters={summaryRunClusters}
          setSummaryRunClusters={setSummaryRunClusters}
          toggleSummaryRunCluster={toggleSummaryRunCluster}
          running={running}
          runningProduct={runningProduct}
          productRuns={productRuns}
          run={run}
          stopAnalyze={stopAnalyze}
          apiKey={apiKey}
          dryRun={dryRun}
          splitSubTab={splitSubTab}
          setSplitSubTab={setSplitSubTab}
          nClustersNoMedoid={nClustersNoMedoid}
          nIcPairsUnbuilt={nIcPairsUnbuilt}
          splitClustersForPrereq={splitClustersForPrereq}
          icPairsForPrereq={icPairsForPrereq}
          clustersMissingIcContrasts={clustersMissingIcContrasts}
          summaryBlocked={summaryBlocked}
        />
      )}

      {activeTab === TAB.CROSS_CLUSTER && (
        <CrossClusterAnalysis
          config={config}
          batchId={batchId}
          splitAnalysis={splitAnalysis}
          evalRunning={evalRunning}
          evalError={evalError}
          evalLogs={evalLogs}
          evalLogFile={evalLogFile}
          evalCompleted={evalCompleted}
          evalTotal={evalTotal}
          runCrossClusterEval={runCrossClusterEval}
          stopCrossClusterEval={stopCrossClusterEval}
          evalConfigs={evalConfigs}
          currentCrossEval={currentCrossEval}
          currentBoundaryPairs={currentBoundaryPairs}
          currentQuality={currentQuality ?? null}
        />
      )}

      {activeTab === TAB.MEDOID && (
        <MedoidAnalysis
          config={config}
          prompts={prompts}
          setPrompts={setPrompts}
          selected={selected}
          setSelected={setSelected}
          runClusters={runClusters}
          setRunClusters={setRunClusters}
          perClusterMax={perClusterMax}
          setPerClusterMax={setPerClusterMax}
          applyAuto={applyAuto}
          toggleImage={toggleImage}
          imgUrl={imgUrl}
          analyzedClusters={analyzedClusters}
          running={running}
          runningProduct={runningProduct}
          productRuns={productRuns}
          run={run}
          stopAnalyze={stopAnalyze}
          apiKey={apiKey}
          dryRun={dryRun}
          results={results}
          downloadYaml={downloadYaml}
          splitAnalysis={splitAnalysis}
        />
      )}

      {activeTab === TAB.REPORT && config && (
        <Report
          batchId={batchId}
          folder={config.folder}
          onNavigateTab={setActiveTab}
        />
      )}

      {activeTab === TAB.ODD_QA && config && (
        <OddQA
          batchId={batchId}
          folder={config.folder}
          apiKey={apiKey}
          model={model}
          onOpenSetup={() => setActiveTab(TAB.SETUP)}
        />
      )}

    </Container>
  );
}
