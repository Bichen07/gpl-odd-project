// "use client";
//
// import chroma from "chroma-js";
// import { SVGScene } from "@pixi-essentials/svg";
// import { styled } from "@mui/material/styles";
// import {
//   Application,
//   Assets,
//   Graphics,
//   Ticker,
//   Texture,
//   Sprite,
//   Container,
//   PI_2,
// } from "pixi.js";
// import {
//   Box,
//   IconButton,
//   Slider,
//   Stack,
//   Typography,
//   Menu,
//   MenuItem,
//   useTheme,
//   ToggleButton,
//   ToggleButtonGroup,
//   FormControl,
//   InputLabel,
//   Select,
// } from "@mui/material";
// import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
// import SplitscreenIcon from "@mui/icons-material/Splitscreen";
// import SportsScoreIcon from "@mui/icons-material/SportsScore";
// import ColorLensIcon from "@mui/icons-material/ColorLens";
// import ArticleIcon from "@mui/icons-material/Article";
// import { PlayArrow, Redo, Stop } from "@mui/icons-material";
// import {
//   useEffect,
//   useMemo,
//   useRef,
//   useState,
//   MouseEvent,
//   ReactNode,
// } from "react";
// import { Viewport } from "pixi-viewport";
// import { toast } from "react-toastify";
// import {
//   TrajectoryResponseData,
//   getTrajectoryFromTrial,
// } from "@/app/_shared/graphql/queries/trials";
// import { useAppDispatch, useAppSelector } from "../../../../redux/hooks";
// import { viewerModes, batchSlice } from "../../../../redux/slices/batch";
// // import { Legends } from "../TrajectoryAnalysisParameterSpace/VectorField/Legend";
// import { ArrowDropDownIcon } from "@mui/x-date-pickers";
// import { sum } from "d3";
// import MetricSelection from "../../components/MetricSelection";
// import JSZip from "jszip";
//
// let clusteringDuration = 5;
// let afterClusteringDuration = 0;
//
// const StyledToggleButtonGroup = styled(ToggleButtonGroup)(({ theme }) => ({
//   [`& .${toggleButtonGroupClasses.grouped}`]: {
//     margin: theme.spacing(0.5),
//     border: 0,
//     borderRadius: theme.shape.borderRadius,
//     [`&.${toggleButtonGroupClasses.disabled}`]: {
//       border: 0,
//     },
//   },
//   [`& .${toggleButtonGroupClasses.middleButton},& .${toggleButtonGroupClasses.lastButton}`]:
//   {
//     marginLeft: -1,
//     borderLeft: "1px solid transparent",
//   },
// }));
//
// export const appData: {
//   manualTimeChanged: number;
//   manualTimeOverride: number;
//   nViewers: number;
//   paused: boolean;
//   lastTime: { [name: string]: number };
//   timeMax: number;
// } = {
//   manualTimeChanged: 0,
//   manualTimeOverride: 0,
//   paused: false,
//   lastTime: {},
//   nViewers: 0,
//   timeMax: 0,
// };
//
// const CaseImageViewer = () => {
//   const theme = useTheme();
//   const dispatch = useAppDispatch();
//   const containerRef = useRef<HTMLDivElement>(null);
//   const canvasRef = useRef<HTMLCanvasElement>(null);
//   const timeTypographyRef = useRef<HTMLDivElement>(null);
//   const timeSliderRef = useRef<HTMLDivElement>(null);
//
//   const viewerMode = useAppSelector((state) => state.batch.viewerMode);
//   const shapeStrings = useAppSelector((state) => state.batch.shapeStrings);
//   const clusteringDurationMode = useAppSelector(
//     (state) => state.batch.clusteringDurationMode,
//   );
//   const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
//   const selectedBoundaryMetric = useAppSelector(
//     (state) => state.batch.selectedSafetyBoundaryMetric,
//   );
//   const trajectoryAnalysis = useAppSelector(
//     (state) => state.batch.trajectoryAnalysis,
//   );
//   const durationMode = useAppSelector((state) => state.batch.durationMode);
//   const mfpca = useMemo(() => {
//     return trajectoryAnalysis?.mfpca[durationMode];
//   }, [trajectoryAnalysis, durationMode]);
//   const filteredTrialIds = useAppSelector(
//     (state) => state.batch.filteredTrialIds,
//   );
//   const selectedTrialId = useAppSelector(
//     (state) => state.batch.selectedTrialId,
//   );
//   const selectedTrialIds = useAppSelector(
//     (state) => state.batch.selectedTrialIds,
//   );
//   // const redrawHandled = useAppSelector(
//   //   (state) => state.batch.replayerRedrawHandled
//   // );
//
//   const [viewerData, setViewerData] = useState<{
//     [name: string]: {
//       agentsData: {
//         [trialId: string]: {
//           [name: string]: {
//             // shapeSymbol: Graphics;
//             graphics: Graphics | Sprite;
//             sprite?: Sprite;
//             getPositionAtTime: (
//               t: number,
//             ) => ReturnType<typeof getPositionAtTime>;
//           };
//         };
//       };
//       tick: (ticker: Ticker) => void;
//       shapes: Container;
//     };
//   } | null>(null);
//
//   const [redrawHandled, setRedrawHandled] = useState(true);
//
//   const clusterInfo = useAppSelector(
//     (state) => state.batch.selectedClusterInfo,
//   );
//   const clusteringResult = useAppSelector(
//     (state) => state.batch.selectedClusteringResult,
//   );
//   const clipTimeManualOverride = useAppSelector(
//     (state) => state.batch.clipTimeManualOverride,
//   );
//   const clipTimePaused = useAppSelector((state) => state.batch.clipPaused);
//
//   const metricColorscale = useMemo(() => {
//     if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
//       return chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
//     }
//     return chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
//   }, [selectedMetric, trajectoryAnalysis]);
//
//   const [showLegend, setShowLegend] = useState(true);
//   const [splitMode, setSplitMode] = useState(true);
//   const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
//   const [menuOpened, setMenuOpened] = useState<string | null>(null);
//   const handleMenuAnchorClick = (event: MouseEvent<HTMLElement>) => {
//     setAnchorEl(event.currentTarget);
//   };
//   const handleMenuClose = () => {
//     setAnchorEl(null);
//     setMenuOpened(null);
//   };
//
//   const [metricMedian, setMetricMedian] = useState<null | number>(null);
//   const [criticalityViewAverage, setCriticalityViewAverage] = useState<{
//     [name: string]: number;
//   } | null>(null);
//
//   const [viewers, setViewers] = useState<{
//     [name: string]: {
//       app: Application;
//       viewport: Viewport;
//       sceneNode: Container;
//       egoTexture: Texture;
//     };
//   } | null>(null);
//
//   const [trajectories, setTrajectories] = useState<
//     | {
//       [trialId: string]: TrajectoryResponseData;
//     }
//     | undefined
//   >(undefined);
//
//   useEffect(() => {
//     appData.paused = clipTimePaused;
//   }, [clipTimePaused]);
//   useEffect(() => {
//     appData.manualTimeChanged = 0;
//     appData.manualTimeOverride = clipTimeManualOverride ?? 0;
//   }, [clipTimeManualOverride]);
//
//   useEffect(() => {
//     const fetchData = async () => {
//       if (selectedTrialIds.value.length == 0) {
//         return;
//       }
//       dispatch(batchSlice.actions.setClipTimeManualOverride(0));
//       try {
//         const updated: typeof trajectories = {};
//
//         const trajData = await getTrajectoryFromTrial(
//           selectedTrialIds.value[0],
//           {
//             index: -1,
//             duration: -1,
//             framePeriod: 0.25,
//           },
//         ).then((response) => response.data);
//         updated[selectedTrialIds.value[0]] = trajData;
//
//         console.log(selectedTrialId);
//         setTrajectories(updated);
//       } catch (error) {
//         toast.error("Failed to fetch trajectory data.");
//       }
//     };
//     fetchData();
//   }, [selectedTrialIds]);
//
//   useEffect(() => {
//     console.log("HELPHELP");
//     if (redrawHandled) {
//       console.log("REDRAW Already");
//       return;
//     }
//     console.log("REDRAW");
//
//     const initApp = async () => {
//       console.log("INIT APP");
//       const egoTexture = (await Assets.load("/car.png")) as Texture;
//       appData.nViewers = 1;
//       if (containerRef.current == null || canvasRef.current == null) {
//         return;
//       }
//
//       const { width, height } = containerRef.current.getBoundingClientRect();
//
//       const app = new Application();
//       await app.init({
//         canvas: canvasRef.current,
//         width,
//         height,
//         backgroundColor: "white",
//         resizeTo: containerRef.current,
//         antialias: true,
//         autoDensity: true,
//       });
//
//       const sceneNode = new Container();
//       sceneNode.scale.y = -1;
//       const map = await SVGScene.from("/map.svg");
//       const bounds = map.getLocalBounds();
//       sceneNode.addChild(map);
//
//       const viewport = new Viewport({
//         screenWidth: app.canvas.width,
//         screenHeight: app.canvas.height,
//         worldWidth: bounds.width,
//         worldHeight: bounds.height,
//         events: app.renderer.events, // the interaction module is important for wheel to work properly when renderer.view is placed or scaled
//       });
//       viewport.drag().pinch().wheel();
//       app.stage.addChild(viewport);
//       viewport.addChild(sceneNode);
//
//       setViewers({ main: { app, viewport, sceneNode, egoTexture } });
//       console.log("REDRAWHANDLED TO TRUE");
//       // dispatch(batchSlice.actions.setReplayerRedrawHandled(true));
//       setRedrawHandled(true);
//     };
//
//     initApp();
//
//     return () => {
//       console.log("destroy app");
//       for (const viewer of Object.values(viewers ?? {})) {
//         viewer?.sceneNode?.destroy({ children: true, context: true });
//         viewer?.viewport?.destroy({ children: true, context: true });
//         // viewer?.app?.destroy();
//       }
//     };
//   }, [redrawHandled]);
//
//   useEffect(() => {
//     // dispatch(batchSlice.actions.setReplayerRedrawHandled(true));
//     setRedrawHandled(true);
//   }, [splitMode, viewerMode, filteredTrialIds]);
//
//   useEffect(() => {
//     if (viewers == null || trajectories == null || mfpca == null) {
//       console.log("RETURN");
//       return;
//     }
//     console.log("DRAW AGENTS");
//     const newViewerData: typeof viewerData = {};
//
//     const criticalityHalfs: {
//       [name: string]: { [trialId: string]: number };
//     } = { head: {}, tail: {} };
//
//     const criticalityViewMetrics: { [name: string]: number[] } = {
//       head: [],
//       tail: [],
//     };
//     const lineGraphicsArray: Graphics[] = [];
//
//     for (const [viewerName, viewer] of Object.entries(viewers)) {
//       const viewport = viewer.viewport;
//       const sceneNode = viewer.sceneNode;
//       const app = viewer.app;
//
//       newViewerData[viewerName] = {
//         agentsData: {},
//         tick: (ticker: Ticker) => { },
//         shapes: new Container(),
//       };
//
//       const agentsData = newViewerData[viewerName].agentsData;
//       const shapes = newViewerData[viewerName].shapes;
//       sceneNode.addChild(shapes);
//
//       let newTimeMax = 0;
//
//       const metricValueMapping: { [trialId: string]: number } = {};
//
//       function median(values: number[]): number {
//         if (values.length === 0) {
//           return 0;
//         }
//         values = [...values].sort((a, b) => a - b);
//         const half = Math.floor(values.length / 2);
//         return values.length % 2
//           ? values[half]
//           : (values[half - 1] + values[half]) / 2;
//       }
//       function average(values: number[]): number {
//         if (values.length === 0) {
//           return 0;
//         }
//         let sum = 0;
//         values.forEach((v) => (sum += v));
//         return sum / values.length;
//       }
//
//       for (const [trialIndex, [trialId, trajectory]] of Object.entries(
//         trajectories,
//       ).entries()) {
//         if (
//           trajectoryAnalysis != null &&
//           filteredTrialIds.length !== 0 &&
//           filteredTrialIds != null &&
//           !filteredTrialIds.includes(trialId)
//         ) {
//           continue;
//         }
//         const label = clusteringResult?.data[trialId].label;
//         if (trajectoryAnalysis != null && label == null) {
//           continue;
//         }
//
//         const trial = trajectoryAnalysis?.trials[trialId];
//         const metricValue = trial?.testObjectives?.criticalityMetrics.find(
//           (m) =>
//             String(m.keyPerformanceIndicator.id) ===
//             String(selectedMetric?.kpi?.id),
//         )?.value;
//         if (metricValue) {
//           metricValueMapping[trialId] = metricValue;
//         }
//       }
//
//       const metricMedian = median(Object.values(metricValueMapping));
//       setMetricMedian(metricMedian);
//
//       for (const [trialIndex, [trialId, trajectory]] of Object.entries(
//         trajectories,
//       ).entries()) {
//         if (
//           trajectoryAnalysis != null &&
//           filteredTrialIds.length !== 0 &&
//           filteredTrialIds != null &&
//           !filteredTrialIds.includes(trialId)
//         ) {
//           continue;
//         }
//
//         newTimeMax = Math.max(
//           newTimeMax,
//           trajectory["time"][trajectory["time"].length - 1],
//         );
//
//         const trial = trajectoryAnalysis?.trials[trialId];
//         const metricValue = trial?.testObjectives?.criticalityMetrics.find(
//           (m) =>
//             String(m.keyPerformanceIndicator.id) ===
//             String(selectedMetric?.kpi?.id),
//         )?.value;
//
//         if (viewerName in criticalityViewMetrics && metricValue != null) {
//           criticalityViewMetrics[viewerName].push(metricValue);
//           criticalityHalfs[viewerName][trialId] = metricValue;
//         }
//
//         agentsData[trialId] = {};
//         for (const [agentIndex, [agentName, agentTraj]] of Object.entries(
//           trajectory.trajectory,
//         ).entries()) {
//           let color = agentName === "Ego" ? chroma("blue") : chroma("red");
//           let alpha = 1.0;
//
//           if (!(agentName in agentsData[trialId])) {
//             const x = agentTraj[0]["x"];
//             const y = agentTraj[0]["y"];
//             const yaw = agentTraj[0]["yaw"] % PI_2; // Assuming `yaw` is in radians
//             let width = agentTraj[0]["width"] ?? 2.2;
//             let length = agentTraj[0]["length"] ?? 5.14;
//
//             width = width == 0 ? 2.2 : width;
//             length = length == 0 ? 5.14 : length;
//
//             const egoX = trajectory.trajectory["Ego"][0]["x"];
//             const egoY = trajectory.trajectory["Ego"][0]["y"];
//             const egoYaw = trajectory.trajectory["Ego"][0]["yaw"]; // Assuming `yaw` is in radians
//
//             let agentGraphic: Graphics | Sprite = new Sprite(Texture.WHITE);
//             let sprite: Sprite | undefined = undefined;
//             if (agentName === "Ego") {
//               sprite = new Sprite(viewer.egoTexture);
//               sprite.alpha = alpha;
//               sprite.tint = color.hex();
//               sprite.width = length;
//               sprite.height = width;
//               sprite.anchor.set(0.5);
//               sprite.position.set(x, y);
//               sprite.rotation = yaw + 3.14;
//               shapes.addChild(sprite);
//
//               const sceneAngleForEgo = -(-egoYaw + 3.14 / 2);
//               sceneNode.pivot.set(egoX, egoY);
//               sceneNode.position.set(0, 0);
//               sceneNode.rotation = sceneAngleForEgo;
//               viewport.moveCenter(0, 0);
//               viewport.setZoom(5);
//             } else {
//               agentGraphic.width = width;
//               agentGraphic.height = length;
//
//               agentGraphic.tint = color.hex();
//               agentGraphic.alpha = alpha;
//               agentGraphic.anchor.set(0.5);
//               agentGraphic.position.set(x, y);
//               agentGraphic.rotation = yaw + 3.14 / 2;
//               shapes.addChild(agentGraphic);
//             }
//
//             let durationIndexRange =
//               mfpca.durationIndices != null
//                 ? [...(mfpca.durationIndices[trialId] ?? [])]
//                 : null;
//             // console.log(trajectoryAnalysis?.request.framePeriod);
//             // console.log("prev");
//             // console.log(durationIndexRange);
//             const endIndex =
//               durationIndexRange == null
//                 ? null
//                 : (durationIndexRange[1] ?? 0) +
//                 afterClusteringDuration /
//                 (trajectoryAnalysis?.request.framePeriod ?? 1);
//             if (endIndex != null && durationIndexRange != null) {
//               durationIndexRange[1] = endIndex;
//             }
//
//             agentsData[trialId][agentName] = {
//               graphics: agentGraphic,
//               sprite,
//               getPositionAtTime: (t: number) => {
//                 return getPositionAtTime(
//                   t,
//                   trajectory.time,
//                   agentTraj.map((item, index) => {
//                     return {
//                       x: item.x,
//                       y: item.y,
//                       yaw: item.yaw,
//                     };
//                   }),
//                   durationIndexRange ?? [0, 50],
//                 );
//               },
//             };
//           }
//         }
//       }
//
//       appData.timeMax = newTimeMax;
//
//       for (const [_trialId, trialAgents] of Object.entries(agentsData)) {
//         for (const [agentName, agent] of Object.entries(trialAgents)) {
//           let agentUpdatedPosition = agent.getPositionAtTime(4.99);
//           if (
//             agentUpdatedPosition == null ||
//             isNaN(agentUpdatedPosition.x) ||
//             isNaN(agentUpdatedPosition.y)
//           ) {
//             agentUpdatedPosition = agent.getPositionAtTime(4.97);
//           }
//           if (
//             agentUpdatedPosition == null ||
//             isNaN(agentUpdatedPosition.x) ||
//             isNaN(agentUpdatedPosition.y)
//           ) {
//             agentUpdatedPosition = agent.getPositionAtTime(4.95);
//           }
//           if (
//             agentUpdatedPosition == null ||
//             isNaN(agentUpdatedPosition.x) ||
//             isNaN(agentUpdatedPosition.y)
//           ) {
//             agentUpdatedPosition = agent.getPositionAtTime(4.9);
//           }
//           if (
//             agentUpdatedPosition == null ||
//             isNaN(agentUpdatedPosition.x) ||
//             isNaN(agentUpdatedPosition.y)
//           ) {
//             agentUpdatedPosition = agent.getPositionAtTime(4.8);
//           }
//           if (
//             agentUpdatedPosition == null ||
//             isNaN(agentUpdatedPosition.x) ||
//             isNaN(agentUpdatedPosition.y)
//           ) {
//             agentUpdatedPosition = agent.getPositionAtTime(4.7);
//           }
//
//           // let agentUpdatedPosition = { x: 0, y: 0, yaw: 0 };
//           // agentUpdatedPosition.x =
//           //   agent.trajectory[agent.trajectory.length - 1].x;
//           // agentUpdatedPosition.y =
//           //   agent.trajectory[agent.trajectory.length - 1].y;
//           // agentUpdatedPosition.y =
//           //   agent.trajectory[agent.trajectory.length - 1].yaw;
//
//           agent.graphics.position.set(
//             agentUpdatedPosition?.x ?? 10000,
//             agentUpdatedPosition?.y ?? 10000,
//           );
//           agent.graphics.rotation = (agentUpdatedPosition?.yaw ?? 0) + 3.14 / 2;
//           if (agent.sprite && agentName === "Ego") {
//             agent.sprite.position.set(
//               agentUpdatedPosition?.x ?? 10000,
//               agentUpdatedPosition?.y ?? 10000,
//             );
//             agent.sprite.rotation = (agentUpdatedPosition?.yaw ?? 0) + 3.14;
//             agent.sprite.zIndex = 200;
//           }
//
//           agent.graphics.zIndex = 100;
//
//           let lineGraphics = new Graphics();
//
//           const initialPos = agent.getPositionAtTime(0);
//           lineGraphics.moveTo(initialPos?.x ?? 0, initialPos?.y ?? 0);
//           const timeGap = 0.1;
//           for (let t = timeGap; t < 5; t += timeGap) {
//             const pos = agent.getPositionAtTime(t);
//             if (pos == null) {
//               continue;
//             }
//             lineGraphics.lineTo(pos.x, pos.y);
//           }
//           lineGraphics.stroke({
//             color: agent.sprite?.tint ?? agent.graphics.tint,
//             pixelLine: true,
//           });
//           shapes.addChild(lineGraphics);
//           lineGraphicsArray.push(lineGraphics);
//         }
//       }
//
//       newViewerData[viewerName].tick = () => { };
//     }
//
//     setViewerData(newViewerData);
//
//     return () => {
//       for (const [viewerName, item] of Object.entries(newViewerData)) {
//         const app = viewers[viewerName].app;
//         app.ticker.remove(item.tick);
//         for (const trial of Object.values(item.agentsData)) {
//           for (const agent of Object.values(trial)) {
//             if (!agent.graphics.destroyed) {
//               agent.graphics.destroy({ children: true, context: true });
//             }
//           }
//         }
//         item.shapes.destroy({ children: true, context: true });
//       }
//       for (const g of lineGraphicsArray) {
//         if (g.destroyed) {
//           continue;
//         }
//         g.destroy({ children: true, context: true });
//       }
//     };
//   }, [
//     trajectories,
//     viewers,
//     timeSliderRef.current,
//     timeTypographyRef.current,
//     clusteringDurationMode,
//   ]);
//
//   let canvases: ReactNode[] = [];
//   canvases.push(<canvas id="replayer-main-canvas" ref={canvasRef}></canvas>);
//
//   return (
//     <Stack
//       component="div"
//       ref={containerRef}
//       sx={{ width: "100%", height: "100%", overflow: "hidden" }}
//     >
//       {canvases}
//       <Stack direction="row" sx={{ position: "absolute" }}>
//         <StyledToggleButtonGroup>
//           <ToggleButton
//             value="redraw"
//             size="small"
//             selected={false}
//             onChange={(event) => {
//               setRedrawHandled(false);
//             }}
//           >
//             <Redo />
//           </ToggleButton>
//         </StyledToggleButtonGroup>
//       </Stack>
//     </Stack>
//   );
// };
//
// export default CaseImageViewer;
//
// // util functions
// function interpolateLinear(
//   t: number,
//   t0: number,
//   t1: number,
//   p0: Position,
//   p1: Position,
// ): Position {
//   const ratio = (t - t0) / (t1 - t0);
//   let yaw = p0.yaw + ratio * (p1.yaw - p0.yaw);
//   return {
//     x: p0.x + ratio * (p1.x - p0.x),
//     y: p0.y + ratio * (p1.y - p0.y),
//     yaw: yaw,
//   };
// }
//
// type Position = { x: number; y: number; yaw: number };
//
// function getPositionAtTime(
//   t: number,
//   times: number[],
//   positions: Position[],
//   durationIndices?: number[],
// ): Position | null {
//   // Ensure the time is within bounds
//   if (t < times[0]) {
//     console.log("t < times[0]");
//     return null;
//   }
//   if (t > times[times.length - 1]) {
//     console.log("t < times[times.length - 1]");
//     return null;
//   }
//
//   // Find the interval using binary search
//   let low = 0;
//   let high = times.length - 1;
//
//   if (durationIndices) {
//     t = times[durationIndices[0]] + t;
//     low = durationIndices[0];
//     high = durationIndices[1];
//   }
//
//   while (low <= high) {
//     const mid = Math.floor((low + high) / 2);
//
//     if (times[mid] === t) {
//       return positions[mid]; // Exact match
//     } else if (times[mid] < t) {
//       low = mid + 1;
//     } else {
//       high = mid - 1;
//     }
//   }
//
//   // Interpolate between `high` and `low`
//   const t0 = times[high];
//   const t1 = times[low];
//   const p0 = positions[high];
//   let p1 = positions[low];
//
//   if (p1 == null) {
//     p1 = positions[high - 1];
//   }
//
//   return interpolateLinear(t, t0, t1, p0, p1);
// }
