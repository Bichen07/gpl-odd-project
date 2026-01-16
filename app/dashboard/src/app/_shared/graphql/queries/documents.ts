import { Document } from "@/app/_shared/graphql/__generated__/graphql";
import { api } from "@/app/_shared/api";

export const postDocument = (form: FormData) => {
  return api.post<Document>("/documents", form);
};

export const deleteDocument = (id: string) => {
  return api.delete<Document>(`/documents/${id}`);
};
