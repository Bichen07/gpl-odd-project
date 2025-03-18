import { Box, Stack } from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useTheme } from "@emotion/react";
import { Data, Layout } from "plotly.js";
import Plot from "react-plotly.js";
import { useEffect, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import { Parameter, resizeObserver } from "src/utils";
import chroma from "chroma-js";

type Props = {
  scatterPlotData: {
    x: number;
    y: number;
    color: number;
    z?: number;
    id: string;
  }[];
  parameters: [Parameter, Parameter, Parameter] | null;
  colorscale: chroma.Scale<chroma.Color>;
};
export default ({ parameters, scatterPlotData, colorscale }: Props) => {
  const theme = useTheme() as Theme;
  const allParameters = useAppSelector((state) => state.batch.parameters);

  const [scatter3DData, setScatter3DData] = useState<{
    layout: Partial<Layout>;
    data: Data[];
  } | null>(null);

  const selectedCriticalityMetric = useAppSelector(
    (state) => state.batch.selectedCriticalityMetric,
  );

  useEffect(() => {
    setScatter3DData(null);
  }, []);

  useEffect(() => {
    if (
      parameters == null ||
      parameters.length < 3 ||
      selectedCriticalityMetric === null
    ) {
      return;
    }

    const data: Data[] = [];

    const getcolor = (t: number) => {
      let min = selectedCriticalityMetric?.min ?? 0;
      let max = selectedCriticalityMetric?.max ?? 1;
      const normalized = (t - min) / (max - min);
      return colorscale(normalized).hex();
    };

    const texts = scatterPlotData.map(
      (item) =>
        `id: ${item.id}<br>` +
        `${selectedCriticalityMetric.name}: ${item.color}<br>` +
        Object.values(allParameters ?? {})
          .map((p) => `${p.name}: ${item[p.name].toFixed(4)}<br>`)
          .join(""),
    );

    data.push({
      type: "scatter3d",
      mode: "markers",
      x: scatterPlotData.map((i) => i.x),
      y: scatterPlotData.map((i) => i.y),
      z: scatterPlotData.map((i) => i.z),
      text: texts,
      marker: {
        color: scatterPlotData.map((i) => getcolor(i.color)),
        size: 5,
        showscale: false,
        opacity: 0.8,
        line: {
          color: theme.palette.background.paper,
          width: 0.1,
        },
      },
    });

    const layout: Partial<Layout> = {
      width: 600,
      height: 600,
      plot_bgcolor: theme.palette.background.default,
      paper_bgcolor: theme.palette.background.default,
      font: {
        color: theme.palette.text.secondary,
      },
      margin: { l: 0, r: 0, t: 0, b: 0, pad: 0 },
      scene: {
        aspectmode: "cube",
        xaxis: {
          title: parameters[0].name,
          // range: [parameters[0].min, parameters[0].max],
        },
        yaxis: {
          title: parameters[1].name,
          // range: [parameters[1].min, parameters[1].max],
        },
        zaxis: {
          title: parameters[2].name,
          // range: [parameters[2].min, parameters[2].max],
        },
      },
    };

    setScatter3DData({ data, layout });
  }, [selectedCriticalityMetric, parameters, allParameters]);

  return (
    <Stack>
      <Plot
        useResizeHandler
        layout={
          scatter3DData?.layout ?? {
            plot_bgcolor: theme.palette.background.default,
            paper_bgcolor: theme.palette.background.default,
            font: {
              color: theme.palette.text.secondary,
            },
          }
        }
        data={scatter3DData?.data ?? []}
      // onClick={(event) => {
      //   const pointNumber = event.points[0].pointNumber;
      // }}
      />
    </Stack>
  );
};
