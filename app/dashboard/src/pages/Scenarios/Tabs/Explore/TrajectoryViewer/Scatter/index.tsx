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
import createScatterplot from "regl-scatterplot";

export const plotModes = ["PCA", "UMAP", "Original"] as const;
export type PlotMode = (typeof plotModes)[number];
export type ColorMode = "criticalityMetric" | "cluster";

export type Point = {
  trialId: string;
  time: number;
  color: string;
  data: number[];
};

export default () => {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const menuAnchorRef = useRef<HTMLDivElement>(null);

  const hoveredTrialId = useAppSelector(
    (state) => state.session.hoveredTrialId,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [openMenu, setOpenMenu] = useState(false);
  const [hoveredPoint, setHoveredPoint] = useState<Point | null>(null);
  const [selectedPoint, setSelectedPoint] = useState<Point | null>(null);

  const [plotMode, setPlotMode] = useState<PlotMode>("Original");
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
    setAxes(
      trajectoryAnalysis?.columns
        ? trajectoryAnalysis?.columns.slice(0, 2)
        : [],
    );
  }, [plotMode]);

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
    if (trajectoryAnalysis == null) {
      return null;
    }
    const result: Point[] = [];
    let columns = trajectoryAnalysis.columns;
    for (const [trialId, item] of Object.entries(
      trajectoryAnalysis.trajectories,
    )) {
      for (const row of item) {
        const pointData = [];
        for (const c of columns) {
          pointData.push(row[c]);
        }
        result.push({
          trialId: trialId,
          time: row["time"],
          data: pointData,
          color: theme.palette.primary.main,
        });
      }
    }
    return result;
  }, [trajectoryAnalysis, plotMode]);

  const plotAxes = useMemo(() => {
    if (trajectoryAnalysis == null) {
      return null;
    }
    const values: number[][] = [];
    let columns = trajectoryAnalysis.columns;
    for (const [_trialId, item] of Object.entries(
      trajectoryAnalysis.trajectories,
    )) {
      for (const row of item) {
        const pointData = [];
        for (const c of columns) {
          pointData.push(row[c]);
        }
        values.push(pointData);
      }
    }

    const xIndex = Number(
      plotMode === "PCA"
        ? axes[0].split("PC")[1]
        : plotMode === "Original"
          ? columns.findIndex((a) => a === axes[0])
          : 0,
    );
    const yIndex = Number(
      plotMode === "PCA"
        ? axes[1].split("PC")[1]
        : plotMode === "Original"
          ? columns.findIndex((a) => a === axes[1])
          : 1,
    );

    const xx = values.map((p) => p[xIndex]);
    const yy = values.map((p) => p[yIndex]);
    const xDomain = [Math.min(...xx), Math.max(...xx)];
    const yDomain = [Math.min(...yy), Math.max(...yy)];
    // const xScale = scaleLinear().domain(xDomain);
    // const yScale = scaleLinear().domain(yDomain);

    // Assuming you have access to width and height
    const width = containerRef.current ? containerRef.current.clientWidth : 800; // default width
    const height = containerRef.current
      ? containerRef.current.clientHeight
      : 600; // default height

    const xScale = scaleLinear()
      .domain(xDomain)
      .range([0, width - yAxisPadding]);
    const yScale = scaleLinear()
      .domain(yDomain)
      .range([height - xAxisPadding, 0]);

    const xAxis = axisBottom(xScale);
    const yAxis = axisRight(yScale);

    return {
      xAxis,
      yAxis,
      xScale,
      yScale,
    };
  }, [axes, trajectoryAnalysis, plotMode]);

  const nonSelectedAxes: string[] = [];
  if (plotMode === "PCA") {
    for (let i in points && points[0] ? points[0].data : []) {
      if ((axes ?? []).includes(`PC${i}`)) {
        continue;
      }
      nonSelectedAxes.push(`PC${i}`);
    }
  }
  if (plotMode === "Original") {
    for (const [i, attribute] of (
      trajectoryAnalysis?.columns ?? []
    ).entries()) {
      if ((axes ?? []).includes(attribute)) {
        continue;
      }
      nonSelectedAxes.push(attribute);
    }
  }

  const resizeObserver = useMemo(() => {
    return new ResizeObserver((entries) => {
      for (let entry of entries) {
        entry.target.dispatchEvent(new Event("resize"));
        const { width, height } = entry.contentRect;
        plotAxes?.xAxis.tickSizeInner(-height);
        plotAxes?.yAxis.tickSizeInner(-width);
        if (xAxisContainer && plotAxes) {
          xAxisContainer
            .attr("transform", `translate(0, ${height - xAxisPadding})`)
            .call(plotAxes.xAxis);
        }
        if (yAxisContainer && plotAxes) {
          yAxisContainer
            .attr("transform", `translate(${width - yAxisPadding}, 0)`)
            .call(plotAxes.yAxis);
        }
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
      plotAxes == null ||
      xAxisContainer == null ||
      yAxisContainer == null
    ) {
      return;
    }

    const xIndex = Number(
      plotMode === "PCA"
        ? axes[0].split("PC")[1]
        : plotMode === "Original"
          ? trajectoryAnalysis?.columns.findIndex((a) => a === axes[0])
          : 0,
    );
    const yIndex = Number(
      plotMode === "PCA"
        ? axes[1].split("PC")[1]
        : plotMode === "Original"
          ? trajectoryAnalysis?.columns.findIndex((a) => a === axes[1])
          : 1,
    );

    const xMinMaxScaler = new MinMaxScaler();
    const xx = points.map((p) => p.data[xIndex]);
    xMinMaxScaler.fit(xx);
    const scaledX = xMinMaxScaler.transform(xx);
    // const scaledX = xx.map((x) => plotAxes.xScale(x));

    const yMinMayScaler = new MinMaxScaler();
    const yy = points.map((p) => p.data[yIndex]);
    yMinMayScaler.fit(yy);
    const scaledY = yMinMayScaler.transform(yy);
    // const scaledY = yy.map((y) => plotAxes.xScale(y));

    const times = points.map((p) => p.time);
    const maxTime = Math.max(...times);
    const minTime = Math.min(...times);
    const valueA = times.map((t) => (t - minTime) / (maxTime - minTime));

    // // Step 1: Define the number of bins
    // const numBins = 100;
    // // Step 2: Map each value to its corresponding bin value
    // const binnedValues = valueA.map((value) => {
    //   // Calculate the bin index (0 to 99)
    //   const binIndex = Math.min(Math.floor(value * numBins), numBins - 1);
    //   // Map it to the bin center by calculating the midpoint of the bin range
    //   return (binIndex + 0.5) / numBins;
    // });

    const colorLength = 256;
    // const colorscale = chroma.scale(["#00FFFF", "#FF00FF"]).colors(colorLength);
    const colorscale = chroma.scale("viridis").colors(colorLength);
    const pointColor = Array.from({ length: 256 }, (_, i) => {
      return colorscale[i];
    });
    // [theme.palette.primary.main];
    const pointColorHover = pointColor.map((c) => chroma(c).darken(1.1).hex());
    const pointColorActive = pointColor.map((c) => chroma(c).hex());

    // console.log(points.map((p) => p.passed));
    const drawingPoints = points.map((p, i) => [
      scaledX[i],
      scaledY[i],
      valueA[i],
      0,
    ]);

    const { xScale, yScale } = plotAxes;
    // const drawingPoints = points.map((p) => [
    //   xScale(p.scores[xIndex]),
    //   yScale(p.scores[yIndex]),
    //   Number(p.clusterLabel),
    //   0,
    // ]);

    scatterplot.clear();
    scatterplot.draw(drawingPoints);
    scatterplot.set({
      pointColor,
      pointColorActive,
      pointColorHover,
      pointSize: [3.0, 10.0],
      opacity: [0.5, 1.0],
      sizeBy: "valueB",
      colorBy: "valueA",
      opacityBy: "valueB",
      reticleColor: chroma(theme.palette.divider).rgba(),
    });

    const dataPoints = points;

    // scatterplot.subscribe("select", ({ points }: { points: number[] }) => {
    //   if (points.length === 1) {
    //     dispatch(
    //       sessionSlice.actions.setSelectedTrialId({
    //         id: dataPoints[points[0]].trialId,
    //       }),
    //     );
    //   } else {
    //     dispatch(
    //       sessionSlice.actions.setSelectedTrialIds(
    //         points.map((point) => dataPoints[point].trialId),
    //       ),
    //     );
    //   }
    // });
    // scatterplot.subscribe("deselect", () => {
    //   dispatch(sessionSlice.actions.setSelectedTrialIds([]));
    //   dispatch(sessionSlice.actions.setSelectedTrialId({ id: null }));
    // });
    // scatterplot.subscribe("pointOver", (pointIndex: number) => {
    //   const dataPoint = dataPoints[pointIndex];
    //   const trialId = dataPoint.trialId;
    //   setHoveredPoint(dataPoint);
    //   dispatch(sessionSlice.actions.setHoveredTrialId(trialId));
    //   const boundaryPairs = dataPoint.passed
    //     ? clusteringResponse?.boundaryPairs.passed
    //     : clusteringResponse?.boundaryPairs.failed;
    //   if (mode === "critical" && boundaryPairs) {
    //     const pairedId = boundaryPairs[trialId];
    //     const pairedPointIndex = dataPoints.findIndex(
    //       (p) => p.trialId === pairedId,
    //     );
    //     const points = drawingPoints;
    //     for (const point of points) {
    //       point[3] = 0;
    //     }
    //     points[pairedPointIndex][3] = 1;
    //     const spatialIndex = scatterplot.get("spatialIndex");
    //     scatterplot.draw(points, { spatialIndex });
    //   }
    // });
    // scatterplot.subscribe("pointOut", (pointIndex: number) => {
    //   const dataPoint = dataPoints[pointIndex];
    //   const trialId = dataPoint.trialId;
    //   if (hoveredTrialId === trialId) {
    //     dispatch(sessionSlice.actions.setHoveredTrialId(null));
    //   }
    //   const points = drawingPoints;
    //   for (const point of points) {
    //     point[3] = 0;
    //   }
    //   const spatialIndex = scatterplot.get("spatialIndex");
    //   scatterplot.draw(points, { spatialIndex });
    //   // if (mode === "critical") {
    //   //   const points = drawingPoints;
    //   //   for (const point of points) {
    //   //     point[3] = 0;
    //   //   }
    //   //   const spatialIndex = scatterplot.get("spatialIndex");
    //   //   scatterplot.draw(points, { spatialIndex });
    //   // }
    //   // const points = drawingPoints;
    //   // const index = dataPoints.findIndex(
    //   //   (p) =>
    //   //     p.trialId === hoveredPoint?.trialId || p.trialId === hoveredTrialId,
    //   // );
    //   // if (index >= 0 && points != null) {
    //   //   points[index][3] = 0;
    //   //   const spatialIndex = scatterplot.get("spatialIndex");
    //   //   scatterplot.draw(points, { spatialIndex });
    //   // }
    //   setHoveredPoint(null);
    // });
    scatterplot.subscribe(
      "init",
      () => {
        xAxisContainer.call(plotAxes.xAxis.scale(scatterplot.get("xScale")));
        yAxisContainer.call(plotAxes.yAxis.scale(scatterplot.get("yScale")));
      },
      1,
    );
    scatterplot.subscribe("view", (event) => {
      xAxisContainer.call(plotAxes.xAxis.scale(event.xScale));
      yAxisContainer.call(plotAxes.yAxis.scale(event.yScale));
    });
  }, [scatterplot, points, axes, xAxisContainer, yAxisContainer, plotAxes]);

  useEffect(() => {
    if (hoveredTrialId && points && scatterplot) {
      const drawingPoints = [...scatterplot.get("points")];
      const index = points.findIndex((p) => p.trialId === hoveredTrialId);
      if (
        drawingPoints == null ||
        index === -1 ||
        drawingPoints.length === 0 ||
        drawingPoints.length !== points.length
      ) {
        return;
      }
      for (const point of drawingPoints) {
        point[3] = 0;
      }
      drawingPoints[index][3] = 1;
      const spatialIndex = scatterplot.get("spatialIndex");
      scatterplot.draw(drawingPoints, { spatialIndex });
    }
    if (
      hoveredPoint == null &&
      hoveredTrialId == null &&
      points &&
      scatterplot
    ) {
      const drawingPoints = [...scatterplot.get("points")];
      const index = points.findIndex((p) => p.trialId === hoveredTrialId);
      if (drawingPoints == null || index === -1) {
        return;
      }
      drawingPoints[index][3] = 0;
      const spatialIndex = scatterplot.get("spatialIndex");
      scatterplot.draw(drawingPoints, { spatialIndex });
    }
  }, [hoveredTrialId, points, scatterplot]);

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
          {/* <Legend mode={mode} /> */}
          <IconButton
            component="div"
            ref={menuAnchorRef}
            onClick={() => setOpenMenu(true)}
          >
            <SettingsIcon sx={{ color: "text.disabled" }} />
          </IconButton>
          {/* <Stack */}
          {/*   sx={{ pt: 1 }} */}
          {/*   direction="column" */}
          {/*   rowGap={0.5} */}
          {/*   justifyContent="center" */}
          {/*   alignItems="center" */}
          {/* > */}
          {/*   {hoveredPoint */}
          {/*     ? axes.map((a, index) => { */}
          {/*         const i = Number( */}
          {/*           plotMode === "PCA" */}
          {/*             ? a.split("PC")[1] */}
          {/*             : plotMode === "Original" */}
          {/*               ? trajectoryAnalysis?.columns.findIndex( */}
          {/*                   (attribute) => attribute === a, */}
          {/*                 ) */}
          {/*               : 0, */}
          {/*         ); */}
          {/*         const value = hoveredPoint?.data[i]; */}
          {/*         return ( */}
          {/*           <Typography>{`${index === 0 ? "xaxis" : "yaxis"} ${a}${ */}
          {/*             plotMode === "PCA" */}
          {/*               ? " (" + */}
          {/*                 ( */}
          {/*                   (clustering?.explainedVarianceRatio[i] ?? 0) * 100 */}
          {/*                 ).toFixed(2) + */}
          {/*                 "%)" */}
          {/*               : "" */}
          {/*           }: ${value?.toFixed(2)}${ */}
          {/*             a.includes("speed") */}
          {/*               ? "kph" */}
          {/*               : a.includes("yaw") */}
          {/*                 ? "deg" */}
          {/*                 : "m" */}
          {/*           }`}</Typography> */}
          {/*         ); */}
          {/*       }) */}
          {/*     : axes.map((a, index) => { */}
          {/*         const i = Number( */}
          {/*           plotMode === "PCA" */}
          {/*             ? a.split("PC")[1] */}
          {/*             : plotMode === "Original" */}
          {/*               ? clustering?.attributes.findIndex( */}
          {/*                   (attribute) => attribute === a, */}
          {/*                 ) */}
          {/*               : 0, */}
          {/*         ); */}
          {/*         return ( */}
          {/*           <Typography>{`${index === 0 ? "xaxis" : "yaxis"} ${a}${ */}
          {/*             plotMode === "PCA" */}
          {/*               ? " (" + */}
          {/*                 ( */}
          {/*                   (clustering?.explainedVarianceRatio[i] ?? 0) * 100 */}
          {/*                 ).toFixed(2) + */}
          {/*                 "%)" */}
          {/*               : "" */}
          {/*           }`}</Typography> */}
          {/*         ); */}
          {/*       })} */}
          {/* </Stack> */}
          {/* <Stack */}
          {/*   sx={{ pt: 1 }} */}
          {/*   direction="column" */}
          {/*   // justifyContent="center" */}
          {/*   // alignItems="center" */}
          {/* > */}
          {/*   {hoveredPoint && clustering != null */}
          {/*     ? Object.entries( */}
          {/*         clustering.states[hoveredPoint.trialId].attributes, */}
          {/*       ) */}
          {/*         .filter( */}
          {/*           (attr) => */}
          {/*             attr[0].includes("agent1RelativeVelocity") || */}
          {/*             attr[0].includes("agent1RelativeX") || */}
          {/*             attr[0] === "agent1RelativeY" || */}
          {/*             attr[0] === "agent1RelativeYaw" || */}
          {/*             attr[0] == "laneOffset" || */}
          {/*             attr[0] == "laneHeading" || */}
          {/*             attr[0] == "speed" || */}
          {/*             attr[0] == "yawRate", */}
          {/*         ) */}
          {/*         .map((attr) => { */}
          {/*           let value = attr[1]; */}
          {/*           const attrName = attr[0]; */}
          {/*           let unit = "m"; */}
          {/*           if (attrName === "yawRate") { */}
          {/*             value *= 180 / 3.14; */}
          {/*             unit = "deg/s"; */}
          {/*           } else if (attrName.includes("Velocity")) { */}
          {/*             value *= 3.6; */}
          {/*             unit = "kph"; */}
          {/*           } else if (attrName.includes("speed")) { */}
          {/*             value *= 3.6; */}
          {/*             unit = "kph"; */}
          {/*           } */}
          {/*           return ( */}
          {/*             <Typography fontSize="12px">{`${ */}
          {/*               attr[0] */}
          {/*             }(${unit}): ${value.toFixed(2)}`}</Typography> */}
          {/*           ); */}
          {/*         }) */}
          {/*     : null} */}
          {/* </Stack> */}
        </Stack>
        <Menu
          anchorEl={anchorEl}
          open={openMenu}
          onClose={() => setOpenMenu(false)}
        >
          <Stack sx={{ p: 1, maxWidth: "500px" }} rowGap={2}>
            <ToggleButtonGroup
              sx={{ mr: 2 }}
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
            <Stack direction="row" flexWrap="wrap" rowGap={2} columnGap={2}>
              {plotMode === "UMAP"
                ? null
                : (axes ?? []).map((axis, index) => {
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
                          {plotMode === "PCA"
                            ? (points && points[0] ? points[0].scores : []).map(
                                (_, i) => (
                                  <MenuItem
                                    disabled={
                                      !nonSelectedAxes.includes(`PC${i}`)
                                    }
                                    key={i}
                                    value={`PC${i}`}
                                  >
                                    {`PC${i}`}
                                  </MenuItem>
                                ),
                              )
                            : (trajectoryAnalysis?.columns ?? []).map(
                                (attribute) => {
                                  return (
                                    <MenuItem
                                      disabled={
                                        !nonSelectedAxes.includes(attribute)
                                      }
                                      key={attribute}
                                      value={attribute}
                                    >
                                      {attribute}
                                    </MenuItem>
                                  );
                                },
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
