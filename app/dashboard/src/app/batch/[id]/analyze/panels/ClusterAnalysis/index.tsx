"use client";

import {
  Alert,
  Button,
  Checkbox,
  Chip,
  CircularProgress,
  FormControlLabel,
  Paper,
  Stack,
  Typography,
} from "@mui/material";
import type { Dispatch, SetStateAction } from "react";
import type { AnalyzeProduct, ProductRunState } from "../../constants";
import { PROMPT_KEYS } from "../../constants";
import type { Config, SplitAnalysis } from "../../types";
import AnalyzeRunConsole from "../../components/AnalyzeRunConsole";
import PromptsCard from "../../components/PromptsCard";
import SplitCardsPanel from "../../components/SplitCardsPanel";
import TitleWithHelp from "../../components/TitleWithHelp";

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
  splitClustersForPrereq: {
    cluster: number;
    medoidYaml?: string;
    readyForSummary?: boolean;
    missingIcContrasts?: string[];
  }[];
  icPairsForPrereq: unknown[];
  clustersMissingIcContrasts: { cluster: number }[];
  summaryBlocked: boolean;
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
}: ClusterAnalysisProps) {
  return (
    <Stack spacing={2}>
      <TitleWithHelp
        title="Cluster analysis"
        variant="h4"
        help={
          <>
            <Typography variant="body2">
              This page creates a local summary for selected clusters. The summary LLM reads
              each cluster&apos;s medoid card, cluster context, and every touching
              Parameter-space pair contrast.
            </Typography>
            <Typography variant="body2" sx={{ mt: 1 }}>
              Select only clusters that are ready, then run <code>summary</code>. The output is
              saved as <code>clusterN/output/cluster_summary.yaml</code>; this is a per-cluster
              explanation, not a judgment of the whole partition. Use the Cross-cluster analysis
              tab for the partition-level verdict.
            </Typography>
          </>
        }
      />
      <Typography variant="body2" color="text.secondary">
        Per-cluster behavior summary (<code>cluster_summary.yaml</code>) from each
        cluster&apos;s medoid + touching Parameter-space pair contrasts. Pick which
        clusters to run — you do not need to analyze all at once.
      </Typography>

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
            const hasSummary = Boolean((c as { summaryYaml?: string }).summaryYaml);
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

      <PromptsCard
        keys={PROMPT_KEYS.summary}
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
  );
}
