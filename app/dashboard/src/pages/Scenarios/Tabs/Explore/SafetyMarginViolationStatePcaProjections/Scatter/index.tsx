import { useEffect, useMemo, useRef, useState } from "react";
import { Legend } from "./Legend";
import { axisBottom, axisRight } from "d3-axis";
import { scaleLinear } from "d3-scale";
import { select, Selection } from "d3-selection";
import {
  Box,
  Stack,
  IconButton,
  Menu,
  Typography,
  ToggleButtonGroup,
  ToggleButton,
  Select,
  MenuItem,
} from "@mui/material";
import SettingsIcon from "@mui/icons-material/Settings";
import { useTheme } from "@mui/material/styles";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import _ from "lodash";
import { sessionSlice } from "src/redux/slices/session";
import chroma from "chroma-js";
import { MinMaxScaler } from "src/utils";
import { useKpis } from "src/api/services/KeyPerformanceIndicators";
import createScatterplot from "regl-scatterplot";

export const plotModes = [
  "scatter2D",
  "scatter3D",
  "parallelCoordinate",
] as const;
export type PlotMode = (typeof plotModes)[number];
export type ColorMode = "criticalityMetric" | "cluster";

export type Point = {
  trialId: string;
  clusterLabel: string;
  color: string;
  scores: number[];
};

export default () => {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const menuAnchorRef = useRef<HTMLDivElement>(null);

  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedSafetyMarginViolationStateClusteringResult,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedSafetyMarginViolationStateClusterInfo,
  );

  const kpis = useKpis().data;
  const selectedKpi = useMemo(() => {
    if (!kpis || !clusteringResponse) {
      return null;
    }
    return (
      kpis.docs?.find((kpi) => kpi?.id === clusteringResponse.request.kpiId) ??
      null
    );
  }, [kpis, clusteringResponse]);

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [openMenu, setOpenMenu] = useState(false);
  const [hoveredPoint, setHoveredPoint] = useState<Point | null>(null);
  const [selectedPoint, setSelectedPoint] = useState<Point | null>(null);

  const [axes, setAxes] = useState<string[]>(["PC0", "PC1"]);
  const [axisContainer, setAxisContainer] = useState<Selection<
    SVGSVGElement,
    unknown,
    null,
    undefined
  > | null>(null);
  const [xAxisContainer, setXAxisContainer] = useState<Selection<
    SVGGElement,
    unknown,
    null,
    undefined
  > | null>(null);
  const [yAxisContainer, setYAxisContainer] = useState<Selection<
    SVGGElement,
    unknown,
    null,
    undefined
  > | null>(null);

  useEffect(() => {
    const parentWrapper = document.querySelector("#parent-wrapper");
    if (parentWrapper == null) {
      return;
    }
    const newAxisContainer = select(parentWrapper).append("svg");
    const node = newAxisContainer.node();
    if (node != null) {
      node.style.position = "absolute";
      node.style.top = "0";
      node.style.left = "0";
      node.style.width = "100%";
      node.style.height = "100%";
      node.style.pointerEvents = "none";
    }
    setAxisContainer(newAxisContainer ?? null);
    setXAxisContainer(newAxisContainer.append("g"));
    setYAxisContainer(newAxisContainer.append("g"));
  }, []);

  const xAxisPadding = 20;
  const yAxisPadding = 40;

  const points: Point[] | null = useMemo(() => {
    if (
      clusteringResponse == null ||
      clusterInfo == null ||
      clusteringResult == null
    ) {
      return null;
    }
    const scores =
      clusteringResponse.safetyMarginViolationStateClustering.projections;
    return Object.entries(scores ?? {}).map(([trialId, item]) => {
      const clusterLabel = clusteringResult.data[trialId].label ?? "-1";
      return {
        trialId,
        clusterLabel,
        color:
          clusterLabel in clusterInfo
            ? clusterInfo[clusterLabel].color
            : "black",
        scores: item,
      };
    });
  }, [clusteringResult, clusterInfo, clusteringResponse]);

  const plotAxes = useMemo(() => {
    let values = Object.values(
      clusteringResponse?.safetyMarginViolationStateClustering.projections ??
        {},
    );
    const xIndex = Number(axes[0].split("PC")[1]);
    const yIndex = Number(axes[1].split("PC")[1]);
    const xx = values.map((p) => p[xIndex]);
    const yy = values.map((p) => p[yIndex]);
    const xDomain = [Math.min(...xx), Math.max(...xx)];
    const yDomain = [Math.min(...yy), Math.max(...yy)];
    const xScale = scaleLinear().domain(xDomain);
    const yScale = scaleLinear().domain(yDomain);
    // const xAxis = axisBottom(xScale);
    // const yAxis = axisRight(yScale);

    return {
      // xAxis,
      // yAxis,
      xScale,
      yScale,
    };
  }, [axes, clusteringResponse]);

  const nonSelectedAxes: string[] = [];
  for (let i in points && points[0] ? points[0].scores : []) {
    if ((axes ?? []).includes(`PC${i}`)) {
      continue;
    }
    nonSelectedAxes.push(`PC${i}`);
  }

  const resizeObserver = useMemo(() => {
    return new ResizeObserver((entries) => {
      for (let entry of entries) {
        entry.target.dispatchEvent(new Event("resize"));
        const { width, height } = entry.contentRect;
        // plotAxes?.xAxis.tickSizeInner(-height);
        // plotAxes?.yAxis.tickSizeInner(-width);
        // if (xAxisContainer && plotAxes) {
        //   xAxisContainer
        //     .attr("transform", `translate(0, ${height - xAxisPadding})`)
        //     .call(plotAxes.xAxis);
        // }
        // if (yAxisContainer && plotAxes) {
        //   yAxisContainer
        //     .attr("transform", `translate(${width - yAxisPadding}, 0)`)
        //     .call(plotAxes.yAxis);
        // }
      }
    });
  }, [xAxisContainer, yAxisContainer, plotAxes]);

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
    setAnchorEl(menuAnchorRef.current);
  }, [menuAnchorRef.current]);

  const [scatterplot, setScatterplot] =
    useState<ReturnType<createScatterplot> | null>(null);

  useEffect(() => {
    if (canvasRef.current == null || scatterplot !== null || !plotAxes) {
      return;
    }
    const canvas = canvasRef.current;
    setScatterplot(
      createScatterplot({
        canvas,
        pointSize: 5,
        xScale: plotAxes.xScale,
        yScale: plotAxes.yScale,
        showReticle: true,
      }),
    );
  }, [canvasRef.current, plotAxes]);

  useEffect(() => {
    if (
      scatterplot == null ||
      points == null ||
      clusterInfo == null ||
      plotAxes == null ||
      xAxisContainer == null ||
      yAxisContainer == null
    ) {
      return;
    }

    const xIndex = Number(axes[0].split("PC")[1]);
    const yIndex = Number(axes[1].split("PC")[1]);

    const xMinMaxScaler = new MinMaxScaler();
    const xx = points.map((p) => p.scores[xIndex]);
    xMinMaxScaler.fit(xx);
    const scaledX = xMinMaxScaler.transform(xx);
    // const scaledX = xx.map((x) => plotAxes.xScale(x));

    const yMinMayScaler = new MinMaxScaler();
    const yy = points.map((p) => p.scores[yIndex]);
    yMinMayScaler.fit(yy);
    const scaledY = yMinMayScaler.transform(yy);
    // const scaledY = yy.map((y) => plotAxes.xScale(y));

    const maxClusterLabel = Math.max(
      ...Object.keys(clusterInfo).map((label) => Number(label)),
    );
    const pointColor = [];
    for (let i = 0; i <= maxClusterLabel; i++) {
      let color: string = "#000";
      if (`${i}` in clusterInfo) {
        color = chroma(clusterInfo[`${i}`].color).hex();
      }
      pointColor.push(color);
    }
    const pointColorHover = pointColor.map((c) => chroma(c).darken(1.1).hex());
    const pointColorActive = pointColor.map((c) => chroma(c).hex());
    const drawingPoints = points.map((p, i) => [
      scaledX[i],
      scaledY[i],
      Number(p.clusterLabel),
      0.1,
    ]);

    scatterplot.clear();
    scatterplot.draw(drawingPoints);
    scatterplot.set({
      pointColor,
      pointColorActive,
      pointColorHover,
      colorBy: "valueA",
      opacityBy: "valueB",
      reticleColor: chroma(theme.palette.divider).rgba(),
    });

    const dataPoints = points;
    scatterplot.subscribe("select", ({ points }: { points: number[] }) => {
      console.log(dataPoints);
      console.log(points[0]);
      setSelectedPoint(dataPoints[points[0]]);
      dispatch(
        sessionSlice.actions.setSelectedTrialId({
          id: dataPoints[points[0]].trialId,
          mode: "safetyMarginViolationState",
        }),
      );
    });
    scatterplot.subscribe("pointOver", (pointIndex: number) => {
      setHoveredPoint(dataPoints[pointIndex]);
    });
    scatterplot.subscribe("pointOut", () => {
      setHoveredPoint(null);
    });
    // scatterplot.subscribe(
    //   "init",
    //   () => {
    //     xAxisContainer.call(plotAxes.xAxis.scale(scatterplot.get("xScale")));
    //     yAxisContainer.call(plotAxes.yAxis.scale(scatterplot.get("yScale")));
    //   },
    //   1,
    // );
    // scatterplot.subscribe("view", (event) => {
    //   xAxisContainer.call(plotAxes.xAxis.scale(event.xScale));
    //   yAxisContainer.call(plotAxes.yAxis.scale(event.yScale));
    // });
  }, [
    scatterplot,
    points,
    clusterInfo,
    axes,
    xAxisContainer,
    yAxisContainer,
    plotAxes,
  ]);

  return (
    <Stack ref={containerRef} sx={{ width: "100%", height: "100%" }}>
      <Box
        component="div"
        sx={{
          position: "absolute",
          zIndex: 100,
        }}
      >
        <Stack
          direction="row"
          columnGap={2}
          alignItems="flex-start"
          justifyContent="flex-start"
        >
          <Legend />
          <IconButton
            component="div"
            ref={menuAnchorRef}
            onClick={() => setOpenMenu(true)}
          >
            <SettingsIcon sx={{ color: "text.disabled" }} />
          </IconButton>
          <Stack
            sx={{ pt: 1 }}
            direction="column"
            rowGap={0.5}
            justifyContent="center"
            alignItems="center"
          >
            {hoveredPoint
              ? axes.map((a, index) => {
                  const i = Number(a.split("PC")[1]);
                  const value = hoveredPoint?.scores[i];
                  return (
                    <Typography>{`${index === 0 ? "xaxis" : "yaxis"} ${a} (${(
                      (clusteringResponse?.safetyMarginViolationStateClustering
                        .explainedVarianceRatio[i] ?? 0) * 100
                    ).toFixed(2)}%): ${value?.toFixed(2)}`}</Typography>
                  );
                })
              : axes.map((a, index) => {
                  const i = Number(a.split("PC")[1]);
                  return (
                    <Typography>{`${index === 0 ? "xaxis" : "yaxis"} ${a} (${(
                      (clusteringResponse?.safetyMarginViolationStateClustering
                        .explainedVarianceRatio[i] ?? 0) * 100
                    ).toFixed(2)}%)`}</Typography>
                  );
                })}
          </Stack>
          <Stack
            sx={{ pt: 1 }}
            direction="column"
            // justifyContent="center"
            // alignItems="center"
          >
            {hoveredPoint && clusteringResponse != null
              ? Object.entries(
                  clusteringResponse.safetyMarginViolationStateClustering
                    .states[hoveredPoint.trialId].attributes,
                )
                  .filter(
                    (attr) =>
                      attr[0].includes("agent1RelativeVelocity") ||
                      attr[0].includes("agent1RelativeX") ||
                      attr[0] === "agent1RelativeY" ||
                      attr[0] === "agent1RelativeYaw" ||
                      attr[0] == "laneOffset" ||
                      attr[0] == "laneHeading" ||
                      attr[0] == "speed" ||
                      attr[0] == "yawRate",
                  )
                  .map((attr) => {
                    let value = attr[1];
                    const attrName = attr[0];
                    let unit = "m";
                    if (attrName === "yawRate") {
                      value *= 180 / 3.14;
                      unit = "deg/s";
                    } else if (attrName.includes("Velocity")) {
                      value *= 3.6;
                      unit = "kph";
                    } else if (attrName.includes("speed")) {
                      value *= 3.6;
                      unit = "kph";
                    }
                    return (
                      <Typography fontSize="12px">{`${
                        attr[0]
                      }(${unit}): ${value.toFixed(2)}`}</Typography>
                    );
                  })
              : null}
          </Stack>
        </Stack>
        <Menu
          anchorEl={anchorEl}
          open={openMenu}
          onClose={() => setOpenMenu(false)}
        >
          <Stack sx={{ p: 1, maxWidth: "500px" }}>
            {/* <ToggleButtonGroup */}
            {/*   sx={{ mr: 2 }} */}
            {/*   size="small" */}
            {/*   color="primary" */}
            {/*   value={plotMode} */}
            {/*   defaultValue={plotMode} */}
            {/*   exclusive */}
            {/*   onChange={(_event, value) => { */}
            {/*     setPlotMode(value as PlotMode); */}
            {/*   }} */}
            {/* > */}
            {/*   {plotModes.map((mode) => ( */}
            {/*     <ToggleButton value={mode}>{mode}</ToggleButton> */}
            {/*   ))} */}
            {/* </ToggleButtonGroup> */}
            <Stack direction="row" flexWrap="wrap" rowGap={2} columnGap={2}>
              {(axes ?? []).map((axis, index) => {
                return (
                  <Stack
                    spacing={1}
                    direction="row"
                    alignItems="center"
                    key={index}
                  >
                    <Typography
                      fontSize={14}
                      color="text.disabled"
                    >{`axis${index}`}</Typography>
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
                      {(points && points[0] ? points[0].scores : []).map(
                        (_, i) => (
                          <MenuItem
                            disabled={!nonSelectedAxes.includes(`PC${i}`)}
                            key={i}
                            value={`PC${i}`}
                          >
                            {`PC${i}`}
                          </MenuItem>
                        ),
                      )}
                    </Select>
                  </Stack>
                );
              })}
            </Stack>
          </Stack>
        </Menu>
      </Box>
      <Stack
        id="parent-wrapper"
        sx={{
          position: "relative",
          width: "100%",
          height: "100%",
          // right: `${yAxisPadding}px`,
          // bottom: `${xAxisPadding}px`,
        }}
      >
        <canvas ref={canvasRef} />
      </Stack>
    </Stack>
  );
};
