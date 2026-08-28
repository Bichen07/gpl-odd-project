"use client";

import { useState } from "react";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Alert,
  Box,
  Button,
  Checkbox,
  Chip,
  Paper,
  Slider,
  Stack,
  Typography,
} from "@mui/material";
import { ExpandMore } from "@mui/icons-material";
import type { Dispatch, SetStateAction } from "react";
import type { ClusterEntry, ResultEntry, SplitClusterCard } from "../types";
import { snapshotLabel } from "../utils";
import ResultCard from "./ResultCard";

/**
 * One-medoid-at-a-time viewer (mirrors IcPairPanel):
 * - Default: all BEV selected; timeline scrubber shows one frame at a time
 * - Optional: "Select frames" opens the checkbox grid to drop frames and save tokens
 * Each cluster keeps its own frame index, pick-mode flag, limit, and selection.
 */
export default function MedoidPanel({
  clusters,
  selected,
  setSelected,
  perClusterMax,
  setPerClusterMax,
  applyAuto,
  toggleImage,
  imgUrl,
  analyzedClusters,
  results,
  downloadYaml,
  splitClusters = [],
}: {
  clusters: ClusterEntry[];
  selected: Record<number, string[]>;
  setSelected: Dispatch<SetStateAction<Record<number, string[]>>>;
  /** Per cluster — 0 means all snapshots. */
  perClusterMax: Record<number, number>;
  setPerClusterMax: Dispatch<SetStateAction<Record<number, number>>>;
  applyAuto: (
    cluster: number,
    snapshots: string[],
    medoid?: Record<string, unknown> | null,
  ) => void;
  toggleImage: (cluster: number, file: string) => void;
  imgUrl: (cluster: number, file: string) => string;
  analyzedClusters: Set<number>;
  results: ResultEntry[];
  downloadYaml: (cluster: number, raw: string) => void;
  splitClusters?: SplitClusterCard[];
}) {
  const [idx, setIdx] = useState(0);
  /** Scrubber position per cluster (pair-style timeline). */
  const [frameByCluster, setFrameByCluster] = useState<Record<number, number>>({});
  /** When true for a cluster, show the multi-select grid to thin BEV inputs. */
  const [pickModeByCluster, setPickModeByCluster] = useState<Record<number, boolean>>({});

  const c = clusters[Math.min(idx, Math.max(0, clusters.length - 1))] ?? null;
  const limit = c != null ? (perClusterMax[c.cluster] ?? 0) : 0;
  const pickMode = c != null ? Boolean(pickModeByCluster[c.cluster]) : false;
  const frames = c?.snapshots ?? [];
  const frame = c != null ? frameByCluster[c.cluster] ?? 0 : 0;
  const frameIdx = frames.length ? Math.min(frame, frames.length - 1) : 0;
  const shown = frames[frameIdx] ?? null;
  const split =
    c != null
      ? splitClusters.find((sc) => sc.cluster === c.cluster) ?? null
      : null;
  const result = c != null ? results.find((r) => r.cluster === c.cluster) : null;
  const sel = new Set(c ? selected[c.cluster] ?? [] : []);
  const collisionRate = (c?.stats as { collision_rate?: unknown } | null)?.collision_rate;
  const nTrials =
    (c?.stats as { n_trials?: unknown; size?: unknown } | null)?.n_trials ??
    (c?.stats as { size?: unknown } | null)?.size;
  const medoidTrial = (c?.medoid as { trial_id?: unknown } | null)?.trial_id;
  const contextText =
    c?.contextMedoid ||
    split?.contextMedoid ||
    "";

  if (clusters.length === 0) {
    return (
      <Alert severity="info">
        No clusters in this run folder. Build / select a clustering result first.
      </Alert>
    );
  }

  return (
    <Stack spacing={2}>
      <Paper variant="outlined" sx={{ p: 2 }}>
        <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 2 }}>
          {clusters.map((cl, i) => {
            const hasCard =
              analyzedClusters.has(cl.cluster) ||
              Boolean(
                splitClusters.find((sc) => sc.cluster === cl.cluster)?.medoidYaml,
              );
            return (
              <Chip
                key={cl.cluster}
                label={`c${cl.cluster}${hasCard ? " ✓" : ""}`}
                color={i === idx ? "primary" : "default"}
                variant={hasCard ? "filled" : "outlined"}
                onClick={() => setIdx(i)}
                size="small"
              />
            );
          })}
        </Stack>
        <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
          Showing one medoid at a time. Default: all BEV sent to the LLM. Use the timeline to
          inspect frames; open <strong>Select frames</strong> only if you want fewer images
          (lower token cost).
        </Typography>

        {c && (
          <Stack direction="row" alignItems="center" spacing={1} flexWrap="wrap" sx={{ mb: 1 }}>
            <Typography fontWeight={600}>Cluster {c.cluster}</Typography>
            {collisionRate != null && (
              <Chip
                size="small"
                color={Number(collisionRate) > 0 ? "error" : "default"}
                label={`collision ${collisionRate}%`}
              />
            )}
            {nTrials != null && <Chip size="small" label={`${nTrials} trials`} />}
            {medoidTrial != null && (
              <Chip size="small" variant="outlined" label={`medoid ${medoidTrial}`} />
            )}
            {analyzedClusters.has(c.cluster) && (
              <Chip size="small" color="success" variant="outlined" label="analyzed" />
            )}
            <Box sx={{ flexGrow: 1 }} />
            <Typography variant="caption" color="text.secondary">
              {sel.size}/{frames.length} frames for LLM
            </Typography>
            <Button
              size="small"
              variant={pickMode ? "contained" : "outlined"}
              onClick={() =>
                setPickModeByCluster((p) => ({
                  ...p,
                  [c.cluster]: !p[c.cluster],
                }))
              }
            >
              {pickMode ? "Done selecting" : "Select frames (save tokens)"}
            </Button>
          </Stack>
        )}
      </Paper>

      {c && frames.length > 0 && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Typography variant="subtitle2" gutterBottom>
            Medoid BEV timeline
          </Typography>
          <Slider
            size="small"
            min={0}
            max={Math.max(frames.length - 1, 0)}
            step={1}
            value={frameIdx}
            onChange={(_, v) =>
              setFrameByCluster((p) => ({ ...p, [c.cluster]: v as number }))
            }
            marks
          />
          <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
            frame {frameIdx + 1} / {frames.length}
            {shown ? ` — ${snapshotLabel(shown)} (${shown})` : ""}
            {shown && sel.has(shown) ? " · included in LLM" : shown ? " · excluded from LLM" : ""}
          </Typography>
          {shown && (
            <Box
              component="img"
              src={imgUrl(c.cluster, shown)}
              alt={shown}
              sx={{
                width: "100%",
                borderRadius: 1,
                border: "2px solid",
                borderColor: sel.has(shown) ? "primary.main" : "divider",
                opacity: sel.has(shown) ? 1 : 0.55,
              }}
            />
          )}
          {pickMode && shown && (
            <Stack direction="row" spacing={1} sx={{ mt: 1 }} flexWrap="wrap">
              <Button
                size="small"
                variant="outlined"
                onClick={() => toggleImage(c.cluster, shown)}
              >
                {sel.has(shown) ? "Exclude this frame" : "Include this frame"}
              </Button>
            </Stack>
          )}
        </Paper>
      )}

      {c && pickMode && (
        <Paper variant="outlined" sx={{ p: 2 }}>
          <Stack direction="row" alignItems="center" spacing={1} flexWrap="wrap" sx={{ mb: 1 }}>
            <Typography variant="subtitle2" sx={{ flexGrow: 1 }}>
              Choose frames for LLM (fewer = lower token cost)
            </Typography>
            <Button size="small" onClick={() => applyAuto(c.cluster, c.snapshots, c.medoid)}>
              Apply limit
            </Button>
            <Button
              size="small"
              onClick={() => {
                setPerClusterMax((p) => ({ ...p, [c.cluster]: 0 }));
                setSelected((p) => ({ ...p, [c.cluster]: [...c.snapshots] }));
              }}
            >
              All
            </Button>
            <Button
              size="small"
              onClick={() => setSelected((p) => ({ ...p, [c.cluster]: [] }))}
            >
              None
            </Button>
          </Stack>

          <Stack direction="row" alignItems="center" spacing={1} sx={{ mb: 1, px: 0.5 }}>
            <Typography variant="caption" sx={{ minWidth: 80 }}>
              BEV limit:
            </Typography>
            <Slider
              size="small"
              min={0}
              max={Math.max(c.snapshots.length, 1)}
              value={limit}
              onChange={(_, v) =>
                setPerClusterMax((p) => ({ ...p, [c.cluster]: v as number }))
              }
              onChangeCommitted={() => applyAuto(c.cluster, c.snapshots, c.medoid)}
              valueLabelDisplay="auto"
              valueLabelFormat={(v) =>
                v === 0 ? `All (${c.snapshots.length})` : String(v)
              }
              sx={{ flex: 1 }}
            />
            <Typography variant="caption" color="text.secondary" sx={{ minWidth: 72 }}>
              {limit === 0 || limit >= c.snapshots.length
                ? `All (${c.snapshots.length})`
                : `${limit}/${c.snapshots.length}`}
            </Typography>
          </Stack>

          <Box
            sx={{
              display: "grid",
              gridTemplateColumns: "repeat(auto-fill, minmax(150px, 1fr))",
              gap: 1,
              maxHeight: 360,
              overflowY: "auto",
              p: 0.5,
            }}
          >
            {c.snapshots.map((file, i) => {
              const isSel = sel.has(file);
              const isCurrent = i === frameIdx;
              return (
                <Box
                  key={file}
                  onClick={() => setFrameByCluster((p) => ({ ...p, [c.cluster]: i }))}
                  sx={{
                    position: "relative",
                    cursor: "pointer",
                    border: "2px solid",
                    borderColor: isCurrent
                      ? "secondary.main"
                      : isSel
                        ? "primary.main"
                        : "transparent",
                    borderRadius: 1,
                    overflow: "hidden",
                    opacity: isSel ? 1 : 0.55,
                  }}
                >
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  <img
                    src={imgUrl(c.cluster, file)}
                    alt={file}
                    loading="lazy"
                    style={{ width: "100%", display: "block" }}
                  />
                  <Checkbox
                    size="small"
                    checked={isSel}
                    onClick={(e) => e.stopPropagation()}
                    onChange={() => toggleImage(c.cluster, file)}
                    sx={{ position: "absolute", top: 0, left: 0, p: 0.25 }}
                  />
                  <Typography
                    variant="caption"
                    sx={{
                      position: "absolute",
                      bottom: 0,
                      width: "100%",
                      bgcolor: "rgba(0,0,0,0.55)",
                      color: "#fff",
                      px: 0.5,
                    }}
                  >
                    {snapshotLabel(file)}
                  </Typography>
                </Box>
              );
            })}
          </Box>
        </Paper>
      )}

      {contextText ? (
        <Accordion disableGutters elevation={0} variant="outlined" defaultExpanded>
          <AccordionSummary expandIcon={<ExpandMore />}>
            <Typography variant="subtitle2">
              Process context (<code>processed/context_medoid.md</code>)
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
                maxHeight: 360,
                overflow: "auto",
                whiteSpace: "pre-wrap",
              }}
            >
              {contextText}
            </Box>
          </AccordionDetails>
        </Accordion>
      ) : (
        <Alert severity="info">
          No <code>context_medoid.md</code> for this cluster yet.
        </Alert>
      )}

      {result ? (
        <ResultCard r={result} onDownload={downloadYaml} />
      ) : (
        <Alert severity="info">
          No saved medoid card for cluster {c?.cluster}. Select it above and run analysis.
        </Alert>
      )}
    </Stack>
  );
}
