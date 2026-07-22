"use client";
import _ from "lodash";
import {
  TransformWrapper,
  TransformComponent,
  ReactZoomPanPinchRef,
} from "react-zoom-pan-pinch";
import {
  Box,
  Drawer,
  IconButton,
  Menu,
  Stack,
  ToggleButton,
  ToggleButtonGroup,
  Typography,
  useTheme,
  Grid,
  MenuItem,
  Skeleton,
  CircularProgress,
} from "@mui/material";
import ColorLensIcon from "@mui/icons-material/ColorLens";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { Viewport } from "pixi-viewport";
import { Application, Container, Graphics, Sprite, Texture } from "pixi.js";
import {
  createRef,
  MouseEvent,
  useContext,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import { useAppDispatch, useAppSelector } from "../../../../redux/hooks";
import {
  batchSlice,
  Bound,
  ClusterInfo,
  viewerModes,
} from "../../../../redux/slices/batch";
import { Redo, Article, Settings } from "@mui/icons-material";
import CloseIcon from "@mui/icons-material/Close";
import SortAndFilter from "./SortAndFilter";
import { toggleButtonGroupClasses } from "@mui/material/ToggleButtonGroup";
import { styled } from "@mui/material/styles";
import JSZip from "jszip";
import LZString from "lz-string";
import { ZipReader, BlobWriter, BlobReader } from "@zip.js/zip.js";

import Input from "@/app/_shared/utils/Input";
import MetricSelection from "../../components/MetricSelection";
import {
  toTitleSpaceCase,
  loadImageAsync,
  getBase64Image,
  getTextFromTxtFile,
  safeIdleCallback,
  uploadImageElement,
} from "@/app/_shared/utils";
import { DockLayoutContext } from "../../index";
import { useParams } from "next/navigation";
import axios from "axios";
import {
  BatchImages,
  getBatchImages,
} from "@/app/_shared/graphql/queries/batches";
import { postDocument } from "@/app/_shared/graphql/queries/documents";
import { interactionSlice } from "../../../../redux/slices/interaction";
import {
  ClusteringResult,
  Mfpca,
} from "@/app/_shared/graphql/queries/clustering";
import { Trial } from "@/app/_shared/graphql/queries/trials";
import { api, getDocs } from "@/app/_shared/api";
import { Document } from "@/app/_shared/graphql/__generated__/graphql";
import { heatmapOrdering } from "@/app/_shared/api/heatmapOrdering";

const DEG2RAD = 3.14159265 / 180;
const resolution = 3;
// const resolution = 7;
const metricBarWidth = 2;
const metricBarGap = 1;
const borderWidth = resolution / 5;
const backgroundColor = "#555";

const windowBorder = 10;
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

const globalStroage = {
  sRatio: 0,
};

export default function TrajectoryHeatmap() {
  const panelName = "heatmap";
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const cropMergeCanvas = useRef<HTMLCanvasElement>(null);
  const params = useParams();
  // const svgParentSize = useParentSize({ debounceTime: 150 });
  const dispatch = useAppDispatch();
  const theme = useTheme();

  const dockLayout = useContext(DockLayoutContext);

  const egos = useAppSelector((state) => state.batch.egos);
  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis
  );
  const savedTrials = useMemo(() => {
    if (!trajectoryAnalysis) {
      return [];
    }
    let result: Trial[] = [];
    for (const egoName of Object.keys(trajectoryAnalysis)) {
      if (trajectoryAnalysis[egoName].trials) {
        result = [
          ...result,
          ...Object.values(trajectoryAnalysis[egoName].trials),
        ];
      }
    }
    return result;
  }, [trajectoryAnalysis]);
  const durationMode = useAppSelector((state) => state.batch.durationMode);
  const showFullTimeline = useAppSelector(
    (state) => state.batch.showFullHeatmap
  );
  const mfpca = useMemo(() => {
    if (trajectoryAnalysis == null) {
      return null;
    }
    let result: { [egoName: string]: Mfpca } = {};
    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      result[egoName] = trajectoryAnalysis[egoName].mfpca[durationMode];
    }
    return result;
  }, [trajectoryAnalysis, durationMode]);

  const clusterInfo = useAppSelector(
    (state) => state.batch.selectedClusterInfos
  );
  const clusteringResult = useAppSelector(
    (state) => state.batch.selectedClusteringResults
  );

  const viewerMode = useAppSelector((state) => state.batch.viewerMode);
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const selectedBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.batch.filteredTrialIds
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.batch.selectedTrialIds
  );
  const attributes = useAppSelector((state) => state.batch.attributes);
  const filteredAttributes = useAppSelector(
    (state) => state.batch.filteredAttributes
  );
  const heatmapGlobalScaleX = useAppSelector(
    (state) => state.batch.heatmapGlobalScaleX
  );
  const heatmapGlobalScaleY = useAppSelector(
    (state) => state.batch.heatmapGlobalScaleY
  );
  const heatmapLocalScaleY = useAppSelector(
    (state) => state.batch.heatmapLocalScaleY
  );

  const batchTrials = useAppSelector((state) => {
    let result: Trial[] = [];
    for (const egoTrials of Object.values(state.batch.trials)) {
      result = [...result, ...egoTrials];
    }
    return result;
  });

  const [batchImages, setBatchImages] = useState<BatchImages | null>(null);
  const [userScaleX, setUserScaleX] = useState(heatmapGlobalScaleX);
  const [userScaleY, setUserScaleY] = useState(heatmapGlobalScaleY);
  const [fullImageWidth, setFullImageWidth] = useState(0);

  const framePeriod = useMemo(() => {
    if (!trajectoryAnalysis) {
      return 1;
    }
    return trajectoryAnalysis[Object.keys(trajectoryAnalysis)[0]].request
      .framePeriod;
  }, [trajectoryAnalysis]);

  const clusteringResultIndex: { [egoName: string]: number } | null =
    useMemo(() => {
      if (trajectoryAnalysis == null || clusteringResult == null) {
        return null;
      }
      const index = trajectoryAnalysis["ITRI"]?.mfpca[
        "full"
      ].clustering.findIndex((v) => v === clusteringResult["ITRI"]);
      const index2 = trajectoryAnalysis["ITRILatest"]?.mfpca[
        "full"
      ].clustering.findIndex((v) => v === clusteringResult["ITRILatest"]);
      return { ITRI: index, ITRILatest: index2 };
    }, [clusteringResult, trajectoryAnalysis]);

  useEffect(() => {
    const loadBatchImages = async () => {
      const results = await getBatchImages({ id: Number(params["id"]) });
      setBatchImages(results);
      // setBatchImages({ id: "", images: [] });
    };
    loadBatchImages();
  }, []);

  useEffect(() => {
    setUserScaleX(heatmapGlobalScaleX);
  }, [heatmapGlobalScaleX]);

  useEffect(() => {
    setUserScaleY(heatmapGlobalScaleY);
  }, [heatmapGlobalScaleY]);

  useEffect(() => {
    if (!containerRef.current) {
      return;
    }
    const handleWheel = (event: WheelEvent) => {
      event.preventDefault();
    };
    let container = containerRef.current;
    container.addEventListener("wheel", handleWheel, { passive: false });

    return () => {
      container.removeEventListener("wheel", handleWheel);
    };
  }, [heatmapGlobalScaleY, heatmapGlobalScaleX]);

  useEffect(() => {
    console.log("DOCKLAYOUT TRIGGER HEATMAP");
  }, [dockLayout]);

  const [timer, setTimer] = useState<number | null>(null);
  const [hoverInfo, setHoverInfo] = useState<{
    trialId: string;
    index: number;
    y: number;
    label: string;
  } | null>(null);
  const [selected, setSelected] = useState<{
    [viewerName: string]: { trialIds: string[]; range: number[] }[];
  }>({});
  const isBaseline = useAppSelector((state) => state.batch.baselineMode);
  const timeOrS = useAppSelector((state) => state.batch.timeOrS);

  useEffect(() => {
    const interval = setInterval(() => {
      setTimer(
        Number(
          document.getElementById("clip-time-typography")?.textContent ?? 0
        )
      );
      let sRatio = Number(
        document.getElementById("clip-s-typography")?.textContent ?? 0
      );
      globalStroage.sRatio = sRatio;
    }, 10);
    return () => clearInterval(interval);
  }, []);

  // Which cluster labels (per ego) are represented by the currently selected
  // trials. Mirrors the Replayer so the heatmap only shows the cluster(s) that
  // contain selected trajectories. `null` => nothing selected => show all.
  const selectedClusterLabelsByEgo = useMemo(() => {
    const ids = selectedTrialIds?.value ?? [];
    if (ids.length === 0 || clusteringResult == null) {
      return null;
    }
    const result: { [egoName: string]: Set<string> } = {};
    for (const egoName of Object.keys(clusteringResult)) {
      const data = clusteringResult[egoName]?.data;
      if (data == null) {
        continue;
      }
      const set = new Set<string>();
      for (const trialId of ids) {
        const label = data[trialId]?.label;
        if (label != null) {
          set.add(String(label));
        }
      }
      if (set.size > 0) {
        result[egoName] = set;
      }
    }
    return Object.keys(result).length > 0 ? result : null;
  }, [selectedTrialIds, clusteringResult]);

  const isClusterVisible = (egoName: string, label: string) => {
    // Only filter in interaction-cluster mode (pass/fail & baseline use
    // non-cluster labels that would never match the selected cluster set).
    if (viewerMode !== "interaction-cluster") {
      return true;
    }
    if (selectedClusterLabelsByEgo == null) {
      return true;
    }
    const set = selectedClusterLabelsByEgo[egoName];
    if (set == null) {
      return true;
    }
    return set.has(String(label));
  };

  const clusterCounter = useMemo(() => {
    let trials: Trial[] = batchTrials;
    if (trajectoryAnalysis != null) {
      trials = savedTrials;
    }

    const trialIds =
      filteredTrialIds.length === 0
        ? trials.map((t) => String(t?.id))
        : filteredTrialIds;

    const counter: { [egoName: string]: { [clusterLabel: string]: number } } =
      {};

    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      // if ( clusteringResult[egoName] == null) {
      //   continue;
      // }
      counter[egoName] = {};
      for (const trialId of trialIds) {
        if (
          clusteringResult == null ||
          clusterInfo == null ||
          mfpca == null ||
          clusteringResult[egoName] == null
        ) {
          if (!("0" in counter)) {
            counter[egoName]["0"] = 0;
          }
          counter[egoName]["0"] += 1;
          continue;
        }
        if (!(trialId in clusteringResult[egoName].data)) {
          continue;
        }
        const label = clusteringResult[egoName].data[trialId].label;
        if (label != null && !(label in counter)) {
          counter[egoName][label] = 0;
        }
        if (label != null) {
          counter[egoName][label] += 1;
        }
      }
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, mfpca]);

  const passFailCounter = useMemo(() => {
    if (clusteringResult == null || clusterInfo == null || mfpca == null) {
      return;
    }
    const counter: { [egoName: string]: { [clusterLabel: string]: number } } =
      {};

    let trials: Trial[] = batchTrials;
    if (trajectoryAnalysis != null) {
      trials = savedTrials;
    }

    const trialIds =
      filteredTrialIds.length === 0
        ? trials.map((t) => String(t?.id))
        : filteredTrialIds;

    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      if (clusteringResult[egoName] == null) {
        continue;
      }

      counter[egoName] = {};
      for (const trialId of trialIds) {
        if (!(trialId in clusteringResult[egoName].data)) {
          continue;
        }

        const trial = trials?.find((t) => t?.id === Number(trialId));
        const passed = trial?.testObjectives?.criticalityMetrics.find(
          (m) =>
            m.keyPerformanceIndicator.id === selectedBoundaryMetric?.kpi?.id
        )?.passed;
        const label = passed ? "pass" : "fail";
        if (!(label in counter)) {
          counter[egoName][label] = 0;
        }
        counter[egoName][label] += 1;
      }
    }
    return counter;
  }, [clusterInfo, filteredTrialIds, mfpca]);

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  const [position, setPosition] = useState({ value: [0, 0], name: "" });

  const heatmapSortedBy = useAppSelector(
    (state) => state.batch.heatmapSortedBy
  );

  const [orderedTrialIds, setOrderedTrialIds] = useState<{
    [egoName: string]: { [label: string]: string[] };
  }>({});

  useEffect(() => {
    let cancelled = false;
    if (trajectoryAnalysis == null || mfpca == null) {
      return;
    }

    async function run() {
      if (trajectoryAnalysis == null || mfpca == null) {
        return;
      }

      const result: { [egoName: string]: { [label: string]: string[] } } = {};

      let trialOrder: string[] = [];

      for (const egoName of Object.keys(trajectoryAnalysis)) {
        if (filteredTrialIds.length === 0) {
          if (clusteringResult && clusteringResult[egoName]) {
            for (const labelOrder of Object.values(
              clusteringResult[egoName].trialOrder ?? {}
            )) {
              trialOrder = [...labelOrder, ...trialOrder];
            }
          } else {
            trialOrder = [...(mfpca[egoName].trialOrder ?? [])];
          }
          continue;
        }

        const body: { [label: string]: { [trialId: string]: number[] } } = {};
        if (clusteringResult) {
          for (const [trialId, item] of Object.entries(
            clusteringResult[egoName]?.data ?? {}
          )) {
            if (
              !filteredTrialIds.includes(trialId) &&
              filteredTrialIds.length !== 0
            ) {
              continue;
            }
            if (!(item.label in body)) {
              body[item.label] = {};
            }

            body[item.label][trialId] = mfpca[egoName].scores[trialId];
          }
          result[egoName] = await heatmapOrdering(body);
        } else {
          result[egoName] = { "0": trialOrder };
        }
      }

      if (!cancelled) {
        setOrderedTrialIds(result);
      }
    }

    console.log("loading true 3");
    setLoading(true);
    run();
    return () => {
      cancelled = true;
    };
  }, [clusteringResult, mfpca, filteredTrialIds]);

  let viewerTrialIds = useMemo(() => {
    setSelected({});
    if (trajectoryAnalysis == null || mfpca == null) {
      console.log("NULL RETURN VIEWER TRIAL IDS");
      return null;
    }
    let result: { [egoName: string]: { [viewerName: string]: string[] } } = {};

    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      result[egoName] = {};

      if (isBaseline) {
        let trialOrder = Object.keys(trajectoryAnalysis[egoName].trials);
        result[egoName]["baseline"] = trialOrder;
        return result;
      }

      let trialOrder: string[] = [];

      if (clusteringResult && clusteringResult[egoName] && egoName === "ITRI") {
        for (const labelOrder of Object.values(
          orderedTrialIds[egoName] ?? {}
        )) {
          trialOrder = [...labelOrder, ...trialOrder];
        }
      } else {
        trialOrder = [...(mfpca[egoName].trialOrder ?? [])];
      }

      if (clusteringResult == null || clusteringResult[egoName] == null) {
        trialOrder
          .filter(
            (trialId) =>
              filteredTrialIds.includes(trialId) ||
              filteredTrialIds.length === 0
          )
          .forEach((trialId) => {
            if (!("0" in result[egoName])) {
              result[egoName]["0"] = [];
            }
            result[egoName]["0"].push(trialId);
          });
        continue;
      }

      const paramIndex =
        trajectoryAnalysis[egoName].batches[
          params["id"] as string
        ]?.scenario.parameters.findIndex((p) => p.name === heatmapSortedBy) ??
        -1;
      if (heatmapSortedBy !== "umap" && paramIndex !== -1) {
        trialOrder = trialOrder.sort((a, b) => {
          const aParamValue =
            trajectoryAnalysis[egoName].trials[a].parameters[paramIndex]
              .value ?? 0;
          const bParamValue =
            trajectoryAnalysis[egoName].trials[b].parameters[paramIndex]
              .value ?? 0;
          return aParamValue - bParamValue;
        });
      }

      if (viewerMode == "interaction-cluster") {
        trialOrder
          .filter(
            (trialId) =>
              filteredTrialIds.includes(trialId) ||
              filteredTrialIds.length === 0
          )
          .forEach((trialId) => {
            if (clusteringResult[egoName] == null) {
              return;
            }
            const clusterLabel = clusteringResult[egoName].data[trialId].label;
            if (!(clusterLabel in result[egoName])) {
              result[egoName][clusterLabel] = [];
            }
            result[egoName][clusterLabel].push(trialId);
          });
      } else if (selectedMetric != null && viewerMode == "pass/fail") {
        trialOrder
          // .filter(
          //   (trialId) =>
          //     filteredTrialIds.includes(trialId) ||
          //     filteredTrialIds.length === 0
          // )
          .map((trialId) => {
            const trial = trajectoryAnalysis[egoName]?.trials[trialId];

            const passed = trial?.testObjectives?.criticalityMetrics.find(
              (m) =>
                m.keyPerformanceIndicator.id === selectedBoundaryMetric?.kpi?.id
            )?.passed;
            const viewerName = passed ? "pass" : "fail";
            if (!(viewerName in result)) {
              result[egoName][viewerName] = [];
            }
            result[egoName][viewerName].push(trialId);
          });
      }
    }

    return result;
  }, [orderedTrialIds]);

  const [loading, setLoading] = useState(false);
  const [heatmapDrawing, setHeatmapDrawing] = useState<{
    app: Application;
    viewport: Viewport;
    sceneNode: Container;
  } | null>(null);

  const [fullHeatmapImages, setFullHeatmapImages] = useState<{
    [egoName: string]: {
      [attribute: string]: HTMLImageElement[];
    };
  }>({});

  const [heatmapImages, setHeatmapImages] = useState<
    Record<string, HTMLImageElement>
  >({});

  const [viewersRef, setViewersRef] = useState<
    React.RefObject<ReactZoomPanPinchRef>[]
  >([]);

  useEffect(() => {
    const newViewersRef: typeof viewersRef = [];
    for (const [index, key] of Object.keys(heatmapImages).entries()) {
      newViewersRef.push(createRef<ReactZoomPanPinchRef>() as any);
    }
    setViewersRef(newViewersRef);
  }, [heatmapImages]);

  const resizeObserver = useMemo(() => {
    return new ResizeObserver((entries) => {
      window.dispatchEvent(new Event("resize"));
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

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      return;
    }
    const attributes =
      trajectoryAnalysis[Object.keys(trajectoryAnalysis ?? {})[0]]
        ?.attributes ?? [];

    dispatch(batchSlice.actions.setAttributes(attributes));
    const preferred = [
      "EgoSpeed",
      "EgoAcceleration",
      "OppositeRelativeDistance",
    ];
    const preferredFiltered = preferred.filter((name) => attributes.includes(name));
    let filteredAttributes =
      preferredFiltered.length > 0
        ? preferredFiltered
        : [...attributes].filter(
            (v) => !v.includes("Spret") && !v.includes("Ttc"),
          );
    const i = filteredAttributes.findIndex((v) => v === "EgoYawRate");
    if (i != null && i >= 0 && trajectoryAnalysis != null) {
      filteredAttributes = filteredAttributes.filter((v) => v !== "EgoYawRate");
    }
    dispatch(batchSlice.actions.setFilteredAttributes(filteredAttributes));
  }, [trajectoryAnalysis]);

  useEffect(() => {
    if (trajectoryAnalysis != null) {
      setLoading(true);
    }
  }, [trajectoryAnalysis]);

  useEffect(() => {
    const container = containerRef.current;
    const canvas = canvasRef.current;
    if (container == null || canvas == null) {
      return;
    }
    const initApp = async () => {
      const { width, height } = container.getBoundingClientRect();

      const app = new Application();
      await app.init({
        canvas: canvas,
        width,
        height,
        backgroundColor: backgroundColor,
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

      app.stage.addChild(viewport);
      viewport.addChild(sceneNode);

      setHeatmapDrawing({ app, viewport, sceneNode });
    };

    initApp();

    return () => {
      console.log("DESTROY HEATMAP DRAWING");
      heatmapDrawing?.sceneNode?.destroy({ children: true, context: true });
      heatmapDrawing?.viewport?.destroy({ children: true, context: true });
      heatmapDrawing?.app.destroy();
    };
  }, []);

  useEffect(() => {
    if (selectedTrialIds.by === "heatmap" || viewerTrialIds == null) {
      return;
    }
    const newSelected: typeof selected = {};
    const selectedSet = new Set(selectedTrialIds.value);
    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      for (const [name, viewer] of Object.entries(
        viewerTrialIds[egoName] ?? {}
      )) {
        const newName = `${egoName}_${name}`;
        newSelected[newName] = [];
        let rangeItem: { trialIds: string[]; range: number[] } = {
          trialIds: [],
          range: [],
        };
        for (const [index, trialId] of viewer.entries()) {
          if (selectedSet.has(trialId)) {
            rangeItem.trialIds.push(trialId);
            if (rangeItem.range.length < 2) {
              rangeItem.range.push(index);
            } else {
              rangeItem.range[1] = index;
            }
          } else {
            if (rangeItem.trialIds.length > 0) {
              newSelected[newName].push(rangeItem);
              rangeItem = { trialIds: [], range: [] };
            }
          }
        }
        if (rangeItem.trialIds.length > 0) {
          newSelected[newName].push(rangeItem);
          rangeItem = { trialIds: [], range: [] };
        }
      }
    }
    setSelected(newSelected);
  }, [selectedTrialIds, viewerTrialIds]);

  useEffect(() => {
    if (trajectoryAnalysis == null || heatmapDrawing == null || mfpca == null) {
      console.log(trajectoryAnalysis);
      console.log(heatmapDrawing);
      console.log(mfpca);
      return;
    }

    console.log("loading true");
    setLoading(true);

    const newHeatmapImages: typeof fullHeatmapImages = {};

    const createEgoImages = async () => {
      for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
        console.log(egoName);
        console.log(attributes);
        newHeatmapImages[egoName] = {};
        const createImages = async () => {
          for (const [attrIndex, attribute] of attributes.entries()) {
            console.log(attribute);
            const key = attribute;
            const imageName = isBaseline
              ? `${egoName}_baseline_${params["id"]}-${trajectoryAnalysis[egoName].id}-${key}_fullheatmap`
              : `${egoName}_${params["id"]}-${trajectoryAnalysis[egoName].id}-${key}_fullheatmap`;

            newHeatmapImages[egoName][attribute] = [];

            const imageUrl =
              trajectoryAnalysis[egoName].fullHeatmaps.find(
                (i) =>
                  (i.filename?.includes(attribute) ||
                    i.url?.includes(attribute)) &&
                  (i.filename?.includes("_" + timeOrS + "_") ||
                    i.url?.includes("_" + timeOrS + "_")),
              )?.url;

            console.log(imageUrl);
            if (imageUrl) {
              console.log(
                `Batch images already have this fullimage ${imageName}`
              );
              try {
                const img = await loadImageAsync(imageUrl);
                newHeatmapImages[egoName][attribute].push(img);

                if (attrIndex === 0) {
                  setFullImageWidth(img.width);
                  console.log(img.width);
                }
              } catch (err) {
                console.warn(`failed to load fullHeatmap ${imageUrl}`, err);
              }
              continue;
            }
          }
        };

        await createImages();
      }

      console.log(newHeatmapImages);
      setFullHeatmapImages(newHeatmapImages);
    };

    createEgoImages();
  }, [selectedMetric, timeOrS, attributes]);

  useEffect(() => {
    if (
      trajectoryAnalysis == null ||
      clusteringResultIndex == null ||
      cropMergeCanvas.current == null ||
      viewerTrialIds == null ||
      mfpca == null
    ) {
      console.log("RETURN CROP not ready");
      return;
    }
    console.log("RERUNNING CROP MERGE IMAGES");

    const canvas = cropMergeCanvas.current;

    const ctx = canvas.getContext("2d");
    if (!canvas || !ctx) return;

    const newHeatmapImages: typeof heatmapImages = {};

    let modes = isBaseline
      ? ["baseline"]
      : viewerMode === "pass/fail"
        ? ["pass", "fail"]
        : [];
    if (modes.length === 0 && clusterInfo != null) {
      modes = [];
      for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
        if (clusterInfo[egoName] == null) {
          continue;
        }
        for (const label of Object.keys(clusterInfo[egoName])) {
          modes.push(egoName + "_" + label);
        }
      }
    }
    if (modes.length == 0) {
      for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
        modes.push(egoName + "_" + "0");
      }
    }
    console.log(modes);
    const labels = [...modes];

    console.log("loading true 2");
    setLoading(true);

    const cropOneLabel = async (key: string) => {
      const egoName = key.split("_")[0];
      const label = key.split("_")[1];
      const trialIds = viewerTrialIds[egoName][label] ?? [];
      if (trialIds.length === 0) return;

      let trialOrder: string[] = [...(mfpca[egoName].trialOrder ?? [])];

      const trialIdToIndex = Object.fromEntries(
        // @ts-ignore
        trialOrder.map((id, idx) => [id, idx])
      );

      const cropRows = async (
        fullImage: HTMLImageElement,
        out: Record<string, HTMLImageElement>,
        key: string
      ) => {
        const usedIndices = trialIds.map((id) => trialIdToIndex[id]);

        if (fullImage == null) {
          return;
        }

        canvas.width = fullImage.width;
        canvas.height = usedIndices.length * resolution;
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        for (let i = 0; i < usedIndices.length; i++) {
          const y = usedIndices[i] * resolution;
          ctx.drawImage(
            fullImage,
            0,
            y,
            fullImage.width,
            resolution,
            0,
            i * resolution,
            fullImage.width,
            resolution
          );
        }

        const dataUrl = canvas.toDataURL("image/png");
        return loadImageAsync(dataUrl).then((img) => {
          out[key] = img;
        });
      };

      // Crop heatmaps by attribute
      const heatmapTasks = filteredAttributes.map(async (attr) => {
        const key = `${egoName}_${label}_${attr}`;

        // const egoClusteringResultIndex = clusteringResultIndex[egoName];
        // const imageName = `${params["id"]}-TA${trajectoryAnalysis[egoName].id}-clustering${egoClusteringResultIndex}-${key}-${timeOrS}_heatmap`;
        // imageName.includes();
        // const imgInfo = await getDocs<{ docs: Document[] }>("documents", {
        //   where: { filename: { equals: imageName + ".png" } },
        // }).then((response) => response.data.docs[0]);
        // const imgInfo = batchImages?.images?.find((v) =>
        //   v.filename?.includes(imageName)
        // );
        // const viewerSet = new Set(viewerTrialIds[egoName][label]);
        // if (
        //   imgInfo != null &&
        //   imgInfo.url != null &&
        //   clusterInfo != null &&
        //   clusterInfo[egoName] != null &&
        //   viewerSet.size === clusterInfo[egoName][label].count
        // ) {
        //   console.log(
        //     `Batch images already have this crop merged image ${imageName}`
        //   );
        //   const img = document.createElement("img");
        //   img.src = imgInfo.url;
        //   img.crossOrigin = "anonymous";
        //   newHeatmapImages[key] = img;
        //   return;
        // }

        const fullImage = fullHeatmapImages[egoName]?.[attr]?.[0];
        if (!fullImage) return;

        return cropRows(fullImage, newHeatmapImages, key).then((_res) => {
          console.log(`drawed crop merge image ${key}`);
          // uploadImageElement(newHeatmapImages[key], imageName);
        });
      });

      await Promise.all(heatmapTasks);
    };

    const cropMergeImages = async () => {
      for (const label of labels) {
        await cropOneLabel(label);
      }
      setHeatmapImages(newHeatmapImages);
      setLoading(false);
    };
    cropMergeImages();
  }, [
    viewerTrialIds,
    filteredAttributes,
    fullHeatmapImages,
    cropMergeCanvas.current,
  ]);

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      return;
    }
    const newIds = [];
    for (const arrays of Object.values(selected)) {
      for (const item of arrays) {
        newIds.push(...item.trialIds);
      }
    }
    if (newIds.length > 0) {
      dispatch(interactionSlice.actions.record(panelName + ".select"));
    }
    dispatch(
      batchSlice.actions.setSelectedTrialIds({
        by: "heatmap",
        value: newIds,
      })
    );
  }, [selected]);

  useEffect(() => {
    viewersRef.forEach((ref, index) => {
      let targetKey = position.name;
      let [targetEgoName, targetLabel, _targetAttribute] = targetKey.split("_");
      const currentKey = Object.keys(heatmapImages)[index];
      if (currentKey == null) {
        return;
      }
      const [currentEgoName, currentLabel, _currentAttribute] =
        currentKey.split("_");
      const instance = ref.current?.instance;
      if (instance?.transformState) {
        let [x, y] = position.value;

        if (targetLabel != currentLabel || targetEgoName != currentEgoName) {
          y = instance.transformState.positionY;
        }

        ref?.current?.setTransform(x, y, instance.transformState.scale);
      }
    });
  }, [position, viewersRef]);

  const debouncedSetPosition = _.debounce(
    (e: ReactZoomPanPinchRef, name: string) => {
      setPosition({
        value: [e.state.positionX, e.state.positionY],
        name: name,
      });
      dispatch(interactionSlice.actions.record(panelName + ".camera"));
    },
    150
  );

  useEffect(() => {
    const newScaleY: { [key: string]: number } = {};
    for (const key of Object.keys(heatmapImages)) {
      let name = key.split("_")[0] + key.split("_")[1];
      if (name == null || name === "") {
        name = key.split("_")[0] + "-1";
      }
      newScaleY[name] = 1;
    }
    dispatch(batchSlice.actions.setHeatmapLocalScaleY(newScaleY));
  }, [heatmapImages]);

  return (
    <Stack
      ref={containerRef}
      sx={{
        position: "reltive",
        height: "100%",
        overflowY: "hidden",
        overflowX: "hidden",
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
      {loading ? (
        <Stack sx={{ width: "100%", height: "100%", position: "relative" }}>
          <Skeleton
            variant="rectangular"
            sx={{ width: "100%", height: "100%" }}
            animation="wave"
          />
          <CircularProgress
            sx={{
              position: "absolute",
              top: "50%",
              left: "50%",
              color: "text.disabled",
            }}
          />
        </Stack>
      ) : (
        <Stack
          component="div"
          direction="row"
          sx={{
            height: "100%",
            overflowY: "hidden",
            overflowX: "hidden",
          }}
        >
          <Stack sx={{ width: "100%" }} direction="row">
            {filteredAttributes.map((attribute, attributeIndex) => {
              let counter =
                viewerMode === "pass/fail" ? passFailCounter : clusterCounter;
              return (
                <Stack
                  key={`heatmap-${attribute}`}
                  // size={Math.floor((1 / filteredAttributes.length) * 12)}
                  sx={{
                    // height: `calc(98% / ${
                    //   Object.keys(viewerTrialIds ?? {}).length ?? 1
                    // })`,
                    height: "100%",
                    flex: 1,
                    width: `calc(100% / ${filteredAttributes.length})`,
                  }}
                >
                  <Typography
                    fontSize={"20px"}
                    textOverflow="ellipsis"
                    sx={{ textWrap: "nowrap", overflow: "hidden" }}
                  >
                    {toTitleSpaceCase(
                      attribute.includes("EgoOffset")
                        ? "EgoLaneOffset"
                        : attribute.includes("Theta")
                          ? attribute.replace("Theta", "Angle")
                          : attribute
                    )}
                  </Typography>

                  {/* {Object.keys(trajectoryAnalysis ?? {}).map( */}
                  {egos.map((egoName, egoNameIndex) => {
                    let modes = isBaseline
                      ? ["baseline"]
                      : viewerMode === "pass/fail"
                        ? ["pass", "fail"]
                        : clusteringResult == null ||
                          clusteringResult[egoName] == null
                          ? ["0"]
                          : Object.keys(
                            clusterInfo == null || clusterInfo[egoName] == null
                              ? {}
                              : clusterInfo[egoName]
                          );
                    return modes.map((label, labelIndex) => {
                      let color =
                        label === "pass"
                          ? theme.palette.success.light
                          : theme.palette.error.light;
                      if (
                        viewerMode === "interaction-cluster" &&
                        clusterInfo != null &&
                        clusterInfo[egoName] != null
                      ) {
                        color =
                          clusterInfo &&
                            egoName in clusterInfo &&
                            label in clusterInfo[egoName] &&
                            clusterInfo[egoName] != null
                            ? clusterInfo[egoName][label].color
                            : "text.primary";
                      }
                      if (isBaseline || (modes.length === 1 && label === "0")) {
                        color = "black";
                      }
                      const key = `${egoName}_${label}_${attribute}`;
                      const egoLabel = `${egoName}_${label}`;
                      const viewerIndex = Object.keys(
                        heatmapImages ?? {}
                      ).findIndex((k) => k === key);
                      const totalScaleY =
                        userScaleY * (heatmapLocalScaleY[egoName + label] ?? 1);
                      if (viewerIndex === -1) {
                        return null;
                      }
                      return (
                        <Stack
                          key={label}
                          id={`heatmap-${egoName}-${viewerMode}-${label}-${attribute}-canvas-container`}
                          sx={{
                            display:
                              isBaseline ||
                                (!isBaseline &&
                                  counter != null &&
                                  counter[egoName] != null &&
                                  label in (counter[egoName] ?? {}) &&
                                  isClusterVisible(egoName, label))
                                ? "inherit"
                                : "none",
                            flex: 1,
                            position: "relative",
                            overflow: "hidden",
                            background: backgroundColor,
                          }}
                          onDoubleClick={() => {
                            setSelected({});
                            dispatch(
                              interactionSlice.actions.record(
                                panelName + ".deselect"
                              )
                            );
                          }}
                          onWheelCapture={(event) => {
                            const baseSensitivity = 0.0005;
                            if (Input.isKeyPressed("ControlLeft")) {
                              const newScaleY = { ...heatmapLocalScaleY };
                              const delta =
                                baseSensitivity *
                                event.deltaY *
                                newScaleY[egoName + label];
                              const next = newScaleY[egoName + label] + delta;
                              const value = Math.max(next, 0.0001);
                              newScaleY[egoName + label] = value;
                              dispatch(
                                batchSlice.actions.setHeatmapLocalScaleY(
                                  newScaleY
                                )
                              );
                            } else {
                              if (!Input.isKeyPressed("ShiftLeft")) {
                                const delta =
                                  baseSensitivity *
                                  event.deltaY *
                                  heatmapGlobalScaleY;
                                const next = heatmapGlobalScaleY + delta;
                                dispatch(
                                  batchSlice.actions.setHeatmapGlobalScaleY(
                                    Math.max(next, 0.0001)
                                  )
                                );
                                return;
                              }
                              const delta =
                                baseSensitivity *
                                event.deltaY *
                                heatmapGlobalScaleX;
                              const next = heatmapGlobalScaleX + delta;
                              dispatch(
                                batchSlice.actions.setHeatmapGlobalScaleX(
                                  Math.max(next, 0.0001)
                                )
                              );
                            }
                            dispatch(
                              interactionSlice.actions.record(
                                panelName + ".camera"
                              )
                            );
                          }}
                        >
                          <Typography
                            sx={{
                              position: "absolute",
                              fontWeight: 500,
                              top: 0,
                              left: "5px",
                              color: "black",
                              zIndex: 100,
                            }}
                          >
                            {labelIndex === 0 && attributeIndex === 0}
                            {/* {attributeIndex === 0 ? egoName : ""} */}
                          </Typography>
                          {heatmapImages != null && key in heatmapImages ? (
                            <TransformWrapper
                              minScale={1}
                              maxScale={1}
                              limitToBounds={false}
                              ref={viewersRef[viewerIndex]}
                              initialPositionX={40}
                              initialPositionY={30}
                              panning={{ velocityDisabled: true }}
                              wheel={{ disabled: true }}
                              onPanning={(e) => debouncedSetPosition(e, key)}
                            >
                              <TransformComponent
                                wrapperStyle={{
                                  width: "100%",
                                  height: "100%",
                                }}
                              >
                                <Stack
                                  component="div"
                                  sx={{
                                    transform: `scale(${userScaleX}, ${totalScaleY})`,
                                    transformOrigin: "top left",
                                    position: "relative",
                                  }}
                                  onMouseLeave={() => {
                                    setHoverInfo(null);
                                  }}
                                  onMouseMove={(event) => {
                                    const rect =
                                      event.currentTarget.getBoundingClientRect();
                                    // const x = event.clientX - rect.left;
                                    const y = event.clientY - rect.top;

                                    if (
                                      viewerTrialIds == null ||
                                      !(label in viewerTrialIds[egoName])
                                    ) {
                                      return;
                                    }
                                    const index = Math.floor(
                                      y / resolution / totalScaleY
                                    );
                                    if (
                                      index >=
                                      viewerTrialIds[egoName][label].length ||
                                      index < 0
                                    ) {
                                      setHoverInfo(null);
                                      return;
                                    }
                                    const trialId =
                                      viewerTrialIds[egoName][label][index];
                                    setHoverInfo({
                                      y,
                                      trialId,
                                      index,
                                      label,
                                    });
                                  }}
                                  onClick={() => {
                                    if (
                                      hoverInfo == null ||
                                      viewerTrialIds == null
                                    ) {
                                      return;
                                    }
                                    // dispatch(
                                    //   interactionSlice.actions.record(
                                    //     panelName + ".select"
                                    //   )
                                    // );
                                    setSelected((prev) => {
                                      const newSelected = _.cloneDeep(prev);
                                      if (!(egoLabel in newSelected)) {
                                        newSelected[egoLabel] = [];
                                      }
                                      let viewerSelected =
                                        newSelected[egoLabel];
                                      const prevSelected =
                                        viewerSelected[
                                        viewerSelected.length - 1
                                        ];
                                      if (newSelected[egoLabel].length === 0) {
                                        newSelected[egoLabel].push({
                                          trialIds: [hoverInfo.trialId],
                                          range: [hoverInfo.index],
                                        });
                                        console.log(newSelected);
                                        return newSelected;
                                      } else {
                                        let isSelectedBefore = false;
                                        for (const item of newSelected[
                                          egoLabel
                                        ]) {
                                          if (
                                            hoverInfo.index >= item.range[0] &&
                                            hoverInfo.index <= item.range[1]
                                          ) {
                                            isSelectedBefore = true;
                                            break;
                                          }
                                        }
                                        if (isSelectedBefore) {
                                          return prev;
                                        }
                                        const prevSelected =
                                          newSelected[egoLabel][
                                          newSelected[egoLabel].length - 1
                                          ];
                                        if (
                                          // false &&
                                          Input.isKeyPressed("ShiftLeft") &&
                                          prevSelected.range.length == 1 &&
                                          hoverInfo.index >
                                          prevSelected.range[0]
                                        ) {
                                          const newRange = [
                                            prevSelected.range[0],
                                            hoverInfo.index,
                                          ];
                                          // check if range intersected with previous
                                          // selections, if yes abort
                                          for (const item of newSelected[
                                            egoLabel
                                          ]) {
                                            if (item.range.length > 1) {
                                              let rangeIntersected =
                                                Math.max(
                                                  item.range[0],
                                                  newRange[0]
                                                ) <=
                                                Math.min(
                                                  item.range[1],
                                                  newRange[1]
                                                );
                                              if (rangeIntersected) {
                                                return prev;
                                              }
                                            }
                                          }
                                          prevSelected.range = newRange;
                                          let newSelectedIds = viewerTrialIds[
                                            egoName
                                          ][label].slice(
                                            newRange[0],
                                            newRange[1]
                                          );
                                          prevSelected.trialIds =
                                            newSelectedIds;

                                          return newSelected;
                                        } else {
                                          newSelected[egoLabel].push({
                                            trialIds: [hoverInfo.trialId],
                                            range: [hoverInfo.index],
                                          });
                                        }
                                        return newSelected;
                                      }
                                    });
                                  }}
                                  onDoubleClick={() => {
                                    // setSelected({});
                                    // dispatch(
                                    //   interactionSlice.actions.record(
                                    //     panelName + ".deselect"
                                    //   )
                                    // );
                                  }}
                                >
                                  <Box
                                    component="div"
                                    sx={{
                                      position: "absolute",
                                      borderTopWidth: `${borderWidth / totalScaleY
                                        }px`,
                                      borderBottomWidth: `${borderWidth / totalScaleY
                                        }px`,
                                      borderRightWidth: `${borderWidth / userScaleX
                                        }px`,
                                      borderLeftWidth: `${borderWidth / userScaleX
                                        }px`,
                                      borderStyle: "solid",
                                      borderColor: "#bbb",
                                      width: "100%",
                                      height: `${resolution}px`,
                                      top: `calc(${(hoverInfo?.index ?? 0) * resolution
                                        }px - 0.5px)`,
                                      left: "-0.5px",
                                      display:
                                        hoverInfo == null ||
                                          hoverInfo.label !== label
                                          ? "none"
                                          : "inherit",
                                    }}
                                  />
                                  <Box
                                    component="div"
                                    className="timer_indicator"
                                    sx={{
                                      position: "absolute",
                                      borderTopWidth: `${borderWidth / totalScaleY
                                        }px`,
                                      borderBottomWidth: `${borderWidth / totalScaleY
                                        }px`,
                                      borderRightWidth: `${borderWidth / userScaleX
                                        }px`,
                                      borderLeftWidth: `${borderWidth / userScaleX
                                        }px`,
                                      borderStyle: "solid",
                                      borderColor: "#bbb",
                                      borderWidth: `${2 / userScaleX}px`,
                                      width: `${resolution}px`,
                                      height: "100%",
                                      top: `-0.5px`,
                                      left: `calc(${timeOrS === "time"
                                          ? ((timer ?? 0) /
                                            (framePeriod ?? 1)) *
                                          resolution
                                          : (globalStroage.sRatio ?? 0) *
                                          fullImageWidth
                                        }px - 0.5px)`,
                                    }}
                                  />
                                  <Box
                                    component="div"
                                    sx={{
                                      position: "absolute",
                                      backgroundColor: "#555",
                                      filter: "invert(100%)",
                                      width: `${3 / resolution}px`,
                                      height: "100%",
                                      top: `-0.5px`,
                                      left: `calc(${
                                        // ((5 + (trajectoryAnalysis?.request.framePeriod ?? 1)) /
                                        (5 / (framePeriod ?? 1)) * resolution
                                        }px - 1px)`,
                                      display:
                                        durationMode == "full" ||
                                          showFullTimeline
                                          ? "none"
                                          : "inherit",
                                    }}
                                  />
                                  {selected && egoLabel in selected
                                    ? selected[egoLabel].map((item, index) => {
                                      return (
                                        <Box
                                          key={index}
                                          component="div"
                                          className="selected_indicator"
                                          sx={{
                                            position: "absolute",
                                            width: "100%",
                                            height: `${resolution *
                                              (item.range[1] == null
                                                ? 1
                                                : item.range[1] -
                                                item.range[0] +
                                                1)
                                              }px`,
                                            // height: `${resolution *
                                            //   (item.range[1] == null
                                            //     ? 1
                                            //     : item.range[1] -
                                            //     item.range[0] +
                                            //     1)
                                            //   }px`,
                                            top: `calc(${(item.range[0] ?? 0) *
                                              resolution
                                              }px - 0.5px)`,
                                            left: "-0.5px",
                                            borderTopWidth: `${borderWidth / totalScaleY
                                              }px`,
                                            borderBottomWidth: `${borderWidth / totalScaleY
                                              }px`,
                                            borderRightWidth: `${borderWidth / userScaleX
                                              }px`,
                                            borderLeftWidth: `${borderWidth / userScaleX
                                              }px`,
                                            borderStyle: "solid",
                                            borderColor: "yellow",
                                          }}
                                        />
                                      );
                                    })
                                    : null}
                                  <img
                                    key={`heatmap-${key}`}
                                    src={heatmapImages[key].src}
                                    style={{
                                      imageRendering: "crisp-edges",
                                    }}
                                  />
                                </Stack>
                              </TransformComponent>
                            </TransformWrapper>
                          ) : null}
                          <Stack
                            sx={{
                              border: `solid ${windowBorder}px ${color}`,
                              width: `calc(100% - ${attributeIndex === filteredAttributes.length - 1
                                  ? 2 * windowBorder
                                  : windowBorder
                                }px + 1px)`,
                              height: `calc(100% - ${2 * windowBorder
                                }px + 1px)`,
                              borderRightStyle:
                                attributeIndex === filteredAttributes.length - 1
                                  ? "solid"
                                  : "none",
                              // boxShadow: `inset 0px 0px 0px 10px ${color}`,
                              zIndex: 10,
                              position: "absolute",
                              top: 0,
                              left: 0,
                              pointerEvents: "none",
                            }}
                          ></Stack>
                        </Stack>
                      );
                    });
                  })}
                </Stack>
              );
            })}
          </Stack>
        </Stack>
      )}
      <canvas ref={canvasRef} width={1000} style={{ display: "none" }} />
      <canvas
        ref={cropMergeCanvas}
        width={1000}
        height={1000}
        style={{ display: "none" }}
      />
    </Stack>
  );
}
