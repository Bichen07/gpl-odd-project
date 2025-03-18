import http from "src/axios/http-common";
import {
  ClusteringSpace,
  Clusters,
} from "src/redux/slices/timeSeriesClustering";

type ClustersRequestBody = {
  clusteringSpace: ClusteringSpace;
  representations: { [trialId: string]: number[] };
};
const getClusters = (query: ClustersRequestBody) => {
  return http.post<Clusters>("/cluster", query);
};

const ClusteringService = {
  getClusters,
};

export default ClusteringService;
