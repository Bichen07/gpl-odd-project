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
} from "react";
import { Viewport } from "pixi-viewport";
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
          target.position.copyFrom(master.position);
          target.scale.copyFrom(master.scale);
          target.rotation = master.rotation;
          target.pivot.copyFrom(master.pivot);
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
    // if (clusterInfo != null) {
    //   console.log("set redrawhandled false");
    // }
    setRedrawHandled(false);
  }, [clusterInfo, filteredTrialIds]);

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
    globalStorage.ITRI.trialIdForS = selectedTrialIds.value[0];
  }, [selectedTrialIds]);

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
            clusteringResult != null &&
            clusteringResult[egoName] != null
              ? clusteringResult[egoName].data[trialId].label
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
            clusteringResult != null &&
            clusteringResult[egoName] != null
              ? clusteringResult[egoName].data[trialId].label
              : "0";

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

              const egoX = trajectory.trajectory["Ego"][0]["x"];
              const egoY = trajectory.trajectory["Ego"][0]["y"];
              const egoYaw = trajectory.trajectory["Ego"][0]["yaw"]; // Assuming `yaw` is in radians

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

                const sceneAngleForEgo = -(-egoYaw + 3.14 / 2);
                sceneNode.pivot.set(egoX, egoY);
                sceneNode.position.set(0, 0);
                sceneNode.rotation = sceneAngleForEgo;
                viewport.moveCenter(0, 0);
                viewport.setZoom(5);
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
              // if (
              //   globalStorage.ITRI.trialIdForS === trialId &&
              //   agentName === "Ego" &&
              //   sTypographyRef.current
              // ) {
              //   sTypographyRef.current.innerText =
              //     agentUpdatedPosition?.s_ratio.toFixed(3) ?? "0";
              // }
            }
            i++;
          }

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
    if (timeOrS === "s" && selectedTrialIds.value.length > 0) {
      setRedrawHandled(false);
    }
  }, [timeOrS, selectedTrialIds]);

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
          for (const agent of Object.values(item)) {
            agent.graphics.alpha = alpha;
            if (agent.sprite) {
              agent.sprite.alpha = alpha;
            }
          }
        }
      }
    }
  }, [selectedTrialIds, viewerData, clipTimePaused]);

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
      }
    }
  }, [viewerData, sliderSRatio]);

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
        if (clusterCounter && label in clusterCounter[egoName]) {
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
        if (clusterCounter && label in clusterCounter[egoName]) {
          windowsCount += 1;
        }
      }

      return (
        <Stack
          key={egoName}
          sx={{
            // height: "100%",
            flex: windowsCount,
            // border: "solid 2px black",
            boxSizing: "border-box",
            position: "relative",
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
            let scaleY = 0.99;
            if (totalWindowsCount >= 3) {
              scaleY = 0.98;
            }
            return (
              <Stack
                key={label}
                id={`replayer-${egoName}-cluster${label}-canvas-container`}
                sx={{
                  display:
                    label in
                    (clusterCounter && egoName in clusterCounter
                      ? clusterCounter[egoName]
                      : {})
                      ? "inherit"
                      : "none",
                  overflow: "hidden",
                  flex: 1,
                  position: "relative",
                }}
                alignItems="center"
                justifyContent="center"
              >
                {/* <Typography */}
                {/*   sx={{ */}
                {/*     position: "absolute", */}
                {/*     fontWeight: 900, */}
                {/*     top: 0, */}
                {/*     right: "5px", */}
                {/*     color, */}
                {/*   }} */}
                {/* >{`Cluster ${label}`}</Typography> */}
                <canvas
                  width={containerRef.current?.offsetWidth ?? 0}
                  height={
                    clusteringResult == null ||
                    clusteringResult[egoName] == null
                      ? "500px"
                      : (containerRef.current?.offsetHeight ?? 0) /
                        totalWindowsCount
                  }
                  style={{
                    display: "block",
                    minHeight: 0,
                    transform: `scale(0.95, ${scaleY.toFixed(2)})`,
                    // border: `solid 3px ${color}`,
                    height:
                      clusteringResult == null ||
                      clusteringResult[egoName] == null
                        ? "500px"
                        : `calc(${
                            containerRef.current?.offsetHeight ?? 0
                          }px / ${totalWindowsCount})`,
                    width: "100%",
                  }}
                  id={`replayer-${egoName}-cluster${label}-canvas`}
                ></canvas>
                <Stack
                  sx={{
                    boxShadow: `inset 0px 0px 0px 10px ${color}`,
                    position: "absolute",
                    width: "100%",
                    height: "99.9%",
                    zIndex: 10,
                    top: 0,
                    pointerEvents: "none",
                  }}
                />
              </Stack>
            );
          })}
        </Stack>
      );
    });
  } else {
    canvases = <canvas id="replayer-main-main-canvas" ref={canvasRef}></canvas>;
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
          position: "absolute",
          bottom: 0,
          zIndex: 100,
          width: "100%",
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
        <Stack direction="row" alignItems="center">
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
                sx={{ pl: 0.5, fontSize: "20px" }}
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
