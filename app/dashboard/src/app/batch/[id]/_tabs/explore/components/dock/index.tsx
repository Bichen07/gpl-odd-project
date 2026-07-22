"use client";

import "./rc-dock.css";
import DockLayout, { PanelData, TabData } from "rc-dock";
import { useRef, useState, createContext, useEffect } from "react";
import { Box } from "@mui/material";
import layout from "./layout";
import Saves from "./panels/Saves";
import {
  Batch,
  SavedTrajectoryAnalysis,
} from "@/app/_shared/graphql/queries/batches";
import { store } from "../../redux/store";
import { Provider } from "react-redux";
import { InteractionCount } from "./interactionCount";
import { A } from "ts-toolbelt";
import { getTrials, Trial } from "@/app/_shared/graphql/queries/trials";
import { useAppDispatch } from "../../redux/hooks";
import { batchSlice, CriticalityMetric } from "../../redux/slices/batch";

export const DockLayoutContext = createContext<DockLayout | null>(null);

type Props = {
  batchId: string;
  saves: SavedTrajectoryAnalysis;
  trials: A.Await<ReturnType<typeof getTrials>>;
  batch: Batch;
};
export default function Dock({ batchId, saves, trials, batch }: Props) {
  const dockLayoutRef = useRef<DockLayout>(null);
  // rc-dock mutates layout styles on the client; mount after hydration to avoid
  // SSR/client style mismatches and React 19 element.ref warnings during SSR.
  const [mounted, setMounted] = useState(false);

  const [dockLayoutRefState, setDockLayoutRefState] =
    useState<DockLayout | null>(null);

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (!mounted || !dockLayoutRef.current) {
      return;
    }
    setDockLayoutRefState(dockLayoutRef.current);
  }, [mounted]);

  useEffect(() => {
    if (dockLayoutRef.current == null) {
      return;
    }
    if (dockLayoutRef.current.find("saves")) {
      return;
    }
    const newTab: TabData = {
      id: "saves",
      title: "Saves",
      content: <Saves batchId={batchId} saves={saves} />,
    };
    dockLayoutRef.current?.dockMove(newTab, "1-misc-top", "middle");
  }, [dockLayoutRefState, batchId, saves]);

  return (
    <Box
      component="div"
      sx={{
        position: "relative",
        display: "flex",
        flexDirection: "column",
        height: "100vh",
        overflowY: "hidden",
        ".dock-tabpane": {
          overflowY: "auto",
        },
      }}
    >
      <Provider store={store}>
        <DockLayoutContext.Provider value={dockLayoutRefState}>
          <DataLoader trials={trials} batch={batch} />
          {mounted ? (
            <DockLayout
              ref={dockLayoutRef}
              defaultLayout={layout}
              style={{
                position: "absolute",
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                fontFamily: "var(--font-roboto)",
              }}
            />
          ) : null}
        </DockLayoutContext.Provider>
        {/* <InteractionCount batchId={batchId} /> */}
      </Provider>
    </Box>
  );
}

function DataLoader({
  trials,
  batch,
}: {
  trials: A.Await<ReturnType<typeof getTrials>>;
  batch: Batch;
}) {
  const dispatch = useAppDispatch();
  useEffect(() => {
    if (trials == null || batch == null) {
      return;
    }
    const egoTrials: { [ego: string]: Trial[] } = {};
    for (const trial of trials ?? []) {
      const egoName = trial.ego.name;
      if (!(egoName in egoTrials)) {
        egoTrials[egoName] = [];
      }
      egoTrials[egoName].push(trial);
    }
    dispatch(batchSlice.actions.setTrials(egoTrials));
    dispatch(batchSlice.actions.setBatch(batch));

    const metrics: { [name: string]: CriticalityMetric } = {};
    for (const m of batch.scenario.testObjectives?.criticalityMetrics ?? []) {
      const newMetric: CriticalityMetric = {
        threshold: m?.threshold ?? 0,
        kpi: {
          name: m?.keyPerformanceIndicator?.name ?? "",
          id: m?.keyPerformanceIndicator?.id ?? 0,
          rule: m?.keyPerformanceIndicator?.rule ?? "greaterThan",
          unit: m?.keyPerformanceIndicator?.unit ?? "error",
        },
      };
      let max = -Infinity;
      let min = Infinity;
      for (const trial of trials) {
        let metricValue = trial.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.id === newMetric.kpi?.id
        )?.value;
        if (metricValue != null) {
          max = Math.max(metricValue, max);
          min = Math.min(metricValue, min);
        }
      }
      newMetric.min = min;
      newMetric.max = m.keyPerformanceIndicator?.name === "spret_min" ? 9 : max;
      metrics[newMetric.kpi.name] = newMetric;
    }
    dispatch(batchSlice.actions.setMetrics(metrics));
    // Prefer a metric with a non-degenerate parameter-space surface.
    // Paper CS2 often has spret_min capped flat (all 9) which Contour cannot render.
    const preferred =
      metrics["ttc_min"] ?? metrics["spret_min"] ?? metrics["collision"];
    dispatch(batchSlice.actions.setSelectedMetric(preferred));
    dispatch(
      batchSlice.actions.setSelectedSafetyBoundaryMetric(metrics["collision"])
    );
  }, [trials, batch]);
  return null;
}
