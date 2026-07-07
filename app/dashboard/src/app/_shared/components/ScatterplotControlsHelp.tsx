"use client";

import { useState } from "react";
import {
  IconButton,
  List,
  ListItem,
  ListItemText,
  Popover,
  Stack,
  Typography,
} from "@mui/material";
import HelpOutlineIcon from "@mui/icons-material/HelpOutline";

/** Shared mouse/keyboard guidance for Parameter Space and Projection Space plots. */
export const SCATTERPLOT_CONTROL_HELP: ReadonlyArray<{
  action: string;
  description: string;
}> = [
  { action: "Left click", description: "Select one trajectory trial" },
  {
    action: "Ctrl + left click",
    description: "Add or remove a trial from the current selection",
  },
  {
    action: "Left drag",
    description: "Draw a selection range (lasso) to select multiple trials",
  },
  {
    action: "Ctrl + left drag",
    description:
      "Draw a selection range (lasso) and add/remove those trials to the current selection",
  },
  {
    action: "Middle mouse button drag",
    description: "Pan / move the plot background",
  },
  { action: "Mouse wheel", description: "Zoom in and out" },
  {
    action: "Left drag on empty background",
    description: "Clear selection",
  },
  {
    action: "White circle marker",
    description:
      "Medoid trajectory (visual marker only — not auto-selected unless you click it)",
  },
];

type Props = {
  /** Optional panel title shown at the top of the popover. */
  title?: string;
};

/**
 * Help (?) button used by Parameter Space and Projection Space scatterplots.
 * Both panels import this component so control guidance stays in one place.
 */
export default function ScatterplotControlsHelp({
  title = "Plot controls",
}: Props) {
  const [anchorEl, setAnchorEl] = useState<HTMLElement | null>(null);
  const open = anchorEl != null;

  return (
    <>
      <IconButton
        size="small"
        aria-label="Show plot control help"
        onClick={(event) => setAnchorEl(event.currentTarget)}
        sx={{ ml: "auto", flexShrink: 0, p: 0.25 }}
      >
        <HelpOutlineIcon fontSize="small" />
      </IconButton>

      <Popover
        open={open}
        anchorEl={anchorEl}
        onClose={() => setAnchorEl(null)}
        anchorOrigin={{ vertical: "bottom", horizontal: "right" }}
        transformOrigin={{ vertical: "top", horizontal: "right" }}
        slotProps={{
          paper: { sx: { maxWidth: 360, p: 1.5 } },
        }}
      >
        <Stack spacing={1}>
          <Typography variant="subtitle2" fontWeight={600}>
            {title}
          </Typography>
          <List dense disablePadding>
            {SCATTERPLOT_CONTROL_HELP.map(({ action, description }) => (
              <ListItem key={action} disablePadding sx={{ py: 0.35 }}>
                <ListItemText
                  primary={action}
                  secondary={description}
                  primaryTypographyProps={{ fontWeight: 600, fontSize: 13 }}
                  secondaryTypographyProps={{ fontSize: 12 }}
                />
              </ListItem>
            ))}
          </List>
        </Stack>
      </Popover>
    </>
  );
}
