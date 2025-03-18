import * as d3 from "d3";
import chroma from "chroma-js";
import { AxisVertical } from "./AxisVertical";
import { scaleLinear, scalePoint } from "@visx/scale";
import {
  Dispatch,
  SetStateAction,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import { Stack } from "@mui/material";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { localPoint } from "@visx/event";
import { kdTree } from "kd-tree-javascript";
import {
  // getSelectedClusteringResult,
  sessionSlice,
} from "src/redux/slices/session";
import { useTheme } from "@mui/material/styles";
import { ColorMode } from "../../../EmbeddingSpace/Scatter";

const MARGIN = { top: 40, right: 30, bottom: 30, left: 30 };
const lineGenerator = d3.line();
const ASPECT_RATIO = 2;

type Point = {
  x: number;
  y: number;
  trialId: string;
};

function distance(a: Point, b: Point) {
  return Math.sqrt(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2));
}

type ParallelCoordinateProps = {
  batchId: string;
  setIsNearestInPlots: Dispatch<SetStateAction<Set<string>>>;
  data: {
    bounds: { [key: string]: { min: number; max: number } };
    data: { [key: string]: string | number }[];
  };
  variables: string[];
  colorMode: ColorMode;
};

export const ParallelCoordinate = ({
  setIsNearestInPlots,
  batchId,
  data,
  variables,
  colorMode,
}: ParallelCoordinateProps) => {
  const dispatch = useAppDispatch();

  const theme = useTheme();
  const containerRef = useRef<HTMLDivElement>(null);
  const svgRef = useRef<SVGSVGElement>(null);

  const hoveredTrialId = useAppSelector(
    (state) => state.session.hoveredTrialId,
  );
  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const clusteringResult = useAppSelector(getSelectedClusteringResult);
  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );

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
      for (const item of data.data) {
        const yScale = yScales[variable]; // FIXME: scales should be the same
        const y = yScale(item[variable] as number);
        result.push({
          x,
          y,
          trialId: `${item["trialId"]}`,
        });
      }
    }
    return result;
  }, [data, xScale, yScales, variables]);

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
      const neighborRadius = 100;
      const query = {
        x: point.x - MARGIN.left,
        y: point.y - MARGIN.top,
        index: -1,
        color: "",
        trialId: "",
      };
      const nearests = tree.nearest(query, 1, neighborRadius);
      if (nearests.length > 0) {
        // setIsNearestInPlots((prev) => new Set([batchId]));
        setIsNearestInPlots(new Set([batchId]));
        setNearest(nearests[0][0]);
        dispatch(
          sessionSlice.actions.setHoveredTrialId(nearests[0][0].trialId),
        );
        dispatch(
          sessionSlice.actions.setSelectedCluster(
            clusteringResult?.data[nearests[0][0].trialId].label ?? null,
          ),
        );
      } else {
        // setIsNearestInPlots(new Set());
        setIsNearestInPlots((prev) => {
          const result = new Set(prev);
          result.delete(batchId);
          return result;
        });
        setNearest(undefined);
      }
    },
    [tree, clusteringResult],
  );

  const allLines = useMemo(
    () =>
      data.data
        .sort(
          (a, b) =>
            Number(a["trialId"] === hoveredTrialId) -
            Number(b["trialId"] === hoveredTrialId),
        )
        .map((series, i) => {
          const allCoordinates = variables.map((variable) => {
            const yScale = yScales[variable];
            const x = xScale(variable) ?? 0;
            const y = yScale ? yScale(series[variable]) : 0;
            const coordinate: [number, number] = [x, y];
            return coordinate;
          });

          const d = lineGenerator(allCoordinates);

          if (!d) {
            return;
          }

          return (
            <path
              key={i}
              d={d}
              // stroke={`${data.data[i]["color"]}`}
              stroke={`${
                (hoveredTrialId &&
                  data.data[i]["trialId"] === hoveredTrialId) ||
                (hoveredTrialId &&
                  hoveredTrialId in
                    (clusteringResponse?.boundaryPairs.passed ?? {}) &&
                  data.data[i]["trialId"] ===
                    clusteringResponse?.boundaryPairs.passed[hoveredTrialId]) ||
                (!hoveredTrialId &&
                  selectedTrialId &&
                  data.data[i]["trialId"] === selectedTrialId) ||
                (!hoveredTrialId &&
                  selectedTrialId &&
                  selectedTrialId in
                    (clusteringResponse?.boundaryPairs.passed ?? {}) &&
                  data.data[i]["trialId"] ===
                    clusteringResponse?.boundaryPairs.passed[selectedTrialId])
                  ? colorMode === "clustering"
                    ? theme.palette.text.primary
                    : chroma(data.data[i]["color"]).alpha(1.0).hex()
                  : data.data[i]["color"]
              }`}
              strokeWidth={
                (hoveredTrialId &&
                  data.data[i]["trialId"] === hoveredTrialId) ||
                (hoveredTrialId &&
                  hoveredTrialId in
                    (clusteringResponse?.boundaryPairs.passed ?? {}) &&
                  data.data[i]["trialId"] ===
                    clusteringResponse?.boundaryPairs.passed[hoveredTrialId]) ||
                (!hoveredTrialId &&
                  selectedTrialId &&
                  data.data[i]["trialId"] === selectedTrialId) ||
                (!hoveredTrialId &&
                  selectedTrialId &&
                  selectedTrialId in
                    (clusteringResponse?.boundaryPairs.passed ?? {}) &&
                  data.data[i]["trialId"] ===
                    clusteringResponse?.boundaryPairs.passed[selectedTrialId])
                  ? 3
                  : 1
              }
              fill="none"
            />
          );
        }),
    [hoveredTrialId, data, xScale, yScales, colorMode],
  );

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
    <Stack ref={containerRef} sx={{ width: "100%", aspectRatio: ASPECT_RATIO }}>
      <svg width={dimension.width} height={dimension.height} ref={svgRef}>
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
  );
};
