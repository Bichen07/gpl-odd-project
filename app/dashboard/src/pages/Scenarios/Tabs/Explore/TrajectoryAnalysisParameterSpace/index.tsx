import chroma from "chroma-js";
import _ from "lodash";

import LineAxisIcon from "@mui/icons-material/LineAxis";
import InterestsIcon from "@mui/icons-material/Interests";
import CameraswitchIcon from "@mui/icons-material/Cameraswitch";
import SwipeRightAltIcon from "@mui/icons-material/SwipeRightAlt";
import ColorLensIcon from "@mui/icons-material/ColorLens";
import ArticleIcon from "@mui/icons-material/Article";
import ClearIcon from "@mui/icons-material/Clear";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import FilterTiltShiftIcon from "@mui/icons-material/FilterTiltShift";
import GrainIcon from "@mui/icons-material/Grain";

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
  IconButton,
  Drawer,
  Select,
} from "@mui/material";
import { Group } from "@visx/group";
import { useParentSize } from "@visx/responsive";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { AxisLeft, AxisBottom } from "@visx/axis";
import { scaleLinear } from "@visx/scale";
import { scaleLinear as d3ScaleLinear } from "d3-scale";
import { sessionSlice, ClusterInfo } from "src/redux/slices/session";
import createScatterplot from "src/regl-scatterplot";
import Contour from "./Contour";
import { ClusteringResult } from "src/api/services/TrajectoryAnalysis";

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
  "criticality",
  "pass/fail",
  "interaction-cluster",
] as const;
export type ColorMode = (typeof colorModes)[number];

const margin = {
  top: 40,
  right: 20,
  left: 60,
  bottom: 60,
};

const globalStorage: {
  scaleX: ReturnType<typeof d3ScaleLinear> | null;
  scaleY: ReturnType<typeof d3ScaleLinear> | null;
  trialOrder: string[];
} = {
  scaleX: null,
  scaleY: null,
  trialOrder: [],
};

export default function ParameterSpace() {
  const theme = useTheme();
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const backgroundImgRef = useRef<HTMLImageElement>(null);
  const axisSvgRef = useRef<SVGSVGElement>(null);
  const axisSvgParentSize = useParentSize({ debounceTime: 150 });
  const svgParentSize = useParentSize({ debounceTime: 150 });
  const dispatch = useAppDispatch();

  const resizeObserver = useMemo(() => {
    return new ResizeObserver((entries) => {
      for (let entry of entries) {
        entry.target.dispatchEvent(new Event("resize"));
        const { width, height } = entry.contentRect;
        setScales((prev) => {
          if (prev == null) {
            return null;
          }
          const newScaleX = scaleLinear<number>({
            domain: prev.x.domain(),
            range: [0, width],
            // range: [0, width - margin.left - margin.right],
          });
          const newScaleY = scaleLinear<number>({
            domain: prev.y.domain(),
            range: [0, height],
            // range: [0, height - margin.top - margin.bottom],
          });
          return {
            x: newScaleX,
            y: newScaleY,
          };
        });
      }
    });
  }, []);

  useEffect(() => {
    if (!svgParentSize.parentRef.current) {
      return;
    }
    resizeObserver.observe(svgParentSize.parentRef.current);
    return () => {
      if (!svgParentSize.parentRef.current) {
        return;
      }
      resizeObserver.unobserve(svgParentSize.parentRef.current);
    };
  }, [svgParentSize.parentRef.current, resizeObserver]);

  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusteringResult,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusterInfo,
  );
  const metrics = useAppSelector((state) => state.session.metrics);
  const selectedMetric = useAppSelector(
    (state) => state.session.selectedMetric,
  );
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.session.selectedTrialIds,
  );

  const [showLegend, setShowLegend] = useState(true);
  const [showGradient, setShowGradient] = useState(false);
  const [showPoints, setShowPoints] = useState(true);

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
    if (trajectoryAnalysis == null) {
      return;
    }
    const parameters = trajectoryAnalysis.clustering.parameters;
    if (parameters == null) {
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
      domain: [yMin, yMax],
      range: [0, svgParentSize.height],
      nice: true,
    });

    setScales({ x: scaleX, y: scaleY });
    setBound({ x: [xMin, xMax], y: [yMin, yMax] });
    globalStorage.scaleX = d3ScaleLinear().domain([xMin, xMax]);
    globalStorage.scaleY = d3ScaleLinear().domain([yMin, yMax]);
  }, [trajectoryAnalysis]);

  useEffect(() => {
    if (
      canvasRef.current == null ||
      globalStorage.scaleX == null ||
      globalStorage.scaleY == null ||
      backgroundImgRef.current?.src == null
    ) {
      return;
    }

    const plot = createScatterplot({
      canvas: canvasRef.current,
      pointSize: 10,

      showReticle: true,
      reticleColor: [0, 0, 0, 0.33],
      // backgroundColor: ,

      lassoMinDelay: 10,
      lassoMinDist: 2,
      lassoOnLongPress: true,
      lassoIndicator: true,
      lassoType: "freeform",

      colorBy: "value1",
      opacityBy: "value2",
      opacity: [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],

      xScale: globalStorage.scaleX,
      yScale: globalStorage.scaleY,

      backgroundImage: backgroundImgRef.current.src,
    });

    plot.subscribe("view", ({ xScale, yScale }) => {
      if (xScale == null || yScale == null) {
        return;
      }
      setScales((prev) => {
        if (prev == null) {
          return null;
        }
        const newScales = { ...prev };
        newScales.x?.domain([xScale.domain()[0], xScale.domain()[1]]);
        newScales.y?.domain([yScale.domain()[1], yScale.domain()[0]]);
        return newScales;
      });
    });

    plot.subscribe("select", ({ points }) => {
      const selection = points;
      if (selection.length === 1) {
        const trialId = globalStorage.trialOrder[selection[0]];
        dispatch(sessionSlice.actions.setSelectedTrialId(trialId));
        dispatch(sessionSlice.actions.setSelectedTrialIds([trialId]));
      } else {
        const selectedTrialIds = [];
        for (const index of selection) {
          selectedTrialIds.push(globalStorage.trialOrder[index]);
        }
        dispatch(sessionSlice.actions.setSelectedTrialIds(selectedTrialIds));
      }
    });

    plot.subscribe("deselect", () => {
      console.log("DESELECT PARAMETER SPACE");
      dispatch(sessionSlice.actions.setSelectedTrialId(null));
      dispatch(sessionSlice.actions.setSelectedTrialIds([]));
    });

    setScatterPlot(plot);

    return () => {
      plot.destroy();
    };
  }, [
    canvasRef.current,
    globalStorage.scaleX,
    globalStorage.scaleY,
    backgroundImgRef.current?.src,
  ]);

  useEffect(() => {
    if (scatterplot == null || clusterInfo == null) {
      return;
    }
    if (colorMode === "criticality") {
      let color = chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
      const colors = color.colors(20, "hex");
      if (selectedMetric && selectedMetric.kpi.rule === "greaterThan") {
        colors.reverse();
      }
      scatterplot.set({
        pointColor: colors,
      });
    } else {
      scatterplot.set({
        pointColor: [
          ...Object.values(clusterInfo).map((item) =>
            chroma(item.color).rgba(),
          ),
          chroma(theme.palette.error.light).rgba(),
          chroma(theme.palette.success.light).rgba(),
        ],
      });
    }
  }, [clusterInfo, scatterplot, colorMode, selectedMetric]);

  const drawPoints = useCallback(
    _.debounce(
      (
        scatterplot: ReturnType<typeof createScatterplot>,
        points: number[][],
        colorMode: ColorMode,
        filteredTrialIds: string[],
        selectedTrialIds: string[],
        clusteringResult: ClusteringResult | null,
        clusterInfo: ClusterInfo | null,
        spatialIndex?: ArrayBuffer,
      ) => {
        console.log("DRAW POINTS PARAMERTER SPACE");
        const newPoints = points;
        const selectedIndices = [];
        const filteredIndices = [];
        for (const [i, trialId] of globalStorage.trialOrder.entries()) {
          const trial = trajectoryAnalysis?.trials[trialId];

          if (selectedTrialIds != null) {
            let selected = selectedTrialIds.includes(trialId);
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
          const label = clusteringResult?.data[trialId].label ?? 0;
          let labelNumber = Number(label);
          if (clusteringResult?.task.method == "hierarchy") {
            labelNumber -= 1;
          }
          newPoints[i][2] = labelNumber;

          if (colorMode == "pass/fail") {
            const passed = Number(
              trial?.testObjectives?.criticalityMetrics.find(
                (m) =>
                  m.keyPerformanceIndicator.id ===
                  selectedSafetyBoundaryMetric?.kpi?.id,
              )?.passed,
            );
            newPoints[i][2] = Object.keys(clusterInfo ?? {}).length + passed;
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

          newPoints[i][3] = labelNumber;
        }
        scatterplot.draw(points, {
          spatialIndex,
          filter: filteredIndices,
          select: selectedIndices,
        });
      },
      100,
    ),
    [],
  );

  // create and draw points
  useEffect(() => {
    if (scatterplot == null || trajectoryAnalysis == null || bound == null) {
      return;
    }

    const trialOrder = Object.keys(trajectoryAnalysis.clustering.scores);
    const trials = trajectoryAnalysis.trials;
    const trialParameterPoints: number[][] = [];
    const points: number[][] = [];
    for (const trialId of trialOrder) {
      const trial = trials[trialId];
      const point = trial.parameters.map((p) => p.value ?? 0);
      trialParameterPoints.push(point);
      points.push([
        ((point[0] - bound.x[0]) / (bound.x[1] - bound.x[0])) * 2 - 1.0,
        ((point[1] - bound.y[0]) / (bound.y[1] - bound.y[0])) * 2 - 1.0,
        0,
        0,
      ]);
    }
    globalStorage.trialOrder = trialOrder;

    drawPoints(
      scatterplot,
      points,
      colorMode,
      filteredTrialIds,
      selectedTrialIds,
      clusteringResult,
      clusterInfo,
    );

    setPoints(points);
  }, [scatterplot, trajectoryAnalysis, bound]);

  // update points
  useEffect(() => {
    if (
      scatterplot == null ||
      clusteringResult == null ||
      clusterInfo == null
    ) {
      return;
    }
    setPoints((prev) => {
      const newPoints = [...prev];
      drawPoints(
        scatterplot,
        newPoints,
        colorMode,
        filteredTrialIds,
        selectedTrialIds,
        clusteringResult,
        clusterInfo,
        scatterplot.get("spatialIndex"),
      );
      return newPoints;
    });
  }, [filteredTrialIds, clusterInfo, colorMode, selectedTrialIds]);

  return (
    <Box
      component="div"
      sx={{
        width: "100%",
        height: "100%",
        overflow: "hidden",
        position: "relative",
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
          sx={{ position: "absolute", bottom: 0, right: margin.right }}
        >
          {`${
            trajectoryAnalysis?.clustering.parameters
              ? trajectoryAnalysis.clustering.parameters[0].name +
                ` [${trajectoryAnalysis.clustering.parameters[0].unit}]`
              : "x"
          }`}
        </Typography>
        <Typography
          sx={{
            position: "absolute",
            left: 0,
            top: margin.top,
            writingMode: "vertical-rl",
            transform: "rotate(180deg)",
          }}
        >
          {`${
            trajectoryAnalysis?.clustering.parameters
              ? trajectoryAnalysis.clustering.parameters[1].name +
                ` [${
                  trajectoryAnalysis.clustering.parameters[1].unit === "kph"
                    ? "m/s"
                    : trajectoryAnalysis.clustering.parameters[1].unit
                }]`
              : "y"
          }`}
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
              numTicks={10}
              tickLabelProps={{ fontSize: 12 }}
            />
            <AxisLeft
              tickLabelProps={{ fontSize: 12 }}
              scale={scales?.y ?? scaleLinear<number>()}
              numTicks={10}
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
        <canvas ref={canvasRef} />
      </Box>

      <Contour imgRef={backgroundImgRef} />

      <Stack
        direction="row"
        // columnGap={1}
        sx={{ position: "absolute", top: 0 }}
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
            value="select-to-filter"
            size="small"
            selected={false}
            onChange={(_event) => {
              dispatch(
                sessionSlice.actions.setFilteredTrialIds(selectedTrialIds),
              );
              dispatch(
                sessionSlice.actions.setFreeformTrialIds(selectedTrialIds),
              );
              dispatch(sessionSlice.actions.setSelectedTrialIds([]));
              dispatch(sessionSlice.actions.setSelectedTrialId(null));
            }}
          >
            <FilterTiltShiftIcon />
          </ToggleButton>
        </StyledToggleButtonGroup>
      </Stack>
    </Box>
  );
}
