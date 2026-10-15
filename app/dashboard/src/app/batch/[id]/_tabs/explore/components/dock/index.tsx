"use client";

import "./rc-dock.css";
import type { DockLayout } from "rc-dock";
import { useState, createContext, useEffect } from "react";
import { Box } from "@mui/material";
import ScrollWorkspace from "./ScrollWorkspace";
import ChatDrawer from "./ChatDrawer";
import { ChatUiContext, OddChatSyncProvider, type TrialAttachment } from "./chatContext";
import {
  Batch,
  SavedTrajectoryAnalysis,
} from "@/app/_shared/graphql/queries/batches";
import { store } from "../../redux/store";
import { Provider } from "react-redux";
import { A } from "ts-toolbelt";
import { getTrials, Trial } from "@/app/_shared/graphql/queries/trials";
import { useAppDispatch, useAppSelector } from "../../redux/hooks";
import { batchSlice, CriticalityMetric } from "../../redux/slices/batch";

export const DockLayoutContext = createContext<DockLayout | null>(null);

type Props = {
  batchId: string;
  saves: SavedTrajectoryAnalysis;
  trials: A.Await<ReturnType<typeof getTrials>>;
  batch: Batch;
  ego?: string;
  k?: string;
  s?: string;
  section?: string;
};
export default function Dock({ batchId, saves, trials, batch, ego, k, s, section }: Props) {
  const [mounted, setMounted] = useState(false);
  const [chatOpen, setChatOpen] = useState(false);
  const [attachment, setAttachment] = useState<TrialAttachment | null>(null);

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <Box
      component="div"
      sx={{
        position: "relative",
        display: "flex",
        flexDirection: "column",
        height: "100vh",
        overflowY: "hidden",
      }}
    >
      <Provider store={store}>
        <ChatUiContext.Provider
          value={{
            open: chatOpen,
            setOpen: setChatOpen,
            attachment,
            setAttachment,
          }}
        >
          <OddChatSyncProvider>
          <DockLayoutContext.Provider value={null}>
            <DataLoader trials={trials} batch={batch} />
            {mounted ? (
              <Box sx={{ position: "absolute", inset: 0 }}>
                <ScrollWorkspace
                  batchId={batchId}
                  saves={saves}
                  ego={ego || "ITRI"}
                  k={k || ""}
                  s={s || ""}
                  section={section}
                />
              </Box>
            ) : null}
            {mounted ? (
              <SelectedRunChat batchId={batchId} ego={ego || "ITRI"} k={k || ""} s={s || ""} />
            ) : null}
          </DockLayoutContext.Provider>
          </OddChatSyncProvider>
        </ChatUiContext.Provider>
      </Provider>
    </Box>
  );
}

function SelectedRunChat({
  batchId,
  ego,
  k,
  s,
}: {
  batchId: string;
  ego: string;
  k: string;
  s: string;
}) {
  const savedFolder = useAppSelector((state) => state.batch.clusterAnalysisByEgo?.[ego]?.folder ?? null);
  const folder = k && s ? `${k}_cluster_s=${s}` : savedFolder;
  return <ChatDrawer batchId={batchId} folder={folder} />;
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
