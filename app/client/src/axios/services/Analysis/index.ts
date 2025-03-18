import http from "src/axios/http-common";

type PcaRequestBody = {
  x: number[][];
};
type PcaResponseData = {
  x: number[][];
  explainedVarianceRatio: number[];
};
const getPca = (query: PcaRequestBody) => {
  return http.post<PcaResponseData>("/analysis/pca", query);
};

const AnalysisService = {
  getPca,
};

export default AnalysisService;
