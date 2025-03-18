import request from "graphql-request";
import { useQuery } from "@tanstack/react-query";
import { gql } from "src/__generated__";
import { client } from "src/api/apollo-client";
import { toast } from "react-toastify";

const GET_CLUSTERING_SAVES = gql(`query GetSession($id: String!) {
  Session(id: $id) {
    savedClustering {
      url
    }
  }
}`);

const GET_TRAJECTORY_ANALYSIS_SAVES =
  gql(`query GetSessionTrajectoryAnalysis($id: String!) {
  Session(id: $id) {
    savedTrajectoryAnalysis {
      url
    }
  }
}`);

const GET_STATE_ANALYSIS_SAVES =
  gql(`query GetSessionStateAnalysis($id: String!) {
  Session(id: $id) {
    savedStateAnalysis {
      url
    }
  }
}`);

export const getClusteringSaves = async (id: string) => {
  const { data, error } = await client.query({
    query: GET_CLUSTERING_SAVES,
    variables: {
      id,
    },
  });
  console.error(error);
  return data.Session;
};

export const useClusteringSaves = (sessionId?: string) => {
  const response = useQuery({
    queryKey: ["clusteringSaves", sessionId],
    queryFn: async () =>
      request(
        `${import.meta.env.VITE_API_ADDRESS}/graphql`,
        GET_CLUSTERING_SAVES,
        { id: sessionId ?? "" },
      ),
  });

  const { isError, error } = response;

  if (isError) {
    toast.error("Failed to load clustering saves!");
    console.error(error);
  }

  return response;
};

export const useTrajectoryAnalysisSaves = (sessionId?: string) => {
  const response = useQuery({
    queryKey: ["savedTrajectoryAnalysis", sessionId],
    queryFn: async () =>
      request(
        `${import.meta.env.VITE_API_ADDRESS}/graphql`,
        GET_TRAJECTORY_ANALYSIS_SAVES,
        { id: sessionId ?? "" },
      ),
  });

  const { isError, error } = response;

  if (isError) {
    toast.error("Failed to load clustering saves!");
    console.error(error);
  }

  return response;
};

export const useStateAnalysisSaves = (sessionId?: string) => {
  const response = useQuery({
    queryKey: ["savedStateAnalysis", sessionId],
    queryFn: async () =>
      request(
        `${import.meta.env.VITE_API_ADDRESS}/graphql`,
        GET_STATE_ANALYSIS_SAVES,
        { id: sessionId ?? "" },
      ),
  });

  const { isError, error } = response;

  if (isError) {
    toast.error("Failed to load clustering saves!");
    console.error(error);
  }

  return response;
};
