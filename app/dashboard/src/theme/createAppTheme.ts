"use client";

import { createTheme } from "@mui/material/styles";

export function createAppTheme() {
  return createTheme({
    cssVariables: true,
    palette: {
      mode: "light",
      background: {
        default: "#f5f5f5",
        paper: "#ffffff",
      },
      text: {
        primary: "#212121",
        secondary: "#555555",
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
            backgroundColor: "#f5f5f5",
            color: "#212121",
          },
        },
      },
    },
  });
}
