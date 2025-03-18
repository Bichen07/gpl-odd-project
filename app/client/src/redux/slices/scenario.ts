import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import { Scenario } from "payload/payload-types";

interface ScenarioState {
  loading: boolean;
  data: Scenario | null;
}

const initialState: ScenarioState = {
  loading: true,
  data: null,
};

export const scenarioSlice = createSlice({
  name: "scenario",
  initialState,
  reducers: {
    setData: (state: ScenarioState, action: PayloadAction<Scenario | null>) => {
      state.data = action.payload;
    },
    setLoading: (state: ScenarioState, action: PayloadAction<boolean>) => {
      state.loading = action.payload;
    },
  },
});

export const { setData, setLoading } = scenarioSlice.actions;
export default scenarioSlice.reducer;
