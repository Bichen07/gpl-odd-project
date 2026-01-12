import { PayloadAction, createSlice } from "@reduxjs/toolkit";

export type InteractionEvent = {
  event: string;
  start: string;
  end: string;
  counts: number;
};
export interface InteractionState {
  activated: boolean;
  records: InteractionEvent[];
  camera: {
    target: number[];
    distance: number;
  };
  currentPanel: string;
}

const initialState: InteractionState = {
  activated: true,
  records: [],
  camera: {
    target: [0, 0],
    distance: 1,
  },
  currentPanel: "",
};

export const interactionSlice = createSlice({
  name: "interaction",
  initialState,
  reducers: {
    reset: (state: InteractionState) => {
      state.records = [];
      state.camera.target = [0, 0];
      state.camera.distance = 1;
    },
    addCounts: (state: InteractionState) => {
      state.records[state.records.length - 1].counts += 1;
    },
    updateCenter: (
      state: InteractionState,
      action: PayloadAction<number[]>,
    ) => {
      state.camera.target = action.payload;
    },
    updateScale: (state: InteractionState, action: PayloadAction<number>) => {
      state.camera.distance = action.payload;
    },
    push: (
      state: InteractionState,
      action: PayloadAction<InteractionEvent>,
    ) => {
      state.records.push(action.payload);
    },
    setCurrentPanel: (
      state: InteractionState,
      action: PayloadAction<string>,
    ) => {
      state.currentPanel = action.payload;
    },
    record: (state: InteractionState, action: PayloadAction<string>) => {
      const now = new Date(Date.now());
      const lastRecord = state.records[state.records.length - 1];

      if (
        lastRecord?.event === action.payload &&
        new Date(lastRecord.end).getTime() >= now.getTime() - 3000 // e.g., 3 seconds
      ) {
        lastRecord.counts += 1;
        lastRecord.end = now.toISOString();
      } else {
        state.records.push({
          event: action.payload,
          start: now.toISOString(),
          end: now.toISOString(),
          counts: 1,
        });
      }
      // const now = new Date(Date.now()).toISOString();
      // if (
      //   state.records.length > 0 &&
      //   state.records[state.records.length - 1].event === action.payload
      // ) {
      //   state.records[state.records.length - 1].counts += 1;
      //   state.records[state.records.length - 1].end = now;
      // } else {
      //   state.records.push({
      //     event: action.payload,
      //     start: now,
      //     end: now,
      //     counts: 1,
      //   });
      // }
    },
  },
});

export const interactionActions = interactionSlice.actions;
export default interactionSlice.reducer;
