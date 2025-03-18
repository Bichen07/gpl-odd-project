import qs from "qs";
import http from "src/axios/http-common";
import { Observation } from "payload/payload-types";
import { BulkResponseData } from "src/axios/common";
import { TimeSeriesRepresentation } from "src/redux/slices/timeSeriesClustering";
import {
  ClusteringSpace,
  Clusters,
} from "src/redux/slices/timeSeriesClustering";

const getObservations = (query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<BulkResponseData<Observation>>(
    `/observations${stringifiedQuery}`
  );
};

type TimeSeriesRepresentationsRequestBody = {
  representation: TimeSeriesRepresentation;
  trialIds: string[];
  attributes?: string[];
};
export type TimeSeriesRepresentationsResponseData = {
  [trialId: string]: number[];
};
const getTimeSeriesRepresentations = (
  data: TimeSeriesRepresentationsRequestBody
) => {
  return http.post<TimeSeriesRepresentationsResponseData>(
    `/observations/timeSeriesRepresentation`,
    data
  );
};

type ClustersRequestBody = {
  clusteringSpace: ClusteringSpace;
  representations: { [trialId: string]: number[] };
};
const getTimeSeriesClusters = (query: ClustersRequestBody) => {
  return http.post<Clusters>("/observations/cluster", query, {
    timeout: undefined,
  });
};

const ObservationService = {
  getObservations,
  getTimeSeriesRepresentations,
  getTimeSeriesClusters,
};

export default ObservationService;
