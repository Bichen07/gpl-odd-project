"use client";
import { createTheme } from "@mui/material/styles";

const theme = createTheme({
  cssVariables: true,
  typography: {
    fontFamily: "var(--font-roboto)",
    button: {
      textTransform: "none",
    },
  },
  palette: {
    error: {
      main: "#ff3045",
      light: "#ff5555",
    },
    warning: {
      main: "#fd3",
      light: "#ec4",
    },
  },
});

export default theme;
