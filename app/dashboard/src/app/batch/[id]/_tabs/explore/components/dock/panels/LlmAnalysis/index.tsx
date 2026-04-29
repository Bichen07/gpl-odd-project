"use client";

import { useEffect, useMemo, useState } from "react";
import { Box, MenuItem, Select, Stack, Typography } from "@mui/material";

type StageView = {
  files: string[];
  preview: string;
};

type ApiResponse = {
  root: string;
  runs: string[];
  selectedRunId: string | null;
  stages: Record<string, StageView>;
};

export default function LlmAnalysis() {
  const [data, setData] = useState<ApiResponse | null>(null);
  const [runId, setRunId] = useState<string>("");

  useEffect(() => {
    const qs = runId ? `?runId=${encodeURIComponent(runId)}` : "";
    fetch(`/api/llm-artifacts${qs}`)
      .then((r) => r.json())
      .then((d: ApiResponse) => {
        setData(d);
        if (!runId && d.selectedRunId) {
          setRunId(d.selectedRunId);
        }
      })
      .catch(() => setData(null));
  }, [runId]);

  const stageNames = useMemo(() => Object.keys(data?.stages ?? {}).sort(), [data]);

  return (
    <Stack spacing={2} sx={{ p: 2 }}>
      <Typography variant="h6">LLM Analysis Artifacts</Typography>
      <Typography variant="body2">
        Browse generated artifacts from Stage 1-5 pipeline runs.
      </Typography>
      <Box>
        <Typography variant="caption">Run ID</Typography>
        <Select
          size="small"
          sx={{ ml: 1, minWidth: 280 }}
          value={runId}
          onChange={(e) => setRunId(String(e.target.value))}
        >
          {(data?.runs ?? []).map((r) => (
            <MenuItem key={r} value={r}>
              {r}
            </MenuItem>
          ))}
        </Select>
      </Box>

      {stageNames.map((stage) => {
        const view = data?.stages?.[stage];
        if (!view) return null;
        return (
          <Box
            key={stage}
            sx={{ border: "1px solid #444", borderRadius: 1, p: 1.5 }}
          >
            <Typography variant="subtitle1">{stage}</Typography>
            <Typography variant="caption">
              Files: {view.files.join(", ") || "none"}
            </Typography>
            <Box
              component="pre"
              sx={{
                whiteSpace: "pre-wrap",
                wordBreak: "break-word",
                p: 1,
                mt: 1,
                background: "#1d1d1d",
                borderRadius: 1,
                maxHeight: 260,
                overflow: "auto",
                fontSize: 12,
              }}
            >
              {view.preview || "(no preview)"}
            </Box>
          </Box>
        );
      })}
    </Stack>
  );
}
