import { scaleOrdinal } from "@visx/scale";
import { LegendOrdinal, LegendItem, LegendLabel } from "@visx/legend";
import { Box, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useTheme } from "@mui/material/styles";
import { useMemo } from "react";
import { useAppSelector } from "src/redux/hooks";

type Props = {
  sx?: SxProps;
  fpcColors: string[] | null;
};
export function Legend({ sx, fpcColors }: Props) {
  const theme = useTheme();
  const clustering = useAppSelector(
    (state) => state.session.clusteringResponse?.boundaryDiffClustering,
  );

  const ordinalColorScale = useMemo(() => {
    return scaleOrdinal(
      fpcColors == null
        ? undefined
        : {
            domain: fpcColors.map((_c, i) => i),
            range: fpcColors,
          },
    );
  }, [fpcColors]);

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
          {/* <Typography sx={{ fontSize: 14 }}>  Patterns</Typography> */}
          <LegendOrdinal
            scale={ordinalColorScale}
            // labelFormat={(label) => `${label.toUpperCase()}`}
          >
            {(labels) => (
              <Stack flexDirection="row" columnGap={1} flexWrap="wrap">
                {labels.map((label, i) => {
                  return (
                    <>
                      <Box
                        component="div"
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
                            {`FPC${Number(label.text)} (${(
                              (clustering?.explainedVarianceRatio[
                                Number(label.text)
                              ] ?? 0) * 100
                            ).toFixed(2)}%)`}
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
