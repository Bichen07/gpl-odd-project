import chroma from "chroma-js";
import { scaleOrdinal } from "@visx/scale";
import { LegendOrdinal, LegendItem, LegendLabel } from "@visx/legend";
import { Box, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useMemo, Dispatch, SetStateAction } from "react";
import { useTheme } from "@mui/material/styles";
import { ClusterResult } from "src/api/services/Clustering";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { ColorMode } from "../../../EmbeddingSpace/Scatter";
import { sessionSlice } from "src/redux/slices/session";

type Props = {
  sx?: SxProps;
  clusterResult: ClusterResult | null | undefined;
  clusterCounts: { [clusterLabel: string]: number };
  selectedCluster: string;
  colorMode: ColorMode;
};
export function Legend({ sx, clusterResult, clusterCounts, colorMode }: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();

  const ordinalColorScale = useMemo(() => {
    const domain = Object.keys(clusterCounts ?? {});
    const range: string[] = [];
    for (const label of domain) {
      range.push(clusterResult?.clusterMemberData[label].color ?? "black");
    }
    return scaleOrdinal({
      domain,
      range,
    });
  }, [clusterResult, clusterCounts]);

  const collisionOrdinalColorScale = useMemo(
    () =>
      scaleOrdinal({
        domain: [0, 1],
        range: [theme.palette.success.main, theme.palette.error.main],
      }),
    [clusterResult],
  );

  const selectedCluster = useAppSelector(
    (state) => state.session.selectedCluster,
  );

  const legendGlyphSize = 16;

  return (
    <Stack sx={{ p: 0.5, ...sx }}>
      <Typography sx={{ fontSize: 14 }}>Cluster (#Trial)</Typography>
      <LegendOrdinal
        scale={ordinalColorScale}
        labelFormat={(label) => `${label.toUpperCase()}`}
      >
        {(labels) => (
          <Stack direction="row" flexWrap="wrap">
            {labels
              .sort((a, b) => clusterCounts[b.text] - clusterCounts[a.text])
              .map((label, i) => (
                <>
                  <Box
                    component="div"
                    onClick={() => {
                      if (label.text === selectedCluster) {
                        dispatch(sessionSlice.actions.setSelectedCluster(null));
                      } else {
                        dispatch(
                          sessionSlice.actions.setSelectedCluster(label.text),
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
                        backgroundColor: chroma(theme.palette.background.paper)
                          .darken(0.5)
                          .hex(),
                      },
                      ...(colorMode === "criticalityMetric"
                        ? {
                            width: legendGlyphSize + 10,
                            height: legendGlyphSize + 10,
                            display: "flex",
                            alignItems: "center",
                            justifyContent: "center",
                            backgroundColor:
                              selectedCluster === label.text
                                ? chroma(theme.palette.primary.main)
                                    .alpha(0.3)
                                    .hex()
                                : chroma(theme.palette.background.paper).hex(),
                            borderRadius: `${legendGlyphSize / 5}px`,
                            borderStyle: "solid",
                            borderWidth: "1px",
                            borderColor: chroma(theme.palette.divider).hex(),
                          }
                        : {}),
                    }}
                  >
                    <LegendItem key={`legend-quantile-${i}`}>
                      <Stack
                        component="div"
                        direction="row"
                        alignItems="center"
                      >
                        {colorMode === "clustering" ? (
                          <svg width={legendGlyphSize} height={legendGlyphSize}>
                            <rect
                              fill={label.value}
                              stroke={
                                selectedCluster === label.text
                                  ? theme.palette.text.primary
                                  : "transparent"
                              }
                              strokeWidth={5}
                              width={legendGlyphSize}
                              height={legendGlyphSize}
                            />
                          </svg>
                        ) : null}
                        <Stack
                          direction="row"
                          sx={{
                            marginLeft: colorMode === "clustering" ? "3px" : 0,
                            ".MuiTypography-root": {
                              fontSize: legendGlyphSize,
                            },
                          }}
                        >
                          <Typography>{label.text}</Typography>
                        </Stack>
                      </Stack>
                    </LegendItem>
                  </Box>
                  <Typography sx={{ ml: "3px", mr: "5px" }}>{`(${
                    clusterCounts[label.text]
                  })`}</Typography>
                </>
              ))}
          </Stack>
        )}
      </LegendOrdinal>
      {colorMode === "criticalityMetric" ? (
        <>
          <Typography sx={{ fontSize: 14, mt: 1 }}>Collision</Typography>
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
                {labels.map((label, i) => (
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
                ))}
              </Box>
            )}
          </LegendOrdinal>
        </>
      ) : null}
    </Stack>
  );
}
