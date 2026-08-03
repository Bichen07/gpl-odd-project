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
  {
    action: "Left click",
    description:
      "Add or remove a trial from the current selection (Highlight role trials stay selected until you clear or uncheck them in Clustering Selection)",
  },
  {
    action: "Left drag",
    description:
      "Draw a selection range (lasso) and add those trials to the current selection",
  },
  {
    action: "Left click background",
    description:
      "Clear the selection in Parameter Space, Trajectory Projection, and Replayer",
  },
  {
    action: "Right click",
    description:
      "Set the Replayer camera-follow trial for that trial's cluster (cyan crosshair). On an already-selected point: follow that ego. On an unselected point: add it to the selection and follow. Background / right-drag: no effect. Each cluster keeps its own follow target",
  },
  {
    action: "Middle mouse button drag",
    description: "Pan / move the plot background",
  },
  { action: "Mouse wheel", description: "Zoom in and out" },
  {
    action: "Cyan dashed crosshair",
    description:
      "Replayer camera-follow trial (set by right-click; distinct from medoid / outlier / pair markers)",
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
