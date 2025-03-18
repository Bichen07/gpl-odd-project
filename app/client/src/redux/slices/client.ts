import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import { Client } from "payload/payload-types";

interface ClientState {
  selectedId: string | null;
  options: {
    [id: string]: Client;
  } | null;
}

const initialState: ClientState = {
  selectedId: null,
  options: null,
};

export const clientSlice = createSlice({
  name: "client",
  initialState,
  reducers: {
    setSelectedId: (
      state: ClientState,
      action: PayloadAction<string | null>
    ) => {
      state.selectedId = action.payload;
    },
    setOptions: (
      state: ClientState,
      action: PayloadAction<typeof initialState.options>
    ) => {
      state.options = action.payload;
    },
  },
});

export const { setSelectedId, setOptions } = clientSlice.actions;
export default clientSlice.reducer;
