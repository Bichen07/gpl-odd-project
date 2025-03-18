import http from "src/axios/http-common";
import { BulkResponseData } from "src/axios/common";
import qs from "qs";
import { Search } from "payload/payload-types";

const getSearchs = (query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<BulkResponseData<Search>>(`/searches${stringifiedQuery}`);
};

const getSearch = (id: string, query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<Search>(`/searches/${id}${stringifiedQuery}`);
};

const SearchService = {
  getSearchs,
  getSearch,
};

export default SearchService;
