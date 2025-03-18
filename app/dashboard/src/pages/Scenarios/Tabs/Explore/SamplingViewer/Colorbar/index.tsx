import { Box, Skeleton, Stack, SxProps, Typography } from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import { useTheme, Theme } from "@mui/material/styles";
import { CriticalityMetric } from "..";
import Labeler from "src/components/Labeler";

export const getOutputColorScale = (
  criticalityMetric: CriticalityMetric | null,
  theme: Theme,
): [number, string][] | null => {
  if (!criticalityMetric) {
    return null;
  }
  if (criticalityMetric.kpi.rule === "greaterThan") {
    return [
      [criticalityMetric.min ?? 0, theme.palette.error.main],
      [criticalityMetric.threshold, theme.palette.warning.main],
      [criticalityMetric.max ?? 1, theme.palette.success.main],
    ];
  } else {
    return [
      [criticalityMetric.min ?? 0, theme.palette.success.main],
      [criticalityMetric.threshold, theme.palette.warning.main],
      [criticalityMetric.max ?? 1, theme.palette.error.main],
    ];
  }
};

type Props = {
  sx?: SxProps;
  metric: CriticalityMetric | null;
  loading: boolean;
};
export default ({ sx, metric, loading }: Props) => {
  const theme = useTheme();
  const colorscale = useMemo(
    () => getOutputColorScale(metric, theme),
    [metric],
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

  if (loading) {
    return (
      <Stack sx={sx}>
        <Skeleton height="5ch" />
      </Stack>
    );
  }

  return (
    <Stack sx={sx}>
      {colorbarData === null ? null : (
        <Stack sx={{ height: "100%" }}>
          <Labeler
            label={`${metric?.kpi.name ?? "Output"} [${metric?.kpi.unit ?? "unit"
              }]`}
          >
            <Stack spacing={1} direction="row" alignItems="center">
              <Typography color="text.disabled" fontSize={12}>
                {Math.round(colorbarData.ticks[0] * 100) / 100}
              </Typography>
              <Box
                component="div"
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
          </Labeler>
        </Stack>
      )}
    </Stack>
  );
};
