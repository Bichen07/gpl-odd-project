import qs from "qs";
import http from "src/api/http-common";
import { EsminiDat } from "src/__generated__/graphql";

export const getEsminiDat = (id: string, query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<EsminiDat>(`/observations/${id}${stringifiedQuery}`);
};
