import chroma from "chroma-js";
import { select } from "d3";
import { Box, Stack } from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useTheme } from "@emotion/react";
import { Data, Layout } from "plotly.js";
import Plotly from "plotly.js-dist";
import Plot from "react-plotly.js";
import { useEffect, useMemo, useRef, useState } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { interpolateMagma } from "d3-scale-chromatic";

window.global = window;

export default function HeightMap() {
  const plotRef = useRef<HTMLDivElement>(null);
  const dispatch = useAppDispatch();
  const theme = useTheme() as Theme;

  const selectedMetric = useAppSelector(
    (state) => state.session.selectedMetric,
  );
  const boundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const metric = selectedMetric;
  const trajectoryAnalysisResponse = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const parameters = trajectoryAnalysisResponse?.clustering.parameters;

  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const pairedTrialId = useAppSelector(
    (state) => state.session.selectedPairTrialId,
  );

  const [scatterPlotData, setScatterPlotData] = useState<
    {
      x: number;
      y: number;
      colorValue: number;
      colorString: string;
      id: string;
      parameters: { [parameterId: string]: number };
    }[]
  >([]);

  const colorscale = useMemo(() => {
    // if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
    //   return chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
    // }
    // return chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
    return chroma.scale("viridis").domain([0, 1]);
  }, [metric]);

  useEffect(() => {
    if (parameters == null || metric == null) {
      return;
    }

    const getcolor = (t: number) => {
      let min = metric?.min ?? 0;
      let max = metric?.max ?? 1;
      const normalized = (t - min) / (max - min);
      return colorscale(normalized).hex();
    };

    try {
      setScatterPlotData([]);

      const plotData: {
        x: number;
        y: number;
        colorValue: number;
        colorString: string;
        id: string;
        parameters: { [parameterId: string]: number };
      }[] = [];

      const visited = new Set<string>();
      for (const trial of Object.values(
        trajectoryAnalysisResponse?.trials ?? {},
      )) {
        if (visited.has(trial.id ?? "")) {
          continue;
        }

        const trialMetric = trial.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.id === metric?.kpi?.id,
        );
        const trialParameters: { [parameterId: string]: number } = {};
        for (const p of trial.parameters) {
          trialParameters[p.parameterId ?? ""] = p.value ?? NaN;
        }
        plotData.push({
          parameters: trialParameters,
          x: trial.parameters.find((tp) => tp.parameterId === parameters[0].id)
            ?.value!,
          y: trial.parameters.find((tp) => tp.parameterId === parameters[1].id)
            ?.value!,
          colorValue: trialMetric?.value ?? NaN,
          colorString:
            trialMetric?.value == null ? "black" : getcolor(trialMetric?.value),
          id: trial.id ?? "",
        });
        visited.add(trial.id ?? "");
      }
      setScatterPlotData(plotData);
    } catch (error) {
      console.error(error);
      setScatterPlotData([]);
    }
  }, [parameters, metric, pairedTrialId]);

  const [scatter3DData, setScatter3DData] = useState<{
    layout: Partial<Layout>;
    data: Data[];
  } | null>(null);

  useEffect(() => {
    setScatter3DData(null);
  }, []);

  useEffect(() => {
    const data: Data[] = [];

    if (scatterPlotData.length === 0 || metric === null) {
      console.log("return");
      return;
    }

    const gridPreds =
      trajectoryAnalysisResponse?.metricGridPredictions[
      selectedMetric?.kpi.name ?? ""
      ];
    // const x = gridPreds.map(
    //   (item) =>
    //     item.x * (parameters[axes[0]].max - parameters[axes[0]].min) +
    //     parameters[axes[0]].min,
    // );
    // const y = gridPreds.map(
    //   (item) =>
    //     item.y * (parameters[axes[1]].max - parameters[axes[1]].min) +
    //     parameters[axes[1]].min,
    // );

    const zData = gridPreds ? gridPreds.z : [];

    const zFlattened: number[] = [];
    const zCorrected: number[][] = [];
    // for (let rowI = 0; rowI < zData.length; rowI++) {
    for (let rowI = zData.length - 1; rowI >= 0; rowI--) {
      const row = zData[rowI];
      const newRow: number[] = [];
      // for (let i = row.length - 1; i >= 0; i--) {
      for (let i = 0; i < row.length; i++) {
        newRow.push(row[i]);
        zFlattened.push(row[i]);
      }
      zCorrected.push(newRow);
    }
    const zMin = Math.min(...zFlattened);
    const zMax = Math.max(...zFlattened);

    const getcolor = (t: number) => {
      let min = metric?.min ?? 0;
      let max = metric?.max ?? 1;
      const normalized = (t - min) / (max - min);
      return colorscale(normalized).hex();
      // return interpolateMagma(normalized);
    };

    const getMetricValue = (t: number) => {
      let min = metric?.min ?? 0;
      let max = metric?.max ?? 1;
      // let min = zMin;
      // let max = zMax;
      return t * (max - min) + min;
    };

    const colorLength = 50;
    const colormap = Array.from({ length: colorLength }).map((v, i) => {
      return [getMetricValue(i / colorLength), getcolor(i / colorLength)];
    });
    colormap.push([getMetricValue(1), getcolor(1)]);
    // console.log(colormap);

    const interpolateColor = interpolateMagma;
    // const colorLength = 20;
    let tempS = chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      tempS = chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
    }
    let temp = Array.from({ length: colorLength }).map((v, i) => {
      return [i / colorLength, tempS(i / colorLength).hex()];
    });
    temp.push([1, tempS(1).hex()]);

    // data.push({
    //   type: "surface",
    //   z: zCorrected,
    //   colorscale: temp,
    //   // showscale: false,
    //   // line: {
    //   //   width: 0,
    //   // },
    //   // contours: {
    //   //   coloring: "heatmap",
    //   // },
    // });

    const bzCorrected: number[][] = [];
    // for (let rowI = 0; rowI < zData.length; rowI++) {
    for (let rowI = zData.length - 1; rowI >= 0; rowI--) {
      const row = zData[rowI];
      const newRow: number[] = [];
      // for (let i = row.length - 1; i >= 0; i--) {
      for (let i = 0; i < row.length; i++) {
        // newRow.push(row[i]);
        const passed =
          boundaryMetric?.kpi.rule === "lessThan"
            ? row[i] < (boundaryMetric?.threshold ?? 0)
            : row[i] > (boundaryMetric?.threshold ?? 0);
        newRow.push(Number(passed));
      }
      bzCorrected.push(newRow);
    }
    const cs =
      boundaryMetric?.kpi.rule === "greaterThan"
        ? [
          [0, "red"],
          [1, "green"],
        ]
        : [
          [0, "green"],
          [1, "red"],
        ];

    data.push({
      type: "surface",
      z: zCorrected,
      surfacecolor: bzCorrected, // Apply contour-based coloring
      colorscale: cs,
      // cmin: 0, // Set color range min
      // cmax: 1.0, // Set color range max
      // showscale: false,
      // line: {
      //   width: 0,
      // },
      // contours: {
      //   coloring: "heatmap",
      // },
    });

    const tickVals = Array.from({ length: zData.length })
      .map((_v, i) => i)
      .filter((i) => i % 2 == 0);
    const layout: Partial<Layout> = {
      title: "3D Surface Plot",
      autosize: true,
      height: "100%",
      width: "100%",
      // scene: {
      //   xaxis: { title: "X Axis" },
      //   yaxis: { title: "Y Axis" },
      //   zaxis: { title: "Height (Z)" },
      // },
      // width: 600,
      // height: 600,
      // autosize: false,
      // plot_bgcolor: theme.palette.background.paper,
      // paper_bgcolor: theme.palette.background.paper,
      // font: {
      //   color: theme.palette.text.secondary,
      // },
      margin: { l: 0, r: 0, t: 0, b: 0, pad: 0 },
      scene: {
        aspectmode: "cube",
        zaxis: {
          title: selectedMetric.kpi.name ?? "",
          tickmode: "linear",
          tick0: 10,
          dtick: 1,
        },
        xaxis: {
          title: `${parameters[1].name} [${parameters[1].unit}]`,
          tickvals: tickVals,
          ticktext: tickVals.map((v) =>
            (
              (v / zData.length) *
              ((parameters[1].max ?? 1) - (parameters[1].min ?? 0)) +
              (parameters[1].min ?? 0)
            ).toFixed(2),
          ),
        },
        yaxis: {
          title: `${parameters[0].name} [${parameters[0].unit}]`,
          tickvals: tickVals,
          ticktext: tickVals
            .map((v) =>
              (
                (v / zData.length) *
                ((parameters[0].max ?? 1) - (parameters[0].min ?? 0)) +
                (parameters[0].min ?? 0)
              ).toFixed(2),
            )
            .reverse(),
        },
      },
    };

    // const img_jpg = select("#testimg");
    // Plotly.newPlot("plotly_div", data, layout).then(function (gd) {
    //   Plotly.toImage(gd, { height: 300, width: 300 }).then(function (url) {
    //     img_jpg.attr("src", url);
    //   });
    // });

    setScatter3DData({ data, layout });
    return;
  }, [metric, parameters, scatterPlotData]);

  const resizeObserver = useMemo(() => {
    // plotRef.current?.dispatchEvent(new Event("resize"));
    return new ResizeObserver((entries) => {
      for (let entry of entries) {
        entry.target.dispatchEvent(new Event("resize"));
        const { width, height } = entry.contentRect;
        console.log("RESIZE");
      }
    });
  }, []);

  useEffect(() => {
    const element = document.getElementById("height-map-root");
    if (element) {
      resizeObserver.observe(element);
    }
    return () => {
      if (element) {
        resizeObserver.unobserve(element);
      }
    };
  }, []);

  // const exportImage = async () => {
  //   if (plotRef.current) {
  //     const gd = plotRef.current.el; // Get the plot div
  //     const imageUrl = await toImage(gd, {
  //       format: "png",
  //       width: 800,
  //       height: 600,
  //     });
  //
  //     // Create a download link
  //     const a = document.createElement("a");
  //     a.href = imageUrl;
  //     a.download = "plot.png";
  //     document.body.appendChild(a);
  //     a.click();
  //     document.body.removeChild(a);
  //   }
  // };

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
      id="height-map-root"
    >
      <Plot
        ref={plotRef}
        style={{ width: "100%", height: "100%" }}
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
      // onInitialized={(figure, gd) => {
      //   Plotly.toImage(gd, { format: "png" }).then((url) => {
      //     console.log("Image URL:", url);
      //   });
      // }}
      />
      <div id="plotly_div"></div>
      {/* <img id="testimg" /> */}
    </Stack>
  );
}
