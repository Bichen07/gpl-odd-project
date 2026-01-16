"use client";
import chroma from "chroma-js";
import _, { isNaN } from "lodash";
import { polygonArea, polygonHull } from "d3-polygon";
import concaveman from "concaveman";
// import from "point-in-polygon"
import pointInPolygon from "point-in-polygon";

import { PatternLines } from "@visx/pattern";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";

import { AreaClosed, Line, Bar } from "@visx/shape";

import { styled } from "@mui/material/styles";
import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
import { useTheme } from "@mui/material/styles";

import {
  Stack,
  Box,
  Typography,
  ToggleButton,
  ToggleButtonGroup,
  Menu,
  MenuItem,
} from "@mui/material";
import { Group } from "@visx/group";
import { useParentSize } from "@visx/responsive";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useAppDispatch, useAppSelector } from "../../../../../redux/hooks";
import { AxisLeft, AxisBottom } from "@visx/axis";
import { scaleLinear } from "@visx/scale";
import { scaleLinear as d3ScaleLinear } from "d3-scale";
import {
  batchSlice,
  ClusterInfo,
  CriticalityMetric,
} from "../../../../../redux/slices/batch";
import {
  ClusteringResult,
  TrajectoryAnalysisResponse,
} from "@/app/_shared/graphql/queries/clustering";
import createScatterplot from "regl-scatterplot";
import Contour from "../Contour";
import { noiseColor } from "@/app/_shared/utils";
import { interactionSlice } from "../../../../../redux/slices/interaction";
import { Trial } from "@/app/_shared/graphql/queries/trials";

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

export const glyphModes = ["pass/fail", "interaction-cluster"] as const;
export type GlyphMode = (typeof glyphModes)[number];

export const colorModes = [
  "criticality change",
  "criticality",
  "pass/fail",
  "interaction-cluster",
] as const;
export type ColorMode = (typeof colorModes)[number];

const margin = {
  top: 40,
  right: 20,
  left: 80,
  bottom: 60,
};

const globalStorage: {
  scaleX: ReturnType<typeof d3ScaleLinear>;
  scaleY: ReturnType<typeof d3ScaleLinear>;
  trialOrder: { [egoName: string]: string[] };
  camera: { distance: number; x: number; y: number } | null;
  mouseOnPanel: string;
  bound: { x: number[]; y: number[] } | null;
  points: { [egoName: string]: number[][] };
  showPoints: Set<string>;
  allEgos: string[];
} = {
  scaleX: d3ScaleLinear().domain([0, 1]),
  scaleY: d3ScaleLinear().domain([0, 1]),
  trialOrder: {},
  camera: null,
  mouseOnPanel: "",
  bound: null,
  points: {},
  showPoints: new Set(),
  allEgos: [],
};
let lastDistance = 1;
let lastTarget = [0, 0];

export default function Plot({ egoName = "ITRI" }: { egoName?: string }) {
  const panelName = "parameter_space";

  const theme = useTheme();
  const canvasRef = useRef<HTMLCanvasElement>(null);

  // const backgroundImgRef = useRef<HTMLImageElement>(null);
  const svgRef = useRef<SVGSVGElement>(null);
  const axisSvgRef = useRef<SVGSVGElement>(null);
  const axisSvgParentSize = useParentSize({ debounceTime: 150 });
  const svgParentSize = useParentSize({ debounceTime: 150 });
  const dispatch = useAppDispatch();
  const isBaseline = useAppSelector((state) => state.batch.baselineMode);
  const batchTrials = useAppSelector((state) => state.batch.trials);
  const batch = useAppSelector((state) => state.batch.batch);
  const mouseOnPanel = useAppSelector(
    (state) => state.interaction.currentPanel,
  );

  useEffect(() => {
    // globalStorage.allEgos = batch?.egos?.map((e) => e.name) ?? [];
    globalStorage.allEgos = ["ITRI", "ITRILatest"];
  }, [batch]);

  // const resizeObserver = useMemo(() => {
  //   return new ResizeObserver((entries) => {
  //     for (let entry of entries) {
  //       entry.target.dispatchEvent(new Event("resize"));
  //       const { width, height } = entry.contentRect;
  //     }
  //   });
  // }, []);

  // useEffect(() => {
  //   if (!svgParentSize.parentRef.current) {
  //     return;
  //   }
  //   resizeObserver.observe(svgParentSize.parentRef.current);
  //   return () => {
  //     if (!svgParentSize.parentRef.current) {
  //       return;
  //     }
  //     resizeObserver.unobserve(svgParentSize.parentRef.current);
  //   };
  // }, [svgParentSize.parentRef.current, resizeObserver]);

  useEffect(() => {
    globalStorage.mouseOnPanel = mouseOnPanel;
  }, [mouseOnPanel]);

  const interactionRecords = useAppSelector(
    (state) => state.interaction.records,
  );
  const interactionCamera = useAppSelector((state) => state.interaction.camera);
  const trajectoryAnalysisAll = useAppSelector((state) => {
    return state.batch.trajectoryAnalysis;
  });
  const trajectoryAnalysis = useAppSelector((state) => {
    if (state.batch.trajectoryAnalysis == null) {
      return;
    }
    return state.batch.trajectoryAnalysis[egoName];
  });
  const durationMode = useAppSelector((state) => state.batch.durationMode);
  const mfpca = useMemo(() => {
    if (trajectoryAnalysis == null) {
      return;
    }
    return trajectoryAnalysis.mfpca[durationMode];
  }, [trajectoryAnalysis, durationMode]);
  const clusteringResult = useAppSelector((state) =>
    state.batch.selectedClusteringResults != null &&
      egoName in state.batch.selectedClusteringResults
      ? state.batch.selectedClusteringResults[egoName]
      : null,
  );
  const clusterInfo = useAppSelector((state) =>
    state.batch.selectedClusterInfos != null &&
      egoName in state.batch.selectedClusterInfos
      ? state.batch.selectedClusterInfos[egoName]
      : null,
  );
  const metrics = useAppSelector((state) => state.batch.metrics);
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.batch.filteredTrialIds,
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.batch.selectedTrialIds,
  );
  const gridMode = useAppSelector((state) => state.batch.gridMode);

  // useEffect(() => {
  //   if (selectedTrialIds.value.length === 1) {
  //   }
  // }, [selectedTrialIds]);

  const [showLegend, setShowLegend] = useState(true);
  const [showBg, setShowBg] = useState(true);
  const [showGradient, setShowGradient] = useState(gridMode === "gradient");
  const [showPoints, setShowPoints] = useState(true);

  useEffect(() => {
    if (showPoints) {
      globalStorage.showPoints.add(egoName);
    } else {
      globalStorage.showPoints.delete(egoName);
    }
  }, [showPoints]);

  useEffect(() => {
    dispatch(
      batchSlice.actions.setGridMode(showGradient ? "gradient" : "prediction"),
    );
  }, [showGradient]);

  const [showPolygons, setShowPolygons] = useState(false);
  const [pointsDrawn, setPointsDrawn] = useState(false);

  const [metricImages, setMetricImages] = useState<{
    [metricName: string]: {
      [gridMode: string]: HTMLImageElement;
    };
  }>({});

  const [clusterHulls, setClusterHulls] = useState<{
    [label: string]: number[];
  }>({});
  const [clusterFailHulls, setClusterFailHulls] = useState<{
    [label: string]: number[];
  }>({});
  const [glyphMode, setGlyphMode] = useState<GlyphMode>("interaction-cluster");
  const [colorMode, setColorMode] = useState<ColorMode>("interaction-cluster");
  const [gradientDirectionMode, setGradientDirectionMode] = useState(false);
  const [scatterplot, setScatterPlot] = useState<ReturnType<
    typeof createScatterplot
  > | null>(null);

  const [points, setPoints] = useState<number[][]>([]);
  const [scales, setScales] = useState<{
    x: ReturnType<typeof scaleLinear<number>>;
    y: ReturnType<typeof scaleLinear<number>>;
  } | null>(null);
  const [bound, setBound] = useState<{ x: number[]; y: number[] } | null>(null);
  const [isReady, setIsReady] = useState(false);

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [menuOpened, setMenuOpened] = useState<string | null>(null);
  const handleMenuAnchorClick = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
    setMenuOpened(null);
  };

  useEffect(() => {
    lastDistance = 0;
    lastTarget[0] = 0;
    lastTarget[1] = 0;
  }, []);

  useEffect(() => {
    if (batch == null) {
      console.log("batch is null");
      return;
    }
    const parameters = batch.scenario.parameters;
    if (parameters == null) {
      console.log("parameter is null");
      return;
    }
    const xMin = parameters[0].min ?? 0;
    const xMax = parameters[0].max ?? 1;
    const yMin = parameters[1].min ?? 0;
    const yMax = parameters[1].max ?? 1;

    const scaleX = scaleLinear<number>({
      domain: [xMin, xMax],
      range: [0, svgParentSize.width],
      nice: true,
    });
    const scaleY = scaleLinear<number>({
      domain: [yMax, yMin],
      range: [0, svgParentSize.height],
      nice: true,
    });

    setScales({ x: scaleX, y: scaleY });
    console.log("UPDATE BOUND");
    setBound({ x: [xMin, xMax], y: [yMin, yMax] });

    globalStorage.scaleX.domain([xMin, xMax]);
    globalStorage.scaleY.domain([yMin, yMax]);
    setIsReady(true);
    // if (globalStorage.scaleX == null) {
    //   globalStorage.scaleX = d3ScaleLinear().domain([xMin, xMax]);
    // }
    // if (globalStorage.scaleY == null) {
    //   globalStorage.scaleY = d3ScaleLinear().domain([yMin, yMax]);
    // }
    // if (globalStorage.bound == null) {
    //   globalStorage.bound = { x: [xMin, xMax], y: [yMin, yMax] };
    // }
  }, [batch]);

  useEffect(() => {
    setScales((prev) => {
      if (prev == null) {
        return null;
      }
      const newScales = { ...prev };
      newScales.x.range([0, svgParentSize.width]);
      newScales.y.range([0, svgParentSize.height]);
      return newScales;
    });
  }, [svgParentSize.width, svgParentSize.height]);

  useEffect(() => {
    if (
      globalStorage.camera != null &&
      scatterplot != null &&
      globalStorage["mouseOnPanel"].split("_")[0] !== egoName
    ) {
      // scatterplot.t
      // scatterplot.set({"lassoLongPressTime"})
      scatterplot.zoomToLocation(
        [globalStorage.camera.x, globalStorage.camera.y],
        globalStorage.camera.distance,
      );
    }
  }, [globalStorage.camera]);

  useEffect(() => {
    if (
      canvasRef.current == null ||
      globalStorage.scaleX == null ||
      globalStorage.scaleY == null ||
      !isReady
    ) {
      console.log("CREATE SCATTER PLOT RETURN");
      return;
    }

    if (batch == null) {
      console.log("batch is null");
      return;
    }
    const parameters = batch.scenario.parameters;
    if (parameters == null) {
      console.log("parameter is null");
      return;
    }
    const xMin = parameters[0].min ?? 0;
    const xMax = parameters[0].max ?? 1;
    const yMin = parameters[1].min ?? 0;
    const yMax = parameters[1].max ?? 1;

    const scaleX = scaleLinear<number>({
      domain: [xMin, xMax],
      range: [0, svgParentSize.width],
      nice: true,
    });
    const scaleY = scaleLinear<number>({
      domain: [yMax, yMin],
      range: [0, svgParentSize.height],
      nice: true,
    });

    setScales({ x: scaleX, y: scaleY });
    setBound({ x: [xMin, xMax], y: [yMin, yMax] });

    globalStorage.scaleX.domain([xMin, xMax]);
    globalStorage.scaleY.domain([yMin, yMax]);

    let sizeFactor = 6.5;
    let sizes = [1, 1.2, 1.5, 1];
    // let sizes = [0.7, 1.5, 1.5, 0.7];
    // let sizes = [1, 1, 1, 1];
    const plot = createScatterplot({
      canvas: canvasRef.current,

      pointSize: [...sizes, ...sizes].map((v) => v * sizeFactor),
      // pointSize: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      // pointSize: [20, 22, 20, 20, 20, 20, 20, 20, 20],
      // pointSize: [size, size + 2, size, size, size, size, size, size, size],
      pointSizeSelected: sizeFactor * 2.5,

      showReticle: true,
      reticleColor: [0, 0, 0, 0.33],

      lassoMinDelay: 10,
      lassoMinDist: 2,
      lassoOnLongPress: true,
      lassoInitiator: true,

      sizeBy: "value2",
      colorBy: "value1",
      opacityBy: "value2",
      opacity: [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0],

      xScale: globalStorage.scaleX as any,
      yScale: globalStorage.scaleY as any,

      backgroundImage: null,
    });

    plot.subscribe("view", ({ xScale, yScale, camera }) => {
      if (xScale == null || yScale == null) {
        return;
      }

      if (globalStorage.mouseOnPanel.includes(egoName)) {
        globalStorage.camera = {
          x: camera.target[0],
          y: camera.target[1],
          // x: -camera.viewCenter[0],
          // y: -camera.viewCenter[1],
          distance: camera.distance[0],
        };
      }

      setScales((prev) => {
        if (prev == null) {
          return null;
        }
        const newScales = { ...prev };
        newScales.x?.domain([...xScale.domain()]);
        newScales.y?.domain([yScale.domain()[1], yScale.domain()[0]]);
        return newScales;
      });
      // setScales((prev) => {
      //   if (prev == null) {
      //     return null;
      //   }
      //   const newScales = { ...prev };
      //   newScales.x?.domain([xScale.domain()[0], xScale.domain()[1]]);
      //   newScales.y?.domain([yScale.domain()[1], yScale.domain()[0]]);
      //   return newScales;
      // });

      dispatch(interactionSlice.actions.record(panelName + ".camera"));
    });

    plot.subscribe("select", ({ points }) => {
      const selection = points;
      const trialOrder = globalStorage.trialOrder[egoName];
      if (selection.length === 1) {
        const trialId = trialOrder[selection[0]];
        console.log(trialId);
        dispatch(batchSlice.actions.setSelectedTrialId(trialId));
        dispatch(
          batchSlice.actions.setSelectedTrialIds({
            by: "parameterSpace",
            value: [trialId],
          }),
        );
      } else {
        const selectedTrialIdValues = [];
        for (const index of selection) {
          selectedTrialIdValues.push(trialOrder[index]);
        }
        dispatch(
          batchSlice.actions.setSelectedTrialIds({
            by: "parameterSpace",
            value: selectedTrialIdValues,
          }),
        );
      }

      dispatch(interactionSlice.actions.record(panelName + ".select"));
    });

    plot.subscribe("deselect", () => {
      console.log("DESELECT PARAMETER SPACE");
      dispatch(batchSlice.actions.setSelectedTrialId(null));
      dispatch(batchSlice.actions.setSelectedTrialIds({ by: "", value: [] }));
      dispatch(interactionSlice.actions.record(panelName + ".deselect"));
    });

    console.log("SET NEW SCATTER PLOT");
    setScatterPlot(plot);

    return () => {
      console.log("plot destoryed");
      plot.destroy();
    };
  }, [
    isReady,
    canvasRef.current,
    globalStorage.scaleX,
    globalStorage.scaleY,
    trajectoryAnalysis,
  ]);

  useEffect(() => {
    if (scatterplot == null || selectedMetric == null) {
      console.log(selectedMetric);
      console.log("COLORCHANGENULLRETURE");
      return;
    }
    console.log(clusterInfo);
    try {
      if (colorMode === "criticality change") {
        const inferno = [
          "#000004",
          "#1b0c41",
          "#4a0c6b",
          "#781c6d",
          "#a52c60",
          "#cf4446",
          "#ed6925",
          "#fb9b06",
          "#f7d13d",
          "#fcffa4",
        ];
        inferno.reverse();
        let color = chroma.scale(inferno).domain([0, 1]);
        const colors = color.colors(20, "hex");
        if (selectedMetric && selectedMetric.kpi.rule === "greaterThan") {
          colors.reverse();
        }
        scatterplot.set({
          pointColor: colors,
        });
      } else if (colorMode === "criticality") {
        let color = chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
        const colors = color.colors(20, "hex");
        if (selectedMetric && selectedMetric.kpi.rule === "greaterThan") {
          colors.reverse();
        }
        scatterplot.set({
          pointColor: colors,
        });
      } else if (clusterInfo == null || isBaseline) {
        scatterplot.set({
          pointColor: [
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
            chroma("black").rgba(),
          ],
        });
      } else {
        // console.log(clusterInfo);
        // let alpha = showPoints ? 1 : 0;
        let alpha = 1;
        let colors = [
          ...Object.entries(clusterInfo)
            .filter(([key, item]) => key !== "-1")
            .map(([_key, item]) => chroma(item.color).alpha(alpha).rgba()),
          chroma(theme.palette.error.light).alpha(alpha).rgba(),
          chroma(theme.palette.success.light).alpha(alpha).rgba(),
          chroma(theme.palette.error.light).alpha(alpha).rgba(),
          // chroma(theme.palette.warning.light).rgba(),
        ];
        console.log(colors);
        if (Object.keys(clusterInfo ?? {}).includes("-1")) {
          colors = [chroma(noiseColor).rgba(), ...colors];
        }
        // console.log(clusterInfo);
        // console.log(Object.keys(clusterInfo));
        // console.log(colors);
        scatterplot.set({
          pointColor: colors,
        });
      }
    } catch {
      console.error();
    }

    // scatterplot.set({
    //   pointColor: [
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //     chroma("black").rgba(),
    //   ],
    // });
  }, [
    clusterInfo,
    scatterplot,
    colorMode,
    selectedMetric,
    isBaseline,
    // showPoints,
  ]);

  const drawPoints = useCallback(
    _.debounce(
      (
        trajectoryAnalysis: TrajectoryAnalysisResponse | undefined | null,
        trials: Trial[],
        scatterplot: ReturnType<typeof createScatterplot>,
        points: number[][],
        colorMode: ColorMode,
        filteredTrialIds: string[],
        selectedTrialIds: { by: string; value: string[] },
        clusteringResult: ClusteringResult | null,
        clusterInfo: ClusterInfo | null,
        spatialIndex?: ArrayBuffer,
        selectedMetric?: CriticalityMetric | null,
        selectedSafetyBoundaryMetric?: CriticalityMetric | null,
        showPoints: boolean = true,
      ) => {
        console.log("DRAW POINTS PARAMERTER SPACE");

        const newPoints = points;
        const selectedIndices = [];
        const filteredIndices = [];
        for (const [i, trial] of trials.entries()) {
          const trialId = String(trial?.id) ?? "";
          if (selectedTrialIds.value.length > 0) {
            let selected = selectedTrialIds.value.includes(trialId);
            if (selected) {
              selectedIndices.push(i);
            }
          }

          const filtered =
            (filteredTrialIds.length > 0 &&
              filteredTrialIds.includes(trialId)) ||
            filteredTrialIds.length == 0;
          if (filtered) {
            filteredIndices.push(i);
          }
          const label =
            clusteringResult && trialId in (clusteringResult?.data ?? {})
              ? clusteringResult?.data[trialId].label
              : 0;
          let labelNumber = Number(label);
          if (
            clusteringResult?.task.method.includes("dbscan") &&
            Object.keys(clusterInfo ?? {}).includes("-1")
          ) {
            labelNumber += 1;
          }
          if (clusteringResult?.task.method.includes("hierarchy")) {
            labelNumber -= 1;
          }
          newPoints[i][2] = labelNumber;

          const passed = Number(
            trial?.testObjectives?.criticalityMetrics.find(
              (m) =>
                m.keyPerformanceIndicator.id ===
                selectedSafetyBoundaryMetric?.kpi?.id,
            )?.passed,
          );
          newPoints[i][3] = passed ? 0 : 1;
          // if (
          //   selectedSafetyBoundaryMetric != null &&
          //   selectedSafetyBoundaryMetric.kpi.name === "collision" &&
          //   trajectoryAnalysis != null &&
          //   trialId in trajectoryAnalysis.trials &&
          //   "collision_type" in trajectoryAnalysis.trials[trialId] &&
          //   trajectoryAnalysis.trials[trialId]["collision_type"] == 2
          // ) {
          //   newPoints[i][3] = 2;
          // }

          if (colorMode == "pass/fail") {
            // newPoints[i][2] =
            //   Object.keys(clusterInfo ?? {}).length +
            //   passed +
            //   (newPoints[i][3] === 2 && passed === 0 ? 2 : 0);
            newPoints[i][2] =
              Object.keys(clusterInfo ?? {}).length + passed + 0;
          }
          if (colorMode == "criticality change" && trajectoryAnalysis != null) {
            let gradients =
              trajectoryAnalysis.metricGradients[
              selectedMetric?.kpi?.name ?? ""
              ];
            let gradient =
              gradients != null && (trialId ?? "") in gradients
                ? gradients[trialId ?? ""]
                : [0, 0];
            let mag = Math.sqrt(
              gradient[0] * gradient[0] + gradient[1] * gradient[1],
            );
            let value =
              (mag - (selectedMetric?.gradMin ?? 0)) /
              ((selectedMetric?.gradMax ?? 1) - (selectedMetric?.gradMin ?? 0));
            newPoints[i][2] = value;
          }
          if (
            colorMode == "criticality" &&
            selectedMetric != null &&
            trial != null
          ) {
            let metricValue = trial.testObjectives?.criticalityMetrics.find(
              (m) => m.keyPerformanceIndicator.id === selectedMetric.kpi?.id,
            )?.value;

            metricValue =
              ((metricValue ?? 0) - (selectedMetric.min ?? 0)) /
              ((selectedMetric.max ?? 0) - (selectedMetric.min ?? 0));

            newPoints[i][2] = metricValue;
          }

          if (!showPoints) {
            newPoints[i][3] = 10;
          }
        }
        scatterplot.draw(points, {
          spatialIndex,
          filter: filteredIndices,
          select: selectedIndices,
        });
        setPointsDrawn(true);
      },
      100,
    ),
    [],
  );

  // create and draw points
  useEffect(() => {
    if (scatterplot == null || bound == null) {
      console.log("CREATE NULL RETURN");
      return;
    }
    console.log("Create and draw parameter space");

    let trials = batchTrials[egoName];
    if (trajectoryAnalysis != null) {
      trials = [];
      for (const trialId of Object.keys(mfpca?.scores ?? {})) {
        trials.push(trajectoryAnalysis.trials[trialId]);
      }
    }

    const trialParameterPoints: number[][] = [];
    const points: number[][] = [];
    for (const trial of trials ?? []) {
      const point = trial!.parameters.map((p) => p.value ?? 0);
      trialParameterPoints.push(point);
      points.push([
        ((point[0] - bound.x[0]) / (bound.x[1] - bound.x[0])) * 2 - 1.0,
        ((point[1] - bound.y[0]) / (bound.y[1] - bound.y[0])) * 2 - 1.0,
        0,
        0,
      ]);
    }
    globalStorage.trialOrder[egoName] = (trials ?? []).map(
      (t) => String(t?.id) ?? "unknown",
    );

    drawPoints(
      trajectoryAnalysis,
      trials ?? [],
      scatterplot,
      points,
      colorMode,
      filteredTrialIds,
      selectedTrialIds,
      clusteringResult,
      clusterInfo,
      undefined,
      selectedMetric,
      selectedSafetyBoundaryMetric,
    );

    globalStorage.points[egoName] = points;
    setPoints(points);

    if (scatterplot == null || Object.keys(globalStorage.points).length < 1) {
      return;
    }

    scatterplot.subscribe("lassoEnd", ({ coordinates }) => {
      // if (
      //   globalStorage.scaleX == null ||
      //   globalStorage.scaleY == null ||
      //   globalStorage.bound == null
      // ) {
      //   console.log(globalStorage.scaleX)
      //   console.log(globalStorage.scaleY)
      //   console.log(globalStorage.bound)
      //   console.log("early return lasso end");
      //   return;
      // }
      if (!trajectoryAnalysisAll || !trajectoryAnalysis) {
        return;
      }

      let coords = coordinates as any;

      const addedSelected: string[] = [];

      for (const ego of Object.keys(globalStorage.points)) {
        // console.log(ego);
        // console.log(trajectoryAnalysisAll);
        let trials = batchTrials[ego];
        if (trajectoryAnalysis != null && trajectoryAnalysisAll != null) {
          trials = [];
          for (const trialId of Object.keys(
            trajectoryAnalysisAll[ego].mfpca[durationMode]?.scores ?? {},
          )) {
            trials.push(trajectoryAnalysisAll[ego].trials[trialId]);
          }
        }
        // console.log(trials);

        for (const [i, point] of globalStorage.points[ego].entries()) {
          const isPointInPolygon = pointInPolygon([point[0], point[1]], coords);
          if (isPointInPolygon) {
            // @ts-ignore
            addedSelected.push(String(trials[i].id ?? "unknown"));
          }
        }
      }

      dispatch(
        batchSlice.actions.setSelectedTrialIds({
          by: "parameter_space",
          value: [...addedSelected],
        }),
      );
      // dispatch(state => state.actions)

      // const xMin = globalStorage.bound.x[-1];
      // const xMax = globalStorage.bound.x[0];
      // const yMin = globalStorage.bound.y[-1];
      // const yMax = globalStorage.bound.y[0];
      // const polygon: number[][] = [];
      // for (const coord of points) {
      //   const x = ((coord[-1] + 1.0) / 2) * (xMax - xMin) + xMin;
      //   const y = ((coord[0] + 1.0) / 2) * (yMax - yMin) + yMin;
      //   polygon.push([x, y]);
      // }
    });
  }, [scatterplot, bound]);

  // update points
  useEffect(() => {
    if (scatterplot == null || points.length === 0) {
      return;
    }
    console.log("UPDATE PARAM");
    let trials = batchTrials[egoName];
    if (trajectoryAnalysis != null) {
      trials = [];
      for (const trialId of Object.keys(mfpca?.scores ?? {})) {
        trials.push(trajectoryAnalysis.trials[trialId]);
      }
    }
    setPoints((prev) => {
      const newPoints = [...prev];

      drawPoints(
        trajectoryAnalysis,
        trials ?? [],
        scatterplot,
        newPoints,
        colorMode,
        filteredTrialIds,
        selectedTrialIds,
        clusteringResult,
        clusterInfo,
        scatterplot.get("spatialIndex"),
        selectedMetric,
        selectedSafetyBoundaryMetric,
        showPoints,
      );

      globalStorage.points[egoName] = newPoints;
      return newPoints;
    });
  }, [
    batchTrials,
    filteredTrialIds,
    clusterInfo,
    colorMode,
    selectedTrialIds,
    showPoints,
  ]);

  useEffect(() => {
    if (scatterplot == null || selectedMetric == null) {
      return;
    }
    if (
      showBg &&
      selectedMetric.kpi.name in metricImages &&
      metricImages[selectedMetric.kpi.name][gridMode] != null
    ) {
      scatterplot.set({
        backgroundImage: metricImages[selectedMetric.kpi.name][gridMode].src,
      });
    } else {
      scatterplot.set({ backgroundImage: null });
    }
  }, [scatterplot, showBg, metricImages, selectedMetric, gridMode]);

  return (
    <Box
      component="div"
      sx={{
        width: "100%",
        height: "100%",
        overflow: "hidden",
        position: "relative",
      }}
      onMouseEnter={() => {
        dispatch(
          interactionSlice.actions.setCurrentPanel(egoName + "_parameterSpace"),
        );
        if (!trajectoryAnalysis) {
          return;
        }
        dispatch(interactionSlice.actions.record(panelName + ".mouse_in"));
      }}
      onMouseLeave={() => {
        dispatch(interactionSlice.actions.setCurrentPanel(""));
        if (!trajectoryAnalysis) {
          return;
        }
        dispatch(interactionSlice.actions.record(panelName + ".mouse_leave"));
      }}
    >
      <Box
        component="div"
        id="parent-wrapper"
        ref={axisSvgParentSize.parentRef}
        sx={{
          width: "100%",
          height: "100%",
          position: "absolute",
          top: 0,
          overflow: "hidden",
        }}
      >
        <Typography
          sx={{
            position: "absolute",
            bottom: 5,
            right: margin.right,
            fontSize: 18,
            textWrap: "nowrap",
          }}
        >
          {`OncomingStartDelay [s]`}
          {/* {`${ */}
          {/*   batch?.scenario?.parameters */}
          {/*     ? batch?.scenario?.parameters[0].name + */}
          {/*       ` [${batch?.scenario?.parameters[0].unit}]` */}
          {/*     : "x" */}
          {/* }`} */}
        </Typography>
        <Typography
          sx={{
            fontSize: 18,
            position: "absolute",
            left: 1.5,
            top: margin.top,
            writingMode: "vertical-rl",
            transform: "rotate(180deg)",
            textWrap: "nowrap",
          }}
        >
          {`OncomingSpeed [m/s]`}
          {/* {`${ */}
          {/*   batch?.scenario?.parameters */}
          {/*     ? batch?.scenario.parameters[1].name + */}
          {/*       ` [${ */}
          {/*         batch?.scenario.parameters[1].unit === "kph" || */}
          {/*         batch?.scenario.parameters[1].unit === "seconds" */}
          {/*           ? "m/s" */}
          {/*           : batch?.scenario.parameters[1].unit */}
          {/*       }]` */}
          {/*     : "y" */}
          {/* }`} */}
        </Typography>

        <svg
          ref={axisSvgRef}
          width={axisSvgParentSize.width}
          height={axisSvgParentSize.height}
        >
          <Group top={margin.top} left={margin.left}>
            <AxisBottom
              top={svgParentSize.height}
              scale={scales?.x ?? scaleLinear<number>()}
              numTicks={5}
              tickLabelProps={{ fontSize: 16 }}
            />
            <AxisLeft
              tickLabelProps={{ fontSize: 16 }}
              scale={scales?.y ?? scaleLinear<number>()}
              numTicks={5}
            />
          </Group>
        </svg>
      </Box>

      <Box
        component="div"
        ref={svgParentSize.parentRef}
        sx={{
          overflow: "hidden",
          width: `calc(100% - ${margin.left}px - ${margin.right}px)`,
          height: `calc(100% - ${margin.top}px - ${margin.bottom}px)`,
          margin: `${margin.top}px ${margin.right}px ${margin.bottom}px ${margin.left}px`,
          position: "relative",
          top: 0,
        }}
      >
        <svg
          style={{ position: "absolute" }}
          ref={svgRef}
          width={svgParentSize.width}
          height={svgParentSize.height}
          pointerEvents="none"
        >
          <Group>
            {!pointsDrawn
              ? null
              : Object.entries(clusterHulls)
                .sort((a, b) => {
                  let aPoints: [number, number][] = [];
                  for (const pointIdx of a[1]) {
                    try {
                      const point = scatterplot?.getScreenPosition(pointIdx);
                      if (point) {
                        aPoints.push(point);
                      }
                    } catch (error) {
                      // console.error(error);
                    }
                  }
                  let bPoints: [number, number][] = [];
                  for (const pointIdx of b[1]) {
                    try {
                      const point = scatterplot?.getScreenPosition(pointIdx);
                      if (point) {
                        bPoints.push(point);
                      }
                    } catch (error) {
                      // console.error(error);
                    }
                  }
                  const aArea = polygonArea(aPoints);
                  const bArea = polygonArea(bPoints);
                  return aArea - bArea;
                })
                .map(([label, hull]) => {
                  if (label == "-1") {
                    return null;
                  }
                  let points: [number, number][] = [];
                  let pointsStr = "";
                  for (const pointIdx of hull) {
                    try {
                      const point = scatterplot?.getScreenPosition(pointIdx);
                      if (point) {
                        pointsStr += `${point[0]},${point[1]} `;
                        points.push(point);
                      }
                    } catch (error) {
                      // console.error(error);
                      // console.log(pointIdx);
                    }
                  }
                  // points = points.slice(0, -1);
                  pointsStr.trim();
                  let color = "black";
                  if (clusterInfo && clusterInfo[label]) {
                    color = clusterInfo[label].color;
                  }

                  let failHull = clusterFailHulls[label];
                  let failPoints: [number, number][] = [];
                  if (failHull) {
                    for (const pointIdx of failHull) {
                      try {
                        const point =
                          scatterplot?.getScreenPosition(pointIdx);
                        if (point) {
                          failPoints.push(point);
                        }
                      } catch (error) {
                        // console.error(error);
                        // console.log(pointIdx);
                      }
                    }
                  }
                  return (
                    <Box key={label}>
                      <PatternLines
                        id={`lines-${label}`}
                        height={7}
                        width={7}
                        stroke={color}
                        strokeWidth={1}
                        orientation={["diagonal"]}
                      />
                      <polygon
                        style={{ display: showPolygons ? "inherit" : "none" }}
                        points={pointsStr}
                        fill={color}
                        fillOpacity={0.3}
                        stroke={color}
                        strokeWidth={3}
                      />
                      <AreaClosed
                        style={{ display: showPolygons ? "inherit" : "none" }}
                        data={failPoints}
                        x={(p) => p[0]}
                        y={(p) => p[1]}
                        fill={`url(#lines-${label})`}
                        yScale={scaleLinear()}
                      />
                    </Box>
                  );
                })}
          </Group>
        </svg>

        <canvas ref={canvasRef} />
      </Box>

      <Contour setMetricImages={setMetricImages} egoName={egoName} />

      <Stack
        direction="row"
        // columnGap={1}
        sx={{
          position: "absolute",
          top: "-10px",
          overflowX: "scroll",
          scrollbarWidth: "none",
          width: "100%",
        }}
      >
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
          {colorModes.map((option) => {
            return (
              <MenuItem
                key={option}
                selected={option === colorMode}
                onClick={(event) => {
                  if (colorMode !== option) {
                    dispatch(
                      interactionSlice.actions.record(
                        panelName + ".change_points_color",
                      ),
                    );
                  }
                  handleMenuClose();
                  setColorMode(option);
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
            sx={{
              textWrap: "nowrap",
            }}
          >
            {/* {"Criticality Metric"} */}
            {"Point Color"}
            <ArrowDropDownIcon />
          </ToggleButton>
          <ToggleButton
            value="showing-gradient"
            size="small"
            selected={showGradient}
            onChange={(event) => {
              dispatch(
                interactionSlice.actions.record(
                  panelName +
                  (showGradient
                    ? ".toggleMetricBg"
                    : ".toggleMetricChangeBg"),
                ),
              );
              setShowGradient((prev) => !prev);
            }}
            sx={{
              textWrap: "nowrap",
            }}
          >
            {`${!showGradient ? "BG: Risk Change" : "BG: Risk Value"}`}
            {/* <WhatshotIcon /> */}
          </ToggleButton>
          <ToggleButton
            value="showing-bg"
            size="small"
            selected={showBg}
            onChange={(event) => {
              dispatch(
                interactionSlice.actions.record(
                  panelName + (showBg ? ".hideBg" : "showBg"),
                ),
              );
              setShowBg((prev) => !prev);
            }}
            sx={{
              textWrap: "nowrap",
            }}
          >
            {`${!showBg ? "Show" : "Hide"} BG`}
          </ToggleButton>
          <ToggleButton
            value="showing-points"
            size="small"
            selected={showPoints}
            onChange={(event) => {
              dispatch(
                interactionSlice.actions.record(
                  panelName + (showPoints ? ".hidePoints" : ".showPoints"),
                ),
              );
              setShowPoints((prev) => !prev);
            }}
            sx={{
              textWrap: "nowrap",
            }}
          >
            {/* <ScatterPlotIcon /> */}
            {`${!showPoints ? "Show" : "Hide"} FG`}
          </ToggleButton>
          {/* <ToggleButton */}
          {/*   value="showing-polygons" */}
          {/*   size="small" */}
          {/*   selected={showPolygons} */}
          {/*   onChange={(event) => { */}
          {/*     setShowPolygons((prev) => !prev); */}
          {/*   }} */}
          {/* > */}
          {/*   <PentagonIcon /> */}
          {/* </ToggleButton> */}
          {/* <ToggleButton */}
          {/*   value="select-to-filter" */}
          {/*   size="small" */}
          {/*   selected={false} */}
          {/*   onChange={(_event) => { */}
          {/*     dispatch( */}
          {/*       batchSlice.actions.setFilteredTrialIds(selectedTrialIds.value) */}
          {/*     ); */}
          {/*     dispatch( */}
          {/*       batchSlice.actions.setFreeformTrialIds(selectedTrialIds.value) */}
          {/*     ); */}
          {/*     dispatch( */}
          {/*       batchSlice.actions.setSelectedTrialIds({ by: "", value: [] }) */}
          {/*     ); */}
          {/*     dispatch(batchSlice.actions.setSelectedTrialId(null)); */}
          {/*   }} */}
          {/* > */}
          {/*   <FilterTiltShiftIcon /> */}
          {/* </ToggleButton> */}
          {/* <ToggleButton */}
          {/*   value="clear-filter" */}
          {/*   size="small" */}
          {/*   onClick={(event) => { */}
          {/*     if (filteredTrialIds.length > 0) { */}
          {/*       dispatch(batchSlice.actions.setFilteredTrialIds([])); */}
          {/*     } */}
          {/*     dispatch(batchSlice.actions.setFreeformTrialIds([])); */}
          {/*   }} */}
          {/* > */}
          {/*   <ClearIcon /> */}
          {/* </ToggleButton> */}
        </StyledToggleButtonGroup>
      </Stack>
    </Box>
  );
}
