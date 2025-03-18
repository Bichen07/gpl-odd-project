import qs from "qs";
import http from "src/axios/http-common";
import { Meta } from "src/axios/common";
import { Client } from "payload/payload-types";

type ClientsResponseData = {
  docs: Client[];
} & Meta;

const getClients = (query?: any) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<ClientsResponseData>(`/clients${stringifiedQuery}`);
};

const ClientService = {
  getClients,
};

export default ClientService;
