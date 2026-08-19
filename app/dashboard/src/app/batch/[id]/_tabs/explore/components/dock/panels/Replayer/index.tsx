"use client";

import chroma from "chroma-js";
import { SVGScene } from "@pixi-essentials/svg";
import { styled } from "@mui/material/styles";
import {
  Application,
  Assets,
  Graphics,
  Ticker,
  Texture,
  Sprite,
  Container,
  PI_2,
} from "pixi.js";
import {
  Box,
  Button,
  Dialog,
  DialogContent,
  DialogTitle,
  IconButton,
  Slider,
  Stack,
  Typography,
  Menu,
  MenuItem,
  useTheme,
  ToggleButton,
  ToggleButtonGroup,
} from "@mui/material";
import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
import { PlayArrow, Redo, Stop } from "@mui/icons-material";
import {
  useEffect,
  useMemo,
  useRef,
  useState,
  MouseEvent,
  ReactNode,
  useCallback,
} from "react";
import { Viewport } from "pixi-viewport";
import { useParams } from "next/navigation";
import { toast } from "react-toastify";
import {
  TrajectoryResponseData,
  Trial,
  getTrajectories,
  getTrajectoryFromTrial,
} from "@/app/_shared/graphql/queries/trials";
import { useAppDispatch, useAppSelector } from "../../../../redux/hooks";
import {
  viewerModes,
  batchSlice,
  ClusterInfo,
} from "../../../../redux/slices/batch";
import { sum } from "d3";
import JSZip from "jszip";
import axios from "axios";
import { interactionSlice } from "../../../../redux/slices/interaction";
import { ClusteringResult } from "@/app/_shared/graphql/queries/clustering";
import EgoTimelineBox from "@/app/_shared/components/EgoTimelineBox";
import { sampleEgoKinematicsAtTime } from "@/app/_shared/utils/egoTimeline";
import { resolveReplayerClusterCaption } from "@/app/_shared/utils/replayerCaption";
import { resolveReplayerFocusTrial } from "@/app/_shared/utils/replayerFocusTrial";

const clusteringDuration = 5;
const afterClusteringDuration = 3;

const StyledToggleButtonGroup = styled(ToggleButtonGroup)(({ theme }) => ({
  [`& .${toggleButtonGroupClasses.grouped}`]: {
    margin: theme.spacing(0.5),
    border: 0,
    borderRadius: theme.shape.borderRadius,
    [`&.${toggleButtonGroupClasses.disabled}`]: {
      border: 0,
    },
  },
  [`& .${toggleButtonGroupClasses.middleButton},& .${toggleButtonGroupClasses.lastButton}`]:
    {
      marginLeft: -1,
      borderLeft: "1px solid transparent",
    },
}));

const globalStorage = {
  ITRI: {
    trialIdForS: "none",
  },
  ITRILatest: {
    trialIdForS: "none",
  },
};

export const appData: {
  manualTimeChanged: number;
  manualTimeOverride: number;
  nViewers: number;
  paused: boolean;
  lastTime: { [name: string]: number };
  timeMax: number;
} = {
  manualTimeChanged: 0,
  manualTimeOverride: 0,
  paused: false,
  lastTime: {},
  nViewers: 0,
  timeMax: 0,
};
const panelName = "replayer";

const Replayer = () => {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const routeParams = useParams();
  const batchId = Array.isArray(routeParams?.id)
    ? routeParams?.id[0]
    : routeParams?.id;
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const timeTypographyRef = useRef<HTMLDivElement>(null);
  const timeSliderRef = useRef<HTMLDivElement>(null);
  const sTypographyRef = useRef<HTMLDivElement>(null);

  const egos = useAppSelector((state) => state.batch.egos);
  const viewerMode = useAppSelector((state) => state.batch.viewerMode);
  const batchTrials = useAppSelector((state) => {
    let result: Trial[] = [];
    for (const egoTrials of Object.values(state.batch.trials)) {
      result = [...result, ...egoTrials];
    }
    return result;
  });
  const showFullTimeline = useAppSelector(
    (state) => state.batch.showFullHeatmap,
  );
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const selectedBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis,
  );
  const timeOrS = useAppSelector((state) => state.batch.timeOrS);
  const durationMode = useAppSelector((state) => state.batch.durationMode);
  const savedTrials = useMemo(() => {
    if (!trajectoryAnalysis) {
      return [];
    }
    let result: Trial[] = [];
    for (const egoName of Object.keys(trajectoryAnalysis)) {
      let mfpca = trajectoryAnalysis[egoName].mfpca[durationMode];
      let trials: Trial[] = [];
      for (const trialId of Object.keys(mfpca?.scores ?? {})) {
        trials.push(trajectoryAnalysis[egoName].trials[trialId]);
      }
      result = [...result, ...trials];
    }
    return result;
  }, [trajectoryAnalysis]);
  const mfpca = useMemo(() => {
    if (trajectoryAnalysis == null) {
      return null;
    }
    const result: any = {};
    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      result[egoName] = trajectoryAnalysis[egoName].mfpca[durationMode];
    }
    return result;
  }, [trajectoryAnalysis, durationMode]);
  const filteredTrialIds = useAppSelector(
    (state) => state.batch.filteredTrialIds,
  );
  const selectedTrialId = useAppSelector(
    (state) => state.batch.selectedTrialId,
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.batch.selectedTrialIds,
  );
  const replayerTraceTrialId = useAppSelector(
    (state) => state.batch.replayerTraceTrialId,
  );
  const replayerTraceByCluster = useAppSelector(
    (state) => state.batch.replayerTraceByCluster,
  );
  const [containerAspect, setContainerAspect] = useState(1);

  const [sliderSRatio, setSliderSRatio] = useState(0);
  const [loading, setLoading] = useState(true);
  const [viewerData, setViewerData] = useState<{
    [egoName: string]: {
      [name: string]: {
        agentsData: {
          [trialId: string]: {
            [name: string]: {
              // shapeSymbol: Graphics;
              graphics: Graphics | Sprite;
              sprite?: Sprite;
              getPositionAtTime: (
                t: number,
              ) => ReturnType<typeof getPositionAtTime>;
              getPositionAtS: (
                sRatio: number,
              ) => ReturnType<typeof getPositionAtS>;
            };
          };
        };
        tick: (ticker: Ticker) => void;
        shapes: Container;
      };
    };
  } | null>(null);

  const [redrawHandled, setRedrawHandled] = useState(false);

  const clusterInfo = useAppSelector(
    (state) => state.batch.selectedClusterInfos,
  );
  const clusteringResult = useAppSelector(
    (state) => state.batch.selectedClusteringResults,
  );
  const clusterAnalysisByEgo = useAppSelector(
    (state) => state.batch.clusterAnalysisByEgo,
  );
  const highlightRolesByTrialId = useAppSelector(
    (state) => state.batch.highlightRolesByTrialId,
  );

  const cameraFocusRef = useRef({
    replayerTraceTrialId: null as string | null,
    replayerTraceByCluster: {} as Record<string, string>,
    selectedTrialIds: { by: "", value: [] as string[] },
    highlightRolesByTrialId: {} as typeof highlightRolesByTrialId,
    clusterAnalysisByEgo: null as typeof clusterAnalysisByEgo,
  });
  cameraFocusRef.current = {
    replayerTraceTrialId,
    replayerTraceByCluster,
    selectedTrialIds,
    highlightRolesByTrialId,
    clusterAnalysisByEgo,
  };

  const clipTimeManualOverride = useAppSelector(
    (state) => state.batch.clipTimeManualOverride,
  );
  const clipTimePaused = useAppSelector((state) => state.batch.clipPaused);
  // const isBaseline = useAppSelector((state) => state.batch.baselineMode);

  const metricColorscale = useMemo(() => {
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      return chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
    }
    return chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
  }, [selectedMetric, trajectoryAnalysis]);

  const [showLegend, setShowLegend] = useState(true);
  const [splitMode, setSplitMode] = useState(true);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [menuOpened, setMenuOpened] = useState<string | null>(null);
  const handleMenuAnchorClick = (event: MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
    setMenuOpened(null);
  };

  const [metricMedian, setMetricMedian] = useState<null | number>(null);
  const [criticalityViewAverage, setCriticalityViewAverage] = useState<{
    [name: string]: number;
  } | null>(null);

  const replayTimeSec = clipTimeManualOverride ?? 0;
  const [displayTimeSec, setDisplayTimeSec] = useState(replayTimeSec);
  const [motiveOpen, setMotiveOpen] = useState<{
    key: string;
    title: string;
    text: string;
  } | null>(null);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    const updateAspect = () => {
      const rect = el.getBoundingClientRect();
      if (rect.width > 0 && rect.height > 0) {
        setContainerAspect(rect.width / rect.height);
      }
    };
    updateAspect();
    const observer = new ResizeObserver(updateAspect);
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const getClusterCaption = useCallback(
    (egoName: string, clusterLabel: string) => {
      if (selectedTrialIds.value.length === 0) return null;

      const ctx = clusterAnalysisByEgo?.[egoName] ?? null;
      const result = clusteringResult?.[egoName] ?? null;

      return resolveReplayerClusterCaption({
        clusterLabel,
        ctx,
        selectedTrialIds,
        highlightRolesByTrialId,
        trialClusterLabel: (trialId: string) => {
          const label = result?.data?.[trialId]?.label;
          if (label == null) {
            // Try numeric / string key variants.
            const alt =
              result?.data?.[String(Number(trialId))]?.label ??
              result?.data?.[String(trialId)]?.label;
            return alt != null ? String(alt) : null;
          }
          return String(label);
        },
      });
    },
    [
      clusterAnalysisByEgo,
      clusteringResult,
      selectedTrialIds,
      highlightRolesByTrialId,
    ],
  );

  const firstActiveCaption = useMemo(() => {
    for (const egoName of egos) {
      const ctx = clusterAnalysisByEgo?.[egoName];
      const labels = ctx?.hasAnalysis
        ? Object.keys(ctx.interpretations)
        : Object.keys(clusterInfo?.[egoName] ?? {});
      for (const label of labels) {
        const caption = getClusterCaption(egoName, label);
        if (caption) return { ...caption, egoName };
      }
      // Fallback: still try visible cluster windows from clustering result.
      if (labels.length === 0 && clusteringResult?.[egoName]?.data) {
        const seen = new Set<string>();
        for (const trialId of Object.keys(clusteringResult[egoName].data)) {
          const lab = String(
            clusteringResult[egoName].data[trialId]?.label ?? "",
          );
          if (!lab || seen.has(lab)) continue;
          seen.add(lab);
          const caption = getClusterCaption(egoName, lab);
          if (caption) return { ...caption, egoName };
        }
      }
    }
    return null;
  }, [
    egos,
    clusterAnalysisByEgo,
    clusterInfo,
    clusteringResult,
    getClusterCaption,
  ]);

  useEffect(() => {
    if (clipTimeManualOverride != null && clipTimePaused) {
      setDisplayTimeSec(clipTimeManualOverride);
    }
  }, [clipTimeManualOverride, clipTimePaused]);

  // Sync analysis caption time from the same clock the replayer ticker writes
  // (timeTypographyRef). clipTimeManualOverride alone does not update during play.
  useEffect(() => {
    if (timeOrS !== "time") return undefined;
    const id = window.setInterval(() => {
      const text = timeTypographyRef.current?.innerText?.trim();
      if (!text) return;
      const t = parseFloat(text);
      if (!Number.isNaN(t)) {
        setDisplayTimeSec(t);
      }
    }, 50);
    return () => window.clearInterval(id);
  }, [timeOrS]);

  const [viewers, setViewers] = useState<{
    [egoName: string]: {
      [name: string]: {
        app: Application;
        viewport: Viewport;
        sceneNode: Container;
        egoTexture: Texture;
      };
    };
  } | null>(null);

  const [trajectories, setTrajectories] = useState<
    | {
        [egoName: string]: {
          [trialId: string]: TrajectoryResponseData;
        };
      }
    | undefined
  >(undefined);

  const egoKinematicsFor = useCallback(
    (egoName: string, medoidId: string | undefined) => {
      if (!medoidId || !trajectories) {
        return { velocityMps: null, accelMps2: null };
      }
      const egoTrajectories = trajectories[egoName] ?? trajectories["main"] ?? {};
      const traj =
        egoTrajectories[medoidId] ??
        egoTrajectories[String(Number(medoidId))] ??
        undefined;
      const egoPoses = traj?.trajectory?.Ego as
        | Array<{ x: number; y: number; speed?: number }>
        | undefined;
      return sampleEgoKinematicsAtTime(traj?.time, egoPoses, displayTimeSec);
    },
    [trajectories, displayTimeSec],
  );

  useEffect(() => {
    appData.paused = clipTimePaused;
  }, [clipTimePaused]);
  useEffect(() => {
    appData.manualTimeChanged = 0;
    appData.manualTimeOverride = clipTimeManualOverride ?? 0;
  }, [clipTimeManualOverride]);

  useEffect(() => {
    if (trajectoryAnalysis != null) {
      return;
    }
    const trialIds = selectedTrialIds.value.map((v) => Number(v)).filter((id) => id > 0);
    if (trialIds.length === 0) {
      return;
    }
    const fetchData = async () => {
      dispatch(batchSlice.actions.setClipTimeManualOverride(0));
      try {
        const updated: typeof trajectories = {};
        updated["main"] = {};

        const trajData = await getTrajectories({
          trialIds,
          framePeriod: 0.25,
        }).then((response) => response.data);

        for (const traj of trajData) {
          updated["main"][traj["trialId"]] = traj;
        }

        setTrajectories(updated);
      } catch (error) {
        console.error("Failed to fetch trajectory data.", error);
      }
    };
    fetchData();
  }, [selectedTrialIds, trajectoryAnalysis]);

  useEffect(() => {
    async function fetchAndUnzip() {
      if (trajectoryAnalysis == null) {
        return;
      }
      const updated: typeof trajectories = {};
      for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
        const url = trajectoryAnalysis[egoName].trajectoriesFileinfo.url;
        const response = await axios.get(url ?? "", {
          responseType: "arraybuffer",
        });

        const zipBlob = await response.data;

        const zip = await JSZip.loadAsync(zipBlob);

        const jsonFileName = Object.keys(zip.files).find((name) =>
          name.endsWith(".json"),
        );
        if (jsonFileName == null) throw new Error("No JSON file found in ZIP");

        const jsonText = await zip.file(jsonFileName)?.async("text");
        const jsonObject = JSON.parse(jsonText ?? "");

        updated[egoName] = jsonObject;
      }
      setTrajectories(updated);
    }

    fetchAndUnzip();
  }, [trajectoryAnalysis]);

  // ---------------------------------------------------------------------------
  // Analysis-stage clip from esmini CSV + clip_conditions.yaml
  // ---------------------------------------------------------------------------
  // true  = Replayer uses config-clipped CSV (same rule as LLM timelines).
  // false = keep Payload / analysis-zip only (sim-upload clip).
  // Toggle by commenting/uncommenting the two lines below:
  const USE_ANALYSIS_CLIP_CSV = true;
  // const USE_ANALYSIS_CLIP_CSV = false;
  //
  // Switch clip geometry in: app/analyzer/config/clip_conditions.yaml
  //   active: current_startvalid      # legacy road-92
  //   # active: analysis_adjustable   # editable world-XY
  // ---------------------------------------------------------------------------
  useEffect(() => {
    if (!USE_ANALYSIS_CLIP_CSV) {
      dispatch(batchSlice.actions.setHeatmapClipOffsetSec(0));
      return undefined;
    }
    if (trajectories == null || batchId == null) {
      return undefined;
    }
    let cancelled = false;

    const applyAnalysisClippedCsv = async () => {
      const patched: NonNullable<typeof trajectories> = {};
      for (const [egoName, egoTrajs] of Object.entries(trajectories)) {
        patched[egoName] = { ...egoTrajs };
      }

      let changed = false;
      // Offsets are trial-dependent — never take max across trials (overshoots playhead).
      const offsetsByTrial = new Map<string, number>();

      const ingestEsmini = (
        egoBucket: Record<string, TrajectoryResponseData>,
        trialId: string,
        data: TrajectoryResponseData & {
          source?: string;
          heatmapClipOffsetSec?: number;
        },
      ) => {
        egoBucket[trialId] = { ...data, trialId: Number(trialId) };
        changed = true;
        const off = Number(data.heatmapClipOffsetSec ?? 0);
        if (Number.isFinite(off) && off >= 0) {
          offsetsByTrial.set(String(trialId), off);
        }
      };

      const noteOffset = (
        trialId: string,
        data: { heatmapClipOffsetSec?: number },
      ) => {
        const off = Number(data.heatmapClipOffsetSec ?? 0);
        if (Number.isFinite(off) && off >= 0) {
          offsetsByTrial.set(String(trialId), off);
        }
      };

      // Medoids from cluster analysis folders
      if (trajectoryAnalysis != null) {
        for (const egoName of Object.keys(clusterAnalysisByEgo ?? {})) {
          const ctx = clusterAnalysisByEgo?.[egoName];
          if (!ctx?.hasAnalysis && !ctx?.hasPreprocess) continue;
          const egoBucket = patched[egoName];
          if (egoBucket == null) continue;

          for (const [label, trialId] of Object.entries(ctx.medoids)) {
            const existing = egoBucket[trialId] as
              | (TrajectoryResponseData & {
                  source?: string;
                  clipProfile?: string | null;
                  clipStartEsminiS?: number | null;
                  heatmapClipOffsetSec?: number;
                })
              | undefined;
            if (existing == null) continue;
            try {
              const resp = await fetch(
                `/api/esmini-trajectory?batchId=${encodeURIComponent(
                  String(batchId),
                )}&folder=${encodeURIComponent(
                  ctx.folder,
                )}&label=${encodeURIComponent(label)}`,
              );
              if (!resp.ok) continue;
              const data = await resp.json();
              if (data?.trajectory == null || !Array.isArray(data?.time)) continue;
              // Skip replace when clip start unchanged (avoids setTrajectories loop).
              // Use Object.is so missing clipStart (NaN) still compares equal —
              // `NaN === NaN` is false and used to re-fetch forever.
              if (
                existing.source === "esmini" &&
                Object.is(
                  Number(data.clipStartEsminiS ?? NaN),
                  Number(existing.clipStartEsminiS ?? NaN),
                ) &&
                Object.is(
                  Number(data.heatmapClipOffsetSec ?? 0),
                  Number(existing.heatmapClipOffsetSec ?? 0),
                )
              ) {
                noteOffset(trialId, data);
                continue;
              }
              ingestEsmini(egoBucket, trialId, data);
            } catch {
              /* keep Payload trajectory */
            }
          }
        }
      }

      // Selected trials (need esminiDat.filename / trialIndex when available)
      const selectedIds = selectedTrialIds.value ?? [];
      if (selectedIds.length > 0) {
        const patchTasks: Promise<void>[] = [];
        for (const egoName of Object.keys(patched)) {
          const egoBucket = patched[egoName];
          if (egoBucket == null) continue;
          const egoTrials = (
            trajectoryAnalysis != null
              ? (trajectoryAnalysis[egoName]?.trials as
                  | Record<string, Record<string, unknown>>
                  | undefined)
              : undefined
          );

          for (const trialId of selectedIds) {
            const existing = egoBucket[trialId] as
              | (TrajectoryResponseData & {
                  source?: string;
                  clipStartEsminiS?: number | null;
                  heatmapClipOffsetSec?: number;
                })
              | undefined;
            if (existing == null) continue;

            const meta = egoTrials?.[trialId] as
              | { batchId?: string; esminiDat?: { filename?: string }; trialIndex?: number }
              | undefined;
            const filename = meta?.esminiDat?.filename ?? "";
            const m = /esmini_(\d+)_(\d+)\.dat/.exec(filename);
            const csvBatch = m ? m[1] : (meta?.batchId ?? String(batchId));
            const csvIndex =
              m?.[2] ??
              (meta?.trialIndex != null ? String(meta.trialIndex) : null);

            let url = `/api/esmini-trajectory?batchId=${encodeURIComponent(
              String(csvBatch),
            )}&trialId=${encodeURIComponent(trialId)}`;
            if (csvIndex != null) {
              url += `&trialIndex=${encodeURIComponent(csvIndex)}`;
            }

            patchTasks.push(
              (async () => {
                try {
                  const resp = await fetch(url);
                  if (!resp.ok) return;
                  const data = await resp.json();
                  if (data?.trajectory == null || !Array.isArray(data?.time)) {
                    return;
                  }
                  if (
                    existing.source === "esmini" &&
                    Object.is(
                      Number(data.clipStartEsminiS ?? NaN),
                      Number(existing.clipStartEsminiS ?? NaN),
                    ) &&
                    Object.is(
                      Number(data.heatmapClipOffsetSec ?? 0),
                      Number(existing.heatmapClipOffsetSec ?? 0),
                    )
                  ) {
                    noteOffset(trialId, data);
                    return;
                  }
                  ingestEsmini(egoBucket, trialId, data);
                } catch {
                  /* keep Payload */
                }
              })(),
            );
          }
        }
        await Promise.all(patchTasks);
      }

      // Collect offsets already on trajs (when we skipped fetches).
      if (offsetsByTrial.size === 0) {
        for (const egoBucket of Object.values(patched)) {
          for (const [tid, traj] of Object.entries(egoBucket)) {
            const off = Number(
              (traj as { heatmapClipOffsetSec?: number })
                .heatmapClipOffsetSec ?? 0,
            );
            if (Number.isFinite(off) && off > 0) {
              offsetsByTrial.set(String(tid), off);
            }
          }
        }
      }

      // Prefer the trial driving the Replayer clock — not max/random batch CSV.
      const preferredIds = [
        replayerTraceTrialId,
        selectedTrialId != null ? String(selectedTrialId) : null,
        ...(selectedIds.map(String) ?? []),
      ].filter((x): x is string => x != null && x !== "");

      let chosenOffset = 0;
      for (const tid of preferredIds) {
        const off = offsetsByTrial.get(tid) ?? offsetsByTrial.get(String(Number(tid)));
        if (off != null && Number.isFinite(off)) {
          chosenOffset = off;
          break;
        }
      }
      if (chosenOffset === 0 && offsetsByTrial.size > 0) {
        // Median of known trial offsets (stable vs max which overshoots).
        const sorted = [...offsetsByTrial.values()].sort((a, b) => a - b);
        chosenOffset = sorted[Math.floor(sorted.length / 2)] ?? 0;
      }

      // Fallback API only when we still have nothing (e.g. before trajs load).
      // Never replace a positive offset with API 0 (batch9 has no esmini_9_*).
      if (chosenOffset === 0) {
        try {
          const resp = await fetch(
            `/api/heatmap-clip-offset?batchId=${encodeURIComponent(String(batchId))}`,
            { cache: "no-store" },
          );
          if (resp.ok) {
            const data = (await resp.json()) as {
              heatmapClipOffsetSec?: number;
            };
            const off = Number(data.heatmapClipOffsetSec ?? 0);
            if (Number.isFinite(off) && off > 0) chosenOffset = off;
          }
        } catch {
          /* keep 0 */
        }
      }

      if (!cancelled) {
        // Only write when something actually changed — otherwise replacing the
        // trajectories object every pass re-triggers this effect (trajectories
        // is in the dependency list) and floods /api/esmini-trajectory.
        dispatch(batchSlice.actions.setHeatmapClipOffsetSec(chosenOffset));
        if (changed) {
          setTrajectories(patched);
          dispatch(batchSlice.actions.setClipTimeManualOverride(0));
        }
      }
    };

    void applyAnalysisClippedCsv();
    return () => {
      cancelled = true;
    };
  }, [
    trajectoryAnalysis,
    trajectories,
    batchId,
    clusterAnalysisByEgo,
    selectedTrialIds,
    selectedTrialId,
    replayerTraceTrialId,
    dispatch,
  ]);

  // Keep Payload / analysis-zip when USE_ANALYSIS_CLIP_CSV is false.
  // Analysis-clip mode (above) rebases from raw/clipped esmini CSV using
  // app/analyzer/config/clip_conditions.yaml so Replayer matches LLM timelines.

  const clusterCounter = useMemo(() => {
    let trials: Trial[] = batchTrials;
    if (trajectoryAnalysis != null) {
      trials = savedTrials;
    }

    const trialIds =
      filteredTrialIds.length === 0
        ? trials.map((t) => String(t?.id))
        : filteredTrialIds;

    const counter: { [egoName: string]: { [clusterLabel: string]: number } } =
      {};

    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      // if ( clusteringResult[egoName] == null) {
      //   continue;
      // }
      counter[egoName] = {};
      for (const trialId of trialIds) {
        if (
          clusteringResult == null ||
          clusterInfo == null ||
          mfpca == null ||
          clusteringResult[egoName] == null
        ) {
          if (!("0" in counter)) {
            counter[egoName]["0"] = 0;
          }
          counter[egoName]["0"] += 1;
          continue;
        }
        if (!(trialId in clusteringResult[egoName].data)) {
          continue;
        }
        const label = clusteringResult[egoName].data[trialId].label;
        if (label != null && !(label in counter)) {
          counter[egoName][label] = 0;
        }
        if (label != null) {
          counter[egoName][label] += 1;
        }
      }
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, mfpca]);

  const passFailCounter = useMemo(() => {
    if (clusteringResult == null || clusterInfo == null || mfpca == null) {
      return;
    }
    const counter: { [egoName: string]: { [clusterLabel: string]: number } } =
      {};

    let trials: Trial[] = batchTrials;
    if (trajectoryAnalysis != null) {
      trials = savedTrials;
    }

    const trialIds =
      filteredTrialIds.length === 0
        ? trials.map((t) => String(t?.id))
        : filteredTrialIds;

    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      if (clusteringResult[egoName] == null) {
        continue;
      }

      counter[egoName] = {};
      for (const trialId of trialIds) {
        if (!(trialId in clusteringResult[egoName].data)) {
          continue;
        }

        const trial = trials?.find((t) => t?.id === Number(trialId));
        const passed = trial?.testObjectives?.criticalityMetrics.find(
          (m) =>
            m.keyPerformanceIndicator.id === selectedBoundaryMetric?.kpi?.id,
        )?.passed;
        const label = passed ? "pass" : "fail";
        if (!(label in counter)) {
          counter[egoName][label] = 0;
        }
        counter[egoName][label] += 1;
      }
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, mfpca]);

  // Which cluster windows to show in split mode. When the user has selected
  // trajectories (in Parameter/Projection space), only show the windows for the
  // clusters those trials belong to. With no selection, show every cluster.
  const selectedClusterLabelsByEgo = useMemo(() => {
    if (selectedTrialIds.value.length === 0) return null;
    const result: { [egoName: string]: Set<string> } = {};
    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      const data = clusteringResult?.[egoName]?.data;
      if (data == null) continue;
      const labels = new Set<string>();
      for (const tid of selectedTrialIds.value) {
        const label = data[tid]?.label;
        if (label != null) labels.add(String(label));
      }
      if (labels.size > 0) result[egoName] = labels;
    }
    return Object.keys(result).length > 0 ? result : null;
  }, [selectedTrialIds, clusteringResult, trajectoryAnalysis]);

  const isClusterWindowVisible = useCallback(
    (egoName: string, label: string) => {
      const inCounter =
        clusterCounter != null &&
        egoName in clusterCounter &&
        label in clusterCounter[egoName];
      if (!inCounter) return false;
      const sel = selectedClusterLabelsByEgo?.[egoName];
      if (sel == null) return true;
      return sel.has(String(label));
    },
    [clusterCounter, selectedClusterLabelsByEgo],
  );

  // Identity of the currently visible cluster-window set. Used to resize
  // existing Pixi apps after CSS show/hide — NOT to destroy/recreate them
  // (that was the main source of highlight/medoid choppiness).
  const visibleClusterKey = useMemo(() => {
    if (selectedClusterLabelsByEgo == null) return "all";
    return Object.entries(selectedClusterLabelsByEgo)
      .map(([ego, set]) => `${ego}:${[...set].sort().join(",")}`)
      .sort()
      .join("|");
  }, [selectedClusterLabelsByEgo]);

  // After highlight toggles hide/show panes via display:none, resize the
  // remaining WebGL canvases to the new layout without a full rebuild.
  useEffect(() => {
    if (viewers == null) return;
    const handle = requestAnimationFrame(() => {
      for (const egoName of Object.keys(viewers)) {
        for (const [label, viewer] of Object.entries(viewers[egoName] ?? {})) {
          if (!isClusterWindowVisible(egoName, label)) continue;
          const container = document.getElementById(
            `replayer-${egoName}-cluster${label}-canvas-container`,
          );
          if (container == null || viewer?.app == null) continue;
          const { width, height } = container.getBoundingClientRect();
          if (width <= 0 || height <= 0) continue;
          viewer.app.renderer.resize(width, height);
          viewer.viewport?.resize(width, height);
        }
      }
    });
    return () => cancelAnimationFrame(handle);
  }, [visibleClusterKey, viewers, isClusterWindowVisible]);
  useEffect(() => {
    if (redrawHandled) {
      console.log("REDRAW Replayer Already, Return");
      return;
    }
    console.log("REDRAW Replayer");

    const initApp = async () => {
      console.log("INIT APP");
      const egoTexture = (await Assets.load("/car.png")) as Texture;
      if (
        clusteringResult != null &&
        // splitMode &&
        // clusterInfo != null &&
        viewerMode === "interaction-cluster"
      ) {
        // let totalWindowsCount = 0;
        // for (const egoName of Object.keys(clusterInfo)) {
        //   for (const label in clusterInfo[egoName]) {
        //     if (clusterCounter && label in clusterCounter[egoName]) {
        //       totalWindowsCount += 1;
        //     }
        //   }
        // }
        console.log("REDRAWHANDLED interaction-cluster replayer");
        const newViewers: typeof viewers = {};
        for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
          if (
            trajectoryAnalysis == null ||
            trajectoryAnalysis[egoName] == null
          ) {
            continue;
          }

          newViewers[egoName] = {};
          const egoClusterInfo =
            clusterInfo && clusterInfo[egoName]
              ? clusterInfo[egoName]
              : { "0": { count: 0, color: "black" } };
          for (const label of Object.keys(egoClusterInfo)) {
            // await sleep(100);
            const container = document.getElementById(
              `replayer-${egoName}-cluster${label}-canvas-container`,
            );
            const canvas = document.getElementById(
              `replayer-${egoName}-cluster${label}-canvas`,
            ) as HTMLCanvasElement;

            // canvas.height =
            //   (containerRef.current?.offsetHeight ?? 0) / totalWindowsCount;
            // canvas.width = containerRef.current?.offsetWidth ?? 0;

            if (container == null || canvas == null) {
              console.log(
                `no ${egoName} ${label} container or canvas, continue...`,
              );
              continue;
            }
            const gl = canvas.getContext("webgl2");
            if (!gl) {
              console.error("WebGL2 not supported");
              continue;
            }

            const { width, height } = container.getBoundingClientRect();

            const app = new Application();
            await app.init({
              canvas: canvas,
              width,
              height,
              backgroundColor: "white",
              resizeTo: container,
              antialias: true,
              autoDensity: true,
            });

            const sceneNode = new Container();
            sceneNode.scale.y = -1;
            const map = await SVGScene.from("/map.svg");
            const bounds = map.getLocalBounds();
            sceneNode.addChild(map);

            const viewport = new Viewport({
              screenWidth: app.canvas.width,
              screenHeight: app.canvas.height,
              worldWidth: bounds.width,
              worldHeight: bounds.height,
              events: app.renderer.events, // the interaction module is important for wheel to work properly when renderer.view is placed or scaled
            });
            viewport.drag().pinch().wheel();
            app.stage.addChild(viewport);
            viewport.addChild(sceneNode);

            newViewers[egoName][label] = {
              app,
              viewport,
              sceneNode,
              egoTexture,
            };
          }
        }
        function syncViewportTransform(master: Viewport, target: Viewport) {
          // Zoom only: each pane centers on its own focus ego during playback.
          target.scale.copyFrom(master.scale);
        }
        const flatViewers: {
          app: Application;
          viewport: Viewport;
          sceneNode: Container;
          egoTexture: Texture;
        }[] = [];
        for (const egoName of Object.keys(newViewers)) {
          for (const viewer of Object.values(newViewers[egoName])) {
            flatViewers.push(viewer);
          }
        }
        for (const viewer of flatViewers) {
          viewer.viewport.on("moved", () => {
            for (const other of flatViewers) {
              if (other === viewer) {
                continue;
              }
              syncViewportTransform(viewer.viewport, other.viewport);
            }
            dispatch(interactionSlice.actions.record(panelName + ".camera"));
          });
        }
        appData.nViewers = Object.keys(flatViewers).length;
        setViewers(newViewers);
      } else if (trajectoryAnalysis == null) {
        console.log("MAIN INIT APP SELECT");
        appData.nViewers = 1;
        if (containerRef.current == null || canvasRef.current == null) {
          return;
        }

        const { width, height } = containerRef.current.getBoundingClientRect();

        const app = new Application();
        await app.init({
          canvas: canvasRef.current,
          width,
          height,
          backgroundColor: "white",
          resizeTo: containerRef.current,
          antialias: true,
          autoDensity: true,
        });

        const sceneNode = new Container();
        sceneNode.scale.y = -1;
        const map = await SVGScene.from("/map.svg");
        const bounds = map.getLocalBounds();
        sceneNode.addChild(map);

        const viewport = new Viewport({
          screenWidth: app.canvas.width,
          screenHeight: app.canvas.height,
          worldWidth: bounds.width,
          worldHeight: bounds.height,
          events: app.renderer.events, // the interaction module is important for wheel to work properly when renderer.view is placed or scaled
        });
        viewport.drag().pinch().wheel();
        app.stage.addChild(viewport);
        viewport.addChild(sceneNode);

        setViewers({
          main: {
            main: { app, viewport, sceneNode, egoTexture },
          },
        });
      } else {
        console.log("NO REDRAW AT ALL");
        setRedrawHandled(true);
      }
      // console.log("REDRAWHANDLED TO TRUE");
      // dispatch(batchSlice.actions.setReplayerRedrawHandled(true));
    };

    initApp();

    return () => {
      if (viewers == null) {
        return;
      }
      console.log("destroy app");
      for (const egoName of Object.keys(viewers ?? {})) {
        for (const viewer of Object.values(viewers[egoName] ?? {})) {
          viewer?.sceneNode?.destroy({ children: true, context: true });
          viewer?.viewport?.destroy({ children: true, context: true });
          // viewer?.app?.destroy();
        }
      }
    };
  }, [redrawHandled]);

  useEffect(() => {
    // Clustering / filter changes need a full Pixi rebuild. Highlight-driven
    // visibleClusterKey changes do NOT — those only toggle display:none and
    // resize via the effect above.
    setRedrawHandled(false);
  }, [clusterInfo, filteredTrialIds]);

  useEffect(() => {
    // Switching time↔s mode needs a rebuild once. Do NOT rebuild on every
    // selectedTrialIds change — that made medoid/highlight toggles destroy
    // WebGL and redraw all agents.
    if (timeOrS === "s") {
      setRedrawHandled(false);
    }
  }, [timeOrS]);
  useEffect(() => {
    const handleKeyPress = (event: KeyboardEvent) => {
      if (event.code === "Space") {
        console.log("PRESS SPACE");
        dispatch(batchSlice.actions.setClipPaused(!appData.paused));
        dispatch(
          interactionSlice.actions.record(
            panelName + (appData.paused ? ".pause" : ".resume"),
          ),
        );
      }
    };
    window.addEventListener("keydown", handleKeyPress);
    return () => {
      window.removeEventListener("keydown", handleKeyPress);
    };
  }, [window]);

  useEffect(() => {
    globalStorage.ITRI.trialIdForS =
      replayerTraceTrialId ?? selectedTrialIds.value[0];
  }, [selectedTrialIds, replayerTraceTrialId]);

  useEffect(() => {
    if (
      viewers == null ||
      trajectories == null ||
      timeSliderRef.current == null ||
      timeTypographyRef == null
      // mfpca == null
    ) {
      console.log("RETURN REPLAYER");
      console.log(trajectories);
      return;
    }
    console.log("DRAW AGENTS");

    let trials: Trial[] = batchTrials;
    if (trajectoryAnalysis != null) {
      trials = savedTrials;
    }

    const newViewerData: typeof viewerData = {};

    const criticalityHalfs: {
      [name: string]: { [trialId: string]: number };
    } = { head: {}, tail: {} };

    const criticalityViewMetrics: { [name: string]: number[] } = {
      head: [],
      tail: [],
    };

    let newTimeMax = 0;
    for (const egoName of Object.keys(viewers)) {
      newViewerData[egoName] = {};
      for (const [viewerName, viewer] of Object.entries(viewers[egoName])) {
        const viewport = viewer.viewport;
        const sceneNode = viewer.sceneNode;
        const app = viewer.app;

        newViewerData[egoName][viewerName] = {
          agentsData: {},
          tick: (ticker: Ticker) => {},
          shapes: new Container(),
        };

        const agentsData = newViewerData[egoName][viewerName].agentsData;
        const shapes = newViewerData[egoName][viewerName].shapes;
        sceneNode.addChild(shapes);

        const metricValueMapping: { [trialId: string]: number } = {};

        function median(values: number[]): number {
          if (values.length === 0) {
            return 0;
          }
          values = [...values].sort((a, b) => a - b);
          const half = Math.floor(values.length / 2);
          return values.length % 2
            ? values[half]
            : (values[half - 1] + values[half]) / 2;
        }
        function average(values: number[]): number {
          if (values.length === 0) {
            return 0;
          }
          let sum = 0;
          values.forEach((v) => (sum += v));
          return sum / values.length;
        }

        const metricViewerRange: {
          [viewrName: string]: { max: number; min: number };
        } = {};

        const egoTrajectories = trajectories[egoName] ?? {};
        for (const [trialIndex, [trialId, trajectory]] of Object.entries(
          egoTrajectories,
        ).entries()) {
          if (
            trajectoryAnalysis != null &&
            filteredTrialIds.length !== 0 &&
            filteredTrialIds != null &&
            !filteredTrialIds.includes(trialId)
          ) {
            continue;
          }
          const label =
            clusteringResult != null &&
            egoName in clusteringResult &&
            clusteringResult[egoName] != null
              ? clusteringResult[egoName].data?.[trialId]?.label
              : "0";
          if (trajectoryAnalysis != null && label == null) {
            continue;
          }

          const trial = trials?.find((t) => t?.id === Number(trialId));
          const metricValue = trial?.testObjectives?.criticalityMetrics.find(
            (m) => m.keyPerformanceIndicator.id === selectedMetric?.kpi?.id,
          )?.value;
          if (metricValue) {
            metricValueMapping[trialId] = metricValue;
          }
        }

        const metricMedian = median(Object.values(metricValueMapping));
        const metricAverage = average(Object.values(metricValueMapping));
        setMetricMedian(metricMedian);

        const visited = new Set<string>();

        for (const [trialIndex, [trialId, trajectory]] of Object.entries(
          egoTrajectories,
        ).entries()) {
          if (
            trajectoryAnalysis != null &&
            filteredTrialIds.length !== 0 &&
            filteredTrialIds != null &&
            !filteredTrialIds.includes(trialId)
          ) {
            continue;
          }

          const label =
            clusteringResult != null &&
            egoName in clusteringResult &&
            clusteringResult[egoName] != null
              ? clusteringResult[egoName].data?.[trialId]?.label
              : "0";

          if (trajectoryAnalysis != null && clusteringResult?.[egoName] != null && label == null) {
            continue;
          }

          newTimeMax = Math.max(
            newTimeMax,
            trajectory["time"][trajectory["time"].length - 1],
          );

          if (
            // !isBaseline &&
            clusteringResult != null &&
            viewerName !== label &&
            splitMode &&
            viewerMode === "interaction-cluster"
          ) {
            continue;
          }

          const trial = trials?.find((t) => t?.id === Number(trialId));
          const metricValue = trial?.testObjectives?.criticalityMetrics.find(
            (m) => m.keyPerformanceIndicator.id === selectedMetric?.kpi?.id,
          )?.value;

          if (viewerName in criticalityViewMetrics && metricValue != null) {
            criticalityViewMetrics[viewerName].push(metricValue);
            criticalityHalfs[viewerName][trialId] = metricValue;
          }

          const metricColor = metricColorscale(
            ((metricValue ?? 0) - (selectedMetric?.min ?? 0)) /
              ((selectedMetric?.max ?? 1) - (selectedMetric?.min ?? 0)),
          ).hex();
          const passed = trial?.testObjectives?.criticalityMetrics.find(
            (m) =>
              m.keyPerformanceIndicator.id === selectedBoundaryMetric?.kpi?.id,
          )?.passed;
          if (
            // !isBaseline &&
            clusteringResult != null &&
            trajectoryAnalysis != null &&
            splitMode &&
            viewerMode === "pass/fail" &&
            selectedMetric != null &&
            passed != null &&
            ((passed && viewerName === "fail") ||
              (!passed && viewerName == "pass"))
          ) {
            continue;
          }
          // if (clusterInfo[egoName] == null) {
          //   continue;
          // }

          agentsData[trialId] = {};
          const egoTraj = trajectory.trajectory["Ego"];
          const ss = egoTraj.map((i) => i["s_ratio"]);
          for (const [agentIndex, [agentName, agentTraj]] of Object.entries(
            trajectory.trajectory ?? {},
          ).entries()) {
            let color = agentName === "Ego" ? chroma("blue") : chroma("red");
            let alpha = 1.0;

            if (
              // !isBaseline &&
              clusteringResult != null &&
              label != null &&
              clusterInfo != null &&
              clusterInfo[egoName] != null
            ) {
              color = chroma(clusterInfo[egoName][label].color).alpha(alpha);
            }
            if (viewerMode === "pass/fail") {
              color = chroma(
                passed
                  ? theme.palette.success.light
                  : theme.palette.error.light,
              ).alpha(alpha);
            }

            if (
              // !isBaseline &&
              clusteringResult != null &&
              viewerMode === "interaction-cluster" &&
              label != null &&
              clusterInfo != null &&
              clusterInfo[egoName] != null
            ) {
              // alpha = (0.05 * membership) / maxMembership[label];
              // if (membership === maxMembership[label] && !visited.has(label)) {
              //   alpha = 0.75;
              // }
              color = chroma(clusterInfo[egoName][label].color).alpha(alpha);
            }

            if (!(agentName in agentsData[trialId])) {
              const x = agentTraj[0]["x"];
              const y = agentTraj[0]["y"];
              const yaw = agentTraj[0]["yaw"] % PI_2; // Assuming `yaw` is in radians
              let width = agentTraj[0]["width"] ?? 2.2;
              let length = agentTraj[0]["length"] ?? 5.14;

              width = width == 0 ? 2.2 : width;
              length = length == 0 ? 5.14 : length;

              // let agentGraphic: Graphics | Sprite = new Graphics();
              let agentGraphic: Graphics | Sprite = new Sprite(Texture.WHITE);
              let sprite: Sprite | undefined = undefined;
              if (agentName === "Ego") {
                sprite = new Sprite(viewer.egoTexture);
                // sprite.zIndex = 5;
                sprite.alpha = alpha;
                sprite.tint = color.hex();
                sprite.width = length;
                sprite.height = width;
                sprite.anchor.set(0.5);
                // sprite.pivot.set(length / 2, width / 2);
                sprite.position.set(x, y);
                sprite.rotation = yaw + 3.14;
                shapes.addChild(sprite);
                // Camera follow is applied after all trials are built (focus trial).
              } else {
                agentGraphic.width = width;
                agentGraphic.height = length;

                agentGraphic.tint = color.hex();
                agentGraphic.alpha = alpha;
                agentGraphic.anchor.set(0.5);
                agentGraphic.position.set(x, y);
                agentGraphic.rotation = yaw + 3.14 / 2;
                shapes.addChild(agentGraphic);
              }

              agentsData[trialId][agentName] = {
                graphics: agentGraphic,
                sprite,
                getPositionAtTime: (t: number) => {
                  return getPositionAtTime(
                    t,
                    trajectory.time,
                    agentTraj.map((item, index) => {
                      return {
                        x: item.x,
                        y: item.y,
                        yaw: item.yaw,
                        s_ratio: item.s_ratio,
                      };
                    }),
                  );
                },
                getPositionAtS: (s: number) => {
                  return getPositionAtS(
                    s,
                    ss,
                    agentTraj.map((item, index) => {
                      return {
                        x: item.x,
                        y: item.y,
                        yaw: item.yaw,
                        s_ratio: item.s_ratio,
                      };
                    }),
                  );
                },
              };
            }
          }
        }

        appData.timeMax = newTimeMax;

        const applyCameraFollow = (
          time: number | null,
          sRatio: number | null,
          opts?: { setInitialOrientation?: boolean },
        ) => {
          const focus = cameraFocusRef.current;
          const focusId = resolveReplayerFocusTrial({
            availableTrialIds: Object.keys(agentsData),
            replayerTraceByCluster: focus.replayerTraceByCluster,
            replayerTraceTrialId: focus.replayerTraceTrialId,
            viewerClusterLabel: viewerName,
            clusterAnalysis: focus.clusterAnalysisByEgo?.[egoName] ?? null,
            selectedTrialIds: focus.selectedTrialIds,
            highlightRolesByTrialId: focus.highlightRolesByTrialId,
          });
          if (focusId == null) return;
          const egoAgent = agentsData[focusId]?.["Ego"];
          if (egoAgent == null) return;
          const pos =
            time != null
              ? egoAgent.getPositionAtTime(time)
              : sRatio != null
                ? egoAgent.getPositionAtS(sRatio)
                : null;
          if (pos?.x == null || pos?.y == null) return;
          // Same display as before: map orientation is fixed after framing.
          // Only translate so the focus ego stays centered — do not rotate
          // with ego yaw during playback.
          sceneNode.pivot.set(pos.x, pos.y);
          sceneNode.position.set(0, 0);
          if (opts?.setInitialOrientation) {
            const yaw = pos.yaw ?? 0;
            sceneNode.rotation = -(-yaw + 3.14 / 2);
          }
          viewport.moveCenter(0, 0);
        };

        // Initial framing: match legacy ego-aligned orientation once, then follow
        // by translation only.
        applyCameraFollow(0, null, { setInitialOrientation: true });
        viewport.setZoom(5);

        const update = (ticker: Ticker) => {
          if (timeOrS === "s") {
            return;
          }

          let lastTime =
            egoName + viewerName in appData.lastTime
              ? appData.lastTime[egoName + viewerName]
              : null;
          if (lastTime == null) {
            appData.lastTime[egoName + viewerName] = 0;
          }

          lastTime = appData.lastTime[egoName + viewerName];

          const delta = ticker.deltaMS;
          const time = lastTime + delta / 1000;
          const agentsData = newViewerData[egoName][viewerName].agentsData;
          let i = 0;
          for (const [trialId, trialAgents] of Object.entries(agentsData)) {
            for (const [agentName, agent] of Object.entries(trialAgents)) {
              const agentUpdatedPosition = agent.getPositionAtTime(time);
              agent.graphics.position.set(
                agentUpdatedPosition?.x ?? 10000,
                agentUpdatedPosition?.y ?? 10000,
              );
              agent.graphics.rotation =
                (agentUpdatedPosition?.yaw ?? 0) + 3.14 / 2;
              if (agent.sprite && agentName === "Ego") {
                agent.sprite.position.set(
                  agentUpdatedPosition?.x ?? 10000,
                  agentUpdatedPosition?.y ?? 10000,
                );
                agent.sprite.rotation = (agentUpdatedPosition?.yaw ?? 0) + 3.14;
              }
            }
            i++;
          }

          applyCameraFollow(time, null);

          if (timeTypographyRef.current) {
            timeTypographyRef.current.innerText = time.toFixed(3);
          }
          if (timeSliderRef.current) {
            const inputElement = timeSliderRef.current.querySelector("input");
            if (inputElement) {
              inputElement.value = ((time / appData.timeMax) * 100).toString();
              inputElement.dispatchEvent(timeSliderUpdateEvent);
            }
          }

          appData.lastTime[egoName + viewerName] = time;
        };
        const tick = (ticker: Ticker) => {
          if (
            timeOrS === "time" &&
            appData.manualTimeChanged < appData.nViewers
          ) {
            appData.lastTime[egoName + viewerName] = appData.manualTimeOverride;
            appData.manualTimeChanged += 1;
            update(ticker);
          } else if (!appData.paused) {
            update(ticker);
          }
        };
        app.ticker.add(tick);

        newViewerData[egoName][viewerName].tick = tick;
      }
    }

    setCriticalityViewAverage({
      tail:
        sum(criticalityViewMetrics["tail"]) /
        criticalityViewMetrics["tail"].length,
      head:
        sum(criticalityViewMetrics["head"]) /
        criticalityViewMetrics["head"].length,
    });

    console.log("Set Viewer Data");
    setViewerData(newViewerData);
    setLoading(false);
    setRedrawHandled(true);

    return () => {
      for (const egoName of Object.keys(newViewerData)) {
        for (const [viewerName, item] of Object.entries(
          newViewerData[egoName],
        )) {
          const app = viewers[egoName][viewerName].app;
          app.ticker.remove(item.tick);
          for (const trial of Object.values(item.agentsData)) {
            for (const agent of Object.values(trial)) {
              if (!agent.graphics.destroyed) {
                agent.graphics.destroy({ children: true, context: true });
              }
            }
          }
          item.shapes.destroy({ children: true, context: true });
        }
      }
    };
  }, [
    trajectories,
    viewers,
    timeSliderRef.current,
    timeTypographyRef.current,
    showFullTimeline,
    // colorMode,
  ]);

  useEffect(() => {
    if (trajectoryAnalysis == null || viewerData == null) {
      return;
    }
    for (const egoName of Object.keys(viewerData)) {
      for (const viewerName of Object.keys(viewerData[egoName])) {
        for (const [trialId, item] of Object.entries(
          viewerData[egoName][viewerName].agentsData,
        )) {
          let alpha = 0.75;
          if (selectedTrialIds.by !== "" && selectedTrialIds.value.length > 0) {
            alpha = selectedTrialIds.value.includes(trialId)
              ? 0.75
              : clipTimePaused
                ? 0.75
                : 0.0;
            if (timeOrS && selectedTrialIds.value.length > 0) {
              alpha = selectedTrialIds.value.includes(trialId) ? 0.75 : 0.0;
            }
          }
          // Keep camera-follow trial(s) visible even if selection alpha dims others.
          const traced = new Set(
            Object.values(
              cameraFocusRef.current.replayerTraceByCluster ?? {},
            ).map(String),
          );
          if (replayerTraceTrialId != null) {
            traced.add(String(replayerTraceTrialId));
          }
          if (traced.has(String(trialId))) {
            alpha = Math.max(alpha, 0.85);
          }
          for (const agent of Object.values(item)) {
            agent.graphics.alpha = alpha;
            if (agent.sprite) {
              agent.sprite.alpha = alpha;
            }
          }
        }
      }
    }
  }, [selectedTrialIds, viewerData, clipTimePaused, replayerTraceTrialId, replayerTraceByCluster, timeOrS]);

  // Recenter on the focus ego when the right-click trace target changes (paused).
  useEffect(() => {
    if (viewerData == null || viewers == null || timeOrS !== "time") return;
    if (!clipTimePaused) return;
    const time = appData.lastTime
      ? Object.values(appData.lastTime)[0] ?? clipTimeManualOverride ?? 0
      : clipTimeManualOverride ?? 0;
    for (const egoName of Object.keys(viewerData)) {
      for (const viewerName of Object.keys(viewerData[egoName])) {
        const agentsData = viewerData[egoName][viewerName].agentsData;
        const viewer = viewers[egoName]?.[viewerName];
        if (viewer == null) continue;
        const focus = cameraFocusRef.current;
        const focusId = resolveReplayerFocusTrial({
          availableTrialIds: Object.keys(agentsData),
          replayerTraceByCluster: focus.replayerTraceByCluster,
          replayerTraceTrialId: focus.replayerTraceTrialId,
          viewerClusterLabel: viewerName,
          clusterAnalysis: focus.clusterAnalysisByEgo?.[egoName] ?? null,
          selectedTrialIds: focus.selectedTrialIds,
          highlightRolesByTrialId: focus.highlightRolesByTrialId,
        });
        if (focusId == null) continue;
        const egoAgent = agentsData[focusId]?.["Ego"];
        if (egoAgent == null) continue;
        const tKey = egoName + viewerName;
        const t = appData.lastTime[tKey] ?? time;
        const pos = egoAgent.getPositionAtTime(t);
        if (pos?.x == null || pos?.y == null) continue;
        viewer.sceneNode.pivot.set(pos.x, pos.y);
        viewer.sceneNode.position.set(0, 0);
        // Keep framing orientation — do not rewrite rotation on follow.
        viewer.viewport.moveCenter(0, 0);
      }
    }
  }, [
    replayerTraceTrialId,
    replayerTraceByCluster,
    viewerData,
    viewers,
    clipTimePaused,
    timeOrS,
    clipTimeManualOverride,
  ]);

  useEffect(() => {
    if (viewerData == null || timeOrS === "time") {
      return;
    }
    for (const egoName of Object.keys(viewerData)) {
      for (const viewerName of Object.keys(viewerData[egoName])) {
        const agentsData = viewerData[egoName][viewerName].agentsData;
        for (const [trialId, trialAgents] of Object.entries(agentsData)) {
          for (const [agentName, agent] of Object.entries(trialAgents)) {
            const agentUpdatedPosition = agent.getPositionAtS(sliderSRatio);
            agent.graphics.position.set(
              agentUpdatedPosition?.x ?? 10000,
              agentUpdatedPosition?.y ?? 10000,
            );
            agent.graphics.rotation =
              (agentUpdatedPosition?.yaw ?? 0) + 3.14 / 2;
            if (agent.sprite && agentName === "Ego") {
              agent.sprite.position.set(
                agentUpdatedPosition?.x ?? 10000,
                agentUpdatedPosition?.y ?? 10000,
              );
              agent.sprite.rotation = (agentUpdatedPosition?.yaw ?? 0) + 3.14;
            }
          }
        }

        const viewer = viewers?.[egoName]?.[viewerName];
        if (viewer == null) continue;
        const focus = cameraFocusRef.current;
        const focusId = resolveReplayerFocusTrial({
          availableTrialIds: Object.keys(agentsData),
          replayerTraceByCluster: focus.replayerTraceByCluster,
          replayerTraceTrialId: focus.replayerTraceTrialId,
          viewerClusterLabel: viewerName,
          clusterAnalysis: focus.clusterAnalysisByEgo?.[egoName] ?? null,
          selectedTrialIds: focus.selectedTrialIds,
          highlightRolesByTrialId: focus.highlightRolesByTrialId,
        });
        if (focusId == null) continue;
        const egoAgent = agentsData[focusId]?.["Ego"];
        if (egoAgent == null) continue;
        const pos = egoAgent.getPositionAtS(sliderSRatio);
        if (pos?.x == null || pos?.y == null) continue;
        viewer.sceneNode.pivot.set(pos.x, pos.y);
        viewer.sceneNode.position.set(0, 0);
        // Keep framing orientation — do not rewrite rotation on follow.
        viewer.viewport.moveCenter(0, 0);
      }
    }
  }, [viewerData, sliderSRatio, viewers, timeOrS, replayerTraceByCluster]);

  let canvases: ReactNode = null;
  if (
    // !isBaseline &&
    clusteringResult != null &&
    splitMode &&
    viewerMode === "interaction-cluster"
    // clusterInfo != null
  ) {
    let totalWindowsCount = 0;

    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      if (clusterInfo == null) {
        totalWindowsCount += 1;
        break;
      }
      for (const label in clusterInfo[egoName]) {
        if (isClusterWindowVisible(egoName, label)) {
          totalWindowsCount += 1;
        }
      }
    }
    // canvases = Object.keys(clusterInfo ?? ["ITRI", "ITRILatest"]).map(
    // canvases = ["ITRILatest", "ITRI"].map((egoName) => {

    canvases = egos.map((egoName) => {
      let egoClusterInfo: ClusterInfo = { "0": { count: 0, color: "black" } };
      if (clusterInfo != null && clusterInfo[egoName] != null) {
        egoClusterInfo = clusterInfo[egoName];
      }

      let windowsCount = 0;
      for (const label in egoClusterInfo) {
        if (clusteringResult == null || clusterCounter[egoName] == null) {
          windowsCount += 1;
          break;
        }
        if (isClusterWindowVisible(egoName, label)) {
          windowsCount += 1;
        }
      }

      const useMultiColumnLayout = containerAspect > 1.35 && windowsCount >= 2;
      const gridColumns = useMultiColumnLayout ? windowsCount : 1;
      const gridRows = Math.max(1, Math.ceil(windowsCount / gridColumns));

      return (
        <Box
          key={egoName}
          sx={{
            flex: 1,
            boxSizing: "border-box",
            position: "relative",
            display: "grid",
            gridTemplateColumns: `repeat(${gridColumns}, minmax(0, 1fr))`,
            gridTemplateRows: `repeat(${gridRows}, minmax(0, 1fr))`,
            gap: useMultiColumnLayout ? 0.5 : 0,
            minHeight: 0,
            overflow: "hidden",
          }}
        >
          {/* <Typography */}
          {/*   sx={{ */}
          {/*     position: "absolute", */}
          {/*     left: "3px", */}
          {/*     top: 0, */}
          {/*     zIndex: 100, */}
          {/*     display: */}
          {/*       Object.keys(trajectoryAnalysis ?? {}).length === 1 */}
          {/*         ? "none" */}
          {/*         : "initial", */}
          {/*   }} */}
          {/* > */}
          {/*   {egoName} */}
          {/* </Typography> */}
          {Object.keys(egoClusterInfo ?? {}).map((label) => {
            const color =
              egoClusterInfo && label in egoClusterInfo
                ? egoClusterInfo[label].color
                : "text.primary";
            const canvasScale = totalWindowsCount >= 3 ? 0.98 : 0.99;
            return (
              <Stack
                key={label}
                id={`replayer-${egoName}-cluster${label}-canvas-container`}
                sx={{
                  display: isClusterWindowVisible(egoName, label)
                    ? "inherit"
                    : "none",
                  overflow: "hidden",
                  minHeight: 0,
                  position: "relative",
                }}
                alignItems="stretch"
              >
                {/* Canvas fills the entire cluster window. */}
                <Stack
                  sx={{
                    flex: 1,
                    position: "relative",
                    minWidth: 0,
                    width: "100%",
                  }}
                  alignItems="center"
                  justifyContent="center"
                >
                  <canvas
                    style={{
                      display: "block",
                      minHeight: 0,
                      transform: `scale(${canvasScale.toFixed(2)})`,
                      height: "100%",
                      width: "100%",
                    }}
                    id={`replayer-${egoName}-cluster${label}-canvas`}
                  ></canvas>
                </Stack>

                {/* Colored border framing the ENTIRE cluster window. */}
                <Stack
                  sx={{
                    boxShadow: `inset 0px 0px 0px 10px ${color}`,
                    position: "absolute",
                    width: "100%",
                    height: "99.9%",
                    zIndex: 10,
                    top: 0,
                    left: 0,
                    pointerEvents: "none",
                  }}
                />

                {/* Caption — top-right; Motive button — bottom-right (medoid only). */}
                {(() => {
                  const panelCaption = getClusterCaption(egoName, label);
                  if (!panelCaption || timeOrS !== "time") return null;
                  const motiveKey = `${egoName}:${label}`;
                  return (
                    <>
                      <Box
                        sx={{
                          position: "absolute",
                          top: 20,
                          right: 20,
                          width: 280,
                          maxWidth: "55%",
                          maxHeight: "calc(100% - 80px)",
                          overflowY: "auto",
                          zIndex: 20,
                          // Allow wheel/drag scroll on the caption; map stays behind.
                          pointerEvents: "auto",
                        }}
                      >
                        <EgoTimelineBox
                          summary={panelCaption.summary}
                          timeSec={displayTimeSec}
                          title={panelCaption.title}
                          variant="chat"
                          borderColor={color}
                          compact
                          {...egoKinematicsFor(egoName, panelCaption.trialId)}
                        />
                      </Box>
                      {panelCaption.motiveSummary && (
                        <Button
                          size="small"
                          variant="contained"
                          onClick={() =>
                            setMotiveOpen({
                              key: motiveKey,
                              title: panelCaption.title,
                              text: panelCaption.motiveSummary as string,
                            })
                          }
                          sx={{
                            position: "absolute",
                            bottom: 16,
                            right: 16,
                            zIndex: 21,
                            pointerEvents: "auto",
                          }}
                        >
                          {panelCaption.narrativeKind === "contrast"
                            ? "Contrast explanation"
                            : "Motive summary"}
                        </Button>
                      )}
                    </>
                  );
                })()}
              </Stack>
            );
          })}
        </Box>
      );
    });
  } else {
    canvases = (
      <Stack sx={{ width: "100%", height: "100%", position: "relative" }}>
        <Box sx={{ flex: 1, minWidth: 0, width: "100%", position: "relative" }}>
          <canvas id="replayer-main-main-canvas" ref={canvasRef}></canvas>
        </Box>
        {firstActiveCaption && timeOrS === "time" && (
          <>
            <Box
              sx={{
                position: "absolute",
                top: 20,
                right: 20,
                width: 400,
                maxWidth: "65%",
                maxHeight: "calc(100% - 80px)",
                overflowY: "auto",
                zIndex: 20,
                pointerEvents: "auto",
              }}
            >
              <EgoTimelineBox
                summary={firstActiveCaption.summary}
                timeSec={displayTimeSec}
                title={firstActiveCaption.title}
                variant="chat"
                borderColor="#888"
                compact
                {...egoKinematicsFor(
                  firstActiveCaption.egoName,
                  firstActiveCaption.trialId,
                )}
              />
            </Box>
            {firstActiveCaption.motiveSummary && (
              <Button
                size="small"
                variant="contained"
                onClick={() =>
                  setMotiveOpen({
                    key: "main",
                    title: firstActiveCaption.title,
                    text: firstActiveCaption.motiveSummary as string,
                  })
                }
                sx={{
                  position: "absolute",
                  bottom: 56,
                  right: 16,
                  zIndex: 21,
                }}
              >
                {firstActiveCaption.narrativeKind === "contrast"
                  ? "Contrast explanation"
                  : "Motive summary"}
              </Button>
            )}
          </>
        )}
      </Stack>
    );
  }

  return (
    <Stack
      component="div"
      ref={containerRef}
      sx={{ width: "100%", height: "100%", overflow: "hidden" }}
      onMouseEnter={() => {
        if (!trajectoryAnalysis) {
          return;
        }
        dispatch(interactionSlice.actions.record(panelName + ".mouse_in"));
      }}
      onMouseLeave={() => {
        if (!trajectoryAnalysis) {
          return;
        }
        dispatch(interactionSlice.actions.record(panelName + ".mouse_leave"));
      }}
    >
      {canvases}

      <Stack
        sx={{
          width: "100%",
          flexShrink: 0,
          position: "relative",
        }}
      >
        <Box
          sx={{
            position: "absolute",
            top: "-3.5px",
            marginLeft: `${(5 / 8) * 99}%`,
            width: `${(3 / 8) * 99}%`,
            height: "7px",
            backgroundColor: "text.disabled",
            pointerEvents: "none",
            display:
              durationMode == "full" || showFullTimeline ? "none" : "inherit",
          }}
        />
        <Slider
          ref={timeSliderRef}
          // size="small"
          defaultValue={0}
          sx={{ width: "99%", p: 0, overflow: "hidden" }}
          step={0.001}
          max={99.5}
          onChange={(event: any, value) => {
            if (timeOrS === "time") {
              const message = event.detail?.message;
              if (message !== "auto-updated") {
                dispatch(
                  interactionSlice.actions.record(panelName + ".time_slider"),
                );
                dispatch(
                  batchSlice.actions.setClipTimeManualOverride(
                    ((value as number) / 100) * appData.timeMax,
                    // (mfpca?.durationIndices != null && !showFullTimeline
                    //   ? clusteringDuration + afterClusteringDuration
                    //   : appData.timeMax),
                  ),
                );
              }
            } else {
              setSliderSRatio((value as number) / 100);
            }
          }}
        />
        <Stack direction="row" alignItems="center" sx={{ width: "100%", pr: 1 }}>
          {timeOrS === "time" ? (
            <>
              <IconButton
                // size="small"
                sx={{ fontSize: "40px" }}
                onClick={() => {
                  dispatch(batchSlice.actions.setClipPaused(!appData.paused));
                }}
              >
                {clipTimePaused ? (
                  <PlayArrow sx={{ fontSize: "30px" }} />
                ) : (
                  <Stop sx={{ fontSize: "30px" }} />
                )}
              </IconButton>
              <Typography
                fontWeight="bold"
                ref={timeTypographyRef}
                id="clip-time-typography"
                sx={{ pl: 0.5, fontSize: "20px", flexGrow: 1 }}
              >
                0
              </Typography>
            </>
          ) : (
            <>
              <Typography fontWeight="bold" sx={{ pl: 0.5, fontSize: "20px" }}>
                S Ratio:
              </Typography>
              <Typography
                fontWeight="bold"
                ref={sTypographyRef}
                id="clip-s-typography"
                sx={{ pl: 0.5, fontSize: "20px" }}
              >
                {`${sliderSRatio.toFixed(4)}`}
              </Typography>
            </>
          )}
        </Stack>
      </Stack>

      <Dialog
        open={motiveOpen != null}
        onClose={() => setMotiveOpen(null)}
        maxWidth="sm"
        fullWidth
      >
        <DialogTitle>{motiveOpen?.title ?? "Motive summary"}</DialogTitle>
        <DialogContent>
          <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
            {motiveOpen?.text ?? ""}
          </Typography>
        </DialogContent>
      </Dialog>

      <Stack direction="row" sx={{ position: "absolute" }}>
        <Menu
          id="color-menu"
          anchorEl={anchorEl}
          open={menuOpened === "color"}
          onClose={handleMenuClose}
          slotProps={{
            paper: {
              style: {
                width: "20ch",
              },
            },
          }}
        >
          {viewerModes.map((option) => {
            return (
              <MenuItem
                key={option}
                selected={option === viewerMode}
                onClick={(event) => {
                  handleMenuClose();
                  dispatch(batchSlice.actions.setViewerMode(option));
                }}
              >
                {option}
              </MenuItem>
            );
          })}
        </Menu>
        <StyledToggleButtonGroup>
          {/* <ToggleButton */}
          {/*   value="colormode" */}
          {/*   size="small" */}
          {/*   selected={false} */}
          {/*   onChange={(event) => { */}
          {/*     handleMenuAnchorClick(event); */}
          {/*     setMenuOpened("color"); */}
          {/*   }} */}
          {/* > */}
          {/*   <ColorLensIcon /> */}
          {/*   <ArrowDropDownIcon /> */}
          {/* </ToggleButton> */}
          {/* <MetricSelection */}
          {/*   opened={menuOpened === "metric"} */}
          {/*   setOpened={() => setMenuOpened("metric")} */}
          {/*   handleClose={handleMenuClose} */}
          {/* /> */}
          {/* <ToggleButton */}
          {/*   value="showing-legend" */}
          {/*   size="small" */}
          {/*   selected={showLegend} */}
          {/*   onChange={(event) => { */}
          {/*     setShowLegend((prev) => !prev); */}
          {/*   }} */}
          {/* > */}
          {/*   <ArticleIcon /> */}
          {/* </ToggleButton> */}
          {/* <ToggleButton */}
          {/*   size="small" */}
          {/*   value="split-mode" */}
          {/*   selected={splitMode} */}
          {/*   onChange={() => setSplitMode((prev) => !prev)} */}
          {/* > */}
          {/*   <SplitscreenIcon /> */}
          {/* </ToggleButton> */}
          <ToggleButton
            value="redraw"
            size="small"
            selected={false}
            onChange={(event) => {
              // console.log("set redraw handled, set to false");
              // dispatch(batchSlice.actions.setReplayerRedrawHandled(false));
              setRedrawHandled((prev) => !prev);
            }}
          >
            <Redo />
          </ToggleButton>
        </StyledToggleButtonGroup>
      </Stack>
    </Stack>
  );
};

export default Replayer;

// util functions
function interpolateLinear(
  t: number,
  t0: number,
  t1: number,
  p0: Position,
  p1: Position,
): Position {
  const ratio = (t - t0) / (t1 - t0);
  let yaw = p0.yaw + ratio * (p1.yaw - p0.yaw);
  return {
    x: p0.x + ratio * (p1.x - p0.x),
    y: p0.y + ratio * (p1.y - p0.y),
    s_ratio: p0.s_ratio + ratio * (p1.s_ratio - p0.s_ratio),
    yaw: yaw,
  };
}

type Position = { x: number; y: number; yaw: number; s_ratio: number };

const timeSliderUpdateEvent = new CustomEvent("input", {
  bubbles: true,
  detail: {
    message: "auto-updated",
  },
});

function getPositionAtTime(
  t: number,
  times: number[],
  positions: Position[],
  durationIndices?: number[],
): Position | null {
  // Ensure the time is within bounds
  if (t < times[0]) {
    return null;
  }
  if (t > times[times.length - 1]) {
    return null;
  }

  // Find the interval using binary search
  let low = 0;
  let high = times.length - 1;

  if (durationIndices) {
    t = times[durationIndices[0]] + t;
    low = durationIndices[0];
    high = durationIndices[1];
  }

  while (low <= high) {
    const mid = Math.floor((low + high) / 2);

    if (times[mid] === t) {
      return positions[mid]; // Exact match
    } else if (times[mid] < t) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }

  // Interpolate between `high` and `low`
  const t0 = times[high];
  const t1 = times[low];
  const p0 = positions[high];
  let p1 = positions[low];

  if (p1 == null) {
    p1 = positions[high - 1];
  }

  return interpolateLinear(t, t0, t1, p0, p1);
}

function getPositionAtS(
  sRatio: number,
  ss: number[],
  positions: Position[],
): Position | null {
  let low = 0;
  let high = ss.length - 1;

  if (sRatio < ss[0]) {
    sRatio = ss[0];
  }

  while (low <= high) {
    const mid = Math.floor((low + high) / 2);

    if (ss[mid] === sRatio) {
      return positions[mid]; // Exact match
    } else if (ss[mid] < sRatio) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }

  // Interpolate between `high` and `low`
  const sRatio0 = ss[high];
  const sRatio1 = ss[low];
  let p0 = positions[high];
  let p1 = positions[low];

  if (p1 == null) {
    p1 = positions[0];
  }
  if (p0 == null) {
    p0 = positions[high - 1];
  }

  // console.log(ss.length);
  // console.log(high, low);
  // console.log(sRatio, sRatio0, sRatio1);
  // console.log(p0, p1);

  return interpolateLinear(sRatio, sRatio0, sRatio1, p0, p1);
}
