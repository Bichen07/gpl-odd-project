import { PaletteMode } from "@mui/material";
import { Theme } from "@mui/material/styles";

const common: Partial<Theme> = {
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: "none",
        },
      },
    },
    MuiFormHelperText: {
      styleOverrides: {
        root: {
          marginLeft: 0,
        },
      },
    },
  },
};

export const getDesignTokens = (mode: PaletteMode) => ({
  ...common,
  palette: {
    mode,
    ...(mode === "light"
      ? {
          // palette values for light mode
          background: {
            // paper: "#f0f0f0",
            paper: "#ffffff",
          },
        }
      : {
          // palette values for dark mode
          background: {
            paper: "#1e1e1e",
          },
        }),
  },
});
