"use client";

import { createTheme, type PaletteMode } from "@mui/material/styles";

export function createAppTheme(mode: PaletteMode) {
  const isDark = mode === "dark";
  return createTheme({
    cssVariables: true,
    palette: {
      mode,
      background: {
        default: isDark ? "#121212" : "#f5f5f5",
        paper: isDark ? "#1e1e1e" : "#ffffff",
      },
      text: {
        primary: isDark ? "#e8e8e8" : "#212121",
        secondary: isDark ? "#aaaaaa" : "#555555",
      },
      error: {
        main: "#ff3045",
        light: "#ff5555",
      },
      warning: {
        main: "#fd3",
        light: "#ec4",
      },
    },
    typography: {
      fontFamily: "var(--font-roboto)",
      button: {
        textTransform: "none",
      },
    },
    components: {
      MuiCssBaseline: {
        styleOverrides: {
          body: {
            backgroundColor: isDark ? "#121212" : "#f5f5f5",
            color: isDark ? "#e8e8e8" : "#212121",
          },
        },
      },
    },
  });
}
