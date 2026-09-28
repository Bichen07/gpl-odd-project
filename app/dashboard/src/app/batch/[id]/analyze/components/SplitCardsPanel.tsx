"use client";

import { useState } from "react";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Alert,
  Box,
  Chip,
  Collapse,
  IconButton,
  Paper,
  Stack,
  Tab,
  Tabs,
  Typography,
} from "@mui/material";
import { Close, ExpandMore, HelpOutline } from "@mui/icons-material";
import type { SplitAnalysis } from "../types";
import {
  agentInteractionRows,
  CONTRAST_FIELD_BODY_SX,
  CONTRAST_FIELD_LABEL_SX,
  fmtNum,
} from "../utils";

export default function SplitCardsPanel({
  split,
  folder,
  batchId,
  subTab,
  onSubTab,
  mode,
}: {
  split: SplitAnalysis | null;
  folder: string;
  batchId: string;
  subTab: number;
  onSubTab: (v: number) => void;
  /** Which saved card to show. Omit for the legacy three-tab viewer. */
  mode?: "medoid" | "summary";
}) {
  const clusters = split?.clusters ?? [];
  const [clusterIdx, setClusterIdx] = useState(0);
  const [pairIdx, setPairIdx] = useState(0);
  const [showNeighborHelp, setShowNeighborHelp] = useState(false);
  const card = clusters[Math.min(clusterIdx, Math.max(0, clusters.length - 1))] ?? null;
  const agg = (card?.aggregate ?? null) as Record<string, unknown> | null;
  const summaryParsed = ((card?.summaryMeta as Record<string, unknown> | null | undefined)
    ?.parsed ?? null) as Record<string, unknown> | null;
  const medoidParsed = ((card?.medoidMeta as Record<string, unknown> | null | undefined)
    ?.parsed ?? null) as Record<string, unknown> | null;
  const medoidAgentInteractions = agentInteractionRows(medoidParsed);
  const icPairs = split?.icPairs ?? [];
  const pair = icPairs[Math.min(pairIdx, Math.max(0, icPairs.length - 1))] ?? null;

  // When scoped to one product, pin the sub-tab instead of showing the picker.
  const effectiveSubTab = mode === "medoid" ? 1 : mode === "summary" ? 0 : subTab;

  if (!split || (clusters.length === 0 && icPairs.length === 0)) {
    return (
      <Alert severity="info">
        No saved cards yet for this folder. Run the product above, then reopen this tab.
      </Alert>
    );
  }

  return (
    <Stack spacing={2}>
      {mode == null && (
        <Typography variant="body2" color="text.secondary">
          Numbers-first report for batch {batchId} · {folder}. Explore Highlight stays the trial
          picker; this tab is the saved card viewer.
        </Typography>
      )}

      {mode == null && (
        <Tabs value={subTab} onChange={(_, v) => onSubTab(v)}>
          <Tab label="Summary" />
          <Tab label="Medoid" />
          <Tab label={`Parameter-space pairs${icPairs.length ? ` (${icPairs.length})` : ""}`} />
        </Tabs>
      )}
      {mode != null && (
        <Typography variant="h6">
          {mode === "medoid" ? "Saved medoid cards" : "Saved cluster summary cards"}
        </Typography>
      )}

      {(effectiveSubTab === 0 || effectiveSubTab === 1) && clusters.length > 0 && (
        <Stack direction="row" spacing={1} flexWrap="wrap">
          {clusters.map((c, i) => (
            <Chip
              key={c.cluster}
              label={`cluster ${c.cluster}`}
              color={i === clusterIdx ? "primary" : "default"}
              onClick={() => setClusterIdx(i)}
              size="small"
            />
          ))}
        </Stack>
      )}

      {effectiveSubTab === 0 && card && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 1 }} flexWrap="wrap">
            <Typography variant="h6" sx={{ flexGrow: 1 }}>
              Cluster {card.cluster}
              {summaryParsed?.label ? ` — ${String(summaryParsed.label)}` : ""}
            </Typography>
            {summaryParsed?.risk_level != null && (
              <Chip size="small" label={`risk: ${String(summaryParsed.risk_level)}`} />
            )}
            {agg?.collision_rate != null && (
              <Chip
                size="small"
                variant="outlined"
                label={`collision rate ${fmtNum(agg.collision_rate, 3)} (n=${String(agg.n_trials ?? "—")})`}
              />
            )}
          </Stack>
          {summaryParsed?.caption != null && (
            <Box sx={{ mb: 2 }}>
              <Typography
                variant="caption"
                color="text.secondary"
                display="block"
                gutterBottom
                sx={CONTRAST_FIELD_LABEL_SX}
              >
                caption
              </Typography>
              <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
                {String(summaryParsed.caption)}
              </Typography>
            </Box>
          )}
          {summaryParsed?.consistency_note != null && (
            <Box sx={{ mb: 2 }}>
              <Typography
                variant="caption"
                color="text.secondary"
                display="block"
                gutterBottom
                sx={CONTRAST_FIELD_LABEL_SX}
              >
                consistency_note
              </Typography>
              <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
                {String(summaryParsed.consistency_note)}
              </Typography>
            </Box>
          )}
          {summaryParsed?.motive_consistency_note != null &&
            String(summaryParsed.motive_consistency_note).trim() !== "" && (
              <Box sx={{ mb: 2 }}>
                <Typography
                  variant="caption"
                  color="text.secondary"
                  display="block"
                  gutterBottom
                  sx={CONTRAST_FIELD_LABEL_SX}
                >
                  motive_consistency_note
                </Typography>
                <Alert severity="warning">{String(summaryParsed.motive_consistency_note)}</Alert>
              </Box>
            )}
          {summaryParsed?.neighborhood_separation != null &&
            String(summaryParsed.neighborhood_separation).trim() !== "" && (
              <Box sx={{ mb: 2 }}>
                <Typography
                  variant="caption"
                  color="text.secondary"
                  display="block"
                  gutterBottom
                  sx={CONTRAST_FIELD_LABEL_SX}
                >
                  neighborhood_separation
                </Typography>
                <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
                  {String(summaryParsed.neighborhood_separation)}
                </Typography>
              </Box>
            )}
          {Array.isArray(summaryParsed?.neighbor_comparison) &&
            (summaryParsed!.neighbor_comparison as any[]).length > 0 && (
              <Box sx={{ mt: 1.5, mb: 2 }}>
                <Stack
                  direction="row"
                  spacing={0.5}
                  alignItems="center"
                  sx={{ mb: 0.5 }}
                  flexWrap="wrap"
                >
                  <Typography
                    variant="caption"
                    color="text.secondary"
                    sx={CONTRAST_FIELD_LABEL_SX}
                  >
                    neighbor_comparison
                  </Typography>
                  <IconButton
                    size="small"
                    aria-label={
                      showNeighborHelp
                        ? "Hide neighbor_comparison verdict meanings"
                        : "Show neighbor_comparison verdict meanings"
                    }
                    onClick={() => setShowNeighborHelp((open) => !open)}
                  >
                    {showNeighborHelp ? (
                      <Close fontSize="inherit" />
                    ) : (
                      <HelpOutline fontSize="inherit" />
                    )}
                  </IconButton>
                  {summaryParsed?.distinct_from_neighbors != null && (
                    <Chip
                      size="small"
                      sx={{ verticalAlign: "middle" }}
                      color={summaryParsed.distinct_from_neighbors ? "success" : "warning"}
                      label={
                        summaryParsed.distinct_from_neighbors
                          ? "distinct from all neighbors"
                          : "not distinct from every neighbor"
                      }
                    />
                  )}
                </Stack>
                <Collapse in={showNeighborHelp}>
                  <Alert severity="info" sx={{ mb: 1, py: 0.5 }}>
                    <Typography variant="caption" display="block" gutterBottom>
                      Per-neighbor verdict for this cluster (from cluster_summary.yaml).
                      These are not the pair card&apos;s separation_call words.
                    </Typography>
                    <Typography variant="caption" component="div">
                      <strong>distinct</strong> — keep apart: under matched scenario
                      parameters the two sides take different paths (stay-behind vs
                      overlap / go-through, or a different resolution) and/or
                      different outcomes. Maps from pair{" "}
                      <code>separation_call: justified</code>. The boundary trial
                      need not match this cluster&apos;s medoid.
                    </Typography>
                    <Typography variant="caption" component="div">
                      <strong>similar</strong> — merge evidence: same geometry family
                      and outcome, only a weak/late geometric difference. Maps
                      from pair <code>separation_call: over_fine</code>.
                    </Typography>
                    <Typography variant="caption" component="div">
                      <strong>inconclusive</strong> — this edge cannot decide keep vs
                      merge because the pair card itself was{" "}
                      <code>separation_call: inconclusive</code> (unusable /
                      contradictory evidence). Not used merely because a boundary
                      trial differs from the medoid. The Analyze report&apos;s
                      &quot;Inconclusive pair separations&quot; list is the pair
                      field, not this verdict.
                    </Typography>
                    <Typography variant="caption" component="div">
                      <strong>ambiguous</strong> — missing contrast.yaml / medoid card,
                      not a behavior judgment.
                    </Typography>
                  </Alert>
                </Collapse>
                <Stack spacing={0.5}>
                  {(summaryParsed!.neighbor_comparison as any[]).map((nc, i) => (
                    <Stack key={i} direction="row" spacing={1} alignItems="baseline" flexWrap="wrap">
                      <Chip
                        size="small"
                        variant="outlined"
                        label={`${nc.parameter_space_pair_folder ?? `cluster${nc.neighbor_cluster}`}: ${nc.verdict ?? "?"}`}
                        color={
                          nc.verdict === "distinct"
                            ? "success"
                            : nc.verdict === "similar"
                              ? "warning"
                              : nc.verdict === "inconclusive"
                                ? "info"
                                : "default"
                        }
                      />
                      <Typography variant="caption" color="text.secondary">
                        {nc.reason}
                      </Typography>
                    </Stack>
                  ))}
                </Stack>
              </Box>
            )}
          {!summaryParsed && card.summaryYaml && (
            <Box
              component="pre"
              sx={{ m: 0, p: 1.5, bgcolor: "grey.50", borderRadius: 1, fontSize: 12, overflow: "auto" }}
            >
              {card.summaryYaml}
            </Box>
          )}
          {summaryParsed && card.summaryYaml && (
            <Accordion disableGutters elevation={0}>
              <AccordionSummary expandIcon={<ExpandMore />}>
                <Typography fontSize={13}>Raw cluster_summary.yaml</Typography>
              </AccordionSummary>
              <AccordionDetails>
                <Box component="pre" sx={{ m: 0, fontSize: 11, overflow: "auto", whiteSpace: "pre-wrap" }}>
                  {card.summaryYaml}
                </Box>
              </AccordionDetails>
            </Accordion>
          )}
        </Paper>
      )}

      {effectiveSubTab === 1 && card && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="h6" gutterBottom>
            Medoid trial
            {medoidParsed?.trial_id != null ? ` ${String(medoidParsed.trial_id)}` : ""}
          </Typography>
          {medoidParsed?.outcome != null && (
            <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 2 }}>
              <Chip size="small" label={`outcome: ${String(medoidParsed.outcome)}`} />
            </Stack>
          )}
          {medoidAgentInteractions.length > 0 && (
            <Stack spacing={0.5} sx={{ mb: 2 }}>
              <Typography variant="caption" color="text.secondary">
                agent_interactions
              </Typography>
              {medoidAgentInteractions.map((row: Record<string, unknown>, i: number) => (
                <Typography key={`${String(row?.agent)}-${i}`} variant="body2">
                  {String(row?.agent ?? "?")}: resolution={String(row?.resolution ?? "—")}
                  {row?.control_response != null && String(row.control_response).trim() !== ""
                    ? `, control=${String(row.control_response)}`
                    : ""}
                  {row?.motive != null && String(row.motive).trim() !== ""
                    ? `, motive=${String(row.motive)}`
                    : ""}
                </Typography>
              ))}
            </Stack>
          )}
          {medoidParsed?.motive_summary != null &&
            String(medoidParsed.motive_summary) !== "parse_failed" && (
            <Box sx={{ mb: 2 }}>
              <Typography
                variant="caption"
                color="text.secondary"
                display="block"
                gutterBottom
                sx={CONTRAST_FIELD_LABEL_SX}
              >
                motive_summary
              </Typography>
              <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
                {String(medoidParsed.motive_summary)}
              </Typography>
            </Box>
          )}
          {Array.isArray(medoidParsed?.decision_timeline) &&
            (medoidParsed.decision_timeline as unknown[]).length > 0 && (
            <Box sx={{ mb: 2 }}>
              <Typography
                variant="caption"
                color="text.secondary"
                display="block"
                gutterBottom
                sx={CONTRAST_FIELD_LABEL_SX}
              >
                decision_timeline
              </Typography>
              <Stack spacing={1}>
                {(medoidParsed.decision_timeline as Array<Record<string, unknown>>).map(
                  (ev, i) => (
                    <Box key={i} sx={{ pl: 1, borderLeft: "2px solid", borderColor: "divider" }}>
                      <Typography variant="caption" color="text.secondary">
                        t={fmtNum(ev.timestamp ?? ev.t, 2)}s
                        {ev.motive != null &&
                        String(ev.motive) !== "" &&
                        String(ev.motive) !== "null"
                          ? ` · ${String(ev.motive)}`
                          : ""}
                      </Typography>
                      <Typography variant="body2">{String(ev.description ?? "")}</Typography>
                    </Box>
                  ),
                )}
              </Stack>
            </Box>
          )}
          {medoidParsed?.collision_detail != null &&
            typeof medoidParsed.collision_detail === "object" && (
            <Box sx={{ mb: 2 }}>
              <Typography
                variant="caption"
                color="text.secondary"
                display="block"
                gutterBottom
                sx={CONTRAST_FIELD_LABEL_SX}
              >
                collision_detail
              </Typography>
              {(() => {
                const cd = medoidParsed.collision_detail as Record<string, unknown>;
                return (
                  <Stack spacing={0.5}>
                    {cd.impact_type != null && (
                      <Typography variant="body2">
                        impact_type: {String(cd.impact_type)}
                      </Typography>
                    )}
                    {cd.bearing_sector != null && (
                      <Typography variant="body2">
                        bearing_sector: {String(cd.bearing_sector)}
                      </Typography>
                    )}
                    {cd.narrative != null && (
                      <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
                        {String(cd.narrative)}
                      </Typography>
                    )}
                  </Stack>
                );
              })()}
            </Box>
          )}
          {(!medoidParsed ||
            String(medoidParsed.motive_summary ?? "") === "parse_failed" ||
            !(Array.isArray(medoidParsed.decision_timeline) &&
              (medoidParsed.decision_timeline as unknown[]).length)) &&
            card.medoidYaml && (
            <Box
              component="pre"
              sx={{ m: 0, p: 1.5, bgcolor: "grey.50", borderRadius: 1, fontSize: 12, overflow: "auto", whiteSpace: "pre-wrap" }}
            >
              {card.medoidYaml}
            </Box>
          )}
          {medoidParsed &&
            String(medoidParsed.motive_summary ?? "") !== "parse_failed" &&
            Array.isArray(medoidParsed.decision_timeline) &&
            (medoidParsed.decision_timeline as unknown[]).length > 0 &&
            card.medoidYaml && (
            <Accordion disableGutters elevation={0}>
              <AccordionSummary expandIcon={<ExpandMore />}>
                <Typography fontSize={13}>Raw medoid_trial.yaml</Typography>
              </AccordionSummary>
              <AccordionDetails>
                <Box component="pre" sx={{ m: 0, fontSize: 11, overflow: "auto" }}>
                  {card.medoidYaml}
                </Box>
              </AccordionDetails>
            </Accordion>
          )}
        </Paper>
      )}

      {effectiveSubTab === 2 && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          {icPairs.length === 0 ? (
            <Alert severity="info">No Parameter-space pair YAMLs under parameter_space_pairs/ yet.</Alert>
          ) : (
            <>
              <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 2 }}>
                {icPairs.map((p, i) => (
                  <Chip
                    key={p.name}
                    label={p.name.replace(/\.yaml$/, "")}
                    color={i === pairIdx ? "primary" : "default"}
                    onClick={() => setPairIdx(i)}
                    size="small"
                  />
                ))}
              </Stack>
              <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
                Trial ids in the YAML can be highlighted from Explore → Highlight.
              </Typography>
              <Box
                component="pre"
                sx={{
                  m: 0,
                  p: 1.5,
                  bgcolor: "grey.50",
                  borderRadius: 1,
                  fontSize: 12,
                  overflow: "auto",
                  whiteSpace: "pre-wrap",
                }}
              >
                {pair?.yaml ?? ""}
              </Box>
            </>
          )}
        </Paper>
      )}
    </Stack>
  );
}
