import { configureStore } from "@reduxjs/toolkit";
import colorModeReducer from "src/redux/slices/colorMode";
import clientReducer from "src/redux/slices/client";
import scenarioReducer from "src/redux/slices/scenario";
import trialFiltersReducer from "src/redux/slices/trialFilters";
import timeSeriesClusteringReducer from "src/redux/slices/timeSeriesClustering";

export const store = configureStore({
  reducer: {
    colorMode: colorModeReducer,
    client: clientReducer,
    scenario: scenarioReducer,
    trialFilters: trialFiltersReducer,
    timeSeriesClustering: timeSeriesClusteringReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
