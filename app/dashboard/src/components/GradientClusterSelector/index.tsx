import { scaleOrdinal } from "@visx/scale";
import { LegendOrdinal, LegendItem, LegendLabel } from "@visx/legend";
import { Box, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { useTheme } from "@mui/material/styles";
import { useMemo } from "react";
import chroma from "chroma-js";
import { sessionSlice } from "src/redux/slices/session";

type Props = {
  sx?: SxProps;
};
export function GradientClusterSelector({ sx }: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();

  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedGradientClusteringResult,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedGradientClusterInfo,
  );
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedGradientCluster,
  );

  const ordinalColorScale = useMemo(() => {
    return scaleOrdinal({
      domain: Object.keys(clusterInfo ?? {}),
      range: Object.values(clusterInfo ?? {}).map((item) => item.color),
    });
  }, [clusterInfo]);

  const legendGlyphSize = 16;

  return (
    <Stack
      sx={{
        backgroundColor: theme.palette.background.paper + "bb",
        ...sx,
      }}
    >
      <Box component="div">
        <Stack>
          <Typography sx={{ fontSize: 14 }}>
            Gradient Cluster Selector
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
                              sessionSlice.actions.setSelectedGradientCluster(
                                null,
                              ),
                            );
                          } else {
                            dispatch(
                              sessionSlice.actions.setSelectedGradientCluster(
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
