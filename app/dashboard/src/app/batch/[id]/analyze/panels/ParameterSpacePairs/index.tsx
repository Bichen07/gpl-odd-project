"use client";

import {
  Alert,
  Button,
  Chip,
  CircularProgress,
  Paper,
  Stack,
  Typography,
} from "@mui/material";
import type { Dispatch, SetStateAction } from "react";
import type { ProductRunState, AnalyzeProduct } from "../../constants";
import { PROMPT_KEYS } from "../../constants";
import type { SplitAnalysis } from "../../types";
import AnalyzeRunConsole from "../../components/AnalyzeRunConsole";
import IcPairPanel from "../../components/IcPairPanel";
import PromptsCard from "../../components/PromptsCard";

export type ParameterSpacePairsProps = {
  prompts: Record<string, string>;
  setPrompts: Dispatch<SetStateAction<Record<string, string>>>;
  splitAnalysis: SplitAnalysis | null;
  selectedPairs: Set<string>;
  setSelectedPairs: Dispatch<SetStateAction<Set<string>>>;
  running: boolean;
  runningProduct: AnalyzeProduct | null;
  productRuns: Record<AnalyzeProduct, ProductRunState>;
  run: (subset: number[] | undefined, productsSpec: string, pairFolders?: string[]) => void;
  stopAnalyze: () => void;
  folder: string;
  batchId: string;
  apiKey: string;
  dryRun: boolean;
};

export default function ParameterSpacePairs({
  prompts,
  setPrompts,
  splitAnalysis,
  selectedPairs,
  setSelectedPairs,
  running,
  runningProduct,
  productRuns,
  run,
  stopAnalyze,
  folder,
  batchId,
  apiKey,
  dryRun,
}: ParameterSpacePairsProps) {
  return (
<Stack direction={{ xs: "column", md: "row" }} spacing={2} alignItems="flex-start">
  <Stack spacing={2} sx={{ flex: 1, minWidth: 0, width: "100%" }}>
    <PromptsCard
      keys={PROMPT_KEYS["parameter-space-pairs"]}
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
            run(undefined, "parameter-space-pairs", [...selectedPairs])
          }
          startIcon={
            runningProduct === "parameter-space-pairs" ? (
              <CircularProgress size={16} color="inherit" />
            ) : undefined
          }
        >
          {runningProduct === "parameter-space-pairs"
            ? "Analyzing…"
            : `Run Parameter-space pair contrast (${selectedPairs.size})`}
        </Button>
        {runningProduct === "parameter-space-pairs" && (
          <Button variant="outlined" color="error" onClick={stopAnalyze}>
            Stop
          </Button>
        )}
        <Typography variant="caption" color="text.secondary">
          Requires medoid cards for both clusters. Writes{" "}
          <code>parameter_space_pairs/cA-cB/output/contrast.yaml</code>.
        </Typography>
      </Stack>
      {!apiKey && !dryRun && (
        <Typography variant="caption" color="warning.main" display="block" sx={{ mt: 1 }}>
          Enter the API key in Model setup first.
        </Typography>
      )}
      <AnalyzeRunConsole
        title="Parameter-space pair analysis"
        running={runningProduct === "parameter-space-pairs"}
        logs={productRuns["parameter-space-pairs"].logs}
        logFile={productRuns["parameter-space-pairs"].logFile}
        error={productRuns["parameter-space-pairs"].error}
        completed={productRuns["parameter-space-pairs"].completed}
        total={productRuns["parameter-space-pairs"].total}
        onStop={stopAnalyze}
      />
    </Paper>
    <IcPairPanel
      pairs={splitAnalysis?.icPairs ?? []}
      folder={folder}
      batchId={batchId}
      splitClusters={splitAnalysis?.clusters ?? []}
    />
  </Stack>
</Stack>
  );
}
