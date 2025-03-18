import { Box, CircularProgress, Stack, Typography } from "@mui/material";
import Plot from "react-plotly.js";
import { Data } from "plotly.js";
import { useEffect, useState } from "react";
import { useTheme } from "@mui/material/styles";
import { useAppSelector } from "src/redux/hooks";
import { resizeObserver } from "src/utils";

export default function Violin() {
  const theme = useTheme();

  const parameters = useAppSelector((state) => state.batch.parameters);
  const trials = useAppSelector((state) => state.batch.trials);
  const selectedCriticalityMetric = useAppSelector(
    (state) => state.batch.selectedCriticalityMetric,
  );

  const [violinPlotData, setViolinPlotData] = useState<{
    [key: string]: Data[];
  } | null>(null);

  useEffect(() => {
    if (!trials || !parameters) {
      return;
    }

    const updatedViolinPlotData: { [key: string]: Data[] } = {};

    for (const parameter of Object.values(parameters ?? {})) {
      const passedX: number[] = [];
      const failedX: number[] = [];
      for (const trial of trials) {
        const metric =
          trial.testObjectives?.criticalityMetrics[
            selectedCriticalityMetric?.index ?? -1
          ];
        if (!metric || parameter.index > trial.parameters.length - 1) {
          continue;
        }
        if (metric.passed) {
          passedX.push(
            Number(
              trial.parameters.find((tp) => tp.parameterId === parameter.id)
                ?.value,
            ),
          );
        } else {
          failedX.push(
            Number(
              trial.parameters.find((tp) => tp.parameterId === parameter.id)
                ?.value,
            ),
          );
        }
      }

      const data: Data[] = [
        {
          type: "violin",
          x: passedX,
          y0: parameter.name,
          legendgroup: "Passed",
          scalegroup: "Passed",
          name: "Passed",
          side: "negative",
          box: {
            visible: true,
          },
          line: {
            color: theme.palette.success.main,
            width: 2,
          },
          meanline: {
            visible: true,
          },
        },
        {
          type: "violin",
          x: failedX,
          y0: parameter.name,
          legendgroup: "Failed",
          scalegroup: "Failed",
          name: "Failed",
          side: "positive",
          box: {
            visible: true,
          },
          line: {
            color: theme.palette.error.main,
            width: 2,
          },
          meanline: {
            visible: true,
          },
        },
      ];

      updatedViolinPlotData[parameter.name] = data;
    }

    setViolinPlotData(updatedViolinPlotData);
  }, [trials, parameters, selectedCriticalityMetric]);

  useEffect(() => {
    const element = document.getElementById("violin-plots-root");
    if (element) {
      resizeObserver.observe(element);
    }
    return () => {
      if (element) {
        resizeObserver.unobserve(element);
      }
    };
  }, []);

  return (
    <Box component="div" id="violin-plots-root">
      <Typography
        sx={{ ml: 2, mt: 2, color: "text.disabled" }}
      >{`selected criticality metric: ${selectedCriticalityMetric?.name}`}</Typography>
      {violinPlotData === null ? (
        <CircularProgress />
      ) : (
        <Stack>
          {Object.keys(violinPlotData).map((key, index) => (
            <Stack
              key={index}
              rowGap={1}
              sx={{
                display: "flex",
                justifyContent: "center",
                width: "100%",
              }}
            >
              <Typography sx={{ m: 2 }}>{`${key}`}</Typography>
              <Plot
                key={index}
                useResizeHandler={true}
                style={{ width: "100%" }}
                layout={{
                  plot_bgcolor: theme.palette.background.default,
                  paper_bgcolor: theme.palette.background.default,
                  font: {
                    color: theme.palette.text.secondary,
                  },
                  margin: { l: 40, r: 40, t: 40, b: 40, pad: 0 },
                  xaxis: {},
                  yaxis: { showticklabels: false },
                }}
                data={violinPlotData[key]}
              />
            </Stack>
          ))}
        </Stack>
      )}
    </Box>
  );
}
