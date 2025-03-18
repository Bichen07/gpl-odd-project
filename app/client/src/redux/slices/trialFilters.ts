import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import { MRT_RowData } from "material-react-table";
import { Trial } from "payload/payload-types";
import { RootState } from "../store";
import { ColorScale } from "plotly.js-basic-dist";
import { kdTree } from "kd-tree-javascript";

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
};
export type CriticalityMetrics = {
  [id: string]: CriticalityMetric;
};

export type Trials = {
  [id: string]: Trial;
};

interface TrialFiltersState {
  interfaceLoading: boolean;
  filterLoading: boolean;
  parameters: Parameters | null;
  criticalityMetrics: CriticalityMetrics | null;
  selectedCriticalityMetricId: string | null;
  outputFilterMin: number | null;
  outputFilterMax: number | null;
  usingBoundaryKNN: boolean;
  kNearestNeighbors: number;
  trials: { [id: string]: Trial } | null;
  filteredTrialIds: string[] | null;
  tableData: MRT_RowData[] | null;
  modalOpen: boolean;
  outputColorScale: ColorScale | null;
  outputColorbarData: ColorbarData | null;
}

const initialState: TrialFiltersState = {
  interfaceLoading: true,
  filterLoading: true,
  parameters: null,
  criticalityMetrics: null,
  selectedCriticalityMetricId: null,
  outputFilterMin: null,
  outputFilterMax: null,
  usingBoundaryKNN: false,
  kNearestNeighbors: 1,
  trials: null,
  filteredTrialIds: null,
  tableData: null,
  modalOpen: false,
  outputColorScale: null,
  outputColorbarData: null,
};

export const analysisSlice = createSlice({
  name: "analysis",
  initialState,
  reducers: {
    reset: () => initialState,
    setInterfaceLoading: (
      state: TrialFiltersState,
      action: PayloadAction<boolean>
    ) => {
      state.interfaceLoading = action.payload;
    },
    setFilterLoading: (
      state: TrialFiltersState,
      action: PayloadAction<boolean>
    ) => {
      state.filterLoading = action.payload;
    },
    setCriticalityMetrics: (
      state: TrialFiltersState,
      action: PayloadAction<CriticalityMetrics>
    ) => {
      state.criticalityMetrics = action.payload;
    },
    setSelectedCriticalityMetricId: (
      state: TrialFiltersState,
      action: PayloadAction<string>
    ) => {
      state.selectedCriticalityMetricId = action.payload;
    },
    setOutputFilterMax: (
      state: TrialFiltersState,
      action: PayloadAction<number>
    ) => {
      state.outputFilterMax = action.payload;
    },
    setOutputFilterMin: (
      state: TrialFiltersState,
      action: PayloadAction<number>
    ) => {
      state.outputFilterMin = action.payload;
    },
    setTrials: (state: TrialFiltersState, action: PayloadAction<Trials>) => {
      state.trials = action.payload;
    },
    setFilteredTrialIndices: (
      state: TrialFiltersState,
      action: PayloadAction<string[]>
    ) => {
      state.filteredTrialIds = action.payload;
    },
    setParameters: (
      state: TrialFiltersState,
      action: PayloadAction<Parameters>
    ) => {
      state.parameters = action.payload;
    },
    setUsingBoundaryKNN: (
      state: TrialFiltersState,
      action: PayloadAction<boolean>
    ) => {
      state.usingBoundaryKNN = action.payload;
    },
    setKNearestNeighbors: (
      state: TrialFiltersState,
      action: PayloadAction<number>
    ) => {
      state.kNearestNeighbors = action.payload;
    },
    setTableData: (
      state: TrialFiltersState,
      action: PayloadAction<MRT_RowData[]>
    ) => {
      state.tableData = action.payload;
    },
    setModalOpen: (
      state: TrialFiltersState,
      action: PayloadAction<boolean>
    ) => {
      state.modalOpen = action.payload;
    },
    setColorScale: (
      state: TrialFiltersState,
      action: PayloadAction<ColorScale>
    ) => {
      state.outputColorScale = action.payload;
    },
    setColorbarData: (
      state: TrialFiltersState,
      action: PayloadAction<ColorbarData>
    ) => {
      state.outputColorbarData = action.payload;
    },
  },
});

export const {
  reset,
  setFilterLoading,
  setInterfaceLoading,
  setCriticalityMetrics,
  setSelectedCriticalityMetricId,
  setOutputFilterMin,
  setOutputFilterMax,
  setTrials,
  setFilteredTrialIndices,
  setParameters,
  setUsingBoundaryKNN,
  setKNearestNeighbors,
  setTableData,
  setModalOpen,
  setColorScale,
  setColorbarData,
} = analysisSlice.actions;

export const getFilteredTrials = (state: RootState) => {
  if (
    state.trialFilters.trials === null ||
    state.trialFilters.filteredTrialIds === null
  ) {
    return null;
  }
  const filteredTrials: { [id: string]: Trial } = {};
  for (const id of state.trialFilters.filteredTrialIds) {
    filteredTrials[id] = state.trialFilters.trials[id];
  }
  return filteredTrials;
};

export const getSelectedCriticalityMetric = (state: RootState) => {
  if (
    state.trialFilters.criticalityMetrics === null ||
    state.trialFilters.selectedCriticalityMetricId === null
  ) {
    return null;
  }
  return state.trialFilters.criticalityMetrics[
    state.trialFilters.selectedCriticalityMetricId
  ];
};

export const getTree = (state: RootState) => {
  const trials = state.trialFilters.trials;
  const parameters = state.trialFilters.parameters;
  if (trials === null || parameters === null) {
    return null;
  }

  const trialValues = Object.values(trials);

  const points: { [key: string]: number }[] = [];

  for (const [index, trial] of trialValues.entries()) {
    const point: { [key: string]: number } = {};
    point["index"] = index;
    for (const parameter of trial.parameters) {
      point[parameter.parameterId as string] = parameter.value as number;
    }
    points.push(point);
  }

  const calculateDistance = (
    a: { [key: string]: number },
    b: { [key: string]: number }
  ) => {
    let sum = 0;
    for (const usedParameter of trialValues[0].parameters) {
      const id = usedParameter.parameterId as string;
      const parameter = parameters[id];
      const bound = [parameter.min, parameter.max];
      const aValue = a[id] / (bound[1] - bound[0]);
      const bValue = b[id] / (bound[1] - bound[0]);
      sum += Math.pow(aValue - bValue, 2);
    }

    return Math.sqrt(sum);
  };

  return new kdTree<{ [key: string]: number }>(
    points,
    calculateDistance,
    trialValues[0].parameters.map((p) => p.parameterId as string)
  );
};

export default analysisSlice.reducer;
