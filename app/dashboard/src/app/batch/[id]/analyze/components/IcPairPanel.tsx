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
  Slider,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableRow,
  Typography,
} from "@mui/material";
import { Close, ExpandMore, HelpOutline } from "@mui/icons-material";
import type { IcPairEntry, SplitClusterCard } from "../types";
import { CONTRAST_FIELD_BODY_SX, CONTRAST_FIELD_LABEL_SX, fmtNum } from "../utils";

export default function IcPairPanel({
  pairs,
  folder,
  batchId,
  splitClusters = [],
}: {
  pairs: IcPairEntry[];
  folder: string;
  batchId: string;
  splitClusters?: SplitClusterCard[];
}) {
  const [idx, setIdx] = useState(0);
  const [frame, setFrame] = useState(0);
  const [showContrastHelp, setShowContrastHelp] = useState(false);
  const [showDivergenceHelp, setShowDivergenceHelp] = useState(false);
  const [showReasonHelp, setShowReasonHelp] = useState(false);
  const pair = pairs[Math.min(idx, Math.max(0, pairs.length - 1))] ?? null;
  const facts = (pair?.facts ?? null) as Record<string, any> | null;
  const frames = pair?.syncedBev ?? [];
  const shown = frames[Math.min(frame, Math.max(0, frames.length - 1))];
  const contrastParsed = (pair?.contrastMeta as Record<string, any> | null)?.parsed as
    | Record<string, any>
    | undefined;
  const leftRes =
    contrastParsed?.left?.resolution ?? contrastParsed?.left?.interaction_resolution;
  const rightRes =
    contrastParsed?.right?.resolution ?? contrastParsed?.right?.interaction_resolution;
  const leftLegacy =
    leftRes == null ? contrastParsed?.left?.primary_motive : undefined;
  const rightLegacy =
    rightRes == null ? contrastParsed?.right?.primary_motive : undefined;
  const leftMedoid = splitClusters.find(
    (c) => String(c.cluster) === String(facts?.cluster_a),
  );
  const rightMedoid = splitClusters.find(
    (c) => String(c.cluster) === String(facts?.cluster_b),
  );

  if (pairs.length === 0) {
    return (
      <Alert severity="info">
        No Parameter-space pair packs under <code>parameter_space_pairs/</code>. Rebuild the dataset with{" "}
        <code>--param-boundaries all</code>. Packs only exist for cluster pairs whose closest
        trials sit within the parameter caliper (param_dist ≤ tau).
      </Alert>
    );
  }

  return (
    <Stack spacing={2}>
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 2 }}>
          {pairs.map((p, i) => (
            <Chip
              key={p.name}
              label={`${p.folder ?? p.name.replace(/\.yaml$/, "")}${
                p.readyForLlm ? "" : " ⚠"
              }`}
              color={i === idx ? "primary" : "default"}
              variant={p.hasContrast || p.yaml ? "filled" : "outlined"}
              onClick={() => {
                setIdx(i);
                setFrame(0);
              }}
              size="small"
            />
          ))}
        </Stack>
        <Typography variant="caption" color="text.secondary">
          Filled chips have an LLM contrast card; ⚠ = not ready for LLM (medoid / process /
          BEV).
        </Typography>
        {pair && !pair.readyForLlm && (
          <Alert severity="warning" sx={{ mt: 1 }}>
            Not ready: {(pair.missing ?? []).join(", ") || "missing inputs"}
          </Alert>
        )}

        {facts && (
          <Table size="small" sx={{ mt: 2 }}>
            <TableBody>
              <TableRow>
                <TableCell>clusters</TableCell>
                <TableCell>
                  cluster {String(facts.cluster_a)} vs cluster {String(facts.cluster_b)}
                </TableCell>
              </TableRow>
              <TableRow>
                <TableCell>param_dist</TableCell>
                <TableCell>
                  {fmtNum(facts.param_dist, 4)} (tau {String(facts.param_dist_tau)}) ·{" "}
                  {String(facts.card_role)}
                </TableCell>
              </TableRow>
              <TableRow>
                <TableCell>outcomes</TableCell>
                <TableCell>
                  <Chip
                    size="small"
                    label={facts.collided_a ? "collision" : "safe"}
                    color={facts.collided_a ? "error" : "success"}
                    sx={{ mr: 1 }}
                  />
                  <Chip
                    size="small"
                    label={facts.collided_b ? "collision" : "safe"}
                    color={facts.collided_b ? "error" : "success"}
                  />
                </TableCell>
              </TableRow>
              {(leftRes || rightRes) && (
                <TableRow>
                  <TableCell>resolution</TableCell>
                  <TableCell>
                    <Chip size="small" variant="outlined" label={`left: ${leftRes ?? "?"}`} sx={{ mr: 1 }} />
                    <Chip size="small" variant="outlined" label={`right: ${rightRes ?? "?"}`} />
                  </TableCell>
                </TableRow>
              )}
              {!leftRes && !rightRes && (leftLegacy || rightLegacy) && (
                <TableRow>
                  <TableCell>legacy motive</TableCell>
                  <TableCell>
                    <Chip size="small" variant="outlined" label={`left: ${leftLegacy ?? "?"}`} sx={{ mr: 1 }} />
                    <Chip size="small" variant="outlined" label={`right: ${rightLegacy ?? "?"}`} />
                  </TableCell>
                </TableRow>
              )}
              <TableRow>
                <TableCell>trials</TableCell>
                <TableCell>
                  {String(facts.trial_a)} (idx {String(facts.trial_index_a)}) vs{" "}
                  {String(facts.trial_b)} (idx {String(facts.trial_index_b)})
                </TableCell>
              </TableRow>
            </TableBody>
          </Table>
        )}
      </Paper>

      {(leftMedoid?.medoidYaml || rightMedoid?.medoidYaml) && (
        <Accordion disableGutters elevation={0} variant="outlined">
          <AccordionSummary expandIcon={<ExpandMore />}>
            <Typography variant="subtitle2">Endpoint medoid cards (required inputs)</Typography>
          </AccordionSummary>
          <AccordionDetails>
            <Stack spacing={1}>
              {leftMedoid?.medoidYaml && (
                <Box>
                  <Typography variant="caption" color="text.secondary">
                    cluster{String(facts?.cluster_a)} medoid
                  </Typography>
                  <Box
                    component="pre"
                    sx={{ m: 0, p: 1, bgcolor: "grey.50", fontSize: 11, maxHeight: 180, overflow: "auto", whiteSpace: "pre-wrap" }}
                  >
                    {leftMedoid.medoidYaml.slice(0, 1200)}
                    {leftMedoid.medoidYaml.length > 1200 ? "\n…" : ""}
                  </Box>
                </Box>
              )}
              {rightMedoid?.medoidYaml && (
                <Box>
                  <Typography variant="caption" color="text.secondary">
                    cluster{String(facts?.cluster_b)} medoid
                  </Typography>
                  <Box
                    component="pre"
                    sx={{ m: 0, p: 1, bgcolor: "grey.50", fontSize: 11, maxHeight: 180, overflow: "auto", whiteSpace: "pre-wrap" }}
                  >
                    {rightMedoid.medoidYaml.slice(0, 1200)}
                    {rightMedoid.medoidYaml.length > 1200 ? "\n…" : ""}
                  </Box>
                </Box>
              )}
            </Stack>
          </AccordionDetails>
        </Accordion>
      )}

      {(pair?.processContext || pair?.mergedTimeline) && (
        <Accordion disableGutters elevation={0} variant="outlined">
          <AccordionSummary expandIcon={<ExpandMore />}>
            <Typography variant="subtitle2">
              Pair context (process/context.md — shared clock)
            </Typography>
          </AccordionSummary>
          <AccordionDetails>
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
                maxHeight: 400,
              }}
            >
              {pair.processContext ?? pair.mergedTimeline}
            </Box>
          </AccordionDetails>
        </Accordion>
      )}

      {frames.length > 0 && pair?.folder && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="subtitle2" gutterBottom>
            Synced BEV — left = cluster {String(facts?.cluster_a)}, right = cluster{" "}
            {String(facts?.cluster_b)}, same shared clock
          </Typography>
          <Slider
            size="small"
            min={0}
            max={frames.length - 1}
            step={1}
            value={Math.min(frame, frames.length - 1)}
            onChange={(_, v) => setFrame(v as number)}
            marks
          />
          <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
            frame {Math.min(frame, frames.length - 1) + 1} / {frames.length} — {shown}
          </Typography>
          {shown && (
            <Box
              component="img"
              src={`/api/cluster-analyze?batchId=${encodeURIComponent(batchId)}&folder=${encodeURIComponent(folder)}&icPair=${encodeURIComponent(pair.folder)}&file=${encodeURIComponent(shown)}`}
              alt={shown}
              sx={{ width: "100%", borderRadius: 1, border: "1px solid #eee" }}
            />
          )}
        </Paper>
      )}

      <Paper variant="outlined" sx={{ p: 2 }}>
        <Stack direction="row" spacing={0.5} alignItems="center" sx={{ mb: 1 }}>
          <Typography variant="subtitle2" sx={{ fontSize: 20, fontWeight: 700 }}>
            Contrast card (output/contrast.yaml)
          </Typography>
          <IconButton
            size="small"
            aria-label={
              showContrastHelp
                ? "Hide contrast field meanings"
                : "Show contrast field meanings"
            }
            onClick={() => setShowContrastHelp((open) => !open)}
          >
            {showContrastHelp ? (
              <Close fontSize="inherit" />
            ) : (
              <HelpOutline fontSize="inherit" />
            )}
          </IconButton>
        </Stack>
        <Collapse in={showContrastHelp}>
          <Alert severity="info" sx={{ mb: 2, py: 0.5 }}>
            <Typography variant="caption" component="div">
              Each side is <code>resolution</code> (<code>pass_first</code>,{" "}
              <code>yield</code>, or <code>unresolved</code>) plus one{" "}
              <code>evidence</code> sentence from this pair&apos;s context.
            </Typography>
            <Typography variant="caption" display="block" fontWeight={700} sx={{ mt: 1 }}>
              Behavioral similarity
            </Typography>
            <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
              The behavior of the two boundary trials in this matched-parameter
              pair. The report column Behavioral similarity is this same field.
              It does not compare the whole-cluster trajectories and it does
              not change the clustering. The file field is{" "}
              <code>behavior_similarity</code>.
            </Typography>
            <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
              <Chip size="small" color="success" label="distinct" /> the two
              trials differ in resolution family, outcome, or a clearance
              difference that stays different.
            </Typography>
            <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
              <Chip size="small" label="similar" /> the two trials share a
              resolution family and the same outcome. A trajectory detail can
              still differ.
            </Typography>
            <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
              <Chip size="small" label="inconclusive" /> the cards do not name
              the difference.
            </Typography>
          </Alert>
        </Collapse>
        <Stack direction="row" spacing={1} sx={{ mb: 2, flexWrap: "wrap", rowGap: 1 }}>
          {contrastParsed?.motive_contrast && (
            <Chip
              size="small"
              variant="outlined"
              label={`motive_contrast: ${String(contrastParsed.motive_contrast)}`}
            />
          )}
          {contrastParsed?.behavior_similarity && (
            <Chip
              size="small"
              color={
                String(contrastParsed.behavior_similarity) === "distinct" ? "success" : "default"
              }
              label={`Behavioral similarity: ${String(contrastParsed.behavior_similarity)}`}
            />
          )}
        </Stack>
        {Array.isArray(contrastParsed?.contrast_timeline) &&
          (contrastParsed.contrast_timeline as unknown[]).length > 0 && (
            <Box sx={{ mb: 2 }}>
              <Typography variant="caption" color="text.secondary" display="block" gutterBottom sx={CONTRAST_FIELD_LABEL_SX}>
                contrast_timeline
              </Typography>
              <Stack spacing={1}>
                {(contrastParsed.contrast_timeline as Array<Record<string, unknown>>).map(
                  (phase, i) => (
                    <Box
                      key={i}
                      sx={{ p: 1, bgcolor: "grey.50", borderRadius: 1, border: "1px solid", borderColor: "divider" }}
                    >
                      <Typography variant="caption" fontWeight={600} display="block">
                        t={String(phase.t_start ?? "?")}–{String(phase.t_end ?? "?")}
                        {phase.bev_frame ? ` · ${String(phase.bev_frame)}` : ""}
                      </Typography>
                      <Typography variant="body2" sx={{ whiteSpace: "pre-wrap", mt: 0.5 }}>
                        {String(phase.interpretation ?? "")}
                      </Typography>
                    </Box>
                  ),
                )}
              </Stack>
            </Box>
          )}
        {contrastParsed?.critical_divergence &&
          typeof contrastParsed.critical_divergence === "object" && (
          <Box sx={{ mb: 2 }}>
            <Stack direction="row" spacing={0.5} alignItems="center" sx={{ mb: 0.5 }}>
              <Typography variant="caption" color="text.secondary" sx={CONTRAST_FIELD_LABEL_SX}>
                critical_divergence
              </Typography>
              <IconButton
                size="small"
                aria-label={
                  showDivergenceHelp
                    ? "Hide critical_divergence explanation"
                    : "Explain critical_divergence"
                }
                onClick={() => setShowDivergenceHelp((open) => !open)}
              >
                {showDivergenceHelp ? <Close fontSize="inherit" /> : <HelpOutline fontSize="inherit" />}
              </IconButton>
            </Stack>
            <Collapse in={showDivergenceHelp}>
              <Alert severity="info" sx={{ mb: 1, py: 0.5 }}>
                <Typography variant="caption" component="div">
                  The earliest shared-clock time where a geometry difference
                  lasts. Lasting means who is ahead, the minimum distance
                  between vehicle boundaries, or the longitudinal relationship
                  stays different on later stamps. A single speed sample, or a
                  brake that starts slightly earlier, counts only when that
                  clearance also splits and stays split. <code>at</code> is
                  that time. The line under it is the measured difference.
                </Typography>
              </Alert>
            </Collapse>
            <Typography variant="body2" color="text.secondary" sx={{ fontSize: 15, lineHeight: 2.5 }}>
              at time =
              {String(
                (contrastParsed.critical_divergence as Record<string, unknown>).at ?? "?",
              )}
            </Typography>
            {(() => {
              const cd = contrastParsed.critical_divergence as Record<string, unknown>;
              const metricDelta = String(
                cd.metric_delta ?? cd.description ?? "",
              ).trim();
              if (!metricDelta) return null;
              return (
                <Typography variant="body2" sx={{ ...CONTRAST_FIELD_BODY_SX, mt: 0.5 }}>
                  {metricDelta}
                </Typography>
              );
            })()}
          </Box>
        )}
        {contrastParsed?.contrast_explanation && (
          <Box sx={{ mb: 2 }}>
            <Typography
              variant="caption"
              color="text.secondary"
              display="block"
              gutterBottom
              sx={CONTRAST_FIELD_LABEL_SX}
            >
              contrast_explanation
            </Typography>
            <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
              {String(contrastParsed.contrast_explanation)}
            </Typography>
          </Box>
        )}
        {contrastParsed?.behavior_similarity_reason && (
          <Box sx={{ mb: 2 }}>
            <Stack direction="row" spacing={0.5} alignItems="center" sx={{ mb: 0.5 }}>
              <Typography variant="caption" color="text.secondary" sx={CONTRAST_FIELD_LABEL_SX}>
                Separation reason
              </Typography>
              <IconButton
                size="small"
                aria-label={
                  showReasonHelp ? "Hide separation reason explanation" : "Explain separation reason"
                }
                onClick={() => setShowReasonHelp((open) => !open)}
              >
                {showReasonHelp ? <Close fontSize="inherit" /> : <HelpOutline fontSize="inherit" />}
              </IconButton>
            </Stack>
            <Collapse in={showReasonHelp}>
              <Alert severity="info" sx={{ mb: 1, py: 0.5 }}>
                <Typography variant="caption" component="div">
                  The one-line reason for Behavioral similarity on these two
                  boundary trials. The trajectory clustering already placed
                  them in different clusters. This line states how their
                  behavior differs. <code>distinct</code> names a resolution
                  family, an outcome, or a clearance that stays different.{" "}
                  <code>similar</code> names a small late clearance or a
                  whole-trajectory detail that remains. The report column
                  Separation reason is this same field (
                  <code>behavior_similarity_reason</code>).
                </Typography>
              </Alert>
            </Collapse>
            <Typography variant="body2" sx={CONTRAST_FIELD_BODY_SX}>
              {String(contrastParsed.behavior_similarity_reason)}
            </Typography>
          </Box>
        )}
        {pair?.yaml ? (
          <Accordion disableGutters elevation={0} variant="outlined">
            <AccordionSummary expandIcon={<ExpandMore />}>
              <Typography variant="subtitle2" sx={{ fontSize: 15, fontWeight: 700 }}>Raw contrast.yaml</Typography>
            </AccordionSummary>
            <AccordionDetails>
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
                {pair.yaml}
              </Box>
            </AccordionDetails>
          </Accordion>
        ) : (
          <Alert severity="info">
            No <code>output/contrast.yaml</code> yet for this pack — select it above and run
            Parameter-space pair analysis.
          </Alert>
        )}
      </Paper>
    </Stack>
  );
}
