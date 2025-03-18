import { Box, Skeleton, Stack, SxProps, Typography } from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import LegendContainer from "../LegendContainer";
import { getOutputColorScale } from "src/utils";
import { useTheme } from "@mui/material/styles";

type Props = {
  sx?: SxProps;
};
export default ({ sx }: Props) => {
  const theme = useTheme();
  const selectedCriticalityMetric = useAppSelector(
    (state) => state.batch.selectedCriticalityMetric,
  );
  const colorscale = useMemo(
    () => getOutputColorScale(selectedCriticalityMetric, theme),
    [selectedCriticalityMetric, theme],
  );

  const [colorbarData, setColorbarData] = useState<{
    ticks: number[];
    colors: string[];
  } | null>(null);

  useEffect(() => {
    if (!colorscale) {
      return;
    }
    setColorbarData({
      ticks: colorscale.map((item) => item[0]),
      colors: colorscale.map((item) => item[1]),
    });
  }, [colorscale]);

  return (
    <Box component="div" sx={sx}>
      {colorbarData === null ? (
        <Skeleton height="5ch" />
      ) : (
        <LegendContainer
          sx={{ height: "100%" }}
          title={`${selectedCriticalityMetric?.name ?? "Output"} [${selectedCriticalityMetric?.unit ?? "unit"
            }]`}
        >
          <Stack spacing={1} direction="row" alignItems="center">
            <Typography color="text.disabled" fontSize={12}>
              {Math.round(colorbarData.ticks[0] * 100) / 100}
            </Typography>
            <Box
              sx={{
                width: "100%",
                flex: 1,
                display: "flex",
                pb: 3,
              }}
            >
              <Box
                sx={{
                  position: "relative",
                  background: `linear-gradient(to right, ${colorbarData.colors[0]}, ${colorbarData.colors[1]})`,
                  borderRight: "solid 2px white",
                  height: "15px",
                  flex: `${Math.round(
                    ((colorbarData.ticks[1] - colorbarData.ticks[0]) /
                      (colorbarData.ticks[2] - colorbarData.ticks[0])) *
                    100,
                  )}`,
                }}
              >
                <Typography
                  fontSize={12}
                  color="text.disabled"
                  sx={{
                    position: "absolute",
                    right: "0",
                    bottom: "-20px",
                    transform: "translate(50%)",
                    textWrap: "nowrap",
                  }}
                  display="inline"
                  noWrap
                >
                  {colorbarData.ticks[1]}
                </Typography>
              </Box>
              <Box
                sx={{
                  background: `linear-gradient(to right, ${colorbarData.colors[1]}, ${colorbarData.colors[2]})`,
                  height: "15px",
                  flex: `${Math.round(
                    ((colorbarData.ticks[2] - colorbarData.ticks[1]) /
                      (colorbarData.ticks[2] - colorbarData.ticks[0])) *
                    100,
                  )}`,
                }}
              />
            </Box>
            <Typography color="text.disabled" fontSize={12}>
              {Math.round((colorbarData.ticks[2] * 100) / 100)}
            </Typography>
          </Stack>
        </LegendContainer>
      )}
    </Box>
  );
};
