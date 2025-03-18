import { Document } from "src/__generated__/graphql";
import http from "src/api/http-common";

export const postDocument = (form: FormData) => {
  return http.post<Document>("/documents", form);
};
