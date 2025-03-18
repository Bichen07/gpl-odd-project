import { PaletteMode } from "@mui/material";
import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import type { RootState } from "src/redux/store";

export type NavData = {
  id: string;
  name: string;
  to: string;
  items?: NavData[];
};
interface UserInterfaceState {
  mode: PaletteMode;
  loading: boolean;
  sitemap: NavData[];
}

const initialState: UserInterfaceState = {
  // mode: "dark",
  mode: "light",
  loading: false,
  sitemap: [
    {
      id: "",
      name: "Sessions",
      to: "sessions",
      items: [],
    },
  ],
};

export const uiSlice = createSlice({
  name: "ui",
  initialState,
  reducers: {
    toggle: (state: UserInterfaceState) => {
      state.mode = state.mode == "light" ? "dark" : "light";
    },
    setLoading: (state: UserInterfaceState, action: PayloadAction<boolean>) => {
      state.loading = action.payload;
    },
    setSiteMap: (
      state: UserInterfaceState,
      action: PayloadAction<{ index: number; items: NavData[] }>,
    ) => {
      state.sitemap[action.payload.index].items = action.payload.items;
    },
  },
});

export const uiActions = uiSlice.actions;
export default uiSlice.reducer;
export const getCurrentColorMode = (state: RootState) => state.ui.mode;
