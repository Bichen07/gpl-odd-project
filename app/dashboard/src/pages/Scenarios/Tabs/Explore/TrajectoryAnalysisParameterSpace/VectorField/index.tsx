import chroma from "chroma-js";
import { symbol, symbolsStroke, symbolCircle } from "d3-shape";
import { scaleOrdinal as d3ScalerOrdinal } from "d3-scale";
import { geoPath } from "d3-geo";
import { PCA } from "ml-pca";
import InterestsIcon from "@mui/icons-material/Interests";
import CameraswitchIcon from "@mui/icons-material/Cameraswitch";
import SwipeRightAltIcon from "@mui/icons-material/SwipeRightAlt";
import ColorLensIcon from "@mui/icons-material/ColorLens";
import ArticleIcon from "@mui/icons-material/Article";
import ClearIcon from "@mui/icons-material/Clear";
import ArrowRightAltIcon from "@mui/icons-material/ArrowRightAlt";
import { useTheme } from "@mui/material/styles";
import React from "react";
import {
  Box,
  IconButton,
  Menu,
  MenuItem,
  Stack,
  ToggleButton,
  ToggleButtonGroup,
  Typography,
} from "@mui/material";
import _ from "lodash";
import { Group } from "@visx/group";
import { Circle, Line } from "@visx/shape";
import { RectClipPath } from "@visx/clip-path";
import {
  Glyph,
  GlyphCircle,
  GlyphStar,
  GlyphTriangle,
  GlyphSquare,
  GlyphWye,
  GlyphDiamond,
  GlyphCross,
} from "@visx/glyph";
import { curveNatural } from "@visx/curve";
import { LinePath } from "@visx/shape";
import { useParentSize } from "@visx/responsive";
import {
  isValidElement,
  ReactNode,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { AxisLeft, AxisBottom } from "@visx/axis";
import { scaleLinear, scaleOrdinal, scaleThreshold } from "@visx/scale";
import { voronoi, VoronoiPolygon } from "@visx/voronoi";
import { localPoint } from "@visx/event";
import { withTooltip, Tooltip } from "@visx/tooltip";
import { WithTooltipProvidedProps } from "@visx/tooltip/lib/enhancers/withTooltip";
import { sessionSlice } from "src/redux/slices/session";
import { LegendThreshold, LegendItem, LegendLabel, Legend } from "@visx/legend";
import { Zoom } from "@visx/zoom";
import { Point as Point2D } from "@visx/point";
import { Legends } from "./Legend";
import { ArrowDropDownIcon } from "@mui/x-date-pickers";
import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
import { styled } from "@mui/material/styles";
import * as math from "mathjs";
import { contours } from "d3-contour";
import Contour from "./Contour";
import { Grain } from "@mui/icons-material";

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

function getDotProduct(vec1: number[], vec2: number[]) {
  return vec1.reduce((sum, val, i) => sum + val * vec2[i], 0);
}

function projectTo2D(
  data: number[][],
  gradientAxis: number[],
  pcaAxis: number[],
) {
  return data.map((point) => ({
    x: getDotProduct(point, gradientAxis),
    y: getDotProduct(point, pcaAxis),
  }));
}

function projectOntoPlane(v: number[], n: number[]) {
  // Ensure both vectors have the same dimension
  if (v.length !== n.length) {
    console.error(new Error("Vectors v and n must have the same dimension."));
    return v;
  }

  // Convert arrays to Math.js vectors
  const vVec = math.matrix(v);
  const nVec = math.matrix(n);

  // Compute dot products
  const dotProduct = math.dot(vVec, nVec); // v . n
  const normSquared = math.dot(nVec, nVec); // n . n

  if (normSquared === 0) {
    throw new Error("Normal vector must be nonzero.");
  }

  // Compute the projection
  const projection = math.multiply(nVec, dotProduct / normSquared); // (v . n) / (n . n) * n
  const projectedVector = math.subtract(vVec, projection); // v - projection

  // Return the result as an array
  return projectedVector.toArray();
}

export const glyphModes = ["pass/fail", "interaction-cluster"] as const;
export type GlyphMode = (typeof glyphModes)[number];

export const colorModes = [
  "criticality",
  "pass/fail",
  "interaction-cluster",
] as const;
export type ColorMode = (typeof colorModes)[number];

const globalStorage: {} = {};

const initialTransform = {
  scaleX: 1,
  scaleY: 1,
  translateX: 0,
  translateY: 0,
  skewX: 0,
  skewY: 0,
};

type Point = {
  trialId: string;
  x: number;
  y: number;
  projX: number;
  projY: number;

  mag: number;
  gradient: number[];
  projGradient: number[];

  parameters: number[];
  angle: number;
  color: string;

  metric: number;
  metricColor: string;

  fpcGradMag: number;

  passFailValue: number;
  passFailColor: string;

  clusterLabel: string;
};

export default function VectorField() {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const svgRef = useRef<SVGSVGElement>(null);
  const svgParentSize = useParentSize({ debounceTime: 150 });

  const axisSvgRef = useRef<SVGSVGElement>(null);
  const axisSvgParentSize = useParentSize({ debounceTime: 150 });

  const margin = {
    top: 40,
    right: 20,
    left: 60,
    bottom: 60,
  };

  const viewrMode = useAppSelector((state) => state.session.viewerMode);
  const shapeStrings = useAppSelector((state) => state.session.shapeStrings);
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
  const viewerMode = useAppSelector((state) => state.session.viewerMode);
  const safe2unsafeMappings = useAppSelector(
    (state) => state.session.safe2unsafeMappings,
  );
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );
  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const selectedPairTrialId = useAppSelector(
    (state) => state.session.selectedPairTrialId,
  );
  const safe2UnsafePairId = useMemo(() => {
    if (selectedTrialId && selectedTrialId in safe2unsafeMappings) {
      console.log(safe2unsafeMappings[selectedTrialId]);
      return safe2unsafeMappings[selectedTrialId];
    }
    return null;
  }, [selectedTrialId, safe2unsafeMappings]);

  const [glyphMode, setGlyphMode] = useState<GlyphMode>("interaction-cluster");
  const [colorMode, setColorMode] = useState<ColorMode>("interaction-cluster");
  const [showPoints, setShowPoints] = useState(true);
  const [gradientDirectionMode, setGradientDirectionMode] = useState(false);
  const [gradientDirectionPlotInfo, setGradientDirectionPlotInfo] = useState<{
    gradient: number[];
    pc1: number[];
  } | null>(null);

  const [voronoiLayout, setVoronoiLayout] = useState<any>(null);

  const [points, setPoints] = useState<{
    [trialId: string]: Point;
  } | null>(null);

  const [scales, setScales] = useState<{
    x: ReturnType<typeof scaleLinear<number>>;
    y: ReturnType<typeof scaleLinear<number>>;
    projX: ReturnType<typeof scaleLinear<number>>;
    projY: ReturnType<typeof scaleLinear<number>>;
  } | null>(null);
  const [axisScales, setAxisScales] = useState<{
    x: ReturnType<typeof scaleLinear<number>>;
    y: ReturnType<typeof scaleLinear<number>>;
  } | null>(null);
  const [showLegend, setShowLegend] = useState(true);
  const [showGradient, setShowGradient] = useState(false);

  const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
  const [menuOpened, setMenuOpened] = React.useState<string | null>(null);
  const handleMenuAnchorClick = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
    setMenuOpened(null);
  };

  const [tooltip, setTooltip] = useState<{
    left: number;
    top: number;
    data: Point;
  } | null>(null);
  const [magMax, setMagMax] = useState(0);
  const [magMin, setMagMin] = useState(0);
  const [gradientBounds, setGradientBounds] = useState<number[][]>([]);
  const [worldDim, setWorldDim] = useState({
    left: 0,
    right: 1,
    bottom: 0,
    top: 1,
    position: {
      x: 0,
      y: 0,
    },
  });

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      return;
    }
    const metricName = Object.keys(
      trajectoryAnalysis.clustering.metricGradients,
    )[0];
    dispatch(
      sessionSlice.actions.setSelectedMetric(
        Object.values(metrics ?? {}).find((m) => m.kpi.name === metricName) ??
          null,
      ),
    );
  }, [metrics]);

  const metricColorscale = useMemo(() => {
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      return chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
    }
    return chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
  }, [selectedMetric, trajectoryAnalysis]);

  const passFailColorscale = useMemo(() => {
    return chroma
      .scale([theme.palette.error.light, theme.palette.success.light])
      .domain([0, 1.0]);
  }, [selectedSafetyBoundaryMetric]);

  const clusterColorscale = useMemo(() => {
    return chroma
      .scale(
        clusterInfo
          ? Object.values(clusterInfo).map((v) => v.color)
          : ["black"],
      )
      .domain(
        clusterInfo ? Object.keys(clusterInfo).map((k) => Number(k)) : [0, 1],
      );
  }, [clusterInfo]);

  const parameters = trajectoryAnalysis?.clustering.parameters;

  useEffect(() => {
    if (
      trajectoryAnalysis == null ||
      svgParentSize.parentRef.current == null ||
      selectedMetric == null ||
      selectedSafetyBoundaryMetric == null
    ) {
      return;
    }

    const parameters = trajectoryAnalysis.clustering.parameters;
    if (parameters == null) {
      return;
    }
    const batches = Object.values(trajectoryAnalysis.batches ?? {});
    const trials = Object.values(trajectoryAnalysis.trials);

    const newPoints: {
      [trialId: string]: Point;
    } = {};

    // average gradient direction
    for (const [metricName, gradients] of Object.entries(
      trajectoryAnalysis.clustering.metricGradients,
    )) {
      if (metricName != selectedMetric?.kpi.name) {
        continue;
      }
      for (const trial of trials) {
        const trialId = trial.id ?? "";
        if (!(trialId in gradients.data)) {
          continue;
        }
        let metricGradientMagnitude = 0;
        let gradient: number[] = [];
        let parameterPoint: number[] = [];
        for (let [pi, value] of gradients.data[trialId].entries()) {
          metricGradientMagnitude += value[0] * value[0];
          gradient.push(value[0]);
          const trialParameter = trial.parameters.find(
            (p) => p.parameterId === parameters[pi].id,
          );
          parameterPoint.push(trialParameter?.value ?? 0);
        }
        metricGradientMagnitude = Math.sqrt(metricGradientMagnitude);
        let metricGradientAngle = Math.atan2(gradient[1], gradient[0]);

        let color = "black";

        const metricValue = trial.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.id === selectedMetric.kpi?.id,
        )?.value;
        const metricColor = metricColorscale(
          ((metricValue ?? 0) - (selectedMetric.min ?? 0)) /
            ((selectedMetric.max ?? 0) - (selectedMetric.min ?? 0)),
        ).hex();

        const passed = Number(
          trial.testObjectives?.criticalityMetrics.find(
            (m) =>
              m.keyPerformanceIndicator.id ===
              selectedSafetyBoundaryMetric.kpi?.id,
          )?.passed,
        );
        const passFailValue = trial.testObjectives?.criticalityMetrics.find(
          (m) =>
            m.keyPerformanceIndicator.id ===
            selectedSafetyBoundaryMetric.kpi?.id,
        )?.value;
        const passFailColor = passFailColorscale(passed).hex();

        let label = "-1";
        if (
          clusteringResult &&
          clusterInfo &&
          clusteringResult.data[trialId].label in clusterInfo
        ) {
          label = clusteringResult.data[trialId].label;
        }

        if (colorMode === "criticality") {
          color = metricColor;
        } else if (colorMode === "pass/fail") {
          color = passFailColor;
        } else {
          color = clusterColorscale(Number(label)).hex();
        }

        let fpcGradMag = 0;
        for (const row of trajectoryAnalysis.clustering.gradients.data[
          trialId
        ]) {
          // for (const value of row) {
          //   fpcGradMag += value * value;
          // }
        }
        fpcGradMag = Math.sqrt(fpcGradMag);

        const parameter = parameters[1];
        if (parameter.unit === "kph") {
          parameterPoint[1] = parameterPoint[1] / 3.6;
        }
        const trialArrow = {
          x: parameterPoint[0],
          y: parameterPoint[1],
          projX: 0,
          projY: 0,
          mag: metricGradientMagnitude,
          angle: metricGradientAngle,
          gradient,
          projGradient: Array.from({ length: gradient.length }).map((v) => 0),
          parameters: parameterPoint,
          metric: metricValue ?? 0,
          trialId: trialId,
          color,
          passFailColor: passFailColor,
          passFailValue: passFailValue ?? 0,
          metricColor: metricColor,
          clusterLabel: label,
          fpcGradMag,
        };
        newPoints[trialId] = trialArrow;
      }
    }

    const mags = Object.values(newPoints).map((d) => d.mag);
    setMagMax(Math.max(...mags));
    setMagMin(Math.min(...mags));

    let avgGradDirection = Array.from({
      length: Object.values(newPoints)[0].gradient.length,
    }).map((_i) => 0);
    Object.values(newPoints).forEach((p) => {
      if (!filteredTrialIds.includes(p.trialId)) {
        return;
      }
      for (let i = 0; i < avgGradDirection.length; i++) {
        avgGradDirection[i] += p.gradient[i] / Object.keys(newPoints).length;
      }
    });
    // avgGradDirection = [-0.2005, 1.3032, 16.9182];
    let normFactor = Math.sqrt(
      avgGradDirection.reduce((sum, val) => sum + val * val, 0),
    );
    avgGradDirection = avgGradDirection.map((val) => val / normFactor);

    const dataset = Object.values(newPoints)
      // .filter((p) => filteredTrialIds.includes(p.trialId))
      .map((p) => p.parameters);
    const pca = new PCA(dataset);
    const nRows = pca.getEigenvectors().rows;
    // const pc1 = pca.getEigenvectors().getRow(nRows - 1);
    const pc1 = pca.getEigenvectors().getRow(0);

    const pcaAxis = projectOntoPlane(pc1, avgGradDirection);

    // let dotProduct = pc1.reduce(
    //   (sum, val, i) => sum + val * avgGradDirection[i],
    //   0,
    // );
    // let orthogonalPC1 = pc1.map(
    //   (val, i) => val - dotProduct * avgGradDirection[i],
    // );
    // normFactor = Math.sqrt(
    //   orthogonalPC1.reduce((sum, val) => sum + val * val, 0),
    // );
    // let pcaAxis = orthogonalPC1.map((val) => val / normFactor);

    // console.log(avgGradDirection);
    // console.log(pcaAxis);

    setGradientDirectionPlotInfo({ gradient: avgGradDirection, pc1: pcaAxis });
    for (const point of Object.values(newPoints)) {
      point.projX = getDotProduct(point.parameters, avgGradDirection);
      point.projY = getDotProduct(point.parameters, pcaAxis);
      point.projGradient[0] = getDotProduct(point.gradient, avgGradDirection);
      point.projGradient[1] = getDotProduct(point.gradient, pcaAxis);
    }

    const gradxx = Object.values(newPoints).map((p) => p.gradient[0]);
    const gradyy = Object.values(newPoints).map((p) => p.gradient[1]);
    setGradientBounds([
      [Math.min(...gradxx), Math.max(...gradxx)],
      [Math.min(...gradyy), Math.max(...gradyy)],
    ]);

    const xx = Object.values(newPoints).map((d) => d.x);
    let xMax = Math.max(...xx);
    let xMin = Math.min(...xx);
    const yy = Object.values(newPoints).map((d) => d.y);
    const yMax = Math.max(...yy);
    const yMin = Math.min(...yy);

    setWorldDim({
      left: xMin,
      right: xMax,
      bottom: yMin,
      top: yMax,
      position: {
        x: 0,
        y: 0,
      },
    });

    const scaleX = scaleLinear<number>({
      domain: [xMin, xMax],
      // range: [0, svgParentSize.width - margin.right - margin.left],
      range: [0, svgParentSize.width],
      nice: true,
    });
    const scaleY = scaleLinear<number>({
      domain: [yMax, yMin],
      // range: [0, svgParentSize.height - margin.top - margin.bottom],
      range: [0, svgParentSize.height],
      nice: true,
    });

    const projxx = Object.values(newPoints).map((d) => d.projX);
    const projxMax = Math.max(...projxx);
    const projxMin = Math.min(...projxx);
    const projyy = Object.values(newPoints).map((d) => d.projY);
    const projyMax = Math.max(...projyy);
    const projyMin = Math.min(...projyy);
    const projScaleX = scaleLinear<number>({
      domain: [projxMin, projxMax],
      // range: [0, svgParentSize.width - margin.right - margin.left],
      range: [0, svgParentSize.width],
      nice: true,
    });
    const projScaleY = scaleLinear<number>({
      domain: [projyMax, projyMin],
      // range: [0, svgParentSize.height - margin.top - margin.bottom],
      range: [0, svgParentSize.height],
      nice: true,
    });

    setPoints(newPoints);
    setScales({ x: scaleX, y: scaleY, projX: projScaleX, projY: projScaleY });
    setAxisScales({ x: scaleX, y: scaleY });
    // console.log(newPoints);
  }, [
    trajectoryAnalysis,
    metricColorscale,
    clusterColorscale,
    passFailColorscale,
    colorMode,
    filteredTrialIds,
  ]);

  const nColorSegments = 100; // Number of segments
  const metricScale = useMemo(
    () =>
      scaleThreshold({
        domain: Array.from(
          { length: nColorSegments },
          (_, i) => i / nColorSegments,
        ),
        range: Array.from({ length: nColorSegments }, (_, i) =>
          metricColorscale(i / nColorSegments).hex(),
        ),
      }),
    [selectedMetric, metricColorscale],
  );

  const passFailScale = useMemo(
    () =>
      scaleThreshold({
        domain: [0, 1],
        range: [theme.palette.error.main, theme.palette.success.main],
      }),
    [passFailColorscale],
  );

  const clusterLegendScale = useMemo(
    () =>
      scaleOrdinal<string, React.FC | React.ReactNode>({
        domain: Object.keys(clusterInfo ?? {}),
        range: Object.keys(clusterInfo ?? {}).map((label) => {
          const shapeProps = {
            fill: clusterInfo ? clusterInfo[label].color : "black",
            key: `legend-cluster-${label}`,
            left: 6,
            top: 6,
          };

          // console.log(shapeProps.size);
          // console.log(zoom.transformMatrix.scaleY);
          const shapeIndex = Number(label);
          const shapeString = shapeStrings[shapeIndex];

          let shape: ReactNode | null = null;
          if (shapeString === "circle") {
            shape = <GlyphCircle {...shapeProps} />;
          } else if (shapeString === "square") {
            shape = <GlyphSquare {...shapeProps} />;
          } else if (shapeString === "wye") {
            shape = <GlyphWye {...shapeProps} />;
          } else if (shapeString === "triangle") {
            shape = <GlyphTriangle {...shapeProps} />;
          } else if (shapeString === "diamond") {
            shape = <GlyphDiamond {...shapeProps} />;
          } else if (shapeString === "cross") {
            shape = <GlyphCross {...shapeProps} />;
          } else if (shapeString === "star") {
            shape = <GlyphStar {...shapeProps} />;
          }

          return shape;
        }),
      }),
    [clusterInfo],
  );

  const handleMouseMove = useCallback(
    (event: React.MouseEvent | React.TouchEvent) => {
      // if (!svgRef.current || voronoiLayout == null) {
      //   return;
      // }
      if (!svgParentSize.parentRef.current || voronoiLayout == null) {
        return;
      }

      const point = localPoint(svgParentSize.parentRef.current, event);
      if (!point) {
        return;
      }
      const neighborRadius = 100;
      const closest = voronoiLayout.find(point.x, point.y, neighborRadius);
      if (closest && filteredTrialIds.includes(closest.data.trialId)) {
        if (gradientDirectionMode) {
          setTooltip({
            left: scales?.projX(closest.data.projX) ?? 0,
            top: scales?.projY(closest.data.projY) ?? 0,
            data: closest.data,
          });
        } else {
          setTooltip({
            left: scales?.x(closest.data.x) ?? 0,
            top: scales?.y(closest.data.y) ?? 0,
            data: closest.data,
          });
        }
      } else {
        setTooltip(null);
      }
    },
    [scales, voronoiLayout, gradientDirectionMode, filteredTrialIds],
  );

  const handleMouseLeave = useCallback(() => {
    setTooltip(null);
  }, []);

  const fpcGradMagRange = useMemo(() => {
    const mags = Object.values(points ?? {}).map((p) => p.fpcGradMag);
    return {
      min: Math.min(...mags) ?? 0,
      max: Math.max(...mags) ?? 1,
    };
  }, [points]);

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
          const newScaleProjX = scaleLinear<number>({
            domain: prev.projX.domain(),
            range: [0, width],
            // range: [0, width - margin.left - margin.right],
          });
          const newScaleProjY = scaleLinear<number>({
            domain: prev.projY.domain(),
            range: [0, height],
            // range: [0, height - margin.top - margin.bottom],
          });
          return {
            x: newScaleX,
            y: newScaleY,
            projX: newScaleProjX,
            projY: newScaleProjY,
          };
        });
      }
    });
  }, []);

  useEffect(() => {
    setVoronoiLayout(
      voronoi<Point>({
        x: (d) =>
          (gradientDirectionMode ? scales?.projX(d.projX) : scales?.x(d.x)) ??
          0,
        y: (d) =>
          (gradientDirectionMode ? scales?.projY(d.projY) : scales?.y(d.y)) ??
          0,
        width: svgParentSize.width,
        height: svgParentSize.height,
      })(Object.values(points ?? {})),
    );
  }, [svgParentSize.width, svgParentSize.height, scales, points]);

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

  const boundaryContour = useMemo(() => {
    if (selectedSafetyBoundaryMetric == null || scales == null) {
      return null;
    }

    // // Create a 2D density grid
    // const gridSize = 10; // Grid resolution
    // const densityData = new Array(gridSize * gridSize).fill(0);
    //
    // // Map points to grid
    // const xStep = (scales.x.domain()[1] - scales.x.domain()[0]) / gridSize;
    // const yStep = (scales.y.domain()[1] - scales.y.domain()[0]) / gridSize;
    //
    // Object.values(points ?? {}).forEach((p) => {
    //   const xi = Math.floor((p.x - scales.x.domain()[0]) / xStep);
    //   const yi = Math.floor((p.y - scales.y.domain()[0]) / yStep);
    //   if (xi >= 0 && xi < gridSize && yi >= 0 && yi < gridSize) {
    //     densityData[yi * gridSize + xi] += p.passFailValue === 0 ? -1 : 1;
    //   }
    // });
    //
    // console.log(densityData);
    //
    // return contours().size([gridSize, gridSize]).thresholds([0])(densityData);

    const grid =
      trajectoryAnalysis?.boundaryGrid[selectedSafetyBoundaryMetric.kpi.name];
    if (grid == null) {
      return null;
    }
    const resolution = grid.z.length;
    // console.log(resolution);
    const values = new Float32Array(resolution * resolution);
    for (let j = 0; j < resolution; j++) {
      for (let i = 0; i < resolution; i++) {
        values[j * resolution + i] = grid.z[j][i];
      }
    }
    return contours().size([resolution, resolution]).thresholds([0])([
      ...values.values(),
    ]);
  }, [trajectoryAnalysis, selectedSafetyBoundaryMetric, points]);

  return (
    <Box sx={{ width: "100%", height: "100%", overflow: "hidden" }}>
      <Box
        component="div"
        ref={axisSvgParentSize.parentRef}
        sx={{
          display: scales == null ? "none" : "initial",
          width: "100%",
          height: "100%",
          position: "absolute",
          top: 0,
          overflow: "hidden",
          // background: "red",
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
          // width: "100%",
          // height: "100%",
          position: "relative",
          top: 0,
        }}
      >
        <Contour sx={{ position: "absolute", top: 0 }} />
        <Zoom<SVGSVGElement>
          width={svgParentSize.width}
          height={svgParentSize.height}
          scaleXMin={1 / 2}
          scaleXMax={10}
          scaleYMin={1 / 2}
          scaleYMax={10}
          initialTransformMatrix={initialTransform}
        >
          {(zoom) => (
            <Box
              component="div"
              sx={{ position: "relative", width: "100%", height: "100%" }}
            >
              <svg
                width={svgParentSize.width}
                height={svgParentSize.height}
                ref={zoom.containerRef}
              >
                <RectClipPath
                  id="zoom-clip"
                  width={svgParentSize.width}
                  height={svgParentSize.height}
                />
                {/* <Group transform={zoom.toString()}> */}
                <Group>
                  {/* <LinePath<any> */}
                  {/*   curve={curveNatural} */}
                  {/*   data={ */}
                  {/*     selectedSafetyBoundaryMetric && trajectoryAnalysis */}
                  {/*       ? trajectoryAnalysis?.boundaryPaths[ */}
                  {/*       selectedSafetyBoundaryMetric?.kpi.name */}
                  {/*       ][0] */}
                  {/*       : [] */}
                  {/*   } */}
                  {/*   x={(d) => scales?.x(d[0]) ?? 0} */}
                  {/*   y={(d) => scales?.y(d[1]) ?? 0} */}
                  {/*   stroke={"lime"} */}
                  {/*   strokeWidth={3} */}
                  {/*   strokeOpacity={1} */}
                  {/* // shapeRendering="geometricPrecision" */}
                  {/* // markerMid="url(#marker-circle)" */}
                  {/* // markerStart={markerStart} */}
                  {/* // markerEnd={markerEnd} */}
                  {/* /> */}
                  {/* <Group> */}
                  {/*   {boundaryContour == null || scales == null */}
                  {/*     ? null */}
                  {/*     : boundaryContour.map((c, i) => ( */}
                  {/*       // <path */}
                  {/*       //   key={`contour-${i}`} */}
                  {/*       //   d={geoPath()(c) ?? undefined} */}
                  {/*       //   fill="none" */}
                  {/*       //   stroke="blue" */}
                  {/*       //   strokeWidth={2} */}
                  {/*       //   strokeDasharray="4,4" */}
                  {/*       // /> */}
                  {/*       <path */}
                  {/*         key={i} */}
                  {/*         d={c.coordinates */}
                  {/*           .flat() */}
                  {/*           .map((ring) => */}
                  {/*           // `M${ring.map((p) => `${scales.x(p[0])},${scales.y(p[1])}`).join("L")}Z`, */}
                  {/*           { */}
                  {/*             console.log(ring); */}
                  {/*             return `M${ring.map((p) => `${scales.x(p[0])},${p[1]}`).join("L")}Z`; */}
                  {/*           }, */}
                  {/*           ) */}
                  {/*           .join(" ")} */}
                  {/*         stroke="blue" */}
                  {/*         strokeWidth={2} */}
                  {/*         fill="none" */}
                  {/*       /> */}
                  {/*     ))} */}
                  {/* </Group> */}
                  <Group
                    pointerEvents="none"
                    style={{ display: !showPoints ? "none" : "inherit" }}
                  >
                    {Object.values(points ?? {}).map((point, i) => {
                      const color =
                        selectedPairTrialId != null ||
                        selectedPairTrialId != null
                          ? tooltip?.data.trialId === point.trialId
                            ? "black"
                            : chroma(point.color)
                                .alpha(
                                  selectedPairTrialId == point.trialId ||
                                    selectedTrialId == point.trialId
                                    ? 1.0
                                    : 1.0,
                                )
                                .hex()
                          : chroma(point.color)
                              .darken(
                                tooltip?.data.trialId === point.trialId
                                  ? 2.0
                                  : 0.0,
                              )
                              .hex();
                      const shapeProps = {
                        ...(glyphMode === "pass/fail"
                          ? {
                              fill: "none",
                              strokeWidth: "4px",
                              size: 54 / zoom.transformMatrix.scaleY,
                              stroke: color,
                            }
                          : {
                              size: 48 / zoom.transformMatrix.scaleY,
                              fill: color,
                            }),
                        style: {
                          display: filteredTrialIds.includes(point.trialId)
                            ? "inherit"
                            : "none",
                          opacity:
                            (selectedPairTrialId != null &&
                              (selectedTrialId == point.trialId ||
                                selectedPairTrialId === point.trialId)) ||
                            (selectedPairTrialId == null &&
                              filteredTrialIds.includes(point.trialId))
                              ? 1.0
                              : 0.05,
                        },
                        key: `point-dot-${point.trialId}`,
                        left: gradientDirectionMode
                          ? scales?.projX(point.projX)
                          : scales?.x(point.x),
                        top: gradientDirectionMode
                          ? scales?.projY(point.projY)
                          : scales?.y(point.y),
                      };

                      // console.log(shapeProps.size);
                      // console.log(zoom.transformMatrix.scaleY);
                      const shapeIndex = Number(point.clusterLabel);
                      const shapeString = shapeStrings[shapeIndex];

                      let shape: ReactNode | null = null;
                      if (shapeString === "circle") {
                        shape = <GlyphCircle {...shapeProps} />;
                      } else if (shapeString === "square") {
                        shape = <GlyphSquare {...shapeProps} />;
                      } else if (shapeString === "wye") {
                        shape = <GlyphWye {...shapeProps} />;
                      } else if (shapeString === "triangle") {
                        shape = <GlyphTriangle {...shapeProps} />;
                      } else if (shapeString === "diamond") {
                        shape = <GlyphDiamond {...shapeProps} />;
                      } else if (shapeString === "cross") {
                        shape = <GlyphCross {...shapeProps} />;
                      } else if (shapeString === "star") {
                        shape = <GlyphStar {...shapeProps} />;
                      }
                      const isValidElement = React.isValidElement(shape);

                      // shape = <GlyphCircle {...shapeProps} />;
                      if (glyphMode === "interaction-cluster") {
                        return <>{shape}</>;
                      }

                      // const symbolType = d3ScalerOrdinal(symbolsStroke);
                      // console.log(symbolType);
                      // const circleStroke = symbol().type((d) => {
                      //   console.log(d.category);
                      //   return symbolType(d.category);
                      // });
                      // console.log(circleStroke());

                      // const s = symbol(symbolCircle);
                      const st =
                        point.passFailValue === 1
                          ? symbolsStroke[2]
                          : symbolsStroke[0];
                      const s = symbol(st);

                      return (
                        <Group {...shapeProps}>
                          <path d={`${s()}`} transform={`scale(${0.75})`} />
                        </Group>
                      );
                    })}
                  </Group>
                  <Group pointerEvents="none">
                    {Object.values(points ?? {}).map((point, i) => {
                      let alpha =
                        (point.fpcGradMag - fpcGradMagRange.min) /
                        (fpcGradMagRange.max - fpcGradMagRange.min);
                      alpha = Math.max(alpha, 0.1);
                      // const widthRatio = alpha * 0.3;
                      return (
                        <>
                          <Line
                            style={{
                              display: showGradient ? "initial" : "none",
                            }}
                            stroke={chroma("cyan")
                              .alpha(
                                selectedPairTrialId == null
                                  ? filteredTrialIds.includes(point.trialId)
                                    ? 0.8
                                    : 0.0
                                  : selectedTrialId == point.trialId
                                    ? 0.8
                                    : 0.0,
                              )
                              .hex()}
                            strokeWidth={2}
                            // strokeWidth={
                            //   (10.0 / zoom.transformMatrix.scaleY) * alpha
                            // }
                            from={{
                              x: gradientDirectionMode
                                ? scales?.projX(point.projX)
                                : scales?.x(point.x),
                              y: gradientDirectionMode
                                ? scales?.projY(point.projY)
                                : scales?.y(point.y),
                            }}
                            to={{
                              x: gradientDirectionMode
                                ? scales?.projX(
                                    point.projX +
                                      point.projGradient[0] *
                                        (scales
                                          ? scales.projX.domain()[1] -
                                            scales.projX.domain()[0]
                                          : 1) *
                                        0.015,
                                  )
                                : scales?.x(
                                    point.x +
                                      point.gradient[0] *
                                        (scales
                                          ? scales.x.domain()[1] -
                                            scales.x.domain()[0]
                                          : 1) *
                                        0.015,
                                  ),
                              y: gradientDirectionMode
                                ? scales?.projY(
                                    point.projY +
                                      point.projGradient[1] *
                                        (scales
                                          ? scales.projY.domain()[0] -
                                            scales.projY.domain()[1]
                                          : 1) *
                                        0.015,
                                  )
                                : scales?.y(
                                    point.y +
                                      point.gradient[1] *
                                        (scales
                                          ? scales.y.domain()[0] -
                                            scales.y.domain()[1]
                                          : 1) *
                                        0.015,
                                  ),
                            }}
                          />
                        </>
                      );
                    })}
                  </Group>
                </Group>
                <rect
                  width={svgParentSize.width}
                  height={svgParentSize.height}
                  rx={14}
                  fill="transparent"
                  // onTouchStart={zoom.dragStart}
                  onTouchMove={(event) => {
                    // zoom.dragMove(event);
                    handleMouseMove(event);
                  }}
                  onTouchEnd={() => {
                    // zoom.dragEnd();
                    handleMouseLeave();
                  }}
                  // onMouseDown={zoom.dragStart}
                  onMouseMove={(event) => {
                    // zoom.dragMove(event);
                    handleMouseMove(event);
                  }}
                  onMouseUp={() => {
                    if (scales == null) {
                      return;
                    }
                    const parameters =
                      trajectoryAnalysis?.clustering.parameters;
                    if (!parameters) {
                      return;
                    }

                    const bottomLeft = zoom.applyToPoint({
                      x: scales.x.invert(zoom.transformMatrix.translateX),
                      y: scales.y.invert(zoom.transformMatrix.translateY),
                    });
                    const topRight = zoom.applyToPoint({
                      x: scales.x.invert(
                        svgParentSize.width + zoom.transformMatrix.translateX,
                      ),
                      y: scales.y.invert(
                        svgParentSize.height + zoom.transformMatrix.translateY,
                      ),
                    });

                    const scaleX = scaleLinear<number>({
                      // domain: [bottomLeft.x, topRight.x],
                      domain: [
                        scales.x.domain()[0] +
                          (zoom.transformMatrix.translateX *
                            (scales.x.domain()[1] - scales.x.domain()[0])) /
                            svgParentSize.width,
                        ((svgParentSize.width +
                          zoom.transformMatrix.translateX) *
                          (scales.x.domain()[1] - scales.x.domain()[0])) /
                          svgParentSize.width,
                      ],
                      range: [0, svgParentSize.width],
                    });
                    const scaleY = scaleLinear<number>({
                      domain: [topRight.y, bottomLeft.y],
                      range: [svgParentSize.height, 0],
                    });

                    // console.log(worldDim.position);
                    // console.log(scaleX.domain());
                    // console.log(scaleX.range());

                    // setAxisScales({ x: scaleX, y: scaleY });
                    // setWorldDim((prev) => {
                    //   const updated = { ...prev };
                    //   updated.position.x += zoom.transformMatrix.translateX;
                    //   updated.position.y += zoom.transformMatrix.translateY;
                    //   return updated;
                    // });
                    // zoom.dragEnd();
                  }}
                  onMouseLeave={() => {
                    if (zoom.isDragging) {
                      // zoom.dragEnd();
                    }
                    handleMouseLeave();
                  }}
                  onClick={(event) => {
                    if (tooltip) {
                      dispatch(
                        sessionSlice.actions.setSelectedTrialId(
                          tooltip.data.trialId,
                        ),
                      );
                      if (
                        viewerMode == "pass/fail" &&
                        tooltip.data.trialId in safe2unsafeMappings
                      ) {
                        dispatch(
                          sessionSlice.actions.setSelectedPairTrialId(
                            safe2unsafeMappings[tooltip.data.trialId],
                          ),
                        );
                      } else {
                        dispatch(
                          sessionSlice.actions.findAndSetSelectedPairTrialId(),
                        );
                      }
                    }
                  }}
                  onDoubleClick={(event) => {
                    const point = localPoint(event) || { x: 0, y: 0 };
                    zoom.scale({ scaleX: 1.0, scaleY: 1.0, point });
                    dispatch(sessionSlice.actions.setSelectedPairTrialId(null));
                  }}
                />
              </svg>
            </Box>
          )}
        </Zoom>
      </Box>
      {tooltip != null && (
        <Tooltip
          left={
            tooltip.left + margin.left + 10 > axisSvgParentSize.width - 250
              ? tooltip.left + margin.left - 250
              : tooltip.left + margin.left + 10
          }
          top={
            tooltip.top + margin.top + 10 > axisSvgParentSize.height - 150
              ? tooltip.top + margin.top - 150
              : tooltip.top + margin.top + 10
          }
        >
          <Stack sx={{ ".MuiTypography-root": { fontWeight: "bold" } }}>
            <Typography
              fontSize={12}
            >{`id: ${tooltip.data.trialId}`}</Typography>
            <Typography
              fontSize={12}
              sx={{
                color: tooltip.data.metricColor,
              }}
            >{`${
              selectedMetric != null ? selectedMetric.kpi.name : "metric"
            }: ${tooltip.data.metric.toFixed(2)}`}</Typography>
            <Typography
              fontSize={12}
              sx={{
                color: tooltip.data.passFailColor,
              }}
            >{`${
              selectedSafetyBoundaryMetric != null
                ? selectedSafetyBoundaryMetric.kpi.name
                : "pass/fail"
            }: ${tooltip.data.passFailValue.toFixed(2)}`}</Typography>
            <Typography
              fontSize={12}
              sx={{
                color:
                  clusteringResult == null || clusterInfo == null
                    ? "none"
                    : clusterInfo[
                        clusteringResult.data[tooltip.data.trialId].label
                      ].color,
              }}
            >{`cluster: ${
              clusteringResult == null
                ? "none"
                : clusteringResult.data[tooltip.data.trialId].label
            }`}</Typography>
            <Typography fontSize={12}>{`${
              parameters != null ? parameters[0].name : "x"
            }: ${tooltip.data.x.toFixed(2)}`}</Typography>
            <Typography fontSize={12}>{`${
              parameters != null ? parameters[1].name : "y"
            }: ${tooltip.data.y.toFixed(2)}`}</Typography>
            <Typography fontSize={12}>{`${
              parameters != null ? parameters[0].name : "x"
            }Gradent: ${tooltip.data.gradient[0].toFixed(2)}`}</Typography>
            <Typography fontSize={12}>{`${
              parameters != null ? parameters[1].name : "y"
            }Gradient: ${tooltip.data.gradient[1].toFixed(2)}`}</Typography>
          </Stack>
        </Tooltip>
      )}

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

        <Menu
          id="glyph-menu"
          anchorEl={anchorEl}
          open={menuOpened === "glyph"}
          onClose={handleMenuClose}
          slotProps={{
            paper: {
              style: {
                width: "20ch",
              },
            },
          }}
        >
          {glyphModes.map((option) => {
            return (
              <MenuItem
                key={option}
                selected={option === glyphMode}
                onClick={(event) => {
                  handleMenuClose();
                  setGlyphMode(option);
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
            value="colormode"
            size="small"
            selected={false}
            onChange={(event) => {
              handleMenuAnchorClick(event);
              setMenuOpened("glyph");
            }}
          >
            <InterestsIcon />
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
            value="showing-gradient"
            size="small"
            selected={showPoints}
            onChange={() => {
              setShowPoints((prev) => !prev);
            }}
          >
            <Grain />
          </ToggleButton>
          <ToggleButton
            value="showing-gradient"
            size="small"
            selected={showGradient}
            onChange={() => {
              setShowGradient((prev) => !prev);
            }}
          >
            <SwipeRightAltIcon />
          </ToggleButton>
          <ToggleButton
            value="gradient-direciton-mode"
            size="small"
            selected={gradientDirectionMode}
            onChange={() => {
              setGradientDirectionMode((prev) => !prev);
            }}
          >
            <CameraswitchIcon />
          </ToggleButton>
          <IconButton
            size="small"
            onClick={(event) => {
              dispatch(sessionSlice.actions.setSelectedPairTrialId(null));
              dispatch(sessionSlice.actions.setSelectedTrialId(null));
            }}
          >
            <ClearIcon />
          </IconButton>
        </StyledToggleButtonGroup>
      </Stack>

      <Legends
        sx={{
          display: showLegend ? "initial" : "none",
        }}
      />
    </Box>
  );
}
