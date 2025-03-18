import chroma from "chroma-js";
import CloseIcon from "@mui/icons-material/Close";
import { useTheme } from "@mui/material/styles";
import {
  Stack,
  Typography,
  Menu,
  Button,
  Card,
  Drawer,
  MenuItem,
  Select,
  ToggleButtonGroup,
  ToggleButton,
  IconButton,
} from "@mui/material";
import { useEffect, useMemo, useRef, useState } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { Drawable } from "./drawables";
import REGL from "regl";
import { ScatterDrawable } from "./drawables/scatter";
import { NumberValue, ScaleLinear, scaleLinear } from "d3-scale";
import { Axis, axisBottom, axisRight } from "d3-axis";
import { select, Selection } from "d3-selection";
import KeyboardArrowUpIcon from "@mui/icons-material/KeyboardArrowUp";
import { Camera2D } from "./drawables/Camera";
import { GradientClusterSelector } from "src/components/GradientClusterSelector";

export const plotModes = ["UMAP", "PCA"] as const;
export type PlotMode = (typeof plotModes)[number];

const globalStorage: {
  regl: REGL.Regl | null;
  camera: Camera2D | null;
  plot: {
    xAxis: Axis<NumberValue>;
    xScale: ScaleLinear<number, number, never>;
    xAxisGroup: Selection<SVGGElement, unknown, HTMLElement, any>;
    yAxis: Axis<NumberValue>;
    yScale: ScaleLinear<number, number, never>;
    yAxisGroup: Selection<SVGGElement, unknown, HTMLElement, any>;
  } | null;
} = {
  regl: null,
  camera: null,
  plot: null,
};

export default function GradientScatter2D() {
  const theme = useTheme();
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);
  const dispatch = useAppDispatch();
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedGradientClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedGradientClusteringResult,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );

  const [plotMode, setPlotMode] = useState<PlotMode>("PCA");
  const [axes, setAxes] = useState<string[]>(["PC0", "PC1"]);

  useEffect(() => {
    if (plotMode === "PCA") {
      setAxes(["PC0", "PC1"]);
    } else {
      setAxes(["UMAP0", "UMAP1"]);
    }
  }, [plotMode]);

  const [scatterDrawable, setScatterDrawable] =
    useState<ScatterDrawable | null>(null);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const fpcNames = useMemo(() => {
    if (trajectoryAnalysis == null) {
      return [];
    }
    const scores = Object.values(
      trajectoryAnalysis.clustering.gradients.clustering.projections,
    );
    if (scores.length === 0) {
      return [];
    }
    return scores[0].map((v, i) => `PC${i}`);
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
        Drawable.resize(width, height);
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

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      console.log("not init app");
      return;
    }
    const canvas = canvasRef.current;
    if (canvas == null) {
      return;
    }
    const gl = canvas.getContext("webgl");
    if (gl == null) {
      return;
    }
    if (globalStorage.regl) {
      globalStorage.regl.destroy();
    }
    if (globalStorage.camera == null) {
      globalStorage.camera = new Camera2D(0, 0, canvas.width, canvas.height);
    }

    const regl = REGL({ gl, extensions: ["ANGLE_instanced_arrays"] });
    globalStorage.regl = regl;
    const camera = globalStorage.camera;
    Drawable.init(
      regl,
      canvas,
      globalStorage.camera,
      trajectoryAnalysis,
      (camera) => {
        if (globalStorage.plot == null) {
          return;
        }
        const plot = globalStorage.plot;
        // Update the scale domain
        plot.xScale
          ?.domain([
            camera.screenToWorld(0, 0).x,
            camera.screenToWorld(camera.width, 0).x,
          ])
          .range([0, camera.width]);
        // Re-render the axis with the updated scale
        plot.xAxisGroup?.call(plot.xAxis);

        // Update the scale domain
        plot.yScale
          ?.domain([
            camera.screenToWorld(0, 0).y,
            camera.screenToWorld(0, camera.height).y,
          ])
          .range([0, camera.height]);
        // Re-render the axis with the updated scale
        plot.yAxisGroup?.call(plot.yAxis);
      },
    );
    const scatter = new ScatterDrawable();

    setScatterDrawable(scatter);
    // scatter.onChangeAxisOrFiltering(axes, filteredTrialIds);

    regl.frame(function({ time }) {
      regl.clear({
        color: chroma("white").rgba(),
      });
      scatter.update(time);
    });

    const axisContainer = select("#parent-wrapper")
      .append("svg")
      .attr("width", canvas.width)
      .attr("height", canvas.height);

    const node = axisContainer.node();
    if (node != null) {
      node.style.position = "absolute";
      node.style.top = "0";
      node.style.left = "0";
      node.style.width = "100%";
      node.style.height = "100%";
      node.style.pointerEvents = "none";
    }

    // Define an initial scale
    let xScale = scaleLinear()
      .domain([
        camera.screenToWorld(0, 0).x,
        camera.screenToWorld(canvas.width, 0).x,
      ]) // Initial domain
      .range([0, canvas.width]); // Range based on SVG size

    // Define an axis generator
    let xAxis = axisBottom(xScale);

    // Append the axis to the SVG
    let xAxisGroup = axisContainer
      .append("g")
      .attr("class", "x-axis")
      // .attr("transform", `translate(0, ${Drawable.canvas.height - 40})`) // Position the axis
      .call(xAxis);

    let yScale = scaleLinear()
      .domain([
        camera.screenToWorld(0, 0).y,
        camera.screenToWorld(0, canvas.height).y,
      ]) // Initial domain
      .range([0, canvas.height]); // Range based on SVG size

    let yAxis = axisRight(yScale);

    // help
    // Append the axis to the SVG
    let yAxisGroup = axisContainer
      .append("g")
      .attr("class", "y-axis")
      // .attr("transform", `translate(${Drawable.canvas.width - 60})`) // Position the axis
      .call(yAxis);

    globalStorage.plot = {
      xScale,
      xAxis,
      xAxisGroup,
      yScale,
      yAxis,
      yAxisGroup,
    };
  }, [trajectoryAnalysis]);

  useEffect(() => {
    if (axes.length < 2 || scatterDrawable == null) {
      return;
    }
    scatterDrawable.onChangeAxis(axes, filteredTrialIds);
  }, [axes, scatterDrawable, filteredTrialIds]);

  useEffect(() => {
    if (
      clusteringResult == null ||
      clusterInfo == null ||
      scatterDrawable == null
    ) {
      return;
    }
    scatterDrawable.onChangeClustering(
      clusteringResult,
      clusterInfo,
      filteredTrialIds,
    );
  }, [clusteringResult, clusterInfo, filteredTrialIds]);

  return (
    <Stack
      id="parent-wrapper"
      ref={containerRef}
      sx={{
        width: "100%",
        height: "100%",
        position: "relative",
        overflow: "hidden",
      }}
    >
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
          <Stack
            direction="row"
            justifyContent="space-between"
            alignItems="center"
          >
            <Typography variant="h6">MPCA Score Space Axis</Typography>
            <IconButton onClick={() => setAnchorEl(null)}>
              <CloseIcon />
            </IconButton>
          </Stack>
          <Stack direction="row" flexWrap="wrap" rowGap={2} columnGap={2}>
            <ToggleButtonGroup
              size="small"
              color="primary"
              value={plotMode}
              defaultValue={plotMode}
              exclusive
              onChange={(_event, value) => {
                setPlotMode(value as PlotMode);
              }}
            >
              {plotModes.map((mode) => (
                <ToggleButton value={mode}>{mode}</ToggleButton>
              ))}
            </ToggleButtonGroup>
            {(axes ?? []).map((axis, index) => {
              return (
                <Stack
                  spacing={1}
                  direction="row"
                  alignItems="center"
                  key={index}
                  sx={{ display: plotMode === "UMAP" ? "none" : "flex" }}
                >
                  <Typography fontSize={14} color="text.disabled">{`${index === 0 ? "x" : "y"
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
          <Stack>
            <GradientClusterSelector />
          </Stack>
        </Stack>
      </Drawer>
      <Stack
        direction="row"
        columnGap={1}
        sx={{
          position: "absolute",
          zIndex: 100,
          p: 1,
          right: 0,
          bottom: 0,
          display: trajectoryAnalysis == null ? "none" : "initial",
        }}
      >
        <Button
          disableElevation
          variant="contained"
          id="select-axis-button"
          color="inherit"
          onClick={(event) => {
            if (event.currentTarget === anchorEl) {
              setAnchorEl(null);
            } else {
              setAnchorEl(event.currentTarget);
            }
          }}
          endIcon={<KeyboardArrowUpIcon />}
        >
          Controls
        </Button>
      </Stack>
      <Stack
        direction="row"
        columnGap={1}
        sx={{
          // width: "100%",
          position: "absolute",
          right: 0,
          marginTop: "20px",
          paddingRight: "5px",
          display: trajectoryAnalysis == null ? "none" : "initial",
        }}
      >
        <Typography
          sx={{
            fontSize: "12px",
            p: "3px 5px",
            backgroundColor: `${chroma(theme.palette.background.paper)
              .alpha(0.8)
              .hex()}`,
            borderRadius: "5px",
            borderStyle: "solid",
            borderWidth: "1px",
            borderColor: "divider",
          }}
        >{`${axes[0]} Score (${(
          (trajectoryAnalysis?.clustering.gradients.clustering
            .explainedVarianceRatio[Number(axes[0].split("PC")[1])] ?? 0) * 100
        ).toFixed(1)}%)`}</Typography>
      </Stack>
      <Stack
        direction="row"
        columnGap={1}
        sx={{
          // width: "100%",
          position: "absolute",
          bottom: 0,
          marginLeft: "35px",
          paddingBottom: "5px",
          display: trajectoryAnalysis == null ? "none" : "initial",
        }}
      >
        <Typography
          sx={{
            fontSize: "12px",
            writingMode: "vertical-rl",
            textOrientation: "mixed",
            p: "5px 3px",
            backgroundColor: `${chroma(theme.palette.background.paper)
              .alpha(0.8)
              .hex()}`,
            borderRadius: "5px",
            borderStyle: "solid",
            borderWidth: "1px",
            borderColor: "divider",
          }}
        >{`${axes[1]} Score (${(
          (trajectoryAnalysis?.clustering.gradients.clustering
            .explainedVarianceRatio[Number(axes[1].split("PC")[1])] ?? 0) * 100
        ).toFixed(1)}%)`}</Typography>
      </Stack>
      <canvas
        ref={canvasRef}
        id="mfpca-scatter-canvas"
      // style={{ border: "solid 5px lime" }}
      />
    </Stack>
  );
}
