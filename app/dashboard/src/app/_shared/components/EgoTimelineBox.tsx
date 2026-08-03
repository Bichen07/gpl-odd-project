"use client";

import { Box, Typography } from "@mui/material";
import { getActiveEventAtTime, getTimedEvents } from "@/app/_shared/utils/egoTimeline";

export default function EgoTimelineBox({
  summary,
  timeSec,
  title = "Ego analysis",
  compact = false,
  variant = "primary",
  borderColor,
  velocityMps = null,
  accelMps2 = null,
}: {
  summary: unknown;
  timeSec: number;
  title?: string;
  compact?: boolean;
  variant?: "primary" | "chat" | "overlay";
  borderColor?: string;
  /** Ego speed at playhead (m/s); shown from t=0. */
  velocityMps?: number | null;
  /** Ego accel at playhead (m/s²), smoothed; shown from t=0. */
  accelMps2?: number | null;
}) {
  const timed = getTimedEvents(summary);
  const active = getActiveEventAtTime(timed, timeSec);

  // Show from t=0 when mounted (medoid highlight). Event text only after its time.
  const hasKinematics = velocityMps != null || accelMps2 != null;
  if (timed.length === 0 && !hasKinematics) return null;

  const isChat = variant === "chat";
  const isOverlay = variant === "overlay";

  const fmt = (v: number | null | undefined, digits = 2) =>
    v == null || !Number.isFinite(v) ? "—" : v.toFixed(digits);

  return (
    <Box
      sx={{
        p: compact ? 1 : 1.25,
        borderRadius: 1,
        bgcolor: isOverlay ? "transparent" : isChat ? "#fff" : "primary.main",
        color: isOverlay
          ? "common.white"
          : isChat
            ? "#000"
            : "primary.contrastText",
        border:
          isOverlay
            ? "none"
            : isChat
              ? `3px solid ${borderColor ?? "#888"}`
              : "none",
        maxWidth: isChat || isOverlay ? "100%" : compact ? 360 : "100%",
        minWidth: isChat || isOverlay ? 160 : undefined,
        width: isChat || isOverlay ? "100%" : undefined,
        boxShadow: isChat ? 1 : "none",
        textShadow: isOverlay ? "0 1px 3px rgba(0,0,0,0.8)" : "none",
      }}
    >
      <Typography
        variant="caption"
        sx={{
          opacity: isChat ? 0.7 : 0.85,
          display: "block",
          color: isOverlay ? "inherit" : isChat ? "#000" : undefined,
        }}
      >
        {title} — t = {timeSec.toFixed(2)} s
      </Typography>
      {(velocityMps != null || accelMps2 != null) && (
        <Typography
          variant="caption"
          component="div"
          sx={{
            mt: 0.25,
            color: isOverlay ? "inherit" : isChat ? "#000" : undefined,
            opacity: isChat ? 0.85 : 1,
          }}
        >
          {`* ego velocity = ${fmt(velocityMps)} m/s`}
          <br />
          {`* ego acceleration = ${fmt(accelMps2)} m/s²`}
        </Typography>
      )}
      {active?.t != null && (
        <Typography
          variant="caption"
          component="div"
          sx={{
            mt: 0.25,
            color: isOverlay ? "inherit" : isChat ? "#000" : undefined,
            opacity: isChat ? 0.85 : 1,
          }}
        >
          {`event at time t = ${active.t.toFixed(2)} s`}
        </Typography>
      )}
      {active && (
        <Typography
          variant={compact || isChat ? "caption" : "body2"}
          sx={{
            mt: 0.25,
            color: isOverlay ? "inherit" : isChat ? "#000" : undefined,
          }}
        >
          {active.text}
        </Typography>
      )}
    </Box>
  );
}
