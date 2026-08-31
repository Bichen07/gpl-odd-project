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
import { normalizeEgoSummary } from "../utils";

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
  const keyFacts = [
    ["Resolution", interactionResolution],
    ["Primary motive", primaryMotive],
    ["Control response", controlResponse],
  ].filter(([, value]) => value != null && String(value).trim() !== "");
  const evidenceFacts = [
    ["Named vehicle", conflictMetrics?.partner],
    ["Peak time", conflictMetrics?.peak_t, "s"],
    ["Brake time", conflictMetrics?.brake_t, "s"],
    ["Distance", conflictMetrics?.d, "m"],
    ["TTC", conflictMetrics?.ttc, "s"],
  ].filter(([, value]) => value != null && String(value).trim() !== "");

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

      {keyFacts.length > 0 && (
        <>
          <Stack direction="row" spacing={0.5} alignItems="center" sx={{ mb: 0.5 }}>
            <Typography variant="caption" color="text.secondary" fontWeight={700}>
              Behavior summary
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
                This card describes the <strong>medoid trial</strong>, one
                representative journey for the cluster. Read the fields in
                order: <strong>resolution → control response → primary
                motive</strong>.
              </Typography>
              <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
                <strong>Resolution (WHO)</strong>: <code>yield</code> means Ego
                decelerates or stops to give way and the named vehicle is not
                behind Ego. It also includes a failed yield that reaches
                FRONT–LEFT overlap while Ego is still braking.{" "}
                <code>pass_first</code> means Ego goes through: the named
                vehicle becomes behind, or Ego holds/increases speed into the
                gap, or releases the brake and continues.{" "}
                <code>unresolved</code> means neither state is clear.
              </Typography>
              <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
                <strong>Control response (HOW)</strong>: how Ego managed speed,
                not who went first. <code>proactive</code> = early braking;{" "}
                <code>late</code> = braking near the conflict peak;{" "}
                <code>slowdown</code> = gradual deceleration; <code>stop</code>{" "}
                = deceleration to near-zero; <code>smooth</code> or{" "}
                <code>maintain</code> = little/no braking; <code>brake</code> ={" "}
                severe braking, often after a pass. Braking alone does not prove
                yield.
              </Typography>
              <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
                <strong>Primary motive (WHY)</strong>: the dominant closed
                motive code explaining Ego&apos;s behavior. For example,{" "}
                <code>late_reaction</code> is a late strong brake near peak;{" "}
                <code>assertive_gap_acceptance</code> is holding/increasing
                speed into a closing gap; <code>yield_to_vehicle</code> means
                giving way. The motive must agree with the resolution and
                control response.
              </Typography>
              <Typography variant="caption" component="div" sx={{ mt: 0.5 }}>
                <strong>Conflict evidence</strong>: the named vehicle is the
                vehicle analyzed; <code>peak time</code> is the closest-approach
                or collision timestamp; <code>brake time</code> is the onset of
                sustained Ego deceleration; <code>distance</code> is
                center-to-center distance, not boundary clearance; and{" "}
                <code>TTC</code> is a constant-rate estimate based on the
                current closing rate, not a guarantee that collision will occur.
              </Typography>
            </Alert>
          </Collapse>
          <Box
            sx={{
              display: "grid",
              gridTemplateColumns: "repeat(auto-fit, minmax(150px, 1fr))",
              gap: 1,
              mb: 1.5,
            }}
          >
            {keyFacts.map(([label, value]) => (
              <Box
                key={String(label)}
                sx={{ p: 1, bgcolor: "action.hover", borderRadius: 1, minWidth: 0 }}
              >
                <Typography variant="caption" color="text.secondary" display="block">
                  {label}
                </Typography>
                <Typography variant="body2" fontWeight={600} sx={{ overflowWrap: "anywhere" }}>
                  {String(value)}
                </Typography>
              </Box>
            ))}
          </Box>
        </>
      )}

      {evidenceFacts.length > 0 && (
        <Box sx={{ mb: 1.5 }}>
          <Typography variant="caption" color="text.secondary" display="block" gutterBottom>
            Conflict evidence
          </Typography>
          <Stack direction="row" spacing={0.75} flexWrap="wrap" useFlexGap>
            {evidenceFacts.map(([label, value, unit]) => (
              <Chip
                key={String(label)}
                size="small"
                variant="outlined"
                label={`${label}: ${
                  typeof value === "number" ? Number(value).toFixed(3) : String(value)
                }${unit ? ` ${unit}` : ""}`}
              />
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
