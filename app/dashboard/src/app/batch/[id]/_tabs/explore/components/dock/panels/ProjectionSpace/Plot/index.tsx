"use client";

import chroma from "chroma-js";
import _ from "lodash";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";

import { AxisLeft, AxisBottom } from "@visx/axis";
import { Group } from "@visx/group";
import { useTheme } from "@mui/material/styles";
import {
  Box,
  Menu,
  MenuItem,
  Stack,
  Typography,
  ToggleButton,
  ToggleButtonGroup,
  Select,
  Button,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { scaleLinear } from "@visx/scale";
import { scaleLinear as d3ScaleLinear } from "d3-scale";
import { useParentSize } from "@visx/responsive";
import {
  ClusterInfo,
  CriticalityMetric,
  batchSlice,
} from "../../../../../redux/slices/batch";
import {
  ClusteringResult,
  TrajectoryAnalysisResponse,
} from "@/app/_shared/graphql/queries/clustering";
import { colorModes, ColorMode } from "../../../../../redux/slices/batch";
import { useAppDispatch, useAppSelector } from "../../../../../redux/hooks";
import createScatterplot from "regl-scatterplot";
import { noiseColor } from "@/app/_shared/utils";
import {
  CLUSTER_HIGHLIGHT_STYLE,
} from "@/app/_shared/utils/clusterHighlightRoles";
import { Settings } from "@mui/icons-material";
import { interactionSlice } from "../../../../../redux/slices/interaction";

export const plotModes = ["UMAP", "FPCs"] as const;
export type PlotMode = (typeof plotModes)[number];

// Helper function to compute the Fisher score for one component axis
// Function to compute the F-statistic for one component axis for multiple groups
function fScoreMultiple(scores: number[], labels: string[]) {
  // Identify the unique groups
  const groups = [...new Set(labels)];
  const nGroups = groups.length;
  const N = scores.length;

  // Compute overall mean for the component
  const overallMean = scores.reduce((sum, v) => sum + v, 0) / N;

  // For each group, compute the group mean and sum of squares within that group
  const groupStats = groups.map((g) => {
    const groupScores = scores.filter((_, i) => labels[i] === g);
    const n = groupScores.length;
    const mean = groupScores.reduce((sum: number, v: number) => sum + v, 0) / n;
    // Sum of squared deviations within the group (not divided by n, to get the sum)
    const ssWithinGroup = groupScores.reduce(
      (sum, v) => sum + (v - mean) ** 2,
      0
    );
    return { group: g, mean, n, ssWithinGroup };
  });

  // Calculate between-group sum of squares (SS_between)
  const ssBetween = groupStats.reduce(
    (sum, stat) => sum + stat.n * (stat.mean - overallMean) ** 2,
    0
  );
  const msBetween = ssBetween / (nGroups - 1);

  // Calculate within-group sum of squares (SS_within)
  const ssWithin = groupStats.reduce(
    (sum, stat) => sum + stat.ssWithinGroup,
    0
  );
  const msWithin = ssWithin / (N - nGroups);

  // F-statistic: ratio of between-group variance to within-group variance
  return msBetween / msWithin;
}

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

const globalStorage: {
  scaleX: ReturnType<typeof d3ScaleLinear>;
  scaleY: ReturnType<typeof d3ScaleLinear>;
  trialOrder: { [egoName: string]: string[] };
} = {
  scaleX: d3ScaleLinear().domain([0, 1]),
  scaleY: d3ScaleLinear().domain([0, 1]),
  trialOrder: {},
};
let lastDistance = 1;
let lastTarget = [0, 0];

export default function Plot({ egoName = "ITRI" }: { egoName?: string }) {
  const panelName = "projection_space";
  const theme = useTheme();
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);
  const dispatch = useAppDispatch();

  const axisSvgRef = useRef<SVGSVGElement>(null);
  const axisSvgParentSize = useParentSize({ debounceTime: 150 });

  const svgParentSize = useParentSize({ debounceTime: 150 });

  const trajectoryAnalysis = useAppSelector((state) => {
    if (state.batch.trajectoryAnalysis == null) {
      return;
    }
    return state.batch.trajectoryAnalysis[egoName];
  });
  const durationMode = useAppSelector((state) => state.batch.durationMode);
  const mfpca = useMemo(() => {
    return trajectoryAnalysis?.mfpca[durationMode];
  }, [trajectoryAnalysis, durationMode]);
  const clusteringResult = useAppSelector((state) =>
    state.batch.selectedClusteringResults != null &&
    egoName in state.batch.selectedClusteringResults
      ? state.batch.selectedClusteringResults[egoName]
      : null
  );
  const clusterInfo = useAppSelector((state) =>
    state.batch.selectedClusterInfos != null &&
    egoName in state.batch.selectedClusterInfos
      ? state.batch.selectedClusterInfos[egoName]
      : null
  );
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.batch.filteredTrialIds
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.batch.selectedTrialIds
  );
  const highlightRolesByTrialId = useAppSelector(
    (state) => state.batch.highlightRolesByTrialId,
  );
  const clusterAnalysis = useAppSelector(
    (state) => state.batch.clusterAnalysisByEgo?.[egoName] ?? null,
  );
  const medoidTrialIds = useMemo(
    () => new Set(Object.values(clusterAnalysis?.medoids ?? {})),
    [clusterAnalysis],
  );
  const shapeStrings = useAppSelector((state) => state.batch.shapeStrings);
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);

  const [plotMode, setPlotMode] = useState<PlotMode>("FPCs");
  const [colorMode, setColorMode] = useState<ColorMode>("interaction-cluster");
  const [axes, setAxes] = useState<string[]>(["FPC0", "FPC1"]);
  const [umapIndex, setUmapIndex] = useState(0);

  const [showLegend, setShowLegend] = useState(true);
  const [showGradient, setShowGradient] = useState(false);
  const [showPoints, setShowPoints] = useState(true);

  const [scales, setScales] = useState<{
    x: ReturnType<typeof scaleLinear<number>>;
    y: ReturnType<typeof scaleLinear<number>>;
  } | null>(null);
  const [bound, setBound] = useState<{ x: number[]; y: number[] } | null>(null);
  const [scatterplot, setScatterPlot] = useState<ReturnType<
    typeof createScatterplot
  > | null>(null);
  const [points, setPoints] = useState<number[][]>([]);
  const highlightMarkers = useMemo(() => {
    const order = globalStorage.trialOrder[egoName] ?? [];
    const selected = new Set(selectedTrialIds.value.map(String));
    const markers: Array<{
      index: number;
      role: "medoid" | "boundary" | "param_boundary" | "outlier";
    }> = [];
    if (selected.size === 0) return markers;

    // Only use roles from Highlight trials picks — never infer from cluster
    // membership (outlier trials are often also closest-pair endpoints).
    for (let i = 0; i < order.length; i++) {
      const tid = String(order[i]);
      if (!selected.has(tid)) continue;
      const roles = highlightRolesByTrialId[tid];
      if (roles == null) continue;
      for (const role of roles) {
        markers.push({ index: i, role });
      }
    }
    return markers;
  }, [points, egoName, selectedTrialIds, highlightRolesByTrialId]);
  const [mfpcaScores, setMfpcaScores] = useState<[string, number[]][]>([]);

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
    if (plotMode === "FPCs") {
      setAxes(["FPC0", "FPC1"]);
    } else {
      setAxes(["UMAP0", "UMAP1"]);
    }
  }, [plotMode]);

  const fpcNames = useMemo(() => {
    if (mfpca == null) {
      return [];
    }
    const scores = Object.values(mfpca.scores);
    if (scores.length === 0) {
      return [];
    }
    return scores[0].map((v, i) => `FPC${i}`);
  }, [trajectoryAnalysis]);
  const nonSelectedAxes: string[] = [];
  for (const fpcName of fpcNames) {
    if ((axes ?? []).includes(fpcName)) {
      continue;
    }
    nonSelectedAxes.push(fpcName);
  }

  const resizeObserver = useMemo(() => {
    return new ResizeObserver((entries) => {
      for (let entry of entries) {
        entry.target.dispatchEvent(new Event("resize"));
        const { width, height } = entry.contentRect;
      }
    });
  }, []);

  useEffect(() => {
    if (!containerRef.current) {
      return;
    }
    resizeObserver.observe(containerRef.current);
    return () => {
      if (!containerRef.current) {
        return;
      }
      resizeObserver.unobserve(containerRef.current);
    };
  }, [containerRef.current]);

  useEffect(() => {}, [trajectoryAnalysis]);

  const index0 = Number(axes[0].split("FPC")[1]);
  const index1 = Number(axes[1].split("FPC")[1]);

  useEffect(() => {
    if (!axes[0].includes("FPC") || mfpca == null) {
      return;
    }
    const scores = Object.entries(mfpca.scores).map(([_trialId, scores]) => {
      return {
        x: scores[index0],
        y: scores[index1],
      };
    });
    const xx = scores.map((d) => d.x);
    const xMax = Math.max(...xx);
    const xMin = Math.min(...xx);

    const yy = scores.map((d) => d.y);
    const yMax = Math.max(...yy);
    const yMin = Math.min(...yy);

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
    setIsReady(true);
  }, [axes, trajectoryAnalysis, mfpca]);

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

  // create scatter plot
  useEffect(() => {
    if (canvasRef.current == null || trajectoryAnalysis == null || !isReady) {
      return;
    }

    let sizeFactor = 5.5;
    let sizes = [1, 1, 1, 1];
    // let sizes = [1, 1.5, 1.5, 1];
    const plot = createScatterplot({
      canvas: canvasRef.current,
      // pointSize: [10, 12, 10, 10, 10, 10, 10, 10, 10],
      // pointSize: [5, 5 * 1.2, 5 * 1.2, 5, 5, 5, 5, 5, 5],
      pointSize: [...sizes, ...sizes].map((v) => v * sizeFactor),
      pointSizeSelected: sizeFactor * 1.5,

      showReticle: true,
      reticleColor: [0, 0, 0, 0.33],

      lassoMinDelay: 10,
      lassoMinDist: 2,
      lassoInitiator: false,
      // Left button is dedicated to selection: a plain left-drag draws a
      // selection range directly, a single left-click selects one point, and
      // ctrl+left-click adds to the current selection. Panning the background
      // is handled separately with the middle mouse button (see the pan
      // handler below), so the left button never pans.
      mouseMode: "lasso",
      ...({
        actionKeyMap: {
          lasso: "shift",
          rotate: "alt",
          merge: "ctrl",
          remove: "alt",
        },
      } as any),

      sizeBy: "value1",
      colorBy: "value1",
      opacityBy: "value2",
      opacity: [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],

      xScale: globalStorage.scaleX as any,
      yScale: globalStorage.scaleY as any,
    });

    plot.subscribe("view", ({ xScale, yScale, camera }) => {
      if (xScale == null || yScale == null) {
        return;
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

      // const { distance, target } = camera;
      // if (distance[0] !== lastDistance) {
      //   lastDistance = distance[0];
      //   dispatch(interactionSlice.actions.record(panelName + ".zoom"));
      // } else if (target[0] !== lastTarget[0] || target[1] !== lastTarget[1]) {
      //   lastTarget[0] = target[0];
      //   lastTarget[1] = target[1];
      //   dispatch(interactionSlice.actions.record(panelName + ".pan"));
      // }
      dispatch(interactionSlice.actions.record(panelName + ".camera"));
    });

    plot.subscribe("select", ({ points }) => {
      const selection = points;
      if (selection.length === 1) {
        const trialId = globalStorage.trialOrder[egoName][selection[0]];
        dispatch(batchSlice.actions.setSelectedTrialId(trialId));
        dispatch(
          batchSlice.actions.setSelectedTrialIds({
            by: "mfpca",
            value: [trialId],
          })
        );
      } else {
        const selectedTrialIdValues = [];
        for (const index of selection) {
          selectedTrialIdValues.push(globalStorage.trialOrder[egoName][index]);
        }
        // console.log(selection.length);
        // console.log(selectedTrialIdValues.length);
        dispatch(
          batchSlice.actions.setSelectedTrialIds({
            by: "mfpca",
            value: selectedTrialIdValues,
          })
        );
      }
      dispatch(interactionSlice.actions.record(panelName + ".select"));
    });

    plot.subscribe("deselect", () => {
      console.log("deselect mfpca");
      dispatch(batchSlice.actions.setSelectedTrialId(null));
      dispatch(batchSlice.actions.setSelectedTrialIds({ by: "", value: [] }));
      dispatch(interactionSlice.actions.record(panelName + ".deselect"));
    });

    setScatterPlot(plot);

    // --- Middle-mouse-button panning ---------------------------------------
    // The left mouse button is reserved for selection (mouseMode "lasso"), so
    // we disable the camera's built-in left-drag pan and instead pan when the
    // user drags with the middle mouse button (the scroll wheel button).
    const anyPlot = plot as any;
    const cameraController = anyPlot.get("camera");
    cameraController?.config?.({ isPan: false });

    const panCanvas = canvasRef.current;
    let midPanning = false;
    let lastPanX = 0;
    let lastPanY = 0;
    const onPanMouseDown = (event: globalThis.MouseEvent) => {
      if (event.button !== 1) return; // middle mouse button only
      event.preventDefault();
      midPanning = true;
      lastPanX = event.clientX;
      lastPanY = event.clientY;
    };
    const onPanMouseMove = (event: globalThis.MouseEvent) => {
      if (!midPanning || panCanvas == null) return;
      const rect = panCanvas.getBoundingClientRect();
      if (rect.width === 0 || rect.height === 0) return;
      const aspect = rect.width / rect.height;
      const panX = ((event.clientX - lastPanX) / rect.width) * 2 * aspect;
      const panY = ((lastPanY - event.clientY) / rect.height) * 2;
      lastPanX = event.clientX;
      lastPanY = event.clientY;
      cameraController?.pan?.([panX, panY]);
      anyPlot.redraw?.();
    };
    const onPanMouseUp = (event: globalThis.MouseEvent) => {
      if (event.button === 1) midPanning = false;
    };
    // Prevent the browser's middle-click autoscroll cursor on the canvas.
    const onAuxClick = (event: globalThis.MouseEvent) => {
      if (event.button === 1) event.preventDefault();
    };
    panCanvas?.addEventListener("mousedown", onPanMouseDown, { passive: false });
    window.addEventListener("mousemove", onPanMouseMove, { passive: true });
    window.addEventListener("mouseup", onPanMouseUp, { passive: true });
    panCanvas?.addEventListener("auxclick", onAuxClick);

    return () => {
      panCanvas?.removeEventListener("mousedown", onPanMouseDown);
      window.removeEventListener("mousemove", onPanMouseMove);
      window.removeEventListener("mouseup", onPanMouseUp);
      panCanvas?.removeEventListener("auxclick", onAuxClick);
      plot.destroy();
    };
  }, [isReady, canvasRef.current, trajectoryAnalysis]);

  // useEffect(() => {
  //   if (scatterplot == null) {
  //     return;
  //   }
  //   const selectedIndices = [...globalStorage.trialOrder.entries()]
  //     .filter(([index, trialId]) => {
  //       return selectedTrialIds.value.includes(trialId);
  //     })
  //     .map(([index, _trialId]) => index);
  //   const spatialIndex = scatterplot.get("spatialIndex");
  //   scatterplot.draw(points, { spatialIndex, select: selectedIndices });
  // }, [selectedTrialIds]);

  useEffect(() => {
    if (scatterplot == null) {
      return;
    }
    console.log("change point color");
    if (colorMode === "criticality") {
      let color = chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
      const colors = color.colors(20, "hex");
      if (selectedMetric && selectedMetric.kpi.rule === "greaterThan") {
        colors.reverse();
      }
      scatterplot.set({
        pointColor: colors,
      });
    } else if (clusterInfo == null) {
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
        ],
      });
    } else {
      let colors = [
        ...Object.entries(clusterInfo)
          .filter(([key, item]) => key !== "-1")
          .map(([_key, item]) => chroma(item.color).rgba()),
        chroma(theme.palette.error.light).rgba(),
        chroma(theme.palette.success.light).rgba(),
        chroma(theme.palette.error.light).rgba(),
        // chroma(theme.palette.warning.light).rgba(),
      ];
      if (Object.keys(clusterInfo ?? {}).includes("-1")) {
        colors = [chroma(noiseColor).rgba(), ...colors];
      }
      scatterplot.set({
        pointColor: colors,
      });
    }
  }, [clusterInfo, scatterplot, colorMode, selectedMetric]);

  const drawPoints = useCallback(
    _.debounce(
      (
        trajectoryAnalysis: TrajectoryAnalysisResponse | null,
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
        medoidTrialIds: Set<string> = new Set(),
      ) => {
        const newPoints = points;
        const filteredIndices = [];
        const selectedIndices = [];
        const medoidIndices: number[] = [];
        for (let i = 0; i < newPoints.length; i++) {
          const trialId = globalStorage.trialOrder[egoName][i];
          const trial = trajectoryAnalysis?.trials[trialId];

          if (selectedTrialIds.value.length > 0) {
            let selected = selectedTrialIds.value.includes(trialId);
            if (selected) {
              selectedIndices.push(i);
            }
          }
          if (medoidTrialIds.has(trialId)) {
            medoidIndices.push(i);
          }

          const filtered =
            (filteredTrialIds.length > 0 &&
              filteredTrialIds.includes(trialId)) ||
            filteredTrialIds.length == 0;
          if (filtered) {
            filteredIndices.push(i);
          }
          // if (selectedPairTrialId != null) {
          // }

          const label = clusteringResult?.data[trialId].label ?? 0;
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
                selectedSafetyBoundaryMetric?.kpi?.id
            )?.passed
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
          if (
            colorMode == "criticality" &&
            selectedMetric != null &&
            trial != null
          ) {
            let metricValue = trial.testObjectives?.criticalityMetrics.find(
              (m) => m.keyPerformanceIndicator.id === selectedMetric.kpi?.id
            )?.value;

            metricValue =
              ((metricValue ?? 0) - (selectedMetric.min ?? 0)) /
              ((selectedMetric.max ?? 0) - (selectedMetric.min ?? 0));

            newPoints[i][2] = metricValue;
          }
          // newPoints[i][3] = labelNumber;
          // newPoints[i][3] = passed ? 0 : 1;
        }
        scatterplot.draw(newPoints, {
          spatialIndex,
          filter: filteredIndices,
          // Highlight trials use SVG overlays. Feeding them into regl-scatterplot
          // select causes deselect/select echoes that fight Redux and can loop.
          select:
            selectedTrialIds.by === "highlight" ? [] : selectedIndices,
        });
      },
      100
    ),
    []
  );

  // create and draw points
  useEffect(() => {
    if (
      scatterplot == null ||
      trajectoryAnalysis == null ||
      bound == null ||
      mfpca == null
    ) {
      return;
    }

    const trialOrder: string[] = [];
    let points: number[][] = [];
    if (plotMode === "FPCs") {
      const mfpcaScores = Object.entries(mfpca.scores ?? {});
      points = mfpcaScores.map(([trialId, scores]) => {
        // if (clusteringResult == null || clusterInfo == null || scales == null) {
        //   return [];
        // }
        trialOrder.push(trialId);
        const label = clusteringResult?.data[trialId].label ?? "0";
        let labelNumber = Number(label);
        if (clusteringResult?.task.method.includes("hierarchy")) {
          labelNumber -= 1;
        }
        return [
          ((scores[index0] - bound.x[0]) / (bound.x[1] - bound.x[0])) * 2 - 1.0,
          ((scores[index1] - bound.y[0]) / (bound.y[1] - bound.y[0])) * 2 - 1.0,
          0,
          0,
        ];
      });
    } else {
      let projections = mfpca.umapProjections[umapIndex].data;
      let minX = Infinity;
      let maxX = -Infinity;
      let minY = Infinity;
      let maxY = -Infinity;
      for (const [_trialId, projection] of Object.entries(projections)) {
        const x = projection[0];
        const y = projection[1];
        minX = Math.min(x, minX);
        maxX = Math.max(x, maxX);
        minY = Math.min(y, minY);
        maxY = Math.max(y, maxY);
      }
      for (const [trialId, projection] of Object.entries(projections)) {
        const x = projection[0];
        const y = projection[1];
        trialOrder.push(trialId);
        points.push([
          (x - minX) / (maxX - minX),
          (y - minY) / (maxY - minY),
          0,
          0,
        ]);
      }
    }

    globalStorage.trialOrder[egoName] = trialOrder;

    drawPoints(
      trajectoryAnalysis,
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
      medoidTrialIds,
    );

    setPoints(points);

    return () => {
      // scatterplot.clearPoints();
    };
  }, [scatterplot, bound, plotMode, umapIndex]);

  // update points
  useEffect(() => {
    if (scatterplot == null) {
      return;
    }
    console.log("UPDATE POINTS MFPCA");
    setPoints((prev) => {
      const newPoints = [...prev];
      drawPoints(
        trajectoryAnalysis ?? null,
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
        medoidTrialIds,
      );
      return newPoints;
    });
  }, [
    clusterInfo,
    colorMode,
    filteredTrialIds,
    selectedTrialIds,
    selectedMetric,
    selectedSafetyBoundaryMetric,
    medoidTrialIds,
  ]);

  const margin = {
    top: 40,
    right: 20,
    left: 60,
    bottom: 60,
  };

  const isBaseline = useAppSelector((state) => state.batch.baselineMode);
  if (isBaseline) {
    return null;
  }

  return (
    <Box
      sx={{
        width: "100%",
        height: "100%",
        overflow: "hidden",
        position: "relative",
      }}
      component="div"
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
          }}
        >
          {`${axes[0]}`}{" "}
          {plotMode == "UMAP"
            ? ""
            : `(${(
                (mfpca?.explainedVarianceRatio[
                  Number(axes[0].split("FPC")[1])
                ] ?? 0) * 100
              ).toFixed(1)}%)`}
        </Typography>
        <Typography
          sx={{
            position: "absolute",
            left: 5,
            fontSize: 18,
            top: margin.top,
            writingMode: "vertical-rl",
            transform: "rotate(180deg)",
          }}
        >
          {`${axes[1]}`}{" "}
          {plotMode == "UMAP"
            ? ""
            : `(${(
                (mfpca?.explainedVarianceRatio[
                  Number(axes[1].split("FPC")[1])
                ] ?? 0) * 100
              ).toFixed(1)}%)`}
        </Typography>

        {trajectoryAnalysis == null ? null : (
          <svg
            ref={axisSvgRef}
            width={axisSvgParentSize.width}
            height={axisSvgParentSize.height}
            style={{ display: plotMode !== "FPCs" ? "none" : "inherit" }}
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
        )}
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
        {trajectoryAnalysis == null ? null : <canvas ref={canvasRef} />}
        {trajectoryAnalysis != null && highlightMarkers.length > 0 && (
          <svg
            style={{ position: "absolute", top: 0, left: 0, pointerEvents: "none" }}
            width={svgParentSize.width}
            height={svgParentSize.height}
          >
            {highlightMarkers.map(({ index: pointIdx, role }) => {
              try {
                const point = scatterplot?.getScreenPosition(pointIdx);
                if (!point) return null;
                const style = CLUSTER_HIGHLIGHT_STYLE[role];
                const [cx, cy] = point;
                if (role === "medoid") {
                  return (
                    <circle
                      key={`hl-${role}-${pointIdx}`}
                      cx={cx}
                      cy={cy}
                      r={10}
                      fill="none"
                      stroke={style.color}
                      strokeWidth={3}
                    />
                  );
                }
                if (role === "boundary") {
                  const s = 9;
                  return (
                    <polygon
                      key={`hl-${role}-${pointIdx}`}
                      points={`${cx},${cy - s} ${cx + s},${cy} ${cx},${cy + s} ${cx - s},${cy}`}
                      fill="none"
                      stroke={style.color}
                      strokeWidth={2.5}
                    />
                  );
                }
                if (role === "param_boundary") {
                  const s = 8;
                  return (
                    <rect
                      key={`hl-${role}-${pointIdx}`}
                      x={cx - s}
                      y={cy - s}
                      width={s * 2}
                      height={s * 2}
                      fill="none"
                      stroke={style.color}
                      strokeWidth={2.5}
                    />
                  );
                }
                const s = 10;
                return (
                  <polygon
                    key={`hl-${role}-${pointIdx}`}
                    points={`${cx},${cy - s} ${cx + s},${cy + s * 0.7} ${cx - s},${cy + s * 0.7}`}
                    fill="none"
                    stroke={style.color}
                    strokeWidth={2.5}
                  />
                );
              } catch {
                return null;
              }
            })}
          </svg>
        )}
      </Box>

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
                  handleMenuClose();
                  setColorMode(option);
                  if (colorMode !== option) {
                    dispatch(
                      interactionSlice.actions.record(
                        panelName + ".change_points_color"
                      )
                    );
                  }
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
          {/*   sx={{ */}
          {/*     textWrap: "nowrap", */}
          {/*   }} */}
          {/* > */}
          {/*   ColorLensIcon /> */}
          {/*   {"Point Color"} */}
          {/*   <ArrowDropDownIcon /> */}
          {/* </ToggleButton> */}
          {/* <ClusterSelection */}
          {/*   opened={menuOpened === "cluster"} */}
          {/*   setOpened={() => setMenuOpened("cluster")} */}
          {/*   handleClose={handleMenuClose} */}
          {/* /> */}
          <ToggleButton
            id="select-axis-button"
            value="select-axis"
            size="small"
            selected={false}
            onChange={(event) => {
              if (event.currentTarget === anchorEl) {
                setAnchorEl(null);
              } else {
                setAnchorEl(event.currentTarget);
              }
            }}
            sx={{
              textWrap: "nowrap",
            }}
          >
            {/* <Settings /> */}
            {"Axes"}
            <ArrowDropDownIcon />
          </ToggleButton>
          {/* <Select */}
          {/*   sx={{ maxHeight: "35px", fontSize: 14 }} */}
          {/*   value={umapIndex} */}
          {/*   size="small" */}
          {/*   onChange={(event) => { */}
          {/*     setUmapIndex(event.target.value as number); */}
          {/*   }} */}
          {/* > */}
          {/*   {mfpca?.umapProjections.map((_, i) => ( */}
          {/*     <MenuItem key={i} value={i}> */}
          {/*       <Typography> */}
          {/*         minDist: {mfpca?.umapProjections[i].parameters.minDist} */}
          {/*       </Typography> */}
          {/*       <Typography> */}
          {/*         nNeighbors: {mfpca?.umapProjections[i].parameters.nNeighbors} */}
          {/*       </Typography> */}
          {/*     </MenuItem> */}
          {/*   ))} */}
          {/* </Select> */}
          {/* <ToggleButton */}
          {/*   id="show-functional-button" */}
          {/*   value="show-functional" */}
          {/*   size="small" */}
          {/*   selected={false} */}
          {/*   onChange={(event) => { */}
          {/*     if (event.currentTarget === anchorEl) { */}
          {/*       setAnchorEl(null); */}
          {/*     } else { */}
          {/*       setAnchorEl(event.currentTarget); */}
          {/*     } */}
          {/*   }} */}
          {/*   sx={{ */}
          {/*     textWrap: "nowrap", */}
          {/*   }} */}
          {/* > */}
          {/*   <LineAxisIcon /> */}
          {/*   {"Functional Curves"} */}
          {/*   <ArrowDropDownIcon /> */}
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
        </StyledToggleButtonGroup>
      </Stack>

      <Menu
        // hideBackdrop
        anchorEl={anchorEl}
        open={anchorEl?.id === "select-axis-button"}
        onClose={() => {
          setAnchorEl(null);
        }}
        // sx={{ height: 0 }}
      >
        <Stack sx={{ p: 1 }} rowGap={1}>
          {/* <Stack direction="row" justifyContent="flex-end" alignItems="center"> */}
          {/*   <IconButton onClick={() => setAnchorEl(null)}> */}
          {/*     <CloseIcon /> */}
          {/*   </IconButton> */}
          {/* </Stack> */}
          <ToggleButtonGroup
            sx={{ mr: 2 }}
            size="small"
            color="primary"
            value={plotMode}
            defaultValue={plotMode}
            exclusive
            onChange={(_event, value) => {
              setPlotMode(value as PlotMode);

              dispatch(
                interactionSlice.actions.record(
                  panelName +
                    ((value as PlotMode) === "UMAP"
                      ? ".change_to_umap"
                      : ".change_to_mfpca")
                )
              );
            }}
          >
            {plotModes.map((mode) => (
              <ToggleButton value={mode}>{mode}</ToggleButton>
            ))}
          </ToggleButtonGroup>
          {/* <Stack> */}
          {/*   <Button */}
          {/*     onClick={() => { */}
          {/*       if ( */}
          {/*         !trajectoryAnalysis || */}
          {/*         clusteringResult == null || */}
          {/*         mfpca == null */}
          {/*       ) { */}
          {/*         return; */}
          {/*       } */}
          {/*       const scores = mfpca.scores ?? {}; */}
          {/*       if (Object.keys(scores).length === 0) { */}
          {/*         return; */}
          {/*       } */}
          {/*       const filteredScores = Object.entries(scores).filter( */}
          {/*         ([trialId, scores]) => { */}
          {/*           return filteredTrialIds.includes(trialId); */}
          {/*         } */}
          {/*       ); */}
          {/*       const scoresByComponent: { axis: number; fScore: number }[] = */}
          {/*         []; */}
          {/*       const nComponents = Object.values(scores)[0].length; */}
          {/*       for (let j = 0; j < nComponents; j++) { */}
          {/*         // Extract scores for the j-th component across all samples */}
          {/*         const componentScores = filteredScores.map( */}
          {/*           (row) => row[1][j] */}
          {/*         ); */}
          {/*         const labels = filteredScores.map((row) => { */}
          {/*           const trialId = row[0]; */}
          {/*           const trial = trajectoryAnalysis.trials[trialId]; */}
          {/*           if (colorMode === "interaction-cluster") { */}
          {/*             return clusteringResult.data[row[0]].label; */}
          {/*           } else { */}
          {/*             const passed = Number( */}
          {/*               trial.testObjectives?.criticalityMetrics.find( */}
          {/*                 (m) => */}
          {/*                   m.keyPerformanceIndicator.id === */}
          {/*                   selectedSafetyBoundaryMetric?.kpi?.id */}
          {/*               )?.passed */}
          {/*             ); */}
          {/*             return passed.toString(); */}
          {/*           } */}
          {/*         }); */}
          {/*         const fScore = fScoreMultiple(componentScores, labels); */}
          {/*         scoresByComponent.push({ axis: j, fScore }); */}
          {/*       } */}
          {/*       // Sort components by F-score in descending order */}
          {/*       scoresByComponent.sort((a, b) => b.fScore - a.fScore); */}
          {/**/}
          {/*       // Choose the two best components for group separation */}
          {/*       const bestAxes = scoresByComponent */}
          {/*         .slice(0, 2) */}
          {/*         .map((item) => item.axis); */}
          {/*       console.log("Best axes for group separation:", bestAxes); */}
          {/**/}
          {/*       setAxes([`FPC${bestAxes[0]}`, `FPC${bestAxes[1]}`]); */}
          {/*     }} */}
          {/*   > */}
          {/*     Auto Select */}
          {/*   </Button> */}
          {/* </Stack> */}
          <Stack direction="row" flexWrap="wrap" rowGap={2} columnGap={2}>
            {(axes ?? []).map((axis, index) => {
              return (
                <Stack
                  spacing={1}
                  direction="row"
                  alignItems="center"
                  key={index}
                  sx={{ display: plotMode === "UMAP" ? "none" : "flex" }}
                >
                  <Typography fontSize={14} color="text.disabled">{`${
                    index === 0 ? "x" : "y"
                  } axis`}</Typography>
                  <Select
                    sx={{ maxHeight: "35px", fontSize: 14 }}
                    value={axis}
                    size="small"
                    onChange={(event) => {
                      dispatch(
                        interactionSlice.actions.record(
                          panelName + ".change_fpc_axis"
                        )
                      );
                      setAxes((prev) => {
                        if (prev === null) {
                          return prev;
                        }
                        prev = [...prev];
                        prev[index] = event.target.value as string;
                        return prev;
                      });
                    }}
                  >
                    {fpcNames.map((fpcName, i) => (
                      <MenuItem
                        disabled={!nonSelectedAxes.includes(fpcName)}
                        key={i}
                        value={fpcName}
                      >
                        {fpcName}
                      </MenuItem>
                    ))}
                  </Select>
                </Stack>
              );
            })}
          </Stack>
        </Stack>
      </Menu>
    </Box>
  );
}
