import axios from "axios";

export default axios.create({
  baseURL: import.meta.env.VITE_API_ADDRESS,
  headers: {
    Authorization: `users API-Key ${import.meta.env.VITE_API_KEY}`,
  },
});

export const analyzerHttp = axios.create({
  baseURL: import.meta.env.VITE_ANALYZER_API_ADDRESS,
});
