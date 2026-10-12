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
  variant: "h4" | "h6" | "subtitle1" | "overline";
}) {
  const [open, setOpen] = useState(false);
  const isOverline = variant === "overline";
  return (
    <>
      <Stack
        direction="row"
        alignItems="center"
        spacing={0.5}
        sx={{ mb: variant === "h4" ? 0.5 : isOverline ? 0 : 1 }}
      >
        <Typography
          variant={variant}
          color={isOverline ? "text.secondary" : undefined}
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
