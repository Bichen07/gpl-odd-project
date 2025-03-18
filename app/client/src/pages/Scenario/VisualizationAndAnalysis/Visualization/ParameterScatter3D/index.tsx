import {
  Box,
  Checkbox,
  CircularProgress,
  FormControlLabel,
  Typography,
} from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useTheme } from "@emotion/react";
import { Data, Layout, PlotMarker } from "plotly.js";
import Plot from "react-plotly.js";
import { useEffect, useState } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { toast } from "react-toastify";
import { Search } from "payload/payload-types";
import {
  getFilteredTrials,
  getSelectedCriticalityMetric,
} from "src/redux/slices/trialFilters";

export default () => {
  const theme = useTheme() as Theme;
  const dispatch = useAppDispatch();

  const [scatter3DData, setScatter3DData] = useState<{
    layout: Partial<Layout>;
    data: Data[];
  } | null>(null);

  const filteredTrials = useAppSelector(getFilteredTrials);
  const colorScale = useAppSelector(
    (state) => state.trialFilters.outputColorScale
  );
  const selectedCriticalityMetric = useAppSelector(
    getSelectedCriticalityMetric
  );
  const parameters = useAppSelector((state) => state.trialFilters.parameters);
  const clusters = useAppSelector(
    (state) => state.timeSeriesClustering.clusters
  );
  const clusterMemberData = useAppSelector(
    (state) => state.timeSeriesClustering.clusterMemberData
  );

  const [viewingClusters, setViewingClusters] = useState(false);

  useEffect(() => {
    if (
      filteredTrials == null ||
      parameters == null ||
      colorScale === null ||
      selectedCriticalityMetric === null
    ) {
      return;
    }

    if (viewingClusters && (clusters === null || clusterMemberData === null)) {
      return;
    }

    const data: Data[] = [];
    const texts: string[] = [];

    const filteredTrialsValues = Object.values(filteredTrials);

    if (filteredTrialsValues.length === 0) {
      return;
    }

    let markerColorConfig: Partial<PlotMarker> =
      viewingClusters && clusters && clusterMemberData
        ? {
            color: filteredTrialsValues.map(
              (trial) => clusterMemberData[clusters[trial.id].cluster].color
            ),
          }
        : {
            color:
              selectedCriticalityMetric.min === selectedCriticalityMetric.max
                ? "blue"
                : filteredTrialsValues.map(
                    (trial) =>
                      trial.safetyRequirements[selectedCriticalityMetric.index]
                        .value
                  ),
            colorscale: JSON.parse(JSON.stringify(colorScale)),
            cmin: selectedCriticalityMetric.min,
            cmax: selectedCriticalityMetric.max,
          };

    data.push({
      type: "scatter3d",
      mode: "markers",
      x: filteredTrialsValues.map(
        (trial) => trial.parameters[0].value as number
      ),
      y: filteredTrialsValues.map(
        (trial) => trial.parameters[1].value as number
      ),
      z: filteredTrialsValues.map(
        (trial) => trial.parameters[2].value as number
      ),
      text: filteredTrialsValues.map((trial) => trial.id!),
      marker: {
        ...markerColorConfig,
        size: 3,
        showscale: false,
        opacity: 0.8,
        line: {
          color: theme.palette.background.paper,
          width: 0.1,
        },
      },
    });

    const sortedParams = [];
    for (const p of (filteredTrialsValues[0].search as Search)
      .parameterRanges) {
      sortedParams.push(parameters[p.parameterId!]);
    }
    const layout: Partial<Layout> = {
      plot_bgcolor: theme.palette.background.paper,
      paper_bgcolor: theme.palette.background.paper,
      font: {
        color: theme.palette.text.secondary,
      },
      margin: { l: 0, r: 0, t: 0, b: 0, pad: 0 },
      scene: {
        aspectmode: "cube",
        xaxis: {
          title: sortedParams[0].name,
          range: [sortedParams[0].min, sortedParams[0].max],
        },
        yaxis: {
          title: sortedParams[1].name,
          range: [sortedParams[1].min, sortedParams[1].max],
        },
        zaxis: {
          title: sortedParams[2].name,
          range: [sortedParams[2].min, sortedParams[2].max],
        },
      },
    };

    setScatter3DData({ data, layout });
  }, [
    filteredTrials,
    selectedCriticalityMetric,
    colorScale,
    viewingClusters,
    clusters,
    clusterMemberData,
  ]);

  return (
    <Box
      sx={{
        width: "100%",
        aspectRatio: 1,
        ".js-plotly-plot": { width: "100%", height: "100%" },
      }}
    >
      <Typography sx={{ mb: 1 }}>Parameter Scatter 3D</Typography>
      <FormControlLabel
        disabled={clusters === null || clusterMemberData === null}
        control={
          <Checkbox onChange={(_event, value) => setViewingClusters(value)} />
        }
        label="view clusters"
      />
      {scatter3DData === null || filteredTrials === null ? (
        <CircularProgress />
      ) : (
        <Plot
          layout={scatter3DData.layout}
          data={scatter3DData.data ?? []}
          onClick={(event) => {
            const pointNumber = event.points[0].pointNumber;
            console.log(pointNumber);
            // fetch(import.meta.env.VITE_ESMINI_REPLAYER_API_ADDRESS, {
            //   method: "POST",
            //   body: JSON.stringify({
            //     esminiDatUrl: filteredTrials[pointNumber].esminiDat!.url,
            //   }),
            // }).catch((error) => toast.error(error.message));
          }}
        />
      )}
    </Box>
  );
};
