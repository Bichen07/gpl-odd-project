"use client";

import { useEffect, useState } from "react";
import {
  Box,
  Chip,
  CircularProgress,
  MenuItem,
  Paper,
  Select,
  Stack,
  Typography,
} from "@mui/material";
import type { BoundaryPair, CrossEvalData } from "../types";

export default function BoundaryComparePanel({
  batchId,
  folder,
  boundaryPairs,
  crossEval,
}: {
  batchId: string;
  folder: string;
  boundaryPairs: BoundaryPair[];
  crossEval?: CrossEvalData;
}) {
  const [selectedPairIdx, setSelectedPairIdx] = useState(0);
  const [descA, setDescA] = useState<string | null>(null);
  const [descB, setDescB] = useState<string | null>(null);
  const [loadingDesc, setLoadingDesc] = useState(false);

  const pair = boundaryPairs[selectedPairIdx];

  useEffect(() => {
    if (!pair) return;
    setLoadingDesc(true);
    // Fetch descriptions from the boundary sub-dirs via a lightweight text API
    const baseUrl = `/api/cluster-analyze?batchId=${batchId}&batchFolder=${folder}`;
    const fetchDesc = (side: "a" | "b") => {
      const clLabel = side === "a" ? pair.cluster_a : pair.cluster_b;
      const otherLabel = side === "a" ? pair.cluster_b : pair.cluster_a;
      const trialId = side === "a" ? pair.trial_a : pair.trial_b;
      return fetch(
        `${baseUrl}&boundaryDesc=1&cluster=${clLabel}&boundaryWith=${otherLabel}`
      )
        .then((r) => r.text())
        .catch(() => "(description not available)");
    };
    Promise.all([fetchDesc("a"), fetchDesc("b")]).then(([a, b]) => {
      setDescA(a || "(description not available)");
      setDescB(b || "(description not available)");
      setLoadingDesc(false);
    });
  }, [pair, batchId, folder]);

  if (!pair) return null;

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>Boundary Trial Comparison</Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
        Trials at the cluster boundary — similar initial conditions, potentially different outcomes.
      </Typography>

      {/* Pair selector */}
      <Select
        size="small"
        value={selectedPairIdx}
        onChange={(e) => setSelectedPairIdx(Number(e.target.value))}
        sx={{ mb: 2, minWidth: 280 }}
      >
        {boundaryPairs.map((bp, i) => (
          <MenuItem key={i} value={i}>
            {`C${bp.cluster_a} ↔ C${bp.cluster_b} — embedding dist ${bp.embedding_dist.toFixed(3)}`}
          </MenuItem>
        ))}
      </Select>

      {/* Outcome badges */}
      <Stack direction="row" spacing={1} sx={{ mb: 2 }}>
        <Chip
          label={`C${pair.cluster_a} trial ${pair.trial_a}${pair.collided_a ? " 💥 COLLISION" : " ✓ safe"}`}
          color={pair.collided_a ? "error" : "success"}
          size="small"
        />
        <Chip
          label={`C${pair.cluster_b} trial ${pair.trial_b}${pair.collided_b ? " 💥 COLLISION" : " ✓ safe"}`}
          color={pair.collided_b ? "error" : "success"}
          size="small"
        />
      </Stack>

      {/* Side-by-side description diff */}
      {loadingDesc ? (
        <CircularProgress size={24} />
      ) : (
        <Stack direction={{ xs: "column", md: "row" }} spacing={2}>
          <Box sx={{ flex: 1 }}>
            <Typography variant="subtitle2" gutterBottom>
              Cluster {pair.cluster_a} — trial {pair.trial_a}
            </Typography>
            <Box
              component="pre"
              sx={{
                p: 1, bgcolor: "background.paper", borderRadius: 1,
                border: "1px solid", borderColor: "divider",
                fontSize: 11, lineHeight: 1.5, whiteSpace: "pre-wrap",
                maxHeight: 320, overflowY: "auto",
              }}
            >
              {descA ?? "(loading…)"}
            </Box>
          </Box>
          <Box sx={{ flex: 1 }}>
            <Typography variant="subtitle2" gutterBottom>
              Cluster {pair.cluster_b} — trial {pair.trial_b}
            </Typography>
            <Box
              component="pre"
              sx={{
                p: 1, bgcolor: "background.paper", borderRadius: 1,
                border: "1px solid", borderColor: "divider",
                fontSize: 11, lineHeight: 1.5, whiteSpace: "pre-wrap",
                maxHeight: 320, overflowY: "auto",
              }}
            >
              {descB ?? "(loading…)"}
            </Box>
          </Box>
        </Stack>
      )}

      {/* LLM caption from cross_cluster_eval */}
      {crossEval?.inter_notes && (
        <Box sx={{ mt: 2 }}>
          <Typography variant="subtitle2">LLM Boundary Analysis:</Typography>
          <Typography variant="body2" color="text.secondary">
            {crossEval.inter_notes}
          </Typography>
        </Box>
      )}
    </Paper>
  );
}
