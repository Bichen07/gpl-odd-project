"use client";

import {
  Box,
  Divider,
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
import TitleWithHelp from "../../components/TitleWithHelp";
import { fmtNum } from "../../utils";

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
    help: "How separated the trajectories are. The file stores s on −1 to 1; this row is (s + 1) / 2.",
  },
  {
    key: "collision_spread_score",
    label: "Collision-rate spread",
    weight: 0.25,
    help: "Standard deviation of the clusters' collision rates ÷ 50 percentage points, capped at 1.",
  },
  {
    key: "ttc_spread_score",
    label: "Time-to-collision spread",
    weight: 0.25,
    help: "Standard deviation of each cluster's mean time-to-collision ÷ 3 s, capped at 1.",
  },
  {
    key: "intra_consistency_score",
    label: "Tightness",
    weight: 0.25,
    help: "Per cluster: 1 − (its spread around the medoid ÷ the largest cluster spread), then averaged. Relative: the loosest cluster always scores 0.",
  },
];

function scoreText(value: unknown, digits = 1): string {
  return typeof value === "number" && Number.isFinite(value) ? value.toFixed(digits) : "n/a";
}

export type ClusteringScoreProps = {
  config: Config;
  splitAnalysis: SplitAnalysis | null;
  evalConfigs: ClusteringQuality[];
};

export default function ClusteringScore({
  config,
  splitAnalysis,
  evalConfigs,
}: ClusteringScoreProps) {
  const quality = (splitAnalysis?.quality ?? null) as Record<string, any> | null;
  const sub = (quality?.sub_scores ?? {}) as Record<string, number | null>;
  const rawSilhouette = sub.silhouette_raw;

  return (
    <Stack spacing={2}>
      <Paper variant="outlined" sx={{ p: 2 }}>
        <TitleWithHelp
          title="Clustering score"
          variant="h6"
          help={
            <>
              <Typography variant="body2">
                The geometry score of the clustering you have open. The tab label
                shows the same number. It does not use the language model and it
                does not change the clusters.
              </Typography>
              <Typography variant="body2" sx={{ mt: 1 }}>
                Silhouette is one piece of it, not a second total. Geometry
                mixes silhouette with collision-rate spread, time-to-collision
                spread, and tightness, each weighted 0.25.
              </Typography>
              {GEOMETRY_ROWS.map((row) => (
                <Typography key={row.key} variant="body2" sx={{ mt: 1 }}>
                  <strong>{row.label}</strong> — {row.help}
                </Typography>
              ))}
              <Typography variant="body2" sx={{ mt: 1 }}>
                What the clusters do and how they differ is on the Cluster
                analysis and Report tabs.
              </Typography>
            </>
          }
        />

        <Stack direction="row" alignItems="baseline" spacing={1} sx={{ mb: 2 }}>
          <Typography variant="h3" sx={{ lineHeight: 1 }}>
            {scoreText(quality?.score)}
          </Typography>
          <Typography variant="subtitle1" color="text.secondary">
            geometry
          </Typography>
        </Stack>

        <Box sx={{ maxWidth: 420 }}>
          {GEOMETRY_ROWS.map((row) => (
            <Stack
              key={row.key}
              direction="row"
              justifyContent="space-between"
              spacing={1}
              sx={{ mb: 0.5 }}
            >
              <Typography variant="body2">{row.label}</Typography>
              <Typography variant="body2">
                {fmtNum(sub[row.key], 3)}
                <Typography component="span" variant="caption" color="text.secondary">
                  {" "}
                  × {row.weight.toFixed(2)}
                </Typography>
              </Typography>
            </Stack>
          ))}
          {typeof rawSilhouette === "number" && (
            <Typography variant="caption" color="text.secondary" display="block" sx={{ mt: 1 }}>
              Silhouette in the file is {rawSilhouette.toFixed(4)} on a −1 to 1 scale.
            </Typography>
          )}
        </Box>

        {evalConfigs.length > 0 && (
          <>
            <Divider sx={{ my: 2 }} />
            <TitleWithHelp
              title="Other clusterings of this batch"
              variant="subtitle1"
              help={
                <Typography variant="body2">
                  Each row is a different clustering, not one cluster inside this run.
                  Silhouette is inside Geometry, so it is not a separate column.
                </Typography>
              }
            />
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>Rank</TableCell>
                  <TableCell>Config</TableCell>
                  <TableCell align="right">k</TableCell>
                  <TableCell align="right">Geometry</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {evalConfigs.map((row) => (
                  <TableRow
                    key={row.folder}
                    sx={{
                      bgcolor: row.folder === config.folder ? "action.selected" : undefined,
                    }}
                  >
                    <TableCell>
                      <strong>#{row.rank ?? "—"}</strong>
                    </TableCell>
                    <TableCell sx={{ fontFamily: "monospace", fontSize: 12 }}>
                      {row.folder}
                    </TableCell>
                    <TableCell align="right">{row.k ?? "—"}</TableCell>
                    <TableCell align="right">{row.score?.toFixed(1)}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </>
        )}
      </Paper>
    </Stack>
  );
}
