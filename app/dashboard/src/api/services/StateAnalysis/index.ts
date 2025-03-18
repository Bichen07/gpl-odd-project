import { analyzerHttp } from "src/api/http-common";

export type StateAnalysisRequest = {
  batchIds: string[];
  trialIds: string[];
  metricNames: string[];
};

export type StateResultItem = {
  id: string;
  data: { [attribute: string]: number | string };
  egoGradients: { [egoFeature: string]: { [envFeature: string]: number } };
  metricGradients: { [metricName: string]: { [envFeature: string]: number } };
};

export type StateAnalysisResponse = {
  request: StateAnalysisRequest;
  states: { [stateId: string]: StateResultItem };
  egoFeatureNames: string[];
  envFeatureNames: string[];
  metricNames: string[];
};

export const getStateAnalysis = (query: StateAnalysisRequest) => {
  console.log(query);
  return analyzerHttp.post<StateAnalysisResponse>("/state_analysis", query);
};
