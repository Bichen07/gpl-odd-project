import { gql } from "@/app/_shared/graphql/__generated__";
import request from "graphql-request";
import { Object, List, O } from "ts-toolbelt";
import {
  GetBatchesQuery,
  GetBatchesQueryVariables,
  GetBatchImagesQuery,
  GetBatchImagesQueryVariables,
  GetBatchQuery,
  GetBatchQueryVariables,
  GetBatchTrajectoryAnalysisQuery,
} from "@/app/_shared/graphql/__generated__/graphql";

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
        session {
          id
        }
        egos {
          id
          name
        }
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
      totalDocs
    }
  }
`);

export const getBatches = async (variables: GetBatchesQueryVariables) => {
  return request(
    `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/graphql`,
    GET_BATCHES,
    variables,
  ).then((response) => response.Batches);
};

export type Batches = Object.Path<GetBatchesQuery, ["Batches"]>;

type ScenarioPath = ["Batches", "docs", number, "scenario"];
export type Scenario = Object.Path<GetBatchesQuery, ScenarioPath>;

const GET_TRAJECTORY_ANALYSIS_SAVES =
  gql(`query GetBatchTrajectoryAnalysis($id: Int!) {
  Batch(id: $id) {
    savedTrajectoryAnalysis {
      id
      url
      filename
    }
  }
}`);

export const getTrajectoryAnalysisSaves = async (batchId?: number) => {
  console.log(batchId);
  return request(
    `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/graphql`,
    GET_TRAJECTORY_ANALYSIS_SAVES,
    { id: batchId ?? 0 },
  ).then((response) => response.Batch?.savedTrajectoryAnalysis ?? []);
};
export type SavedTrajectoryAnalysis = Object.Path<
  GetBatchTrajectoryAnalysisQuery,
  ["Batch", "savedTrajectoryAnalysis"]
>;

// const GET_BATCH_WITH_TRIALS = gql(/* GraphQL */ `
//   query GetBatchWithTrials($id: String!) {
//     Batch(id: $id) {
//       id
//       trials {
//         id
//         parameters {
//           parameterId
//           value
//         }
//         testObjectives {
//           criticalityMetrics {
//             value
//             passed
//             keyPerformanceIndicator {
//               id
//               name
//             }
//           }
//         }
//       }
//     }
//   }
// `);
//
// export type BatchWithTrial = NonNullable<
//   Object.Path<GetBatchWithTrialsQuery, ["Batch"]>
// >;
// export type Trial = List.UnionOf<
//   NonNullable<Object.Path<GetBatchWithTrialsQuery, ["Batch", "trials"]>>
// >;
//
// export const getBatch = async (variables: GetBatchWithTrialsQueryVariables) => {
//   return request(
//     `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/graphql`,
//     GET_BATCH_WITH_TRIALS,
//     variables
//   ).then((response) => response.Batch);
// };

const GET_BATCH_IMAGES = gql(/* GraphQL */ `
  query GetBatchImages($id: Int!) {
    Batch(id: $id) {
      id
      images {
        id
        url
        filename
      }
    }
  }
`);

export const getBatchImages = async (
  variables: GetBatchImagesQueryVariables,
) => {
  return request(
    `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/graphql`,
    GET_BATCH_IMAGES,
    variables,
  ).then((response) => response.Batch);
};

export type BatchImages = NonNullable<
  Object.Path<GetBatchImagesQuery, ["Batch"]>
>;

const GET_BATCH = gql(/* GraphQL */ `
  query GetBatch($id: Int!) {
    Batch(id: $id) {
      id
      egos {
        id
        name
      }
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
      }
    }
  }
`);

export const getBatch = async (variables: GetBatchQueryVariables) => {
  return request(
    `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/graphql`,
    GET_BATCH,
    variables,
  ).then((response) => response.Batch);
};

export type Batch = O.Path<GetBatchQuery, ["Batch"]>;
