"use client";

import {
  Alert,
  Box,
  FormControlLabel,
  MenuItem,
  Paper,
  Select,
  Slider,
  Stack,
  Switch,
  TextField,
  Typography,
} from "@mui/material";
import type { ModelOption } from "../../types";

export type ModelSetupProps = {
  provider: string;
  model: string;
  setModel: (v: string) => void;
  models: ModelOption[];
  apiKey: string;
  setApiKey: (v: string) => void;
  temperature: number;
  setTemperature: (v: number) => void;
  review: boolean;
  setReview: (v: boolean) => void;
  dryRun: boolean;
  setDryRun: (v: boolean) => void;
};

export default function ModelSetup({
  provider,
  model,
  setModel,
  models,
  apiKey,
  setApiKey,
  temperature,
  setTemperature,
  review,
  setReview,
  dryRun,
  setDryRun,
}: ModelSetupProps) {
  return (
<Paper variant="outlined" sx={{ p: 2, maxWidth: 640 }}>
  <Typography variant="h6" gutterBottom>
    Model setup
  </Typography>
  <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
    Shared by Medoid, Parameter-space pair, Cluster summary, and ODD Q&amp;A.
    The API key is ephemeral (sent only for each request; never stored).
  </Typography>
  <Stack spacing={2}>
    <Box>
      <Typography variant="body2" gutterBottom>
        Model ({provider})
      </Typography>
      <Select size="small" fullWidth value={model} onChange={(e) => setModel(String(e.target.value))}>
        {models.map((m) => (
          <MenuItem key={m.id} value={m.id}>
            {m.id} — {m.provider}
          </MenuItem>
        ))}
      </Select>
    </Box>
    <TextField
      size="small"
      fullWidth
      type="password"
      label={`${provider} API Key (ephemeral)`}
      value={apiKey}
      onChange={(e) => setApiKey(e.target.value)}
      helperText="Required for live LLM runs and ODD Q&A. Server env keys are ignored so another user's key is not reused. Dry run can leave this blank."
    />
    <Box>
      <Typography variant="body2" gutterBottom>
        Temperature: {temperature.toFixed(2)}
      </Typography>
      <Slider
        size="small"
        min={0}
        max={1}
        step={0.1}
        value={temperature}
        onChange={(_, v) => setTemperature(v as number)}
      />
    </Box>
    <Stack direction="row" spacing={2} flexWrap="wrap">
      <FormControlLabel
        control={<Switch checked={review} onChange={(e) => setReview(e.target.checked)} />}
        label="Reviewer pass"
      />
      <FormControlLabel
        control={<Switch checked={dryRun} onChange={(e) => setDryRun(e.target.checked)} />}
        label="Dry run (stub)"
      />
    </Stack>
    {!apiKey && !dryRun && (
      <Alert severity="warning">
        Enter an API key before running medoid / pair / summary analysis or ODD Q&amp;A.
      </Alert>
    )}
    {apiKey && (
      <Alert severity="success">
        API key set for this browser session — other Analyze tabs will reuse it.
      </Alert>
    )}
  </Stack>
</Paper>
  );
}
