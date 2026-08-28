"use client";

import {
  Alert,
  Box,
  Button,
  Checkbox,
  Chip,
  CircularProgress,
  Divider,
  FormControlLabel,
  Paper,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Typography,
} from "@mui/material";
import type { Dispatch, SetStateAction } from "react";
import type { AnalyzeProduct, ProductRunState } from "../../constants";
import { PROMPT_KEYS } from "../../constants";
import type {
  ClusteringQuality,
  Config,
  SplitAnalysis,
} from "../../types";
import AnalyzeRunConsole from "../../components/AnalyzeRunConsole";
import BoundaryComparePanel from "../../components/BoundaryComparePanel";
import PromptsCard from "../../components/PromptsCard";
import SelectionQualityPanel from "../../components/SelectionQualityPanel";
import SplitCardsPanel from "../../components/SplitCardsPanel";

export type ClusterAnalysisProps = {
  config: Config;
  batchId: string;
  splitAnalysis: SplitAnalysis | null;
  prompts: Record<string, string>;
  setPrompts: Dispatch<SetStateAction<Record<string, string>>>;
  summaryRunClusters: Set<number>;
  setSummaryRunClusters: Dispatch<SetStateAction<Set<number>>>;
  toggleSummaryRunCluster: (cluster: number) => void;
  running: boolean;
  runningProduct: AnalyzeProduct | null;
  productRuns: Record<AnalyzeProduct, ProductRunState>;
  run: (subset: number[] | undefined, productsSpec: string, pairFolders?: string[]) => void;
  stopAnalyze: () => void;
  apiKey: string;
  dryRun: boolean;
  splitSubTab: number;
  setSplitSubTab: (v: number) => void;
  nClustersNoMedoid: number;
  nIcPairsUnbuilt: number;
  splitClustersForPrereq: { cluster: number; medoidYaml?: string; readyForSummary?: boolean; missingIcContrasts?: string[] }[];
  icPairsForPrereq: unknown[];
  clustersMissingIcContrasts: { cluster: number }[];
  summaryBlocked: boolean;
  evalRunning: boolean;
  evalError: string | null;
  evalLogs: string;
  evalLogFile: string;
  evalCompleted: number;
  evalTotal: number;
  runCrossClusterEval: () => void;
  stopCrossClusterEval: () => void;
  evalConfigs: ClusteringQuality[];
  currentCrossEval: ClusteringQuality["cross_cluster_eval"];
  currentBoundaryPairs: NonNullable<ClusteringQuality["trajectory_projection_pairs"]>;
};

export default function ClusterAnalysis({
  config,
  batchId,
  splitAnalysis,
  prompts,
  setPrompts,
  summaryRunClusters,
  setSummaryRunClusters,
  toggleSummaryRunCluster,
  running,
  runningProduct,
  productRuns,
  run,
  stopAnalyze,
  apiKey,
  dryRun,
  splitSubTab,
  setSplitSubTab,
  nClustersNoMedoid,
  nIcPairsUnbuilt,
  splitClustersForPrereq,
  icPairsForPrereq,
  clustersMissingIcContrasts,
  summaryBlocked,
  evalRunning,
  evalError,
  evalLogs,
  evalLogFile,
  evalCompleted,
  evalTotal,
  runCrossClusterEval,
  stopCrossClusterEval,
  evalConfigs,
  currentCrossEval,
  currentBoundaryPairs,
}: ClusterAnalysisProps) {
  return (
<Stack spacing={4}>
  {/* ---------- Section A: per-cluster summaries ---------- */}
  <Box>
    <Typography variant="h4" sx={{ mb: 0.5, fontWeight: 700 }}>
      Cluster analysis
    </Typography>
    <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
      Per-cluster behavior summary (<code>cluster_summary.yaml</code>) from each
      cluster&apos;s medoid + touching Parameter-space pair contrasts. Pick which
      clusters to run — you do not need to analyze all at once.
    </Typography>

    {(nClustersNoMedoid > 0 || nIcPairsUnbuilt > 0) && (
      <Alert severity="warning" sx={{ mb: 2 }}>
        {nClustersNoMedoid > 0 && (
          <Typography variant="body2">
            {nClustersNoMedoid} of {splitClustersForPrereq.length} clusters have no medoid
            card yet — run Medoid analysis first.
          </Typography>
        )}
        {nIcPairsUnbuilt > 0 && (
          <Typography variant="body2">
            {nIcPairsUnbuilt} of {icPairsForPrereq.length} Parameter-space pairs have no
            contrast card yet — run Parameter-space pair analysis before cluster summary
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

    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="subtitle1" fontWeight={600} gutterBottom>
        Clusters to summarize
      </Typography>
      <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1.5 }}>
        {(splitAnalysis?.clusters ?? config.clusters).map((c) => {
          const ready =
            "readyForSummary" in c
              ? Boolean((c as { readyForSummary?: boolean }).readyForSummary)
              : true;
          const hasSummary = Boolean(
            (c as { summaryYaml?: string }).summaryYaml,
          );
          return (
            <FormControlLabel
              key={c.cluster}
              control={
                <Checkbox
                  size="small"
                  checked={summaryRunClusters.has(c.cluster)}
                  disabled={!ready}
                  onChange={() => toggleSummaryRunCluster(c.cluster)}
                />
              }
              label={
                <Stack direction="row" spacing={0.5} alignItems="center">
                  <Typography variant="body2" fontWeight={600}>
                    c{c.cluster}
                  </Typography>
                  {hasSummary && (
                    <Chip size="small" color="success" variant="outlined" label="saved" />
                  )}
                  {!ready && (
                    <Chip size="small" color="warning" variant="outlined" label="blocked" />
                  )}
                </Stack>
              }
            />
          );
        })}
      </Stack>
      <Stack direction="row" spacing={1} sx={{ mb: 1.5 }}>
        <Button
          size="small"
          onClick={() => {
            const ready = (splitAnalysis?.clusters ?? [])
              .filter((c) => c.readyForSummary)
              .map((c) => c.cluster);
            setSummaryRunClusters(new Set(ready));
          }}
        >
          Select ready
        </Button>
        <Button size="small" onClick={() => setSummaryRunClusters(new Set())}>
          Clear
        </Button>
      </Stack>

      <Stack direction="row" alignItems="center" spacing={2} flexWrap="wrap">
        <Button
          variant="contained"
          disabled={
            running ||
            summaryRunClusters.size === 0 ||
            ![...summaryRunClusters].some((id) =>
              (splitAnalysis?.clusters ?? []).some(
                (c) => c.cluster === id && c.readyForSummary,
              ),
            )
          }
          onClick={() => {
            const chosen = [...summaryRunClusters]
              .filter((id) =>
                (splitAnalysis?.clusters ?? []).some(
                  (c) => c.cluster === id && c.readyForSummary,
                ),
              )
              .sort((a, b) => a - b);
            if (chosen.length) run(chosen, "summary");
          }}
          startIcon={
            runningProduct === "summary" ? (
              <CircularProgress size={16} color="inherit" />
            ) : undefined
          }
        >
          {runningProduct === "summary"
            ? "Analyzing…"
            : `Run cluster summaries (${
                [...summaryRunClusters].filter((id) =>
                  (splitAnalysis?.clusters ?? []).some(
                    (c) => c.cluster === id && c.readyForSummary,
                  ),
                ).length
              })`}
        </Button>
        {runningProduct === "summary" && (
          <Button variant="outlined" color="error" onClick={stopAnalyze}>
            Stop
          </Button>
        )}
        <Typography variant="caption" color="text.secondary">
          Runs <code>--products summary --clusters …</code>. Requires medoid +{" "}
          <code>output/contrast.yaml</code> for every touching Parameter-space pair.
        </Typography>
      </Stack>
      {summaryBlocked && (
        <Alert severity="error" sx={{ mt: 1 }}>
          Cluster summary is blocked until medoid + Parameter-space pair contrasts are
          built for the selected clusters.
        </Alert>
      )}
      {!apiKey && !dryRun && (
        <Typography variant="caption" color="warning.main" display="block" sx={{ mt: 1 }}>
          Enter the API key in Model setup first.
        </Typography>
      )}
      <AnalyzeRunConsole
        title="Cluster summary analysis"
        running={runningProduct === "summary"}
        logs={productRuns.summary.logs}
        logFile={productRuns.summary.logFile}
        error={productRuns.summary.error}
        completed={productRuns.summary.completed}
        total={productRuns.summary.total}
        onStop={stopAnalyze}
      />
    </Paper>

    <Box sx={{ mt: 2 }}>
      <PromptsCard
        keys={PROMPT_KEYS.summary}
        prompts={prompts}
        setPrompts={setPrompts}
        productLabel="summary"
      />
    </Box>

    <Box sx={{ mt: 2 }}>
      <SplitCardsPanel
        split={splitAnalysis}
        folder={config.folder}
        batchId={batchId}
        subTab={splitSubTab}
        onSubTab={setSplitSubTab}
        mode="summary"
      />
    </Box>
  </Box>

  <Divider />

  {/* ---------- Section B: whole-partition cross-cluster ---------- */}
  <Box>
    <Typography variant="h4" sx={{ mb: 0.5, fontWeight: 700 }}>
      Cross-cluster analysis
    </Typography>
    <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
      Whole-partition verdict (<code>cross_cluster_eval.json</code>): are clusters
      behaviorally distinct? Uses all medoid + Parameter-space pair cards and
      deterministic selection checks.
    </Typography>

    <Paper variant="outlined" sx={{ p: 2, mb: 2 }}>
      <Stack direction="row" alignItems="center" spacing={2} flexWrap="wrap">
        <Button
          variant="contained"
          disabled={evalRunning}
          onClick={runCrossClusterEval}
          startIcon={
            evalRunning ? <CircularProgress size={16} color="inherit" /> : undefined
          }
        >
          {evalRunning ? "Running LLM eval…" : "Run Cross-Cluster Eval (LLM)"}
        </Button>
        {evalRunning && (
          <Button variant="outlined" color="error" onClick={stopCrossClusterEval}>
            Stop
          </Button>
        )}
        <Typography variant="caption" color="text.secondary">
          Requires a valid API key (Model setup). Updates the composite score with the LLM
          behavioral layer.
        </Typography>
      </Stack>
      <AnalyzeRunConsole
        title="Cross-cluster eval"
        running={evalRunning}
        logs={evalLogs}
        logFile={evalLogFile}
        error={evalError}
        completed={evalCompleted}
        total={evalTotal}
        onStop={stopCrossClusterEval}
      />
    </Paper>

    {evalConfigs.length > 0 && (
      <Paper variant="outlined" sx={{ p: 2, mb: 2 }}>
        <Typography variant="h6" gutterBottom>
          All Clustering Configurations (ranked)
        </Typography>
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
                sx={{
                  bgcolor: c.folder === config.folder ? "action.selected" : undefined,
                }}
              >
                <TableCell>
                  <strong>#{c.rank ?? "—"}</strong>
                </TableCell>
                <TableCell sx={{ fontFamily: "monospace", fontSize: 12 }}>
                  {c.folder}
                </TableCell>
                <TableCell align="right">{c.k ?? "—"}</TableCell>
                <TableCell align="right">
                  {c.silhouette?.toFixed(4) ?? "—"}
                </TableCell>
                <TableCell align="right">{c.rule_score?.toFixed(1)}</TableCell>
                <TableCell align="right">
                  {c.llm_score != null ? c.llm_score.toFixed(1) : "—"}
                </TableCell>
                <TableCell align="right">
                  <strong>{c.final_score?.toFixed(1)}</strong>
                </TableCell>
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

    {config.clusters.length > 0 && (
      <Paper variant="outlined" sx={{ p: 2, mb: 2 }}>
        <Typography variant="h6" gutterBottom>
          Per-Cluster Intra Variance
        </Typography>
        <Stack spacing={1}>
          {config.clusters.map((cl) => {
            const iv = cl.intraVariance as Record<string, unknown> | null;
            if (!iv) return null;
            const outlierIds = (iv.outlier_trial_ids as string[] | undefined) ?? [];
            const outlierColl = (iv.outlier_collision as boolean[] | undefined) ?? [];
            const splitCard = splitAnalysis?.clusters?.find((c) => c.cluster === cl.cluster);
            const summaryLabel = (
              (splitCard?.summaryMeta as { parsed?: { label?: unknown } } | null | undefined)
                ?.parsed?.label
            );
            const intraScore =
              (iv.intra_consistency_score as number | undefined) ??
              (
                (splitCard?.summaryMeta as Record<string, unknown> | null | undefined)
                  ?.intra_consistency_score as number | undefined
              );
            return (
              <Paper key={cl.cluster} variant="outlined" sx={{ p: 1.5 }}>
                <Stack direction="row" alignItems="center" spacing={1} flexWrap="wrap">
                  <Typography fontWeight="bold">Cluster {cl.cluster}</Typography>
                  {summaryLabel != null && String(summaryLabel) !== "" && (
                    <Chip size="small" label={String(summaryLabel)} />
                  )}
                  {intraScore != null && (
                    <Chip
                      size="small"
                      color={
                        Number(intraScore) >= 7
                          ? "success"
                          : Number(intraScore) >= 5
                            ? "warning"
                            : "error"
                      }
                      label={`consistency ${intraScore}/10`}
                    />
                  )}
                </Stack>
                <Stack direction="row" spacing={2} sx={{ mt: 0.5 }} flexWrap="wrap">
                  <Typography variant="caption">
                    mean dist: {String(iv.mean_dist_to_medoid ?? "—")}
                  </Typography>
                  <Typography variant="caption">
                    std: {String(iv.std_dist_to_medoid ?? "—")}
                  </Typography>
                  <Typography variant="caption">
                    max: {String(iv.max_dist_to_medoid ?? "—")}
                  </Typography>
                  <Typography variant="caption">
                    n_members: {String(iv.n_members ?? "—")}
                  </Typography>
                </Stack>
                {outlierIds.length > 0 && (
                  <Typography variant="caption" sx={{ mt: 0.5, display: "block" }}>
                    Outliers:{" "}
                    {outlierIds.map((tid, i) => (
                      <span key={tid}>
                        {tid}
                        {outlierColl[i] ? " (COLLISION)" : ""}
                        {i < outlierIds.length - 1 ? ", " : ""}
                      </span>
                    ))}
                  </Typography>
                )}
              </Paper>
            );
          })}
        </Stack>
      </Paper>
    )}

    {currentCrossEval && (
      <Paper variant="outlined" sx={{ p: 2, mb: 2 }}>
        <Typography variant="h6" gutterBottom>
          Inter-Cluster Analysis (LLM)
        </Typography>
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
            <Typography variant="body2" fontWeight="bold">
              Merge candidates:
            </Typography>
            {currentCrossEval.merge_candidates!.map((m, i) => (
              <Typography key={i} variant="caption" display="block">
                {m}
              </Typography>
            ))}
          </Alert>
        )}
        {(currentCrossEval.split_candidates?.length ?? 0) > 0 && (
          <Alert severity="info">
            <Typography variant="body2" fontWeight="bold">
              Split candidates:
            </Typography>
            {currentCrossEval.split_candidates!.map((m, i) => (
              <Typography key={i} variant="caption" display="block">
                {m}
              </Typography>
            ))}
          </Alert>
        )}
      </Paper>
    )}

    {currentBoundaryPairs.length > 0 && (
      <BoundaryComparePanel
        batchId={batchId}
        folder={config.folder}
        boundaryPairs={currentBoundaryPairs}
        crossEval={currentCrossEval}
      />
    )}

    <SelectionQualityPanel
      selectionEval={splitAnalysis?.selectionEval ?? null}
      crossEval={splitAnalysis?.crossEval ?? null}
      quality={splitAnalysis?.quality ?? null}
    />
  </Box>
</Stack>
  );
}
