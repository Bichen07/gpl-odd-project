"use client";

import { useEffect, useRef } from "react";
import {
  Alert,
  Box,
  Button,
  LinearProgress,
  Stack,
  Typography,
} from "@mui/material";

export default function AnalyzeRunConsole({
  title,
  running,
  logs,
  logFile,
  error,
  completed,
  total,
  onStop,
}: {
  title: string;
  running: boolean;
  logs: string;
  logFile: string;
  error: string | null;
  completed: number;
  total: number;
  onStop: () => void;
}) {
  const logRef = useRef<HTMLPreElement>(null);
  useEffect(() => {
    const el = logRef.current;
    if (el) el.scrollTop = el.scrollHeight;
  }, [logs]);

  if (!running && !logs && !error) return null;

  const pct =
    total > 0 ? Math.min(100, Math.round((completed / Math.max(total, 1)) * 100)) : running ? 0 : 100;
  const status =
    running && total > 0
      ? `${completed}/${total} done (${pct}%)`
      : running
        ? "running…"
        : "last run output";

  return (
    <Box sx={{ mt: 2 }}>
      <Stack direction="row" alignItems="center" spacing={1} sx={{ mb: 0.5 }}>
        <Typography variant="body2" sx={{ flexGrow: 1 }}>
          {title}: {status}
        </Typography>
        {running && (
          <Button size="small" variant="outlined" color="error" onClick={onStop}>
            Stop
          </Button>
        )}
      </Stack>
      <LinearProgress
        variant={running && pct === 0 ? "indeterminate" : "determinate"}
        value={pct}
        sx={{ mb: 1, borderRadius: 1 }}
      />
      <Box
        component="pre"
        ref={logRef}
        sx={{
          m: 0,
          p: 1,
          bgcolor: "#0b0b0b",
          color: "#d6e2c4",
          borderRadius: 1,
          fontSize: 11,
          lineHeight: 1.5,
          maxHeight: 280,
          overflow: "auto",
          whiteSpace: "pre-wrap",
        }}
      >
        {logs || "(waiting for output…)"}
      </Box>
      {logFile && (
        <Typography variant="caption" color="text.secondary">
          Log saved to <code>{logFile}</code>
        </Typography>
      )}
      {error && (
        <Alert severity="error" sx={{ mt: 1 }}>
          {error}
        </Alert>
      )}
    </Box>
  );
}
