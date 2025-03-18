import { scaleOrdinal } from "@visx/scale";
import { LegendOrdinal, LegendItem, LegendLabel } from "@visx/legend";
import { Box, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { useTheme } from "@mui/material/styles";
import { useMemo } from "react";
import { sessionSlice } from "src/redux/slices/session";

type Props = {
  sx?: SxProps;
  clusterCounts?: {
    passed: { [clusterLabel: string]: Set<string> };
    failed: { [clusterLabel: string]: Set<string> };
  };
};
export function Legend({ sx, clusterCounts }: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();

  // const hoveredTrialId = useAppSelector(
  //   (state) => state.session.hoveredTrialId,
  // );
  // const selectedTrialId = useAppSelector(
  //   (state) => state.session.selectedTrialId,
  // );
  // const clusteringResponse = useAppSelector(
  //   (state) => state.session.clusteringResponse,
  // );
  // const clusteringResult = useAppSelector(
  //   (state) => state.session.selectedCriticalStateClusteringResult,
  // );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedSafetyMarginViolationStateClusterInfo,
  );
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedSafetyMarginViolationStateCluster,
  );

  const ordinalColorScale = useMemo(() => {
    return scaleOrdinal({
      domain: Object.keys(clusterInfo ?? {}),
      range: Object.values(clusterInfo ?? {}).map((item) => item.color),
    });
  }, [clusterInfo]);

  const scaleFactorSize = 30;
  const scaleFactors = Array.from(
    { length: scaleFactorSize + 1 },
    (_, i) => i / scaleFactorSize,
  );

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
            Safety Margin Violation State Patterns
          </Typography>
          <LegendOrdinal
            scale={ordinalColorScale}
            labelFormat={(label) => `${label.toUpperCase()}`}
          >
            {(labels) => (
              <Stack flexDirection="row" columnGap={1} flexWrap="wrap">
                {labels.map((label, i) => {
                  return (
                    <>
                      <Box
                        component="div"
                        onClick={() => {
                          if (label.text === selectedCluster) {
                            dispatch(
                              sessionSlice.actions.setSelectedSafetyMarginViolationStateCluster(
                                null,
                              ),
                            );
                          } else {
                            dispatch(
                              sessionSlice.actions.setSelectedSafetyMarginViolationStateCluster(
                                label.text,
                              ),
                            );
                          }
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
                          <svg width={legendGlyphSize} height={legendGlyphSize}>
                            <rect
                              fill={label.value}
                              stroke={
                                selectedCluster === label.text
                                  ? theme.palette.text.primary
                                  : "transparent"
                              }
                              strokeWidth={"4px"}
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
    </Stack>
  );
}
