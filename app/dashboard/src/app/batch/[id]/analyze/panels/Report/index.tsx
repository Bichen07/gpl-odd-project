"use client";

import { useEffect, useState } from "react";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Alert,
  Box,
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
import { ExpandMore } from "@mui/icons-material";
import type { ReportData } from "../../types";
import { TAB } from "../../constants";
import { riskColor } from "../../utils";

export default function Report({
  batchId,
  folder,
  onNavigateTab,
}: {
  batchId: string;
  folder: string;
  onNavigateTab: (tab: number) => void;
}) {
  const [data, setData] = useState<ReportData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  /** Expanded pair row folder — click again or another row to collapse. */
  const [expandedPair, setExpandedPair] = useState<string | null>(null);

  useEffect(() => {
    setLoading(true);
    setError(null);
    fetch(`/api/cluster-run-report?batchId=${batchId}&folder=${encodeURIComponent(folder)}`)
      .then((r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then((d) => setData(d as ReportData))
      .catch((e) => setError(String(e)))
      .finally(() => setLoading(false));
  }, [batchId, folder]);

  if (loading) {
    return (
      <Stack alignItems="center" sx={{ py: 6 }}>
        <CircularProgress />
        <Typography sx={{ mt: 1 }}>Loading report…</Typography>
      </Stack>
    );
  }
  if (error || !data) {
    return <Alert severity="error">{error ?? "Failed to load report"}</Alert>;
  }

  const { header, clusters, pairs } = data;

  // Motive histogram: count primary motives across high-collision clusters
  const motiveCount: Record<string, number> = {};
  for (const c of clusters) {
    if (c.medoidMotive && (c.collisionRate ?? 0) > 5) {
      motiveCount[c.medoidMotive] = (motiveCount[c.medoidMotive] ?? 0) + 1;
    }
  }
  const sortedMotives = Object.entries(motiveCount).sort(([, a], [, b]) => b - a);

  // Outcome-flip pairs
  const flipPairs = pairs.filter((p) => p.outcomeFlip);
  const justifiedPairs = pairs.filter((p) => p.separationCall === "justified");

  // Next tests recommendations (deterministic)
  const highFailNoContrast = clusters.filter(
    (c) => (c.collisionRate ?? 0) > 10 && !pairs.some((p) => p.clusters.includes(c.id) && p.hasContrast),
  );
  const inconclusivePairs = pairs.filter(
    (p) => p.separationCall === "inconclusive" || (p.hasContrast && !p.separationCall),
  );

  return (
    <Stack spacing={3}>
      {/* ── A. Header ─────────────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Report
        </Typography>
        <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1 }}>
          <Chip label={`batch ${header.batchId}`} size="small" />
          <Chip label={header.folder} size="small" variant="outlined" />
          {header.k != null && <Chip label={`k = ${header.k}`} size="small" />}
          {header.silhouette != null && (
            <Chip label={`silhouette = ${header.silhouette.toFixed(4)}`} size="small" />
          )}
        </Stack>
        <Stack direction="row" spacing={1} flexWrap="wrap">
          {header.selectionScore != null && (
            <Chip
              label={`selection score: ${header.selectionScore}`}
              color="primary"
              size="small"
            />
          )}
          {header.qualityScore != null && (
            <Chip
              label={`quality: ${header.qualityScore.toFixed(1)}`}
              size="small"
              variant="outlined"
            />
          )}
        </Stack>
        <Typography variant="caption" color="text.secondary" sx={{ mt: 1, display: "block" }}>
          Selection score measures behavioral usefulness of this partition, not geometric correctness alone.
        </Typography>
      </Paper>

      {/* ── B. Risk Table ─────────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Cluster Risk Overview
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Sorted by collision rate (descending). Click a cluster to view its analysis.
        </Typography>
        <Table size="small">
          <TableHead>
            <TableRow>
              <TableCell>Cluster</TableCell>
              <TableCell>Label</TableCell>
              <TableCell>n</TableCell>
              <TableCell>Collision Rate</TableCell>
              <TableCell>Medoid Motive</TableCell>
              <TableCell>Outcome</TableCell>
              <TableCell>Risk</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {clusters.map((c) => (
              <TableRow
                key={c.id}
                hover
                sx={{ cursor: "pointer" }}
                onClick={() => onNavigateTab(TAB.MEDOID)}
              >
                <TableCell>
                  <Chip label={`C${c.id}`} size="small" />
                </TableCell>
                <TableCell>{c.label ?? "—"}</TableCell>
                <TableCell>{c.n}</TableCell>
                <TableCell>
                  <Chip
                    label={c.collisionRate != null ? `${c.collisionRate.toFixed(1)}%` : "—"}
                    color={
                      (c.collisionRate ?? 0) > 50
                        ? "error"
                        : (c.collisionRate ?? 0) > 10
                          ? "warning"
                          : "success"
                    }
                    size="small"
                  />
                </TableCell>
                <TableCell>
                  <Chip
                    label={c.medoidMotive ?? "—"}
                    size="small"
                    variant="outlined"
                  />
                </TableCell>
                <TableCell>{c.medoidOutcome ?? "—"}</TableCell>
                <TableCell>
                  {c.riskLevel ? (
                    <Chip
                      label={c.riskLevel}
                      color={riskColor(c.riskLevel)}
                      size="small"
                    />
                  ) : (
                    "—"
                  )}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </Paper>

      {/* ── C. Failure Modes ──────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Behavioral Failure Modes
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Primary motives ranked by frequency across clusters with collision rate &gt; 5%.
        </Typography>
        {sortedMotives.length > 0 ? (
          <Stack spacing={1}>
            {sortedMotives.map(([motive, count]) => (
              <Stack key={motive} direction="row" spacing={1} alignItems="center">
                <Box
                  sx={{
                    width: `${Math.min(100, (count / clusters.length) * 100 * 2)}%`,
                    minWidth: 40,
                    height: 24,
                    bgcolor: "error.main",
                    borderRadius: 1,
                    opacity: 0.7 + 0.3 * (count / Math.max(...sortedMotives.map(([, c]) => c))),
                  }}
                />
                <Typography variant="body2" fontWeight={600}>
                  {motive}
                </Typography>
                <Typography variant="caption" color="text.secondary">
                  ({count} cluster{count > 1 ? "s" : ""})
                </Typography>
              </Stack>
            ))}
          </Stack>
        ) : (
          <Typography variant="body2" color="text.secondary">
            No high-collision clusters with motives found.
          </Typography>
        )}
      </Paper>

      {/* ── D. Pair Evidence ──────────────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Matched-Parameter ODD Evidence
        </Typography>
        <Stack direction="row" spacing={1} sx={{ mb: 2 }} flexWrap="wrap">
          <Chip
            label={`${flipPairs.length} outcome flip${flipPairs.length !== 1 ? "s" : ""}`}
            color={flipPairs.length > 0 ? "warning" : "default"}
            size="small"
          />
          <Chip
            label={`${justifiedPairs.length} justified separation${justifiedPairs.length !== 1 ? "s" : ""}`}
            color={justifiedPairs.length > 0 ? "success" : "default"}
            size="small"
          />
          <Chip label={`${pairs.length} total pair${pairs.length !== 1 ? "s" : ""}`} size="small" variant="outlined" />
        </Stack>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Near-identical scenario parameters with different outcomes → candidate ODD edge.
          Click a row to expand full Explanation / Separation reason; click again or another
          row to collapse.
        </Typography>
        {pairs.length > 0 ? (
          <Table size="small">
            <TableHead>
              <TableRow>
                <TableCell>Pack</TableCell>
                <TableCell>Param Distance</TableCell>
                <TableCell>Outcome Flip</TableCell>
                <TableCell>Separation</TableCell>
                <TableCell>Explanation</TableCell>
                <TableCell>Separation reason</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {pairs.map((p) => {
                const expanded = expandedPair === p.folder;
                const clampSx = (lines: number) =>
                  expanded
                    ? {
                        whiteSpace: "pre-wrap" as const,
                        display: "block",
                        maxHeight: 480,
                        overflow: "auto",
                        transition: "max-height 0.35s ease",
                      }
                    : {
                        display: "-webkit-box",
                        WebkitLineClamp: lines,
                        WebkitBoxOrient: "vertical" as const,
                        overflow: "hidden",
                        maxHeight: `${lines * 1.45}em`,
                        transition: "max-height 0.35s ease",
                      };
                return (
                <TableRow
                  key={p.folder}
                  hover
                  sx={{
                    cursor: "pointer",
                    verticalAlign: "top",
                    "& td": {
                      transition: "padding 0.25s ease",
                      py: expanded ? 1.25 : 0.75,
                    },
                  }}
                  onClick={() =>
                    setExpandedPair((prev) => (prev === p.folder ? null : p.folder))
                  }
                >
                  <TableCell>
                    <Chip
                      label={p.folder}
                      size="small"
                      variant="outlined"
                      onDoubleClick={(e) => {
                        e.stopPropagation();
                        onNavigateTab(TAB.PAIRS);
                      }}
                    />
                  </TableCell>
                  <TableCell>{p.paramDist != null ? p.paramDist.toFixed(4) : "—"}</TableCell>
                  <TableCell>
                    <Chip
                      label={p.outcomeFlip ? "Yes" : "No"}
                      color={p.outcomeFlip ? "warning" : "default"}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>
                    {p.separationCall ? (
                      <Chip
                        label={p.separationCall}
                        color={
                          p.separationCall === "justified"
                            ? "success"
                            : p.separationCall === "over_fine"
                              ? "warning"
                              : "default"
                        }
                        size="small"
                      />
                    ) : (
                      "—"
                    )}
                  </TableCell>
                  <TableCell sx={{ maxWidth: 480 }}>
                    <Typography variant="caption" sx={clampSx(2)}>
                      {p.contrastExplanation ?? (p.hasContrast ? "(see contrast)" : "Not yet analyzed")}
                    </Typography>
                  </TableCell>
                  <TableCell sx={{ maxWidth: 440 }}>
                    <Typography variant="caption" sx={{ ...clampSx(3), whiteSpace: "pre-wrap" }}>
                      {p.separationReason ?? "—"}
                    </Typography>
                  </TableCell>
                </TableRow>
                );
              })}
            </TableBody>
          </Table>
        ) : (
          <Alert severity="info">No parameter-space pairs in this run.</Alert>
        )}
      </Paper>

      {/* ── E. Rules / Boundary (S2 + S3) ──────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          ODD Boundary Export &amp; Parameter Rules
        </Typography>
        {data.boundaryExport ? (
          <>
            <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1 }}>
              <Chip size="small" label={`kNN = ${data.boundaryExport.kNN ?? "—"}`} />
              {data.boundaryExport.kpiName && (
                <Chip size="small" variant="outlined" label={`KPI: ${data.boundaryExport.kpiName}`} />
              )}
              <Chip
                size="small"
                color="warning"
                label={`${data.boundaryExport.collisionBoundaryCount} on collision boundary`}
              />
              <Chip
                size="small"
                color="info"
                label={`${data.boundaryExport.clusterBoundaryCount} on cluster boundary`}
              />
              {data.boundaryExport.nTrialsConsidered != null && (
                <Chip
                  size="small"
                  variant="outlined"
                  label={`n=${data.boundaryExport.nTrialsConsidered} trials considered`}
                />
              )}
              {data.boundaryExport.nTrialsWithoutClusterLabel != null &&
                data.boundaryExport.nTrialsWithoutClusterLabel > 0 && (
                  <Chip
                    size="small"
                    variant="outlined"
                    color="default"
                    label={`${data.boundaryExport.nTrialsWithoutClusterLabel} trials outside clustering fit`}
                  />
                )}
            </Stack>
            <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
              From <code>odd_boundary_export.json</code>
              {data.boundaryExport.generatedAt
                ? ` (generated ${new Date(data.boundaryExport.generatedAt).toLocaleString()})`
                : ""}
              . Same min–max normalized kd-tree metric as Explore &rsquo;s Filtering panel — not
              comparable to parameter-space pair z-score distances. Can be (re)written from a
              terminal via <code>python -m llm_pipeline.cli odd-export --run-dir …</code> instead
              of the Explore UI button.
            </Typography>
          </>
        ) : (
          <Alert severity="info" sx={{ mb: 1 }}>
            <Typography variant="body2">
              <strong>Not yet exported.</strong> Open Explore → Filtering and click &ldquo;Export
              ODD boundary&rdquo;, or run{" "}
              <code>python -m llm_pipeline.cli odd-export --run-dir …</code> from a terminal.
            </Typography>
          </Alert>
        )}

        {data.parameterRules && data.parameterRules.rules.length > 0 ? (
          <>
            <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mt: 2, mb: 1 }}>
              <Chip size="small" label={`CART depth ≤ ${data.parameterRules.maxDepth ?? "—"}`} />
              <Chip
                size="small"
                variant="outlined"
                label={`n=${data.parameterRules.nTrialsUsed ?? "—"} trials trained on`}
              />
              {data.parameterRules.trainAcc != null && (
                <Chip size="small" variant="outlined" label={`train acc ${data.parameterRules.trainAcc}`} />
              )}
              {data.parameterRules.cvAcc != null && (
                <Chip size="small" variant="outlined" label={`cv acc ${data.parameterRules.cvAcc}`} />
              )}
            </Stack>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>Rule</TableCell>
                  <TableCell>Predicate</TableCell>
                  <TableCell>Predicts</TableCell>
                  <TableCell align="right">Support</TableCell>
                  <TableCell align="right">Precision</TableCell>
                  <TableCell align="right">Boundary hits</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {data.parameterRules.rules.map((r) => (
                  <TableRow key={r.id}>
                    <TableCell>
                      <Chip size="small" label={r.id} />
                    </TableCell>
                    <TableCell>
                      <Typography variant="body2" component="code" sx={{ fontSize: "0.8rem" }}>
                        {r.predicate}
                      </Typography>
                    </TableCell>
                    <TableCell>
                      <Chip
                        size="small"
                        color={r.predicted === "collision" ? "error" : "success"}
                        label={r.predicted}
                      />
                    </TableCell>
                    <TableCell align="right">{r.support}</TableCell>
                    <TableCell align="right">{r.precision}</TableCell>
                    <TableCell align="right">{r.boundaryTrialHits ?? "—"}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
            <Typography variant="caption" color="text.secondary" display="block" sx={{ mt: 1 }}>
              From <code>odd_parameter_rules.json</code>
              {data.parameterRules.generatedAt
                ? ` (generated ${new Date(data.parameterRules.generatedAt).toLocaleString()})`
                : ""}
              . Auditable hypotheses about the sampled trials only — not a certified SAE J3016 ODD
              boundary. Trained via <code>python -m llm_pipeline.cli odd-rules --run-dir …</code>.
            </Typography>
          </>
        ) : (
          <Alert severity="info" sx={{ mt: 2 }}>
            <Typography variant="body2">
              <strong>Parameter rules not yet available (S3).</strong> Run{" "}
              <code>python -m llm_pipeline.cli odd-rules --run-dir …</code> (needs S2&rsquo;s{" "}
              <code>odd_all_trials.json</code> first) to get auditable predicates like
              &ldquo;OncomingSpeed &gt; 12.4 AND OncomingStartDelay &lt; 0.8 →
              collision&rdquo; with precision/support.
            </Typography>
          </Alert>
        )}
      </Paper>

      {/* ── F. Merge / Split Advice ───────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Clustering Trust
        </Typography>
        {data.mergeCandidates.length > 0 ? (
          <>
            <Alert severity="warning" sx={{ mb: 1 }}>
              <Typography variant="body2" fontWeight={600}>
                Merge candidates detected
              </Typography>
              {data.mergeCandidates.map((mc, i) => (
                <Typography key={i} variant="caption" display="block">
                  cluster{mc.clusters[0]} + cluster{mc.clusters[1]} — shared motive{" "}
                  <strong>{mc.sharedMotive}</strong>, param overlap {mc.paramOverlap.toFixed(2)}
                </Typography>
              ))}
            </Alert>
          </>
        ) : (
          <Alert severity="success" sx={{ mb: 1 }}>
            No merge candidates — all clusters appear sufficiently distinct.
          </Alert>
        )}
        {data.selectionFindings.length > 0 && (
          <Stack spacing={0.5} sx={{ mt: 1 }}>
            {data.selectionFindings.map((f, i) => (
              <Typography key={i} variant="body2">
                • {f}
              </Typography>
            ))}
          </Stack>
        )}
        <Button
          variant="text"
          size="small"
          sx={{ mt: 1 }}
          onClick={() => onNavigateTab(TAB.CROSS_CLUSTER)}
        >
          View detailed cross-cluster analysis →
        </Button>
      </Paper>

      {/* ── G. Recommended Next Tests ─────────────────────────────────── */}
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>
          Recommended Next Tests
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Deterministic priorities based on current analysis gaps.
        </Typography>
        <Stack spacing={1}>
          {highFailNoContrast.length > 0 && (
            <Alert severity="warning">
              <Typography variant="body2">
                <strong>High-collision clusters without pair contrast:</strong>{" "}
                {highFailNoContrast.map((c) => `cluster${c.id} (${c.collisionRate?.toFixed(1)}%)`).join(", ")}
              </Typography>
              <Typography variant="caption">
                These clusters have high failure rates but no parameter-space pair analysis yet.
              </Typography>
            </Alert>
          )}
          {inconclusivePairs.length > 0 && (
            <Alert severity="info">
              <Typography variant="body2">
                <strong>Inconclusive pair separations:</strong>{" "}
                {inconclusivePairs.map((p) => p.folder).join(", ")}
              </Typography>
              <Typography variant="caption">
                Re-examine these pairs — the current analysis could not determine if the separation is justified.
              </Typography>
            </Alert>
          )}
          {highFailNoContrast.length === 0 && inconclusivePairs.length === 0 && (
            <Alert severity="success">
              All high-collision clusters have pair contrasts and all separations are resolved.
            </Alert>
          )}
        </Stack>
      </Paper>

      {/* ── Captions (per-cluster expandable) ─────────────────────────── */}
      {clusters.some((c) => c.summaryCaption) && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="h6" gutterBottom>
            Cluster Summaries
          </Typography>
          {clusters.map((c) =>
            c.summaryCaption ? (
              <Accordion key={c.id} disableGutters elevation={0} variant="outlined" sx={{ mb: 0.5 }}>
                <AccordionSummary expandIcon={<ExpandMore />}>
                  <Stack direction="row" spacing={1} alignItems="center">
                    <Chip label={`C${c.id}`} size="small" />
                    <Typography variant="subtitle2">{c.label ?? `Cluster ${c.id}`}</Typography>
                    {c.riskLevel && (
                      <Chip label={c.riskLevel} color={riskColor(c.riskLevel)} size="small" />
                    )}
                  </Stack>
                </AccordionSummary>
                <AccordionDetails>
                  <Typography
                    variant="body2"
                    sx={{ whiteSpace: "pre-wrap", lineHeight: 1.7 }}
                  >
                    {c.summaryCaption}
                  </Typography>
                  {c.consistencyNote && (
                    <Typography variant="caption" color="text.secondary" sx={{ mt: 1, display: "block" }}>
                      Consistency: {c.consistencyNote}
                    </Typography>
                  )}
                </AccordionDetails>
              </Accordion>
            ) : null,
          )}
        </Paper>
      )}
    </Stack>
  );
}
