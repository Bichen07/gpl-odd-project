"use client";

import { useEffect, useMemo, useState } from "react";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Button,
  Chip,
  Paper,
  Slider,
  Stack,
  Typography,
} from "@mui/material";
import { ExpandMore } from "@mui/icons-material";
import type { ResultEntry } from "../types";
import { normalizeEgoSummary, stringifyValue } from "../utils";

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
  const tokens = meta.token_usage as Record<string, number> | undefined;

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
  useEffect(() => setScrub(tMin), [tMin]);

  const activeEvent = useMemo(() => {
    let cur: { t: number; text: string } | null = null;
    for (const e of timed) {
      if (e.t <= scrub + 1e-6) cur = e;
      else break;
    }
    return cur ?? (timed.length ? timed[0] : null);
  }, [timed, scrub]);

  const outcome = parsed.outcome ?? meta.outcome;
  const primaryMotive = parsed.primary_motive ?? meta.primary_motive;
  const interactionResolution =
    parsed.interaction_resolution ?? meta.interaction_resolution;
  const controlResponse = parsed.control_response ?? meta.control_response;
  const trialId = parsed.trial_id ?? meta.trial_id;
  const conflictMetrics =
    (parsed.conflict_metrics as Record<string, unknown> | undefined) ??
    (meta.conflict_metrics as Record<string, unknown> | undefined) ??
    null;

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Stack direction="row" alignItems="center" spacing={1} sx={{ mb: 1 }} flexWrap="wrap">
        <Typography variant="h6" sx={{ flexGrow: 1 }}>
          Medoid of cluster {r.cluster}
          {trialId != null ? ` · ${String(trialId)}` : ""}
        </Typography>
        {outcome != null && (
          <Chip size="small" label={`outcome: ${String(outcome)}`} />
        )}
        {interactionResolution != null && (
          <Chip
            size="small"
            variant="outlined"
            label={`interaction_resolution: ${String(interactionResolution)}`}
          />
        )}
        {primaryMotive != null && (
          <Chip
            size="small"
            color="primary"
            variant="outlined"
            label={`primary_motive: ${String(primaryMotive)}`}
          />
        )}
        {controlResponse != null && (
          <Chip
            size="small"
            variant="outlined"
            label={`control_response: ${String(controlResponse)}`}
          />
        )}
        {tokens?.Total != null && (
          <Chip size="small" variant="outlined" label={`${tokens.Total} tokens`} />
        )}
        <Button size="small" onClick={() => onDownload(r.cluster, r.rawYaml)}>
          Download YAML
        </Button>
      </Stack>

      {conflictMetrics && Object.keys(conflictMetrics).length > 0 && (
        <Stack direction="row" spacing={1} flexWrap="wrap" sx={{ mb: 1.5 }}>
          {Object.entries(conflictMetrics).map(([k, v]) => (
            <Chip
              key={k}
              size="small"
              variant="outlined"
              label={`${k}=${typeof v === "number" ? Number(v).toFixed(3) : stringifyValue(v)}`}
            />
          ))}
        </Stack>
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
