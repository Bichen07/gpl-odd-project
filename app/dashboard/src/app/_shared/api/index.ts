import qs from "qs";
import axios from "axios";

export const api = axios.create({
  baseURL: process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS + "/api",
  headers: {
    Authorization: `users API-Key ${process.env.NEXT_PUBLIC_PAYLOAD_API_KEY}`,
  },
});

api.interceptors.request.use(
  (config) => {
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export const analyzerApi = axios.create({
  baseURL: process.env.NEXT_PUBLIC_ANALYZER_API_ADDRESS,
  headers: {
    request_max_body_size: null,
  },
});

export function getDoc<Type>(slug: string, id: string, query?: any) {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return api.get<Type>(`/${slug}/${id}${stringifiedQuery}`);
}

export function getDocs<Type>(slug: string, query?: any) {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return api.get<Type>(`/${slug}${stringifiedQuery}`);
}
