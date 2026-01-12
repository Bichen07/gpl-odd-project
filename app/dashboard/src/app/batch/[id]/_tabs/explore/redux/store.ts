import { configureStore } from "@reduxjs/toolkit";
import batchReducer from "./slices/batch";
import interactionReducer from "./slices/interaction";

export const store = configureStore({
  reducer: {
    batch: batchReducer,
    interaction: interactionReducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({ serializableCheck: false }),
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
