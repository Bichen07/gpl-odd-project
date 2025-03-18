import { PaletteMode } from "@mui/material";
import { createSlice } from "@reduxjs/toolkit";
import type { RootState } from "src/redux/store";

interface ColorModeState {
  mode: PaletteMode;
}

const initialState: ColorModeState = {
  mode: "dark",
  // mode: "light",
};

export const colorModeSlice = createSlice({
  name: "colorMode",
  initialState,
  reducers: {
    toggle: (state: ColorModeState) => {
      state.mode = state.mode == "light" ? "dark" : "light";
    },
  },
});

export const { toggle } = colorModeSlice.actions;
export const getCurrentColorMode = (state: RootState) => state.colorMode.mode;
export default colorModeSlice.reducer;
