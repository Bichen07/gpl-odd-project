import { format } from "@visx/vendor/d3-format";
import {
  scaleLinear,
  scaleOrdinal,
  scaleThreshold,
  scaleQuantile,
} from "@visx/scale";
import {
  // Legend,
  LegendLinear,
  LegendQuantile,
  LegendOrdinal,
  LegendSize,
  LegendThreshold,
  LegendItem,
  LegendLabel,
} from "@visx/legend";
import { Box, Slider, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { useTheme } from "@mui/material/styles";
import { useMemo } from "react";
import chroma from "chroma-js";
import { ColorMode } from "..";
import {
  // getSelectedBoundaryDiffClusterInfo,
  // getSelectedClusterInfo,
  // getSelectedClusteringResult,
  sessionSlice,
} from "src/redux/slices/session";
import { useKpis } from "src/api/services/KeyPerformanceIndicators";

type Props = {
  sx?: SxProps;
  clusterCounts?: {
    passed: { [clusterLabel: string]: Set<string> };
    failed: { [clusterLabel: string]: Set<string> };
  };
  isBoundaryDiffMode?: boolean;
};
export function Legend({ sx, clusterCounts, isBoundaryDiffMode }: Props) {
  const theme = useTheme();
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
  const clusteringResult = useAppSelector(getSelectedClusteringResult);
  const failedClusterTrialIds = useAppSelector(
    (state) => state.session.failedClusterTrialIds,
  );
  const clusterInfo = useAppSelector(getSelectedClusterInfo);
  const boundaryDiffClusterInfo = useAppSelector(
    getSelectedBoundaryDiffClusterInfo,
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

  const ordinalColorScale = useMemo(() => {
    const target = isBoundaryDiffMode ? boundaryDiffClusterInfo : clusterInfo;
    return scaleOrdinal({
      domain: Object.keys(target ?? {}),
      range: Object.values(target ?? {}).map((item) => item.color),
    });
  }, [clusterInfo, boundaryDiffClusterInfo]);

  const collisionOrdinalColorScale = useMemo(
    () =>
      scaleOrdinal({
        domain: [0, 1],
        range: [theme.palette.success.main, theme.palette.error.main],
      }),
    [],
  );

  const scaleFactorSize = 30;
  const scaleFactors = Array.from(
    { length: scaleFactorSize + 1 },
    (_, i) => i / scaleFactorSize,
  );
  // const thresholdScale = scaleOrdinal({
  //   domain: scaleFactors,
  //   range: scaleFactors.map((factor) =>
  //     shade(chroma(theme.palette.primary.main), factor),
  //   ),
  // });

  const legendGlyphSize = 16;

  return (
    <Stack
      sx={{
        backgroundColor: theme.palette.background.paper + "bb",
        borderRadius: "5px",
        borderStyle: "solid",
        borderColor: "divider",
        borderWidth: "1px",
        p: 1,
        ...sx,
      }}
    >
      <Box component="div">
        <Stack>
          <Typography sx={{ fontSize: 14 }}>
            {isBoundaryDiffMode
              ? "Boundary Difference Patterns"
              : "Failure Patterns"}
          </Typography>
          <LegendOrdinal
            scale={ordinalColorScale}
            labelFormat={(label) => `${label.toUpperCase()}`}
          >
            {(labels) => (
              <Stack flexDirection="row" columnGap={1} flexWrap="wrap">
                {labels
                  .filter(
                    (label) =>
                      (!clusterCounts && label.text in failedClusterTrialIds) ||
                      (clusterCounts && label.text in clusterCounts.failed),
                  )
                  .map((label, i) => {
                    return (
                      <>
                        <Box
                          component="div"
                          onClick={() => {
                            if (label.text === selectedCluster) {
                              dispatch(
                                sessionSlice.actions.setSelectedCluster(null),
                              );
                            } else {
                              dispatch(
                                sessionSlice.actions.setSelectedCluster(
                                  label.text,
                                ),
                              );
                            }
                            dispatch(
                              sessionSlice.actions.setSelectedBoundarySafeCluster(
                                null,
                              ),
                            );
                          }}
                          sx={{
                            m: 0,
                            p: 0,
                            position: "relative",
                            zIndex: 100,
                            ":hover": {
                              cursor: "pointer",
                              filter: "brightness(0.8)",
                            },
                            ...(selectedCluster && !isBoundaryDiffMode
                              ? {
                                  width: legendGlyphSize + 10,
                                  height: legendGlyphSize + 10,
                                  display: "flex",
                                  alignItems: "center",
                                  justifyContent: "center",
                                  backgroundColor:
                                    selectedCluster === label.text
                                      ? chroma(theme.palette.error.main)
                                          .alpha(0.4)
                                          .hex()
                                      : chroma(
                                          theme.palette.background.paper,
                                        ).hex(),
                                  borderRadius: `${legendGlyphSize / 5}px`,
                                  borderStyle: "solid",
                                  borderWidth: "3px",
                                  borderColor: chroma(
                                    theme.palette.divider,
                                  ).hex(),
                                }
                              : {}),
                          }}
                        >
                          <LegendItem
                            className="legend-item"
                            key={`legend-quantile-${i}`}
                            margin="0 5px"
                            style={{
                              display: "flex",
                              alignItems: "center",
                            }}
                          >
                            {!selectedCluster || isBoundaryDiffMode ? (
                              <svg
                                width={legendGlyphSize}
                                height={legendGlyphSize}
                              >
                                <rect
                                  fill={label.value}
                                  stroke={
                                    // trialClusterMappings[hoveredTrialId ?? ""] ===
                                    selectedCluster === label.text
                                      ? theme.palette.text.primary
                                      : "transparent"
                                  }
                                  strokeWidth={"4px"}
                                  width={legendGlyphSize}
                                  height={legendGlyphSize}
                                />
                              </svg>
                            ) : null}
                            <LegendLabel
                              align="left"
                              style={{
                                fontSize: legendGlyphSize,
                                marginLeft:
                                  !selectedCluster || isBoundaryDiffMode
                                    ? 3
                                    : 0,
                              }}
                            >
                              {label.text}
                            </LegendLabel>
                          </LegendItem>
                        </Box>
                        {clusterCounts && label.text in clusterCounts.failed ? (
                          <Typography>{`(${
                            clusterCounts.failed[label.text].size
                          })`}</Typography>
                        ) : null}
                      </>
                    );
                  })}
              </Stack>
            )}
          </LegendOrdinal>
        </Stack>
      </Box>
      {!selectedCluster || isBoundaryDiffMode ? null : (
        <>
          <Typography sx={{ fontSize: 14, mt: 0.5 }}>Collision</Typography>
          <LegendOrdinal
            scale={collisionOrdinalColorScale}
            labelFormat={(label) => (label ? "Yes" : "No")}
          >
            {(labels) => (
              <Box
                component="div"
                sx={{
                  display: "flex",
                  flexDirection: "row",
                  columnGap: 1,
                }}
              >
                {labels.map((label, i) => {
                  return (
                    <Box component="div">
                      <LegendItem
                        className="legend-item"
                        key={`legend-quantile-${i}`}
                        margin="0 5px"
                        style={{
                          display: "flex",
                          alignItems: "center",
                        }}
                      >
                        <svg width={legendGlyphSize} height={legendGlyphSize}>
                          <rect
                            fill={label.value}
                            width={legendGlyphSize}
                            height={legendGlyphSize}
                          />
                        </svg>
                        <LegendLabel
                          align="left"
                          style={{
                            fontSize: legendGlyphSize,
                            marginLeft: 3,
                          }}
                        >
                          {label.text}
                        </LegendLabel>
                      </LegendItem>
                    </Box>
                  );
                })}
              </Box>
            )}
          </LegendOrdinal>
        </>
      )}
    </Stack>
  );
}
