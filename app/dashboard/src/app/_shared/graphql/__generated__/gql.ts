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
type Documents = {
    "\n  query GetBatches(\n    $limit: Int\n    $sort: String\n    $where: Batch_where\n    $page: Int\n  ) {\n    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {\n      docs {\n        id\n        session {\n          id\n        }\n        egos {\n          id\n          name\n        }\n        scenario {\n          id\n          name\n          parameters {\n            id\n            max\n            min\n            name\n            unit\n          }\n          testObjectives {\n            criticalityMetrics {\n              id\n              threshold\n              keyPerformanceIndicator {\n                id\n                name\n                rule\n                unit\n              }\n            }\n          }\n          schematic {\n            sizes {\n              tablet {\n                url\n              }\n            }\n          }\n        }\n      }\n      page\n      totalPages\n      totalDocs\n    }\n  }\n": typeof types.GetBatchesDocument,
    "query GetBatchTrajectoryAnalysis($id: Int!) {\n  Batch(id: $id) {\n    savedTrajectoryAnalysis {\n      id\n      url\n      filename\n    }\n  }\n}": typeof types.GetBatchTrajectoryAnalysisDocument,
    "\n  query GetBatchImages($id: Int!) {\n    Batch(id: $id) {\n      id\n      images {\n        id\n        url\n        filename\n      }\n    }\n  }\n": typeof types.GetBatchImagesDocument,
    "\n  query GetBatch($id: Int!) {\n    Batch(id: $id) {\n      id\n      egos {\n        id\n        name\n      }\n      scenario {\n        id\n        name\n        parameters {\n          id\n          max\n          min\n          name\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n": typeof types.GetBatchDocument,
    "\n  query GetBatchInfo($id: Int!) {\n    Batch(id: $id) {\n      id\n      scenario {\n        parameters {\n          id\n          name\n          min\n          max\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n": typeof types.GetBatchInfoDocument,
    "\n  query GetTrials(\n    $limit: Int\n    $sort: String\n    $where: Trial_where\n    $page: Int\n  ) {\n    Trials(limit: $limit, sort: $sort, where: $where, page: $page) {\n  \t  docs {\n        id\n        ego {\n          id\n          name\n        }\n        parameters {\n          parameterId\n          value\n        }\n        testObjectives {\n          criticalityMetrics {\n            value\n            passed\n            keyPerformanceIndicator {\n              id\n              name\n            }\n          }\n        }\n      }\n    }\n  }\n": typeof types.GetTrialsDocument,
};
const documents: Documents = {
    "\n  query GetBatches(\n    $limit: Int\n    $sort: String\n    $where: Batch_where\n    $page: Int\n  ) {\n    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {\n      docs {\n        id\n        session {\n          id\n        }\n        egos {\n          id\n          name\n        }\n        scenario {\n          id\n          name\n          parameters {\n            id\n            max\n            min\n            name\n            unit\n          }\n          testObjectives {\n            criticalityMetrics {\n              id\n              threshold\n              keyPerformanceIndicator {\n                id\n                name\n                rule\n                unit\n              }\n            }\n          }\n          schematic {\n            sizes {\n              tablet {\n                url\n              }\n            }\n          }\n        }\n      }\n      page\n      totalPages\n      totalDocs\n    }\n  }\n": types.GetBatchesDocument,
    "query GetBatchTrajectoryAnalysis($id: Int!) {\n  Batch(id: $id) {\n    savedTrajectoryAnalysis {\n      id\n      url\n      filename\n    }\n  }\n}": types.GetBatchTrajectoryAnalysisDocument,
    "\n  query GetBatchImages($id: Int!) {\n    Batch(id: $id) {\n      id\n      images {\n        id\n        url\n        filename\n      }\n    }\n  }\n": types.GetBatchImagesDocument,
    "\n  query GetBatch($id: Int!) {\n    Batch(id: $id) {\n      id\n      egos {\n        id\n        name\n      }\n      scenario {\n        id\n        name\n        parameters {\n          id\n          max\n          min\n          name\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n": types.GetBatchDocument,
    "\n  query GetBatchInfo($id: Int!) {\n    Batch(id: $id) {\n      id\n      scenario {\n        parameters {\n          id\n          name\n          min\n          max\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n": types.GetBatchInfoDocument,
    "\n  query GetTrials(\n    $limit: Int\n    $sort: String\n    $where: Trial_where\n    $page: Int\n  ) {\n    Trials(limit: $limit, sort: $sort, where: $where, page: $page) {\n  \t  docs {\n        id\n        ego {\n          id\n          name\n        }\n        parameters {\n          parameterId\n          value\n        }\n        testObjectives {\n          criticalityMetrics {\n            value\n            passed\n            keyPerformanceIndicator {\n              id\n              name\n            }\n          }\n        }\n      }\n    }\n  }\n": types.GetTrialsDocument,
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
export function gql(source: "\n  query GetBatches(\n    $limit: Int\n    $sort: String\n    $where: Batch_where\n    $page: Int\n  ) {\n    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {\n      docs {\n        id\n        session {\n          id\n        }\n        egos {\n          id\n          name\n        }\n        scenario {\n          id\n          name\n          parameters {\n            id\n            max\n            min\n            name\n            unit\n          }\n          testObjectives {\n            criticalityMetrics {\n              id\n              threshold\n              keyPerformanceIndicator {\n                id\n                name\n                rule\n                unit\n              }\n            }\n          }\n          schematic {\n            sizes {\n              tablet {\n                url\n              }\n            }\n          }\n        }\n      }\n      page\n      totalPages\n      totalDocs\n    }\n  }\n"): (typeof documents)["\n  query GetBatches(\n    $limit: Int\n    $sort: String\n    $where: Batch_where\n    $page: Int\n  ) {\n    Batches(limit: $limit, sort: $sort, where: $where, page: $page) {\n      docs {\n        id\n        session {\n          id\n        }\n        egos {\n          id\n          name\n        }\n        scenario {\n          id\n          name\n          parameters {\n            id\n            max\n            min\n            name\n            unit\n          }\n          testObjectives {\n            criticalityMetrics {\n              id\n              threshold\n              keyPerformanceIndicator {\n                id\n                name\n                rule\n                unit\n              }\n            }\n          }\n          schematic {\n            sizes {\n              tablet {\n                url\n              }\n            }\n          }\n        }\n      }\n      page\n      totalPages\n      totalDocs\n    }\n  }\n"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "query GetBatchTrajectoryAnalysis($id: Int!) {\n  Batch(id: $id) {\n    savedTrajectoryAnalysis {\n      id\n      url\n      filename\n    }\n  }\n}"): (typeof documents)["query GetBatchTrajectoryAnalysis($id: Int!) {\n  Batch(id: $id) {\n    savedTrajectoryAnalysis {\n      id\n      url\n      filename\n    }\n  }\n}"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "\n  query GetBatchImages($id: Int!) {\n    Batch(id: $id) {\n      id\n      images {\n        id\n        url\n        filename\n      }\n    }\n  }\n"): (typeof documents)["\n  query GetBatchImages($id: Int!) {\n    Batch(id: $id) {\n      id\n      images {\n        id\n        url\n        filename\n      }\n    }\n  }\n"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "\n  query GetBatch($id: Int!) {\n    Batch(id: $id) {\n      id\n      egos {\n        id\n        name\n      }\n      scenario {\n        id\n        name\n        parameters {\n          id\n          max\n          min\n          name\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n"): (typeof documents)["\n  query GetBatch($id: Int!) {\n    Batch(id: $id) {\n      id\n      egos {\n        id\n        name\n      }\n      scenario {\n        id\n        name\n        parameters {\n          id\n          max\n          min\n          name\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "\n  query GetBatchInfo($id: Int!) {\n    Batch(id: $id) {\n      id\n      scenario {\n        parameters {\n          id\n          name\n          min\n          max\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n"): (typeof documents)["\n  query GetBatchInfo($id: Int!) {\n    Batch(id: $id) {\n      id\n      scenario {\n        parameters {\n          id\n          name\n          min\n          max\n          unit\n        }\n        testObjectives {\n          criticalityMetrics {\n            id\n            threshold\n            keyPerformanceIndicator {\n              id\n              name\n              rule\n              unit\n            }\n          }\n        }\n      }\n    }\n  }\n"];
/**
 * The gql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function gql(source: "\n  query GetTrials(\n    $limit: Int\n    $sort: String\n    $where: Trial_where\n    $page: Int\n  ) {\n    Trials(limit: $limit, sort: $sort, where: $where, page: $page) {\n  \t  docs {\n        id\n        ego {\n          id\n          name\n        }\n        parameters {\n          parameterId\n          value\n        }\n        testObjectives {\n          criticalityMetrics {\n            value\n            passed\n            keyPerformanceIndicator {\n              id\n              name\n            }\n          }\n        }\n      }\n    }\n  }\n"): (typeof documents)["\n  query GetTrials(\n    $limit: Int\n    $sort: String\n    $where: Trial_where\n    $page: Int\n  ) {\n    Trials(limit: $limit, sort: $sort, where: $where, page: $page) {\n  \t  docs {\n        id\n        ego {\n          id\n          name\n        }\n        parameters {\n          parameterId\n          value\n        }\n        testObjectives {\n          criticalityMetrics {\n            value\n            passed\n            keyPerformanceIndicator {\n              id\n              name\n            }\n          }\n        }\n      }\n    }\n  }\n"];

export function gql(source: string) {
  return (documents as any)[source] ?? {};
}

export type DocumentType<TDocumentNode extends DocumentNode<any, any>> = TDocumentNode extends DocumentNode<  infer TType,  any>  ? TType  : never;