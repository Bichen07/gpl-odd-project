"use client";

import { Alert, Collapse, IconButton, Stack, Tooltip, Typography } from "@mui/material";
import { Close, HelpOutline } from "@mui/icons-material";
import { useState, type ReactNode } from "react";

export default function TitleWithHelp({
  title,
  help,
  variant,
}: {
  title: string;
  help: ReactNode;
  variant: "h4" | "h6";
}) {
  const [open, setOpen] = useState(false);
  return (
    <>
      <Stack
        direction="row"
        alignItems="center"
        spacing={0.5}
        sx={{ mb: variant === "h4" ? 0.5 : 1 }}
      >
        <Typography
          variant={variant}
          sx={variant === "h4" ? { fontWeight: 700 } : undefined}
        >
          {title}
        </Typography>
        <Tooltip title={`Explain ${title}`}>
          <IconButton
            size="small"
            aria-label={`Explain ${title}`}
            onClick={() => setOpen((value) => !value)}
          >
            <HelpOutline fontSize="small" />
          </IconButton>
        </Tooltip>
      </Stack>
      <Collapse in={open}>
        <Alert
          severity="info"
          sx={{ mb: 2 }}
          action={
            <IconButton
              size="small"
              aria-label={`Close ${title} explanation`}
              onClick={() => setOpen(false)}
            >
              <Close fontSize="small" />
            </IconButton>
          }
        >
          {help}
        </Alert>
      </Collapse>
    </>
  );
}
