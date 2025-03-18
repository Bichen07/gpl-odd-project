import LoadingButton from "@mui/lab/LoadingButton";
import { Autocomplete, Box, TextField, Typography } from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useEffect, useState } from "react";
import { toast } from "react-toastify";
import { LinePath } from "@visx/shape";
import { scaleLinear } from "@visx/scale";
import { AxisLeft, AxisBottom } from "@visx/axis";
import { Group } from "@visx/group";
import AnalysisService from "src/axios/services/Analysis";
import ObservationService from "src/axios/services/Observations";
import Labeler from "src/components/Labeler";
import TextFieldSkeleton from "src/components/TextFieldSkeleton";
import { useAppSelector } from "src/redux/hooks";
import { observationDocsToRows } from "src/utils";
import { useTheme } from "@emotion/react";
import { getSelectedCriticalityMetric } from "src/redux/slices/trialFilters";

type Line = {
  data: { x: number; y: number }[];
  color: string;
};

type PlotData = {
  xrange: [number, number];
  yrange: [number, number];
  lines: Line[];
  explainedVarianceRatio: [number, number];
};

export default () => {
  const theme = useTheme() as Theme;
  const trials = useAppSelector((state) => state.trialFilters.trials);
  const colorscale = useAppSelector(
    (state) => state.trialFilters.outputColorScale
  );
  const selectedCriticalityMetric = useAppSelector(
    getSelectedCriticalityMetric
  );
  const attributes = useAppSelector(
    (state) => state.timeSeriesClustering.attributes
  );

  const [selectedTrialIds, setSelectedTrialIds] = useState<string[]>([]);
  const [selectedAttributes, setSelectedAttributes] = useState<string[]>([]);
  const [plotData, setPlotData] = useState<PlotData | null>({
    lines: [],
    xrange: [0, 0],
    yrange: [0, 0],
    explainedVarianceRatio: [0, 0],
  });

  useEffect(() => {
    if (
      trials === null ||
      plotData !== null ||
      selectedCriticalityMetric === null
    ) {
      return;
    }

    const fetchAndSet = async () => {
      try {
        let response = await ObservationService.getObservations({
          where: {
            trial: {
              in: selectedTrialIds.join(","),
            },
          },
          sort: "+time",
          limit: 100000,
        });
        const observations = observationDocsToRows(response.data.docs);
        const points: number[][] = [];
        for (const observation of observations) {
          const row: number[] = [];
          for (const attribute of selectedAttributes) {
            row.push(observation[attribute]);
          }
          points.push(row);
        }

        const pca = await AnalysisService.getPca({ x: points }).then(
          (response) => response.data
        );
        const newPlotData: PlotData = {
          lines: [],
          xrange: [Infinity, -Infinity],
          yrange: [Infinity, -Infinity],
          explainedVarianceRatio: [
            pca.explainedVarianceRatio[0],
            pca.explainedVarianceRatio[1],
          ],
        };
        for (const selectedTrialId of selectedTrialIds) {
          const trial = trials[selectedTrialId];
          const line: Line = {
            data: [],
            color: trial.safetyRequirements[selectedCriticalityMetric.index]
              .passed
              ? theme.palette.success.main
              : theme.palette.error.main,
          };
          for (const [index, point] of pca.x.entries()) {
            if (observations[index]["trialId"] !== selectedTrialId) {
              continue;
            }
            const pointData = { x: point[0], y: point[1] };
            line.data.push(pointData);
            newPlotData.xrange[0] = Math.min(newPlotData.xrange[0], point[0]);
            newPlotData.xrange[1] = Math.max(newPlotData.xrange[1], point[0]);
            newPlotData.yrange[0] = Math.min(newPlotData.yrange[0], point[1]);
            newPlotData.yrange[1] = Math.max(newPlotData.yrange[1], point[1]);
          }
          newPlotData.lines.push(line);
        }
        setPlotData(newPlotData);
      } catch (error) {
        console.error(error);
        setPlotData({
          lines: [],
          xrange: [0, 0],
          yrange: [0, 0],
          explainedVarianceRatio: [0, 0],
        });
      }
    };

    fetchAndSet();
  }, [trials, plotData, selectedCriticalityMetric]);

  const width = 500;
  const height = 500;
  const margin = { top: 30, right: 30, bottom: 30, left: 30 };
  const xMax = width - margin.left - margin.right;
  const yMax = height - margin.top - margin.bottom;

  const xScale = scaleLinear({
    range: [0, xMax],
    domain: plotData?.xrange,
  });
  const yScale = scaleLinear({
    range: [yMax, 0],
    domain: plotData?.yrange,
  });

  return (
    <Box>
      <Typography sx={{ mb: 1 }}>Time Seires PCA</Typography>
      {trials === null ? (
        <TextFieldSkeleton />
      ) : (
        <Autocomplete
          multiple
          id="tags-standard"
          options={Object.keys(trials)}
          value={selectedTrialIds}
          onChange={(_event, value) => setSelectedTrialIds(value)}
          renderInput={(params) => (
            <Labeler label="Trial IDs">
              <TextField
                {...params}
                variant="standard"
                label=""
                placeholder="Trial ID"
              />
            </Labeler>
          )}
        />
      )}
      {attributes === null ? (
        <TextFieldSkeleton />
      ) : (
        <Autocomplete
          multiple
          id="tags-standard"
          options={attributes}
          value={selectedAttributes}
          onChange={(_event, value) => setSelectedAttributes(value)}
          renderInput={(params) => (
            <Labeler label="Attributes">
              <TextField
                {...params}
                variant="standard"
                label=""
                placeholder="Attributes"
              />
            </Labeler>
          )}
        />
      )}
      <LoadingButton
        loading={plotData === null}
        onClick={() => setPlotData(null)}
      >
        Plot
      </LoadingButton>
      <Box>
        <svg width={width} height={height}>
          <Group left={margin.left} top={margin.top}>
            <text
              x="-25"
              y="15"
              transform="rotate(-90)"
              fontSize={10}
              fill={theme.palette.text.primary}
            >
              {`PCA2 (${(plotData?.explainedVarianceRatio[1] ?? 0) * 100}%)`}
            </text>
            <text
              x={xMax - 25}
              y={yMax - 10}
              fontSize={10}
              fill={theme.palette.text.primary}
            >
              {`PCA1 (${(plotData?.explainedVarianceRatio[0] ?? 0) * 100}%)`}
            </text>
            <AxisLeft
              scale={yScale}
              stroke={theme.palette.text.primary}
              tickStroke={theme.palette.text.secondary}
              tickLabelProps={() => ({
                fill: theme.palette.text.secondary, // Set the color of tick labels
                fontSize: 10, // Set the font size of tick labels
                textAnchor: "end", // Set the alignment of tick labels
                dx: "-0.2em",
                dy: "0.4em",
              })}
            />
            <AxisBottom
              scale={xScale}
              top={yMax}
              stroke={theme.palette.text.primary}
              tickStroke={theme.palette.text.secondary}
              tickLabelProps={() => ({
                fill: theme.palette.text.secondary, // Set the color of tick labels
                fontSize: 10, // Set the font size of tick labels
                textAnchor: "middle", // Set the alignment of tick labels
              })}
            />
            {plotData
              ? plotData.lines.map((line, index) => (
                <LinePath
                  key={index}
                  data={line.data}
                  x={(d) => xScale(d.x)}
                  y={(d) => yScale(d.y)}
                  stroke={line.color}
                  strokeWidth={2}
                />
              ))
              : null}
          </Group>
        </svg>
      </Box>
    </Box>
  );
};
