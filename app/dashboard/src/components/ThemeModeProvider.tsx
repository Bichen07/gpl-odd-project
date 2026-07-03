"use client";

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from "react";
import { CssBaseline, ThemeProvider } from "@mui/material";
import type { PaletteMode } from "@mui/material";
import { createAppTheme } from "@/theme/createAppTheme";

const STORAGE_KEY = "gpl-odd-dashboard-color-mode";

type ThemeModeContextValue = {
  mode: PaletteMode;
  toggleMode: () => void;
  setMode: (mode: PaletteMode) => void;
};

const ThemeModeContext = createContext<ThemeModeContextValue | null>(null);

function readStoredMode(): PaletteMode {
  if (typeof window === "undefined") return "dark";
  const stored = localStorage.getItem(STORAGE_KEY);
  if (stored === "light" || stored === "dark") return stored;
  return window.matchMedia("(prefers-color-scheme: dark)").matches
    ? "dark"
    : "light";
}

export function ThemeModeProvider({ children }: { children: ReactNode }) {
  const [mode, setModeState] = useState<PaletteMode>("dark");

  useEffect(() => {
    setModeState(readStoredMode());
  }, []);

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, mode);
    document.documentElement.setAttribute("data-color-mode", mode);
  }, [mode]);

  const setMode = useCallback((next: PaletteMode) => {
    setModeState(next);
  }, []);

  const toggleMode = useCallback(() => {
    setModeState((m) => (m === "dark" ? "light" : "dark"));
  }, []);

  const theme = useMemo(() => createAppTheme(mode), [mode]);
  const value = useMemo(
    () => ({ mode, toggleMode, setMode }),
    [mode, toggleMode, setMode],
  );

  return (
    <ThemeModeContext.Provider value={value}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        {children}
      </ThemeProvider>
    </ThemeModeContext.Provider>
  );
}

export function useThemeMode() {
  const ctx = useContext(ThemeModeContext);
  if (!ctx) {
    throw new Error("useThemeMode must be used within ThemeModeProvider");
  }
  return ctx;
}
