/* eslint-disable */
import * as types from './graphql';
import { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';

/**
 * Map of all GraphQL operations in the project.
 *
 * This map has several performance disadvantages:
 * 1. It is not tree-shakeable, so it will include all operations in the project.
 * 2. It is not minifiable, so the string of a GraphQL query will be multiple times inside the bundle.
 * 3. It does not support dead code elimination, so it will add unused operations.
 *
 * Therefore it is highly recommended to use the babel or swc plugin for production.
 * Learn more about it here: https://the-guild.dev/graphql/codegen/plugins/presets/preset-client#reducing-bundle-size
 */
const documents = {
    "\n  query GetBatches(\n    $limit: Int\n    $sort: String\n    $where: Batch_where\n    $page: Int\n  ) {\n    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {\n      docs {\n        id\n        scenario {\n          id\n          name\n          parameters {\n            id\n            max\n            min\n            name\n            unit\n          }\n          testObjectives {\n            criticalityMetrics {\n              id\n              threshold\n              keyPerformanceIndicator {\n                id\n                name\n                rule\n                unit\n              }\n            }\n          }\n          schematic {\n            sizes {\n              tablet {\n                url\n              }\n            }\n          }\n        }\n      }\n      page\n      totalPages\n    }\n  }\n": types.GetBatchesDocument,
    "\n  query GetBatchWithTrials($id: String!) {\n    Batch(id: $id) {\n      id\n      trials {\n        id\n        parameters {\n          parameterId\n          value\n        }\n        testObjectives {\n          criticalityMetrics {\n            value\n            passed\n            keyPerformanceIndicator {\n              id\n              name\n            }\n          }\n        }\n      }\n    }\n  }\n": types.GetBatchWithTrialsDocument,
    "query GetSession($id: String!) {\n  Session(id: $id) {\n    savedClustering {\n      url\n    }\n  }\n}": types.GetSessionDocument,
    "query GetSessionTrajectoryAnalysis($id: String!) {\n  Session(id: $id) {\n    savedTrajectoryAnalysis {\n      url\n    }\n  }\n}": types.GetSessionTrajectoryAnalysisDocument,
    "query GetSessionStateAnalysis($id: String!) {\n  Session(id: $id) {\n    savedStateAnalysis {\n      url\n    }\n  }\n}": types.GetSessionStateAnalysisDocument,
    "\n  query GetBatchInfo($id: String!) {\n    Batch(id: $id) {\n      id\n      scenario {\n        parameters {\n          id\n          name\n          min\n          max\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n": types.GetBatchInfoDocument,
    "query GetTrials($where: Trial_where) {\n  Trials(where: $where, limit: 8000) {\n  \tdocs {\n      id\n      previewImage {\n        url\n        sizes {\n          thumbnail {\n            url\n          }\n        }\n      }\n    }\n  }\n}": types.GetTrialsDocument,
};

/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 *
 *
 * @example
 * ```ts
 * const query = gql(`query GetUser($id: ID!) { user(id: $id) { name } }`);
 * ```
 *
 * The query argument is unknown!
 * Please regenerate the types.
 */
export function gql(source: string): unknown;

/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "\n  query GetBatches(\n    $limit: Int\n    $sort: String\n    $where: Batch_where\n    $page: Int\n  ) {\n    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {\n      docs {\n        id\n        scenario {\n          id\n          name\n          parameters {\n            id\n            max\n            min\n            name\n            unit\n          }\n          testObjectives {\n            criticalityMetrics {\n              id\n              threshold\n              keyPerformanceIndicator {\n                id\n                name\n                rule\n                unit\n              }\n            }\n          }\n          schematic {\n            sizes {\n              tablet {\n                url\n              }\n            }\n          }\n        }\n      }\n      page\n      totalPages\n    }\n  }\n"): (typeof documents)["\n  query GetBatches(\n    $limit: Int\n    $sort: String\n    $where: Batch_where\n    $page: Int\n  ) {\n    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {\n      docs {\n        id\n        scenario {\n          id\n          name\n          parameters {\n            id\n            max\n            min\n            name\n            unit\n          }\n          testObjectives {\n            criticalityMetrics {\n              id\n              threshold\n              keyPerformanceIndicator {\n                id\n                name\n                rule\n                unit\n              }\n            }\n          }\n          schematic {\n            sizes {\n              tablet {\n                url\n              }\n            }\n          }\n        }\n      }\n      page\n      totalPages\n    }\n  }\n"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "\n  query GetBatchWithTrials($id: String!) {\n    Batch(id: $id) {\n      id\n      trials {\n        id\n        parameters {\n          parameterId\n          value\n        }\n        testObjectives {\n          criticalityMetrics {\n            value\n            passed\n            keyPerformanceIndicator {\n              id\n              name\n            }\n          }\n        }\n      }\n    }\n  }\n"): (typeof documents)["\n  query GetBatchWithTrials($id: String!) {\n    Batch(id: $id) {\n      id\n      trials {\n        id\n        parameters {\n          parameterId\n          value\n        }\n        testObjectives {\n          criticalityMetrics {\n            value\n            passed\n            keyPerformanceIndicator {\n              id\n              name\n            }\n          }\n        }\n      }\n    }\n  }\n"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "query GetSession($id: String!) {\n  Session(id: $id) {\n    savedClustering {\n      url\n    }\n  }\n}"): (typeof documents)["query GetSession($id: String!) {\n  Session(id: $id) {\n    savedClustering {\n      url\n    }\n  }\n}"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "query GetSessionTrajectoryAnalysis($id: String!) {\n  Session(id: $id) {\n    savedTrajectoryAnalysis {\n      url\n    }\n  }\n}"): (typeof documents)["query GetSessionTrajectoryAnalysis($id: String!) {\n  Session(id: $id) {\n    savedTrajectoryAnalysis {\n      url\n    }\n  }\n}"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "query GetSessionStateAnalysis($id: String!) {\n  Session(id: $id) {\n    savedStateAnalysis {\n      url\n    }\n  }\n}"): (typeof documents)["query GetSessionStateAnalysis($id: String!) {\n  Session(id: $id) {\n    savedStateAnalysis {\n      url\n    }\n  }\n}"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "\n  query GetBatchInfo($id: String!) {\n    Batch(id: $id) {\n      id\n      scenario {\n        parameters {\n          id\n          name\n          min\n          max\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n"): (typeof documents)["\n  query GetBatchInfo($id: String!) {\n    Batch(id: $id) {\n      id\n      scenario {\n        parameters {\n          id\n          name\n          min\n          max\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "query GetTrials($where: Trial_where) {\n  Trials(where: $where, limit: 8000) {\n  \tdocs {\n      id\n      previewImage {\n        url\n        sizes {\n          thumbnail {\n            url\n          }\n        }\n      }\n    }\n  }\n}"): (typeof documents)["query GetTrials($where: Trial_where) {\n  Trials(where: $where, limit: 8000) {\n  \tdocs {\n      id\n      previewImage {\n        url\n        sizes {\n          thumbnail {\n            url\n          }\n        }\n      }\n    }\n  }\n}"];

export function gql(source: string) {
  return (documents as any)[source] ?? {};
}

export type DocumentType<TDocumentNode extends DocumentNode<any, any>> = TDocumentNode extends DocumentNode<  infer TType,  any>  ? TType  : never;