"use client";

import {
  Box,
  Chip,
  Collapse,
  IconButton,
  Paper,
  Stack,
  Typography,
  useTheme,
} from "@mui/material";
import CloseIcon from "@mui/icons-material/Close";
import VisibilityIcon from "@mui/icons-material/Visibility";
import VisibilityOffIcon from "@mui/icons-material/VisibilityOff";
import { useAppDispatch, useAppSelector } from "../../../../redux/hooks";
import { batchSlice } from "../../../../redux/slices/batch";

export default function BehaviorOverlay() {
  const theme = useTheme();
  const dispatch = useAppDispatch();

  const show = useAppSelector((s) => s.batch.showBehaviorOverlay);
  const explanations = useAppSelector((s) => s.batch.llmBehaviorExplanations);
  const medoids = useAppSelector((s) => s.batch.llmMedoidTrialIds);

  if (!explanations || Object.keys(explanations).length === 0) return null;

  return (
    <Box
      sx={{
        position: "absolute",
        bottom: 16,
        right: 16,
        zIndex: 1200,
        maxWidth: 380,
        maxHeight: "60vh",
      }}
    >
      {!show ? (
        <IconButton
          onClick={() => dispatch(batchSlice.actions.setShowBehaviorOverlay(true))}
          sx={{
            bgcolor: theme.palette.primary.main,
            color: "#fff",
            "&:hover": { bgcolor: theme.palette.primary.dark },
            boxShadow: 3,
          }}
        >
          <VisibilityIcon />
        </IconButton>
      ) : (
        <Paper
          elevation={6}
          sx={{
            p: 2,
            maxHeight: "60vh",
            overflow: "auto",
            bgcolor: theme.palette.background.paper,
            border: `1px solid ${theme.palette.divider}`,
            borderRadius: 2,
          }}
        >
          <Stack
            direction="row"
            justifyContent="space-between"
            alignItems="center"
            sx={{ mb: 1 }}
          >
            <Typography variant="subtitle2" fontWeight={700}>
              Behavior Explanations
            </Typography>
            <IconButton
              size="small"
              onClick={() => dispatch(batchSlice.actions.setShowBehaviorOverlay(false))}
            >
              <VisibilityOffIcon fontSize="small" />
            </IconButton>
          </Stack>

          {medoids.length > 0 && (
            <Typography variant="caption" color="text.secondary" sx={{ mb: 1, display: "block" }}>
              Medoids highlighted: {medoids.join(", ")}
            </Typography>
          )}

          <Stack spacing={1}>
            {Object.entries(explanations).map(([cid, info]) => (
              <Box
                key={cid}
                sx={{
                  p: 1,
                  borderRadius: 1,
                  border: `1px solid ${theme.palette.divider}`,
                  bgcolor:
                    theme.palette.mode === "dark" ? "#1a1a2e" : "#f0f4f8",
                }}
              >
                <Typography variant="subtitle2" fontWeight={600}>
                  {info.label || `Cluster ${cid}`}
                </Typography>
                <Typography variant="body2" sx={{ mt: 0.5 }}>
                  {info.description || "(no description)"}
                </Typography>
              </Box>
            ))}
          </Stack>
        </Paper>
      )}
    </Box>
  );
}
