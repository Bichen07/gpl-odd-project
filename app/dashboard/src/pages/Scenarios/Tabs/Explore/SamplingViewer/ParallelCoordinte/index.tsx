import Plot from "react-plotly.js";
import { useTheme } from "@mui/material/styles";
import { CriticalityMetric, Parameter } from "..";
import { ColorScale, Data } from "plotly.js-basic-dist";
import { useCallback, useEffect, useState } from "react";
import chroma from "chroma-js";
import _ from "lodash";
import { Stack } from "@mui/material";
import { Trial } from "src/__generated__/graphql";

type Props = {
  constraintRanges: {
    [parameterId: string]: [number, number][];
  } | null;
  setConstraintRanges: (value: {
    [parameterId: string]: [number, number][];
  }) => void;
  parameters: { [parameterId: string]: Parameter };
  metric: CriticalityMetric | null;
  trials: Trial[] | null;
  loading: boolean;
  viewClusters?: boolean;
};

export default function ParallelCoordinate({
  constraintRanges,
  setConstraintRanges,
  parameters,
  metric,
  trials,
  loading,
  viewClusters,
}: Props) {
  const theme = useTheme();
  const [parallelCoordData, setParallelCoordData] = useState<Data[] | null>(
    null,
  );

  useEffect(() => {
    if (!trials || !parameters || !metric) {
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
    if (metric.kpi.rule === "lessThan") {
      colors.reverse();
    }

    const alpha = 0.1;
    const colorscale: ColorScale = [
      [0.0, chroma(colors[0]).alpha(alpha).hex()],
      [
        metric.threshold / ((metric.max || 1.0) - (metric.min || 0.0) - 1e-6),
        chroma(colors[1]).alpha(alpha).hex(),
      ],
      [1.0, chroma(colors[2]).alpha(alpha).hex()],
    ];

    const values = [];
    for (const trial of trials) {
      const trialMetric = trial.testObjectives?.criticalityMetrics.find(
        // (m) => m.keyPerformanceIndicator.id === metric.kpi?.id,
        (m) => `${m.keyPerformanceIndicator}` === metric.kpi?.id,
      );
      values.push(trialMetric?.value ?? NaN);
    }

    const data: Data[] = [
      {
        type: "parcoords",
        line: {
          colorscale,
          color: values,
        },
        marker: {
          opacity: alpha,
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
  }, [trials, parameters, metric]);

  const updateConstraintRanges = useCallback(
    _.debounce((event: any) => {
      const updatedConstraintRanges: {
        [key: string]: [number, number][];
      } = {};
      if (!event.data || event.data.length === 0) {
        return;
      }
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
    }, 500),
    [constraintRanges, setConstraintRanges],
  );

  return (
    <Stack sx={{ filter: loading ? "blur(2px)" : "none" }}>
      <Plot
        onUpdate={(event) => updateConstraintRanges(event)}
        useResizeHandler={true}
        style={{ width: "100%" }}
        layout={{
          autosize: true,
          plot_bgcolor: theme.palette.background.paper,
          paper_bgcolor: theme.palette.background.paper,
          font: {
            color: theme.palette.text.secondary,
          },
          margin: { l: 40, r: 40, t: 60, b: 40, pad: 0 },
          height: 250,
        }}
        data={parallelCoordData ?? []}
      />
    </Stack>
  );
}
