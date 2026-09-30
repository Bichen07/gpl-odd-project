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

const GEOMETRY_ROWS: Array<{
  key: string;
  label: string;
  weight: number;
  help: string;
}> = [
  {
    key: "silhouette_score",
    label: "Silhouette",
    weight: 0.25,
    help: "How separated the trajectories are. The file stores this on −1 to 1; the row is that value shifted onto 0–1.",
  },
  {
    key: "collision_spread_score",
    label: "Collision-rate spread",
    weight: 0.25,
    help: "How uneven the clusters' collision rates are.",
  },
  {
    key: "ttc_spread_score",
    label: "Time-to-collision spread",
    weight: 0.25,
    help: "How uneven each cluster's mean time-to-collision is.",
  },
  {
    key: "intra_consistency_score",
    label: "Tightness",
    weight: 0.25,
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
  const findings = (sel?.findings ?? []) as string[];
  const mergeCandidates = (sel?.merge_candidates ?? []) as Array<Record<string, any>>;
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
          geometry
        </Typography>
      </Stack>
      <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5, mb: 2 }}>
        This number is the geometry score from the clustering. The language-model
        reading explains what still differs between clusters and does not change
        this number. The tab label shows this score.
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
            The language-model ratings describe how clearly the behavior
            differences can be stated. They sit beside this score. They do not
            move it, and they do not change the number of clusters.
          </Typography>
        </Alert>
      </Collapse>

      <Stack direction={{ xs: "column", md: "row" }} spacing={2} alignItems="stretch">
        <ScoreCard
          title="Geometry"
          value={scoreText(qual?.rule_score)}
          caption="Clustering score"
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
          caption="Supplementary reading"
        >
          <Typography variant="body2">
            Behavior difference {cross?.behavioral_separation_score ?? "n/a"}/10
          </Typography>
          <Typography variant="body2" sx={{ mb: 1 }}>
            Boundary clarity {cross?.boundary_clarity_score ?? "n/a"}/10
          </Typography>
          <Typography variant="caption" color="text.secondary">
            Behavior difference rates how clearly the cluster stories differ.
            Boundary clarity rates how clearly the cards state that difference.
            Neither number is Behavioral similarity, and neither changes the
            clustering.
          </Typography>
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

      {mergeCandidates.length > 0 && (
        <Alert severity="warning" sx={{ mt: 2 }}>
          <Typography variant="body2" fontWeight="bold">
            Same-title clusters
          </Typography>
          {mergeCandidates.map((m, i) => (
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
          {Array.isArray(cross.cluster_differences) && cross.cluster_differences.length > 0 && (
            <Alert severity="info">
              <Typography variant="body2" fontWeight="bold">
                What still differs
              </Typography>
              {cross.cluster_differences.map((item: unknown, i: number) => {
                const row = (item ?? {}) as Record<string, unknown>;
                const clusters = Array.isArray(row.clusters) ? row.clusters.join(" and ") : "";
                const shared = row.shared ? ` Shared: ${String(row.shared)}` : "";
                const difference = row.difference ? ` Difference: ${String(row.difference)}` : "";
                return (
                  <Typography key={i} variant="caption" display="block">
                    {clusters ? `${clusters}.` : ""}
                    {shared}
                    {difference}
                    {!clusters && !shared && !difference ? String(item) : ""}
                  </Typography>
                );
              })}
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
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </>
      )}
    </Paper>
  );
}
