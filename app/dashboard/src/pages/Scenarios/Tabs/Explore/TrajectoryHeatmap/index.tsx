import chroma from "chroma-js";
import { scaleLinear, scaleThreshold } from "@visx/scale";
import { AxisLeft, AxisBottom } from "@visx/axis";
import {
  Button,
  Box,
  Drawer,
  Grid2,
  IconButton,
  Menu,
  Stack,
  ToggleButton,
  ToggleButtonGroup,
  Typography,
  useTheme,
  Modal,
} from "@mui/material";
import { Viewport } from "pixi-viewport";
import { Application, Container, Graphics, Sprite, Ticker } from "pixi.js";
import { ReactNode, useEffect, useMemo, useRef, useState } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { DEG2RAD } from "three/src/math/MathUtils.js";
import { Redo, Article, Settings } from "@mui/icons-material";
import CloseIcon from "@mui/icons-material/Close";
import ArrowDropDown from "@mui/icons-material/ArrowDropDown";
import SortAndFilter from "./SortAndFilter";
import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
import { styled } from "@mui/material/styles";
import Legend from "./Legend";

import { useParentSize } from "@visx/responsive";
import {
  TransferFunctionEditor,
  TransparencyEditor,
  ColorMapEditor,
  ColorPicker,
} from "src/transfer-function-editor/src";
import NumericInput from "src/components/NumericInput";
import { display2originalValue, displayValue, getUnit } from "src/utils";

type Bound = {
  [attribute: string]: {
    range: [number, number];
    colorscale: chroma.Scale;
    // domain: number[];
    colorStops: { stop: number; color: string }[];
    alphaStops: { stop: number; alpha: number }[];
  };
} | null;

const TransferFunction = ({
  attribute,
  bound,
  setBound,
  onClose,
}: {
  attribute: string | null;
  bound: Bound;
  setBound: React.Dispatch<React.SetStateAction<Bound>>;
  onClose: () => void;
}) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const [tf, setTf] = useState<TransferFunctionEditor | null>(null);

  const axisSvgRef = useRef<SVGSVGElement>(null);
  const axisSvgParentSize = useParentSize({ debounceTime: 150 });

  useEffect(() => {
    if (containerRef.current == null || bound == null || attribute == null) {
      return;
    }

    const tf = new TransferFunctionEditor(containerRef.current, {
      initialColorMap: {
        interpolationMethod: "HSL",
        colorStops: bound[attribute].colorStops,
      },
      initialAlphaStops: bound[attribute].alphaStops,
    });

    tf.addListener((tf) => {
      const element = document.querySelector("#tf-output");
      if (element) {
        element.innerText = JSON.stringify(tf.getTransferFunction(), null, 2);
      }
    });

    setTf(tf);
  }, []);

  return (
    <Stack
      component="div"
      sx={{
        position: "absolute",
        top: "40%",
        left: "50%",
        width: "800px",
        height: "550px",

        transform: "translate(-50%, -50%)",
        bgcolor: "background.paper",
        boxShadow: 24,
        p: 4,
      }}
      justifyContent="space-between"
    >
      <Typography sx={{ mb: 1 }}>
        {attribute} Transfer Function Editor
      </Typography>
      <Box ref={containerRef} sx={{ width: "100%", height: "300px" }}></Box>
      <Box
        component="div"
        ref={axisSvgParentSize.parentRef}
        sx={{
          width: "100%",
          height: "50px",

          background: "background.paper",
          position: "relative",
          transform: "translateY(-50px)",
        }}
      >
        <svg
          ref={axisSvgRef}
          width={axisSvgParentSize.width}
          height={axisSvgParentSize.height}
          fill={"white"}
        >
          <rect
            width={axisSvgParentSize.width}
            height={axisSvgParentSize.height}
            fill={"white"}
          ></rect>
          <AxisBottom
            top={0}
            scale={
              bound == null || attribute == null
                ? scaleLinear<number>()
                : scaleLinear<number>({
                    domain: [
                      bound[attribute]?.range[0] ?? 0,
                      bound[attribute]?.range[1] ?? 1,
                    ],
                    range: [0, axisSvgParentSize.width],
                  })
            }
            numTicks={10}
            tickLabelProps={{ fontSize: 12 }}
          />
        </svg>
      </Box>
      <Button
        onClick={() => {
          console.log(tf?.getColorMap());
          console.log(tf?.getTransferFunction());
          if (tf == null) {
            return;
          }

          const colorStops = tf.getColorMap().colorStops;
          const alphaStops = tf.getAlphaStops();

          // Extract stop positions and colors
          const stops = colorStops.map((cs) => cs.stop);
          const colors = colorStops.map((cs) => cs.color);

          // Create Chroma color scale in HSL mode
          const colorScale = chroma.scale(colors).domain(stops).mode("hsl");

          // Function to interpolate alpha values
          function interpolateAlpha(value: number) {
            if (value <= alphaStops[0].stop) return alphaStops[0].alpha;
            if (value >= alphaStops[alphaStops.length - 1].stop)
              return alphaStops[alphaStops.length - 1].alpha;

            for (let i = 0; i < alphaStops.length - 1; i++) {
              let a1 = alphaStops[i];
              let a2 = alphaStops[i + 1];

              if (value >= a1.stop && value <= a2.stop) {
                let t = (value - a1.stop) / (a2.stop - a1.stop);
                return (1 - t) * a1.alpha + t * a2.alpha;
              }
            }
            return 0.0;
          }

          // Generate 20 interpolated colors with alpha
          const numColors = 20;
          const interpolatedColors = Array.from(
            { length: numColors },
            (_, i) => {
              let value = i / (numColors - 1); // Normalize between 0 and 1
              let color = chroma(colorScale(value).hex());
              let alpha = interpolateAlpha(value);
              return color.alpha(alpha).css(); // Return rgba()
            },
          );

          const scale = chroma.scale(interpolatedColors);
          setBound((prev) => {
            if (!attribute || !prev) {
              return prev;
            }
            const result = { ...prev };
            result[attribute] = {
              range: prev[attribute].range,
              colorStops: colorStops,
              alphaStops: alphaStops,
              colorscale: scale,
            };
            return result;
          });
          onClose();
        }}
        variant="contained"
        sx={{ width: "100%" }}
      >
        Update
      </Button>
    </Stack>
  );
};

const globalStorage: {
  scaleX: number;
  attrPlotInfo: { [attr: string]: { startX: number; endX: number } };
  hoveredTrialGraphics: Graphics | null;
  selectedTrialGraphics: {
    [viewer: string]: { graphics: Graphics; y: number };
  };
  viewerTrialIds: { [viewerName: string]: string[] };
  viewerStartY: { [viewerName: string]: number };
  hoveredTrialId: string | null;
  userScaleY: number;
} = {
  scaleX: 0,
  attrPlotInfo: {},
  viewerTrialIds: {},
  viewerStartY: {},
  hoveredTrialGraphics: null,
  selectedTrialGraphics: {},
  hoveredTrialId: null,
  userScaleY: 1,
};

const resolution = 15;

const StyledToggleButtonGroup = styled(ToggleButtonGroup)(({ theme }) => ({
  [`& .${toggleButtonGroupClasses.grouped}`]: {
    margin: theme.spacing(0.5),
    p: 0,
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

export default function TrajectoryHeatmap() {
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  // const svgParentSize = useParentSize({ debounceTime: 150 });
  const dispatch = useAppDispatch();
  const theme = useTheme();

  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusteringResult,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusterInfo,
  );
  const viewerMode = useAppSelector((state) => state.session.viewerMode);
  const selectedMetric = useAppSelector(
    (state) => state.session.selectedMetric,
  );
  const selectedBoundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const selectedPairTrialId = useAppSelector(
    (state) => state.session.selectedPairTrialId,
  );
  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const clusteringDurationMode = useAppSelector(
    (state) => state.session.clusteringDurationMode,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );

  const [redrawHandled, setRedrawHandled] = useState(true);

  const clusterCounter = useMemo(() => {
    if (clusteringResult == null || clusterInfo == null) {
      return;
    }
    const counter: { [clusterLabel: string]: number } = {};

    const trialIds =
      filteredTrialIds.length === 0
        ? Object.keys(trajectoryAnalysis?.clustering.scores ?? {})
        : filteredTrialIds;

    for (const trialId of trialIds) {
      if (!(trialId in clusteringResult.data)) {
        continue;
      }
      const label = clusteringResult.data[trialId].label;
      if (label != null && !(label in counter)) {
        counter[label] = 0;
      }
      if (label != null) {
        counter[label] += 1;
      }
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, trajectoryAnalysis]);

  const passFailCounter = useMemo(() => {
    if (clusteringResult == null || clusterInfo == null) {
      return;
    }
    const counter: { [clusterLabel: string]: number } = {};
    const trialIds =
      filteredTrialIds.length === 0
        ? Object.keys(trajectoryAnalysis?.clustering.scores ?? {})
        : filteredTrialIds;
    for (const trialId of trialIds) {
      if (!(trialId in clusteringResult.data)) {
        continue;
      }
      const trial = trajectoryAnalysis?.trials[trialId];
      const passed = trial?.testObjectives?.criticalityMetrics.find(
        (m) => m.keyPerformanceIndicator.id === selectedBoundaryMetric?.kpi?.id,
      )?.passed;
      const label = passed ? "pass" : "fail";
      if (!(label in counter)) {
        counter[label] = 0;
      }
      counter[label] += 1;
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, trajectoryAnalysis]);

  const [userScaleX, setUserScaleX] = useState<number>(1);
  const [userScaleY, setUserScaleY] = useState<number>(1);
  const [modalOpen, setModalOpen] = useState(false);
  const [bound, setBound] = useState<Bound>(null);
  const [boundInput, setBoundInput] = useState<{
    [attribute: string]: { min: number; max: number };
  }>({});

  const [showLegend, setShowLegend] = useState(true);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [attributes, setAttributes] = useState<string[]>([]);
  const [filteredAttributes, setFilteredAttributes] = useState<string[]>([]);
  const [viewerTrials, setViewerTrials] = useState<{
    [viewerName: string]: string[];
  }>({});

  // const [modalOpen, setModalOpen] = useState(false);
  const [transferFunctionOpen, setTransferFunctionOpen] = useState<
    string | null
  >(null);

  let viewerTrialIds = useMemo(() => {
    if (clusteringResult == null || trajectoryAnalysis == null) {
      return null;
    }
    const result: { [viewerName: string]: string[] } = {};
    if (viewerMode == "interaction-cluster") {
      // if (clusteringResult.task.method === "hdbscan") {
      //   Object.entries(clusteringResult.data)
      //     .sort((a, b) => {
      //       const cluster = a[1].label.localeCompare(b[1].label);
      //       if (cluster != 0) {
      //         return cluster;
      //       }
      //       const label = String(Number(a[1].label) - 1);
      //       return a[1].probability - b[1].probability;
      //     })
      //     .map((item) => item[0])
      //     .filter(
      //       (trialId) =>
      //         filteredTrialIds.includes(trialId) ||
      //         filteredTrialIds.length === 0,
      //     )
      //     .forEach((trialId) => {
      //       const clusterLabel = clusteringResult.data[trialId].label;
      //       if (!(clusterLabel in result)) {
      //         result[clusterLabel] = [];
      //       }
      //       result[clusterLabel].push(trialId);
      //     });
      // } else {
      trajectoryAnalysis.clustering.dendrogram["hierarchy"].trialIds
        .filter(
          (trialId) =>
            filteredTrialIds.includes(trialId) || filteredTrialIds.length === 0,
        )
        .forEach((trialId) => {
          const clusterLabel = clusteringResult.data[trialId].label;
          if (!(clusterLabel in result)) {
            result[clusterLabel] = [];
          }
          result[clusterLabel].push(trialId);
        });
    } else if (selectedMetric != null && viewerMode == "pass/fail") {
      trajectoryAnalysis.clustering.dendrogram["hierarchy"].trialIds
        .filter(
          (trialId) =>
            filteredTrialIds.includes(trialId) || filteredTrialIds.length === 0,
        )
        // .filter(
        //   (id) =>
        //     selectedPairTrialId == null ||
        //     id === selectedPairTrialId ||
        //     id === selectedTrialId,
        // )
        .map((trialId) => {
          const trial = trajectoryAnalysis?.trials[trialId];

          const passed = trial?.testObjectives?.criticalityMetrics.find(
            (m) =>
              m.keyPerformanceIndicator.id === selectedBoundaryMetric?.kpi?.id,
          )?.passed;
          const viewerName = passed ? "pass" : "fail";
          if (!(viewerName in result)) {
            result[viewerName] = [];
          }
          result[viewerName].push(trialId);
        });
    }
    return result;
  }, [
    clusterInfo,
    trajectoryAnalysis,
    viewerMode,
    selectedPairTrialId,
    filteredTrialIds,
  ]);

  let modes =
    viewerMode === "pass/fail"
      ? ["pass", "fail"]
      : Object.keys(clusterInfo ?? {});

  const [viewers, setViewers] = useState<{
    [viewerName: string]: {
      app: Application;
      viewport: Viewport;
      sceneNode: Container;
    };
  } | null>(null);

  const resizeObserver = useMemo(() => {
    return new ResizeObserver((entries) => {
      window.dispatchEvent(new Event("resize"));
      for (let entry of entries) {
        entry.target.dispatchEvent(new Event("resize"));
        const { width, height } = entry.contentRect;
      }
    });
  }, [viewers]);

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
    setAttributes(trajectoryAnalysis?.columns ?? []);
    setFilteredAttributes(
      trajectoryAnalysis?.columns.filter(
        (c) =>
          (c.includes("Ego") || c.includes("Distance")) &&
          !c.includes("Parking") &&
          !c.includes("YawRate"),
      ) ?? [],
    );
  }, [trajectoryAnalysis]);

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      return;
    }

    const colorValueLength = 30;
    const colorValues = Array.from(
      { length: colorValueLength },
      (_x, i) => i / colorValueLength,
    );

    const updatedBound: Bound = {};

    for (const trialId of trajectoryAnalysis.clustering.dendrogram["hierarchy"]
      .trialIds) {
      const trajectory = trajectoryAnalysis.trajectories[trialId];
      const attributes = Object.keys(trajectory[0]);
      for (const attribute of attributes) {
        if (attribute.includes("EgoAcc")) {
          if (!(attribute in updatedBound)) {
            updatedBound[attribute] = {
              range: [-4.5, 4.5],
              colorscale: chroma.scale(),
              domain: [],
            };
          }
          continue;
        }
        if (attribute.includes("YawRate")) {
          if (!(attribute in updatedBound)) {
            updatedBound[attribute] = {
              range: [-45 * DEG2RAD, 45 * DEG2RAD],
              colorscale: chroma.scale(),
              domain: [],
            };
          }
          continue;
        }
        if (attribute.includes("RelativeDistance")) {
          if (!(attribute in updatedBound)) {
            updatedBound[attribute] = {
              range: [0, 20],
              colorscale: chroma.scale(),
              domain: [],
            };
          }
          continue;
        }
        const values = trajectory.map((snapshot) => snapshot[attribute]);
        if (!(attribute in updatedBound)) {
          updatedBound[attribute] = {
            range: [
              +Math.min(...values).toFixed(4),
              +Math.max(...values).toFixed(4),
            ],
            colorscale: chroma.scale(),
            domain: [],
          };
        } else {
          updatedBound[attribute].range[0] = +Math.min(
            updatedBound[attribute].range[0],
            Math.min(...values),
          ).toFixed(4);
          updatedBound[attribute].range[1] = +Math.max(
            updatedBound[attribute].range[1],
            Math.max(...values),
          ).toFixed(4);
        }
      }
      const brbg = chroma.scale("PuOr");
      for (const attribute of attributes) {
        if (attribute.includes("DISABLE-RelativeDistance")) {
          const domain = [0, 0.05, 1];
          const colorscale = chroma
            // .scale(["white", warmColors[0], warmColors[1]])
            .scale([brbg(0.5), brbg(0.75), brbg(1.0)])
            .domain(domain);
          updatedBound[attribute].colorscale = colorscale;
          updatedBound[attribute].domain = domain;
          updatedBound[attribute].colorStops = [
            { stop: 0, color: brbg(0).hex() },
            { stop: 0.5, color: brbg(0.5).hex() },
            { stop: 1, color: brbg(1).hex() },
          ];
        } else if (updatedBound[attribute].range[0] >= 0) {
          const colorscale = chroma.scale([brbg(0.5), brbg(0.75), brbg(1.0)]);
          // .scale(["white", warmColors[0], warmColors[1]]);
          updatedBound[attribute].colorscale = colorscale;
          updatedBound[attribute].colorStops = [
            { stop: 0, color: brbg(0.5).hex() },
            { stop: 0.5, color: brbg(0.75).hex() },
            { stop: 1, color: brbg(1).hex() },
          ];
        } else {
          const midValue =
            (0 - updatedBound[attribute].range[0]) /
            (updatedBound[attribute].range[1] -
              updatedBound[attribute].range[0]);
          const domain = [0, midValue / 2, midValue, (1 + midValue) / 2, 1];
          updatedBound[attribute].colorscale = chroma
            .scale([brbg(0), brbg(0.25), brbg(0.5), brbg(0.75), brbg(1.0)])
            .domain(domain);

          updatedBound[attribute].colorStops = [
            { stop: 0, color: brbg(0).hex() },
            { stop: midValue / 2, color: brbg(0.25).hex() },
            { stop: 0.5, color: brbg(0.5).hex() },
            { stop: (1 + midValue) / 2, color: brbg(0.75).hex() },
            { stop: 1, color: brbg(1).hex() },
          ];
        }
        updatedBound[attribute].alphaStops = [
          { stop: 0, alpha: 1 },
          { stop: 1, alpha: 1 },
        ];
      }
    }

    setBound(updatedBound);

    const newBoundInput: typeof boundInput = {};
    for (const [key, item] of Object.entries(updatedBound ?? {})) {
      newBoundInput[key] = { min: item.range[0], max: item.range[1] };
    }
    setBoundInput(newBoundInput);
  }, [trajectoryAnalysis]);

  useEffect(() => {
    // if (redrawHandled) {
    //   return;
    // }
    if (trajectoryAnalysis == null || bound == null) {
      return;
    }

    const framePeriod = trajectoryAnalysis.request.framePeriod;
    const sprites: Sprite[] = [];
    const graphicsArray: Graphics[] = [];

    const initApp = async () => {
      console.log("CREATE HEATMAP APP");
      const newViewers: typeof viewers = {};

      const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
      for (const label of modes) {
        for (const attribute of filteredAttributes) {
          await sleep(50);

          const container = document.getElementById(
            `heatmap-${viewerMode}-${label}-${attribute}-canvas-container`,
          );
          const canvas = document.getElementById(
            `heatmap-${viewerMode}-${label}-${attribute}-canvas`,
          ) as HTMLCanvasElement;
          if (container == null || canvas == null) {
            console.log(`NULL CANNOT CREATE VIEWER`);
            continue;
          }
          const gl = canvas.getContext("webgl2");
          if (!gl) {
            console.error("WebGL2 not supported");
            continue;
          }

          const { width, height } = container.getBoundingClientRect();

          const app = new Application();
          await app.init({
            canvas: canvas,
            width,
            height,
            backgroundColor: "#555",
            resizeTo: container,
            antialias: true,
            autoDensity: true,
          });

          const sceneNode = new Container();
          sceneNode.scale.y = -1;

          const viewport = new Viewport({
            screenWidth: app.canvas.width,
            screenHeight: app.canvas.height,
            worldWidth: app.canvas.width,
            worldHeight: app.canvas.height,
            events: app.renderer.events, // the interaction module is important for wheel to work properly when renderer.view is placed or scaled
          });
          // viewport.drag().pinch().wheel();
          // viewport.pinch().wheel();
          viewport.drag({ wheel: false });
          app.stage.addChild(viewport);
          viewport.addChild(sceneNode);

          newViewers[`${label}-${attribute}`] = { app, viewport, sceneNode };
        }
      }

      function syncViewportTransform(master: Viewport, target: Viewport) {
        target.position.copyFrom(master.position);
        target.scale.copyFrom(master.scale);
        target.rotation = master.rotation;
        target.pivot.copyFrom(master.pivot);
      }

      function syncViewportX(master: Viewport, target: Viewport) {
        target.position.x = master.position.x;
      }

      for (const [key, viewer] of Object.entries(newViewers)) {
        const [label, attribute] = key.split("-");
        viewer.viewport.on("moved", () => {
          for (const [otherKey, other] of Object.entries(newViewers)) {
            syncViewportX(viewer.viewport, other.viewport);
            const [otherLabel, otherAttribute] = otherKey.split("-");
            if (other === viewer || otherLabel != label) {
              continue;
            }
            syncViewportTransform(viewer.viewport, other.viewport);
          }
        });
      }

      console.log(Object.keys(newViewers));

      for (const [key, viewer] of Object.entries(newViewers)) {
        await sleep(50);
        console.log(key);

        const [label, attribute] = key.split("-");

        let attrHeatmap = new Graphics();
        const { app, viewport, sceneNode } = viewer;

        let spriteY = 0;

        let currentY = 0;

        for (const trialId of viewerTrialIds == null ||
        !(label in viewerTrialIds)
          ? []
          : viewerTrialIds[label]) {
          const trial = trajectoryAnalysis?.trials[trialId];

          const clusteringDuration =
            trajectoryAnalysis?.clustering.durationIndices[trialId];

          const y = currentY;
          const trajectory = trajectoryAnalysis.trajectories[trialId];
          for (const [index, snapshot] of trajectory.entries()) {
            if (
              clusteringDurationMode &&
              (index < clusteringDuration[0] || index > clusteringDuration[1])
            ) {
              continue;
            }
            let x = snapshot["time"] / framePeriod;
            if (clusteringDurationMode) {
              x =
                (snapshot["time"] - trajectory[clusteringDuration[0]]["time"]) /
                framePeriod;
            }
            let currentX = x;
            let colorValue =
              (snapshot[attribute] - bound[attribute].range[0]) /
              (bound[attribute].range[1] - bound[attribute].range[0]);
            const color = bound[attribute]
              .colorscale(colorValue)
              .rgb()
              .map((v) => v / 255) as [number, number, number];

            attrHeatmap
              .rect(x * resolution, y * resolution, resolution, resolution)
              .fill(color);
          }

          if (currentY > 250) {
            const texture = app.renderer.generateTexture(attrHeatmap);
            const sprite = new Sprite(texture);
            sprite.position.set(0, spriteY * resolution);
            sprite.pivot.set(0, 0);
            sprites.push(sprite);

            sprite.eventMode = "static";
            sprite.cursor = "pointer";

            sprite.on("pointermove", (event) => {});
            sprite.on("pointerdown", (event) => {});

            sceneNode.addChild(sprite);
            attrHeatmap.destroy({ children: true, context: true });

            attrHeatmap = new Graphics();
            spriteY = currentY;
          }

          currentY += 1;
        }

        const texture = app.renderer.generateTexture(attrHeatmap);
        const sprite = new Sprite(texture);

        sprite.position.set(0, spriteY * resolution);
        sprite.pivot.set(0, 0);
        // sprite.pivot.set(0, sprite.height);
        sprites.push(sprite);

        sprite.eventMode = "static";
        sprite.cursor = "pointer";

        sprite.on("pointermove", (event) => {});
        sprite.on("pointerdown", (event) => {});

        console.log("ADD SPRITE TO SCENENODE");
        sceneNode.addChild(sprite);
        attrHeatmap.destroy();

        const timer = new Graphics();

        timer.rect(0, -resolution, resolution, currentY * resolution).stroke({
          pixelLine: true,
          color: "cyan",
          // color: clusteringDurationMode ? "transparent" : "cyan",
        });
        timer.position.x = resolution;
        timer.position.y = resolution;
        if (!clusteringDurationMode) {
          sceneNode.addChild(timer);
        }
        graphicsArray.push(timer);

        const timeTypography = document.getElementById("clip-time-typography");
        const tick = (ticker: Ticker) => {
          if (!timeTypography) {
            return;
          }
          if (timer.position == null) {
            return;
          }
          timer.position.x =
            (Number(timeTypography.textContent) / framePeriod) * resolution;
        };
        app.ticker.add(tick);
      }

      setUserScaleX((prev) => prev + 0.000001);
      setUserScaleY((prev) => prev + 0.000001);

      setViewers(newViewers);
      setRedrawHandled(true);
    };

    initApp();

    return () => {
      console.log("DESTROY APP HEATMAP");
      for (const viewer of Object.values(viewers ?? {})) {
        viewer?.sceneNode?.destroy({ children: true, context: true });
        viewer?.viewport?.destroy({ children: true, context: true });
        // viewer?.app?.destroy();
      }
      for (const sprite of sprites) {
        if (sprite.destroyed) {
          continue;
        }
        sprite.destroy({ texture: true, textureSource: true });
      }
      for (const graphics of graphicsArray) {
        if (graphics.destroyed) {
          continue;
        }
        graphics.destroy({ children: true, context: true });
      }
    };
  }, [
    viewerMode,
    viewerTrialIds,
    filteredAttributes,
    clusteringDurationMode,
    bound,
  ]);

  // useEffect(() => {
  //   setRedrawHandled(false);
  // }, [viewerMode, filteredAttributes, clusteringDurationMode, bound]);

  useEffect(() => {
    for (const viewer of Object.values(viewers ?? {})) {
      viewer.sceneNode.scale.y = userScaleY;
    }
  }, [userScaleY]);

  useEffect(() => {
    for (const viewer of Object.values(viewers ?? {})) {
      viewer.sceneNode.scale.x = userScaleX;
    }
  }, [userScaleX]);

  return (
    <Stack
      sx={{
        position: "reltive",
        height: "100%",
        overflowY: "hidden",
        overflowX: "scroll",
      }}
    >
      <Modal
        open={transferFunctionOpen != null}
        onClose={() => setTransferFunctionOpen(null)}
      >
        <TransferFunction
          attribute={transferFunctionOpen ?? null}
          bound={bound}
          setBound={setBound}
          onClose={() => setTransferFunctionOpen(null)}
        />
      </Modal>
      <Modal open={modalOpen} onClose={() => setModalOpen(false)}>
        <Box
          sx={{
            position: "absolute",
            top: "50%",
            left: "50%",
            transform: "translate(-50%, -50%)",
            bgcolor: "background.paper",
            boxShadow: 24,
            maxHeight: "90vh",
            overflow: "scroll",

            p: 4,
          }}
        >
          {attributes.map((attribute) => {
            if (!(attribute in boundInput)) {
              return null;
            }
            return (
              <Stack>
                <Typography>{`${attribute} [${getUnit(attribute)}]`}</Typography>
                <Stack direction="row">
                  <NumericInput
                    value={displayValue(boundInput[attribute].min, attribute)}
                    onChange={(event) =>
                      setBoundInput((prev) => {
                        const updated = { ...prev };
                        updated[attribute].min = display2originalValue(
                          Number(Number(event.target.value).toFixed(2)),
                          attribute,
                        );
                        return updated;
                      })
                    }
                  />
                  <NumericInput
                    value={displayValue(boundInput[attribute].max, attribute)}
                    onChange={(event) =>
                      setBoundInput((prev) => {
                        const updated = { ...prev };
                        updated[attribute].max = display2originalValue(
                          Number(Number(event.target.value).toFixed(2)),
                          attribute,
                        );
                        return updated;
                      })
                    }
                  />
                </Stack>
                <Button onClick={() => setTransferFunctionOpen(attribute)}>
                  Transfer Function
                </Button>
              </Stack>
            );
          })}
          <Button
            onClick={() => {
              setBound((prev) => {
                if (prev == null) {
                  return prev;
                }
                const updated = { ...prev };
                for (const attribute in updated) {
                  updated[attribute].range[0] = boundInput[attribute].min;
                  updated[attribute].range[1] = boundInput[attribute].max;
                }
                return updated;
              });
            }}
          >
            Update
          </Button>
        </Box>
      </Modal>
      <Menu
        anchorEl={anchorEl}
        open={anchorEl?.id === "legend-button"}
        onClose={() => {
          setAnchorEl(null);
        }}
        elevation={0}
      >
        <IconButton size="small" onClick={() => setModalOpen(true)}>
          <Settings />
        </IconButton>
        <Legend bound={bound} filteredAttributes={filteredAttributes} />
      </Menu>
      <Drawer
        hideBackdrop
        anchor="bottom"
        open={anchorEl?.id === "sort-filter-button"}
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
            <Typography variant="h6">Controls</Typography>
            <IconButton onClick={() => setAnchorEl(null)}>
              <CloseIcon />
            </IconButton>
          </Stack>
          <SortAndFilter
            attributes={attributes}
            filteredAttributes={filteredAttributes}
            setFilteredAttributes={setFilteredAttributes}
          />
        </Stack>
      </Drawer>
      <Stack direction="row" sx={{ position: "absolute" }}>
        <StyledToggleButtonGroup>
          <ToggleButton
            id="sort-filter-button"
            value="colormode"
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
            <Settings />
          </ToggleButton>
          <ToggleButton
            id="legend-button"
            value="legend"
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
            <Article />
          </ToggleButton>
          <ToggleButton
            value="redraw"
            size="small"
            selected={false}
            onChange={(event) => {
              setRedrawHandled(false);
            }}
          >
            <Redo />
          </ToggleButton>
          <Box
            component="div"
            sx={{
              background: "white",
              padding: 1,
              fontSize: "14px",
            }}
            onWheel={(event) => {
              const sensitivity = 0.0001;
              setUserScaleX((prev) => prev + sensitivity * event.deltaY);
            }}
          >
            Scale X: {userScaleX.toFixed(2)}
          </Box>
          <Box
            component="div"
            sx={{
              background: "white",
              padding: 1,
              fontSize: "14px",
            }}
            onWheel={(event) => {
              const sensitivity = 0.0001;
              setUserScaleY((prev) => prev + sensitivity * event.deltaY);
            }}
          >
            Scale Y: {userScaleY.toFixed(2)}
          </Box>
        </StyledToggleButtonGroup>
      </Stack>
      <Grid2
        container
        component="div"
        ref={containerRef}
        sx={{
          width: `${filteredAttributes.length * 500}px`,
          height: "calc(100% - 40px)",
          overflowY: "hidden",
          overflowX: "hidden",
          marginTop: "40px",
        }}
      >
        {filteredAttributes.map((attribute) => {
          let modes =
            viewerMode === "pass/fail"
              ? ["pass", "fail"]
              : Object.keys(clusterInfo ?? {});
          let counter =
            viewerMode === "pass/fail" ? passFailCounter : clusterCounter;
          return (
            <Grid2
              size={Math.floor((1 / filteredAttributes.length) * 12)}
              sx={{
                height: `calc(99% / ${Object.keys(viewerTrialIds ?? {}).length ?? 1})`,
              }}
            >
              <Typography fontSize={"12px"} textOverflow="ellipsis">
                {attribute}
              </Typography>
              {modes.map((label) => {
                let color =
                  label === "pass"
                    ? theme.palette.success.light
                    : theme.palette.error.light;
                if (viewerMode === "interaction-cluster") {
                  color =
                    clusterInfo && label in clusterInfo
                      ? clusterInfo[label].color
                      : "text.primary";
                }
                return (
                  <Box
                    component="div"
                    key={label}
                    id={`heatmap-${viewerMode}-${label}-${attribute}-canvas-container`}
                    sx={{
                      display: label in (counter ?? {}) ? "inherit" : "none",
                      width: "100%",
                      height: "100%",
                      flex: 1,
                      border: `solid 3px ${color}`,
                      position: "relative",
                    }}
                  >
                    <Stack
                      direction="column"
                      flexWrap="wrap"
                      sx={{
                        position: "absolute",
                        width: "100%",
                        top: 0,
                        right: 0,
                      }}
                    >
                      <Typography
                        sx={{
                          fontWeight: 900,
                          color,
                        }}
                      >
                        {label}
                      </Typography>
                    </Stack>
                    <canvas
                      id={`heatmap-${viewerMode}-${label}-${attribute}-canvas`}
                    ></canvas>
                  </Box>
                );
              })}
            </Grid2>
          );
        })}
      </Grid2>
    </Stack>
  );
}
