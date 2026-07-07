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
  variant?: "primary" | "chat";
  borderColor?: string;
}) {
  const timed = getTimedEvents(summary);
  if (timed.length === 0) return null;

  const active = getActiveEventAtTime(timed, timeSec);
  const isChat = variant === "chat";

  return (
    <Box
      sx={{
        p: compact ? 1 : 1.25,
        borderRadius: 1,
        bgcolor: isChat ? "#fff" : "primary.main",
        color: isChat ? "#000" : "primary.contrastText",
        border: isChat ? `3px solid ${borderColor ?? "#888"}` : "none",
        maxWidth: isChat ? 280 : compact ? 360 : "100%",
        minWidth: isChat ? 200 : undefined,
        boxShadow: isChat ? 1 : "none",
      }}
    >
      <Typography
        variant="caption"
        sx={{
          opacity: isChat ? 0.7 : 0.85,
          display: "block",
          color: isChat ? "#000" : undefined,
        }}
      >
        {title} — t = {timeSec.toFixed(2)} s
      </Typography>
      <Typography
        variant={compact || isChat ? "caption" : "body2"}
        sx={{ mt: 0.25, color: isChat ? "#000" : undefined }}
      >
        {active?.text ?? "—"}
      </Typography>
    </Box>
  );
}
