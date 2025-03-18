import TableChart from "@mui/icons-material/TableChart";
import LoadingButton from "@mui/lab/LoadingButton";
import {
  Box,
  Checkbox,
  Divider,
  ListItemIcon,
  ListItemText,
  MenuItem,
  Select,
  Skeleton,
  Stack,
  Typography,
} from "@mui/material";
import { useEffect } from "react";
import ObservationService from "src/axios/services/Observations";
import Labeler from "src/components/Labeler";
import TextFieldSkeleton from "src/components/TextFieldSkeleton";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import {
  ClusterMemberData,
  ClusteringSpace,
  FinalObservations,
  Representations,
  TimeSeriesRepresentation,
  clusteringSpaces,
  resetClusters,
  setAttributes,
  setClusterMemberData,
  setClusteringSpace,
  setClusters,
  setFinalObservations,
  setRepresentation,
  setRepresentations,
  setRepresentationsModalTableOpen,
  setSelectedAttributes,
  timeSeriesRepresentations,
} from "src/redux/slices/timeSeriesClustering";
import { observationDocsToRows, titleizeCamelCase } from "src/utils";
import RepresentationsModalTable from "./RepresentationsModalTable";
import distinctColors from "distinct-colors";
import { toast } from "react-toastify";

export default () => {
  const dispatch = useAppDispatch();
  const scenario = useAppSelector((state) => state.scenario.data);
  const clientId = useAppSelector((state) => state.client.selectedId);

  const representation = useAppSelector(
    (state) => state.timeSeriesClustering.representation
  );
  const clusteringSpace = useAppSelector(
    (state) => state.timeSeriesClustering.clusteringSpace
  );
  const attributes = useAppSelector(
    (state) => state.timeSeriesClustering.attributes
  );
  const selectedAttributes = useAppSelector(
    (state) => state.timeSeriesClustering.selectedAttributes
  );
  const finalObservations = useAppSelector(
    (state) => state.timeSeriesClustering.finalObservations
  );
  const representations = useAppSelector(
    (state) => state.timeSeriesClustering.representations
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.trialFilters.filteredTrialIds
  );
  const clusters = useAppSelector(
    (state) => state.timeSeriesClustering.clusters
  );

  const isAllSelected =
    attributes !== null &&
    selectedAttributes !== null &&
    attributes.length > 0 &&
    selectedAttributes.length === attributes.length;

  useEffect(() => {
    if (scenario === null) {
      return;
    }
    ObservationService.getObservations({
      where: {
        "trial.scenario": scenario.id,
      },
      limit: 1,
    }).then((response) => {
      if (response.data.docs.length === 0) {
        dispatch(setAttributes([]));
        return;
      }
      const observationRow = observationDocsToRows(response.data.docs)[0];
      dispatch(
        setAttributes(
          Object.keys(observationRow).filter(
            (name) =>
              !(
                name.includes("Id") ||
                name.includes("time") ||
                name === "egoS" ||
                (!name.includes("ego") && !name.includes("Local")) ||
                name.includes("isFinal")
              )
          )
        )
      );
    });
  }, [scenario]);

  useEffect(() => {
    if (
      representation !== "finalObservation" ||
      finalObservations !== null ||
      scenario === null
    ) {
      return;
    }
    ObservationService.getObservations({
      limit: 100000,
      depth: 0,
      where: {
        and: [
          {
            isFinal: { equals: true },
          },
          {
            "trial.search.scenario": { equals: scenario.id },
          },
          {
            "trial.search.client": { equals: clientId },
          },
        ],
      },
    }).then((response) => {
      const newFinalObservations: FinalObservations = {};
      for (const observation of response.data.docs) {
        const trialId = observation.trial as string;
        newFinalObservations[trialId] = observation;
      }
      dispatch(setFinalObservations(newFinalObservations));
    });
  }, [finalObservations, scenario]);

  useEffect(() => {
    if (
      representations !== null ||
      filteredTrialIds === null ||
      finalObservations === null
    ) {
      return;
    }
    if (
      selectedAttributes.length === 0 ||
      filteredTrialIds.length === 0 ||
      Object.keys(finalObservations).length === 0
    ) {
      dispatch(setRepresentations({}));
      return;
    }
    const filteredTrialSet = new Set(filteredTrialIds);
    const newRepresentations: Representations = {};
    for (const [trialId, observation] of Object.entries(finalObservations)) {
      if (!filteredTrialSet.has(trialId)) {
        continue;
      }
      const observationRow = observationDocsToRows([observation])[0];
      const point: number[] = [];
      for (const attribute of selectedAttributes) {
        point.push(observationRow[attribute] as number);
      }
      newRepresentations[trialId] = point;
    }
    dispatch(setRepresentations(newRepresentations));
  }, [
    representations,
    filteredTrialIds,
    finalObservations,
    selectedAttributes,
  ]);

  useEffect(() => {
    if (representations === null) {
      return;
    }
    if (Object.keys(representations).length === 0) {
      dispatch(setClusters({}));
      return;
    }
    ObservationService.getTimeSeriesClusters({
      representations,
      clusteringSpace,
    })
      .then((response) => {
        dispatch(setClusters(response.data));
        const newClusterMemberData: ClusterMemberData = {};
        for (const [_trialId, cluster] of Object.entries(response.data)) {
          if (!(cluster.cluster in newClusterMemberData)) {
            newClusterMemberData[cluster.cluster] = {
              color: "#000000",
              count: 0,
              means: {},
            };
          }
          newClusterMemberData[cluster.cluster].count += 1;
        }
        let hasNoise = false;
        let uniqueClusterCount = Object.keys(newClusterMemberData).length;
        if (-1 in newClusterMemberData) {
          uniqueClusterCount -= 1;
          hasNoise = true;
        }
        const palette = distinctColors({
          count: uniqueClusterCount,
          chromaMin: 30,
          chromaMax: 80,
          lightMin: 35,
          lightMax: 80,
        });
        const keys = Object.keys(newClusterMemberData)
          .sort()
          .map((key) => Number(key));
        for (const [index, key] of keys.entries()) {
          if (key === -1) {
            continue;
          }
          newClusterMemberData[key].color =
            palette[hasNoise ? index - 1 : index].css();
        }
        for (const [
          attributeIndex,
          attribute,
        ] of selectedAttributes.entries()) {
          for (const uniqueNumber of Object.keys(newClusterMemberData)) {
            let mean = 0;
            for (const [trialId, rep] of Object.entries(representations)) {
              if (response.data[trialId].cluster !== Number(uniqueNumber)) {
                continue;
              }
              mean += rep[attributeIndex];
            }
            mean /= newClusterMemberData[Number(uniqueNumber)].count;
            newClusterMemberData[Number(uniqueNumber)].means[attribute] = mean;
          }
        }
        dispatch(setClusterMemberData(newClusterMemberData));
      })
      .catch((error) => {
        toast.error(error);
        console.error(error);
        dispatch(setClusters({}));
      });
  }, [representations]);

  return (
    <Box sx={{ mt: 2 }}>
      <RepresentationsModalTable />
      <Typography variant="subtitle1">Time Series Clustering</Typography>
      <Stack spacing={2} direction="row">
        <Labeler label="representation">
          <Select
            value={representation}
            renderValue={(value) => titleizeCamelCase(value)}
            size="small"
            onChange={(event) => {
              dispatch(
                setRepresentation(
                  event.target.value as TimeSeriesRepresentation
                )
              );
            }}
          >
            {timeSeriesRepresentations.map((item, index) => {
              return (
                <MenuItem
                  key={index}
                  value={item}
                  disabled={item === "deepEmbedding"}
                >
                  {titleizeCamelCase(item)}
                </MenuItem>
              );
            })}
          </Select>
        </Labeler>
        <Labeler label="clustering space">
          <Select
            value={clusteringSpace}
            size="small"
            onChange={(event) => {
              dispatch(
                setClusteringSpace(event.target.value as ClusteringSpace)
              );
            }}
          >
            {clusteringSpaces.map((item, index) => {
              return (
                <MenuItem
                  key={index}
                  value={item}
                  disabled={item === "original"}
                >
                  {item}
                </MenuItem>
              );
            })}
          </Select>
        </Labeler>
        {attributes === null ? (
          <TextFieldSkeleton />
        ) : (
          <Labeler
            sx={{
              flexGrow: 1,
              ".MuiInputBase-root": {
                maxWidth: "none",
                flexShrink: 1,
                flexGrow: 1,
              },
            }}
            label="attributes"
          >
            <Select
              multiple
              size="small"
              value={selectedAttributes}
              sx={{ width: 300 }}
              onChange={(event) => {
                const value = event.target.value;
                if (value[value.length - 1] === "all") {
                  dispatch(
                    setSelectedAttributes(
                      selectedAttributes.length === attributes.length
                        ? []
                        : attributes
                    )
                  );
                  return;
                }
                dispatch(
                  setSelectedAttributes(
                    typeof value === "string" ? [value] : value
                  )
                );
              }}
              renderValue={(selected) => selected.join(", ")}
            >
              <MenuItem value="all">
                <ListItemIcon>
                  <Checkbox
                    checked={isAllSelected}
                    indeterminate={
                      selectedAttributes.length > 0 &&
                      selectedAttributes.length < attributes.length
                    }
                  />
                </ListItemIcon>
                <ListItemText primary="Select All" />
              </MenuItem>
              {attributes.map((option) => (
                <MenuItem key={option} value={option}>
                  <ListItemIcon>
                    <Checkbox
                      checked={selectedAttributes.indexOf(option) > -1}
                    />
                  </ListItemIcon>
                  <ListItemText primary={option} />
                </MenuItem>
              ))}
            </Select>
          </Labeler>
        )}
      </Stack>
      <Stack spacing={2} sx={{ mt: 2 }}>
        <Divider />
        <LoadingButton
          loading={clusters === null}
          onClick={() => {
            dispatch(resetClusters());
          }}
          sx={{ width: "100%" }}
          variant="contained"
        >
          Cluster
        </LoadingButton>
        <Stack direction="row" spacing={2} alignItems="center">
          {representations === null ? (
            <Skeleton width="15ch" />
          ) : (
            <Typography variant="subtitle2">{`Representation Counts:  ${Object.keys(representations).length
              }`}</Typography>
          )}
          {clusters === null ? (
            <Skeleton width="15ch" />
          ) : (
            <Typography variant="subtitle2">{`Cluster Counts:  ${Math.max(
              ...Object.values(clusters).map((cluster) => cluster.cluster)
            )}`}</Typography>
          )}
          <LoadingButton
            size="small"
            variant="contained"
            startIcon={<TableChart />}
            loading={clusters === null}
            onClick={() => dispatch(setRepresentationsModalTableOpen(true))}
          >
            List Representations & Clusters
          </LoadingButton>
        </Stack>
        <Divider />
      </Stack>
    </Box>
  );
};
