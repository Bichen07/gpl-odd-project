"use client";

import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Paper,
  TextField,
  Typography,
} from "@mui/material";
import { ExpandMore } from "@mui/icons-material";
import { PROMPT_LABELS } from "../constants";

export default function PromptsCard({
  keys,
  prompts,
  setPrompts,
  productLabel,
}: {
  keys: string[];
  prompts: Record<string, string>;
  setPrompts: React.Dispatch<React.SetStateAction<Record<string, string>>>;
  productLabel: string;
}) {
  const entries = PROMPT_LABELS.filter((p) => keys.includes(p.key));
  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>
        Prompts sent by this analysis
      </Typography>
      <Typography variant="caption" color="text.secondary" display="block" sx={{ mb: 1 }}>
        These are the exact templates <code>--products {productLabel}</code> sends, in order.
        Edits apply to the next run from this tab only.
      </Typography>
      {entries.map(({ key, label, help }) => (
        <Accordion key={key} disableGutters elevation={0} square>
          <AccordionSummary expandIcon={<ExpandMore />}>
            <Typography fontSize={14}>{label}</Typography>
          </AccordionSummary>
          <AccordionDetails>
            <TextField
              multiline
              fullWidth
              minRows={5}
              maxRows={18}
              value={prompts[key] ?? ""}
              onChange={(e) => setPrompts((p) => ({ ...p, [key]: e.target.value }))}
              helperText={help}
              slotProps={{ htmlInput: { style: { fontFamily: "monospace", fontSize: 12 } } }}
            />
          </AccordionDetails>
        </Accordion>
      ))}
    </Paper>
  );
}
