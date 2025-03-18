import qs from "qs";
import http from "src/axios/http-common";
import { Meta } from "src/axios/common";
import { Scenario } from "payload/payload-types";

type ScenariosResponseData = {
  docs: Scenario[];
} & Meta;

const getScenarios = (query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<ScenariosResponseData>(`/scenarios${stringifiedQuery}`);
};

const getScenario = (id: string, query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<Scenario>(`/scenarios/${id}${stringifiedQuery}`);
};

const ScenarioService = {
  getScenarios,
  getScenario,
};

export default ScenarioService;
