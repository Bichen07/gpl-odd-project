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
              This judges the clustering you have open: do the clusters describe
              different driving behaviors, and do the boundaries hold when two
              trials start from nearly the same scenario inputs? It does not
              re-cluster the data.
            </Typography>
            <Typography variant="body2" sx={{ mt: 1 }}>
              The number on this tab is the composite: 60% geometry and 40%
              language-model ratings. Silhouette is one piece of geometry.
              Behavior is shown beside the composite and is not inside it.
            </Typography>
          </>
        }
      />
      <Typography variant="body2" color="text.secondary">
        Whole-partition verdict for the clustering you have open. It uses the
        medoid cards, the matched-parameter pairs, and the behavior checks.
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
