import chroma from "chroma-js";
import { Stack } from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useTheme } from "@emotion/react";
import { Data, Layout } from "plotly.js";
import Plot from "react-plotly.js";
import { useEffect, useMemo, useState } from "react";
import { resizeObserver } from "src/utils";
import { sessionSlice } from "src/redux/slices/session";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import {
  interpolateInferno,
  interpolateMagma,
  interpolateViridis,
  interpolateTurbo,
} from "d3-scale-chromatic";

type Props = {
  kde: { x: number; y: number }[];
  clusterKde: { x: number; y: number }[];
  name: string;
};
export default function KernelDensityPlot({ kde, clusterKde, name }: Props) {
  const dispatch = useAppDispatch();
  const theme = useTheme() as Theme;
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedGradientCluster,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedGradientClusterInfo,
  );

  const clusterColor =
    clusterInfo != null && selectedCluster != null
      ? clusterInfo[selectedCluster].color
      : "black";

  const [plotData, setPlotData] = useState<{
    layout: Partial<Layout>;
    data: Data[];
  } | null>(null);

  useEffect(() => {
    setPlotData(null);
  }, []);

  useEffect(() => {
    if (kde == null || clusterKde == null) {
      return;
    }
    const data: Data[] = [];

    // data.push({
    //   x: kde.map((p) => p.x),
    //   y: kde.map((p) => p.y),
    //   fill: "tozeroy",
    //   type: "scatter",
    //   showlegend: false,
    //   line: {
    //     color: theme.palette.divider, // Set the color of the curve
    //     width: 2, // Adjust the curve's thickness
    //   },
    //   fillcolor: theme.palette.divider, // Set the fill color (with transparency)
    // });

    data.push({
      x: clusterKde.map((p) => p.x),
      y: clusterKde.map((p) => p.y),
      fill: "tozeroy",
      type: "scatter",
      showlegend: false,
      line: {
        color: clusterColor, // Set the color of the curve
        width: 2, // Adjust the curve's thickness
      },
      fillcolor: chroma(clusterColor).alpha(0.5).hex(), // Set the fill color (with transparency)
    });

    const layout: Partial<Layout> = {
      width: 300,
      height: 150,
      plot_bgcolor: theme.palette.background.paper,
      paper_bgcolor: theme.palette.background.paper,
      font: {
        color: theme.palette.text.secondary,
      },
      margin: { l: 30, r: 0, t: 30, b: 30, pad: 0 },
    };
    setPlotData({ data, layout });
  }, [kde, clusterKde]);

  useEffect(() => {
    const element = document.getElementById(`kde-plot-root-${name}`);
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
    <Stack
      alignItems="center"
      justifyContent="center"
      sx={{
        width: "100%",
        height: "100%",
        // aspectRatio: 1,
        // mt: 2,
        // mb: 2,
        // filter: loading ? "blur(2px)" : "none",
      }}
      id={`kde-plot-root-${name}`}
    >
      <Plot
        useResizeHandler
        layout={
          plotData?.layout ?? {
            plot_bgcolor: theme.palette.background.default,
            paper_bgcolor: theme.palette.background.default,
            font: {
              color: theme.palette.text.secondary,
            },
          }
        }
        data={plotData?.data ?? []}
      />
    </Stack>
  );
}
