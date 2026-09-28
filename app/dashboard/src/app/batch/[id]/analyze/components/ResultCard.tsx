"use client";

import { useEffect, useMemo, useState } from "react";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Alert,
  Box,
  Button,
  Chip,
  Collapse,
  IconButton,
  Paper,
  Slider,
  Stack,
  Typography,
} from "@mui/material";
import { Close, ExpandMore, HelpOutline } from "@mui/icons-material";
import type { ResultEntry } from "../types";
import { agentInteractionRows, normalizeEgoSummary } from "../utils";

/**
 * Medoid analysis result card. Shows medoid_trial.yaml fields only —
 * not cluster_summary label/caption/risk (those belong on Cluster analysis).
 */
export default function ResultCard({
  r,
  onDownload,
}: {
  r: ResultEntry;
  onDownload: (cluster: number, raw: string) => void;
}) {
  const meta = (r.meta ?? {}) as Record<string, any>;
  const parsed = (meta.parsed ?? {}) as Record<string, any>;

  const motiveSummary =
    (typeof parsed.motive_summary === "string" && parsed.motive_summary) ||
    (typeof meta.behavior_description === "string" && meta.behavior_description) ||
    "";

  const events = useMemo(
    () =>
      normalizeEgoSummary(
        parsed.decision_timeline ?? meta.ego_perspective_summary,
      ),
    [parsed.decision_timeline, meta.ego_perspective_summary],
  );
  const timed = useMemo(
    () => events.filter((e) => e.t != null) as { t: number; text: string }[],
    [events],
  );
  const tMin = timed.length ? Math.min(...timed.map((e) => e.t)) : 0;
  const tMax = timed.length ? Math.max(...timed.map((e) => e.t)) : 0;
  const [scrub, setScrub] = useState(tMin);
  const [showSummaryHelp, setShowSummaryHelp] = useState(false);
  useEffect(() => setScrub(tMin), [tMin]);

  const activeEvent = useMemo(() => {
    let cur: { t: number; text: string } | null = null;
    for (const e of timed) {
      if (e.t <= scrub + 1e-6) cur = e;
      else break;
    }
    return cur ?? (timed.length ? timed[0] : null);
  }, [timed, scrub]);

  const trialId = parsed.trial_id ?? meta.trial_id;
  const outcome = parsed.outcome ?? meta.outcome;
  const conflictMetrics =
    (parsed.conflict_metrics as Record<string, unknown> | undefined) ??
    (meta.conflict_metrics as Record<string, unknown> | undefined) ??
    null;
  const conflictPartner = String(
    conflictMetrics?.vehicle ?? conflictMetrics?.partner ?? "",
  ).trim();
  const agentInteractions = agentInteractionRows(parsed);

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Stack direction="row" alignItems="center" spacing={1} sx={{ mb: 1 }} flexWrap="wrap">
        <Typography variant="h6" sx={{ flexGrow: 1 }}>
          Medoid of cluster {r.cluster}
          {trialId != null ? ` · ${String(trialId)}` : ""}
        </Typography>
        {outcome != null && (
          <Chip
            size="small"
            color={
              String(outcome).toLowerCase() === "collision"
                ? "error"
                : String(outcome).toLowerCase() === "safe"
                  ? "success"
                  : "default"
            }
            label={String(outcome)}
          />
        )}
        <Button size="small" onClick={() => onDownload(r.cluster, r.rawYaml)}>
          Download YAML
        </Button>
      </Stack>

      {agentInteractions.length > 0 && (
        <Box sx={{ mb: 1.5 }}>
          <Stack direction="row" spacing={0.5} alignItems="center" sx={{ mb: 0.5 }}>
            <Typography variant="caption" color="text.secondary" fontWeight={700}>
              Agent interactions
            </Typography>
            <IconButton
              size="small"
              aria-label={
                showSummaryHelp
                  ? "Hide medoid field meanings"
                  : "Show medoid field meanings"
              }
              onClick={() => setShowSummaryHelp((open) => !open)}
            >
              {showSummaryHelp ? (
                <Close fontSize="inherit" />
              ) : (
                <HelpOutline fontSize="inherit" />
              )}
            </IconButton>
          </Stack>
          <Collapse in={showSummaryHelp}>
            <Alert severity="info" sx={{ mb: 1.5, py: 0.5 }}>
              <Typography variant="caption" component="div">
                Each row is Ego vs <strong>that agent</strong>:{" "}
                <code>agent</code> and <code>resolution</code>. The first row
                is the pack partner
                {conflictPartner ? ` (${conflictPartner})` : ""}. Extra rows
                are other agents Ego actually responded to.
              </Typography>
              <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
                <strong>Resolution</strong> (go-through vs give-way vs that
                agent): <code>yield</code> — Ego decelerates or stops to give
                way and that agent is not behind (includes failed yield:
                FRONT–LEFT overlap while still braking).{" "}
                <code>pass_first</code> — that agent becomes behind, or Ego
                holds/increases speed into the gap, or releases the brake and
                continues. <code>unresolved</code> — neither state is clear.
                A name such as Late Yield is the cluster summary label, not
                this row.
              </Typography>
              <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
                The why is <code>motive_summary</code> (2–4 sentences) and the
                last clause of each timeline <code>description</code>.
              </Typography>
            </Alert>
          </Collapse>
          <Stack spacing={0.75}>
            {agentInteractions.map((row: Record<string, unknown>, i: number) => (
              <Stack
                key={`${String(row.agent)}-${i}`}
                direction="row"
                spacing={0.75}
                flexWrap="wrap"
                useFlexGap
                alignItems="center"
              >
                <Chip size="small" label={String(row.agent)} />
                {row.resolution != null && String(row.resolution).trim() !== "" && (
                  <Chip
                    size="small"
                    variant="outlined"
                    label={`resolution: ${String(row.resolution)}`}
                  />
                )}
                {row.control_response != null &&
                  String(row.control_response).trim() !== "" && (
                    <Chip
                      size="small"
                      variant="outlined"
                      label={`control: ${String(row.control_response)}`}
                    />
                  )}
                {row.motive != null && String(row.motive).trim() !== "" && (
                  <Chip
                    size="small"
                    variant="outlined"
                    label={`motive: ${String(row.motive)}`}
                  />
                )}
              </Stack>
            ))}
          </Stack>
        </Box>
      )}

      {motiveSummary && String(motiveSummary) !== "parse_failed" && (
        <Box sx={{ mb: 1.5 }}>
          <Typography variant="subtitle2" gutterBottom>
            motive_summary
          </Typography>
          <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
            {motiveSummary}
          </Typography>
        </Box>
      )}

      {timed.length > 0 && (
        <Box sx={{ mb: 1.5 }}>
          <Typography variant="subtitle2" gutterBottom>
            Decision timeline (scrub to replay)
          </Typography>
          <Box
            sx={{
              p: 1.25,
              mb: 1,
              minHeight: 52,
              borderRadius: 1,
              bgcolor: "primary.main",
              color: "primary.contrastText",
            }}
          >
            <Typography variant="caption" sx={{ opacity: 0.85 }}>
              t = {activeEvent ? activeEvent.t.toFixed(2) : scrub.toFixed(2)} s
            </Typography>
            <Typography variant="body2">{activeEvent?.text ?? "—"}</Typography>
          </Box>
          <Slider
            size="small"
            min={tMin}
            max={tMax === tMin ? tMin + 1 : tMax}
            step={0.05}
            value={scrub}
            marks={timed.map((e) => ({ value: e.t }))}
            valueLabelDisplay="auto"
            valueLabelFormat={(v) => `${Number(v).toFixed(1)}s`}
            onChange={(_, v) => setScrub(v as number)}
          />
          <Stack spacing={0.25} sx={{ mt: 0.5 }}>
            {timed.map((e, i) => {
              const isActive =
                activeEvent != null && e.t === activeEvent.t && e.text === activeEvent.text;
              return (
                <Typography
                  key={`${e.t}-${i}`}
                  variant="caption"
                  onClick={() => setScrub(e.t)}
                  sx={{
                    cursor: "pointer",
                    px: 0.5,
                    borderRadius: 0.5,
                    bgcolor: isActive ? "action.selected" : "transparent",
                    fontWeight: isActive ? 700 : 400,
                  }}
                >
                  <strong>t={e.t.toFixed(2)}s</strong> — {e.text}
                </Typography>
              );
            })}
          </Stack>
        </Box>
      )}

      <Accordion disableGutters elevation={0} square>
        <AccordionSummary expandIcon={<ExpandMore />}>
          <Typography fontSize={13}>Raw medoid_trial.yaml</Typography>
        </AccordionSummary>
        <AccordionDetails>
          <Box
            component="pre"
            sx={{
              m: 0,
              p: 1.5,
              bgcolor: "action.hover",
              borderRadius: 1,
              fontSize: 12,
              overflowX: "auto",
              whiteSpace: "pre-wrap",
            }}
          >
            {r.rawYaml || "(empty)"}
          </Box>
        </AccordionDetails>
      </Accordion>
    </Paper>
  );
}
