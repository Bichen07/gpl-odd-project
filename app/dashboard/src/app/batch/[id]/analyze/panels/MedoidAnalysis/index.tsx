"use client";

import {
  Button,
  Chip,
  CircularProgress,
  Paper,
  Stack,
  Typography,
} from "@mui/material";
import type { Dispatch, SetStateAction } from "react";
import type { AnalyzeProduct, ProductRunState } from "../../constants";
import { PROMPT_KEYS } from "../../constants";
import type { ClusterEntry, ResultEntry, SplitAnalysis } from "../../types";
import AnalyzeRunConsole from "../../components/AnalyzeRunConsole";
import MedoidPanel from "../../components/MedoidPanel";
import PromptsCard from "../../components/PromptsCard";

export type MedoidAnalysisProps = {
  config: { folder: string; clusters: ClusterEntry[] };
  prompts: Record<string, string>;
  setPrompts: Dispatch<SetStateAction<Record<string, string>>>;
  selected: Record<number, string[]>;
  setSelected: Dispatch<SetStateAction<Record<number, string[]>>>;
  runClusters: Set<number>;
  setRunClusters: Dispatch<SetStateAction<Set<number>>>;
  /** Per-cluster BEV limit (0 = all). Survives switching the viewed medoid. */
  perClusterMax: Record<number, number>;
  setPerClusterMax: Dispatch<SetStateAction<Record<number, number>>>;
  applyAuto: (
    cluster: number,
    snapshots: string[],
    medoid?: Record<string, unknown> | null,
  ) => void;
  toggleImage: (cluster: number, file: string) => void;
  imgUrl: (cluster: number, file: string) => string;
  analyzedClusters: Set<number>;
  running: boolean;
  runningProduct: AnalyzeProduct | null;
  productRuns: Record<AnalyzeProduct, ProductRunState>;
  run: (subset: number[] | undefined, productsSpec: string, pairFolders?: string[]) => void;
  stopAnalyze: () => void;
  apiKey: string;
  dryRun: boolean;
  results: ResultEntry[];
  downloadYaml: (cluster: number, raw: string) => void;
  splitAnalysis: SplitAnalysis | null;
};

export default function MedoidAnalysis({
  config,
  prompts,
  setPrompts,
  selected,
  setSelected,
  runClusters,
  setRunClusters,
  perClusterMax,
  setPerClusterMax,
  applyAuto,
  toggleImage,
  imgUrl,
  analyzedClusters,
  running,
  runningProduct,
  productRuns,
  run,
  stopAnalyze,
  apiKey,
  dryRun,
  results,
  downloadYaml,
  splitAnalysis,
}: MedoidAnalysisProps) {
  return (
    <Stack direction={{ xs: "column", md: "row" }} spacing={2} alignItems="flex-start">
      <Stack spacing={2} sx={{ flex: 1, minWidth: 0, width: "100%" }}>
        <PromptsCard
          keys={PROMPT_KEYS.medoid}
          prompts={prompts}
          setPrompts={setPrompts}
          productLabel="medoid"
        />
      </Stack>

      <Stack spacing={2} sx={{ flex: 1.3, minWidth: 0, width: "100%" }}>
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="subtitle2" gutterBottom>
            Select clusters to run
          </Typography>
          <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1.5 }}>
            {config.clusters.map((c) => {
              const ready = (c.snapshots?.length ?? 0) > 0;
              const checked = runClusters.has(c.cluster);
              const hasCard =
                analyzedClusters.has(c.cluster) ||
                Boolean(
                  splitAnalysis?.clusters?.find((sc) => sc.cluster === c.cluster)
                    ?.medoidYaml,
                );
              return (
                <Chip
                  key={c.cluster}
                  label={`c${c.cluster}${hasCard ? " ✓" : ""}${ready ? "" : " ⚠"}`}
                  color={checked ? "primary" : "default"}
                  variant={ready ? (checked ? "filled" : "outlined") : "outlined"}
                  disabled={!ready}
                  onClick={() => {
                    if (!ready) return;
                    setRunClusters((prev) => {
                      const next = new Set(prev);
                      if (next.has(c.cluster)) next.delete(c.cluster);
                      else next.add(c.cluster);
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
                setRunClusters(
                  new Set(
                    config.clusters
                      .filter((c) => (c.snapshots?.length ?? 0) > 0)
                      .map((c) => c.cluster),
                  ),
                )
              }
            >
              Select all ready
            </Button>
            <Button size="small" onClick={() => setRunClusters(new Set())}>
              Clear
            </Button>
          </Stack>

          <Stack direction="row" alignItems="center" spacing={2} flexWrap="wrap">
            <Button
              variant="contained"
              disabled={running || runClusters.size === 0}
              onClick={() => run([...runClusters].sort((a, b) => a - b), "medoid")}
              startIcon={
                runningProduct === "medoid" ? (
                  <CircularProgress size={16} color="inherit" />
                ) : undefined
              }
            >
              {runningProduct === "medoid"
                ? "Analyzing…"
                : `Run medoid cards (${runClusters.size})`}
            </Button>
            {runningProduct === "medoid" && (
              <Button variant="outlined" color="error" onClick={stopAnalyze}>
                Stop
              </Button>
            )}
            <Typography variant="caption" color="text.secondary">
              Writes <code>clusterN/output/medoid_trial.yaml</code>. Browse one cluster at a
              time below (process BEV + context + result).
            </Typography>
          </Stack>
          {!apiKey && !dryRun && (
            <Typography variant="caption" color="warning.main" display="block" sx={{ mt: 1 }}>
              Enter the API key in Model setup first.
            </Typography>
          )}
          <AnalyzeRunConsole
            title="Medoid analysis"
            running={runningProduct === "medoid"}
            logs={productRuns.medoid.logs}
            logFile={productRuns.medoid.logFile}
            error={productRuns.medoid.error}
            completed={productRuns.medoid.completed}
            total={productRuns.medoid.total}
            onStop={stopAnalyze}
          />
        </Paper>

        <MedoidPanel
          clusters={config.clusters}
          selected={selected}
          setSelected={setSelected}
          perClusterMax={perClusterMax}
          setPerClusterMax={setPerClusterMax}
          applyAuto={applyAuto}
          toggleImage={toggleImage}
          imgUrl={imgUrl}
          analyzedClusters={analyzedClusters}
          results={results}
          downloadYaml={downloadYaml}
          splitClusters={splitAnalysis?.clusters ?? []}
        />
      </Stack>
    </Stack>
  );
}
