import chroma from "chroma-js";

import _ from "lodash";
import LineAxisIcon from "@mui/icons-material/LineAxis";
import InterestsIcon from "@mui/icons-material/Interests";
import CameraswitchIcon from "@mui/icons-material/Cameraswitch";
import SwipeRightAltIcon from "@mui/icons-material/SwipeRightAlt";
import ColorLensIcon from "@mui/icons-material/ColorLens";
import ArticleIcon from "@mui/icons-material/Article";
import FilterTiltShiftIcon from "@mui/icons-material/FilterTiltShift";
import ClearIcon from "@mui/icons-material/Clear";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import GrainIcon from "@mui/icons-material/Grain";

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
  IconButton,
  Drawer,
  Select,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { scaleLinear } from "@visx/scale";
import { scaleLinear as d3ScaleLinear } from "d3-scale";
import { useParentSize } from "@visx/responsive";
import createScatterplot from "src/regl-scatterplot";
import { ClusterInfo, sessionSlice } from "src/redux/slices/session";
import { colorModes, ColorMode } from "../TrajectoryAnalysisParameterSpace";
import { Close } from "@mui/icons-material";
import { ClusteringResult } from "src/api/services/TrajectoryAnalysis";
import FunctionalCurves from "./FunctionalCurves";

export const plotModes = ["UMAP", "Original"] as const;
export type PlotMode = (typeof plotModes)[number];

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
  scaleX: ReturnType<typeof d3ScaleLinear> | null;
  scaleY: ReturnType<typeof d3ScaleLinear> | null;
  trialOrder: string[];
} = {
  scaleX: null,
  scaleY: null,
  trialOrder: [],
};

export default function TrajectoryAnalysisMfpca() {
  const theme = useTheme();
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);
  const dispatch = useAppDispatch();

  const axisSvgRef = useRef<SVGSVGElement>(null);
  const axisSvgParentSize = useParentSize({ debounceTime: 150 });

  const svgParentSize = useParentSize({ debounceTime: 150 });

  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusteringResult,
  );
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );
  const selectedPairTrialId = useAppSelector(
    (state) => state.session.selectedPairTrialId,
  );
  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.session.selectedTrialIds,
  );
  const shapeStrings = useAppSelector((state) => state.session.shapeStrings);
  const selectedMetric = useAppSelector(
    (state) => state.session.selectedMetric,
  );

  const [plotMode, setPlotMode] = useState<PlotMode>("Original");
  const [colorMode, setColorMode] = useState<ColorMode>("interaction-cluster");
  const [axes, setAxes] = useState<string[]>(["FPC0", "FPC1"]);

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
  const [mfpcaScores, setMfpcaScores] = useState<[string, number[]][]>([]);

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
    if (plotMode === "Original") {
      setAxes(["FPC0", "FPC1"]);
    } else {
      setAxes(["UMAP0", "UMAP1"]);
    }
  }, [plotMode]);

  const fpcNames = useMemo(() => {
    if (trajectoryAnalysis == null) {
      return [];
    }
    const scores = Object.values(trajectoryAnalysis.clustering.scores);
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
    const scores = Object.entries(
      trajectoryAnalysis?.clustering.scores ?? {},
    ).map(([trialId, scores]) => {
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

    globalStorage.scaleX = d3ScaleLinear().domain([xMin, xMax]);
    globalStorage.scaleY = d3ScaleLinear().domain([yMin, yMax]);
  }, [axes, trajectoryAnalysis]);

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
    if (
      canvasRef.current == null ||
      globalStorage.scaleX == null ||
      globalStorage.scaleY == null
    ) {
      return;
    }

    console.log("RECREATE MFPCA PLOT");
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
        newScales.x?.domain([...xScale.domain()]);
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
      console.log("deselect mfpca");
      dispatch(sessionSlice.actions.setSelectedTrialId(null));
      dispatch(sessionSlice.actions.setSelectedTrialIds([]));
    });

    setScatterPlot(plot);

    return () => {
      plot.destroy();
    };
  }, []);

  useEffect(() => {
    if (scatterplot == null) {
      return;
    }
    const selectedIndices = [...globalStorage.trialOrder.entries()]
      .filter(([index, trialId]) => {
        return selectedTrialIds.includes(trialId);
      })
      .map(([index, _trialId]) => index);
    const spatialIndex = scatterplot.get("spatialIndex");
    scatterplot.draw(points, { spatialIndex, select: selectedIndices });
  }, [selectedTrialIds]);

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
        console.log("DRAW POINTS MFPCA");
        const newPoints = points;
        const filteredIndices = [];
        const selectedIndices = [];
        for (let i = 0; i < newPoints.length; i++) {
          const trialId = globalStorage.trialOrder[i];
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
          // if (selectedPairTrialId != null) {
          // }

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
        scatterplot.draw(newPoints, {
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
    console.log("CREATE AND DRAW POINT MFPCA");
    const mfpcaScores = Object.entries(
      trajectoryAnalysis?.clustering.scores ?? {},
    );

    const trialOrder: string[] = [];
    const points = mfpcaScores.map(([trialId, scores]) => {
      if (clusteringResult == null || clusterInfo == null || scales == null) {
        return [];
      }
      trialOrder.push(trialId);
      const label = clusteringResult.data[trialId].label;
      let labelNumber = Number(label);
      if (clusteringResult.task.method == "hierarchy") {
        labelNumber -= 1;
      }
      return [
        ((scores[index0] - bound.x[0]) / (bound.x[1] - bound.x[0])) * 2 - 1.0,
        ((scores[index1] - bound.y[0]) / (bound.y[1] - bound.y[0])) * 2 - 1.0,
        0,
        0,
      ];
    });
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
    setMfpcaScores(mfpcaScores);

    return () => {
      // scatterplot.clearPoints();
    };
  }, [scatterplot, bound]);

  // update points
  useEffect(() => {
    if (
      points.length !== mfpcaScores.length ||
      scatterplot == null ||
      clusteringResult == null ||
      clusterInfo == null
    ) {
      return;
    }
    console.log("UPDATE POINTS MFPCA");
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
  }, [clusterInfo, colorMode, filteredTrialIds, selectedTrialIds]);

  const margin = {
    top: 40,
    right: 20,
    left: 60,
    bottom: 60,
  };

  return (
    <Box
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
          {`${axes[0]} (${(
            (trajectoryAnalysis?.clustering.explainedVarianceRatio[
              Number(axes[0].split("FPC")[1])
            ] ?? 0) * 100
          ).toFixed(1)}%)`}
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
          {`${axes[1]} (${(
            (trajectoryAnalysis?.clustering.explainedVarianceRatio[
              Number(axes[1].split("FPC")[1])
            ] ?? 0) * 100
          ).toFixed(1)}%)`}
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
          // width: "100%",
          // height: "100%",
          position: "relative",
          top: 0,
        }}
      >
        <canvas ref={canvasRef} />
      </Box>

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
          >
            <LineAxisIcon />
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

      <Drawer
        hideBackdrop
        anchor="bottom"
        open={anchorEl?.id === "select-axis-button"}
        onClose={() => {
          setAnchorEl(null);
        }}
        sx={{ height: 0 }}
      >
        <Stack sx={{ p: 2 }}>
          <Stack direction="row" justifyContent="flex-end" alignItems="center">
            <IconButton onClick={() => setAnchorEl(null)}>
              <Close />
            </IconButton>
          </Stack>
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
          <FunctionalCurves />
        </Stack>
      </Drawer>
    </Box>
  );
}
