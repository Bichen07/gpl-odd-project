"use client";

import {
  Alert,
  Button,
  Chip,
  CircularProgress,
  Paper,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Typography,
} from "@mui/material";
import type { ClusteringQuality, Config, SplitAnalysis } from "../../types";
import AnalyzeRunConsole from "../../components/AnalyzeRunConsole";
import BoundaryComparePanel from "../../components/BoundaryComparePanel";
import SelectionQualityPanel from "../../components/SelectionQualityPanel";
import TitleWithHelp from "../../components/TitleWithHelp";

export type CrossClusterAnalysisProps = {
  config: Config;
  batchId: string;
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
  currentCrossEval: ClusteringQuality["cross_cluster_eval"];
  currentBoundaryPairs: NonNullable<ClusteringQuality["trajectory_projection_pairs"]>;
  currentQuality: ClusteringQuality | null;
};

export default function CrossClusterAnalysis({
  config,
  batchId,
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
  currentCrossEval,
  currentBoundaryPairs,
  currentQuality,
}: CrossClusterAnalysisProps) {
  return (
    <Stack spacing={2}>
      <TitleWithHelp
        title="Cross-cluster analysis"
        variant="h4"
        help={
          <>
            <Typography variant="body2">
              This evaluates the current clustering partition as a whole. It does not compare
              different run folders or re-cluster the data.
            </Typography>
            <Typography variant="body2" sx={{ mt: 1 }}>
              First, Python writes the deterministic selection report to
              <code> cross_cluster/input/cluster_selection_eval.json</code>. The optional
              whole-partition LLM then reads narrative cards and writes
              <code> cross_cluster/output/cross_cluster_eval.json</code>. Finally, the rule-based
              scorer writes <code>analysis/quality/clustering_quality.json</code>.
            </Typography>
          </>
        }
      />
      <Typography variant="body2" color="text.secondary">
        Whole-partition verdict (<code>cross_cluster_eval.json</code>): are clusters
        behaviorally distinct? Uses all medoid + Parameter-space pair cards and
        deterministic selection checks.
        {currentQuality?.final_score != null
          ? ` Current composite score: ${currentQuality.final_score.toFixed(1)}.`
          : ""}
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

      {evalConfigs.length > 0 && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <TitleWithHelp
            title="All Clustering Configurations (ranked)"
            variant="h6"
            help={
              <Typography variant="body2">
                Each row is a different candidate run folder, not a cluster inside the current
                run. <strong>k</strong> is the number of clusters. <strong>Silhouette</strong>
                measures trajectory/FPC geometry. <strong>Rule Score</strong> comes from
                <code>analysis/quality/clustering_quality.json</code> and combines silhouette,
                collision-rate spread, TTC spread, parameter non-overlap, and intra-cluster
                consistency. <strong>LLM Score</strong> is the separation and boundary-clarity
                average scaled to 0–100. <strong>Final Score</strong> is
                <code>0.6 × Rule Score + 0.4 × LLM Score</code> when valid LLM scores exist;
                otherwise it remains rule-only.
              </Typography>
            }
          />
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
        <Paper variant="outlined" sx={{ p: 2 }}>
          <TitleWithHelp
            title="Per-Cluster Intra Variance"
            variant="h6"
            help={
              <Typography variant="body2">
                These are rule-side trajectory-spread statistics from
                <code>clusterN/raw/cluster.json</code> and its <code>intra_variance</code> block.
                Mean, standard deviation, and maximum distance are distances from the cluster
                medoid in embedding space; <code>n_members</code> is the cluster size. A large
                spread can indicate a heterogeneous cluster, but it is not by itself a behavioral
                purity score.
              </Typography>
            }
          />
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
        <Paper variant="outlined" sx={{ p: 2 }}>
          <TitleWithHelp
            title="Inter-Cluster Analysis (LLM)"
            variant="h6"
            help={
              <Typography variant="body2">
                These fields come from <code>cross_cluster/output/cross_cluster_eval.json</code>.
                Behavioral separation and boundary clarity are LLM ratings from 1–10;
                <code>inter_notes</code> is the global explanation, while merge and split
                candidates are recommendations. They are not automatically applied and do not
                replace the deterministic selection checks.
              </Typography>
            }
          />
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
    </Stack>
  );
}
