import { scaleOrdinal } from "@visx/scale";
import { LegendOrdinal, LegendItem, LegendLabel } from "@visx/legend";
import { Box, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useMemo } from "react";
import { useTheme } from "@mui/material/styles";

type Props = {
  sx?: SxProps;
  colorMode: any;
};
export function Legend({ sx, colorMode }: Props) {
  const theme = useTheme();

  const collisionOrdinalColorScale = useMemo(
    () =>
      scaleOrdinal({
        domain: [0, 1],
        range: [theme.palette.success.main, theme.palette.error.main],
      }),
    []
  );

  const legendGlyphSize = 16;

  return (
    <Stack sx={{ p: 0.5, ...sx }}>
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
