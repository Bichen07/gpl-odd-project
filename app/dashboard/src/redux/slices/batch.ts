import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import { Batch, Scenario, Trial } from "src/__generated__/graphql";

export type ColorbarData = {
  ticks: number[];
  colors: string[];
};

export type Parameter = {
  index: number;
  name: string;
  unit: string;
  min: number;
  max: number;
  id: string;
  description?: string;
};
export type Parameters = {
  [id: string]: Parameter;
};

export type CriticalityMetric = {
  index: number;
  name: string;
  unit: string;
  rule: "greaterThan" | "lessThan";
  min: number;
  max: number;
  id: string;
  threshold: number;
  description?: string;
};
export type CriticalityMetrics = {
  [id: string]: CriticalityMetric;
};

interface batchState {
  batch: Batch | null;
  viewBoundary: boolean;
  parameters: Parameters | null;
  criticalityMetrics: CriticalityMetrics | null;
  selectedCriticalityMetric: CriticalityMetric | null;
  filteredTrials: Trial[] | null;
  features: string[] | null;
  selectedFeatures: string[];
  scenario: Scenario | null;
  trials: Trial[] | null;
  hoveredTrialId: string | null;
}

const initialState: batchState = {
  batch: null,
  viewBoundary: false,
  parameters: null,
  criticalityMetrics: null,
  selectedCriticalityMetric: null,
  features: null,
  selectedFeatures: [],
  scenario: null,
  trials: null,
  filteredTrials: null,
  hoveredTrialId: null,
};

export const batchSlice = createSlice({
  name: "batch",
  initialState,
  reducers: {
    reset: (state: batchState) => {
      state = initialState;
    },
    setViewBoundary: (state: batchState, action: PayloadAction<boolean>) => {
      state.viewBoundary = action.payload;
    },
    setParameters: (
      state: batchState,
      action: PayloadAction<Parameters | null>,
    ) => {
      state.parameters = action.payload;
    },
    setCriticalityMetrics: (
      state: batchState,
      action: PayloadAction<CriticalityMetrics | null>,
    ) => {
      state.criticalityMetrics = action.payload;
    },
    setSelectedCriticalityMetric: (
      state: batchState,
      action: PayloadAction<CriticalityMetric | null>,
    ) => {
      state.selectedCriticalityMetric = action.payload;
    },
    setFeatures: (
      state: batchState,
      action: PayloadAction<string[] | null>,
    ) => {
      state.features = action.payload;
    },
    setSelectedFeatures: (
      state: batchState,
      action: PayloadAction<string[]>,
    ) => {
      state.selectedFeatures = action.payload;
    },
    setScenario: (
      state: batchState,
      action: PayloadAction<Scenario | null>,
    ) => {
      state.scenario = action.payload;
    },
    setBatch: (state: batchState, action: PayloadAction<Batch | null>) => {
      state.batch = action.payload;
    },
    setTrials: (state: batchState, action: PayloadAction<Trial[] | null>) => {
      state.trials = action.payload;
    },
    setFilteredTrials: (
      state: batchState,
      action: PayloadAction<Trial[] | null>,
    ) => {
      state.filteredTrials = action.payload;
    },
    setHoveredTrialId: (
      state: batchState,
      action: PayloadAction<string | null>,
    ) => {
      state.hoveredTrialId = action.payload;
    },
  },
});

export const uiActions = batchSlice.actions;
export default batchSlice.reducer;
