import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import {
  Box,
  Stack,
  Button,
  IconButton,
  Menu,
  ToggleButtonGroup,
  ToggleButton,
  FormControlLabel,
  Checkbox,
  Typography,
  Slider,
} from "@mui/material";
import SettingsIcon from "@mui/icons-material/Settings";
import { useTheme } from "@mui/material/styles";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import _ from "lodash";
import {
  // getSelectedBoundaryDiffClusterInfo,
  // getSelectedBoundaryDiffClusteringResult,
  // getSelectedClusterInfo,
  // Point,
  // getSelectedClusterInfo,
  // getSelectedClusterResult,
  // getSelectedClusteringResult,
  sessionSlice,
} from "src/redux/slices/session";
import chroma from "chroma-js";
import { Group } from "@visx/group";
import { Circle } from "@visx/shape";
import { scaleLinear } from "@visx/scale";
import { localPoint } from "@visx/event";
import { kdTree } from "kd-tree-javascript";
import { Legend } from "./Legend";
import { Zoom } from "@visx/zoom";
import { RectClipPath } from "@visx/clip-path";
import { getSuperPoints } from "src/api/services/Clustering";
import { getCriticalityMetricColor } from "src/utils";
import { useKpis } from "src/api/services/KeyPerformanceIndicators";
import { toast } from "react-toastify";

export type Point = {
  x: number;
  y: number;
  trialId: string;
  clusterLabel: string;
  color: string;
  originalColor: string;
  disable: boolean;
  passed: boolean;
  radius: number;
};

const initialTransform = {
  scaleX: 1.0,
  scaleY: 1.0,
  translateX: 0,
  translateY: 0,
  skewX: 0,
  skewY: 0,
};

export const colorModes = ["clustering", "criticalityMetric"] as const;
export type ColorMode = (typeof colorModes)[number];

function distance(a: Point, b: Point) {
  return Math.sqrt(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2));
}

type Props = {
  isBoundaryDiffMode?: boolean;
};
export default ({ isBoundaryDiffMode }: Props) => {
  const theme = useTheme();
  const containerRef = useRef<HTMLDivElement>(null);
  const svgRef = useRef<SVGSVGElement>(null);

  const dispatch = useAppDispatch();

  const hoveredTrialId = useAppSelector(
    (state) => state.session.hoveredTrialId,
  );
  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const selectedClusteringResultIndex = useAppSelector(
    (state) => state.session.selectedClusteringResultIndex,
  );
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedCluster,
  );
  const selectedBoundarySafeCluster = useAppSelector(
    (state) => state.session.selectedBoundarySafeCluster,
  );
  const selectedBoundarySafeClusterTrialIds = useAppSelector(
    (state) => state.session.selectedBoundarySafeClusterTrialIds,
  );
  const clusteringResult = useAppSelector(getSelectedClusteringResult);
  const clusteringResultIndex = useAppSelector(
    (state) => state.session.selectedClusteringResultIndex,
  );
  const clusterInfo = useAppSelector(getSelectedClusterInfo);
  const boundaryDiffClusterInfo = useAppSelector(
    getSelectedBoundaryDiffClusterInfo,
  );
  const boundaryDiffClusteringResult = useAppSelector(
    getSelectedBoundaryDiffClusteringResult,
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

  // const highlightedTrialIds = useAppSelector(
  //   (state) => state.session.highlightedTrialIds,
  // );
  // const blackedOutTrialIds = useAppSelector(
  //   (state) => state.session.blackedOutTrialIds,
  // );
  // const batchTrialMappings = useAppSelector(
  //   (state) => state.session.batchTrialMappings,
  // );

  // const boundaryPair = useAppSelector((state) => state.session.boundaryPair);
  // const passedFailedPair = useAppSelector(
  //   (state) => state.session.passedFailedPair,
  // );
  // const failedClusterPassedIds = useAppSelector(
  //   (state) => state.session.failedClusterPassedIds,
  // );
  // const selectedBoundarySafeCluster = useAppSelector(
  //   (state) => state.session.selectedBoundarySafeCluster,
  // );
  // const selectedBoundarySafeClusterTrialIds = useAppSelector(
  //   (state) => state.session.selectedBoundarySafeClusterTrialIds,
  // );

  // const trials = useAppSelector((state) => state.session.trialMappings);
  // const trialClusterMappings = useAppSelector(
  //   (state) => state.session.trialClusterMappings,
  // );
  // const umap = useAppSelector((state) => state.session.umap);
  // const previewImages = useAppSelector((state) => state.session.previewImages);

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const open = Boolean(anchorEl);
  const handleSettingClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleSettingClose = () => {
    setAnchorEl(null);
  };

  const [colorMode, setColorMode] = useState<ColorMode>("clustering");
  const [boundaryPairMode, setBoundaryPairMode] = useState(true);

  const [superpoints, setSuperpoints] = useState<{
    [trialId: string]: string[];
  }>({});
  const [showSuperpoints, setShowSuperPoints] = useState(false);
  const [superpointRatio, setSuperpointRatio] = useState(0.01);

  const [dimension, setDimension] = useState<{ width: number; height: number }>(
    { width: 0, height: 0 },
  );
  const [nearest, setNearest] = useState<Point | undefined>();

  const padding = 20;

  const failureScales = useMemo(() => {
    let values = Object.values(
      clusteringResponse?.umapProjections[0].data ?? {},
    );

    const xx = values.map((item, _index) => item[0]) ?? [];
    const minX = Math.min(...xx);
    const maxX = Math.max(...xx);
    const x = scaleLinear<number>({
      domain: [minX, maxX],
      range: [0 + padding, dimension.width - padding],
      clamp: true,
    });

    const yy = values.map((item, _index) => item[1]) ?? [];
    const minY = Math.min(...yy);
    const maxY = Math.max(...yy);
    const y = scaleLinear<number>({
      domain: [minY, maxY],
      range: [dimension.height - padding, 0 + padding],
      clamp: true,
    });

    return {
      x,
      y,
    };
  }, [dimension, clusteringResponse]);

  const boundaryDiffScales = useMemo(() => {
    if (
      selectedCluster == null ||
      clusteringResultIndex === null ||
      boundaryDiffClusteringResult === null
    ) {
      console.log(selectedCluster);
      console.log(clusteringResultIndex);
      console.log(boundaryDiffClusteringResult);
      return null;
    }
    const boundaryDiffUmap =
      clusteringResponse?.boundaryDiffs[clusteringResultIndex].umapProjections[
        selectedCluster
      ];
    if (!boundaryDiffUmap || boundaryDiffUmap.length === 0) {
      console.log(boundaryDiffUmap);
      return null;
    }

    const values = Object.values(boundaryDiffUmap[0].data ?? {});

    const xx = values.map((item, _index) => item[0]) ?? [];
    const minX = Math.min(...xx);
    const maxX = Math.max(...xx);
    const x = scaleLinear<number>({
      domain: [minX, maxX],
      range: [0 + padding, dimension.width - padding],
      clamp: true,
    });

    const yy = values.map((item, _index) => item[1]) ?? [];
    const minY = Math.min(...yy);
    const maxY = Math.max(...yy);
    const y = scaleLinear<number>({
      domain: [minY, maxY],
      range: [dimension.height - padding, 0 + padding],
      clamp: true,
    });

    return {
      x,
      y,
    };
  }, [dimension, clusteringResponse, clusteringResultIndex, selectedCluster]);

  const scales = isBoundaryDiffMode ? boundaryDiffScales : failureScales;

  const disabledColor = chroma(theme.palette.divider).hex();

  const failurePoints: Point[] = useMemo(() => {
    if (scales == null) {
      return [];
    }

    let entries = Object.entries(clusteringResult?.data ?? {});
    let umapProjection = clusteringResponse?.umapProjections[0].data;

    return (
      entries
        // .filter(
        //   ([_i, item]) => item.trialId in trials,
        //   // item.trialId in trials &&
        //   // ((showSuperpoints &&
        //   //   Object.keys(superpoints).length > 0 &&
        //   //   item.trialId in superpoints) ||
        //   //   Object.keys(superpoints).length === 0 ||
        //   //   !showSuperpoints ||
        //   //   !superpoints),
        // )
        .map(([i, item]) => {
          let radius = 5;

          let clusterColor = theme.palette.divider;

          if (clusterInfo && clusterInfo[item.label]) {
            clusterColor = clusterInfo[item.label].color;
          }

          // if (
          //   showSuperpoints &&
          //   superpoints &&
          //   Object.keys(superpoints).length > 0
          // ) {
          //   const memberCount = Object.keys(superpoints[item.trialId]).length;
          //   radius = Math.max(Math.ceil(5 * (memberCount / 30)), 5);
          // }

          let originalColor = chroma(clusterColor).alpha(0.5).hex();
          let color = originalColor;
          let disable = false;

          const trial = clusteringResponse?.trials[item.trialId];
          const passed =
            item.trialId in (clusteringResponse?.boundaryPairs.passed ?? {});

          if (selectedKpi && trial && clusteringResult && selectedCluster) {
            originalColor = getCriticalityMetricColor(
              trial,
              selectedKpi,
              theme,
            );
            originalColor = chroma(originalColor).alpha(0.5).hex();
            color = originalColor;

            if (item.label != selectedCluster && !passed) {
              color = disabledColor;
              disable = true;
            }

            if (passed) {
              const failedPairTrialId =
                clusteringResponse.boundaryPairs.passed[item.trialId];
              color =
                clusteringResult.data[failedPairTrialId].label ===
                selectedCluster
                  ? originalColor
                  : "transparent";

              if (color === "transparent") {
                color = disabledColor;
                disable = true;
              } else if (
                selectedBoundarySafeCluster &&
                item.label !== selectedBoundarySafeCluster
              ) {
                color = disabledColor;
                disable = true;
              }
            }

            if (
              !disable &&
              !passed &&
              item.label === selectedCluster &&
              selectedBoundarySafeCluster
            ) {
              let found = false;
              for (const passedId of selectedBoundarySafeClusterTrialIds[
                selectedBoundarySafeCluster
              ]) {
                const failedId =
                  clusteringResponse.boundaryPairs.passed[passedId];
                found = item.trialId === failedId;
                if (found) {
                  break;
                }
              }
              if (!found) {
                color = disabledColor;
                disable = true;
              }
            }
          }

          if (passed && !selectedCluster) {
            // color = disabledColor;
            color = "transparent";
            disable = true;
          }

          // if (
          //   highlightedTrialIds.size > 0 &&
          //   !highlightedTrialIds.has(item.trialId)
          // ) {
          //   color = chroma(color).alpha(0.1).hex();
          // }

          return {
            x: scales.x(umapProjection ? umapProjection[item.trialId][0] : 0),
            y: scales.y(umapProjection ? umapProjection[item.trialId][1] : 0),
            trialId: item.trialId,
            clusterLabel: item.label,
            color,
            originalColor,
            disable,
            passed,
            index: i,
            radius,
          };
        })
    );
  }, [
    failureScales,
    // yScale,
    selectedKpi,
    superpoints,
    // umap,
    // highlightedTrialIds,
    // blackedOutTrialIds,
    // viewProbability,
    // viewInverted,
    // batchTrialMappings,
    selectedCluster,
    clusteringResultIndex,
    selectedBoundarySafeCluster,
    selectedBoundarySafeClusterTrialIds,
    // trials,
    // passedFailedPair,
    // failedClusterPassedIds,
    // selectedBoundarySafeCluster,
    // selectedBoundarySafeClusterTrialIds,
  ]);

  const boundaryDiffPoints: Point[] = useMemo(() => {
    const scales = boundaryDiffScales;

    if (
      scales == null ||
      selectedCluster == null ||
      clusteringResultIndex == null
    ) {
      console.log(scales);
      console.log(selectedCluster);
      console.log(clusteringResultIndex);
      return [];
    }
    const umapProjections =
      clusteringResponse?.boundaryDiffs[clusteringResultIndex].umapProjections;
    if (!umapProjections || !umapProjections[selectedCluster]) {
      console.log(umapProjections);
      console.log(umapProjections[selectedCluster]);
      return [];
    }
    const umapProjection =
      umapProjections[selectedCluster] &&
      umapProjections[selectedCluster].length > 0 &&
      umapProjections[selectedCluster][0]
        ? umapProjections[selectedCluster][0].data
        : undefined;
    if (!umapProjection) {
      console.log(umapProjection);
      return [];
    }

    return (
      Object.entries(boundaryDiffClusteringResult?.data ?? {})
        // .filter(
        //   ([_i, item]) => item.trialId in trials,
        //   // item.trialId in trials &&
        //   // ((showSuperpoints &&
        //   //   Object.keys(superpoints).length > 0 &&
        //   //   item.trialId in superpoints) ||
        //   //   Object.keys(superpoints).length === 0 ||
        //   //   !showSuperpoints ||
        //   //   !superpoints),
        // )
        .map(([i, item]) => {
          let radius = 5;

          let clusterColor = theme.palette.divider;

          if (boundaryDiffClusterInfo && boundaryDiffClusterInfo[item.label]) {
            clusterColor = boundaryDiffClusterInfo[item.label].color;
          }

          let originalColor = chroma(clusterColor).alpha(0.5).hex();
          let color = originalColor;
          let disable = false;
          const passed =
            item.trialId in (clusteringResponse?.boundaryPairs.passed ?? {});

          return {
            x: scales.x(umapProjection ? umapProjection[item.trialId][0] : 0),
            y: scales.y(umapProjection ? umapProjection[item.trialId][1] : 0),
            trialId: item.trialId,
            clusterLabel: item.label,
            color,
            originalColor,
            disable,
            passed,
            index: i,
            radius,
          };
        })
    );
  }, [boundaryDiffScales, boundaryDiffClusterInfo]);

  const points = isBoundaryDiffMode ? boundaryDiffPoints : failurePoints;

  const failureTree = useMemo(() => {
    return new kdTree(
      failurePoints.filter((point) => !point.disable),
      distance,
      ["x", "y"],
    );
  }, [failurePoints]);
  const boundaryDiffTree = useMemo(() => {
    return new kdTree(
      boundaryDiffPoints.filter((point) => !point.disable),
      distance,
      ["x", "y"],
    );
  }, [boundaryDiffPoints]);
  const tree = isBoundaryDiffMode ? boundaryDiffTree : failureTree;

  const resizeObserver = useMemo(
    () =>
      new ResizeObserver((entries) => {
        for (let entry of entries) {
          entry.target.dispatchEvent(new Event("resize"));
          const { width, height } = entry.contentRect;
          setDimension({ width, height });
        }
      }),
    [],
  );

  // useEffect(() => {
  //   const updated: { [trialId: string]: Point } = {};
  //   for (const point of points) {
  //     updated[point.trialId] = point;
  //   }
  //   // dispatch(sessionSlice.actions.setPoints(updated));
  // }, [points]);

  useEffect(() => {
    if (!containerRef.current) {
      return;
    }
    resizeObserver.observe(containerRef.current);
    const { width, height } = containerRef.current.getBoundingClientRect();
    setDimension({ width, height });
    return () => {
      if (!containerRef.current) {
        return;
      }
      resizeObserver.unobserve(containerRef.current);
    };
  }, [containerRef.current]);

  useEffect(() => {
    if (!nearest) {
      dispatch(sessionSlice.actions.setHoveredTrialId(null));
      return;
    }
    dispatch(sessionSlice.actions.setHoveredTrialId(nearest.trialId));
  }, [nearest]);

  // useEffect(() => {
  //   if (!clusterResult) {
  //     return;
  //   }
  //   const updated: { [clusterLabel: string]: Set<string> } = {};
  //   for (const clusterItem of clusterResult.data) {
  //     if (clusterItem.trialId in failedPassedPair) {
  //       if (!(clusterItem.label in updated)) {
  //         updated[clusterItem.label] = new Set<string>();
  //       }
  //       updated[clusterItem.label].add(failedPassedPair[clusterItem.trialId]);
  //     }
  //   }
  //   dispatch(sessionSlice.actions.setFailedClusterPassedId(updated));
  // }, [clusterResult, failedPassedPair]);

  useEffect(() => {
    if (!clusteringResult) {
      return;
    }
    const updated: { [clusterLabel: string]: Set<string> } = {};
    Object.entries(clusteringResult.data ?? {})
      .filter(
        ([_i, item]) => item.trialId in (clusteringResponse?.trials ?? {}),
      )
      .forEach(([_i, item]) => {
        const passed =
          item.trialId in (clusteringResponse?.boundaryPairs.passed ?? {});
        const failedPair =
          clusteringResponse?.boundaryPairs.passed[item.trialId];
        if (passed && failedPair) {
          const isSafeBoundary =
            clusteringResult.data[failedPair].label === selectedCluster;
          if (isSafeBoundary) {
            if (!(item.label in updated)) {
              updated[item.label] = new Set<string>();
            }
            updated[item.label].add(item.trialId);
          }
        }
      });
    dispatch(
      sessionSlice.actions.setSelectedBoundarySafeClusterTrialIds(updated),
    );
  }, [clusteringResult, selectedCluster]);

  const imageSize = 50;
  const zoomScale = (value: number) => Math.exp(-0.05 * value);

  // useEffect(() => {
  //   if (!clusterResult) {
  //     return;
  //   }
  //   getSuperPoints({
  //     clusterResult,
  //     representations,
  //     ratio: superpointRatio,
  //   }).then((response) => setSuperpoints(response.data));
  // }, [superpointRatio, clusterResult, representations]);

  return (
    <Stack
      ref={containerRef}
      sx={{ width: "100%", height: "100%" }}
      onClick={() => {
        // if (nearest) {
        //   return;
        // }
        // dispatch(sessionSlice.actions.setBlackedOutTrialIds(new Set<string>()));
        // dispatch(
        //   sessionSlice.actions.setHighlightedTrialIds(new Set<string>()),
        // );
        if (!nearest) {
          dispatch(sessionSlice.actions.setSelectedTrialId(null));
          // dispatch(
          //   sessionSlice.actions.setHighlightedTrialIds(new Set<string>()),
          // );
          return;
        }
        dispatch(sessionSlice.actions.setSelectedTrialId(nearest.trialId));
      }}
    >
      <Stack
        sx={{
          position: "absolute",
          zIndex: 100,
          p: 1,
        }}
      >
        <Legend isBoundaryDiffMode={isBoundaryDiffMode} />
        {/* <Slider */}
        {/*   marks */}
        {/*   size="small" */}
        {/*   valueLabelDisplay="auto" */}
        {/*   value={superpointRatio} */}
        {/*   onChange={(_event, value) => setSuperpointRatio(value as number)} */}
        {/*   shiftStep={0.03} */}
        {/*   step={0.01} */}
        {/*   min={0} */}
        {/*   max={0.1} */}
        {/* /> */}
      </Stack>
      <Box
        component="div"
        sx={{ position: "absolute", right: 10, top: 10, zIndex: 1000 }}
      >
        <Menu
          elevation={1}
          anchorEl={anchorEl}
          open={open}
          onClose={handleSettingClose}
          MenuListProps={{
            "aria-labelledby": "basic-button",
          }}
          sx={{
            ".MuiList-root": {
              p: 1,
              m: 0,
              display: "flex",
              flexDirection: "column",
              rowGap: 1,
            },
          }}
        >
          <ToggleButtonGroup
            color="primary"
            exclusive
            value={colorMode}
            onChange={(
              _event: React.MouseEvent<HTMLElement>,
              newColorMode: typeof colorMode,
            ) => {
              setColorMode(newColorMode);
            }}
          >
            <ToggleButton value="clustering">Clustering</ToggleButton>
            <ToggleButton value="criticalityMetric">
              Criticality Metric
            </ToggleButton>
          </ToggleButtonGroup>
          <FormControlLabel
            control={
              <Checkbox
                checked={boundaryPairMode}
                onChange={(_event, value) => setBoundaryPairMode(value)}
              />
            }
            label="view boundary pair"
          />
        </Menu>
      </Box>
      {/* <Box */}
      {/*   component="div" */}
      {/*   sx={{ position: "absolute", right: 20, top: 20, zIndex: 1000 }} */}
      {/* > */}
      {/*   <Button */}
      {/*     onClick={() => { */}
      {/*       if (!clusteringResult) { */}
      {/*         return; */}
      {/*       } */}
      {/*       // getSuperPoints({ */}
      {/*       //   clusterResult, */}
      {/*       //   representations, */}
      {/*       //   ratio: 0.02, */}
      {/*       // }).then((response) => setSuperpoints(response.data)); */}
      {/*     }} */}
      {/*   > */}
      {/*     Get Superpoints */}
      {/*   </Button> */}
      {/*   <Checkbox */}
      {/*     value={showSuperpoints} */}
      {/*     onChange={(event, checked) => setShowSuperPoints(checked)} */}
      {/*   ></Checkbox> */}
      {/* </Box> */}
      <Zoom<SVGSVGElement>
        width={dimension.width}
        height={dimension.height}
        scaleXMin={1 / 5}
        scaleXMax={10}
        scaleYMin={1 / 5}
        scaleYMax={10}
        initialTransformMatrix={initialTransform}
      >
        {(zoom) => (
          <Box component="div" sx={{ position: "relative" }}>
            <svg width={dimension.width} height={dimension.height} ref={svgRef}>
              <RectClipPath
                id="zoom-clip"
                width={dimension.width}
                height={dimension.height}
              />
              <Group pointerEvents="none" transform={zoom.toString()}>
                {points
                  ?.sort(
                    (a, b) =>
                      Number(
                        a.trialId === selectedTrialId,
                        // a.trialId === boundaryPair,
                      ) -
                      Number(
                        b.trialId === selectedTrialId,
                        // b.trialId === boundaryPair,
                      ),
                  )
                  .map((point, i) => {
                    const radius = point.radius / zoom.transformMatrix.scaleX;
                    const strokeWidth = 3 / zoom.transformMatrix.scaleX;
                    return (
                      <>
                        <Circle
                          key={i}
                          className="dot"
                          cx={point.x}
                          cy={point.y}
                          r={
                            radius
                            // point.trialId === hoveredTrialId ||
                            //   (point.trialId === boundaryPair &&
                            //     selectedCluster &&
                            //     hoveredTrialId &&
                            //     hoveredTrialId in passedFailedPair)
                            //   ? radius * 2
                            //   : radius
                          }
                          fill={point.color}
                          stroke={
                            point.trialId === hoveredTrialId ||
                            (!hoveredTrialId &&
                              point.trialId === selectedTrialId) ||
                            (selectedCluster &&
                              hoveredTrialId &&
                              hoveredTrialId in
                                (clusteringResponse?.boundaryPairs.passed ??
                                  {}) &&
                              point.trialId ===
                                clusteringResponse?.boundaryPairs.passed[
                                  hoveredTrialId
                                ])
                              ? // (!boundaryPair &&
                                //   point.trialId === focusedBoundaryPair &&
                                //   selectedCluster &&
                                //   focusedTrialId &&
                                //   focusedTrialId in passedFailedPair)
                                theme.palette.text.primary
                              : "transparent"
                          }
                          strokeWidth={strokeWidth}
                        />
                      </>
                    );
                  })}
                {points?.map((point, i) => (
                  <>
                    {showSuperpoints &&
                    point.trialId in superpoints &&
                    !point.disable ? (
                      <>
                        <rect
                          fill={theme.palette.background.default}
                          opacity={0.3}
                          stroke={theme.palette.text.disabled}
                          strokeWidth={2 / zoom.transformMatrix.scaleX}
                          x={
                            point.x -
                            imageSize /
                              zoomScale(zoom.transformMatrix.scaleX) /
                              2
                          }
                          y={
                            point.y -
                            imageSize /
                              zoomScale(zoom.transformMatrix.scaleY) /
                              2
                          }
                          height={
                            imageSize / zoomScale(zoom.transformMatrix.scaleY)
                          }
                          width={
                            imageSize / zoomScale(zoom.transformMatrix.scaleX)
                          }
                        />
                        <image
                          key={i}
                          href={
                            ""
                            // point.trialId in previewImages
                            //   ? previewImages[point.trialId].url
                            //   : ""
                          }
                          x={
                            point.x -
                            imageSize /
                              zoomScale(zoom.transformMatrix.scaleX) /
                              2
                          }
                          y={
                            point.y -
                            imageSize /
                              zoomScale(zoom.transformMatrix.scaleY) /
                              2
                          }
                          height={
                            imageSize / zoomScale(zoom.transformMatrix.scaleY)
                          }
                          width={
                            imageSize / zoomScale(zoom.transformMatrix.scaleX)
                          }
                        />
                      </>
                    ) : null}
                  </>
                ))}
              </Group>
              <rect
                width={dimension.width}
                height={dimension.height}
                rx={14}
                fill="transparent"
                onTouchStart={zoom.dragStart}
                onTouchMove={zoom.dragMove}
                onTouchEnd={zoom.dragEnd}
                onMouseDown={zoom.dragStart}
                onMouseMove={(event) => {
                  zoom.dragMove(event);
                  if (!svgRef.current || !tree) {
                    return;
                  }
                  const point = localPoint(svgRef.current, event);
                  if (!point) {
                    return;
                  }
                  const { translateX, translateY, scaleX, scaleY } =
                    zoom.transformMatrix;
                  const neighborRadius = 15;
                  const query = {
                    x: (point.x - translateX) / scaleX,
                    y: (point.y - translateY) / scaleY,
                    index: -1,
                    color: "",
                    trialId: "",
                  };
                  const nearests = tree.nearest(query, 1, neighborRadius);
                  if (nearests.length > 0) {
                    setNearest(nearests[0][0]);
                    dispatch(
                      sessionSlice.actions.setHoveredTrialId(
                        nearests[0][0].trialId,
                      ),
                    );
                  } else {
                    setNearest(undefined);
                  }
                }}
                onMouseUp={zoom.dragEnd}
                onMouseLeave={() => {
                  if (zoom.isDragging) zoom.dragEnd();
                }}
                onDoubleClick={(event) => {
                  const point = localPoint(event) || { x: 0, y: 0 };
                  zoom.scale({ scaleX: 1.1, scaleY: 1.1, point });
                }}
                onWheel={(event) => {
                  const point = localPoint(event) || { x: 0, y: 0 };
                  const scaleFactor = event.deltaY < 0 ? 1.1 : 0.9;
                  zoom.scale({
                    scaleX: scaleFactor,
                    scaleY: scaleFactor,
                    point,
                  });
                }}
              />
            </svg>
          </Box>
        )}
      </Zoom>
    </Stack>
  );
};
