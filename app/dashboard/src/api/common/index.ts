import qs from "qs";
import http from "src/api/http-common";

export type BulkResponseData<T> = {
  docs: T[];
  totalDocs: number;
  limit: number;
  totalPages: number;
  page: number;
  pagingCounter: number;
  hasPrevPage: boolean;
  hasNextPage: boolean;
  prevPage: boolean;
  nextPage: boolean;
};

export function getDoc<Type>(slug: string, id: string, query?: any) {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<Type>(`/${slug}/${id}${stringifiedQuery}`);
}

export function getDocs<Type>(slug: string, query?: any) {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<Type>(`/${slug}${stringifiedQuery}`);
}
