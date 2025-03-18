import * as d3 from "d3";
import chroma from "chroma-js";
import { AxisVertical } from "./AxisVertical";
import { scaleLinear, scalePoint } from "@visx/scale";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useTheme } from "@mui/material/styles";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { localPoint } from "@visx/event";
import { kdTree } from "kd-tree-javascript";
import session, { sessionSlice } from "src/redux/slices/session";
import { ClusterResult } from "src/api/services/Clustering";
import { Stack, SxProps } from "@mui/material";
import { ColorMode } from "../../EmbeddingSpace/Scatter";
import { getCriticalityMetricColor } from "src/utils";
import { Legend } from "../../EmbeddingSpace/Scatter/Legend";

const MARGIN = { top: 40, bottom: 30, left: 50, right: 50 };
const lineGenerator = d3.line();
const ASPECT_RATIO = 2;

type Point = {
  x: number;
  y: number;
  trialId: string;
  group: string;
};

function distance(a: Point, b: Point) {
  return Math.sqrt(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2));
}

type ParallelCoordinateProps = {
  batchId: string;
  data: {
    bounds: { [key: string]: { min: number; max: number } };
    data: {
      [trialId: string]: {
        trialId: string;
        group: string;
        color: string;
        originalColor: string;
        parameters: { [parameterName: string]: number };
      };
    };
  };
  variables: string[];
  clusterCounts: {
    passed: { [clusterLabel: string]: Set<string> };
    failed: { [clusterLabel: string]: Set<string> };
  };
  clusterResult: ClusterResult | null;
  sx?: SxProps;
  colorMode: ColorMode;
};

export const ParallelCoordinate = ({
  batchId,
  sx,
  data,
  variables,
  clusterCounts,
  clusterResult,
  colorMode,
}: ParallelCoordinateProps) => {
  const dispatch = useAppDispatch();

  const theme = useTheme();

  const containerRef = useRef<HTMLDivElement>(null);
  const svgRef = useRef<SVGSVGElement>(null);

  const hoveredTrialId = useAppSelector(
    (state) => state.session.hoveredTrialId,
  );
  const boundaryPair = useAppSelector((state) => state.session.boundaryPair);
  const focusedTrialId = useAppSelector(
    (state) => state.session.focusedTrialId,
  );
  const focusedBoundaryPair = useAppSelector(
    (state) => state.session.focusedBoundaryPair,
  );
  const trialClusterMappings = useAppSelector(
    (state) => state.session.trialClusterMappings,
  );
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedCluster,
  );
  const selectedBoundarySafeCluster = useAppSelector(
    (state) => state.session.selectedBoundarySafeCluster,
  );
  const trials = useAppSelector((state) => state.session.trialMappings);
  const selectedKpi = useAppSelector((state) => state.session.selectedKpi);

  const [nearest, setNearest] = useState<Point | undefined>();
  const [dimension, setDimension] = useState<{ width: number; height: number }>(
    { width: 0, height: 0 },
  );

  const boundsWidth = useMemo(
    () => dimension.width - MARGIN.right - MARGIN.left,
    [dimension],
  );
  const boundsHeight = useMemo(
    () => dimension.height - MARGIN.top - MARGIN.bottom,
    [dimension],
  );

  const xScale = useMemo(() => {
    return scalePoint<string>({
      domain: variables,
      range: [0, boundsWidth],
    });
  }, [variables, dimension, boundsWidth]);

  const yScales = useMemo(() => {
    const result: { [name: string]: ReturnType<typeof scaleLinear<number>> } =
      {};
    for (const variable of variables) {
      if (!(variable in data.bounds)) {
        continue;
      }
      const { min, max } = data.bounds[variable];
      result[variable] = scaleLinear<number>({
        domain: [min, max],
        range: [boundsHeight, 0],
      });
    }
    return result;
  }, [variables, data, boundsHeight, dimension]);

  const resizeObserver = useMemo(
    () =>
      new ResizeObserver((entries) => {
        for (let entry of entries) {
          entry.target.dispatchEvent(new Event("resize"));
          const { width, height } = entry.contentRect;
          setDimension({ width, height: width / ASPECT_RATIO });
        }
      }),
    [],
  );

  useEffect(() => {
    if (!containerRef.current) {
      return;
    }
    resizeObserver.observe(containerRef.current);
    const { width, height } = containerRef.current.getBoundingClientRect();
    setDimension({ width, height: width / ASPECT_RATIO });
    return () => {
      if (!containerRef.current) {
        return;
      }
      resizeObserver.unobserve(containerRef.current);
    };
  }, [containerRef.current]);

  const points = useMemo(() => {
    const result: Point[] = [];
    for (const variable of variables) {
      const x = xScale(variable) ?? 0;
      for (const item of Object.values(data.data)) {
        if (selectedCluster !== null && item["group"] !== selectedCluster) {
          continue;
        }
        const yScale = yScales[variable];
        const y = yScale(item.parameters[variable] as number);
        result.push({
          x,
          y,
          trialId: `${item["trialId"]}`,
          group: item["group"] as string,
        });
      }
    }
    return result;
  }, [data, xScale, yScales, variables, selectedCluster]);

  const tree = useMemo(() => {
    if (!points) {
      return;
    }
    return new kdTree(points, distance, ["x", "y"]);
  }, [points]);

  const handleMouseMove = useCallback(
    (event: React.MouseEvent | React.TouchEvent) => {
      if (!svgRef.current || !tree) {
        return;
      }
      const point = localPoint(svgRef.current, event);
      if (!point) {
        return;
      }
      const neighborRadius = 30;
      const query = {
        x: point.x - MARGIN.left,
        y: point.y - MARGIN.top,
        index: -1,
        color: "",
        trialId: "",
        group: "",
      };
      const nearests = tree.nearest(query, 1, neighborRadius);
      if (nearests.length > 0) {
        setNearest(nearests[0][0]);
        dispatch(
          sessionSlice.actions.setHoveredTrialId(nearests[0][0].trialId),
        );
      } else {
        setNearest(undefined);
        dispatch(sessionSlice.actions.setHoveredTrialId(null));
      }
    },
    [tree],
  );

  const allLines = useMemo(
    () =>
      Object.values(data.data)
        .sort(
          (a, b) =>
            Number(
              a["trialId"] === hoveredTrialId ||
                a["trialId"] === nearest?.trialId,
            ) -
              Number(
                b["trialId"] === hoveredTrialId ||
                  b["trialId"] === nearest?.trialId,
              ) ||
            Number(a["trialId"] === boundaryPair) -
              Number(b["trialId"] === boundaryPair) ||
            Number(a["group"] === trialClusterMappings[hoveredTrialId ?? ""]) -
              Number(
                b["group"] === trialClusterMappings[hoveredTrialId ?? ""],
              ) ||
            Number(a["group"] === nearest?.group) -
              Number(b["group"] === nearest?.group),
        )
        .map((item, i) => {
          const allCoordinates = variables.map((variable) => {
            const yScale = yScales[variable];
            const x = xScale(variable) ?? 0;
            const y = yScale ? yScale(item.parameters[variable]) : 0;
            const coordinate: [number, number] = [x, y];
            return coordinate;
          });

          const d = lineGenerator(allCoordinates);

          if (!d) {
            return;
          }

          let color = item["color"];
          let originalColor = item["originalColor"];

          // const alpha = 0.1;
          // let color = chroma(item["color"] as string)
          //   .alpha(alpha)
          //   .hex();

          // if (
          //   hoveredTrialId &&
          //   // nearest &&
          //   data.data[i]["group"] !== trialClusterMappings[hoveredTrialId ?? ""]
          // ) {
          //   color = chroma(color).alpha(0.01).hex();
          // }
          //
          // if (
          //   // (hoveredTrialId &&
          //   //   nearest &&
          //   //   data.data[i]["group"] !==
          //   //   trialClusterMappings[hoveredTrialId ?? ""]) ||
          //   selectedCluster !== "" &&
          //   data.data[i]["group"] !== selectedCluster
          // ) {
          //   color = chroma(color).alpha(0.0).hex();
          // }
          //
          // if (
          //   // (!hoveredTrialId &&
          //   //   nearest &&
          //   //   data.data[i]["trialId"] === nearest.trialId) ||
          //   data.data[i]["trialId"] === hoveredTrialId
          // ) {
          //   color = theme.palette.text.primary;
          // }

          // if (colorMode === "criticalityMetric" && trials && selectedKpi) {
          //   color = chroma(
          //     getCriticalityMetricColor(
          //       trials[item.trialId],
          //       selectedKpi,
          //       theme,
          //     ),
          //   )
          //     .alpha(alpha)
          //     .hex();
          // }
          // if (selectedCluster && item["group"] !== selectedCluster) {
          //   color = chroma(theme.palette.divider).alpha(0.0).hex();
          // }

          if (
            item.trialId === hoveredTrialId ||
            (!hoveredTrialId && item.trialId === focusedTrialId)
          ) {
            color = chroma(originalColor).alpha(1.0).hex();
          } else if (
            item.trialId === boundaryPair ||
            (!boundaryPair && item["trialId"] === focusedBoundaryPair)
          ) {
            color = chroma(originalColor).alpha(1.0).hex();
          } else if (focusedTrialId && item.trialId !== focusedTrialId) {
            color = chroma(originalColor).alpha(0.01).hex();
          } else if (
            focusedBoundaryPair &&
            item.trialId !== focusedBoundaryPair
          ) {
            color = chroma(originalColor).alpha(0.01).hex();
          }
          // item["trialId"] === hoveredTrialId ||
          // item["trialId"] === boundaryPair ||
          // (!hoveredTrialId && item["trialId"] === focusedTrialId) ||
          // (!boundaryPair && item["trialId"] === focusedBoundaryPair)

          return (
            <path
              key={i}
              d={d}
              stroke={color}
              strokeWidth={
                item["trialId"] === hoveredTrialId ||
                item["trialId"] === boundaryPair ||
                (!hoveredTrialId && item["trialId"] === focusedTrialId) ||
                (!boundaryPair && item["trialId"] === focusedBoundaryPair)
                  ? 3
                  : 1
              }
              fill="none"
            />
          );
        }),
    [
      nearest,
      hoveredTrialId,
      data,
      xScale,
      yScales,
      selectedCluster,
      trials,
      selectedKpi,
      boundaryPair,
      selectedBoundarySafeCluster,
    ],
  );

  useEffect(() => {
    setNearest(undefined);
    dispatch(sessionSlice.actions.setHoveredTrialId(null));
  }, [selectedCluster]);

  const allAxes = useMemo(
    () =>
      variables.map((variable, i) => {
        const yScale = yScales[variable];
        return yScale ? (
          <g key={i} transform={"translate(" + xScale(variable) + ",0)"}>
            <AxisVertical yScale={yScale} pixelsPerTick={40} name={variable} />
          </g>
        ) : null;
      }),
    [yScales, variables],
  );

  return (
    <Stack sx={{ p: 1, width: "100%", ...sx }}>
      <Legend clusterCounts={clusterCounts} />
      <Stack
        ref={containerRef}
        sx={{ width: "100%", aspectRatio: ASPECT_RATIO }}
      >
        <svg
          width={dimension.width}
          height={dimension.height}
          ref={svgRef}
          onMouseEnter={() => {
            dispatch(
              sessionSlice.actions.setHighlightedTrialIds(
                new Set<string>(
                  Object.values(data.data).map(
                    (item) => item["trialId"] as string,
                  ),
                ),
              ),
            );
          }}
          onMouseLeave={() => {
            dispatch(
              sessionSlice.actions.setHighlightedTrialIds(new Set<string>()),
            );
            setNearest(undefined);
          }}
          onClick={() => {
            dispatch(
              sessionSlice.actions.setFocusedTrialId(nearest?.trialId ?? null),
            );
          }}
        >
          <g
            width={boundsWidth}
            height={boundsHeight}
            onMouseMove={handleMouseMove}
            onTouchMove={handleMouseMove}
            transform={`translate(${[MARGIN.left, MARGIN.top].join(",")})`}
          >
            {allLines}
            {allAxes}
          </g>
        </svg>
      </Stack>
    </Stack>
  );
};
