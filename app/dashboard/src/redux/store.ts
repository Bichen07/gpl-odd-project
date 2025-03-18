import { configureStore } from "@reduxjs/toolkit";
import uiReducer from "src/redux/slices/userInterface";
import batchReducer from "src/redux/slices/batch";
import sessionReducer from "src/redux/slices/session";

export const store = configureStore({
  reducer: {
    ui: uiReducer,
    batch: batchReducer,
    session: sessionReducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({ serializableCheck: false }),
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
