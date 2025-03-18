import chroma from "chroma-js";
import { Stack } from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useTheme } from "@emotion/react";
import { Data, Layout } from "plotly.js";
import Plot from "react-plotly.js";
import { useEffect, useMemo, useState } from "react";
import { resizeObserver } from "src/utils";
import { ColorMode, CriticalityMetric, Parameter } from "..";
import { sessionSlice } from "src/redux/slices/session";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { Trial } from "src/api/services/Batches";
import {
  interpolateInferno,
  interpolateMagma,
  interpolateViridis,
  interpolateTurbo,
} from "d3-scale-chromatic";

type Props = {
  axes: string[] | null;
  parameters: { [parameterId: string]: Parameter };
  metric: CriticalityMetric | null;
  trials: Trial[] | null;
  constraintRanges: {
    [parameterId: string]: [number, number][];
  } | null;
  colorMode: ColorMode;
};
export default function Scatter3D({
  parameters,
  axes,
  metric,
  trials,
  constraintRanges,
  colorMode,
}: Props) {
  const dispatch = useAppDispatch();
  const theme = useTheme() as Theme;

  const gradClusterInfo = useAppSelector(
    (state) => state.session.selectedGradientClusterInfo,
  );
  const gradClusteringResult = useAppSelector(
    (state) => state.session.selectedGradientClusteringResult,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusteringResult,
  );
  const trajectoryAnalysisResponse = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );

  const [scatterPlotData, setScatterPlotData] = useState<
    {
      x: number;
      y: number;
      z: number;
      colorValue: number;
      colorString: string;
      id: string;
      parameters: { [parameterId: string]: number };
    }[]
  >([]);

  const colorscale = useMemo(() => {
    // const interpolateColor = interpolateMagma;
    // const colorLength = 20;
    // const colors = Array.from({ length: colorLength }).map((v, i) => {
    //   return chroma(interpolateColor(i / colorLength)).hex();
    // });
    const colors = [
      theme.palette.error.main,
      theme.palette.warning.main,
      theme.palette.success.main,
    ];
    if (metric && metric.kpi.rule === "lessThan") {
      colors.reverse();
    }
    return chroma.scale(colors);

    // const interpolateColor = interpolateMagma;
    // const colorLength = 20;
    // const colorscale = Array.from({ length: colorLength }).map((v, i) => {
    //   return [i / colorLength, interpolateColor(i / colorLength)];
    // });
    // colorscale.push([1, interpolateColor(1)]);
    // return chroma.scale(colorscale);
  }, [metric]);

  useEffect(() => {
    if (!parameters || !trials || !axes || !metric) {
      // console.log(trials);
      // console.log(parameters);
      // console.log(axes);
      // console.log(metric);
      console.log("HELP");
      console.log("CANNOT SET SCATTER PLOT DATA");
      return;
    }
    if (
      trials.length > 0 &&
      trials[0].parameters
        .map((p) => p.parameterId)
        .sort()
        .join() !==
      Object.values(parameters)
        .map((p) => p.id)
        .sort()
        .join()
    ) {
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
        z: number;
        colorValue: number;
        colorString: string;
        id: string;
        parameters: { [parameterId: string]: number };
      }[] = [];

      const visited = new Set<string>();
      for (const trial of trials) {
        if (visited.has(trial.id ?? "")) {
          continue;
        }

        if (!(axes[0] in parameters) || !(axes[1] in parameters)) {
          continue;
        }
        const trialMetric = trial.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.id === metric.kpi?.id,
        );
        const trialParameters: { [parameterId: string]: number } = {};
        for (const p of trial.parameters) {
          trialParameters[p.parameterId ?? ""] = p.value ?? NaN;
        }
        plotData.push({
          parameters: trialParameters,
          x: trial.parameters.find(
            (tp) => tp.parameterId === parameters[axes[0]].id,
          )?.value!,
          y: trial.parameters.find(
            (tp) => tp.parameterId === parameters[axes[1]].id,
          )?.value!,
          z: trial.parameters.find(
            (tp) => tp.parameterId === parameters[axes[2]].id,
          )?.value!,
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
  }, [parameters, colorMode, trials, axes, metric, constraintRanges]);

  const [scatter3DData, setScatter3DData] = useState<{
    layout: Partial<Layout>;
    data: Data[];
  } | null>(null);

  useEffect(() => {
    setScatter3DData(null);
  }, []);

  useEffect(() => {
    const data: Data[] = [];

    const interpolateColor = interpolateMagma;
    const colorLength = 20;
    const colorscale = Array.from({ length: colorLength }).map((v, i) => {
      return [i / colorLength, interpolateColor(i / colorLength)];
    });
    colorscale.push([1, interpolateColor(1)]);
    if (colorMode === "FpcGradIso") {
      const gradient = trajectoryAnalysisResponse?.clustering.gradients;
      if (gradient == null) {
        return;
      }
      if (axes === null || Object.keys(parameters).length < 3) {
        return;
      }

      const x = gradient.isosurface.map(
        (item) =>
          item.x * (parameters[axes[0]].max - parameters[axes[0]].min) +
          parameters[axes[0]].min,
      );
      const y = gradient.isosurface.map(
        (item) =>
          item.y * (parameters[axes[1]].max - parameters[axes[1]].min) +
          parameters[axes[1]].min,
      );
      const z = gradient.isosurface.map(
        (item) =>
          item.z * (parameters[axes[2]].max - parameters[axes[2]].min) +
          parameters[axes[2]].min,
      );
      // const y = gradient.isosurface.map((item) => item.y * 20);
      // const z = gradient.isosurface.map((item) => item.z * 20);
      const values = gradient.isosurface.map((item) => item.value);

      data.push({
        type: "isosurface",
        x: x,
        y: y,
        z: z,
        opacity: 0.3,
        value: values,
        isomin: Math.min(...values), // Min value for the isosurface
        isomax: Math.max(...values), // Max value for the isosurface
        surface: { show: true, count: 8 }, // Number of isosurfaces
        caps: { x: { show: false }, y: { show: false }, z: { show: false } },
        colorscale: colorscale,
      });
      const layout: Partial<Layout> = {
        title: "4D Isosurface Example",
        width: 600,
        height: 600,
        plot_bgcolor: theme.palette.background.paper,
        paper_bgcolor: theme.palette.background.paper,
        font: {
          color: theme.palette.text.secondary,
        },
        margin: { l: 0, r: 0, t: 0, b: 0, pad: 0 },
        scene: {
          aspectmode: "cube",
          xaxis: {
            title: axes[0] in parameters ? parameters[axes[0]].name : axes[0],
            range:
              axes[0] in parameters
                ? [parameters[axes[0]].min, parameters[axes[0]].max]
                : undefined,
          },
          yaxis: {
            title: axes[1] in parameters ? parameters[axes[1]].name : axes[1],
            range:
              axes[1] in parameters
                ? [parameters[axes[1]].min, parameters[axes[1]].max]
                : undefined,
          },
          zaxis: {
            title: axes[2] in parameters ? parameters[axes[2]].name : axes[2],
            range:
              axes[2] in parameters
                ? [parameters[axes[2]].min, parameters[axes[2]].max]
                : undefined,
          },
        },
      };
      setScatter3DData({ data, layout });
    } else {
      if (
        axes === null ||
        scatterPlotData.length === 0 ||
        Object.keys(parameters).length < 3 ||
        metric === null
      ) {
        console.log(scatterPlotData);
        console.log("return");
        return;
      }
      console.log(colorMode);

      let invalid = false;
      for (const p of Object.values(parameters ?? {})) {
        for (const item of scatterPlotData) {
          if (!(p.id in item.parameters)) {
            invalid = true;
          }
          if (invalid) {
            break;
          }
        }
        if (invalid) {
          break;
        }
      }
      if (invalid) {
        console.log("INVALID");
        return;
      }

      const texts = scatterPlotData.map((item) => {
        return (
          `id: ${item.id}<br>` +
          `${metric.kpi.name}: ${item.colorValue}<br>` +
          Object.values(parameters ?? {})
            .map((p) => `${p.name}: ${item.parameters[p.id].toFixed(4)}<br>`)
            .join("")
        );
      });

      const colorLength = 20;
      let colorscale = Array.from({ length: colorLength }).map((v, i) => {
        return [i / colorLength, interpolateColor(i / colorLength)];
      });
      colorscale.push([1, interpolateColor(1)]);

      let colors: string | string[] = "black";
      let colorValues: number[] = [];
      let cmin = 0;
      let cmax = 1;
      if (
        colorMode === "Cluster" &&
        clusterInfo &&
        clusteringResult &&
        trajectoryAnalysisResponse
      ) {
        colors = scatterPlotData.map((item) => {
          const clusterLabel =
            item.id in clusteringResult.data
              ? clusteringResult.data[item.id].label
              : null;
          return clusterLabel == null
            ? item.colorString
            : clusterInfo[clusterLabel].color;
        });
      } else if (
        colorMode === "FpcGradCluster" &&
        gradClusterInfo &&
        gradClusteringResult &&
        trajectoryAnalysisResponse
      ) {
        colors = scatterPlotData.map((item) => {
          const clusterLabel =
            item.id in gradClusteringResult.data
              ? gradClusteringResult.data[item.id].label
              : null;
          return clusterLabel == null
            ? item.colorString
            : gradClusterInfo[clusterLabel].color;
        });
      } else if (colorMode === "FpcGradMag" && trajectoryAnalysisResponse) {
        let overallMags: number[] = [];
        for (const trialId in trajectoryAnalysisResponse.trials) {
          const gradient =
            trajectoryAnalysisResponse.clustering.gradients.data[trialId];
          if (gradient == null) {
            continue;
          }
          let sum = 0;
          for (const row of gradient) {
            for (const value of row) {
              sum += value * value;
            }
          }
          let mag = Math.sqrt(sum);
          overallMags.push(mag);
        }
        const magMin = Math.min(...overallMags);
        const magMax = Math.max(...overallMags);

        let mags: number[] = [];
        for (const item of scatterPlotData) {
          const gradient =
            trajectoryAnalysisResponse.clustering.gradients.data[item.id];
          if (gradient == null) {
            continue;
          }
          let sum = 0;
          for (const row of gradient) {
            for (const value of row) {
              sum += value * value;
            }
          }
          let mag = Math.sqrt(sum);
          mags.push(mag);
        }

        colors = scatterPlotData.map((_item, i) => {
          const value = (mags[i] - magMin) / (magMax - magMin);
          return interpolateColor(value);
        });
        colorValues = mags;
        cmin = magMin;
        cmax = magMax;

        // const colorLength = 20;
        // colorscale = Array.from({ length: colorLength }).map((v, i) => {
        //   return [
        //     (i / colorLength) * (cmax - cmin),
        //     interpolateColor(i / colorLength),
        //   ];
        // });
        // colorscale.push([cmax, interpolateColor(1)]);
      } else if (colorMode === "MetricGradMag" && trajectoryAnalysisResponse) {
        let overallMags: number[] = [];
        let usedMetric = "dce_min";
        for (const trialId in trajectoryAnalysisResponse.trials) {
          const gradient =
            trajectoryAnalysisResponse.clustering.metricGradients[usedMetric]
              .data[trialId];
          if (gradient == null) {
            continue;
          }
          let sum = 0;
          for (const value of gradient) {
            sum += value * value;
          }
          let mag = Math.sqrt(sum);
          overallMags.push(mag);
        }
        const magMin = Math.min(...overallMags);
        const magMax = Math.max(...overallMags);

        let mags: number[] = [];
        for (const item of scatterPlotData) {
          const gradient =
            trajectoryAnalysisResponse.clustering.metricGradients[usedMetric]
              .data[item.id];
          if (gradient == null) {
            continue;
          }
          let sum = 0;
          for (const value of gradient) {
            sum += value * value;
          }
          let mag = Math.sqrt(sum);
          mags.push(mag);
        }

        colors = scatterPlotData.map((_item, i) => {
          const value = (mags[i] - magMin) / (magMax - magMin);
          return interpolateColor(value);
        });
        colorValues = mags;
        cmin = magMin;
        cmax = magMax;

        const colorLength = 20;
        const colorscale = Array.from({ length: colorLength }).map((v, i) => {
          return [
            (i / colorLength) * (cmax - cmin),
            interpolateColor(i / colorLength),
          ];
        });
        colorscale.push([cmax, interpolateColor(1)]);
      } else {
        colors = scatterPlotData.map((i) => i.colorString);
        colorValues = scatterPlotData.map((i) => i.colorValue);

        const colorLength = 20;

        const mCs = [
          theme.palette.success.main,
          theme.palette.warning.main,
          theme.palette.error.main,
        ];
        if (metric && metric.kpi.rule === "lessThan") {
          colors.reverse();
        }
        const chromaScale = chroma.scale(mCs);

        colorscale = Array.from({ length: colorLength }).map((v, i) => {
          return [i / colorLength, chromaScale(i / colorLength).hex()];
        });
        colorscale.push([1, chromaScale(1).hex()]);
        cmin = metric.min ?? 0;
        cmax = metric.max ?? 1;
      }

      console.log(colorscale);
      console.log(colorValues);
      console.log(metric);
      data.push({
        type: "scatter3d",
        mode: "markers",
        x: scatterPlotData.map((i) => i.x),
        y: scatterPlotData.map((i) => i.y),
        z: scatterPlotData.map((i) => i.z),
        text: texts,
        hoverinfo: "text",
        marker: {
          color: colors,

          // size: colorMode === "FpcGradMag" ? 7.5 : 5,
          size: 7.5,
          opacity: 0.5,

          // color: colorValues,
          // colorscale: colorscale, // Choose a colorscale (e.g., Viridis, Cividis, etc.)
          // colorbar: {
          //   title: "Interaction FPC Scores Gradient Magnitude", // Title of the colorbar
          //   titleside: "right", // Position of the title
          //   ticks: "outside", // Tick style
          //   cmin: cmin,
          //   cmax: cmax,
          // },
          // showscale: true, // Show the colorbar
        },
        colorbar: {
          ticks: "outside", // Tick style
        },
      });

      const layout: Partial<Layout> = {
        width: 600,
        height: 600,
        plot_bgcolor: theme.palette.background.paper,
        paper_bgcolor: theme.palette.background.paper,
        font: {
          color: theme.palette.text.secondary,
        },
        margin: { l: 0, r: 0, t: 0, b: 0, pad: 0 },
        scene: {
          aspectmode: "cube",
          xaxis: {
            title: axes[0] in parameters ? parameters[axes[0]].name : axes[0],
            range:
              axes[0] in parameters
                ? [parameters[axes[0]].min, parameters[axes[0]].max]
                : undefined,
          },
          yaxis: {
            title: axes[1] in parameters ? parameters[axes[1]].name : axes[1],
            range:
              axes[1] in parameters
                ? [parameters[axes[1]].min, parameters[axes[1]].max]
                : undefined,
          },
          zaxis: {
            title: axes[2] in parameters ? parameters[axes[2]].name : axes[2],
            range:
              axes[2] in parameters
                ? [parameters[axes[2]].min, parameters[axes[2]].max]
                : undefined,
          },
        },
      };
      setScatter3DData({ data, layout });
    }
  }, [
    metric,
    parameters,
    axes,
    scatterPlotData,
    colorMode,
    clusterInfo,
    gradClusterInfo,
  ]);

  useEffect(() => {
    const element = document.getElementById("scatter-3d-root");
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
        mt: 2,
        mb: 2,
        // filter: loading ? "blur(2px)" : "none",
      }}
      id="scatter-3d-root"
    >
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
        onClick={(event) => {
          if (!(event.points.length > 0)) {
            return;
          }
          const pointNumber = event.points[0].pointNumber;
          if (!(pointNumber < scatterPlotData.length - 1)) {
            return;
          }
          const trialId = scatterPlotData[pointNumber].id;
          dispatch(sessionSlice.actions.setSelectedTrialId({ id: trialId }));
          const updatedTrajQuery = {
            trialId: trialId,
            duration: -1,
            index: -1,
            framePeriod: 0.25,
            forward: false,
            standardized: true,
          };
          dispatch(
            sessionSlice.actions.setReplayerTrajectoryQuery(updatedTrajQuery),
          );
        }}
      />
    </Stack>
  );
}
