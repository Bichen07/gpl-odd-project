import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import chroma from "chroma-js";
import { useTheme } from "@mui/material/styles";
import { ParallelCoordinate } from "./Plot";
import { useEffect, useMemo, useState } from "react";
import { Stack, Typography } from "@mui/material";
import {
  // getSelectedClusterInfo,
  // getSelectedClusteringResult,
  sessionSlice,
} from "src/redux/slices/session";
import { ColorMode } from "../../EmbeddingSpace/Scatter";
import { getCriticalityMetricColor } from "src/utils";
import { useKpis } from "src/api/services/KeyPerformanceIndicators";
import { SessionBatch, useSessionBatches } from "src/api/services/Batches";
import { useParams } from "react-router-dom";
import { ClusteringResult } from "src/api/services/Clustering";

type Props = {
  clusterLabel: string | undefined;
  colorMode: ColorMode;
};
export default function ParallelCoordinates({
  clusterLabel,
  colorMode,
}: Props) {
  const params = useParams();
  const theme = useTheme();
  const dispatch = useAppDispatch();

  const kpis = useKpis().data;
  const batches = useSessionBatches(params["sessionId"]).data;

  const clusteringRespose = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const clusteringResult = useAppSelector(getSelectedClusteringResult);
  const clusterInfo = useAppSelector(getSelectedClusterInfo);
  const hoveredTrialId = useAppSelector(
    (state) => state.session.hoveredTrialId,
  );
  const [isNearestInPlots, setIsNearestInPlots] = useState<Set<string>>(
    new Set<string>(),
  );
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedCluster,
  );

  const selectedKpi = useMemo(() => {
    if (!kpis || !clusteringRespose) {
      return;
    }
    return kpis.docs?.find(
      (kpi) => kpi?.id === clusteringRespose.request.kpiId,
    );
  }, [kpis, clusteringRespose]);

  // const embeddingPoints = useAppSelector((state) => state.session.points);

  useEffect(() => {
    setIsNearestInPlots(new Set<string>());
  }, [clusterLabel]);

  const data = useMemo(() => {
    if (
      !clusterLabel ||
      !clusterInfo ||
      !clusteringResult ||
      !clusteringRespose ||
      !clusteringRespose.trials ||
      !batches
    ) {
      return {};
    }
    const trials = clusteringRespose.trials;
    const result: {
      [batchId: string]: {
        batch: SessionBatch | null;
        bounds: { [key: string]: { min: number; max: number } };
        data: { [key: string]: number | string }[];
      };
    } = {};
    for (const item of Object.values(clusteringResult.data)) {
      if (item.label !== clusterLabel) {
        continue;
      }
      // if (!(item.trialId in embeddingPoints)) {
      //   continue;
      // }
      // if (embeddingPoints[item.trialId].disable) {
      //   continue;
      // }

      let found = clusteringRespose?.trials[item.trialId].batchId;
      if (found && !(found in result)) {
        result[found] = { bounds: {}, data: [], batch: null };
      }
      const trial = trials[item.trialId];
      const batch = batches.Batches?.docs?.find((b) => b?.id === trial.batchId);

      if (trial && batch) {
        result[found].batch = batch;
        const row: { [key: string]: number | string } = {};
        for (const parameter of trial.parameters) {
          const parameterName =
            batch.scenario.parameters.find(
              (p) => p.id === parameter.parameterId,
            )?.name ?? "";
          row[parameterName] = parameter.value ?? NaN;

          if (batch.id && !(batch.id in result[batch.id])) {
            const parameterConfig = batch.scenario.parameters.find(
              (p) => p.id === parameter.parameterId,
            );
            if (parameterConfig && parameterConfig.min && parameterConfig.max) {
              result[batch.id ?? ""].bounds[parameterName] = {
                min: parameterConfig.min,
                max: parameterConfig.max,
              };
            }
          }
        }
        row["group"] = item.label;
        row["trialId"] = item.trialId;

        const alpha = 0.1;

        let color = chroma(clusterInfo[item.label].color).alpha(alpha).hex();

        if (selectedCluster && trials && selectedKpi) {
          color = chroma(
            getCriticalityMetricColor(trials[item.trialId], selectedKpi, theme),
          )
            .alpha(alpha)
            .hex();
        }

        row["color"] = color;

        result[found].data.push(row);
      }
    }
    return result;
  }, [
    clusteringResult,
    clusterLabel,
    batches,
    selectedKpi,
    selectedCluster,
    // embeddingPoints,
  ]);

  useEffect(() => {
    const batchIds = new Set(Object.keys(data));
    if (isNearestInPlots.size > 0) {
      const batchId = [...isNearestInPlots][0];
      batchIds.delete(batchId);
      const result: string[] = [];
      for (const batchId of batchIds) {
        for (const item of data[batchId].data) {
          result.push(item["trialId"] as string);
        }
      }
      // dispatch(sessionSlice.actions.setBlackedOutTrialIds(new Set(result)));
    } else {
      // dispatch(sessionSlice.actions.setBlackedOutTrialIds(new Set()));
    }
  }, [isNearestInPlots, data]);

  return (
    <Stack sx={{ p: 2 }}>
      {Object.keys(data)
        // .sort((batchId1, batchId2) =>
        //   isNearestInPlots.size > 0
        //     ? data[batchId2].data.length - data[batchId1].data.length
        //     : Number(batchTrialMappings[batchId2].has(hoveredTrialId ?? "")) -
        //       Number(batchTrialMappings[batchId1].has(hoveredTrialId ?? "")),
        // )
        .map((batchId) => (
          <Stack>
            <Typography sx={{ mt: 2, fontSize: 14 }} align="center">
              {`${data[batchId].batch?.scenario.name ?? ""} (${
                data[batchId].data.length
              })`}
            </Typography>
            <ParallelCoordinate
              batchId={batchId}
              setIsNearestInPlots={setIsNearestInPlots}
              data={data[batchId]}
              variables={Object.keys(data[batchId].bounds)}
              colorMode={colorMode}
            />
          </Stack>
        ))}
    </Stack>
  );
}
