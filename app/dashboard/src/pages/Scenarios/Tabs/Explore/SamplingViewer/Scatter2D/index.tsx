import chroma from "chroma-js";
import { Paper, Stack, Typography } from "@mui/material";
import { ChartsItemContentProps, ScatterChart } from "@mui/x-charts";
import { CriticalityMetric, Parameter } from "..";
import { BatchWithTrials } from "src/api/services/Batches";
import { useEffect, useMemo, useState } from "react";
import { useTheme } from "@mui/material/styles";
import { sessionSlice } from "src/redux/slices/session";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { Trial } from "src/__generated__/graphql";

const userData: {
  metric: CriticalityMetric | null;
  parameters: { [parameterId: string]: Parameter };
} = {
  metric: null,
  parameters: {},
};

const CustomItemTooltipContent = (props: ChartsItemContentProps<"scatter">) => {
  const { itemData, series } = props;

  const metric = userData.metric;
  const parameters = userData.parameters;
  if (!metric) {
    return <Typography>Not found</Typography>;
  }

  const filteredIndex = itemData.dataIndex
    ? (series.data[itemData.dataIndex].id as number)
    : null;
  if (!filteredIndex) {
    return <Typography>Not found</Typography>;
  }

  return (
    <Paper key={itemData.dataIndex} sx={{ padding: "5px" }}>
      <Typography>{`id: ${series.data[itemData.dataIndex].id}`}</Typography>
      <Typography>{`${metric?.kpi.name}: ${series.data[
        itemData.dataIndex
      ].color.toFixed(4)}`}</Typography>
      {Object.values(parameters ?? {}).map((p) => {
        if (!(p.id in series.data[itemData.dataIndex]["parameters"])) {
          return null;
        }
        return (
          <Typography>{`${p.name}: ${series.data[itemData.dataIndex][
            "parameters"
          ][p.id].toFixed(4)}`}</Typography>
        );
      })}
    </Paper>
  );
};

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
};

export default function Scatter2D({
  axes,
  parameters,
  metric,
  trials,
  constraintRanges,
  loading,
  boundaryTrialIds,
}: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();

  const replayerInput = useAppSelector((state) => state.session.replayerInput);
  const [scatterPlotData, setScatterPlotData] = useState<
    { x: number; y: number; color: number; id: string }[]
  >([]);

  const colorscale = useMemo(() => {
    const colors = [
      theme.palette.error.main,
      // theme.palette.warning.main,
      theme.palette.success.main,
    ];
    if (metric && metric.kpi.rule === "lessThan") {
      colors.reverse();
    }
    // return chroma.scale(colors);
    return chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
  }, [metric]);

  useEffect(() => {
    userData.metric = metric;
    userData.parameters = parameters;
  }, [metric, parameters]);

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

    try {
      const plotData: {
        x: number;
        y: number;
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
        if (
          !(axes[0] in parameters) ||
          !(axes[1] in parameters)
          // parameters[axes[0]].index > trial.parameters.length - 1 ||
          // parameters[axes[1]].index > trial.parameters.length - 1
        ) {
          continue;
        }
        const trialMetric = trial.testObjectives?.criticalityMetrics.find(
          (m) => `${m.keyPerformanceIndicator}` === metric.kpi?.id,
          // (m) => m.keyPerformanceIndicator === metric.kpi?.id,
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
          color: trialMetric?.value ?? NaN,
          id: trial.id ?? "",
        });
        visited.add(trial.id ?? "");
      }
      setScatterPlotData(plotData);
    } catch (error) {
      setScatterPlotData([]);
    }
  }, [parameters, trials, axes, metric, constraintRanges, boundaryTrialIds]);

  return (
    <Stack
      alignItems="center"
      justifyContent="center"
      sx={{ mt: 2, mb: 2, filter: loading ? "blur(2px)" : "none" }}
    >
      <ScatterChart
        width={600}
        height={600}
        tooltip={{ trigger: "item", itemContent: CustomItemTooltipContent }}
        onItemClick={(_event: any, d: any) => {
          const trialId =
            d.dataIndex < scatterPlotData.length - 1
              ? scatterPlotData[d.dataIndex].id
              : null;
          if (!trialId) {
            return;
          }
          dispatch(sessionSlice.actions.setSelectedTrialId(trialId));
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
        sx={{
          circle: {
            borderStyle: "solid",
            borderWidth: "1px",
            borderColor: "background.paper",
            width: "10px",
            height: "10px",
          },
        }}
        xAxis={[
          {
            label: `${
              axes && parameters && axes[0] in parameters
                ? parameters[axes[0]].name
                : null
            }`,
          },
        ]}
        yAxis={[
          {
            labelStyle: {
              angle: -90,
            },
            label: `${
              axes && parameters && axes[1] in parameters
                ? parameters[axes[1]].name
                : null
            }`,
          },
        ]}
        zAxis={[
          {
            data: scatterPlotData.map((item) => item.color),
            colorMap: {
              type: "continuous",
              min: metric?.min,
              max: metric?.max,
              color: (t) => colorscale(t).hex(),
            },
          },
        ]}
        series={[
          {
            data: scatterPlotData,
            highlightScope: {
              highlighted: "item",
              faded: "global",
            },
          },
        ]}
      />
    </Stack>
  );
}
