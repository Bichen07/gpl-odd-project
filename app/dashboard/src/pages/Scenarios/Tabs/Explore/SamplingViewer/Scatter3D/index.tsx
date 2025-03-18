import chroma from "chroma-js";
import { Stack } from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useTheme } from "@emotion/react";
import { Data, Layout } from "plotly.js";
import Plot from "react-plotly.js";
import { useEffect, useMemo, useState } from "react";
import { resizeObserver } from "src/utils";
import { CriticalityMetric, Parameter } from "..";
import { sessionSlice } from "src/redux/slices/session";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { Trial } from "src/__generated__/graphql";

type Props = {
  axes: string[] | null;
  parameters: { [parameterId: string]: Parameter };
  metric: CriticalityMetric | null;
  trials: Trial[] | null;
  loading: boolean;
  constraintRanges: {
    [parameterId: string]: [number, number][];
  } | null;
  boundaryTrialIds: Set<string> | null;
  // batchClusterTrials: {
  //   [batchId: string]: { passed: Set<string>; failed: Set<string> };
  // };
  viewClusters: boolean;
};
export default function Scatter3D({
  parameters,
  axes,
  metric,
  trials,
  loading,
  constraintRanges,
  boundaryTrialIds,
  // batchClusterTrials,
  viewClusters,
}: Props) {
  const dispatch = useAppDispatch();
  const theme = useTheme() as Theme;

  const clusterInfo = useAppSelector(
    (state) => state.session.selectedFailureClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedFailureClusteringResult,
  );
  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );

  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );

  const replayerInput = useAppSelector((state) => state.session.replayerInput);
  const [scatterPlotData, setScatterPlotData] = useState<
    {
      x: number;
      y: number;
      z: number;
      color: number;
      id: string;
      parameters: { [parameterId: string]: number };
    }[]
  >([]);

  const colorscale = useMemo(() => {
    const colors = [
      theme.palette.error.main,
      theme.palette.warning.main,
      theme.palette.success.main,
    ];
    if (metric && metric.kpi.rule === "lessThan") {
      colors.reverse();
    }
    return chroma.scale(colors);
  }, [metric]);

  useEffect(() => {
    if (!parameters || !trials || !axes || !metric || !constraintRanges) {
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

    console.log("trials length scatter3d");
    console.log(trials.length);
    try {
      setScatterPlotData([]);

      const plotData: {
        x: number;
        y: number;
        z: number;
        color: number;
        id: string;
        parameters: { [parameterId: string]: number };
      }[] = [];

      const visited = new Set<string>();
      for (const trial of trials) {
        if (visited.has(trial.id ?? "")) {
          continue;
        }
        if (
          boundaryTrialIds != null &&
          !boundaryTrialIds.has(trial.id ?? "unknown")
        ) {
          continue;
        }
        let inSlice = true;
        for (const parameter of Object.values(parameters)) {
          const value = trial.parameters.find(
            (tp) => tp.parameterId === parameter.id,
          )?.value;
          if (parameter.id in constraintRanges) {
            let inRange = false;
            for (const range of constraintRanges[parameter.id]) {
              if (!range || range[0] === undefined) {
                inRange = true;
                break;
              }
              if (
                range &&
                value !== undefined &&
                value !== null &&
                value <= range[1] &&
                value >= range[0]
              ) {
                inRange = true;
                break;
              }
            }
            if (!inRange) {
              inSlice = false;
              break;
            }
          }
        }
        if (!inSlice) {
          continue;
        }
        if (!filteredTrialIds.includes(trial.id ?? "")) {
          continue;
        }

        if (!(axes[0] in parameters) || !(axes[1] in parameters)) {
          continue;
        }
        const trialMetric = trial.testObjectives?.criticalityMetrics.find(
          // (m) => m.keyPerformanceIndicator.id === metric.kpi?.id,
          (m) => `${m.keyPerformanceIndicator}` === metric.kpi?.id,
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
          color: trialMetric?.value ?? NaN,
          id: trial.id ?? "",
        });
        visited.add(trial.id ?? "");
      }
      setScatterPlotData(plotData);
    } catch (error) {
      setScatterPlotData([]);
    }
  }, [
    parameters,
    trials,
    axes,
    metric,
    constraintRanges,
    boundaryTrialIds,
    filteredTrialIds,
  ]);

  const [scatter3DData, setScatter3DData] = useState<{
    layout: Partial<Layout>;
    data: Data[];
  } | null>(null);

  useEffect(() => {
    setScatter3DData(null);
  }, []);

  useEffect(() => {
    if (
      axes === null ||
      scatterPlotData.length === 0 ||
      Object.keys(parameters).length < 3 ||
      metric === null
    ) {
      return;
    }

    const data: Data[] = [];

    const getcolor = (t: number) => {
      let min = metric?.min ?? 0;
      let max = metric?.max ?? 1;
      const normalized = (t - min) / (max - min);
      return colorscale(normalized).hex();
    };

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
      return;
    }

    const texts = scatterPlotData.map((item) => {
      return (
        `id: ${item.id}<br>` +
        `${metric.kpi.name}: ${item.color}<br>` +
        Object.values(parameters ?? {})
          .map((p) => `${p.name}: ${item.parameters[p.id].toFixed(4)}<br>`)
          .join("")
      );
    });

    let colors: string | string[] = "black";
    if (viewClusters && clusterInfo && clusteringResult && clusteringResponse) {
      colors = scatterPlotData.map((item) => {
        const clusterLabel =
          item.id in clusteringResult
            ? clusteringResult.data[item.id].label
            : null;
        return item.id in clusteringResponse.boundaryPairs.passed ||
          clusterLabel == null
          ? getcolor(item.color)
          : clusterInfo[clusterLabel].color;
      });
    } else {
      colors = scatterPlotData.map((i) => getcolor(i.color));
    }

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
        size: 5,
        showscale: false,
        opacity: 0.5,
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
  }, [metric, parameters, axes, scatterPlotData, viewClusters, clusterInfo]);

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
        // aspectRatio: 1,
        mt: 2,
        mb: 2,
        filter: loading ? "blur(2px)" : "none",
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
