import qs from "qs";
import http from "src/axios/http-common";
import { Meta } from "src/axios/common";
import { Trial } from "src/__generated__/graphql";

type SearchAttemptsResponseData = {
  docs: Trial[];
} & Meta;

const getTrials = (query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<SearchAttemptsResponseData>(`/trials${stringifiedQuery}`);
};

type KMeansQuery = {
  trialIds: string[];
};
const getKMeansClusters = (query: KMeansQuery) => {
  return http.post<{ [id: string]: number }>(`/trials/kmeans`, query);
};

const TrialService = {
  getTrials,
  getKMeansClusters,
};

export default TrialService;
