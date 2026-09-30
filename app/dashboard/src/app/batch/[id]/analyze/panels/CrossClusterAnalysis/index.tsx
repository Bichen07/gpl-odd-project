"use client";

import {
  Button,
  CircularProgress,
  Paper,
  Stack,
  Typography,
} from "@mui/material";
import type { ClusteringQuality, Config, SplitAnalysis } from "../../types";
import AnalyzeRunConsole from "../../components/AnalyzeRunConsole";
import SelectionQualityPanel from "../../components/SelectionQualityPanel";
import TitleWithHelp from "../../components/TitleWithHelp";

export type CrossClusterAnalysisProps = {
  config: Config;
  splitAnalysis: SplitAnalysis | null;
  evalRunning: boolean;
  evalError: string | null;
  evalLogs: string;
  evalLogFile: string;
  evalCompleted: number;
  evalTotal: number;
  runCrossClusterEval: () => void;
  stopCrossClusterEval: () => void;
  evalConfigs: ClusteringQuality[];
};

export default function CrossClusterAnalysis({
  config,
  splitAnalysis,
  evalRunning,
  evalError,
  evalLogs,
  evalLogFile,
  evalCompleted,
  evalTotal,
  runCrossClusterEval,
  stopCrossClusterEval,
  evalConfigs,
}: CrossClusterAnalysisProps) {
  return (
    <Stack spacing={2}>
      <TitleWithHelp
        title="Cross-cluster analysis"
        variant="h4"
        help={
          <>
            <Typography variant="body2">
              This explains the clustering you have open. The clusters come from
              MFPCA and HDBSCAN on the whole trajectory, so they already differ
              in trajectory shape. The reading names what behavior they share
              and what collision, clearance, or timing difference still separates
              them. It does not re-cluster the data.
            </Typography>
            <Typography variant="body2" sx={{ mt: 1 }}>
              The number on this tab is the geometry score. Silhouette is one
              piece of that score. The language-model reading sits beside it.
            </Typography>
          </>
        }
      />
      <Typography variant="body2" color="text.secondary">
        Whole-partition reading for the clustering you have open. It uses the
        medoid cards and the matched-parameter pairs to name differences.
      </Typography>

      <Paper variant="outlined" sx={{ p: 2 }}>
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
            Requires a valid API key (Model setup). Rewrites the difference reading.
            It does not change the geometry score.
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

      <SelectionQualityPanel
        selectionEval={splitAnalysis?.selectionEval ?? null}
        crossEval={splitAnalysis?.crossEval ?? null}
        quality={splitAnalysis?.quality ?? null}
        evalConfigs={evalConfigs}
        currentFolder={config.folder}
      />
    </Stack>
  );
}
