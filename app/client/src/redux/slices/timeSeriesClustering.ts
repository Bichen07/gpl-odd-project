import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import { MRT_RowData } from "material-react-table";
import { Observation } from "payload/payload-types";

export const timeSeriesRepresentations = [
  "finalObservation",
  "deepEmbedding",
] as const;
export const clusteringSpaces = ["umap", "original"] as const;
export type TimeSeriesRepresentation =
  (typeof timeSeriesRepresentations)[number];
export type ClusteringSpace = (typeof clusteringSpaces)[number];
export type FinalObservations = { [trialId: string]: Observation };
export type Representations = { [trialId: string]: number[] };
export type Clusters = {
  [trialId: string]: { cluster: number; membership: number };
};
export type ClusterMemberData = {
  [cluster: number]: {
    color: string;
    count: number;
    means: {
      [attribute: string]: number;
    };
  };
};

export type TableData = {
  data: MRT_RowData[];
  headers: string[];
};

interface TimeSeriesClusteringState {
  representation: TimeSeriesRepresentation;
  attributes: string[] | null;
  selectedAttributes: string[];
  clusteringSpace: ClusteringSpace;
  finalObservations: FinalObservations | null;
  representations: Representations | null;
  clusters: Clusters | null;
  clusterMemberData: ClusterMemberData | null;
  representationsModalTableOpen: boolean;
  clustersModalTableOpen: boolean;
  tableData: TableData | null;
}

const initialState: TimeSeriesClusteringState = {
  representation: "finalObservation",
  clusteringSpace: "umap",
  attributes: null,
  selectedAttributes: [],
  finalObservations: null,
  representations: {},
  clusters: {},
  clusterMemberData: null,
  representationsModalTableOpen: false,
  clustersModalTableOpen: false,
  tableData: null,
};

export const scenarioSlice = createSlice({
  name: "scenario",
  initialState,
  reducers: {
    resetClusters: (state: TimeSeriesClusteringState) => {
      state.representations = null;
      state.clusters = null;
      state.tableData = null;
      state.clusterMemberData = null;
    },
    setRepresentation: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<TimeSeriesRepresentation>
    ) => {
      state.representation = action.payload;
    },
    setClusteringSpace: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<ClusteringSpace>
    ) => {
      state.clusteringSpace = action.payload;
    },
    setAttributes: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<string[] | null>
    ) => {
      state.attributes = action.payload;
    },
    setSelectedAttributes: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<string[]>
    ) => {
      state.selectedAttributes = action.payload;
    },
    setFinalObservations: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<FinalObservations>
    ) => {
      state.finalObservations = action.payload;
    },
    setRepresentations: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<Representations | null>
    ) => {
      state.representations = action.payload;
    },
    setClusters: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<Clusters | null>
    ) => {
      state.clusters = action.payload;
    },
    setRepresentationsModalTableOpen: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<boolean>
    ) => {
      state.representationsModalTableOpen = action.payload;
    },
    setClustersModalTableOpen: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<boolean>
    ) => {
      state.representationsModalTableOpen = action.payload;
    },
    setTableData: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<TableData>
    ) => {
      state.tableData = action.payload;
    },
    setClusterMemberData: (
      state: TimeSeriesClusteringState,
      action: PayloadAction<ClusterMemberData | null>
    ) => {
      state.clusterMemberData = action.payload;
    },
  },
});

export const {
  resetClusters,
  setRepresentation,
  setClusteringSpace,
  setAttributes,
  setSelectedAttributes,
  setFinalObservations,
  setRepresentations,
  setClusters,
  setRepresentationsModalTableOpen,
  setClustersModalTableOpen,
  setClusterMemberData,
  setTableData,
} = scenarioSlice.actions;
export default scenarioSlice.reducer;
