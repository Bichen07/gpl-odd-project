"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import {
  Alert,
  Box,
  Button,
  Checkbox,
  Chip,
  CircularProgress,
  Collapse,
  FormControl,
  FormControlLabel,
  IconButton,
  InputAdornment,
  InputLabel,
  LinearProgress,
  MenuItem,
  Paper,
  Select,
  Stack,
  Step,
  StepLabel,
  Stepper,
  TextField,
  Tooltip,
  Typography,
  useTheme,
} from "@mui/material";
import VisibilityIcon from "@mui/icons-material/Visibility";
import VisibilityOffIcon from "@mui/icons-material/VisibilityOff";
import PlayArrowIcon from "@mui/icons-material/PlayArrow";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import ExpandLessIcon from "@mui/icons-material/ExpandLess";
import RefreshIcon from "@mui/icons-material/Refresh";
import CheckCircleIcon from "@mui/icons-material/CheckCircle";
import ErrorIcon from "@mui/icons-material/Error";
import ImageIcon from "@mui/icons-material/Image";
import ThemeToggleButton from "@/components/ThemeToggleButton";
import {
  useAppSelector,
  useAppDispatch,
} from "@/app/batch/[id]/_tabs/explore/redux/hooks";
import { batchSlice } from "@/app/batch/[id]/_tabs/explore/redux/slices/batch";

/* ───────── types ───────── */
type ClusterInterpretation = {
  clusterId: string;
  clusterLabel: string;
  behaviorDescription: string;
  confidence: string;
  safetyAssessment?: Record<string, unknown>;
  parameterConditions?: Record<string, unknown>;
  rawYaml?: string;
};

type StageView = {
  files: string[];
  preview: string;
  interpretations?: ClusterInterpretation[];
};

type ApiResponse = {
  root: string;
  llmArtifactsRoot?: string;
  runs: string[];
  clusterRuns?: string[];
  captureRuns?: string[];
  hasBev?: boolean;
  defaultRunId?: string | null;
  selectedRunId: string | null;
  stages: Record<string, StageView>;
};

type BevCluster = { clusterId: string; bevFiles: string[] };

type BevGenStatus = {
  runId: string;
  state: string;
  progress: number;
  total: number;
  message: string;
  clusters?: Record<
    string,
    { medoidTrialId: string; clusterSize: number; bevFiles: string[] }
  >;
};

const MODELS = [
  "gpt-4o",
  "gpt-4o-mini",
  "gpt-4.1",
  "gpt-4.1-mini",
  "o3-mini",
];

const PIPELINE_STEPS = [
  "Phase 4: Build Dataset",
  "Phase 5: LLM Interpret",
  "Phase 6: Store Results",
];

const confidenceColor = (c: string) => {
  if (c === "high") return "success";
  if (c === "medium") return "warning";
  return "error";
};

/* ═══════════════════════════════════════ */
export default function LlmAnalysis() {
  const theme = useTheme();
  const isDark = theme.palette.mode === "dark";
  const bgCard = theme.palette.background.paper;
  const bgPre =
    theme.palette.mode === "dark"
      ? theme.palette.grey[900]
      : theme.palette.grey[50];
  const fgPre = theme.palette.text.primary;
  const borderColor = theme.palette.divider;
  const bgPage = theme.palette.background.default;
  const fgPage = theme.palette.text.primary;

  const dispatch = useAppDispatch();

  /* ───── Redux: selected clustering ───── */
  const selectedClusteringResult = useAppSelector(
    (s) => s.batch.selectedClusteringResult,
  );
  const selectedClusteringResults = useAppSelector(
    (s) => s.batch.selectedClusteringResults,
  );
  const egos = useAppSelector((s) => s.batch.egos);
  const trajectoryAnalysis = useAppSelector((s) => s.batch.trajectoryAnalysis);
  const batchObj = useAppSelector((s) => s.batch.batch);

  const activeClusteringResult = useMemo(() => {
    if (selectedClusteringResult) return selectedClusteringResult;
    if (selectedClusteringResults && egos.length > 0)
      return selectedClusteringResults[egos[0]] ?? null;
    return null;
  }, [selectedClusteringResult, selectedClusteringResults, egos]);

  const nClusters = useMemo(() => {
    if (!activeClusteringResult?.data) return 0;
    const labels = new Set(
      Object.values(activeClusteringResult.data).map((d) =>
        typeof d === "string" ? d : d.label,
      ),
    );
    labels.delete("-1");
    return labels.size;
  }, [activeClusteringResult]);

  const clusteringDataFlat = useMemo(() => {
    if (!activeClusteringResult?.data) return null;
    const m: Record<string, string> = {};
    for (const [tid, item] of Object.entries(activeClusteringResult.data)) {
      m[tid] = typeof item === "string" ? item : item.label;
    }
    return m;
  }, [activeClusteringResult]);

  /* ───── state ───── */
  const [data, setData] = useState<ApiResponse | null>(null);
  const [runId, setRunId] = useState<string>("");
  const [loading, setLoading] = useState(false);

  const [apiKey, setApiKey] = useState("");
  const [showKey, setShowKey] = useState(false);
  const [model, setModel] = useState("gpt-4o");
  const [dataset, setDataset] = useState("dataset1");
  const [dryRun, setDryRun] = useState(true);

  const [running, setRunning] = useState(false);
  const [pipelineStep, setPipelineStep] = useState(-1);
  const [pipelineLogs, setPipelineLogs] = useState("");
  const [pipelineOk, setPipelineOk] = useState<boolean | null>(null);

  const [bevData, setBevData] = useState<BevCluster[]>([]);
  const [selectedCluster, setSelectedCluster] = useState("");
  const [selectedBev, setSelectedBev] = useState("");
  const [selectedBevFiles, setSelectedBevFiles] = useState<Set<string>>(
    new Set(),
  );

  const [showStages, setShowStages] = useState(false);
  const [expandedYaml, setExpandedYaml] = useState<string | null>(null);

  // BEV generation
  const [bevGenerating, setBevGenerating] = useState(false);
  const [bevGenStatus, setBevGenStatus] = useState<BevGenStatus | null>(null);
  const pollRef = useRef<ReturnType<typeof setInterval> | null>(null);

  /* ───── fetch artifacts ───── */
  const fetchArtifacts = useCallback(
    (rid?: string) => {
      setLoading(true);
      const qs = rid || runId ? `?runId=${encodeURIComponent(rid || runId)}` : "";
      fetch(`/api/llm-artifacts${qs}`)
        .then((r) => r.json())
        .then((d: ApiResponse) => {
          setData(d);
          if (rid) {
            setRunId(rid);
          } else if (!runId || !d.runs.includes(runId)) {
            setRunId(
              d.defaultRunId || d.clusterRuns?.[0] || d.selectedRunId || "",
            );
          }
        })
        .catch(() => setData(null))
        .finally(() => setLoading(false));
    },
    [runId],
  );

  useEffect(() => {
    fetchArtifacts();
  }, [fetchArtifacts]);

  /* ───── fetch bev images ───── */
  useEffect(() => {
    if (!runId) return;
    fetch(`/api/llm-artifacts/bev?runId=${encodeURIComponent(runId)}`)
      .then((r) => r.json())
      .then((d) => {
        setBevData(d.clusters || []);
        if (d.clusters?.length > 0) setSelectedCluster(d.clusters[0].clusterId);
      })
      .catch(() => setBevData([]));
  }, [runId]);

  const bevFiles = useMemo(
    () =>
      bevData.find((c) => c.clusterId === selectedCluster)?.bevFiles ?? [],
    [bevData, selectedCluster],
  );

  useEffect(() => {
    if (bevFiles.length > 0 && !bevFiles.includes(selectedBev))
      setSelectedBev(bevFiles[0]);
  }, [bevFiles, selectedBev]);

  /* ───── BEV generation ───── */
  const handleGenerateBev = async () => {
    if (!clusteringDataFlat || nClusters === 0) return;
    setBevGenerating(true);
    setBevGenStatus(null);

    try {
      const res = await fetch("/api/llm-artifacts/generate-bev", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          dataset,
          nClusters,
          batchId: String(batchObj?.id || 1),
          clusteringData: clusteringDataFlat,
          nSnapshots: 12,
        }),
      });
      const json = await res.json();
      if (!json.runId) {
        setBevGenerating(false);
        return;
      }
      const genRunId = json.runId as string;
      setBevGenStatus({
        runId: genRunId,
        state: "starting",
        progress: 0,
        total: json.total || nClusters * 12,
        message: "Starting...",
      });

      if (pollRef.current) clearInterval(pollRef.current);
      pollRef.current = setInterval(async () => {
        try {
          const sr = await fetch(
            `/api/llm-artifacts/generate-bev?runId=${encodeURIComponent(genRunId)}`,
          );
          const st = (await sr.json()) as BevGenStatus;
          setBevGenStatus(st);
          if (st.state === "done" || st.state === "error") {
            if (pollRef.current) clearInterval(pollRef.current);
            pollRef.current = null;
            setBevGenerating(false);
            setRunId(genRunId);
            fetchArtifacts(genRunId);
          }
        } catch {
          /* keep polling */
        }
      }, 1500);
    } catch {
      setBevGenerating(false);
    }
  };

  useEffect(
    () => () => {
      if (pollRef.current) clearInterval(pollRef.current);
    },
    [],
  );

  /* ───── toggle BEV image selection for LLM ───── */
  const toggleBevSelection = (file: string) => {
    setSelectedBevFiles((prev) => {
      const next = new Set(prev);
      if (next.has(file)) next.delete(file);
      else next.add(file);
      return next;
    });
  };

  /* ───── pipeline run ───── */
  const handleRun = async () => {
    if (!runId) return;
    setRunning(true);
    setPipelineStep(1);
    setPipelineLogs("");
    setPipelineOk(null);
    try {
      const res = await fetch("/api/llm-artifacts/run", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          runId,
          dataset,
          model,
          apiKey: apiKey || undefined,
          dryRun: dryRun || !apiKey,
          selectedImages: Array.from(selectedBevFiles),
        }),
      });
      const json = await res.json();
      setPipelineLogs(json.logs || json.error || "");
      setPipelineOk(json.ok ?? false);
      setPipelineStep(json.ok ? 2 : 1);
      if (json.ok) fetchArtifacts(runId);
    } catch (e) {
      setPipelineLogs(String(e));
      setPipelineOk(false);
    } finally {
      setRunning(false);
    }
  };

  /* ───── medoid highlighting ───── */
  const medoidTrialIds = useMemo(() => {
    if (!bevGenStatus?.clusters) return [];
    return Object.values(bevGenStatus.clusters).map((c) => c.medoidTrialId);
  }, [bevGenStatus]);

  const handleHighlightMedoids = useCallback(() => {
    if (medoidTrialIds.length === 0) return;
    dispatch(
      batchSlice.actions.setSelectedTrialIds({
        by: "llm-medoids",
        value: medoidTrialIds,
      }),
    );
    dispatch(batchSlice.actions.setLlmMedoidTrialIds(medoidTrialIds));
  }, [dispatch, medoidTrialIds]);

  /* ───── derived ───── */
  const stageNames = useMemo(
    () => Object.keys(data?.stages ?? {}).sort(),
    [data],
  );

  const allInterpretations = useMemo(() => {
    const seen = new Set<string>();
    const list: ClusterInterpretation[] = [];
    for (const stage of stageNames) {
      for (const item of data?.stages?.[stage]?.interpretations ?? []) {
        if (seen.has(item.clusterId)) continue;
        seen.add(item.clusterId);
        list.push(item);
      }
    }
    return list.sort((a, b) => a.clusterId.localeCompare(b.clusterId));
  }, [data, stageNames]);

  useEffect(() => {
    if (allInterpretations.length === 0) return;
    const expl: Record<string, { label: string; description: string }> = {};
    for (const c of allInterpretations) {
      expl[c.clusterId] = {
        label: c.clusterLabel || `Cluster ${c.clusterId}`,
        description: c.behaviorDescription || "",
      };
    }
    dispatch(batchSlice.actions.setLlmBehaviorExplanations(expl));
    dispatch(batchSlice.actions.setShowBehaviorOverlay(true));
  }, [allInterpretations, dispatch]);

  /* ═════════════ render ═════════════ */
  return (
    <Stack
      spacing={2}
      sx={{ p: 2, height: "100%", overflow: "auto", bgcolor: bgPage, color: fgPage }}
    >
      {/* ─── Header ─── */}
      <Stack direction="row" alignItems="center" justifyContent="space-between">
        <Typography variant="h6" fontWeight={700}>
          LLM Cluster Interpretation
        </Typography>
        <Stack direction="row" spacing={0.5} alignItems="center">
          <ThemeToggleButton />
          <Tooltip title="Refresh artifacts">
            <IconButton size="small" onClick={() => fetchArtifacts()} sx={{ color: fgPage }}>
              <RefreshIcon fontSize="small" />
            </IconButton>
          </Tooltip>
        </Stack>
      </Stack>

      {/* ─── Active Clustering Info (auto-pinned from Clustering Selection) ─── */}
      <Paper
        elevation={0}
        sx={{ p: 2, bgcolor: bgCard, border: `1px solid ${borderColor}`, borderRadius: 2 }}
      >
        <Typography variant="subtitle2" gutterBottom fontWeight={600} color={fgPage}>
          Active Clustering
        </Typography>
        {activeClusteringResult ? (
          <Stack spacing={0.5}>
            <Typography variant="body2" color={fgPage}>
              <strong>{nClusters}</strong> clusters selected
              {activeClusteringResult.task?.method
                ? ` (${activeClusteringResult.task.method})`
                : ""}
              , <strong>{Object.keys(activeClusteringResult.data).length}</strong> trials
            </Typography>
            {activeClusteringResult.scores && (
              <Typography variant="caption" color="text.secondary">
                Silhouette:{" "}
                {(activeClusteringResult.scores.silhouetteScore ?? 0).toFixed(3)}
                {" | "}
                Calinski-Harabasz:{" "}
                {(activeClusteringResult.scores.calinskiHarabazScore ?? 0).toFixed(1)}
              </Typography>
            )}
          </Stack>
        ) : (
          <Alert severity="info" variant="outlined" sx={{ fontSize: 12, py: 0 }}>
            No clustering selected. Go to <strong>Clustering Selection</strong> panel,
            choose a clustering result (e.g. 4 clusters), then come back here.
          </Alert>
        )}
      </Paper>

      {/* ─── Configuration ─── */}
      <Paper
        elevation={0}
        sx={{ p: 2, bgcolor: bgCard, border: `1px solid ${borderColor}`, borderRadius: 2 }}
      >
        <Typography variant="subtitle2" gutterBottom fontWeight={600} color={fgPage}>
          Configuration
        </Typography>
        <Stack spacing={1.5}>
          <Stack direction="row" spacing={1}>
            <FormControl size="small" sx={{ flex: 1 }}>
              <InputLabel sx={{ color: fgPage }}>Dataset</InputLabel>
              <Select
                label="Dataset"
                value={dataset}
                onChange={(e) => setDataset(String(e.target.value))}
                sx={{ color: fgPage }}
              >
                {["dataset1", "dataset2", "dataset3"].map((d) => (
                  <MenuItem key={d} value={d}>
                    {d}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
            <FormControl size="small" sx={{ flex: 1 }}>
              <InputLabel sx={{ color: fgPage }}>Model</InputLabel>
              <Select
                label="Model"
                value={model}
                onChange={(e) => setModel(String(e.target.value))}
                sx={{ color: fgPage }}
              >
                {MODELS.map((m) => (
                  <MenuItem key={m} value={m}>
                    {m}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Stack>

          <TextField
            size="small"
            fullWidth
            label="OpenAI API Key"
            type={showKey ? "text" : "password"}
            value={apiKey}
            onChange={(e) => setApiKey(e.target.value)}
            placeholder="sk-... (leave empty for dry-run)"
            InputProps={{
              sx: { color: fgPage },
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton
                    size="small"
                    onClick={() => setShowKey(!showKey)}
                    sx={{ color: fgPage }}
                  >
                    {showKey ? (
                      <VisibilityOffIcon fontSize="small" />
                    ) : (
                      <VisibilityIcon fontSize="small" />
                    )}
                  </IconButton>
                </InputAdornment>
              ),
            }}
            InputLabelProps={{ sx: { color: isDark ? "#aaa" : undefined } }}
          />

          {!apiKey && (
            <Alert severity="info" variant="outlined" sx={{ fontSize: 12, py: 0 }}>
              No API key — will run in <strong>dry-run</strong> mode (stub YAML, no LLM
              cost).
            </Alert>
          )}
        </Stack>
      </Paper>

      {/* ─── BEV Generation ─── */}
      <Paper
        elevation={0}
        sx={{ p: 2, bgcolor: bgCard, border: `1px solid ${borderColor}`, borderRadius: 2 }}
      >
        <Stack
          direction="row"
          alignItems="center"
          justifyContent="space-between"
          sx={{ mb: 1 }}
        >
          <Typography variant="subtitle2" fontWeight={600} color={fgPage}>
            BEV Snapshots
          </Typography>
          <Button
            size="small"
            variant="contained"
            startIcon={
              bevGenerating ? (
                <CircularProgress size={16} color="inherit" />
              ) : (
                <ImageIcon />
              )
            }
            disabled={bevGenerating || !activeClusteringResult || nClusters === 0}
            onClick={handleGenerateBev}
          >
            {bevGenerating ? "Generating..." : "Generate BEV"}
          </Button>
        </Stack>

        {!activeClusteringResult && (
          <Alert severity="info" variant="outlined" sx={{ fontSize: 12 }}>
            Select a clustering result first to generate BEV images.
          </Alert>
        )}

        {activeClusteringResult && !bevGenerating && bevData.length === 0 && !bevGenStatus && (
          <Alert severity="info" variant="outlined" sx={{ fontSize: 12 }}>
            Click <strong>Generate BEV</strong> to create Bird&apos;s Eye View snapshots
            for each cluster medoid ({nClusters} clusters × 12 frames = {nClusters * 12}{" "}
            images).
          </Alert>
        )}

        {/* Progress bar during generation */}
        {bevGenStatus && bevGenStatus.state !== "done" && (
          <Stack spacing={1} sx={{ mt: 1 }}>
            <Stack direction="row" justifyContent="space-between" alignItems="center">
              <Typography variant="body2" color={fgPage}>
                {bevGenStatus.message}
              </Typography>
              <Typography variant="caption" color="text.secondary">
                {bevGenStatus.progress}/{bevGenStatus.total} images
              </Typography>
            </Stack>
            <LinearProgress
              variant="determinate"
              value={
                bevGenStatus.total > 0
                  ? (bevGenStatus.progress / bevGenStatus.total) * 100
                  : 0
              }
              sx={{ borderRadius: 1, height: 8 }}
            />
            {/* Live cluster results during generation */}
            {bevGenStatus.clusters &&
              Object.entries(bevGenStatus.clusters).map(([label, info]) => (
                <Typography key={label} variant="caption" color="text.secondary">
                  Cluster {label}: medoid trial {info.medoidTrialId} ({info.clusterSize}{" "}
                  members, {info.bevFiles?.length || 0} images)
                </Typography>
              ))}
          </Stack>
        )}

        {bevGenStatus?.state === "done" && (
          <Alert severity="success" variant="outlined" sx={{ fontSize: 12, mt: 1 }}>
            BEV generation complete!{" "}
            {bevGenStatus.clusters
              ? `${Object.keys(bevGenStatus.clusters).length} clusters rendered.`
              : ""}
          </Alert>
        )}

        {/* Image viewer when images exist */}
        {bevData.length > 0 && (
          <Stack spacing={1} sx={{ mt: 1 }}>
            <Stack direction="row" spacing={1} sx={{ flexWrap: "wrap" }}>
              <FormControl size="small" sx={{ minWidth: 130 }}>
                <InputLabel>Cluster</InputLabel>
                <Select
                  label="Cluster"
                  value={selectedCluster || bevData[0]?.clusterId || ""}
                  onChange={(e) => setSelectedCluster(String(e.target.value))}
                >
                  {bevData.map((c) => (
                    <MenuItem key={c.clusterId} value={c.clusterId}>
                      Cluster {c.clusterId} ({c.bevFiles.length} frames)
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
              <FormControl size="small" sx={{ minWidth: 200, flex: 1 }}>
                <InputLabel>Frame / snapshot</InputLabel>
                <Select
                  label="Frame / snapshot"
                  value={selectedBev || bevFiles[0] || ""}
                  onChange={(e) => setSelectedBev(String(e.target.value))}
                >
                  {bevFiles.map((f) => (
                    <MenuItem key={f} value={f}>
                      {f}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Stack>

            {(selectedBev || bevFiles[0]) && selectedCluster && (
              <Box
                component="img"
                src={`/api/llm-artifacts/bev?runId=${encodeURIComponent(runId)}&cluster=${encodeURIComponent(selectedCluster)}&file=${encodeURIComponent(selectedBev || bevFiles[0])}`}
                alt={`BEV cluster ${selectedCluster}`}
                sx={{
                  width: "100%",
                  maxHeight: 320,
                  objectFit: "contain",
                  borderRadius: 1,
                  border: 1,
                  borderColor: "divider",
                  bgcolor: "#000",
                }}
              />
            )}

            {/* Thumbnails with selection checkboxes */}
            <Typography variant="caption" color="text.secondary">
              Check images to include in LLM analysis:
            </Typography>
            <Stack direction="row" spacing={0.5} sx={{ overflowX: "auto", pb: 0.5 }}>
              {bevFiles.map((f) => {
                const fullKey = `${selectedCluster}/${f}`;
                const isSelected = selectedBevFiles.has(fullKey);
                return (
                  <Stack key={f} alignItems="center" sx={{ position: "relative" }}>
                    <Box
                      component="img"
                      src={`/api/llm-artifacts/bev?runId=${encodeURIComponent(runId)}&cluster=${encodeURIComponent(selectedCluster)}&file=${encodeURIComponent(f)}`}
                      onClick={() => setSelectedBev(f)}
                      title={f}
                      sx={{
                        width: 64,
                        height: 48,
                        flexShrink: 0,
                        objectFit: "cover",
                        borderRadius: 0.5,
                        cursor: "pointer",
                        border: 2,
                        borderColor:
                          f === (selectedBev || bevFiles[0])
                            ? "primary.main"
                            : isSelected
                              ? "success.main"
                              : "divider",
                        opacity: f === (selectedBev || bevFiles[0]) ? 1 : isSelected ? 0.9 : 0.6,
                        "&:hover": { opacity: 1 },
                      }}
                    />
                    <Checkbox
                      size="small"
                      checked={isSelected}
                      onChange={() => toggleBevSelection(fullKey)}
                      sx={{ p: 0, mt: -0.5 }}
                    />
                  </Stack>
                );
              })}
            </Stack>
            {selectedBevFiles.size > 0 && (
              <Typography variant="caption" color="success.main">
                {selectedBevFiles.size} image(s) selected for analysis
              </Typography>
            )}

            {/* Medoid highlighting button */}
            {medoidTrialIds.length > 0 && (
              <Button
                size="small"
                variant="outlined"
                onClick={handleHighlightMedoids}
                sx={{ alignSelf: "flex-start" }}
              >
                Highlight {medoidTrialIds.length} medoids in other panels
              </Button>
            )}
          </Stack>
        )}
      </Paper>

      {/* ─── Interpretation Pipeline ─── */}
      <Paper
        elevation={0}
        sx={{ p: 2, bgcolor: bgCard, border: `1px solid ${borderColor}`, borderRadius: 2 }}
      >
        <Stack
          direction="row"
          alignItems="center"
          justifyContent="space-between"
          sx={{ mb: 1 }}
        >
          <Typography variant="subtitle2" fontWeight={600} color={fgPage}>
            Interpretation Pipeline
          </Typography>
          <Button
            size="small"
            variant="contained"
            startIcon={
              running ? <CircularProgress size={16} color="inherit" /> : <PlayArrowIcon />
            }
            disabled={running || !runId || selectedBevFiles.size === 0}
            onClick={handleRun}
          >
            {running
              ? "Running..."
              : apiKey
                ? "Run Analysis"
                : "Dry Run"}
          </Button>
        </Stack>

        {selectedBevFiles.size === 0 && bevData.length > 0 && (
          <Alert severity="info" variant="outlined" sx={{ fontSize: 12, mb: 1 }}>
            Select BEV images above (checkboxes) to enable analysis.
          </Alert>
        )}

        <Stepper activeStep={pipelineStep} alternativeLabel sx={{ mb: 1 }}>
          {PIPELINE_STEPS.map((label, i) => (
            <Step key={label} completed={pipelineStep > i}>
              <StepLabel
                error={pipelineOk === false && pipelineStep === i}
                StepIconProps={{ sx: { color: fgPage } }}
              >
                <Typography variant="caption" sx={{ color: fgPage }}>
                  {label}
                </Typography>
              </StepLabel>
            </Step>
          ))}
        </Stepper>

        {pipelineOk !== null && (
          <Alert
            severity={pipelineOk ? "success" : "error"}
            icon={pipelineOk ? <CheckCircleIcon /> : <ErrorIcon />}
            sx={{ mb: 1, fontSize: 12 }}
          >
            {pipelineOk
              ? "Interpretation complete — results below."
              : "Pipeline failed — see logs."}
          </Alert>
        )}

        {pipelineLogs && (
          <Box
            component="pre"
            sx={{
              whiteSpace: "pre-wrap",
              wordBreak: "break-word",
              p: 1.5,
              background: bgPre,
              color: fgPre,
              border: `1px solid ${borderColor}`,
              borderRadius: 1,
              maxHeight: 200,
              overflow: "auto",
              fontSize: 11,
              fontFamily: "monospace",
            }}
          >
            {pipelineLogs}
          </Box>
        )}

        {/* Inline interpretation results */}
        {allInterpretations.length > 0 && (
          <Stack spacing={1.5} sx={{ mt: 2 }}>
            <Typography variant="subtitle2" fontWeight={600} color={fgPage}>
              Results ({allInterpretations.length} clusters)
            </Typography>
            {allInterpretations.map((c) => (
              <Box
                key={c.clusterId}
                sx={{
                  p: 1.5,
                  borderRadius: 1,
                  border: `1px solid ${borderColor}`,
                  bgcolor: isDark ? "#1a1a2e" : "#f0f4f8",
                }}
              >
                <Stack
                  direction="row"
                  spacing={1}
                  alignItems="center"
                  justifyContent="space-between"
                >
                  <Stack direction="row" spacing={1} alignItems="center">
                    <Typography variant="subtitle2" fontWeight={600} color={fgPage}>
                      {c.clusterLabel || `Cluster ${c.clusterId}`}
                    </Typography>
                    {c.confidence && (
                      <Chip
                        size="small"
                        label={c.confidence}
                        color={confidenceColor(c.confidence) as any}
                        variant="outlined"
                      />
                    )}
                  </Stack>
                  <Tooltip title="Show/hide raw YAML">
                    <IconButton
                      size="small"
                      onClick={() =>
                        setExpandedYaml(expandedYaml === c.clusterId ? null : c.clusterId)
                      }
                      sx={{ color: fgPage }}
                    >
                      {expandedYaml === c.clusterId ? (
                        <ExpandLessIcon fontSize="small" />
                      ) : (
                        <ExpandMoreIcon fontSize="small" />
                      )}
                    </IconButton>
                  </Tooltip>
                </Stack>
                <Typography variant="body2" sx={{ mt: 0.5, color: fgPage }}>
                  {c.behaviorDescription || "(no description)"}
                </Typography>
                <Collapse in={expandedYaml === c.clusterId}>
                  <Box
                    component="pre"
                    sx={{
                      mt: 1,
                      p: 1,
                      background: bgPre,
                      color: fgPre,
                      border: `1px solid ${borderColor}`,
                      borderRadius: 1,
                      maxHeight: 300,
                      overflow: "auto",
                      fontSize: 11,
                      fontFamily: "monospace",
                    }}
                  >
                    {c.rawYaml || "(raw YAML not available from API)"}
                  </Box>
                </Collapse>
              </Box>
            ))}
          </Stack>
        )}
      </Paper>

      {/* ─── Existing run selector (collapsed) ─── */}
      <Box>
        <Button
          size="small"
          onClick={() => setShowStages(!showStages)}
          endIcon={showStages ? <ExpandLessIcon /> : <ExpandMoreIcon />}
          sx={{ textTransform: "none", color: fgPage }}
        >
          {showStages ? "Hide" : "Show"} previous runs & raw stages
        </Button>
        <Collapse in={showStages}>
          <Stack spacing={1} sx={{ mt: 1 }}>
            <FormControl size="small" fullWidth>
              <InputLabel>Browse run</InputLabel>
              <Select
                label="Browse run"
                value={runId}
                onChange={(e) => {
                  setRunId(String(e.target.value));
                  fetchArtifacts(String(e.target.value));
                }}
              >
                {(data?.runs ?? []).map((r) => (
                  <MenuItem key={r} value={r}>
                    {r}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
            {stageNames.map((stage) => {
              const view = data?.stages?.[stage];
              if (!view) return null;
              return (
                <Box
                  key={stage}
                  sx={{
                    border: `1px solid ${borderColor}`,
                    borderRadius: 1,
                    p: 1.5,
                    bgcolor: bgCard,
                  }}
                >
                  <Typography variant="subtitle2" color={fgPage}>
                    {stage}
                  </Typography>
                  <Typography variant="caption" sx={{ color: isDark ? "#aaa" : "#666" }}>
                    Files: {view.files.join(", ") || "none"}
                  </Typography>
                  <Box
                    component="pre"
                    sx={{
                      whiteSpace: "pre-wrap",
                      wordBreak: "break-word",
                      p: 1,
                      mt: 1,
                      background: bgPre,
                      color: fgPre,
                      border: `1px solid ${borderColor}`,
                      borderRadius: 1,
                      maxHeight: 200,
                      overflow: "auto",
                      fontSize: 11,
                      fontFamily: "monospace",
                    }}
                  >
                    {view.preview || "(no preview)"}
                  </Box>
                </Box>
              );
            })}
          </Stack>
        </Collapse>
      </Box>

      {loading && (
        <Box sx={{ textAlign: "center", py: 2 }}>
          <CircularProgress size={24} />
        </Box>
      )}
    </Stack>
  );
}
