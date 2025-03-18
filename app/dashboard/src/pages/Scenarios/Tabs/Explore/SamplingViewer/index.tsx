import {
  MenuItem,
  Select,
  Stack,
  ToggleButton,
  ToggleButtonGroup,
  Typography,
  Autocomplete,
  Checkbox,
  FormControlLabel,
  TextField,
  Tooltip,
} from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import _ from "lodash";
import {
  Trial,
  SessionBatch,
  useBatchwithTrials,
  useSessionBatches,
} from "src/api/services/Batches";
import Labeler from "src/components/Labeler";
import ParallelCoordinate from "./ParallelCoordinte";
import Scatter2D from "./Scatter2D";
import Scatter3D from "./Scatter3D";
import { resizeObserver } from "src/utils";
import Colorbar from "./Colorbar";
import { kdTree } from "kd-tree-javascript";
import { useParams } from "react-router-dom";
import { useAppSelector } from "src/redux/hooks";

type ViewMode = "boundary" | "analysis" | "all";

export type CriticalityMetric = {
  threshold: number;
  kpi: {
    id: string;
    name: string;
    rule: "greaterThan" | "lessThan";
    unit: string;
  };
  min?: number;
  max?: number;
};

export type Parameter = {
  name: string;
  unit: string;
  min: number;
  max: number;
  id: string;
};

export const getTree = (
  trials: Trial[],
  parameters: {
    [parameterId: string]: Parameter;
  } | null,
) => {
  if (trials === null || trials.length === 0 || parameters === null) {
    return null;
  }

  const points: { [key: string]: number }[] = [];

  for (const [index, trial] of trials.entries()) {
    const point: { [key: string]: number } = {};
    point["index"] = index;
    for (const parameter of trial.parameters) {
      point[parameter.parameterId as string] = parameter.value as number;
    }
    points.push(point);
  }

  const calculateDistance = (
    a: { [key: string]: number },
    b: { [key: string]: number },
  ) => {
    let sum = 0;
    for (const usedParameter of trials[0].parameters) {
      const id = usedParameter.parameterId as string;
      const parameter = parameters[id];
      const bound = [parameter.min, parameter.max];
      const aValue = a[id] / (bound[1] - bound[0]);
      const bValue = b[id] / (bound[1] - bound[0]);
      sum += Math.pow(aValue - bValue, 2);
    }

    return Math.sqrt(sum);
  };

  return new kdTree<{ [key: string]: number }>(
    points,
    calculateDistance,
    trials[0].parameters.map((p: any) => p.parameterId as string),
  );
};

export const scatterModes = ["2D", "3D"] as const;
export type ScatterMode = (typeof scatterModes)[number];

export default function SamplingViewer() {
  const params = useParams();

  const sessionBatches = useSessionBatches(params["sessionId"]);
  const batches = sessionBatches.data?.Batches;
  const sessionBatchesLoading = sessionBatches.isLoading;
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedFailureClusteringResult,
  );
  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.session.selectedTrialIds,
  );

  const batchClusterTrials = useMemo(() => {
    if (clusteringResponse == null) {
      return null;
    }
    const result: {
      [batchId: string]: {
        passed: { [clusterLabel: string]: Set<string> };
        failed: { [clusterLabel: string]: Set<string> };
      };
    } = {};
    Object.values(clusteringResult?.data ?? {}).forEach((item) => {
      for (const [batchId, trialIds] of Object.entries(
        clusteringResponse?.batchTrials ?? {},
      )) {
        const trialSet = new Set<string>(trialIds);
        if (trialSet.has(item.trialId)) {
          if (batchId && !(batchId in result)) {
            result[batchId] = {
              passed: {},
              failed: {},
            };
          }
          const passed =
            item.trialId in clusteringResponse?.boundaryPairs.passed;
          if (!passed) {
            if (!result[batchId].failed[item.label]) {
              result[batchId].failed[item.label] = new Set();
            }
            result[batchId].failed[item.label].add(item.trialId);
          } else {
            if (!result[batchId].passed[item.label]) {
              result[batchId].passed[item.label] = new Set();
            }
            result[batchId].passed[item.label].add(item.trialId);
          }
          break;
        }
      }
    });
    return result;
  }, [clusteringResult]);

  const [selectedSessionBatch, setSelectedSessionBatch] =
    useState<SessionBatch | null>(null);
  const [parameters, setParameters] = useState<{
    [parameterId: string]: Parameter;
  }>({});
  const [metrics, setMetrics] = useState<{
    [kpiId: string]: CriticalityMetric;
  }>({});
  const [selectedMetric, setSelectedMetric] =
    useState<CriticalityMetric | null>(null);
  const [viewMode, setViewMode] = useState<ViewMode>("all");
  const [viewBoundary, setViewBoundary] = useState(false);
  const [viewAnalysis, setViewAnalysis] = useState(false);
  const [viewClusters, setViewClusters] = useState(false);

  const batchWithTrialsQuery = useBatchwithTrials(
    selectedSessionBatch?.id ?? "",
    !!selectedSessionBatch && !!selectedSessionBatch?.id,
  );
  const batchWithTrials = batchWithTrialsQuery.data;
  const batchWithTrialsLoading = batchWithTrialsQuery.isLoading;

  const trials = useMemo(() => {
    if (selectedTrialIds.length > 0 && clusteringResponse) {
      const selectedTrialIdsSet = new Set(selectedTrialIds);
      return batchWithTrials?.trials?.filter(
        (t) =>
          typeof t === "object" &&
          (selectedTrialIdsSet.has(t.id ?? "") ||
            selectedTrialIdsSet.has(
              clusteringResponse.boundaryPairs.failed[t.id ?? ""],
            )),
      );
    }
    return batchWithTrials?.trials?.filter((t) => typeof t === "object");
  }, [batchWithTrials, clusteringResponse, selectedTrialIds]);

  useEffect(() => {
    if (
      !selectedSessionBatch ||
      !batchWithTrials ||
      selectedSessionBatch.id !== batchWithTrials.id
    ) {
      return;
    }
    const updated: { [kpiId: string]: CriticalityMetric } = {};
    for (const metric of selectedSessionBatch.scenario.testObjectives
      ?.criticalityMetrics ?? []) {
      const values = [];
      for (const trial of trials ?? []) {
        const trialMetric = trial.testObjectives?.criticalityMetrics.find(
          (m) =>
            // m.keyPerformanceIndicator.id === metric.keyPerformanceIndicator?.id,
            `${m.keyPerformanceIndicator}` ===
            metric.keyPerformanceIndicator?.id,
        );
        if (!trialMetric) {
          continue;
        }
        values.push(trialMetric.value);
      }
      let min = undefined;
      let max = undefined;
      if (values.length > 0) {
        min = Math.min(...values);
        max = Math.max(...values);
        if (min - max === 0) {
          min = undefined;
          max = undefined;
        }
      }
      updated[metric.keyPerformanceIndicator?.id ?? "unknown"] = {
        threshold: metric.threshold ?? 0,
        kpi: {
          rule: metric.keyPerformanceIndicator?.rule ?? "greaterThan",
          name: metric.keyPerformanceIndicator?.name ?? "unknown",
          unit: metric.keyPerformanceIndicator?.unit ?? "unknown",
          id: metric.keyPerformanceIndicator?.id ?? "unknown",
        },
        min,
        max,
      };
    }
    setMetrics(updated);
  }, [selectedSessionBatch, batchWithTrials]);

  useEffect(() => {
    if (!selectedSessionBatch) {
      return;
    }
    const updated: { [parameterId: string]: Parameter } = {};
    for (const parameter of selectedSessionBatch.scenario.parameters) {
      updated[parameter.id ?? ""] = {
        id: parameter.id ?? "",
        min: parameter.min ?? 0,
        max: parameter.max ?? 1,
        name: parameter.name ?? "unknown",
        unit: parameter.unit ?? "unknown",
      };
    }
    // console.log(selectedSessionBatch);
    // console.log(updated);
    setParameters(updated);
  }, [selectedSessionBatch]);

  useEffect(() => {
    if (Object.keys(metrics).length > 0) {
      let updated: CriticalityMetric | null = null;
      const collision = Object.values(metrics).find(
        (metric) => metric.kpi.name === "collision",
      );
      if (collision) {
        updated = collision;
      } else if (Object.keys(metrics).length > 0) {
        updated = metrics[0];
      }
      setSelectedMetric(updated);
    }
  }, [metrics]);

  const [scatterMode, setScatterMode] = useState<ScatterMode>("2D");
  const [constraintRanges, setConstraintRanges] = useState<{
    [parameterId: string]: [number, number][];
  } | null>(null);

  const [axes, setAxes] = useState<string[] | null>(null);

  const nonSelectedAxes: string[] = [];
  for (const key of Object.keys(parameters ?? {}).sort()) {
    if ((axes ?? []).includes(key)) {
      continue;
    }
    nonSelectedAxes.push(key);
  }

  const tree = useMemo(() => {
    if (!trials || !parameters) {
      return null;
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
      return null;
    }
    return getTree(trials, parameters);
  }, [batchWithTrials, parameters]);

  const boundaryTrialIds = useMemo(() => {
    if (!tree || !selectedMetric) {
      return null;
    }
    const result = new Set<string>();
    for (const trial of trials ?? []) {
      const point: { [parameterId: string]: number } = {};
      let failed = false;
      for (const p of trial.parameters) {
        if (p.parameterId == null || p.value == null) {
          failed = true;
          break;
        }
        point[p.parameterId] = p.value;
      }
      if (failed) {
        continue;
      }
      const nearests = tree.nearest(point, 2);
      if (nearests.length < 2) {
        continue;
      }
      const nearest = nearests[0][0];
      const nearestTrial = trials ? trials[nearest["index"]] : null;
      if (nearestTrial == null) {
        continue;
      }
      const trialMetric = trial.testObjectives?.criticalityMetrics.find(
        // (m) => m.keyPerformanceIndicator.id === selectedMetric.kpi?.id,
        (m) => `${m.keyPerformanceIndicator}` === selectedMetric.kpi?.id,
      );
      const nearestTrialMetric =
        nearestTrial.testObjectives?.criticalityMetrics.find(
          // (m) => m.keyPerformanceIndicator.id === selectedMetric.kpi?.id,
          (m) => `${m.keyPerformanceIndicator}` === selectedMetric.kpi?.id,
        );
      if (trialMetric == null || nearestTrialMetric == null) {
        continue;
      }
      if (trialMetric.passed !== nearestTrialMetric.passed) {
        result.add(trial.id ?? "");
        result.add(nearestTrial.id ?? "");
      }
    }
    return result;
  }, [tree, selectedMetric]);

  const analysisTrialIds = useMemo(() => {
    const result = new Set<string>();
    if (clusteringResponse) {
      for (const trialId of Object.keys(
        clusteringResponse.boundaryDiffClustering.results[0].data,
      )) {
        result.add(trialId);
        const failedId = clusteringResponse.boundaryPairs.passed[trialId];
        if (failedId) {
          result.add(failedId);
        }
      }
    }
    return result;
  }, [clusteringResponse]);

  useEffect(() => {
    if (!parameters) {
      return;
    }
    setAxes(Object.keys(parameters).slice(0, scatterMode === "2D" ? 2 : 3));
  }, [parameters, scatterMode]);

  useEffect(() => {
    const element = document.getElementById(
      "session-batches-parameter-space-root",
    );
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
      sx={{ p: 2, overflowY: "scroll", height: "100%" }}
      id="session-batches-parameter-space-root"
    >
      <Stack direction="row" columnGap={2} rowGap={2} flexWrap="wrap">
        <Labeler label="batch">
          <Autocomplete
            size="small"
            disablePortal
            options={batches?.docs ?? []}
            sx={{ minWidth: 300 }}
            getOptionLabel={(batch) => batch?.scenario.name ?? ""}
            renderInput={(params) => <TextField {...params} />}
            onChange={(_event, value) => setSelectedSessionBatch(value ?? null)}
          />
        </Labeler>
        <Labeler label="metric">
          <Select
            size="small"
            value={selectedMetric?.kpi.id ?? ""}
            renderValue={(value) =>
              value in metrics ? metrics[value].kpi.name : value
            }
            onChange={(event) => setSelectedMetric(metrics[event.target.value])}
          >
            {Object.values(metrics).map((metric, index) => {
              return (
                <MenuItem key={metric.kpi.id ?? index} value={metric.kpi.id}>
                  {metric.kpi.name ?? "unknown"}
                </MenuItem>
              );
            })}
          </Select>
        </Labeler>
      </Stack>
      <Colorbar
        sx={{ mt: 3 }}
        metric={selectedMetric}
        loading={sessionBatchesLoading || batchWithTrialsLoading}
      />
      <ParallelCoordinate
        metric={selectedMetric}
        parameters={parameters}
        trials={trials ?? null}
        setConstraintRanges={setConstraintRanges}
        constraintRanges={constraintRanges}
        loading={sessionBatchesLoading || batchWithTrialsLoading}
      />
      <Stack
        direction="row"
        flexWrap="wrap"
        rowGap={2}
        columnGap={2}
        sx={{ mb: 2 }}
      >
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
              <ToggleButton key={mode} value={mode}>
                {mode}
              </ToggleButton>
            ))}
          </ToggleButtonGroup>
        ) : null}
        {/* <Tooltip */}
        {/*   title="if its nearest neighbor has different test result" */}
        {/*   placement="top" */}
        {/* > */}
        {/*   <FormControlLabel */}
        {/*     control={ */}
        {/*       <Checkbox */}
        {/*         checked={viewBoundary} */}
        {/*         onChange={(_event, checked) => setViewBoundary(checked)} */}
        {/*       /> */}
        {/*     } */}
        {/*     label="boundary" */}
        {/*   /> */}
        {/* </Tooltip> */}
        <ToggleButtonGroup
          color="primary"
          value={viewMode}
          exclusive
          onChange={(_event, value) => setViewMode(value)}
          aria-label="Platform"
        >
          <ToggleButton value="all">All</ToggleButton>
          <ToggleButton value="boundary">Boundary</ToggleButton>
          <ToggleButton value="analysis">Analysis</ToggleButton>
        </ToggleButtonGroup>
        {/* <FormControlLabel */}
        {/*   control={ */}
        {/*     <Checkbox */}
        {/*       checked={viewClusters} */}
        {/*       onChange={(_event, checked) => setViewClusters(checked)} */}
        {/*     /> */}
        {/*   } */}
        {/*   label="clusters" */}
        {/* /> */}
      </Stack>
      <Stack direction="row" flexWrap="wrap" rowGap={2} columnGap={2}>
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
        <Scatter2D
          axes={axes}
          metric={selectedMetric}
          parameters={parameters}
          trials={trials ?? null}
          boundaryTrialIds={
            viewMode === "boundary"
              ? boundaryTrialIds
              : viewMode === "analysis"
                ? analysisTrialIds
                : null
          }
          constraintRanges={constraintRanges}
          loading={sessionBatchesLoading || batchWithTrialsLoading}
        />
      ) : (
        <Scatter3D
          axes={axes}
          metric={selectedMetric}
          parameters={parameters}
          boundaryTrialIds={
            viewMode === "boundary"
              ? boundaryTrialIds
              : viewMode === "analysis"
                ? analysisTrialIds
                : null
          }
          trials={trials ?? null}
          constraintRanges={constraintRanges}
          loading={sessionBatchesLoading || batchWithTrialsLoading}
          // batchClusterTrials={batchClusterTrials}
        />
      )}
    </Stack>
  );
}
