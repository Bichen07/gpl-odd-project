import {
  MenuItem,
  Paper,
  Select,
  Stack,
  ToggleButton,
  ToggleButtonGroup,
  Typography,
} from "@mui/material";
import { useTheme } from "@mui/material/styles";
import { useEffect, useMemo, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import chroma from "chroma-js";
import Plot from "react-plotly.js";
import { ColorScale, Data } from "plotly.js-basic-dist";
import _ from "lodash";
import Scatter3D from "./Scatter3D";
import { ChartsItemContentProps, ScatterChart } from "@mui/x-charts";

const scatterModes = ["2D", "3D"] as const;
type ScatterMode = (typeof scatterModes)[number];

const CustomItemTooltipContent = (props: ChartsItemContentProps<"scatter">) => {
  const { itemData, series } = props;
  const selectedCriticalityMetric = useAppSelector(
    (state) => state.batch.selectedCriticalityMetric,
  );
  const parameters = useAppSelector((state) => state.batch.parameters);

  const filteredIndex = itemData.dataIndex
    ? (series.data[itemData.dataIndex].id as number)
    : null;
  if (!filteredIndex) {
    return <Typography>Not found</Typography>;
  }
  return (
    <Paper sx={{ padding: "5px" }}>
      <Typography>{`id: ${series.data[itemData.dataIndex].id}`}</Typography>
      <Typography>{`${selectedCriticalityMetric?.name}: ${series.data[
        itemData.dataIndex
      ].color.toFixed(4)}`}</Typography>
      {Object.values(parameters ?? {}).map((p) => (
        <Typography>{`${p.name}: ${series.data[itemData.dataIndex][
          p.name
        ].toFixed(4)}`}</Typography>
      ))}
    </Paper>
  );
};

export default function ParameterSpace() {
  const theme = useTheme();
  const parameters = useAppSelector((state) => state.batch.parameters);
  const trials = useAppSelector((state) => state.batch.trials);
  const selectedCriticalityMetric = useAppSelector(
    (state) => state.batch.selectedCriticalityMetric,
  );

  const [scatterMode, setScatterMode] = useState<ScatterMode>("2D");

  const [parallelCoordData, setParallelCoordData] = useState<Data[] | null>(
    null,
  );
  const [constraintRanges, setConstraintRanges] = useState<{
    [id: string]: [number, number][];
  } | null>(null);

  const [axes, setAxes] = useState<string[] | null>(null);
  const [scatterPlotData, setScatterPlotData] = useState<
    { x: number; y: number; color: number; z?: number; id: string }[]
  >([]);

  useEffect(() => {
    if (!parameters) {
      return;
    }
    setAxes(Object.keys(parameters).slice(0, scatterMode === "2D" ? 2 : 3));
  }, [parameters, scatterMode]);

  const nonSelectedAxes: string[] = [];
  for (const key of Object.keys(parameters ?? {}).sort()) {
    if ((axes ?? []).includes(key)) {
      continue;
    }
    nonSelectedAxes.push(key);
  }

  useEffect(() => {
    if (!trials || !axes || !parameters || !selectedCriticalityMetric) {
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

    const colors = [
      theme.palette.error.main,
      theme.palette.warning.light,
      theme.palette.success.main,
    ];
    if (selectedCriticalityMetric.rule === "lessThan") {
      colors.reverse();
    }
    const updatedColorscale: ColorScale = [
      [0.0, colors[0]],
      [
        selectedCriticalityMetric.threshold /
          (selectedCriticalityMetric.max ||
            1.0 - selectedCriticalityMetric.min ||
            0.0) -
          1e-6,
        colors[1],
      ],
      [1.0, colors[2]],
    ];

    const data: Data[] = [
      {
        type: "parcoords",
        line: {
          colorscale: updatedColorscale,
          color: trials.map(
            (t) =>
              t.testObjectives?.criticalityMetrics[
                selectedCriticalityMetric.index
              ].value,
          ),
        },
        dimensions: Object.values(parameters).map((p) => ({
          constraintrange: constraintRanges
            ? constraintRanges[p.id]
            : undefined,
          range: [p.min, p.max],
          label: p.name,
          id: p.id,
          values: trials.map(
            (t) => t.parameters?.find((tp) => tp.parameterId === p.id)?.value,
          ),
        })),
      },
    ];

    setParallelCoordData(data);
  }, [trials, parameters, selectedCriticalityMetric, axes]);

  useEffect(() => {
    if (
      !parameters ||
      !trials ||
      !axes ||
      !selectedCriticalityMetric ||
      !constraintRanges
    ) {
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
    const plotData: {
      x: number;
      y: number;
      color: number;
      z?: number;
      id: string;
    }[] = [];
    for (const [i, trial] of trials.entries()) {
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
        !(axes[1] in parameters) ||
        parameters[axes[0]].index > trial.parameters.length - 1 ||
        parameters[axes[1]].index > trial.parameters.length - 1
      ) {
        continue;
      }
      // console.log(axes);
      // console.log(trial.parameters);
      plotData.push({
        ...trial.parameters.reduce(
          (acc, item) => ({
            ...acc,
            [item.parameterId in parameters
              ? parameters[item.parameterId].name
              : ""]: item.value,
          }),
          {},
        ),
        // x: trial.parameters.find(
        //   (tp) => tp.parameterId === parameters[axes[0]].id,
        // )?.value!,
        // y: trial.parameters.find(
        //   (tp) => tp.parameterId === parameters[axes[1]].id,
        // )?.value!,
        x: trial.parameters[0].value!,
        y: trial.parameters[1].value!,
        z: trial.parameters[2].value!,
        // z:
        //   axes.length >= 3 &&
        //     axes[2] in parameters &&
        //     parameters[axes[2]].index < trial.parameters.length
        //     ? trial.parameters.find(
        //       (tp) => tp.parameterId === parameters[axes[2]].id,
        //     )?.value!
        //     : undefined,
        color:
          trial.testObjectives?.criticalityMetrics[
            selectedCriticalityMetric.index
          ].value ?? NaN,
        id: trial.id,
      });
    }
    setScatterPlotData(plotData);
    // console.log(plotData);
  }, [parameters, trials, axes, selectedCriticalityMetric, constraintRanges]);
  // console.log(scatterPlotData);

  const colorscale = useMemo(() => {
    const colors = [
      theme.palette.error.main,
      theme.palette.warning.main,
      theme.palette.success.main,
    ];
    if (
      selectedCriticalityMetric &&
      selectedCriticalityMetric.rule === "lessThan"
    ) {
      colors.reverse();
    }
    return chroma.scale(colors);
  }, [selectedCriticalityMetric]);

  return (
    <Stack
      sx={{ height: "100%", p: 2, overflowY: "scroll" }}
      id="parameter-space-root"
    >
      <Typography
        sx={{ color: "text.disabled" }}
      >{`selected criticality metric: ${selectedCriticalityMetric?.name}`}</Typography>
      <Stack>
        <Plot
          onUpdate={(event) => {
            const updatedConstraintRanges: {
              [key: string]: [number, number][];
            } = {};
            for (const dim of event.data[0].dimensions) {
              if (
                "constraintrange" in dim &&
                dim["constraintrange"] &&
                dim["constraintrange"].length > 0 &&
                Array.isArray(dim["constraintrange"][0])
              ) {
                updatedConstraintRanges[dim.id] = dim["constraintrange"];
              } else {
                updatedConstraintRanges[dim.id] = [dim["constraintrange"]];
              }
            }
            if (_.isEqual(constraintRanges, updatedConstraintRanges)) {
              return;
            }
            setConstraintRanges(updatedConstraintRanges);
          }}
          useResizeHandler={true}
          style={{ width: "100%" }}
          layout={{
            plot_bgcolor: theme.palette.background.default,
            paper_bgcolor: theme.palette.background.default,
            font: {
              color: theme.palette.text.secondary,
            },
            margin: { l: 40, r: 40, t: 60, b: 40, pad: 0 },
            height: 300,
          }}
          data={parallelCoordData ?? []}
        />
      </Stack>
      <Stack direction="row" flexWrap="wrap" rowGap={2} columnGap={2}>
        {Object.keys(parameters ?? {}).length >= 3 ? (
          <ToggleButtonGroup
            sx={{ mr: 2 }}
            size="small"
            color="primary"
            value={scatterMode}
            defaultValue={scatterMode}
            exclusive
            onChange={(_event, value) => {
              setScatterMode(value as ScatterMode);
            }}
          >
            {scatterModes.map((mode) => (
              <ToggleButton value={mode}>{mode}</ToggleButton>
            ))}
          </ToggleButtonGroup>
        ) : null}
        {(axes ?? []).map((axis, index) => {
          return (
            <Stack spacing={1} direction="row" alignItems="center" key={index}>
              <Typography
                fontSize={14}
                color="text.disabled"
              >{`axis${index}`}</Typography>
              <Select
                sx={{ maxHeight: "35px", fontSize: 14 }}
                value={axis}
                size="small"
                onChange={(event) => {
                  setAxes((prev) => {
                    if (prev === null) {
                      return prev;
                    }
                    prev = [...prev];
                    prev[index] = event.target.value as string;
                    return prev;
                  });
                }}
              >
                {Object.keys(parameters ?? {}).map((key, index) => (
                  <MenuItem
                    disabled={!nonSelectedAxes.includes(key)}
                    key={index}
                    value={key}
                  >
                    {parameters ? parameters[key].name : null}
                  </MenuItem>
                ))}
              </Select>
            </Stack>
          );
        })}
      </Stack>
      {scatterMode === "2D" ? (
        <Stack
          alignItems="center"
          justifyContent="center"
          sx={{ mt: 2, mb: 2 }}
        >
          <ScatterChart
            width={600}
            height={600}
            tooltip={{ trigger: "item", itemContent: CustomItemTooltipContent }}
            sx={{
              circle: {
                borderStyle: "solid",
                borderWidth: "1px",
                borderColor: "background.paper",
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
                  min: selectedCriticalityMetric?.min,
                  max: selectedCriticalityMetric?.max,
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
      ) : (
        <Scatter3D
          scatterPlotData={scatterPlotData}
          colorscale={colorscale}
          parameters={
            parameters && axes && axes.length === 3
              ? axes.map((id) =>
                  Object.values(parameters).find((p) => p.id === id),
                )
              : null
          }
        />
      )}
    </Stack>
  );
}
