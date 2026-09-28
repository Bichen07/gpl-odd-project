"use client";

import {
  Alert,
  Box,
  Collapse,
  Divider,
  IconButton,
  Paper,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Tooltip,
  Typography,
} from "@mui/material";
import { Close, HelpOutline } from "@mui/icons-material";
import { useState, type ReactNode } from "react";
import type { ClusteringQuality } from "../types";
import { fmtNum } from "../utils";

const BEHAVIOR_ROWS: Array<{ key: string; label: string; help: string }> = [
  {
    key: "outcome_purity",
    label: "Outcome purity",
    help: "Share of clusters that are almost all safe or almost all collisions.",
  },
  {
    key: "motive_distinctness",
    label: "Title distinctness",
    help: "Unique summary titles divided by clusters that have a title.",
  },
];

const GEOMETRY_ROWS: Array<{
  key: string;
  label: string;
  weight: number;
  help: string;
}> = [
  {
    key: "silhouette_score",
    label: "Silhouette",
    weight: 0.2941,
    help: "How separated the trajectories are. The file stores this on −1 to 1; the row is that value shifted onto 0–1.",
  },
  {
    key: "collision_spread_score",
    label: "Collision-rate spread",
    weight: 0.2353,
    help: "How uneven the clusters' collision rates are.",
  },
  {
    key: "ttc_spread_score",
    label: "Time-to-collision spread",
    weight: 0.1765,
    help: "How uneven each cluster's mean time-to-collision is.",
  },
  {
    key: "intra_consistency_score",
    label: "Tightness",
    weight: 0.2941,
    help: "How close each cluster's trials sit to its center in the projection.",
  },
];

function scoreText(value: unknown, digits = 1): string {
  return typeof value === "number" && Number.isFinite(value) ? value.toFixed(digits) : "n/a";
}

function ScoreCard({
  title,
  value,
  caption,
  children,
}: {
  title: string;
  value: string;
  caption: string;
  children?: ReactNode;
}) {
  return (
    <Box
      sx={{
        flex: 1,
        minWidth: 260,
        p: 1.5,
        border: 1,
        borderColor: "divider",
        borderRadius: 1,
      }}
    >
      <Typography variant="overline" color="text.secondary">
        {title}
      </Typography>
      <Typography variant="h4" sx={{ lineHeight: 1.1 }}>
        {value}
      </Typography>
      <Typography variant="caption" color="text.secondary" display="block" sx={{ mt: 0.5, mb: 1.5 }}>
        {caption}
      </Typography>
      {children}
    </Box>
  );
}

export default function SelectionQualityPanel({
  selectionEval,
  crossEval,
  quality,
  evalConfigs,
  currentFolder,
}: {
  selectionEval: Record<string, unknown> | null;
  crossEval: Record<string, unknown> | null;
  quality: Record<string, unknown> | null;
  evalConfigs: ClusteringQuality[];
  currentFolder: string;
}) {
  const sel = (selectionEval ?? null) as Record<string, any> | null;
  const cross = (crossEval ?? null) as Record<string, any> | null;
  const qual = (quality ?? null) as Record<string, any> | null;
  const sub = (qual?.sub_scores ?? {}) as Record<string, number | null>;
  const components = (sel?.components ?? {}) as Record<string, number | null>;
  const weights = (sel?.weights ?? {}) as Record<string, number>;
  const findings = (sel?.findings ?? []) as string[];
  const crossIsStub = cross?.stub === true;
  const [showHelp, setShowHelp] = useState(false);
  const rawSilhouette = sub.silhouette_raw;

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Stack direction="row" alignItems="center" spacing={0.5}>
        <Typography variant="h6">Is this cluster selection good?</Typography>
        <Tooltip title="Explain the quality scores">
          <IconButton
            size="small"
            aria-label="Explain the quality scores"
            onClick={() => setShowHelp((value) => !value)}
          >
            <HelpOutline fontSize="small" />
          </IconButton>
        </Tooltip>
      </Stack>

      <Stack direction="row" alignItems="baseline" spacing={1} sx={{ mt: 1 }}>
        <Typography variant="h3" sx={{ lineHeight: 1 }}>
          {scoreText(qual?.final_score)}
        </Typography>
        <Typography variant="subtitle1" color="text.secondary">
          composite
        </Typography>
      </Stack>
      <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5, mb: 2 }}>
        60% geometry and 40% language-model ratings. Behavior is reported beside
        them and is not in this number. The tab label shows this composite.
      </Typography>

      <Collapse in={showHelp}>
        <Alert
          severity="info"
          sx={{ mb: 2 }}
          action={
            <IconButton
              size="small"
              aria-label="Close quality score explanation"
              onClick={() => setShowHelp(false)}
            >
              <Close fontSize="small" />
            </IconButton>
          }
        >
          <Typography variant="body2">
            Silhouette is one piece of geometry, not a second total. The file
            stores it from −1 to 1. Geometry uses that value after adding 1 and
            dividing by 2, then mixes it with collision-rate spread,
            time-to-collision spread, and tightness.
          </Typography>
          <Typography variant="body2" sx={{ mt: 1 }}>
            The language-model half is the average of separation and boundary
            clarity, each 1–10, multiplied by 10. Ratings of 5 and 5 become 50.
            Without those ratings, the composite stays equal to geometry.
          </Typography>
          <Typography variant="body2" sx={{ mt: 1 }}>
            Behavior is the average of outcome purity and title distinctness.
            It does not call the language model, and the composite leaves it out.
          </Typography>
        </Alert>
      </Collapse>

      <Stack direction={{ xs: "column", md: "row" }} spacing={2} alignItems="stretch">
        <ScoreCard
          title="Geometry"
          value={scoreText(qual?.rule_score)}
          caption="60% of the composite"
        >
          {GEOMETRY_ROWS.map((row) => (
            <Box key={row.key} sx={{ mb: 1 }}>
              <Stack direction="row" justifyContent="space-between" spacing={1}>
                <Typography variant="body2">{row.label}</Typography>
                <Typography variant="body2">
                  {fmtNum(sub[row.key], 3)}
                  <Typography component="span" variant="caption" color="text.secondary">
                    {" "}
                    × {row.weight.toFixed(2)}
                  </Typography>
                </Typography>
              </Stack>
              <Typography variant="caption" color="text.secondary">
                {row.help}
              </Typography>
            </Box>
          ))}
          {typeof rawSilhouette === "number" && (
            <Typography variant="caption" color="text.secondary" display="block" sx={{ mt: 0.5 }}>
              Silhouette in the file is {rawSilhouette.toFixed(4)} on a −1 to 1 scale.
            </Typography>
          )}
        </ScoreCard>

        <ScoreCard
          title="Language model"
          value={scoreText(qual?.llm_score)}
          caption="40% of the composite"
        >
          <Typography variant="body2">
            Separation {cross?.behavioral_separation_score ?? "n/a"}/10
          </Typography>
          <Typography variant="body2" sx={{ mb: 1 }}>
            Boundary clarity {cross?.boundary_clarity_score ?? "n/a"}/10
          </Typography>
          <Typography variant="caption" color="text.secondary">
            Separation asks whether the clusters describe different driving
            strategies. Clarity asks whether the written cards and
            matched-parameter pairs keep those boundaries readable.
          </Typography>
        </ScoreCard>

        <ScoreCard
          title="Behavior"
          value={scoreText(sel?.selection_score)}
          caption="Not in the composite"
        >
          {!sel && (
            <Typography variant="caption" color="text.secondary">
              Filled when this clustering is evaluated. These checks do not use
              the language model.
            </Typography>
          )}
          {BEHAVIOR_ROWS.map((row) => (
            <Box key={row.key} sx={{ mb: 1 }}>
              <Stack direction="row" justifyContent="space-between" spacing={1}>
                <Typography variant="body2">{row.label}</Typography>
                <Typography variant="body2">
                  {components[row.key] == null ? "n/a" : fmtNum(components[row.key], 3)}
                  {weights[row.key] != null && (
                    <Typography component="span" variant="caption" color="text.secondary">
                      {" "}
                      × {fmtNum(weights[row.key], 2)}
                    </Typography>
                  )}
                </Typography>
              </Stack>
              <Typography variant="caption" color="text.secondary">
                {row.help}
              </Typography>
            </Box>
          ))}
        </ScoreCard>
      </Stack>

      {findings.length > 0 && (
        <Stack spacing={0.5} sx={{ mt: 2 }}>
          {findings.map((finding, i) => (
            <Typography key={i} variant="body2">
              • {finding}
            </Typography>
          ))}
        </Stack>
      )}

      {(sel?.merge_candidates ?? []).length > 0 && (
        <Alert severity="warning" sx={{ mt: 2 }}>
          <Typography variant="body2" fontWeight="bold">
            Behavior merge candidates
          </Typography>
          {(sel.merge_candidates as Array<Record<string, any>>).map((m, i) => (
            <Typography key={i} variant="caption" display="block">
              cluster{m.clusters?.[0]} + cluster{m.clusters?.[1]} — shared label{" "}
              {m.shared_motive}, param overlap {m.param_overlap}
            </Typography>
          ))}
        </Alert>
      )}

      <Divider sx={{ my: 2 }} />

      <Typography variant="subtitle1" gutterBottom>
        Language-model reading
      </Typography>
      {!cross || crossIsStub ? (
        <Alert severity="info">
          {crossIsStub
            ? `Stub only — ${String(cross?.inter_notes ?? "no LLM run yet")}.`
            : "No cross-cluster reading yet. Run the evaluation above."}
        </Alert>
      ) : (
        <Stack spacing={1}>
          {cross.inter_notes && (
            <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
              {String(cross.inter_notes)}
            </Typography>
          )}
          {cross.selection_verdict && (
            <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
              {String(cross.selection_verdict)}
            </Typography>
          )}
          {cross.recommended_action && (
            <Typography variant="body2">
              <strong>Recommended action:</strong> {String(cross.recommended_action)}
              {cross.recommended_action_detail
                ? ` — ${String(cross.recommended_action_detail)}`
                : ""}
            </Typography>
          )}
          {Array.isArray(cross.merge_candidates) && cross.merge_candidates.length > 0 && (
            <Alert severity="warning">
              <Typography variant="body2" fontWeight="bold">
                Merge candidates
              </Typography>
              {cross.merge_candidates.map((item: unknown, i: number) => (
                <Typography key={i} variant="caption" display="block">
                  {String(item)}
                </Typography>
              ))}
            </Alert>
          )}
          {Array.isArray(cross.split_candidates) && cross.split_candidates.length > 0 && (
            <Alert severity="info">
              <Typography variant="body2" fontWeight="bold">
                Split candidates
              </Typography>
              {cross.split_candidates.map((item: unknown, i: number) => (
                <Typography key={i} variant="caption" display="block">
                  {String(item)}
                </Typography>
              ))}
            </Alert>
          )}
        </Stack>
      )}

      {evalConfigs.length > 0 && (
        <>
          <Divider sx={{ my: 2 }} />
          <Typography variant="subtitle1">Other clusterings of this batch</Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
            Each row is a different clustering, not one cluster inside this run.
            Silhouette is inside Geometry, so it is not a separate column.
          </Typography>
          <Table size="small">
            <TableHead>
              <TableRow>
                <TableCell>Rank</TableCell>
                <TableCell>Config</TableCell>
                <TableCell align="right">k</TableCell>
                <TableCell align="right">Geometry</TableCell>
                <TableCell align="right">Language model</TableCell>
                <TableCell align="right">Composite</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {evalConfigs.map((row) => (
                <TableRow
                  key={row.folder}
                  sx={{
                    bgcolor: row.folder === currentFolder ? "action.selected" : undefined,
                  }}
                >
                  <TableCell>
                    <strong>#{row.rank ?? "—"}</strong>
                  </TableCell>
                  <TableCell sx={{ fontFamily: "monospace", fontSize: 12 }}>
                    {row.folder}
                  </TableCell>
                  <TableCell align="right">{row.k ?? "—"}</TableCell>
                  <TableCell align="right">{row.rule_score?.toFixed(1)}</TableCell>
                  <TableCell align="right">
                    {row.llm_score != null ? row.llm_score.toFixed(1) : "—"}
                  </TableCell>
                  <TableCell align="right">
                    <strong>{row.final_score?.toFixed(1)}</strong>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </>
      )}
    </Paper>
  );
}
