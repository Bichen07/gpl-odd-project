import chroma from "chroma-js";
import { SVGScene } from "@pixi-essentials/svg";
import { styled } from "@mui/material/styles";
import {
  symbol,
  symbolSquare,
  symbolStar,
  symbolDiamond,
  symbolTriangle,
  symbolWye,
  symbolCross,
} from "d3-shape";
import {
  Application,
  Assets,
  Graphics,
  GraphicsContext,
  GraphicsPath,
  Ticker,
  Texture,
  Sprite,
  Container,
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
import SplitscreenIcon from "@mui/icons-material/Splitscreen";
import ColorLensIcon from "@mui/icons-material/ColorLens";
import ArticleIcon from "@mui/icons-material/Article";
import { GroupWork, PlayArrow, Redo, Stop } from "@mui/icons-material";
import {
  useEffect,
  useMemo,
  useRef,
  useState,
  MouseEvent,
  ReactNode,
} from "react";
import { Viewport } from "pixi-viewport";
import {
  getTrajectoryFromTrial,
  TrajectoryResponseData,
} from "src/api/services/Trials";
import { toast } from "react-toastify";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import {
  sessionSlice,
  ViewerMode,
  viewerModes,
} from "src/redux/slices/session";
import { Legends } from "../TrajectoryAnalysisParameterSpace/VectorField/Legend";
import { ArrowDropDownIcon } from "@mui/x-date-pickers";
import { sum } from "d3";
import { sleep } from "src/utils";

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

const MapTrajectoriesViewer = () => {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const timeTypographyRef = useRef<HTMLDivElement>(null);
  const timeSliderRef = useRef<HTMLDivElement>(null);

  const viewerMode = useAppSelector((state) => state.session.viewerMode);
  // const viewerMode = useAppSelector((state) => state.session.);
  const safe2unsafeMappings = useAppSelector(
    (state) => state.session.safe2unsafeMappings,
  );
  const shapeStrings = useAppSelector((state) => state.session.shapeStrings);
  const selectedMetric = useAppSelector(
    (state) => state.session.selectedMetric,
  );
  const selectedBoundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );
  const pairedTrialIds = useAppSelector(
    (state) => state.session.pairedTrialIds,
  );
  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const selectedPairTrialId = useAppSelector(
    (state) => state.session.selectedPairTrialId,
  );
  const [viewerData, setViewerData] = useState<{
    [name: string]: {
      agentsData: {
        [trialId: string]: {
          [name: string]: {
            // shapeSymbol: Graphics;
            graphics: Graphics;
            sprite?: Sprite;
            getPositionAtTime: (
              t: number,
            ) => ReturnType<typeof getPositionAtTime>;
          };
        };
      };
      tick: (ticker: Ticker) => void;
      shapes: Container;
    };
  } | null>(null);

  const [redrawHandled, setRedrawHandled] = useState(true);

  const safe2UnsafePairId = useMemo(() => {
    if (selectedTrialId && selectedTrialId in safe2unsafeMappings) {
      return safe2unsafeMappings[selectedTrialId];
    }
    return null;
  }, [selectedTrialId, safe2unsafeMappings]);

  const safeIds = useMemo(() => {
    if (safe2unsafeMappings) {
      return new Set<string>(Object.keys(safe2unsafeMappings));
    }
    return null;
  }, [safe2unsafeMappings]);
  const unsafeIds = useMemo(() => {
    if (safe2unsafeMappings) {
      return new Set<string>(Object.values(safe2unsafeMappings));
    }
    return null;
  }, [safe2unsafeMappings]);

  const clusterInfo = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusteringResult,
  );
  const clipTimeManualOverride = useAppSelector(
    (state) => state.session.clipTimeManualOverride,
  );
  const clipTimePaused = useAppSelector((state) => state.session.clipPaused);
  const groupComparationMode = useAppSelector(
    (state) => state.session.groupComparationMode,
  );

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
    [name: string]: {
      app: Application;
      viewport: Viewport;
      sceneNode: Container;
      egoTexture: Texture;
    };
  } | null>(null);

  const [trajectories, setTrajectories] = useState<
    | {
        [trialId: string]: TrajectoryResponseData;
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
    dispatch(sessionSlice.actions.setReplayerDuration(appData.timeMax));
  }, [appData.timeMax]);

  useEffect(() => {
    if (selectedPairTrialId !== null || trajectoryAnalysis != null) {
      return;
    }
    const fetchData = async () => {
      if (selectedTrialId == null) {
        return;
      }
      dispatch(sessionSlice.actions.setClipTimeManualOverride(0));
      try {
        const updated: typeof trajectories = {};

        const trajData = await getTrajectoryFromTrial(selectedTrialId, {
          index: -1,
          duration: -1,
          framePeriod: 0.25,
        }).then((response) => response.data);
        updated[selectedTrialId] = trajData;

        console.log(selectedTrialId);
        setTrajectories(updated);
      } catch (error) {
        toast.error("Failed to fetch trajectory data.");
      }
    };
    fetchData();
  }, [selectedTrialId]);

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      return;
    }
    const fetchData = async () => {
      dispatch(sessionSlice.actions.setClipTimeManualOverride(0));
      try {
        const updated: typeof trajectories = {};
        let trialIds =
          trajectoryAnalysis.clustering.dendrogram["hierarchy"].trialIds;
        for (const trialId of trialIds) {
          const trajectory = trajectoryAnalysis.rawTrajectories[trialId];
          updated[trialId] = trajectory;
        }
        // if (
        //   selectedPairTrialId == null &&
        //   selectedPairTrialId &&
        //   selectedTrialId
        // ) {
        //   updated[selectedTrialId] =
        //     trajectoryAnalysis.rawTrajectories[selectedTrialId];
        //   updated[selectedPairTrialId] =
        //     trajectoryAnalysis.rawTrajectories[selectedPairTrialId];
        // } else {
        //   for (const trialId of trialIds) {
        //     const trajectory = trajectoryAnalysis.rawTrajectories[trialId];
        //     updated[trialId] = trajectory;
        //   }
        // }
        console.log("UPDATED TRAJECTORIES");
        setTrajectories(updated);
      } catch (error) {
        toast.error("Failed to fetch trajectory data.");
      }
    };
    fetchData();
  }, [trajectoryAnalysis]);

  const clusterCounter = useMemo(() => {
    if (clusteringResult == null || clusterInfo == null) {
      return;
    }
    const counter: { [clusterLabel: string]: number } = {};

    const trialIds =
      filteredTrialIds.length === 0
        ? Object.keys(trajectoryAnalysis?.clustering.scores ?? {})
        : filteredTrialIds;

    for (const trialId of trialIds) {
      if (!(trialId in clusteringResult.data)) {
        continue;
      }
      const label = clusteringResult.data[trialId].label;
      if (label != null && !(label in counter)) {
        counter[label] = 0;
      }
      if (label != null) {
        counter[label] += 1;
      }
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, trajectoryAnalysis]);

  const passFailCounter = useMemo(() => {
    if (clusteringResult == null || clusterInfo == null) {
      return;
    }
    const counter: { [clusterLabel: string]: number } = {};
    const trialIds =
      filteredTrialIds.length === 0
        ? Object.keys(trajectoryAnalysis?.clustering.scores ?? {})
        : filteredTrialIds;
    for (const trialId of trialIds) {
      if (!(trialId in clusteringResult.data)) {
        continue;
      }
      const trial = trajectoryAnalysis?.trials[trialId];
      const passed = trial?.testObjectives?.criticalityMetrics.find(
        (m) => m.keyPerformanceIndicator.id === selectedBoundaryMetric?.kpi?.id,
      )?.passed;
      const label = passed ? "pass" : "fail";
      if (!(label in counter)) {
        counter[label] = 0;
      }
      counter[label] += 1;
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, trajectoryAnalysis]);

  useEffect(() => {
    if (redrawHandled) {
      return;
    }

    const initApp = async () => {
      const egoTexture = (await Assets.load("/car.png")) as Texture;
      if (
        splitMode &&
        clusterInfo != null &&
        viewerMode === "interaction-cluster"
      ) {
        const newViewers: typeof viewers = {};
        for (const label of Object.keys(clusterInfo)) {
          // await sleep(100);
          const container = document.getElementById(
            `replayer-cluster${label}-canvas-container`,
          );
          const canvas = document.getElementById(
            `replayer-cluster${label}-canvas`,
          ) as HTMLCanvasElement;
          if (container == null || canvas == null) {
            return;
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

          newViewers[label] = { app, viewport, sceneNode, egoTexture };
        }
        function syncViewportTransform(master: Viewport, target: Viewport) {
          target.position.copyFrom(master.position);
          target.scale.copyFrom(master.scale);
          target.rotation = master.rotation;
          target.pivot.copyFrom(master.pivot);
        }
        for (const viewer of Object.values(newViewers)) {
          viewer.viewport.on("moved", () => {
            for (const other of Object.values(newViewers)) {
              if (other === viewer) {
                continue;
              }
              syncViewportTransform(viewer.viewport, other.viewport);
            }
          });
        }
        appData.nViewers = Object.keys(newViewers).length;
        setViewers(newViewers);
      } else if (splitMode && viewerMode === "pass/fail") {
        const newViewers: typeof viewers = {};
        for (const label of ["pass", "fail"]) {
          // await sleep(100);
          const container = document.getElementById(
            `replayer-passfail-${label}-canvas-container`,
          );
          const canvas = document.getElementById(
            `replayer-passfail-${label}-canvas`,
          ) as HTMLCanvasElement;
          if (container == null || canvas == null) {
            return;
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

          newViewers[label] = { app, viewport, sceneNode, egoTexture };
        }
        function syncViewportTransform(master: Viewport, target: Viewport) {
          target.position.copyFrom(master.position);
          target.scale.copyFrom(master.scale);
          target.rotation = master.rotation;
          target.pivot.copyFrom(master.pivot);
        }
        for (const viewer of Object.values(newViewers)) {
          viewer.viewport.on("moved", () => {
            for (const other of Object.values(newViewers)) {
              if (other === viewer) {
                continue;
              }
              syncViewportTransform(viewer.viewport, other.viewport);
            }
          });
        }
        appData.nViewers = Object.keys(newViewers).length;
        setViewers(newViewers);
      } else {
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

        setViewers({ main: { app, viewport, sceneNode, egoTexture } });
      }
      setRedrawHandled(true);
    };

    initApp();

    return () => {
      console.log("destroy app");
      for (const viewer of Object.values(viewers ?? {})) {
        viewer?.sceneNode?.destroy({ children: true, context: true });
        viewer?.viewport?.destroy({ children: true, context: true });
        // viewer?.app?.destroy();
      }
    };
  }, [redrawHandled]);

  useEffect(() => {
    setRedrawHandled(false);
  }, [splitMode, viewerMode, filteredTrialIds]);

  useEffect(() => {
    const handleKeyPress = (event: KeyboardEvent) => {
      if (event.code === "Space") {
        dispatch(sessionSlice.actions.setClipPaused(!appData.paused));
      }
    };
    window.addEventListener("keydown", handleKeyPress);
    return () => {
      window.removeEventListener("keydown", handleKeyPress);
    };
  }, []);

  useEffect(() => {
    if (
      viewers == null ||
      trajectories == null ||
      timeSliderRef.current == null ||
      timeTypographyRef == null
    ) {
      console.log("RETURN");
      return;
    }
    console.log("DRAW AGENTS");

    function normalizeAngle(angle: number) {
      /**
       * Normalize an angle to the range [-π, π].
       *
       * @param {number} angle - The input angle in radians.
       * @return {number} - The normalized angle in radians.
       */
      // Use modulo to bring the angle to the range [0, 2π]
      let normalized = angle % (2 * Math.PI);

      // Shift the angle to the range [-π, π]
      if (normalized > Math.PI) {
        normalized -= 2 * Math.PI;
      } else if (normalized < -Math.PI) {
        normalized += 2 * Math.PI;
      }

      return normalized;
    }

    const newViewerData: typeof viewerData = {};

    const criticalityHalfs: {
      [name: string]: { [trialId: string]: number };
    } = { head: {}, tail: {} };

    const criticalityViewMetrics: { [name: string]: number[] } = {
      head: [],
      tail: [],
    };

    for (const [viewerName, viewer] of Object.entries(viewers)) {
      const viewport = viewer.viewport;
      const sceneNode = viewer.sceneNode;
      const app = viewer.app;

      newViewerData[viewerName] = {
        agentsData: {},
        tick: (ticker: Ticker) => {},
        shapes: new Container(),
      };

      const agentsData = newViewerData[viewerName].agentsData;
      const shapes = newViewerData[viewerName].shapes;
      sceneNode.addChild(shapes);

      let newTimeMax = 0;

      const maxMembership: { [clusterlabel: string]: number } = {};
      const maxMembershipTrialIds: { [clusterlabel: string]: string } = {};
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

      for (const [trialIndex, [trialId, trajectory]] of Object.entries(
        trajectories,
      ).entries()) {
        if (
          trajectoryAnalysis != null &&
          filteredTrialIds.length !== 0 &&
          filteredTrialIds != null &&
          !filteredTrialIds.includes(trialId)
        ) {
          continue;
        }
        const label = clusteringResult?.data[trialId].label;
        const membership = clusteringResult?.data[trialId].probability ?? 0;
        if (trajectoryAnalysis != null && label == null) {
          continue;
        }
        if (!(label in maxMembership)) {
          maxMembership[label] = membership;
        }
        if (membership > maxMembership[label]) {
          maxMembershipTrialIds[label] = trialId;
        }
        maxMembership[label] = Math.max(membership, maxMembership[label]);

        const trial = trajectoryAnalysis?.trials[trialId];
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

      // console.log(safeIds);
      // console.log(unsafeIds);
      for (const [trialIndex, [trialId, trajectory]] of Object.entries(
        trajectories,
      )
        .sort((a, b) => {
          let membershipA = clusteringResult?.data[a[0]].probability ?? 0;
          let membershipB = clusteringResult?.data[b[0]].probability ?? 0;
          if (a[0] in Object.values(maxMembershipTrialIds)) {
            membershipA = 10000;
          }
          if (b[0] in Object.values(maxMembershipTrialIds)) {
            membershipB = 10000;
          }
          return membershipA - membershipB;
        })
        .entries()) {
        if (
          trajectoryAnalysis != null &&
          filteredTrialIds.length !== 0 &&
          filteredTrialIds != null &&
          !filteredTrialIds.includes(trialId)
        ) {
          continue;
        }

        newTimeMax = Math.max(
          newTimeMax,
          trajectory["time"][trajectory["time"].length - 1],
        );

        const membership = clusteringResult?.data[trialId].probability ?? 0;
        const label = clusteringResult?.data[trialId].label;

        if (
          viewerName !== label &&
          splitMode &&
          viewerMode === "interaction-cluster"
        ) {
          continue;
        }

        const trial = trajectoryAnalysis?.trials[trialId];
        const metricValue = trial?.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.id === selectedMetric?.kpi?.id,
        )?.value;
        if (
          splitMode &&
          viewerMode === "criticality" &&
          ((viewerName === "tail" &&
            selectedPairTrialId == null &&
            !pairedTrialIds.includes(trial?.id ?? "")) ||
            (viewerName === "head" &&
              pairedTrialIds.includes(trial?.id ?? "")) ||
            (viewerName === "head" &&
              selectedPairTrialId &&
              selectedPairTrialId === trialId) ||
            (viewerName === "tail" &&
              selectedPairTrialId &&
              selectedPairTrialId !== trialId))
        ) {
          continue;
        }

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

        agentsData[trialId] = {};
        for (const [agentIndex, [agentName, agentTraj]] of Object.entries(
          trajectory.trajectory,
        ).entries()) {
          let color = agentName === "Ego" ? chroma("blue") : chroma("red");
          let alpha = 0.5;

          if (label != null && clusterInfo != null) {
            color = chroma(clusterInfo[label].color).alpha(alpha);
          }
          if (viewerMode === "criticality") {
            color = chroma(metricColor).alpha(alpha);
          }
          if (viewerMode === "pass/fail") {
            // if (trialId === "678d81eb2ed96a72d5a0f199") {
            //   alpha = 1.0;
            // } else if (trialId === "678d2b1c2ed96a72d582a4c2") {
            //   alpha = 1.0;
            // } else {
            //   alpha = 0.05;
            // }

            // if (trialId === selectedTrialId || trialId === safe2UnsafePairId) {
            //   alpha = 1.0;
            // } else {
            //   alpha = 0.01;
            // }

            color = chroma(
              passed ? theme.palette.success.light : theme.palette.error.light,
            ).alpha(alpha);
          }

          if (
            viewerMode === "interaction-cluster" &&
            label != null &&
            clusterInfo != null &&
            selectedPairTrialId == null
          ) {
            // alpha = (0.05 * membership) / maxMembership[label];
            // if (membership === maxMembership[label] && !visited.has(label)) {
            //   alpha = 0.75;
            // }
            color = chroma(clusterInfo[label].color).alpha(alpha);
          }

          if (!(agentName in agentsData[trialId])) {
            const x = agentTraj[0]["x"];
            const y = agentTraj[0]["y"];
            const width = agentTraj[0]["width"] ?? 2.2;
            const length = agentTraj[0]["length"] ?? 5.14;
            const yaw = agentTraj[0]["yaw"]; // Assuming `yaw` is in radians

            // const shapeIndex = Number(label);
            // const shapeString = shapeStrings[shapeIndex];
            // let shapeSymbol = new GraphicsPath();
            // if (shapeString === "circle") {
            //   shapeSymbol = new GraphicsPath(symbol()() ?? "");
            // } else if (shapeString === "square") {
            //   shapeSymbol = new GraphicsPath(symbol(symbolSquare)() ?? "");
            // } else if (shapeString === "wye") {
            //   shapeSymbol = new GraphicsPath(symbol(symbolWye)() ?? "");
            // } else if (shapeString === "triangle") {
            //   shapeSymbol = new GraphicsPath(symbol(symbolTriangle)() ?? "");
            // } else if (shapeString === "diamond") {
            //   shapeSymbol = new GraphicsPath(symbol(symbolDiamond)() ?? "");
            // } else if (shapeString === "cross") {
            //   shapeSymbol = new GraphicsPath(symbol(symbolCross)() ?? "");
            // } else if (shapeString === "star") {
            //   shapeSymbol = new GraphicsPath(symbol(symbolStar)() ?? "");
            // }

            const egoX = trajectory.trajectory["Ego"][0]["x"];
            const egoY = trajectory.trajectory["Ego"][0]["y"];
            const egoYaw = trajectory.trajectory["Ego"][0]["yaw"]; // Assuming `yaw` is in radians

            let agentGraphic: Graphics | Sprite = new Graphics();
            let sprite: Sprite | undefined = undefined;
            if (agentName === "Ego") {
              agentGraphic.rect(0, 0, width, length);
              // agentGraphic.fill(color.hex());
              agentGraphic.stroke({
                color: chroma("#555").alpha(alpha).hex(),
                width: 0.1,
              });
              // // agentGraphic.fill(color.alpha(0).hex());
              agentGraphic.pivot.set(width / 2, length / 2);
              agentGraphic.position.set(x, y);
              agentGraphic.rotation = yaw + 3.14 / 2;

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
              agentGraphic.rect(0, 0, width, length);
              agentGraphic.fill("white");
              agentGraphic.tint = color.hex();
              agentGraphic.alpha = alpha;
              agentGraphic.pivot.set(width / 2, length / 2);
              agentGraphic.position.set(x, y);
              agentGraphic.rotation = yaw + 3.14 / 2;
            }

            shapes.addChild(agentGraphic);

            // const symbolGraphics = new Graphics();
            // symbolGraphics.path(shapeSymbol);
            // // symbolGraphics.fill(chroma("black").alpha(alpha).hex());
            // symbolGraphics.fill("white");
            // symbolGraphics.tint = "#000000";
            // symbolGraphics.alpha = alpha;
            // symbolGraphics.pivot.set(0, -3);
            // symbolGraphics.scale.x = 0.1 * width * 0.5;
            // symbolGraphics.scale.y = 0.1 * width * 0.5;
            // // shapes.addChild(symbolGraphics);

            // const agent_path_boxes: number[][] = agentTraj.map(
            //   (item) => item.agent_path_box,
            // );
            // agentTraj.forEach((item) => {
            //   console.log(item);
            //   // item["pathbox1x"] = item.agent_path_box[0][0];
            //   // item["pathbox1y"] = item.agent_path_box[0][1];
            // });
            // console.log(agentTraj);

            // let pathboxColor = chroma("black");
            // const size = 0.3;
            // let pathbox1: Graphics = new Graphics();
            // pathbox1.circle(0, 0, size);
            // pathbox1.fill("white");
            // pathbox1.tint = pathboxColor.hex();
            // pathbox1.alpha = alpha;
            // pathbox1.pivot.set(size / 2, size / 2);
            // pathbox1.position.set(0, 0);
            // // shapes.addChild(pathbox1);
            //
            // let pathbox2: Graphics = new Graphics();
            // pathbox2.circle(0, 0, size);
            // pathbox2.fill("white");
            // pathbox2.tint = pathboxColor.hex();
            // pathbox2.alpha = alpha;
            // pathbox2.pivot.set(size / 2, size / 2);
            // pathbox2.position.set(0, 0);
            // // shapes.addChild(pathbox2);
            //
            // let pathbox3: Graphics = new Graphics();
            // pathbox3.circle(0, 0, size);
            // pathbox3.fill("white");
            // pathbox3.tint = pathboxColor.hex();
            // pathbox3.alpha = alpha;
            // pathbox3.pivot.set(size / 3, size / 3);
            // pathbox3.position.set(0, 0);
            // // shapes.addChild(pathbox3);
            //
            // let pathbox4: Graphics = new Graphics();
            // pathbox4.circle(0, 0, size);
            // pathbox4.fill("white");
            // pathbox4.tint = pathboxColor.hex();
            // pathbox4.alpha = alpha;
            // pathbox4.pivot.set(size / 4, size / 4);
            // pathbox4.position.set(0, 0);
            // // shapes.addChild(pathbox4);

            // console.log(agentName);

            agentsData[trialId][agentName] = {
              // shapeSymbol: symbolGraphics,
              graphics: agentGraphic,
              sprite,
              // pathbox1,
              // pathbox2,
              // pathbox3,
              // pathbox4,
              getPositionAtTime: (t: number) => {
                // console.log(agentTraj);
                return getPositionAtTime(
                  t,
                  trajectory.time,
                  agentTraj.map((item, index) => {
                    return {
                      x: item.x,
                      y: item.y,
                      yaw:
                        item.yaw > 3.14 ? normalizeAngle(item.yaw) : item.yaw,
                      // pathbox1x: item.agent_path_box[0][0],
                      // pathbox1y: item.agent_path_box[0][1],
                      // pathbox2x: item.agent_path_box[1][0],
                      // pathbox2y: item.agent_path_box[1][1],
                      // pathbox3x: item.agent_path_box[2][0],
                      // pathbox3y: item.agent_path_box[2][1],
                      // pathbox4x: item.agent_path_box[3][0],
                      // pathbox4y: item.agent_path_box[3][1],
                    };
                  }),
                );
              },
            };
          }
        }

        if (label != null) {
          if (membership === maxMembership[label] && !visited.has(label)) {
            visited.add(label);
          }
        }
      }

      appData.timeMax = newTimeMax;

      const update = (ticker: Ticker) => {
        let lastTime =
          viewerName in appData.lastTime ? appData.lastTime[viewerName] : null;
        if (lastTime == null || lastTime > appData.timeMax) {
          appData.lastTime[viewerName] = 0;
        }
        lastTime = appData.lastTime[viewerName];

        const delta = ticker.deltaMS;
        const time = lastTime + delta / 1000;
        const agentsData = newViewerData[viewerName].agentsData;
        for (const [_trialId, trialAgents] of Object.entries(agentsData)) {
          for (const [agentName, agent] of Object.entries(trialAgents)) {
            const agentUpdatedPosition = agent.getPositionAtTime(time);

            // if (agentName == "Ego") {
            //   console.log(agentUpdatedPosition);
            // }

            // agent.pathbox1.position.set(
            //   agentUpdatedPosition?.pathbox1x ?? 10000,
            //   agentUpdatedPosition?.pathbox1y ?? 10000,
            // );
            // agent.pathbox2.position.set(
            //   agentUpdatedPosition?.pathbox2x ?? 20000,
            //   agentUpdatedPosition?.pathbox2y ?? 20000,
            // );
            // agent.pathbox3.position.set(
            //   agentUpdatedPosition?.pathbox3x ?? 30000,
            //   agentUpdatedPosition?.pathbox3y ?? 30000,
            // );
            // agent.pathbox4.position.set(
            //   agentUpdatedPosition?.pathbox4x ?? 40000,
            //   agentUpdatedPosition?.pathbox4y ?? 40000,
            // );

            agent.graphics.position.set(
              agentUpdatedPosition?.x ?? 10000,
              agentUpdatedPosition?.y ?? 10000,
            );
            agent.graphics.rotation =
              (agentUpdatedPosition?.yaw ?? 0) + 3.14 / 2;

            // agent.shapeSymbol.position.set(
            //   agentUpdatedPosition?.x ?? 10000,
            //   agentUpdatedPosition?.y ?? 10000,
            // );
            // agent.shapeSymbol.rotation =
            //   (agentUpdatedPosition?.yaw ?? 0) + 3.14 / 2;

            if (agent.sprite && agentName === "Ego") {
              agent.sprite.position.set(
                agentUpdatedPosition?.x ?? 10000,
                agentUpdatedPosition?.y ?? 10000,
              );
              agent.sprite.rotation = (agentUpdatedPosition?.yaw ?? 0) + 3.14;
            }
          }
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

        appData.lastTime[viewerName] = time;
      };
      const tick = (ticker: Ticker) => {
        if (appData.manualTimeChanged < appData.nViewers) {
          appData.lastTime[viewerName] = appData.manualTimeOverride;
          appData.manualTimeChanged += 1;
          update(ticker);
        } else if (!appData.paused) {
          update(ticker);
        }
      };
      app.ticker.add(tick);

      newViewerData[viewerName].tick = tick;
    }

    setCriticalityViewAverage({
      tail:
        sum(criticalityViewMetrics["tail"]) /
        criticalityViewMetrics["tail"].length,
      head:
        sum(criticalityViewMetrics["head"]) /
        criticalityViewMetrics["head"].length,
    });
    dispatch(sessionSlice.actions.setCriticalityHalfs(criticalityHalfs));

    setViewerData(newViewerData);

    return () => {
      for (const [viewerName, item] of Object.entries(newViewerData)) {
        const app = viewers[viewerName].app;
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
    };
  }, [
    trajectories,
    viewers,
    timeSliderRef.current,
    timeTypographyRef.current,
    // colorMode,
  ]);

  useEffect(() => {
    if (trajectoryAnalysis == null || viewerData == null) {
      return;
    }
    if (viewerMode == "pass/fail") {
      for (const viewerName of ["pass", "fail"]) {
        if (!(viewerName in viewerData)) {
          continue;
        }
        for (const [trialId, item] of Object.entries(
          viewerData[viewerName].agentsData,
        )) {
          let alpha = 0.5;
          if (selectedTrialId) {
            alpha =
              trialId == selectedTrialId || trialId == selectedPairTrialId
                ? 0.7
                : clipTimePaused && groupComparationMode
                  ? 0.05
                  : 0.0;
          }
          for (const agent of Object.values(item)) {
            agent.graphics.alpha = alpha;
            // agent.pathbox1.alpha = alpha;
            // agent.pathbox2.alpha = alpha;
            // agent.pathbox3.alpha = alpha;
            // agent.pathbox4.alpha = alpha;
            // agent.shapeSymbol.alpha = alpha;
            if (agent.sprite) {
              agent.sprite.alpha = alpha;
            }
          }
        }
      }
    }
  }, [selectedTrialId, viewerData, viewerMode, clipTimePaused]);

  let canvases: ReactNode[] = [];
  if (
    splitMode &&
    viewerMode === "interaction-cluster" &&
    clusterInfo != null
  ) {
    canvases = Object.keys(clusterInfo).map((label) => {
      const color =
        clusterInfo && label in clusterInfo
          ? clusterInfo[label].color
          : "text.primary";
      return (
        <Box
          component="div"
          key={label}
          id={`replayer-cluster${label}-canvas-container`}
          sx={{
            display: label in (clusterCounter ?? {}) ? "inherit" : "none",
            width: "100%",
            height: "100%",
            overflow: "hidden",
            flex: 1,
            border: `solid 3px ${color}`,
            position: "relative",
          }}
        >
          <Typography
            sx={{
              position: "absolute",
              fontWeight: 900,
              top: 0,
              right: 0,
              color,
            }}
          >{`Cluster ${label}`}</Typography>
          <canvas id={`replayer-cluster${label}-canvas`}></canvas>
        </Box>
      );
    });
  } else if (splitMode && viewerMode === "pass/fail") {
    canvases = ["pass", "fail"].map((label) => {
      let color =
        label === "pass"
          ? theme.palette.success.light
          : theme.palette.error.light;
      return (
        <Box
          component="div"
          key={label}
          id={`replayer-passfail-${label}-canvas-container`}
          sx={{
            display: label in (passFailCounter ?? {}) ? "inherit" : "none",
            width: "100%",
            height: "100%",
            overflow: "hidden",
            flex: 1,
            border: `solid 3px ${color}`,
            position: "relative",
          }}
        >
          <Typography
            sx={{
              position: "absolute",
              fontWeight: 900,
              top: 0,
              right: 0,
              color,
            }}
          >
            {label}
          </Typography>
          <canvas id={`replayer-passfail-${label}-canvas`}></canvas>
        </Box>
      );
    });
  } else if (splitMode && viewerMode === "criticality") {
    canvases = ["head", "tail"].map((label) => {
      let color = criticalityViewAverage
        ? metricColorscale(
            ((criticalityViewAverage[label] ?? 0) -
              (selectedMetric?.min ?? 0)) /
              ((selectedMetric?.max ?? 1) - (selectedMetric?.min ?? 0)),
          ).hex()
        : "black";
      return (
        <Box
          component="div"
          key={label}
          id={`replayer-criticality-${label}-canvas-container`}
          sx={{
            width: "100%",
            height: "100%",
            overflow: "hidden",
            flex: 1,
            border: `solid 3px ${color}`,
            position: "relative",
          }}
        >
          <Typography
            sx={{
              position: "absolute",
              fontWeight: 900,
              top: 0,
              right: 0,
              color,
            }}
          >{`${label} | avg ${selectedMetric?.kpi.name} ${criticalityViewAverage ? criticalityViewAverage[label].toFixed(2) : 0}`}</Typography>
          <canvas id={`replayer-criticality-${label}-canvas`}></canvas>
        </Box>
      );
    });
  } else {
    canvases.push(<canvas id="replayer-main-canvas" ref={canvasRef}></canvas>);
  }

  return (
    <Stack
      component="div"
      // direction="row"
      ref={containerRef}
      sx={{ width: "100%", height: "100%", overflow: "hidden" }}
    >
      {canvases}
      <Stack
        sx={{ position: "absolute", bottom: 0, zIndex: 100, width: "100%" }}
      >
        <Slider
          ref={timeSliderRef}
          size="small"
          defaultValue={0}
          sx={{ width: "99%", p: 0 }}
          step={0.001}
          max={99.99}
          onChange={(event: any, value) => {
            const message = event.detail?.message;
            if (message !== "auto-updated") {
              dispatch(
                sessionSlice.actions.setClipTimeManualOverride(
                  ((value as number) / 100) * appData.timeMax,
                ),
              );
            }
          }}
        />
        <Stack direction="row" alignItems="center">
          <IconButton
            size="small"
            onClick={() => {
              dispatch(sessionSlice.actions.setClipPaused(!appData.paused));
            }}
          >
            {clipTimePaused ? <PlayArrow /> : <Stop />}
          </IconButton>
          <Typography
            fontWeight="bold"
            ref={timeTypographyRef}
            id="clip-time-typography"
            sx={{ pl: 0.5 }}
          >
            0
          </Typography>
        </Stack>
      </Stack>

      <Stack direction="row" sx={{ position: "absolute", top: 0 }}>
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
                  dispatch(sessionSlice.actions.setViewerMode(option));
                }}
              >
                {option}
              </MenuItem>
            );
          })}
        </Menu>
        <StyledToggleButtonGroup>
          <ToggleButton
            value="colormode"
            size="small"
            selected={false}
            onChange={(event) => {
              handleMenuAnchorClick(event);
              setMenuOpened("color");
            }}
          >
            <ColorLensIcon />
            <ArrowDropDownIcon />
          </ToggleButton>
          <ToggleButton
            value="showing-legend"
            size="small"
            selected={showLegend}
            onChange={(event) => {
              setShowLegend((prev) => !prev);
            }}
          >
            <ArticleIcon />
          </ToggleButton>
          <ToggleButton
            size="small"
            value="split-mode"
            selected={splitMode}
            onChange={() => setSplitMode((prev) => !prev)}
          >
            <SplitscreenIcon />
          </ToggleButton>
          <ToggleButton
            size="small"
            value="split-mode"
            selected={groupComparationMode}
            onChange={() =>
              dispatch(
                sessionSlice.actions.setGroupComparationMode(
                  !groupComparationMode,
                ),
              )
            }
          >
            <GroupWork />
          </ToggleButton>
          <ToggleButton
            value="redraw"
            size="small"
            selected={false}
            onChange={(event) => {
              setRedrawHandled(false);
            }}
          >
            <Redo />
          </ToggleButton>
        </StyledToggleButtonGroup>
      </Stack>

      <Legends
        sx={{
          display: showLegend ? "initial" : "none",
        }}
      />
    </Stack>
  );
};

export default MapTrajectoriesViewer;

// util functions
function interpolateLinear(
  t: number,
  t0: number,
  t1: number,
  p0: Position,
  p1: Position,
): Position {
  const ratio = (t - t0) / (t1 - t0);
  return {
    x: p0.x + ratio * (p1.x - p0.x),
    y: p0.y + ratio * (p1.y - p0.y),
    yaw: p0.yaw + ratio * (p1.yaw - p0.yaw),
    // pathbox1x: p0.pathbox1x + ratio * (p1.pathbox1x - p0.pathbox1x),
    // pathbox1y: p0.pathbox1y + ratio * (p1.pathbox1y - p0.pathbox1y),
    // pathbox2x: p0.pathbox2x + ratio * (p1.pathbox2x - p0.pathbox2x),
    // pathbox2y: p0.pathbox2y + ratio * (p1.pathbox2y - p0.pathbox2y),
    // pathbox3x: p0.pathbox3x + ratio * (p1.pathbox3x - p0.pathbox3x),
    // pathbox3y: p0.pathbox3y + ratio * (p1.pathbox3y - p0.pathbox3y),
    // pathbox4x: p0.pathbox4x + ratio * (p1.pathbox4x - p0.pathbox4x),
    // pathbox4y: p0.pathbox4y + ratio * (p1.pathbox4y - p0.pathbox4y),
  };
}

type Position = { x: number; y: number; yaw: number };

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
  const p1 = positions[low];

  return interpolateLinear(t, t0, t1, p0, p1);
}
