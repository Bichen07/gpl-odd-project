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
}: {
  summary: unknown;
  timeSec: number;
  title?: string;
  compact?: boolean;
  variant?: "primary" | "chat" | "overlay";
  borderColor?: string;
}) {
  const timed = getTimedEvents(summary);
  if (timed.length === 0) return null;

  const active = getActiveEventAtTime(timed, timeSec);
  // Before the first event timestamp, show nothing (do not peek ahead).
  if (!active) return null;

  const isChat = variant === "chat";
  const isOverlay = variant === "overlay";

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
        {active.t != null ? ` (event ${active.t.toFixed(2)} s)` : ""}
      </Typography>
      <Typography
        variant={compact || isChat ? "caption" : "body2"}
        sx={{
          mt: 0.25,
          color: isOverlay ? "inherit" : isChat ? "#000" : undefined,
        }}
      >
        {active.text}
      </Typography>
    </Box>
  );
}
