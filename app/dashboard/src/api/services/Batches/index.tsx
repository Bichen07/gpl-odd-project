import request from "graphql-request";
import { useQuery } from "@tanstack/react-query";
import { gql } from "src/__generated__/gql";
import { Object, List } from "ts-toolbelt";
import {
  Batch,
  GetBatchWithTrialsQuery,
  GetBatchesQuery,
  GetBatchesQueryVariables,
} from "src/__generated__/graphql";
import { toast } from "react-toastify";
import { getDoc } from "src/api/common";

const MAX_BATCH_COUNT_OF_SESSION = 10000;

const GET_BATCHES = gql(/* GraphQL */ `
  query GetBatches(
    $limit: Int
    $sort: String
    $where: Batch_where
    $page: Int
  ) {
    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {
      docs {
        id
        scenario {
          id
          name
          parameters {
            id
            max
            min
            name
            unit
          }
          testObjectives {
            criticalityMetrics {
              id
              threshold
              keyPerformanceIndicator {
                id
                name
                rule
                unit
              }
            }
          }
          schematic {
            sizes {
              tablet {
                url
              }
            }
          }
        }
      }
      page
      totalPages
    }
  }
`);

export const useBatches = (
  queryKey?: any[],
  variables?: GetBatchesQueryVariables,
) => {
  const response = useQuery({
    queryKey: ["batches", ...(queryKey ?? [])],
    queryFn: async () =>
      request(
        `${import.meta.env.VITE_API_ADDRESS}/graphql/batches`,
        GET_BATCHES,
        variables ?? {},
      ),
  });

  const { isError, error } = response;

  if (isError) {
    toast.error("Failed to load batches!");
    console.error(error);
  }

  return response;
};

export const useSessionBatches = (sessionId: string | null | undefined) => {
  return useBatches([sessionId], {
    limit: MAX_BATCH_COUNT_OF_SESSION,
    where: {
      session: { equals: sessionId },
    },
  });
};

type ScenarioPath = ["Batches", "docs", number, "scenario"];
export type Scenario = Object.Path<GetBatchesQuery, ScenarioPath>;

type SessionBatchPath = ["Batches", "docs", number];
export type SessionBatch = Object.Path<GetBatchesQuery, SessionBatchPath>;

export type Batches = Object.Path<GetBatchesQuery, ["Batches"]>;

const GET_BATCH_WITH_TRIALS = gql(/* GraphQL */ `
  query GetBatchWithTrials($id: String!) {
    Batch(id: $id) {
      id
      trials {
        id
        parameters {
          parameterId
          value
        }
        testObjectives {
          criticalityMetrics {
            value
            passed
            keyPerformanceIndicator {
              id
              name
            }
          }
        }
      }
    }
  }
`);

export const useBatchwithTrials = (batchId?: string, enabled?: boolean) => {
  // const response = useQuery({
  //   queryKey: ["batchWithTrials", batchId],
  //   queryFn: async () =>
  //     request(
  //       `${import.meta.env.VITE_API_ADDRESS}/graphql`,
  //       GET_BATCH_WITH_TRIALS,
  //       { id: batchId ?? "" },
  //     ),
  //   enabled: enabled,
  // });
  const response = useQuery({
    queryKey: ["batchWithTrials", batchId],
    queryFn: async () =>
      getDoc<Batch>("batches", batchId ?? "", { depth: 1 }).then(
        (response) => response.data,
      ),
    enabled: enabled,
  });

  const { isError, error } = response;

  if (isError) {
    toast.error("Failed to load batch with trials!");
    console.error(error);
  }

  return response;
};

// export type BatchWithTrials = Object.Path<GetBatchWithTrialsQuery, ["Batch"]>;
export type BatchWithTrials = Batch;
export type Trial = List.UnionOf<
  NonNullable<Object.Path<GetBatchWithTrialsQuery, ["Batch", "trials"]>>
>;
