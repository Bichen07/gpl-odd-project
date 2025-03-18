import {
  Autocomplete,
  Box,
  Divider,
  Grid,
  MenuItem,
  Select,
  Skeleton,
  Stack,
  Switch,
  SxProps,
  TextField,
  Typography,
} from "@mui/material";
import { Theme } from "@mui/material/styles";
import { useTheme } from "@emotion/react";
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import TrialService from "src/axios/services/Trials";
import Labeler from "src/components/Labeler";
import { useAppSelector, useAppDispatch } from "src/redux/hooks";
import {
  setCriticalityMetrics,
  setSelectedCriticalityMetricId,
  setOutputFilterMin,
  setOutputFilterMax,
  setInterfaceLoading,
  setFilteredTrialIndices,
  setFilterLoading,
  setTrials,
  Parameters,
  setParameters,
  CriticalityMetrics,
  setUsingBoundaryKNN,
  setKNearestNeighbors,
  setModalOpen,
  setColorbarData,
  setColorScale,
  getTree,
} from "src/redux/slices/trialFilters";
import TextFieldSkeleton from "src/components/TextFieldSkeleton";
import {
  CriticalityMetric as PayloadCriticalityMetric,
  Trial,
} from "payload/payload-types";
import { toast } from "react-toastify";
import SearchService from "src/axios/services/Searches";
import LoadingButton from "@mui/lab/LoadingButton";
import ModalTable from "./ModalTable";
import TableChartIcon from "@mui/icons-material/TableChart";
import { ColorScale } from "plotly.js-basic-dist";

type Props = {
  sx?: SxProps;
};
const TrialFilters = ({ sx }: Props) => {
  const theme = useTheme() as Theme;
  const params = useParams();

  const scenario = useAppSelector((state) => state.scenario.data);
  const selectedClientId = useAppSelector((state) => state.client.selectedId);

  const interfaceLoading = useAppSelector(
    (state) => state.trialFilters.interfaceLoading
  );
  const filterLoading = useAppSelector(
    (state) => state.trialFilters.filterLoading
  );

  const parameters = useAppSelector((state) => state.trialFilters.parameters);

  const criticalityMetrics = useAppSelector(
    (state) => state.trialFilters.criticalityMetrics
  );
  const selectedCriticalityMetricId = useAppSelector(
    (state) => state.trialFilters.selectedCriticalityMetricId
  );
  const outputFilterMin = useAppSelector(
    (state) => state.trialFilters.outputFilterMin
  );
  const outputFilterMax = useAppSelector(
    (state) => state.trialFilters.outputFilterMax
  );

  const usingBoundaryKNN = useAppSelector(
    (state) => state.trialFilters.usingBoundaryKNN
  );
  const kNearestNeighbors = useAppSelector(
    (state) => state.trialFilters.kNearestNeighbors
  );

  const trials = useAppSelector((state) => state.trialFilters.trials);
  const filteredTrialIds = useAppSelector(
    (state) => state.trialFilters.filteredTrialIds
  );

  const tableData = useAppSelector((state) => state.trialFilters.tableData);

  const tree = useAppSelector(getTree);

  const dispatch = useAppDispatch();

  const [selectedTrialIds, setSelectedTrialIds] = useState<string[]>([]);

  useEffect(() => {
    if (scenario === null) {
      return;
    }
    SearchService.getSearchs({
      depth: 2,
      where: {
        and: [
          { client: { equals: selectedClientId } },
          { scenario: { equals: params["id"] } },
        ],
      },
    }).then((response) => {
      const updatedParameters: Parameters = {};
      for (const [index, parameter] of scenario.parameters.entries()) {
        let min = Infinity;
        let max = -Infinity;
        for (const search of response.data.docs) {
          const id = parameter.id;
          const parameterRanges = search.parameterRanges;
          const found = parameterRanges.find(
            (r) => r.parameterId === parameter.id
          );
          if (
            found === undefined ||
            found.min === undefined ||
            found.max === undefined
          ) {
            toast.error(
              `Error occurs finding parameter id ${id} in search ${search.id}`
            );
            continue;
          }
          min = Math.min(found.min as number, min);
          max = Math.max(found.max as number, max);
        }
        updatedParameters[parameter.id!] = {
          index,
          min,
          max,
          id: parameter.id!,
          name: parameter.name,
          unit: parameter.unit,
        };
      }
      dispatch(setParameters(updatedParameters));
    });
  }, [scenario]);

  useEffect(() => {
    if (scenario === null) {
      return;
    }
    const criticalityMetric = scenario.safetyRequirements[0]
      .criticalityMetric as PayloadCriticalityMetric;
    dispatch(setSelectedCriticalityMetricId(criticalityMetric.id));
  }, [scenario]);

  useEffect(() => {
    if (scenario === null) {
      return;
    }
    TrialService.getTrials({
      where: {
        "search.scenario": {
          contains: params["id"],
        },
      },
      depth: 2,
      limit: 100000,
    })
      .then((response) => {
        console.log("help");
        console.log(response);
        if (response.data.docs.length === 0) {
          dispatch(setTrials({}));
          dispatch(setOutputFilterMin(0));
          dispatch(setOutputFilterMax(0));
          return;
        }
        const newTrials: { [id: string]: Trial } = {};
        for (const doc of response.data.docs) {
          newTrials[doc.id] = doc;
        }
        dispatch(setTrials(newTrials));
      })
      .catch((error) => {
        console.log("error");
        console.log(error);
      });
  }, [scenario]);

  useEffect(() => {
    if (
      selectedCriticalityMetricId === null ||
      scenario === null ||
      trials === null
    ) {
      return;
    }
    const newCriticalityMetrics: CriticalityMetrics = {};
    for (const [
      index,
      safetyRequirement,
    ] of scenario.safetyRequirements.entries()) {
      const criticalityMetric =
        safetyRequirement.criticalityMetric as PayloadCriticalityMetric;
      const metricValues = Object.values(trials).map(
        (doc) => doc.safetyRequirements[index].value
      );
      metricValues.sort();
      newCriticalityMetrics[criticalityMetric.id] = {
        index,
        unit: criticalityMetric.unit,
        id: criticalityMetric.id,
        name: criticalityMetric.name,
        rule: criticalityMetric.rule,
        threshold: safetyRequirement.threshold,
        min: metricValues[0],
        max: metricValues[metricValues.length - 1],
      };
    }
    dispatch(setCriticalityMetrics(newCriticalityMetrics));
    dispatch(
      setOutputFilterMin(newCriticalityMetrics[selectedCriticalityMetricId].min)
    );
    dispatch(
      setOutputFilterMax(newCriticalityMetrics[selectedCriticalityMetricId].max)
    );
  }, [scenario, selectedCriticalityMetricId, trials]);

  useEffect(() => {
    if (
      trials === null ||
      criticalityMetrics === null ||
      selectedCriticalityMetricId === null ||
      outputFilterMin === null ||
      outputFilterMax === null ||
      parameters === null ||
      tree === null ||
      scenario === null
    ) {
      return;
    }
    dispatch(setInterfaceLoading(false));
  }, [
    selectedCriticalityMetricId,
    outputFilterMin,
    outputFilterMax,
    criticalityMetrics,
    trials,
    parameters,
    tree,
    scenario,
  ]);

  useEffect(() => {
    if (!filterLoading) {
      return;
    }
    if (
      trials === null ||
      criticalityMetrics === null ||
      selectedCriticalityMetricId === null ||
      outputFilterMin === null ||
      outputFilterMax === null ||
      parameters === null ||
      tree === null
    ) {
      return;
    }

    const kNeighborsFilterDeleted = new Set<number>();
    const rangeFilterDeleted = new Set<number>();

    const trialArray = Object.values(trials);
    for (const [index, trial] of trialArray.entries()) {
      kNeighborsFilterDeleted.add(index);

      if (rangeFilterDeleted.has(index)) {
        continue;
      }

      const outputValue = trial.safetyRequirements[
        criticalityMetrics[selectedCriticalityMetricId].index
      ].value as number;

      if (outputValue < outputFilterMin) {
        rangeFilterDeleted.add(index);
      } else if (outputValue > outputFilterMax) {
        rangeFilterDeleted.add(index);
      }
    }

    // console.log(textAreaValue);
    const textAreaTrialIds = textAreaValue.split(",");
    console.log(textAreaTrialIds);

    const deleted = rangeFilterDeleted;
    if (usingBoundaryKNN) {
      for (const [index, trial] of trialArray.entries()) {
        if (
          selectedTrialIds.length > 0 &&
          trial.id &&
          (textAreaTrialIds.find((item) => item === trial.id) === undefined ||
            textAreaTrialIds.find((item) => item === trial.id) === undefined)
        ) {
          continue;
        }
        const point: { [key: string]: number } = {};
        point["index"] = index;
        for (const trialParameter of trial.parameters) {
          point[trialParameter.parameterId as string] =
            trialParameter.value as number;
        }

        let isBoundary = false;
        const neighbors = tree.nearest(point, kNearestNeighbors + 1);
        const currentPassed =
          trial.safetyRequirements[
            criticalityMetrics[selectedCriticalityMetricId].index
          ].passed;

        for (const neighbor of neighbors) {
          const neighborPassed =
            trialArray[neighbor[0]["index"]].safetyRequirements[
              criticalityMetrics[selectedCriticalityMetricId].index
            ].passed;

          const isSameResult = currentPassed === neighborPassed;
          if (!isSameResult) {
            isBoundary = true;
          }
        }
        if (isBoundary) {
          for (const neighbor of neighbors) {
            kNeighborsFilterDeleted.delete(neighbor[0]["index"]);
          }
          kNeighborsFilterDeleted.delete(index);
        }
      }

      for (const key of kNeighborsFilterDeleted) {
        deleted.add(key);
      }
    }

    const newFilteredTrialIds: string[] = [];
    for (const [index, trial] of trialArray.entries()) {
      if (deleted.has(index)) {
        continue;
      }
      newFilteredTrialIds.push(trial.id);
    }
    dispatch(setFilteredTrialIndices(newFilteredTrialIds));
  }, [interfaceLoading, filterLoading]);

  useEffect(() => {
    if (filteredTrialIds === null) {
      return;
    }
    dispatch(setFilterLoading(false));
  }, [filteredTrialIds]);

  useEffect(() => {
    if (
      trials === null ||
      criticalityMetrics === null ||
      selectedCriticalityMetricId === null
    ) {
      return;
    }

    const metricValues = Object.values(trials).map(
      (doc) =>
        doc.safetyRequirements[
          criticalityMetrics[selectedCriticalityMetricId].index
        ].value as number
    );
    const min = Math.min(...metricValues);
    const max = Math.max(...metricValues);

    const threshold = criticalityMetrics[selectedCriticalityMetricId].threshold;
    const rule = criticalityMetrics[selectedCriticalityMetricId].rule;

    const colors = [
      theme.palette.error.main,
      theme.palette.warning.light,
      theme.palette.success.main,
    ];
    dispatch(
      setColorbarData({
        ticks: [min, threshold, max],
        colors: rule === "greaterThan" ? colors : colors.reverse(),
      })
    );

    const updatedColorscale: ColorScale = [
      [0.0, colors[0]],
      [threshold / (max - min), colors[1]],
      [1.0, colors[2]],
    ];
    dispatch(setColorScale(updatedColorscale));
  }, [trials, criticalityMetrics, selectedCriticalityMetricId]);

  const [textAreaValue, setTextAreaValue] = useState<string>("");

  return (
    <Box sx={sx}>
      <ModalTable />
      {interfaceLoading ? (
        <Skeleton width="50px" animation="wave" />
      ) : (
        <Typography variant="subtitle1">Trial Filters</Typography>
      )}
      <Grid
        container
        spacing={[2, 2, 10]}
        sx={{
          ".MuiInputBase-root.restrict": {
            maxWidth: ["100px", "150px"],
            flexShrink: 1,
          },
        }}
      >
        <Grid item xs={12} md={6}>
          <Stack
            direction="row"
            className=".outputGroup"
            sx={{
              rowGap: 0.5,
              columnGap: 2,
            }}
          >
            {criticalityMetrics === null ||
            selectedCriticalityMetricId === null ||
            interfaceLoading ? (
              <TextFieldSkeleton />
            ) : (
              <Labeler label="output">
                <Select
                  value={selectedCriticalityMetricId}
                  renderValue={(id: string) => criticalityMetrics[id].name}
                  size="small"
                  onChange={(event) => {
                    dispatch(
                      setSelectedCriticalityMetricId(
                        criticalityMetrics[event.target.value].id
                      )
                    );
                  }}
                >
                  {Object.values(criticalityMetrics).map((item, index) => {
                    return (
                      <MenuItem key={index} value={item.id}>
                        {item.name}
                      </MenuItem>
                    );
                  })}
                </Select>
              </Labeler>
            )}
            {interfaceLoading ? (
              <TextFieldSkeleton />
            ) : (
              <Labeler label="output min">
                <TextField
                  type="number"
                  value={outputFilterMin}
                  size="small"
                  onChange={(event) =>
                    dispatch(setOutputFilterMin(Number(event.target.value)))
                  }
                />
              </Labeler>
            )}
            {interfaceLoading ? (
              <TextFieldSkeleton />
            ) : (
              <Labeler label="output max">
                <TextField
                  type="number"
                  size="small"
                  value={outputFilterMax}
                  onChange={(event) =>
                    dispatch(setOutputFilterMax(Number(event.target.value)))
                  }
                />
              </Labeler>
            )}
          </Stack>
        </Grid>
        <Grid item xs={12} md={6}>
          <Stack direction="row" spacing={2} className=".KNNGroup">
            {interfaceLoading ? (
              <TextFieldSkeleton />
            ) : (
              <Labeler label="boundary knn">
                <Switch
                  checked={usingBoundaryKNN}
                  onChange={(_event, checked) =>
                    dispatch(setUsingBoundaryKNN(checked))
                  }
                />
              </Labeler>
            )}
            {interfaceLoading ? (
              <TextFieldSkeleton />
            ) : (
              <Labeler label="k" disabled={!usingBoundaryKNN}>
                <TextField
                  disabled={!usingBoundaryKNN}
                  type="number"
                  size="small"
                  value={kNearestNeighbors}
                  onChange={(e) =>
                    dispatch(setKNearestNeighbors(Number(e.target.value)))
                  }
                />
              </Labeler>
            )}
            {trials === null ? (
              <TextFieldSkeleton />
            ) : (
              <Autocomplete
                multiple
                sx={{ width: "100%" }}
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
          </Stack>
        </Grid>
        <Grid item xs={12}>
          {trials === null ? (
            <TextFieldSkeleton />
          ) : (
            <Labeler label="trialIds with comma">
              <TextField
                multiline
                value={textAreaValue}
                onChange={(event) => setTextAreaValue(event.target.value)}
              />
            </Labeler>
          )}
        </Grid>
      </Grid>
      <Stack spacing={2} sx={{ mt: 2 }}>
        <Divider />
        <LoadingButton
          loading={filterLoading}
          onClick={() => dispatch(setFilterLoading(true))}
          sx={{ width: "100%" }}
          variant="contained"
        >
          Filter
        </LoadingButton>
        <Stack direction="row" spacing={2} alignItems="center">
          {filterLoading || filteredTrialIds === null || trials === null ? (
            <Skeleton width="20ch" />
          ) : (
            <Typography variant="subtitle2">{`Filter:  ${
              filteredTrialIds.length
            } / ${Object.keys(trials).length}`}</Typography>
          )}
          <LoadingButton
            size="small"
            variant="contained"
            startIcon={<TableChartIcon />}
            loading={filterLoading && tableData === null}
            onClick={() => dispatch(setModalOpen(true))}
          >
            List Filtered Trials
          </LoadingButton>
        </Stack>
        <Divider />
      </Stack>
    </Box>
  );
};

export default TrialFilters;
