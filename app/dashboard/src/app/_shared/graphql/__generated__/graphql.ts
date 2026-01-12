/* eslint-disable */
import { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
  /** A date-time string at UTC, such as 2007-12-03T10:15:30Z, compliant with the `date-time` format outlined in section 5.6 of the RFC 3339 profile of the ISO 8601 standard for representation of dates and times using the Gregorian calendar. */
  DateTime: { input: any; output: any; }
  /** A field whose value conforms to the standard internet email address format as specified in HTML Spec: https://html.spec.whatwg.org/multipage/input.html#valid-e-mail-address. */
  EmailAddress: { input: any; output: any; }
  /** The `JSON` scalar type represents JSON values as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf). */
  JSON: { input: any; output: any; }
  /** The `JSONObject` scalar type represents JSON objects as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf). */
  JSONObject: { input: any; output: any; }
};

export type Access = {
  __typename?: 'Access';
  batches: Maybe<BatchesAccess>;
  canAccessAdmin: Scalars['Boolean']['output'];
  documents: Maybe<DocumentsAccess>;
  egos: Maybe<EgosAccess>;
  esminiDats: Maybe<EsminiDatsAccess>;
  keyPerformanceIndicators: Maybe<KeyPerformanceIndicatorsAccess>;
  media: Maybe<MediaAccess>;
  observations: Maybe<ObservationsAccess>;
  openDrives: Maybe<OpenDrivesAccess>;
  openScenarios: Maybe<OpenScenariosAccess>;
  payload_locked_documents: Maybe<Payload_Locked_DocumentsAccess>;
  payload_preferences: Maybe<Payload_PreferencesAccess>;
  samplings: Maybe<SamplingsAccess>;
  scenarios: Maybe<ScenariosAccess>;
  sessions: Maybe<SessionsAccess>;
  trials: Maybe<TrialsAccess>;
  users: Maybe<UsersAccess>;
};

export type Batch = {
  __typename?: 'Batch';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  egos: Maybe<Array<Ego>>;
  id: Scalars['Int']['output'];
  images: Maybe<Array<Document>>;
  requiredNumberOfTrials: Scalars['Float']['output'];
  sampling: Maybe<Sampling>;
  savedTrajectoryAnalysis: Maybe<Array<Document>>;
  scenario: Scenario;
  session: Session;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};


export type BatchSamplingArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type BatchScenarioArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type BatchSessionArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
};

export type Batch_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Batch_Egos_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Batch_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Batch_Images_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Batch_RequiredNumberOfTrials_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Batch_Sampling_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Batch_SavedTrajectoryAnalysis_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Batch_Scenario_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Batch_Session_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Batch_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Batch_Where = {
  AND: InputMaybe<Array<InputMaybe<Batch_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Batch_Where_Or>>>;
  createdAt: InputMaybe<Batch_CreatedAt_Operator>;
  egos: InputMaybe<Batch_Egos_Operator>;
  id: InputMaybe<Batch_Id_Operator>;
  images: InputMaybe<Batch_Images_Operator>;
  requiredNumberOfTrials: InputMaybe<Batch_RequiredNumberOfTrials_Operator>;
  sampling: InputMaybe<Batch_Sampling_Operator>;
  savedTrajectoryAnalysis: InputMaybe<Batch_SavedTrajectoryAnalysis_Operator>;
  scenario: InputMaybe<Batch_Scenario_Operator>;
  session: InputMaybe<Batch_Session_Operator>;
  updatedAt: InputMaybe<Batch_UpdatedAt_Operator>;
};

export type Batch_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Batch_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Batch_Where_Or>>>;
  createdAt: InputMaybe<Batch_CreatedAt_Operator>;
  egos: InputMaybe<Batch_Egos_Operator>;
  id: InputMaybe<Batch_Id_Operator>;
  images: InputMaybe<Batch_Images_Operator>;
  requiredNumberOfTrials: InputMaybe<Batch_RequiredNumberOfTrials_Operator>;
  sampling: InputMaybe<Batch_Sampling_Operator>;
  savedTrajectoryAnalysis: InputMaybe<Batch_SavedTrajectoryAnalysis_Operator>;
  scenario: InputMaybe<Batch_Scenario_Operator>;
  session: InputMaybe<Batch_Session_Operator>;
  updatedAt: InputMaybe<Batch_UpdatedAt_Operator>;
};

export type Batch_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Batch_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Batch_Where_Or>>>;
  createdAt: InputMaybe<Batch_CreatedAt_Operator>;
  egos: InputMaybe<Batch_Egos_Operator>;
  id: InputMaybe<Batch_Id_Operator>;
  images: InputMaybe<Batch_Images_Operator>;
  requiredNumberOfTrials: InputMaybe<Batch_RequiredNumberOfTrials_Operator>;
  sampling: InputMaybe<Batch_Sampling_Operator>;
  savedTrajectoryAnalysis: InputMaybe<Batch_SavedTrajectoryAnalysis_Operator>;
  scenario: InputMaybe<Batch_Scenario_Operator>;
  session: InputMaybe<Batch_Session_Operator>;
  updatedAt: InputMaybe<Batch_UpdatedAt_Operator>;
};

export type Batches = {
  __typename?: 'Batches';
  docs: Array<Batch>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type BatchesCreateAccess = {
  __typename?: 'BatchesCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type BatchesCreateDocAccess = {
  __typename?: 'BatchesCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type BatchesDeleteAccess = {
  __typename?: 'BatchesDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type BatchesDeleteDocAccess = {
  __typename?: 'BatchesDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type BatchesDocAccessFields = {
  __typename?: 'BatchesDocAccessFields';
  createdAt: Maybe<BatchesDocAccessFields_CreatedAt>;
  egos: Maybe<BatchesDocAccessFields_Egos>;
  images: Maybe<BatchesDocAccessFields_Images>;
  requiredNumberOfTrials: Maybe<BatchesDocAccessFields_RequiredNumberOfTrials>;
  sampling: Maybe<BatchesDocAccessFields_Sampling>;
  savedTrajectoryAnalysis: Maybe<BatchesDocAccessFields_SavedTrajectoryAnalysis>;
  scenario: Maybe<BatchesDocAccessFields_Scenario>;
  session: Maybe<BatchesDocAccessFields_Session>;
  updatedAt: Maybe<BatchesDocAccessFields_UpdatedAt>;
};

export type BatchesDocAccessFields_CreatedAt = {
  __typename?: 'BatchesDocAccessFields_createdAt';
  create: Maybe<BatchesDocAccessFields_CreatedAt_Create>;
  delete: Maybe<BatchesDocAccessFields_CreatedAt_Delete>;
  read: Maybe<BatchesDocAccessFields_CreatedAt_Read>;
  update: Maybe<BatchesDocAccessFields_CreatedAt_Update>;
};

export type BatchesDocAccessFields_CreatedAt_Create = {
  __typename?: 'BatchesDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_CreatedAt_Delete = {
  __typename?: 'BatchesDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_CreatedAt_Read = {
  __typename?: 'BatchesDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_CreatedAt_Update = {
  __typename?: 'BatchesDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Egos = {
  __typename?: 'BatchesDocAccessFields_egos';
  create: Maybe<BatchesDocAccessFields_Egos_Create>;
  delete: Maybe<BatchesDocAccessFields_Egos_Delete>;
  read: Maybe<BatchesDocAccessFields_Egos_Read>;
  update: Maybe<BatchesDocAccessFields_Egos_Update>;
};

export type BatchesDocAccessFields_Egos_Create = {
  __typename?: 'BatchesDocAccessFields_egos_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Egos_Delete = {
  __typename?: 'BatchesDocAccessFields_egos_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Egos_Read = {
  __typename?: 'BatchesDocAccessFields_egos_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Egos_Update = {
  __typename?: 'BatchesDocAccessFields_egos_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Images = {
  __typename?: 'BatchesDocAccessFields_images';
  create: Maybe<BatchesDocAccessFields_Images_Create>;
  delete: Maybe<BatchesDocAccessFields_Images_Delete>;
  read: Maybe<BatchesDocAccessFields_Images_Read>;
  update: Maybe<BatchesDocAccessFields_Images_Update>;
};

export type BatchesDocAccessFields_Images_Create = {
  __typename?: 'BatchesDocAccessFields_images_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Images_Delete = {
  __typename?: 'BatchesDocAccessFields_images_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Images_Read = {
  __typename?: 'BatchesDocAccessFields_images_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Images_Update = {
  __typename?: 'BatchesDocAccessFields_images_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_RequiredNumberOfTrials = {
  __typename?: 'BatchesDocAccessFields_requiredNumberOfTrials';
  create: Maybe<BatchesDocAccessFields_RequiredNumberOfTrials_Create>;
  delete: Maybe<BatchesDocAccessFields_RequiredNumberOfTrials_Delete>;
  read: Maybe<BatchesDocAccessFields_RequiredNumberOfTrials_Read>;
  update: Maybe<BatchesDocAccessFields_RequiredNumberOfTrials_Update>;
};

export type BatchesDocAccessFields_RequiredNumberOfTrials_Create = {
  __typename?: 'BatchesDocAccessFields_requiredNumberOfTrials_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_RequiredNumberOfTrials_Delete = {
  __typename?: 'BatchesDocAccessFields_requiredNumberOfTrials_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_RequiredNumberOfTrials_Read = {
  __typename?: 'BatchesDocAccessFields_requiredNumberOfTrials_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_RequiredNumberOfTrials_Update = {
  __typename?: 'BatchesDocAccessFields_requiredNumberOfTrials_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Sampling = {
  __typename?: 'BatchesDocAccessFields_sampling';
  create: Maybe<BatchesDocAccessFields_Sampling_Create>;
  delete: Maybe<BatchesDocAccessFields_Sampling_Delete>;
  read: Maybe<BatchesDocAccessFields_Sampling_Read>;
  update: Maybe<BatchesDocAccessFields_Sampling_Update>;
};

export type BatchesDocAccessFields_Sampling_Create = {
  __typename?: 'BatchesDocAccessFields_sampling_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Sampling_Delete = {
  __typename?: 'BatchesDocAccessFields_sampling_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Sampling_Read = {
  __typename?: 'BatchesDocAccessFields_sampling_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Sampling_Update = {
  __typename?: 'BatchesDocAccessFields_sampling_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_SavedTrajectoryAnalysis = {
  __typename?: 'BatchesDocAccessFields_savedTrajectoryAnalysis';
  create: Maybe<BatchesDocAccessFields_SavedTrajectoryAnalysis_Create>;
  delete: Maybe<BatchesDocAccessFields_SavedTrajectoryAnalysis_Delete>;
  read: Maybe<BatchesDocAccessFields_SavedTrajectoryAnalysis_Read>;
  update: Maybe<BatchesDocAccessFields_SavedTrajectoryAnalysis_Update>;
};

export type BatchesDocAccessFields_SavedTrajectoryAnalysis_Create = {
  __typename?: 'BatchesDocAccessFields_savedTrajectoryAnalysis_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_SavedTrajectoryAnalysis_Delete = {
  __typename?: 'BatchesDocAccessFields_savedTrajectoryAnalysis_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_SavedTrajectoryAnalysis_Read = {
  __typename?: 'BatchesDocAccessFields_savedTrajectoryAnalysis_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_SavedTrajectoryAnalysis_Update = {
  __typename?: 'BatchesDocAccessFields_savedTrajectoryAnalysis_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Scenario = {
  __typename?: 'BatchesDocAccessFields_scenario';
  create: Maybe<BatchesDocAccessFields_Scenario_Create>;
  delete: Maybe<BatchesDocAccessFields_Scenario_Delete>;
  read: Maybe<BatchesDocAccessFields_Scenario_Read>;
  update: Maybe<BatchesDocAccessFields_Scenario_Update>;
};

export type BatchesDocAccessFields_Scenario_Create = {
  __typename?: 'BatchesDocAccessFields_scenario_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Scenario_Delete = {
  __typename?: 'BatchesDocAccessFields_scenario_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Scenario_Read = {
  __typename?: 'BatchesDocAccessFields_scenario_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Scenario_Update = {
  __typename?: 'BatchesDocAccessFields_scenario_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Session = {
  __typename?: 'BatchesDocAccessFields_session';
  create: Maybe<BatchesDocAccessFields_Session_Create>;
  delete: Maybe<BatchesDocAccessFields_Session_Delete>;
  read: Maybe<BatchesDocAccessFields_Session_Read>;
  update: Maybe<BatchesDocAccessFields_Session_Update>;
};

export type BatchesDocAccessFields_Session_Create = {
  __typename?: 'BatchesDocAccessFields_session_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Session_Delete = {
  __typename?: 'BatchesDocAccessFields_session_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Session_Read = {
  __typename?: 'BatchesDocAccessFields_session_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_Session_Update = {
  __typename?: 'BatchesDocAccessFields_session_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_UpdatedAt = {
  __typename?: 'BatchesDocAccessFields_updatedAt';
  create: Maybe<BatchesDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<BatchesDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<BatchesDocAccessFields_UpdatedAt_Read>;
  update: Maybe<BatchesDocAccessFields_UpdatedAt_Update>;
};

export type BatchesDocAccessFields_UpdatedAt_Create = {
  __typename?: 'BatchesDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'BatchesDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_UpdatedAt_Read = {
  __typename?: 'BatchesDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesDocAccessFields_UpdatedAt_Update = {
  __typename?: 'BatchesDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields = {
  __typename?: 'BatchesFields';
  createdAt: Maybe<BatchesFields_CreatedAt>;
  egos: Maybe<BatchesFields_Egos>;
  images: Maybe<BatchesFields_Images>;
  requiredNumberOfTrials: Maybe<BatchesFields_RequiredNumberOfTrials>;
  sampling: Maybe<BatchesFields_Sampling>;
  savedTrajectoryAnalysis: Maybe<BatchesFields_SavedTrajectoryAnalysis>;
  scenario: Maybe<BatchesFields_Scenario>;
  session: Maybe<BatchesFields_Session>;
  updatedAt: Maybe<BatchesFields_UpdatedAt>;
};

export type BatchesFields_CreatedAt = {
  __typename?: 'BatchesFields_createdAt';
  create: Maybe<BatchesFields_CreatedAt_Create>;
  delete: Maybe<BatchesFields_CreatedAt_Delete>;
  read: Maybe<BatchesFields_CreatedAt_Read>;
  update: Maybe<BatchesFields_CreatedAt_Update>;
};

export type BatchesFields_CreatedAt_Create = {
  __typename?: 'BatchesFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_CreatedAt_Delete = {
  __typename?: 'BatchesFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_CreatedAt_Read = {
  __typename?: 'BatchesFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_CreatedAt_Update = {
  __typename?: 'BatchesFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Egos = {
  __typename?: 'BatchesFields_egos';
  create: Maybe<BatchesFields_Egos_Create>;
  delete: Maybe<BatchesFields_Egos_Delete>;
  read: Maybe<BatchesFields_Egos_Read>;
  update: Maybe<BatchesFields_Egos_Update>;
};

export type BatchesFields_Egos_Create = {
  __typename?: 'BatchesFields_egos_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Egos_Delete = {
  __typename?: 'BatchesFields_egos_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Egos_Read = {
  __typename?: 'BatchesFields_egos_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Egos_Update = {
  __typename?: 'BatchesFields_egos_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Images = {
  __typename?: 'BatchesFields_images';
  create: Maybe<BatchesFields_Images_Create>;
  delete: Maybe<BatchesFields_Images_Delete>;
  read: Maybe<BatchesFields_Images_Read>;
  update: Maybe<BatchesFields_Images_Update>;
};

export type BatchesFields_Images_Create = {
  __typename?: 'BatchesFields_images_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Images_Delete = {
  __typename?: 'BatchesFields_images_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Images_Read = {
  __typename?: 'BatchesFields_images_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Images_Update = {
  __typename?: 'BatchesFields_images_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_RequiredNumberOfTrials = {
  __typename?: 'BatchesFields_requiredNumberOfTrials';
  create: Maybe<BatchesFields_RequiredNumberOfTrials_Create>;
  delete: Maybe<BatchesFields_RequiredNumberOfTrials_Delete>;
  read: Maybe<BatchesFields_RequiredNumberOfTrials_Read>;
  update: Maybe<BatchesFields_RequiredNumberOfTrials_Update>;
};

export type BatchesFields_RequiredNumberOfTrials_Create = {
  __typename?: 'BatchesFields_requiredNumberOfTrials_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_RequiredNumberOfTrials_Delete = {
  __typename?: 'BatchesFields_requiredNumberOfTrials_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_RequiredNumberOfTrials_Read = {
  __typename?: 'BatchesFields_requiredNumberOfTrials_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_RequiredNumberOfTrials_Update = {
  __typename?: 'BatchesFields_requiredNumberOfTrials_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Sampling = {
  __typename?: 'BatchesFields_sampling';
  create: Maybe<BatchesFields_Sampling_Create>;
  delete: Maybe<BatchesFields_Sampling_Delete>;
  read: Maybe<BatchesFields_Sampling_Read>;
  update: Maybe<BatchesFields_Sampling_Update>;
};

export type BatchesFields_Sampling_Create = {
  __typename?: 'BatchesFields_sampling_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Sampling_Delete = {
  __typename?: 'BatchesFields_sampling_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Sampling_Read = {
  __typename?: 'BatchesFields_sampling_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Sampling_Update = {
  __typename?: 'BatchesFields_sampling_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_SavedTrajectoryAnalysis = {
  __typename?: 'BatchesFields_savedTrajectoryAnalysis';
  create: Maybe<BatchesFields_SavedTrajectoryAnalysis_Create>;
  delete: Maybe<BatchesFields_SavedTrajectoryAnalysis_Delete>;
  read: Maybe<BatchesFields_SavedTrajectoryAnalysis_Read>;
  update: Maybe<BatchesFields_SavedTrajectoryAnalysis_Update>;
};

export type BatchesFields_SavedTrajectoryAnalysis_Create = {
  __typename?: 'BatchesFields_savedTrajectoryAnalysis_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_SavedTrajectoryAnalysis_Delete = {
  __typename?: 'BatchesFields_savedTrajectoryAnalysis_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_SavedTrajectoryAnalysis_Read = {
  __typename?: 'BatchesFields_savedTrajectoryAnalysis_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_SavedTrajectoryAnalysis_Update = {
  __typename?: 'BatchesFields_savedTrajectoryAnalysis_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Scenario = {
  __typename?: 'BatchesFields_scenario';
  create: Maybe<BatchesFields_Scenario_Create>;
  delete: Maybe<BatchesFields_Scenario_Delete>;
  read: Maybe<BatchesFields_Scenario_Read>;
  update: Maybe<BatchesFields_Scenario_Update>;
};

export type BatchesFields_Scenario_Create = {
  __typename?: 'BatchesFields_scenario_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Scenario_Delete = {
  __typename?: 'BatchesFields_scenario_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Scenario_Read = {
  __typename?: 'BatchesFields_scenario_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Scenario_Update = {
  __typename?: 'BatchesFields_scenario_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Session = {
  __typename?: 'BatchesFields_session';
  create: Maybe<BatchesFields_Session_Create>;
  delete: Maybe<BatchesFields_Session_Delete>;
  read: Maybe<BatchesFields_Session_Read>;
  update: Maybe<BatchesFields_Session_Update>;
};

export type BatchesFields_Session_Create = {
  __typename?: 'BatchesFields_session_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Session_Delete = {
  __typename?: 'BatchesFields_session_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Session_Read = {
  __typename?: 'BatchesFields_session_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_Session_Update = {
  __typename?: 'BatchesFields_session_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_UpdatedAt = {
  __typename?: 'BatchesFields_updatedAt';
  create: Maybe<BatchesFields_UpdatedAt_Create>;
  delete: Maybe<BatchesFields_UpdatedAt_Delete>;
  read: Maybe<BatchesFields_UpdatedAt_Read>;
  update: Maybe<BatchesFields_UpdatedAt_Update>;
};

export type BatchesFields_UpdatedAt_Create = {
  __typename?: 'BatchesFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_UpdatedAt_Delete = {
  __typename?: 'BatchesFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_UpdatedAt_Read = {
  __typename?: 'BatchesFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type BatchesFields_UpdatedAt_Update = {
  __typename?: 'BatchesFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type BatchesReadAccess = {
  __typename?: 'BatchesReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type BatchesReadDocAccess = {
  __typename?: 'BatchesReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type BatchesUpdateAccess = {
  __typename?: 'BatchesUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type BatchesUpdateDocAccess = {
  __typename?: 'BatchesUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Document = {
  __typename?: 'Document';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  focalX: Maybe<Scalars['Float']['output']>;
  focalY: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  id: Scalars['Int']['output'];
  mimeType: Maybe<Scalars['String']['output']>;
  thumbnailURL: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type Document_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Document_Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Document_Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Document_FocalX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Document_FocalY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Document_Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Document_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Document_MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Document_ThumbnailUrl_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Document_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Document_Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Document_Where = {
  AND: InputMaybe<Array<InputMaybe<Document_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Document_Where_Or>>>;
  createdAt: InputMaybe<Document_CreatedAt_Operator>;
  filename: InputMaybe<Document_Filename_Operator>;
  filesize: InputMaybe<Document_Filesize_Operator>;
  focalX: InputMaybe<Document_FocalX_Operator>;
  focalY: InputMaybe<Document_FocalY_Operator>;
  height: InputMaybe<Document_Height_Operator>;
  id: InputMaybe<Document_Id_Operator>;
  mimeType: InputMaybe<Document_MimeType_Operator>;
  thumbnailURL: InputMaybe<Document_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<Document_UpdatedAt_Operator>;
  url: InputMaybe<Document_Url_Operator>;
  width: InputMaybe<Document_Width_Operator>;
};

export type Document_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Document_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Document_Where_Or>>>;
  createdAt: InputMaybe<Document_CreatedAt_Operator>;
  filename: InputMaybe<Document_Filename_Operator>;
  filesize: InputMaybe<Document_Filesize_Operator>;
  focalX: InputMaybe<Document_FocalX_Operator>;
  focalY: InputMaybe<Document_FocalY_Operator>;
  height: InputMaybe<Document_Height_Operator>;
  id: InputMaybe<Document_Id_Operator>;
  mimeType: InputMaybe<Document_MimeType_Operator>;
  thumbnailURL: InputMaybe<Document_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<Document_UpdatedAt_Operator>;
  url: InputMaybe<Document_Url_Operator>;
  width: InputMaybe<Document_Width_Operator>;
};

export type Document_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Document_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Document_Where_Or>>>;
  createdAt: InputMaybe<Document_CreatedAt_Operator>;
  filename: InputMaybe<Document_Filename_Operator>;
  filesize: InputMaybe<Document_Filesize_Operator>;
  focalX: InputMaybe<Document_FocalX_Operator>;
  focalY: InputMaybe<Document_FocalY_Operator>;
  height: InputMaybe<Document_Height_Operator>;
  id: InputMaybe<Document_Id_Operator>;
  mimeType: InputMaybe<Document_MimeType_Operator>;
  thumbnailURL: InputMaybe<Document_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<Document_UpdatedAt_Operator>;
  url: InputMaybe<Document_Url_Operator>;
  width: InputMaybe<Document_Width_Operator>;
};

export type Document_Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Documents = {
  __typename?: 'Documents';
  docs: Array<Document>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type DocumentsCreateAccess = {
  __typename?: 'DocumentsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type DocumentsCreateDocAccess = {
  __typename?: 'DocumentsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type DocumentsDeleteAccess = {
  __typename?: 'DocumentsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type DocumentsDeleteDocAccess = {
  __typename?: 'DocumentsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type DocumentsDocAccessFields = {
  __typename?: 'DocumentsDocAccessFields';
  createdAt: Maybe<DocumentsDocAccessFields_CreatedAt>;
  filename: Maybe<DocumentsDocAccessFields_Filename>;
  filesize: Maybe<DocumentsDocAccessFields_Filesize>;
  focalX: Maybe<DocumentsDocAccessFields_FocalX>;
  focalY: Maybe<DocumentsDocAccessFields_FocalY>;
  height: Maybe<DocumentsDocAccessFields_Height>;
  mimeType: Maybe<DocumentsDocAccessFields_MimeType>;
  thumbnailURL: Maybe<DocumentsDocAccessFields_ThumbnailUrl>;
  updatedAt: Maybe<DocumentsDocAccessFields_UpdatedAt>;
  url: Maybe<DocumentsDocAccessFields_Url>;
  width: Maybe<DocumentsDocAccessFields_Width>;
};

export type DocumentsDocAccessFields_CreatedAt = {
  __typename?: 'DocumentsDocAccessFields_createdAt';
  create: Maybe<DocumentsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<DocumentsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<DocumentsDocAccessFields_CreatedAt_Read>;
  update: Maybe<DocumentsDocAccessFields_CreatedAt_Update>;
};

export type DocumentsDocAccessFields_CreatedAt_Create = {
  __typename?: 'DocumentsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'DocumentsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_CreatedAt_Read = {
  __typename?: 'DocumentsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_CreatedAt_Update = {
  __typename?: 'DocumentsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filename = {
  __typename?: 'DocumentsDocAccessFields_filename';
  create: Maybe<DocumentsDocAccessFields_Filename_Create>;
  delete: Maybe<DocumentsDocAccessFields_Filename_Delete>;
  read: Maybe<DocumentsDocAccessFields_Filename_Read>;
  update: Maybe<DocumentsDocAccessFields_Filename_Update>;
};

export type DocumentsDocAccessFields_Filename_Create = {
  __typename?: 'DocumentsDocAccessFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filename_Delete = {
  __typename?: 'DocumentsDocAccessFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filename_Read = {
  __typename?: 'DocumentsDocAccessFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filename_Update = {
  __typename?: 'DocumentsDocAccessFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filesize = {
  __typename?: 'DocumentsDocAccessFields_filesize';
  create: Maybe<DocumentsDocAccessFields_Filesize_Create>;
  delete: Maybe<DocumentsDocAccessFields_Filesize_Delete>;
  read: Maybe<DocumentsDocAccessFields_Filesize_Read>;
  update: Maybe<DocumentsDocAccessFields_Filesize_Update>;
};

export type DocumentsDocAccessFields_Filesize_Create = {
  __typename?: 'DocumentsDocAccessFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filesize_Delete = {
  __typename?: 'DocumentsDocAccessFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filesize_Read = {
  __typename?: 'DocumentsDocAccessFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Filesize_Update = {
  __typename?: 'DocumentsDocAccessFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalX = {
  __typename?: 'DocumentsDocAccessFields_focalX';
  create: Maybe<DocumentsDocAccessFields_FocalX_Create>;
  delete: Maybe<DocumentsDocAccessFields_FocalX_Delete>;
  read: Maybe<DocumentsDocAccessFields_FocalX_Read>;
  update: Maybe<DocumentsDocAccessFields_FocalX_Update>;
};

export type DocumentsDocAccessFields_FocalX_Create = {
  __typename?: 'DocumentsDocAccessFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalX_Delete = {
  __typename?: 'DocumentsDocAccessFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalX_Read = {
  __typename?: 'DocumentsDocAccessFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalX_Update = {
  __typename?: 'DocumentsDocAccessFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalY = {
  __typename?: 'DocumentsDocAccessFields_focalY';
  create: Maybe<DocumentsDocAccessFields_FocalY_Create>;
  delete: Maybe<DocumentsDocAccessFields_FocalY_Delete>;
  read: Maybe<DocumentsDocAccessFields_FocalY_Read>;
  update: Maybe<DocumentsDocAccessFields_FocalY_Update>;
};

export type DocumentsDocAccessFields_FocalY_Create = {
  __typename?: 'DocumentsDocAccessFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalY_Delete = {
  __typename?: 'DocumentsDocAccessFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalY_Read = {
  __typename?: 'DocumentsDocAccessFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_FocalY_Update = {
  __typename?: 'DocumentsDocAccessFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Height = {
  __typename?: 'DocumentsDocAccessFields_height';
  create: Maybe<DocumentsDocAccessFields_Height_Create>;
  delete: Maybe<DocumentsDocAccessFields_Height_Delete>;
  read: Maybe<DocumentsDocAccessFields_Height_Read>;
  update: Maybe<DocumentsDocAccessFields_Height_Update>;
};

export type DocumentsDocAccessFields_Height_Create = {
  __typename?: 'DocumentsDocAccessFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Height_Delete = {
  __typename?: 'DocumentsDocAccessFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Height_Read = {
  __typename?: 'DocumentsDocAccessFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Height_Update = {
  __typename?: 'DocumentsDocAccessFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_MimeType = {
  __typename?: 'DocumentsDocAccessFields_mimeType';
  create: Maybe<DocumentsDocAccessFields_MimeType_Create>;
  delete: Maybe<DocumentsDocAccessFields_MimeType_Delete>;
  read: Maybe<DocumentsDocAccessFields_MimeType_Read>;
  update: Maybe<DocumentsDocAccessFields_MimeType_Update>;
};

export type DocumentsDocAccessFields_MimeType_Create = {
  __typename?: 'DocumentsDocAccessFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_MimeType_Delete = {
  __typename?: 'DocumentsDocAccessFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_MimeType_Read = {
  __typename?: 'DocumentsDocAccessFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_MimeType_Update = {
  __typename?: 'DocumentsDocAccessFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_ThumbnailUrl = {
  __typename?: 'DocumentsDocAccessFields_thumbnailURL';
  create: Maybe<DocumentsDocAccessFields_ThumbnailUrl_Create>;
  delete: Maybe<DocumentsDocAccessFields_ThumbnailUrl_Delete>;
  read: Maybe<DocumentsDocAccessFields_ThumbnailUrl_Read>;
  update: Maybe<DocumentsDocAccessFields_ThumbnailUrl_Update>;
};

export type DocumentsDocAccessFields_ThumbnailUrl_Create = {
  __typename?: 'DocumentsDocAccessFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_ThumbnailUrl_Delete = {
  __typename?: 'DocumentsDocAccessFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_ThumbnailUrl_Read = {
  __typename?: 'DocumentsDocAccessFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_ThumbnailUrl_Update = {
  __typename?: 'DocumentsDocAccessFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_UpdatedAt = {
  __typename?: 'DocumentsDocAccessFields_updatedAt';
  create: Maybe<DocumentsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<DocumentsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<DocumentsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<DocumentsDocAccessFields_UpdatedAt_Update>;
};

export type DocumentsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'DocumentsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'DocumentsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'DocumentsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'DocumentsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Url = {
  __typename?: 'DocumentsDocAccessFields_url';
  create: Maybe<DocumentsDocAccessFields_Url_Create>;
  delete: Maybe<DocumentsDocAccessFields_Url_Delete>;
  read: Maybe<DocumentsDocAccessFields_Url_Read>;
  update: Maybe<DocumentsDocAccessFields_Url_Update>;
};

export type DocumentsDocAccessFields_Url_Create = {
  __typename?: 'DocumentsDocAccessFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Url_Delete = {
  __typename?: 'DocumentsDocAccessFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Url_Read = {
  __typename?: 'DocumentsDocAccessFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Url_Update = {
  __typename?: 'DocumentsDocAccessFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Width = {
  __typename?: 'DocumentsDocAccessFields_width';
  create: Maybe<DocumentsDocAccessFields_Width_Create>;
  delete: Maybe<DocumentsDocAccessFields_Width_Delete>;
  read: Maybe<DocumentsDocAccessFields_Width_Read>;
  update: Maybe<DocumentsDocAccessFields_Width_Update>;
};

export type DocumentsDocAccessFields_Width_Create = {
  __typename?: 'DocumentsDocAccessFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Width_Delete = {
  __typename?: 'DocumentsDocAccessFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Width_Read = {
  __typename?: 'DocumentsDocAccessFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsDocAccessFields_Width_Update = {
  __typename?: 'DocumentsDocAccessFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields = {
  __typename?: 'DocumentsFields';
  createdAt: Maybe<DocumentsFields_CreatedAt>;
  filename: Maybe<DocumentsFields_Filename>;
  filesize: Maybe<DocumentsFields_Filesize>;
  focalX: Maybe<DocumentsFields_FocalX>;
  focalY: Maybe<DocumentsFields_FocalY>;
  height: Maybe<DocumentsFields_Height>;
  mimeType: Maybe<DocumentsFields_MimeType>;
  thumbnailURL: Maybe<DocumentsFields_ThumbnailUrl>;
  updatedAt: Maybe<DocumentsFields_UpdatedAt>;
  url: Maybe<DocumentsFields_Url>;
  width: Maybe<DocumentsFields_Width>;
};

export type DocumentsFields_CreatedAt = {
  __typename?: 'DocumentsFields_createdAt';
  create: Maybe<DocumentsFields_CreatedAt_Create>;
  delete: Maybe<DocumentsFields_CreatedAt_Delete>;
  read: Maybe<DocumentsFields_CreatedAt_Read>;
  update: Maybe<DocumentsFields_CreatedAt_Update>;
};

export type DocumentsFields_CreatedAt_Create = {
  __typename?: 'DocumentsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_CreatedAt_Delete = {
  __typename?: 'DocumentsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_CreatedAt_Read = {
  __typename?: 'DocumentsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_CreatedAt_Update = {
  __typename?: 'DocumentsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filename = {
  __typename?: 'DocumentsFields_filename';
  create: Maybe<DocumentsFields_Filename_Create>;
  delete: Maybe<DocumentsFields_Filename_Delete>;
  read: Maybe<DocumentsFields_Filename_Read>;
  update: Maybe<DocumentsFields_Filename_Update>;
};

export type DocumentsFields_Filename_Create = {
  __typename?: 'DocumentsFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filename_Delete = {
  __typename?: 'DocumentsFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filename_Read = {
  __typename?: 'DocumentsFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filename_Update = {
  __typename?: 'DocumentsFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filesize = {
  __typename?: 'DocumentsFields_filesize';
  create: Maybe<DocumentsFields_Filesize_Create>;
  delete: Maybe<DocumentsFields_Filesize_Delete>;
  read: Maybe<DocumentsFields_Filesize_Read>;
  update: Maybe<DocumentsFields_Filesize_Update>;
};

export type DocumentsFields_Filesize_Create = {
  __typename?: 'DocumentsFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filesize_Delete = {
  __typename?: 'DocumentsFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filesize_Read = {
  __typename?: 'DocumentsFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Filesize_Update = {
  __typename?: 'DocumentsFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalX = {
  __typename?: 'DocumentsFields_focalX';
  create: Maybe<DocumentsFields_FocalX_Create>;
  delete: Maybe<DocumentsFields_FocalX_Delete>;
  read: Maybe<DocumentsFields_FocalX_Read>;
  update: Maybe<DocumentsFields_FocalX_Update>;
};

export type DocumentsFields_FocalX_Create = {
  __typename?: 'DocumentsFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalX_Delete = {
  __typename?: 'DocumentsFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalX_Read = {
  __typename?: 'DocumentsFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalX_Update = {
  __typename?: 'DocumentsFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalY = {
  __typename?: 'DocumentsFields_focalY';
  create: Maybe<DocumentsFields_FocalY_Create>;
  delete: Maybe<DocumentsFields_FocalY_Delete>;
  read: Maybe<DocumentsFields_FocalY_Read>;
  update: Maybe<DocumentsFields_FocalY_Update>;
};

export type DocumentsFields_FocalY_Create = {
  __typename?: 'DocumentsFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalY_Delete = {
  __typename?: 'DocumentsFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalY_Read = {
  __typename?: 'DocumentsFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_FocalY_Update = {
  __typename?: 'DocumentsFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Height = {
  __typename?: 'DocumentsFields_height';
  create: Maybe<DocumentsFields_Height_Create>;
  delete: Maybe<DocumentsFields_Height_Delete>;
  read: Maybe<DocumentsFields_Height_Read>;
  update: Maybe<DocumentsFields_Height_Update>;
};

export type DocumentsFields_Height_Create = {
  __typename?: 'DocumentsFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Height_Delete = {
  __typename?: 'DocumentsFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Height_Read = {
  __typename?: 'DocumentsFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Height_Update = {
  __typename?: 'DocumentsFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_MimeType = {
  __typename?: 'DocumentsFields_mimeType';
  create: Maybe<DocumentsFields_MimeType_Create>;
  delete: Maybe<DocumentsFields_MimeType_Delete>;
  read: Maybe<DocumentsFields_MimeType_Read>;
  update: Maybe<DocumentsFields_MimeType_Update>;
};

export type DocumentsFields_MimeType_Create = {
  __typename?: 'DocumentsFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_MimeType_Delete = {
  __typename?: 'DocumentsFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_MimeType_Read = {
  __typename?: 'DocumentsFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_MimeType_Update = {
  __typename?: 'DocumentsFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_ThumbnailUrl = {
  __typename?: 'DocumentsFields_thumbnailURL';
  create: Maybe<DocumentsFields_ThumbnailUrl_Create>;
  delete: Maybe<DocumentsFields_ThumbnailUrl_Delete>;
  read: Maybe<DocumentsFields_ThumbnailUrl_Read>;
  update: Maybe<DocumentsFields_ThumbnailUrl_Update>;
};

export type DocumentsFields_ThumbnailUrl_Create = {
  __typename?: 'DocumentsFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_ThumbnailUrl_Delete = {
  __typename?: 'DocumentsFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_ThumbnailUrl_Read = {
  __typename?: 'DocumentsFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_ThumbnailUrl_Update = {
  __typename?: 'DocumentsFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_UpdatedAt = {
  __typename?: 'DocumentsFields_updatedAt';
  create: Maybe<DocumentsFields_UpdatedAt_Create>;
  delete: Maybe<DocumentsFields_UpdatedAt_Delete>;
  read: Maybe<DocumentsFields_UpdatedAt_Read>;
  update: Maybe<DocumentsFields_UpdatedAt_Update>;
};

export type DocumentsFields_UpdatedAt_Create = {
  __typename?: 'DocumentsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_UpdatedAt_Delete = {
  __typename?: 'DocumentsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_UpdatedAt_Read = {
  __typename?: 'DocumentsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_UpdatedAt_Update = {
  __typename?: 'DocumentsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Url = {
  __typename?: 'DocumentsFields_url';
  create: Maybe<DocumentsFields_Url_Create>;
  delete: Maybe<DocumentsFields_Url_Delete>;
  read: Maybe<DocumentsFields_Url_Read>;
  update: Maybe<DocumentsFields_Url_Update>;
};

export type DocumentsFields_Url_Create = {
  __typename?: 'DocumentsFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Url_Delete = {
  __typename?: 'DocumentsFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Url_Read = {
  __typename?: 'DocumentsFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Url_Update = {
  __typename?: 'DocumentsFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Width = {
  __typename?: 'DocumentsFields_width';
  create: Maybe<DocumentsFields_Width_Create>;
  delete: Maybe<DocumentsFields_Width_Delete>;
  read: Maybe<DocumentsFields_Width_Read>;
  update: Maybe<DocumentsFields_Width_Update>;
};

export type DocumentsFields_Width_Create = {
  __typename?: 'DocumentsFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Width_Delete = {
  __typename?: 'DocumentsFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Width_Read = {
  __typename?: 'DocumentsFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsFields_Width_Update = {
  __typename?: 'DocumentsFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type DocumentsReadAccess = {
  __typename?: 'DocumentsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type DocumentsReadDocAccess = {
  __typename?: 'DocumentsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type DocumentsUpdateAccess = {
  __typename?: 'DocumentsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type DocumentsUpdateDocAccess = {
  __typename?: 'DocumentsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Ego = {
  __typename?: 'Ego';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  id: Scalars['Int']['output'];
  name: Scalars['String']['output'];
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export type Ego_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Ego_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Ego_Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Ego_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Ego_Where = {
  AND: InputMaybe<Array<InputMaybe<Ego_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Ego_Where_Or>>>;
  createdAt: InputMaybe<Ego_CreatedAt_Operator>;
  id: InputMaybe<Ego_Id_Operator>;
  name: InputMaybe<Ego_Name_Operator>;
  updatedAt: InputMaybe<Ego_UpdatedAt_Operator>;
};

export type Ego_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Ego_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Ego_Where_Or>>>;
  createdAt: InputMaybe<Ego_CreatedAt_Operator>;
  id: InputMaybe<Ego_Id_Operator>;
  name: InputMaybe<Ego_Name_Operator>;
  updatedAt: InputMaybe<Ego_UpdatedAt_Operator>;
};

export type Ego_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Ego_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Ego_Where_Or>>>;
  createdAt: InputMaybe<Ego_CreatedAt_Operator>;
  id: InputMaybe<Ego_Id_Operator>;
  name: InputMaybe<Ego_Name_Operator>;
  updatedAt: InputMaybe<Ego_UpdatedAt_Operator>;
};

export type Egos = {
  __typename?: 'Egos';
  docs: Array<Ego>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type EgosCreateAccess = {
  __typename?: 'EgosCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EgosCreateDocAccess = {
  __typename?: 'EgosCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EgosDeleteAccess = {
  __typename?: 'EgosDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EgosDeleteDocAccess = {
  __typename?: 'EgosDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EgosDocAccessFields = {
  __typename?: 'EgosDocAccessFields';
  createdAt: Maybe<EgosDocAccessFields_CreatedAt>;
  name: Maybe<EgosDocAccessFields_Name>;
  updatedAt: Maybe<EgosDocAccessFields_UpdatedAt>;
};

export type EgosDocAccessFields_CreatedAt = {
  __typename?: 'EgosDocAccessFields_createdAt';
  create: Maybe<EgosDocAccessFields_CreatedAt_Create>;
  delete: Maybe<EgosDocAccessFields_CreatedAt_Delete>;
  read: Maybe<EgosDocAccessFields_CreatedAt_Read>;
  update: Maybe<EgosDocAccessFields_CreatedAt_Update>;
};

export type EgosDocAccessFields_CreatedAt_Create = {
  __typename?: 'EgosDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_CreatedAt_Delete = {
  __typename?: 'EgosDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_CreatedAt_Read = {
  __typename?: 'EgosDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_CreatedAt_Update = {
  __typename?: 'EgosDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_Name = {
  __typename?: 'EgosDocAccessFields_name';
  create: Maybe<EgosDocAccessFields_Name_Create>;
  delete: Maybe<EgosDocAccessFields_Name_Delete>;
  read: Maybe<EgosDocAccessFields_Name_Read>;
  update: Maybe<EgosDocAccessFields_Name_Update>;
};

export type EgosDocAccessFields_Name_Create = {
  __typename?: 'EgosDocAccessFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_Name_Delete = {
  __typename?: 'EgosDocAccessFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_Name_Read = {
  __typename?: 'EgosDocAccessFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_Name_Update = {
  __typename?: 'EgosDocAccessFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_UpdatedAt = {
  __typename?: 'EgosDocAccessFields_updatedAt';
  create: Maybe<EgosDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<EgosDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<EgosDocAccessFields_UpdatedAt_Read>;
  update: Maybe<EgosDocAccessFields_UpdatedAt_Update>;
};

export type EgosDocAccessFields_UpdatedAt_Create = {
  __typename?: 'EgosDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'EgosDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_UpdatedAt_Read = {
  __typename?: 'EgosDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EgosDocAccessFields_UpdatedAt_Update = {
  __typename?: 'EgosDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields = {
  __typename?: 'EgosFields';
  createdAt: Maybe<EgosFields_CreatedAt>;
  name: Maybe<EgosFields_Name>;
  updatedAt: Maybe<EgosFields_UpdatedAt>;
};

export type EgosFields_CreatedAt = {
  __typename?: 'EgosFields_createdAt';
  create: Maybe<EgosFields_CreatedAt_Create>;
  delete: Maybe<EgosFields_CreatedAt_Delete>;
  read: Maybe<EgosFields_CreatedAt_Read>;
  update: Maybe<EgosFields_CreatedAt_Update>;
};

export type EgosFields_CreatedAt_Create = {
  __typename?: 'EgosFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_CreatedAt_Delete = {
  __typename?: 'EgosFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_CreatedAt_Read = {
  __typename?: 'EgosFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_CreatedAt_Update = {
  __typename?: 'EgosFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_Name = {
  __typename?: 'EgosFields_name';
  create: Maybe<EgosFields_Name_Create>;
  delete: Maybe<EgosFields_Name_Delete>;
  read: Maybe<EgosFields_Name_Read>;
  update: Maybe<EgosFields_Name_Update>;
};

export type EgosFields_Name_Create = {
  __typename?: 'EgosFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_Name_Delete = {
  __typename?: 'EgosFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_Name_Read = {
  __typename?: 'EgosFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_Name_Update = {
  __typename?: 'EgosFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_UpdatedAt = {
  __typename?: 'EgosFields_updatedAt';
  create: Maybe<EgosFields_UpdatedAt_Create>;
  delete: Maybe<EgosFields_UpdatedAt_Delete>;
  read: Maybe<EgosFields_UpdatedAt_Read>;
  update: Maybe<EgosFields_UpdatedAt_Update>;
};

export type EgosFields_UpdatedAt_Create = {
  __typename?: 'EgosFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_UpdatedAt_Delete = {
  __typename?: 'EgosFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_UpdatedAt_Read = {
  __typename?: 'EgosFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EgosFields_UpdatedAt_Update = {
  __typename?: 'EgosFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EgosReadAccess = {
  __typename?: 'EgosReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EgosReadDocAccess = {
  __typename?: 'EgosReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EgosUpdateAccess = {
  __typename?: 'EgosUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EgosUpdateDocAccess = {
  __typename?: 'EgosUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDat = {
  __typename?: 'EsminiDat';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  focalX: Maybe<Scalars['Float']['output']>;
  focalY: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  id: Scalars['Int']['output'];
  mimeType: Maybe<Scalars['String']['output']>;
  thumbnailURL: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type EsminiDat_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type EsminiDat_Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type EsminiDat_Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type EsminiDat_FocalX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type EsminiDat_FocalY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type EsminiDat_Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type EsminiDat_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type EsminiDat_MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type EsminiDat_ThumbnailUrl_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type EsminiDat_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type EsminiDat_Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type EsminiDat_Where = {
  AND: InputMaybe<Array<InputMaybe<EsminiDat_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<EsminiDat_Where_Or>>>;
  createdAt: InputMaybe<EsminiDat_CreatedAt_Operator>;
  filename: InputMaybe<EsminiDat_Filename_Operator>;
  filesize: InputMaybe<EsminiDat_Filesize_Operator>;
  focalX: InputMaybe<EsminiDat_FocalX_Operator>;
  focalY: InputMaybe<EsminiDat_FocalY_Operator>;
  height: InputMaybe<EsminiDat_Height_Operator>;
  id: InputMaybe<EsminiDat_Id_Operator>;
  mimeType: InputMaybe<EsminiDat_MimeType_Operator>;
  thumbnailURL: InputMaybe<EsminiDat_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<EsminiDat_UpdatedAt_Operator>;
  url: InputMaybe<EsminiDat_Url_Operator>;
  width: InputMaybe<EsminiDat_Width_Operator>;
};

export type EsminiDat_Where_And = {
  AND: InputMaybe<Array<InputMaybe<EsminiDat_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<EsminiDat_Where_Or>>>;
  createdAt: InputMaybe<EsminiDat_CreatedAt_Operator>;
  filename: InputMaybe<EsminiDat_Filename_Operator>;
  filesize: InputMaybe<EsminiDat_Filesize_Operator>;
  focalX: InputMaybe<EsminiDat_FocalX_Operator>;
  focalY: InputMaybe<EsminiDat_FocalY_Operator>;
  height: InputMaybe<EsminiDat_Height_Operator>;
  id: InputMaybe<EsminiDat_Id_Operator>;
  mimeType: InputMaybe<EsminiDat_MimeType_Operator>;
  thumbnailURL: InputMaybe<EsminiDat_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<EsminiDat_UpdatedAt_Operator>;
  url: InputMaybe<EsminiDat_Url_Operator>;
  width: InputMaybe<EsminiDat_Width_Operator>;
};

export type EsminiDat_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<EsminiDat_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<EsminiDat_Where_Or>>>;
  createdAt: InputMaybe<EsminiDat_CreatedAt_Operator>;
  filename: InputMaybe<EsminiDat_Filename_Operator>;
  filesize: InputMaybe<EsminiDat_Filesize_Operator>;
  focalX: InputMaybe<EsminiDat_FocalX_Operator>;
  focalY: InputMaybe<EsminiDat_FocalY_Operator>;
  height: InputMaybe<EsminiDat_Height_Operator>;
  id: InputMaybe<EsminiDat_Id_Operator>;
  mimeType: InputMaybe<EsminiDat_MimeType_Operator>;
  thumbnailURL: InputMaybe<EsminiDat_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<EsminiDat_UpdatedAt_Operator>;
  url: InputMaybe<EsminiDat_Url_Operator>;
  width: InputMaybe<EsminiDat_Width_Operator>;
};

export type EsminiDat_Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type EsminiDats = {
  __typename?: 'EsminiDats';
  docs: Array<EsminiDat>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type EsminiDatsCreateAccess = {
  __typename?: 'EsminiDatsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDatsCreateDocAccess = {
  __typename?: 'EsminiDatsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDatsDeleteAccess = {
  __typename?: 'EsminiDatsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDatsDeleteDocAccess = {
  __typename?: 'EsminiDatsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDatsDocAccessFields = {
  __typename?: 'EsminiDatsDocAccessFields';
  createdAt: Maybe<EsminiDatsDocAccessFields_CreatedAt>;
  filename: Maybe<EsminiDatsDocAccessFields_Filename>;
  filesize: Maybe<EsminiDatsDocAccessFields_Filesize>;
  focalX: Maybe<EsminiDatsDocAccessFields_FocalX>;
  focalY: Maybe<EsminiDatsDocAccessFields_FocalY>;
  height: Maybe<EsminiDatsDocAccessFields_Height>;
  mimeType: Maybe<EsminiDatsDocAccessFields_MimeType>;
  thumbnailURL: Maybe<EsminiDatsDocAccessFields_ThumbnailUrl>;
  updatedAt: Maybe<EsminiDatsDocAccessFields_UpdatedAt>;
  url: Maybe<EsminiDatsDocAccessFields_Url>;
  width: Maybe<EsminiDatsDocAccessFields_Width>;
};

export type EsminiDatsDocAccessFields_CreatedAt = {
  __typename?: 'EsminiDatsDocAccessFields_createdAt';
  create: Maybe<EsminiDatsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_CreatedAt_Read>;
  update: Maybe<EsminiDatsDocAccessFields_CreatedAt_Update>;
};

export type EsminiDatsDocAccessFields_CreatedAt_Create = {
  __typename?: 'EsminiDatsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_CreatedAt_Read = {
  __typename?: 'EsminiDatsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_CreatedAt_Update = {
  __typename?: 'EsminiDatsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filename = {
  __typename?: 'EsminiDatsDocAccessFields_filename';
  create: Maybe<EsminiDatsDocAccessFields_Filename_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_Filename_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_Filename_Read>;
  update: Maybe<EsminiDatsDocAccessFields_Filename_Update>;
};

export type EsminiDatsDocAccessFields_Filename_Create = {
  __typename?: 'EsminiDatsDocAccessFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filename_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filename_Read = {
  __typename?: 'EsminiDatsDocAccessFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filename_Update = {
  __typename?: 'EsminiDatsDocAccessFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filesize = {
  __typename?: 'EsminiDatsDocAccessFields_filesize';
  create: Maybe<EsminiDatsDocAccessFields_Filesize_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_Filesize_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_Filesize_Read>;
  update: Maybe<EsminiDatsDocAccessFields_Filesize_Update>;
};

export type EsminiDatsDocAccessFields_Filesize_Create = {
  __typename?: 'EsminiDatsDocAccessFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filesize_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filesize_Read = {
  __typename?: 'EsminiDatsDocAccessFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Filesize_Update = {
  __typename?: 'EsminiDatsDocAccessFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalX = {
  __typename?: 'EsminiDatsDocAccessFields_focalX';
  create: Maybe<EsminiDatsDocAccessFields_FocalX_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_FocalX_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_FocalX_Read>;
  update: Maybe<EsminiDatsDocAccessFields_FocalX_Update>;
};

export type EsminiDatsDocAccessFields_FocalX_Create = {
  __typename?: 'EsminiDatsDocAccessFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalX_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalX_Read = {
  __typename?: 'EsminiDatsDocAccessFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalX_Update = {
  __typename?: 'EsminiDatsDocAccessFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalY = {
  __typename?: 'EsminiDatsDocAccessFields_focalY';
  create: Maybe<EsminiDatsDocAccessFields_FocalY_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_FocalY_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_FocalY_Read>;
  update: Maybe<EsminiDatsDocAccessFields_FocalY_Update>;
};

export type EsminiDatsDocAccessFields_FocalY_Create = {
  __typename?: 'EsminiDatsDocAccessFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalY_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalY_Read = {
  __typename?: 'EsminiDatsDocAccessFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_FocalY_Update = {
  __typename?: 'EsminiDatsDocAccessFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Height = {
  __typename?: 'EsminiDatsDocAccessFields_height';
  create: Maybe<EsminiDatsDocAccessFields_Height_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_Height_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_Height_Read>;
  update: Maybe<EsminiDatsDocAccessFields_Height_Update>;
};

export type EsminiDatsDocAccessFields_Height_Create = {
  __typename?: 'EsminiDatsDocAccessFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Height_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Height_Read = {
  __typename?: 'EsminiDatsDocAccessFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Height_Update = {
  __typename?: 'EsminiDatsDocAccessFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_MimeType = {
  __typename?: 'EsminiDatsDocAccessFields_mimeType';
  create: Maybe<EsminiDatsDocAccessFields_MimeType_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_MimeType_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_MimeType_Read>;
  update: Maybe<EsminiDatsDocAccessFields_MimeType_Update>;
};

export type EsminiDatsDocAccessFields_MimeType_Create = {
  __typename?: 'EsminiDatsDocAccessFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_MimeType_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_MimeType_Read = {
  __typename?: 'EsminiDatsDocAccessFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_MimeType_Update = {
  __typename?: 'EsminiDatsDocAccessFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_ThumbnailUrl = {
  __typename?: 'EsminiDatsDocAccessFields_thumbnailURL';
  create: Maybe<EsminiDatsDocAccessFields_ThumbnailUrl_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_ThumbnailUrl_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_ThumbnailUrl_Read>;
  update: Maybe<EsminiDatsDocAccessFields_ThumbnailUrl_Update>;
};

export type EsminiDatsDocAccessFields_ThumbnailUrl_Create = {
  __typename?: 'EsminiDatsDocAccessFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_ThumbnailUrl_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_ThumbnailUrl_Read = {
  __typename?: 'EsminiDatsDocAccessFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_ThumbnailUrl_Update = {
  __typename?: 'EsminiDatsDocAccessFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_UpdatedAt = {
  __typename?: 'EsminiDatsDocAccessFields_updatedAt';
  create: Maybe<EsminiDatsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<EsminiDatsDocAccessFields_UpdatedAt_Update>;
};

export type EsminiDatsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'EsminiDatsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'EsminiDatsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'EsminiDatsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Url = {
  __typename?: 'EsminiDatsDocAccessFields_url';
  create: Maybe<EsminiDatsDocAccessFields_Url_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_Url_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_Url_Read>;
  update: Maybe<EsminiDatsDocAccessFields_Url_Update>;
};

export type EsminiDatsDocAccessFields_Url_Create = {
  __typename?: 'EsminiDatsDocAccessFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Url_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Url_Read = {
  __typename?: 'EsminiDatsDocAccessFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Url_Update = {
  __typename?: 'EsminiDatsDocAccessFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Width = {
  __typename?: 'EsminiDatsDocAccessFields_width';
  create: Maybe<EsminiDatsDocAccessFields_Width_Create>;
  delete: Maybe<EsminiDatsDocAccessFields_Width_Delete>;
  read: Maybe<EsminiDatsDocAccessFields_Width_Read>;
  update: Maybe<EsminiDatsDocAccessFields_Width_Update>;
};

export type EsminiDatsDocAccessFields_Width_Create = {
  __typename?: 'EsminiDatsDocAccessFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Width_Delete = {
  __typename?: 'EsminiDatsDocAccessFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Width_Read = {
  __typename?: 'EsminiDatsDocAccessFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsDocAccessFields_Width_Update = {
  __typename?: 'EsminiDatsDocAccessFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields = {
  __typename?: 'EsminiDatsFields';
  createdAt: Maybe<EsminiDatsFields_CreatedAt>;
  filename: Maybe<EsminiDatsFields_Filename>;
  filesize: Maybe<EsminiDatsFields_Filesize>;
  focalX: Maybe<EsminiDatsFields_FocalX>;
  focalY: Maybe<EsminiDatsFields_FocalY>;
  height: Maybe<EsminiDatsFields_Height>;
  mimeType: Maybe<EsminiDatsFields_MimeType>;
  thumbnailURL: Maybe<EsminiDatsFields_ThumbnailUrl>;
  updatedAt: Maybe<EsminiDatsFields_UpdatedAt>;
  url: Maybe<EsminiDatsFields_Url>;
  width: Maybe<EsminiDatsFields_Width>;
};

export type EsminiDatsFields_CreatedAt = {
  __typename?: 'EsminiDatsFields_createdAt';
  create: Maybe<EsminiDatsFields_CreatedAt_Create>;
  delete: Maybe<EsminiDatsFields_CreatedAt_Delete>;
  read: Maybe<EsminiDatsFields_CreatedAt_Read>;
  update: Maybe<EsminiDatsFields_CreatedAt_Update>;
};

export type EsminiDatsFields_CreatedAt_Create = {
  __typename?: 'EsminiDatsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_CreatedAt_Delete = {
  __typename?: 'EsminiDatsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_CreatedAt_Read = {
  __typename?: 'EsminiDatsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_CreatedAt_Update = {
  __typename?: 'EsminiDatsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filename = {
  __typename?: 'EsminiDatsFields_filename';
  create: Maybe<EsminiDatsFields_Filename_Create>;
  delete: Maybe<EsminiDatsFields_Filename_Delete>;
  read: Maybe<EsminiDatsFields_Filename_Read>;
  update: Maybe<EsminiDatsFields_Filename_Update>;
};

export type EsminiDatsFields_Filename_Create = {
  __typename?: 'EsminiDatsFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filename_Delete = {
  __typename?: 'EsminiDatsFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filename_Read = {
  __typename?: 'EsminiDatsFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filename_Update = {
  __typename?: 'EsminiDatsFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filesize = {
  __typename?: 'EsminiDatsFields_filesize';
  create: Maybe<EsminiDatsFields_Filesize_Create>;
  delete: Maybe<EsminiDatsFields_Filesize_Delete>;
  read: Maybe<EsminiDatsFields_Filesize_Read>;
  update: Maybe<EsminiDatsFields_Filesize_Update>;
};

export type EsminiDatsFields_Filesize_Create = {
  __typename?: 'EsminiDatsFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filesize_Delete = {
  __typename?: 'EsminiDatsFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filesize_Read = {
  __typename?: 'EsminiDatsFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Filesize_Update = {
  __typename?: 'EsminiDatsFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalX = {
  __typename?: 'EsminiDatsFields_focalX';
  create: Maybe<EsminiDatsFields_FocalX_Create>;
  delete: Maybe<EsminiDatsFields_FocalX_Delete>;
  read: Maybe<EsminiDatsFields_FocalX_Read>;
  update: Maybe<EsminiDatsFields_FocalX_Update>;
};

export type EsminiDatsFields_FocalX_Create = {
  __typename?: 'EsminiDatsFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalX_Delete = {
  __typename?: 'EsminiDatsFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalX_Read = {
  __typename?: 'EsminiDatsFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalX_Update = {
  __typename?: 'EsminiDatsFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalY = {
  __typename?: 'EsminiDatsFields_focalY';
  create: Maybe<EsminiDatsFields_FocalY_Create>;
  delete: Maybe<EsminiDatsFields_FocalY_Delete>;
  read: Maybe<EsminiDatsFields_FocalY_Read>;
  update: Maybe<EsminiDatsFields_FocalY_Update>;
};

export type EsminiDatsFields_FocalY_Create = {
  __typename?: 'EsminiDatsFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalY_Delete = {
  __typename?: 'EsminiDatsFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalY_Read = {
  __typename?: 'EsminiDatsFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_FocalY_Update = {
  __typename?: 'EsminiDatsFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Height = {
  __typename?: 'EsminiDatsFields_height';
  create: Maybe<EsminiDatsFields_Height_Create>;
  delete: Maybe<EsminiDatsFields_Height_Delete>;
  read: Maybe<EsminiDatsFields_Height_Read>;
  update: Maybe<EsminiDatsFields_Height_Update>;
};

export type EsminiDatsFields_Height_Create = {
  __typename?: 'EsminiDatsFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Height_Delete = {
  __typename?: 'EsminiDatsFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Height_Read = {
  __typename?: 'EsminiDatsFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Height_Update = {
  __typename?: 'EsminiDatsFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_MimeType = {
  __typename?: 'EsminiDatsFields_mimeType';
  create: Maybe<EsminiDatsFields_MimeType_Create>;
  delete: Maybe<EsminiDatsFields_MimeType_Delete>;
  read: Maybe<EsminiDatsFields_MimeType_Read>;
  update: Maybe<EsminiDatsFields_MimeType_Update>;
};

export type EsminiDatsFields_MimeType_Create = {
  __typename?: 'EsminiDatsFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_MimeType_Delete = {
  __typename?: 'EsminiDatsFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_MimeType_Read = {
  __typename?: 'EsminiDatsFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_MimeType_Update = {
  __typename?: 'EsminiDatsFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_ThumbnailUrl = {
  __typename?: 'EsminiDatsFields_thumbnailURL';
  create: Maybe<EsminiDatsFields_ThumbnailUrl_Create>;
  delete: Maybe<EsminiDatsFields_ThumbnailUrl_Delete>;
  read: Maybe<EsminiDatsFields_ThumbnailUrl_Read>;
  update: Maybe<EsminiDatsFields_ThumbnailUrl_Update>;
};

export type EsminiDatsFields_ThumbnailUrl_Create = {
  __typename?: 'EsminiDatsFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_ThumbnailUrl_Delete = {
  __typename?: 'EsminiDatsFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_ThumbnailUrl_Read = {
  __typename?: 'EsminiDatsFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_ThumbnailUrl_Update = {
  __typename?: 'EsminiDatsFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_UpdatedAt = {
  __typename?: 'EsminiDatsFields_updatedAt';
  create: Maybe<EsminiDatsFields_UpdatedAt_Create>;
  delete: Maybe<EsminiDatsFields_UpdatedAt_Delete>;
  read: Maybe<EsminiDatsFields_UpdatedAt_Read>;
  update: Maybe<EsminiDatsFields_UpdatedAt_Update>;
};

export type EsminiDatsFields_UpdatedAt_Create = {
  __typename?: 'EsminiDatsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_UpdatedAt_Delete = {
  __typename?: 'EsminiDatsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_UpdatedAt_Read = {
  __typename?: 'EsminiDatsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_UpdatedAt_Update = {
  __typename?: 'EsminiDatsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Url = {
  __typename?: 'EsminiDatsFields_url';
  create: Maybe<EsminiDatsFields_Url_Create>;
  delete: Maybe<EsminiDatsFields_Url_Delete>;
  read: Maybe<EsminiDatsFields_Url_Read>;
  update: Maybe<EsminiDatsFields_Url_Update>;
};

export type EsminiDatsFields_Url_Create = {
  __typename?: 'EsminiDatsFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Url_Delete = {
  __typename?: 'EsminiDatsFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Url_Read = {
  __typename?: 'EsminiDatsFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Url_Update = {
  __typename?: 'EsminiDatsFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Width = {
  __typename?: 'EsminiDatsFields_width';
  create: Maybe<EsminiDatsFields_Width_Create>;
  delete: Maybe<EsminiDatsFields_Width_Delete>;
  read: Maybe<EsminiDatsFields_Width_Read>;
  update: Maybe<EsminiDatsFields_Width_Update>;
};

export type EsminiDatsFields_Width_Create = {
  __typename?: 'EsminiDatsFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Width_Delete = {
  __typename?: 'EsminiDatsFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Width_Read = {
  __typename?: 'EsminiDatsFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsFields_Width_Update = {
  __typename?: 'EsminiDatsFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type EsminiDatsReadAccess = {
  __typename?: 'EsminiDatsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDatsReadDocAccess = {
  __typename?: 'EsminiDatsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDatsUpdateAccess = {
  __typename?: 'EsminiDatsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type EsminiDatsUpdateDocAccess = {
  __typename?: 'EsminiDatsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicator = {
  __typename?: 'KeyPerformanceIndicator';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  description: Maybe<Scalars['String']['output']>;
  id: Scalars['Int']['output'];
  name: Scalars['String']['output'];
  rule: KeyPerformanceIndicator_Rule;
  unit: Scalars['String']['output'];
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export enum KeyPerformanceIndicatorUpdate_Rule_MutationInput {
  GreaterThan = 'greaterThan',
  LessThan = 'lessThan'
}

export type KeyPerformanceIndicator_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type KeyPerformanceIndicator_Description_Operator = {
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
};

export type KeyPerformanceIndicator_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type KeyPerformanceIndicator_Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export enum KeyPerformanceIndicator_Rule {
  GreaterThan = 'greaterThan',
  LessThan = 'lessThan'
}

export enum KeyPerformanceIndicator_Rule_Input {
  GreaterThan = 'greaterThan',
  LessThan = 'lessThan'
}

export enum KeyPerformanceIndicator_Rule_MutationInput {
  GreaterThan = 'greaterThan',
  LessThan = 'lessThan'
}

export type KeyPerformanceIndicator_Rule_Operator = {
  all: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Rule_Input>>>;
  equals: InputMaybe<KeyPerformanceIndicator_Rule_Input>;
  in: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Rule_Input>>>;
  not_equals: InputMaybe<KeyPerformanceIndicator_Rule_Input>;
  not_in: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Rule_Input>>>;
};

export type KeyPerformanceIndicator_Unit_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type KeyPerformanceIndicator_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type KeyPerformanceIndicator_Where = {
  AND: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Where_Or>>>;
  createdAt: InputMaybe<KeyPerformanceIndicator_CreatedAt_Operator>;
  description: InputMaybe<KeyPerformanceIndicator_Description_Operator>;
  id: InputMaybe<KeyPerformanceIndicator_Id_Operator>;
  name: InputMaybe<KeyPerformanceIndicator_Name_Operator>;
  rule: InputMaybe<KeyPerformanceIndicator_Rule_Operator>;
  unit: InputMaybe<KeyPerformanceIndicator_Unit_Operator>;
  updatedAt: InputMaybe<KeyPerformanceIndicator_UpdatedAt_Operator>;
};

export type KeyPerformanceIndicator_Where_And = {
  AND: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Where_Or>>>;
  createdAt: InputMaybe<KeyPerformanceIndicator_CreatedAt_Operator>;
  description: InputMaybe<KeyPerformanceIndicator_Description_Operator>;
  id: InputMaybe<KeyPerformanceIndicator_Id_Operator>;
  name: InputMaybe<KeyPerformanceIndicator_Name_Operator>;
  rule: InputMaybe<KeyPerformanceIndicator_Rule_Operator>;
  unit: InputMaybe<KeyPerformanceIndicator_Unit_Operator>;
  updatedAt: InputMaybe<KeyPerformanceIndicator_UpdatedAt_Operator>;
};

export type KeyPerformanceIndicator_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<KeyPerformanceIndicator_Where_Or>>>;
  createdAt: InputMaybe<KeyPerformanceIndicator_CreatedAt_Operator>;
  description: InputMaybe<KeyPerformanceIndicator_Description_Operator>;
  id: InputMaybe<KeyPerformanceIndicator_Id_Operator>;
  name: InputMaybe<KeyPerformanceIndicator_Name_Operator>;
  rule: InputMaybe<KeyPerformanceIndicator_Rule_Operator>;
  unit: InputMaybe<KeyPerformanceIndicator_Unit_Operator>;
  updatedAt: InputMaybe<KeyPerformanceIndicator_UpdatedAt_Operator>;
};

export type KeyPerformanceIndicators = {
  __typename?: 'KeyPerformanceIndicators';
  docs: Array<KeyPerformanceIndicator>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type KeyPerformanceIndicatorsCreateAccess = {
  __typename?: 'KeyPerformanceIndicatorsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicatorsCreateDocAccess = {
  __typename?: 'KeyPerformanceIndicatorsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicatorsDeleteAccess = {
  __typename?: 'KeyPerformanceIndicatorsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicatorsDeleteDocAccess = {
  __typename?: 'KeyPerformanceIndicatorsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicatorsDocAccessFields = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields';
  createdAt: Maybe<KeyPerformanceIndicatorsDocAccessFields_CreatedAt>;
  description: Maybe<KeyPerformanceIndicatorsDocAccessFields_Description>;
  name: Maybe<KeyPerformanceIndicatorsDocAccessFields_Name>;
  rule: Maybe<KeyPerformanceIndicatorsDocAccessFields_Rule>;
  unit: Maybe<KeyPerformanceIndicatorsDocAccessFields_Unit>;
  updatedAt: Maybe<KeyPerformanceIndicatorsDocAccessFields_UpdatedAt>;
};

export type KeyPerformanceIndicatorsDocAccessFields_CreatedAt = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_createdAt';
  create: Maybe<KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Read>;
  update: Maybe<KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Update>;
};

export type KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Create = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Read = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_CreatedAt_Update = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Description = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_description';
  create: Maybe<KeyPerformanceIndicatorsDocAccessFields_Description_Create>;
  delete: Maybe<KeyPerformanceIndicatorsDocAccessFields_Description_Delete>;
  read: Maybe<KeyPerformanceIndicatorsDocAccessFields_Description_Read>;
  update: Maybe<KeyPerformanceIndicatorsDocAccessFields_Description_Update>;
};

export type KeyPerformanceIndicatorsDocAccessFields_Description_Create = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Description_Delete = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Description_Read = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Description_Update = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Name = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_name';
  create: Maybe<KeyPerformanceIndicatorsDocAccessFields_Name_Create>;
  delete: Maybe<KeyPerformanceIndicatorsDocAccessFields_Name_Delete>;
  read: Maybe<KeyPerformanceIndicatorsDocAccessFields_Name_Read>;
  update: Maybe<KeyPerformanceIndicatorsDocAccessFields_Name_Update>;
};

export type KeyPerformanceIndicatorsDocAccessFields_Name_Create = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Name_Delete = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Name_Read = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Name_Update = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Rule = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_rule';
  create: Maybe<KeyPerformanceIndicatorsDocAccessFields_Rule_Create>;
  delete: Maybe<KeyPerformanceIndicatorsDocAccessFields_Rule_Delete>;
  read: Maybe<KeyPerformanceIndicatorsDocAccessFields_Rule_Read>;
  update: Maybe<KeyPerformanceIndicatorsDocAccessFields_Rule_Update>;
};

export type KeyPerformanceIndicatorsDocAccessFields_Rule_Create = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_rule_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Rule_Delete = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_rule_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Rule_Read = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_rule_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Rule_Update = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_rule_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Unit = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_unit';
  create: Maybe<KeyPerformanceIndicatorsDocAccessFields_Unit_Create>;
  delete: Maybe<KeyPerformanceIndicatorsDocAccessFields_Unit_Delete>;
  read: Maybe<KeyPerformanceIndicatorsDocAccessFields_Unit_Read>;
  update: Maybe<KeyPerformanceIndicatorsDocAccessFields_Unit_Update>;
};

export type KeyPerformanceIndicatorsDocAccessFields_Unit_Create = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_unit_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Unit_Delete = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_unit_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Unit_Read = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_unit_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_Unit_Update = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_unit_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_UpdatedAt = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_updatedAt';
  create: Maybe<KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Update>;
};

export type KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'KeyPerformanceIndicatorsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields = {
  __typename?: 'KeyPerformanceIndicatorsFields';
  createdAt: Maybe<KeyPerformanceIndicatorsFields_CreatedAt>;
  description: Maybe<KeyPerformanceIndicatorsFields_Description>;
  name: Maybe<KeyPerformanceIndicatorsFields_Name>;
  rule: Maybe<KeyPerformanceIndicatorsFields_Rule>;
  unit: Maybe<KeyPerformanceIndicatorsFields_Unit>;
  updatedAt: Maybe<KeyPerformanceIndicatorsFields_UpdatedAt>;
};

export type KeyPerformanceIndicatorsFields_CreatedAt = {
  __typename?: 'KeyPerformanceIndicatorsFields_createdAt';
  create: Maybe<KeyPerformanceIndicatorsFields_CreatedAt_Create>;
  delete: Maybe<KeyPerformanceIndicatorsFields_CreatedAt_Delete>;
  read: Maybe<KeyPerformanceIndicatorsFields_CreatedAt_Read>;
  update: Maybe<KeyPerformanceIndicatorsFields_CreatedAt_Update>;
};

export type KeyPerformanceIndicatorsFields_CreatedAt_Create = {
  __typename?: 'KeyPerformanceIndicatorsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_CreatedAt_Delete = {
  __typename?: 'KeyPerformanceIndicatorsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_CreatedAt_Read = {
  __typename?: 'KeyPerformanceIndicatorsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_CreatedAt_Update = {
  __typename?: 'KeyPerformanceIndicatorsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Description = {
  __typename?: 'KeyPerformanceIndicatorsFields_description';
  create: Maybe<KeyPerformanceIndicatorsFields_Description_Create>;
  delete: Maybe<KeyPerformanceIndicatorsFields_Description_Delete>;
  read: Maybe<KeyPerformanceIndicatorsFields_Description_Read>;
  update: Maybe<KeyPerformanceIndicatorsFields_Description_Update>;
};

export type KeyPerformanceIndicatorsFields_Description_Create = {
  __typename?: 'KeyPerformanceIndicatorsFields_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Description_Delete = {
  __typename?: 'KeyPerformanceIndicatorsFields_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Description_Read = {
  __typename?: 'KeyPerformanceIndicatorsFields_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Description_Update = {
  __typename?: 'KeyPerformanceIndicatorsFields_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Name = {
  __typename?: 'KeyPerformanceIndicatorsFields_name';
  create: Maybe<KeyPerformanceIndicatorsFields_Name_Create>;
  delete: Maybe<KeyPerformanceIndicatorsFields_Name_Delete>;
  read: Maybe<KeyPerformanceIndicatorsFields_Name_Read>;
  update: Maybe<KeyPerformanceIndicatorsFields_Name_Update>;
};

export type KeyPerformanceIndicatorsFields_Name_Create = {
  __typename?: 'KeyPerformanceIndicatorsFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Name_Delete = {
  __typename?: 'KeyPerformanceIndicatorsFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Name_Read = {
  __typename?: 'KeyPerformanceIndicatorsFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Name_Update = {
  __typename?: 'KeyPerformanceIndicatorsFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Rule = {
  __typename?: 'KeyPerformanceIndicatorsFields_rule';
  create: Maybe<KeyPerformanceIndicatorsFields_Rule_Create>;
  delete: Maybe<KeyPerformanceIndicatorsFields_Rule_Delete>;
  read: Maybe<KeyPerformanceIndicatorsFields_Rule_Read>;
  update: Maybe<KeyPerformanceIndicatorsFields_Rule_Update>;
};

export type KeyPerformanceIndicatorsFields_Rule_Create = {
  __typename?: 'KeyPerformanceIndicatorsFields_rule_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Rule_Delete = {
  __typename?: 'KeyPerformanceIndicatorsFields_rule_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Rule_Read = {
  __typename?: 'KeyPerformanceIndicatorsFields_rule_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Rule_Update = {
  __typename?: 'KeyPerformanceIndicatorsFields_rule_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Unit = {
  __typename?: 'KeyPerformanceIndicatorsFields_unit';
  create: Maybe<KeyPerformanceIndicatorsFields_Unit_Create>;
  delete: Maybe<KeyPerformanceIndicatorsFields_Unit_Delete>;
  read: Maybe<KeyPerformanceIndicatorsFields_Unit_Read>;
  update: Maybe<KeyPerformanceIndicatorsFields_Unit_Update>;
};

export type KeyPerformanceIndicatorsFields_Unit_Create = {
  __typename?: 'KeyPerformanceIndicatorsFields_unit_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Unit_Delete = {
  __typename?: 'KeyPerformanceIndicatorsFields_unit_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Unit_Read = {
  __typename?: 'KeyPerformanceIndicatorsFields_unit_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_Unit_Update = {
  __typename?: 'KeyPerformanceIndicatorsFields_unit_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_UpdatedAt = {
  __typename?: 'KeyPerformanceIndicatorsFields_updatedAt';
  create: Maybe<KeyPerformanceIndicatorsFields_UpdatedAt_Create>;
  delete: Maybe<KeyPerformanceIndicatorsFields_UpdatedAt_Delete>;
  read: Maybe<KeyPerformanceIndicatorsFields_UpdatedAt_Read>;
  update: Maybe<KeyPerformanceIndicatorsFields_UpdatedAt_Update>;
};

export type KeyPerformanceIndicatorsFields_UpdatedAt_Create = {
  __typename?: 'KeyPerformanceIndicatorsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_UpdatedAt_Delete = {
  __typename?: 'KeyPerformanceIndicatorsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_UpdatedAt_Read = {
  __typename?: 'KeyPerformanceIndicatorsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsFields_UpdatedAt_Update = {
  __typename?: 'KeyPerformanceIndicatorsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type KeyPerformanceIndicatorsReadAccess = {
  __typename?: 'KeyPerformanceIndicatorsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicatorsReadDocAccess = {
  __typename?: 'KeyPerformanceIndicatorsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicatorsUpdateAccess = {
  __typename?: 'KeyPerformanceIndicatorsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type KeyPerformanceIndicatorsUpdateDocAccess = {
  __typename?: 'KeyPerformanceIndicatorsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Media = {
  __typename?: 'Media';
  alt: Scalars['String']['output'];
  createdAt: Maybe<Scalars['DateTime']['output']>;
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  focalX: Maybe<Scalars['Float']['output']>;
  focalY: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  id: Scalars['Int']['output'];
  mimeType: Maybe<Scalars['String']['output']>;
  sizes: Maybe<Media_Sizes>;
  thumbnailURL: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type MediaCreateAccess = {
  __typename?: 'MediaCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type MediaCreateDocAccess = {
  __typename?: 'MediaCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type MediaDeleteAccess = {
  __typename?: 'MediaDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type MediaDeleteDocAccess = {
  __typename?: 'MediaDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type MediaDocAccessFields = {
  __typename?: 'MediaDocAccessFields';
  alt: Maybe<MediaDocAccessFields_Alt>;
  createdAt: Maybe<MediaDocAccessFields_CreatedAt>;
  filename: Maybe<MediaDocAccessFields_Filename>;
  filesize: Maybe<MediaDocAccessFields_Filesize>;
  focalX: Maybe<MediaDocAccessFields_FocalX>;
  focalY: Maybe<MediaDocAccessFields_FocalY>;
  height: Maybe<MediaDocAccessFields_Height>;
  mimeType: Maybe<MediaDocAccessFields_MimeType>;
  sizes: Maybe<MediaDocAccessFields_Sizes>;
  thumbnailURL: Maybe<MediaDocAccessFields_ThumbnailUrl>;
  updatedAt: Maybe<MediaDocAccessFields_UpdatedAt>;
  url: Maybe<MediaDocAccessFields_Url>;
  width: Maybe<MediaDocAccessFields_Width>;
};

export type MediaDocAccessFields_Alt = {
  __typename?: 'MediaDocAccessFields_alt';
  create: Maybe<MediaDocAccessFields_Alt_Create>;
  delete: Maybe<MediaDocAccessFields_Alt_Delete>;
  read: Maybe<MediaDocAccessFields_Alt_Read>;
  update: Maybe<MediaDocAccessFields_Alt_Update>;
};

export type MediaDocAccessFields_Alt_Create = {
  __typename?: 'MediaDocAccessFields_alt_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Alt_Delete = {
  __typename?: 'MediaDocAccessFields_alt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Alt_Read = {
  __typename?: 'MediaDocAccessFields_alt_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Alt_Update = {
  __typename?: 'MediaDocAccessFields_alt_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_CreatedAt = {
  __typename?: 'MediaDocAccessFields_createdAt';
  create: Maybe<MediaDocAccessFields_CreatedAt_Create>;
  delete: Maybe<MediaDocAccessFields_CreatedAt_Delete>;
  read: Maybe<MediaDocAccessFields_CreatedAt_Read>;
  update: Maybe<MediaDocAccessFields_CreatedAt_Update>;
};

export type MediaDocAccessFields_CreatedAt_Create = {
  __typename?: 'MediaDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_CreatedAt_Delete = {
  __typename?: 'MediaDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_CreatedAt_Read = {
  __typename?: 'MediaDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_CreatedAt_Update = {
  __typename?: 'MediaDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filename = {
  __typename?: 'MediaDocAccessFields_filename';
  create: Maybe<MediaDocAccessFields_Filename_Create>;
  delete: Maybe<MediaDocAccessFields_Filename_Delete>;
  read: Maybe<MediaDocAccessFields_Filename_Read>;
  update: Maybe<MediaDocAccessFields_Filename_Update>;
};

export type MediaDocAccessFields_Filename_Create = {
  __typename?: 'MediaDocAccessFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filename_Delete = {
  __typename?: 'MediaDocAccessFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filename_Read = {
  __typename?: 'MediaDocAccessFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filename_Update = {
  __typename?: 'MediaDocAccessFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filesize = {
  __typename?: 'MediaDocAccessFields_filesize';
  create: Maybe<MediaDocAccessFields_Filesize_Create>;
  delete: Maybe<MediaDocAccessFields_Filesize_Delete>;
  read: Maybe<MediaDocAccessFields_Filesize_Read>;
  update: Maybe<MediaDocAccessFields_Filesize_Update>;
};

export type MediaDocAccessFields_Filesize_Create = {
  __typename?: 'MediaDocAccessFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filesize_Delete = {
  __typename?: 'MediaDocAccessFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filesize_Read = {
  __typename?: 'MediaDocAccessFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Filesize_Update = {
  __typename?: 'MediaDocAccessFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalX = {
  __typename?: 'MediaDocAccessFields_focalX';
  create: Maybe<MediaDocAccessFields_FocalX_Create>;
  delete: Maybe<MediaDocAccessFields_FocalX_Delete>;
  read: Maybe<MediaDocAccessFields_FocalX_Read>;
  update: Maybe<MediaDocAccessFields_FocalX_Update>;
};

export type MediaDocAccessFields_FocalX_Create = {
  __typename?: 'MediaDocAccessFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalX_Delete = {
  __typename?: 'MediaDocAccessFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalX_Read = {
  __typename?: 'MediaDocAccessFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalX_Update = {
  __typename?: 'MediaDocAccessFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalY = {
  __typename?: 'MediaDocAccessFields_focalY';
  create: Maybe<MediaDocAccessFields_FocalY_Create>;
  delete: Maybe<MediaDocAccessFields_FocalY_Delete>;
  read: Maybe<MediaDocAccessFields_FocalY_Read>;
  update: Maybe<MediaDocAccessFields_FocalY_Update>;
};

export type MediaDocAccessFields_FocalY_Create = {
  __typename?: 'MediaDocAccessFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalY_Delete = {
  __typename?: 'MediaDocAccessFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalY_Read = {
  __typename?: 'MediaDocAccessFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_FocalY_Update = {
  __typename?: 'MediaDocAccessFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Height = {
  __typename?: 'MediaDocAccessFields_height';
  create: Maybe<MediaDocAccessFields_Height_Create>;
  delete: Maybe<MediaDocAccessFields_Height_Delete>;
  read: Maybe<MediaDocAccessFields_Height_Read>;
  update: Maybe<MediaDocAccessFields_Height_Update>;
};

export type MediaDocAccessFields_Height_Create = {
  __typename?: 'MediaDocAccessFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Height_Delete = {
  __typename?: 'MediaDocAccessFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Height_Read = {
  __typename?: 'MediaDocAccessFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Height_Update = {
  __typename?: 'MediaDocAccessFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_MimeType = {
  __typename?: 'MediaDocAccessFields_mimeType';
  create: Maybe<MediaDocAccessFields_MimeType_Create>;
  delete: Maybe<MediaDocAccessFields_MimeType_Delete>;
  read: Maybe<MediaDocAccessFields_MimeType_Read>;
  update: Maybe<MediaDocAccessFields_MimeType_Update>;
};

export type MediaDocAccessFields_MimeType_Create = {
  __typename?: 'MediaDocAccessFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_MimeType_Delete = {
  __typename?: 'MediaDocAccessFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_MimeType_Read = {
  __typename?: 'MediaDocAccessFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_MimeType_Update = {
  __typename?: 'MediaDocAccessFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes = {
  __typename?: 'MediaDocAccessFields_sizes';
  create: Maybe<MediaDocAccessFields_Sizes_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Delete>;
  fields: Maybe<MediaDocAccessFields_Sizes_Fields>;
  read: Maybe<MediaDocAccessFields_Sizes_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Update>;
};

export type MediaDocAccessFields_Sizes_Create = {
  __typename?: 'MediaDocAccessFields_sizes_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Fields = {
  __typename?: 'MediaDocAccessFields_sizes_Fields';
  card: Maybe<MediaDocAccessFields_Sizes_Card>;
  tablet: Maybe<MediaDocAccessFields_Sizes_Tablet>;
  thumbnail: Maybe<MediaDocAccessFields_Sizes_Thumbnail>;
};

export type MediaDocAccessFields_Sizes_Read = {
  __typename?: 'MediaDocAccessFields_sizes_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Update = {
  __typename?: 'MediaDocAccessFields_sizes_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card = {
  __typename?: 'MediaDocAccessFields_sizes_card';
  create: Maybe<MediaDocAccessFields_Sizes_Card_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Card_Delete>;
  fields: Maybe<MediaDocAccessFields_Sizes_Card_Fields>;
  read: Maybe<MediaDocAccessFields_Sizes_Card_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Card_Update>;
};

export type MediaDocAccessFields_Sizes_Card_Create = {
  __typename?: 'MediaDocAccessFields_sizes_card_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_card_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Fields = {
  __typename?: 'MediaDocAccessFields_sizes_card_Fields';
  filename: Maybe<MediaDocAccessFields_Sizes_Card_Filename>;
  filesize: Maybe<MediaDocAccessFields_Sizes_Card_Filesize>;
  height: Maybe<MediaDocAccessFields_Sizes_Card_Height>;
  mimeType: Maybe<MediaDocAccessFields_Sizes_Card_MimeType>;
  url: Maybe<MediaDocAccessFields_Sizes_Card_Url>;
  width: Maybe<MediaDocAccessFields_Sizes_Card_Width>;
};

export type MediaDocAccessFields_Sizes_Card_Read = {
  __typename?: 'MediaDocAccessFields_sizes_card_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Update = {
  __typename?: 'MediaDocAccessFields_sizes_card_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filename = {
  __typename?: 'MediaDocAccessFields_sizes_card_filename';
  create: Maybe<MediaDocAccessFields_Sizes_Card_Filename_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Card_Filename_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Card_Filename_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Card_Filename_Update>;
};

export type MediaDocAccessFields_Sizes_Card_Filename_Create = {
  __typename?: 'MediaDocAccessFields_sizes_card_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filename_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_card_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filename_Read = {
  __typename?: 'MediaDocAccessFields_sizes_card_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filename_Update = {
  __typename?: 'MediaDocAccessFields_sizes_card_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filesize = {
  __typename?: 'MediaDocAccessFields_sizes_card_filesize';
  create: Maybe<MediaDocAccessFields_Sizes_Card_Filesize_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Card_Filesize_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Card_Filesize_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Card_Filesize_Update>;
};

export type MediaDocAccessFields_Sizes_Card_Filesize_Create = {
  __typename?: 'MediaDocAccessFields_sizes_card_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filesize_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_card_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filesize_Read = {
  __typename?: 'MediaDocAccessFields_sizes_card_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Filesize_Update = {
  __typename?: 'MediaDocAccessFields_sizes_card_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Height = {
  __typename?: 'MediaDocAccessFields_sizes_card_height';
  create: Maybe<MediaDocAccessFields_Sizes_Card_Height_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Card_Height_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Card_Height_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Card_Height_Update>;
};

export type MediaDocAccessFields_Sizes_Card_Height_Create = {
  __typename?: 'MediaDocAccessFields_sizes_card_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Height_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_card_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Height_Read = {
  __typename?: 'MediaDocAccessFields_sizes_card_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Height_Update = {
  __typename?: 'MediaDocAccessFields_sizes_card_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_MimeType = {
  __typename?: 'MediaDocAccessFields_sizes_card_mimeType';
  create: Maybe<MediaDocAccessFields_Sizes_Card_MimeType_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Card_MimeType_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Card_MimeType_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Card_MimeType_Update>;
};

export type MediaDocAccessFields_Sizes_Card_MimeType_Create = {
  __typename?: 'MediaDocAccessFields_sizes_card_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_MimeType_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_card_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_MimeType_Read = {
  __typename?: 'MediaDocAccessFields_sizes_card_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_MimeType_Update = {
  __typename?: 'MediaDocAccessFields_sizes_card_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Url = {
  __typename?: 'MediaDocAccessFields_sizes_card_url';
  create: Maybe<MediaDocAccessFields_Sizes_Card_Url_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Card_Url_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Card_Url_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Card_Url_Update>;
};

export type MediaDocAccessFields_Sizes_Card_Url_Create = {
  __typename?: 'MediaDocAccessFields_sizes_card_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Url_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_card_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Url_Read = {
  __typename?: 'MediaDocAccessFields_sizes_card_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Url_Update = {
  __typename?: 'MediaDocAccessFields_sizes_card_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Width = {
  __typename?: 'MediaDocAccessFields_sizes_card_width';
  create: Maybe<MediaDocAccessFields_Sizes_Card_Width_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Card_Width_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Card_Width_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Card_Width_Update>;
};

export type MediaDocAccessFields_Sizes_Card_Width_Create = {
  __typename?: 'MediaDocAccessFields_sizes_card_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Width_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_card_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Width_Read = {
  __typename?: 'MediaDocAccessFields_sizes_card_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Card_Width_Update = {
  __typename?: 'MediaDocAccessFields_sizes_card_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet = {
  __typename?: 'MediaDocAccessFields_sizes_tablet';
  create: Maybe<MediaDocAccessFields_Sizes_Tablet_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Tablet_Delete>;
  fields: Maybe<MediaDocAccessFields_Sizes_Tablet_Fields>;
  read: Maybe<MediaDocAccessFields_Sizes_Tablet_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Tablet_Update>;
};

export type MediaDocAccessFields_Sizes_Tablet_Create = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Fields = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_Fields';
  filename: Maybe<MediaDocAccessFields_Sizes_Tablet_Filename>;
  filesize: Maybe<MediaDocAccessFields_Sizes_Tablet_Filesize>;
  height: Maybe<MediaDocAccessFields_Sizes_Tablet_Height>;
  mimeType: Maybe<MediaDocAccessFields_Sizes_Tablet_MimeType>;
  url: Maybe<MediaDocAccessFields_Sizes_Tablet_Url>;
  width: Maybe<MediaDocAccessFields_Sizes_Tablet_Width>;
};

export type MediaDocAccessFields_Sizes_Tablet_Read = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Update = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filename = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filename';
  create: Maybe<MediaDocAccessFields_Sizes_Tablet_Filename_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Tablet_Filename_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Tablet_Filename_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Tablet_Filename_Update>;
};

export type MediaDocAccessFields_Sizes_Tablet_Filename_Create = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filename_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filename_Read = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filename_Update = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filesize = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filesize';
  create: Maybe<MediaDocAccessFields_Sizes_Tablet_Filesize_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Tablet_Filesize_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Tablet_Filesize_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Tablet_Filesize_Update>;
};

export type MediaDocAccessFields_Sizes_Tablet_Filesize_Create = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filesize_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filesize_Read = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Filesize_Update = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Height = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_height';
  create: Maybe<MediaDocAccessFields_Sizes_Tablet_Height_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Tablet_Height_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Tablet_Height_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Tablet_Height_Update>;
};

export type MediaDocAccessFields_Sizes_Tablet_Height_Create = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Height_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Height_Read = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Height_Update = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_MimeType = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_mimeType';
  create: Maybe<MediaDocAccessFields_Sizes_Tablet_MimeType_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Tablet_MimeType_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Tablet_MimeType_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Tablet_MimeType_Update>;
};

export type MediaDocAccessFields_Sizes_Tablet_MimeType_Create = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_MimeType_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_MimeType_Read = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_MimeType_Update = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Url = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_url';
  create: Maybe<MediaDocAccessFields_Sizes_Tablet_Url_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Tablet_Url_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Tablet_Url_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Tablet_Url_Update>;
};

export type MediaDocAccessFields_Sizes_Tablet_Url_Create = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Url_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Url_Read = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Url_Update = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Width = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_width';
  create: Maybe<MediaDocAccessFields_Sizes_Tablet_Width_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Tablet_Width_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Tablet_Width_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Tablet_Width_Update>;
};

export type MediaDocAccessFields_Sizes_Tablet_Width_Create = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Width_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Width_Read = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Tablet_Width_Update = {
  __typename?: 'MediaDocAccessFields_sizes_tablet_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail';
  create: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Delete>;
  fields: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Fields>;
  read: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Update>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_Create = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Fields = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_Fields';
  filename: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filename>;
  filesize: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filesize>;
  height: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Height>;
  mimeType: Maybe<MediaDocAccessFields_Sizes_Thumbnail_MimeType>;
  url: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Url>;
  width: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Width>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_Read = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Update = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filename = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filename';
  create: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filename_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filename_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filename_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filename_Update>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filename_Create = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filename_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filename_Read = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filename_Update = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filesize = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filesize';
  create: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filesize_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filesize_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filesize_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Filesize_Update>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filesize_Create = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filesize_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filesize_Read = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Filesize_Update = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Height = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_height';
  create: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Height_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Height_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Height_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Height_Update>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_Height_Create = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Height_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Height_Read = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Height_Update = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_MimeType = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_mimeType';
  create: Maybe<MediaDocAccessFields_Sizes_Thumbnail_MimeType_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Thumbnail_MimeType_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Thumbnail_MimeType_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Thumbnail_MimeType_Update>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_MimeType_Create = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_MimeType_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_MimeType_Read = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_MimeType_Update = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Url = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_url';
  create: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Url_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Url_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Url_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Url_Update>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_Url_Create = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Url_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Url_Read = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Url_Update = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Width = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_width';
  create: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Width_Create>;
  delete: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Width_Delete>;
  read: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Width_Read>;
  update: Maybe<MediaDocAccessFields_Sizes_Thumbnail_Width_Update>;
};

export type MediaDocAccessFields_Sizes_Thumbnail_Width_Create = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Width_Delete = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Width_Read = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Sizes_Thumbnail_Width_Update = {
  __typename?: 'MediaDocAccessFields_sizes_thumbnail_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_ThumbnailUrl = {
  __typename?: 'MediaDocAccessFields_thumbnailURL';
  create: Maybe<MediaDocAccessFields_ThumbnailUrl_Create>;
  delete: Maybe<MediaDocAccessFields_ThumbnailUrl_Delete>;
  read: Maybe<MediaDocAccessFields_ThumbnailUrl_Read>;
  update: Maybe<MediaDocAccessFields_ThumbnailUrl_Update>;
};

export type MediaDocAccessFields_ThumbnailUrl_Create = {
  __typename?: 'MediaDocAccessFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_ThumbnailUrl_Delete = {
  __typename?: 'MediaDocAccessFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_ThumbnailUrl_Read = {
  __typename?: 'MediaDocAccessFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_ThumbnailUrl_Update = {
  __typename?: 'MediaDocAccessFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_UpdatedAt = {
  __typename?: 'MediaDocAccessFields_updatedAt';
  create: Maybe<MediaDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<MediaDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<MediaDocAccessFields_UpdatedAt_Read>;
  update: Maybe<MediaDocAccessFields_UpdatedAt_Update>;
};

export type MediaDocAccessFields_UpdatedAt_Create = {
  __typename?: 'MediaDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'MediaDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_UpdatedAt_Read = {
  __typename?: 'MediaDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_UpdatedAt_Update = {
  __typename?: 'MediaDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Url = {
  __typename?: 'MediaDocAccessFields_url';
  create: Maybe<MediaDocAccessFields_Url_Create>;
  delete: Maybe<MediaDocAccessFields_Url_Delete>;
  read: Maybe<MediaDocAccessFields_Url_Read>;
  update: Maybe<MediaDocAccessFields_Url_Update>;
};

export type MediaDocAccessFields_Url_Create = {
  __typename?: 'MediaDocAccessFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Url_Delete = {
  __typename?: 'MediaDocAccessFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Url_Read = {
  __typename?: 'MediaDocAccessFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Url_Update = {
  __typename?: 'MediaDocAccessFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Width = {
  __typename?: 'MediaDocAccessFields_width';
  create: Maybe<MediaDocAccessFields_Width_Create>;
  delete: Maybe<MediaDocAccessFields_Width_Delete>;
  read: Maybe<MediaDocAccessFields_Width_Read>;
  update: Maybe<MediaDocAccessFields_Width_Update>;
};

export type MediaDocAccessFields_Width_Create = {
  __typename?: 'MediaDocAccessFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Width_Delete = {
  __typename?: 'MediaDocAccessFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Width_Read = {
  __typename?: 'MediaDocAccessFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaDocAccessFields_Width_Update = {
  __typename?: 'MediaDocAccessFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields = {
  __typename?: 'MediaFields';
  alt: Maybe<MediaFields_Alt>;
  createdAt: Maybe<MediaFields_CreatedAt>;
  filename: Maybe<MediaFields_Filename>;
  filesize: Maybe<MediaFields_Filesize>;
  focalX: Maybe<MediaFields_FocalX>;
  focalY: Maybe<MediaFields_FocalY>;
  height: Maybe<MediaFields_Height>;
  mimeType: Maybe<MediaFields_MimeType>;
  sizes: Maybe<MediaFields_Sizes>;
  thumbnailURL: Maybe<MediaFields_ThumbnailUrl>;
  updatedAt: Maybe<MediaFields_UpdatedAt>;
  url: Maybe<MediaFields_Url>;
  width: Maybe<MediaFields_Width>;
};

export type MediaFields_Alt = {
  __typename?: 'MediaFields_alt';
  create: Maybe<MediaFields_Alt_Create>;
  delete: Maybe<MediaFields_Alt_Delete>;
  read: Maybe<MediaFields_Alt_Read>;
  update: Maybe<MediaFields_Alt_Update>;
};

export type MediaFields_Alt_Create = {
  __typename?: 'MediaFields_alt_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Alt_Delete = {
  __typename?: 'MediaFields_alt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Alt_Read = {
  __typename?: 'MediaFields_alt_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Alt_Update = {
  __typename?: 'MediaFields_alt_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_CreatedAt = {
  __typename?: 'MediaFields_createdAt';
  create: Maybe<MediaFields_CreatedAt_Create>;
  delete: Maybe<MediaFields_CreatedAt_Delete>;
  read: Maybe<MediaFields_CreatedAt_Read>;
  update: Maybe<MediaFields_CreatedAt_Update>;
};

export type MediaFields_CreatedAt_Create = {
  __typename?: 'MediaFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_CreatedAt_Delete = {
  __typename?: 'MediaFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_CreatedAt_Read = {
  __typename?: 'MediaFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_CreatedAt_Update = {
  __typename?: 'MediaFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filename = {
  __typename?: 'MediaFields_filename';
  create: Maybe<MediaFields_Filename_Create>;
  delete: Maybe<MediaFields_Filename_Delete>;
  read: Maybe<MediaFields_Filename_Read>;
  update: Maybe<MediaFields_Filename_Update>;
};

export type MediaFields_Filename_Create = {
  __typename?: 'MediaFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filename_Delete = {
  __typename?: 'MediaFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filename_Read = {
  __typename?: 'MediaFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filename_Update = {
  __typename?: 'MediaFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filesize = {
  __typename?: 'MediaFields_filesize';
  create: Maybe<MediaFields_Filesize_Create>;
  delete: Maybe<MediaFields_Filesize_Delete>;
  read: Maybe<MediaFields_Filesize_Read>;
  update: Maybe<MediaFields_Filesize_Update>;
};

export type MediaFields_Filesize_Create = {
  __typename?: 'MediaFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filesize_Delete = {
  __typename?: 'MediaFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filesize_Read = {
  __typename?: 'MediaFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Filesize_Update = {
  __typename?: 'MediaFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalX = {
  __typename?: 'MediaFields_focalX';
  create: Maybe<MediaFields_FocalX_Create>;
  delete: Maybe<MediaFields_FocalX_Delete>;
  read: Maybe<MediaFields_FocalX_Read>;
  update: Maybe<MediaFields_FocalX_Update>;
};

export type MediaFields_FocalX_Create = {
  __typename?: 'MediaFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalX_Delete = {
  __typename?: 'MediaFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalX_Read = {
  __typename?: 'MediaFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalX_Update = {
  __typename?: 'MediaFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalY = {
  __typename?: 'MediaFields_focalY';
  create: Maybe<MediaFields_FocalY_Create>;
  delete: Maybe<MediaFields_FocalY_Delete>;
  read: Maybe<MediaFields_FocalY_Read>;
  update: Maybe<MediaFields_FocalY_Update>;
};

export type MediaFields_FocalY_Create = {
  __typename?: 'MediaFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalY_Delete = {
  __typename?: 'MediaFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalY_Read = {
  __typename?: 'MediaFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_FocalY_Update = {
  __typename?: 'MediaFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Height = {
  __typename?: 'MediaFields_height';
  create: Maybe<MediaFields_Height_Create>;
  delete: Maybe<MediaFields_Height_Delete>;
  read: Maybe<MediaFields_Height_Read>;
  update: Maybe<MediaFields_Height_Update>;
};

export type MediaFields_Height_Create = {
  __typename?: 'MediaFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Height_Delete = {
  __typename?: 'MediaFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Height_Read = {
  __typename?: 'MediaFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Height_Update = {
  __typename?: 'MediaFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_MimeType = {
  __typename?: 'MediaFields_mimeType';
  create: Maybe<MediaFields_MimeType_Create>;
  delete: Maybe<MediaFields_MimeType_Delete>;
  read: Maybe<MediaFields_MimeType_Read>;
  update: Maybe<MediaFields_MimeType_Update>;
};

export type MediaFields_MimeType_Create = {
  __typename?: 'MediaFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_MimeType_Delete = {
  __typename?: 'MediaFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_MimeType_Read = {
  __typename?: 'MediaFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_MimeType_Update = {
  __typename?: 'MediaFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes = {
  __typename?: 'MediaFields_sizes';
  create: Maybe<MediaFields_Sizes_Create>;
  delete: Maybe<MediaFields_Sizes_Delete>;
  fields: Maybe<MediaFields_Sizes_Fields>;
  read: Maybe<MediaFields_Sizes_Read>;
  update: Maybe<MediaFields_Sizes_Update>;
};

export type MediaFields_Sizes_Create = {
  __typename?: 'MediaFields_sizes_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Delete = {
  __typename?: 'MediaFields_sizes_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Fields = {
  __typename?: 'MediaFields_sizes_Fields';
  card: Maybe<MediaFields_Sizes_Card>;
  tablet: Maybe<MediaFields_Sizes_Tablet>;
  thumbnail: Maybe<MediaFields_Sizes_Thumbnail>;
};

export type MediaFields_Sizes_Read = {
  __typename?: 'MediaFields_sizes_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Update = {
  __typename?: 'MediaFields_sizes_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card = {
  __typename?: 'MediaFields_sizes_card';
  create: Maybe<MediaFields_Sizes_Card_Create>;
  delete: Maybe<MediaFields_Sizes_Card_Delete>;
  fields: Maybe<MediaFields_Sizes_Card_Fields>;
  read: Maybe<MediaFields_Sizes_Card_Read>;
  update: Maybe<MediaFields_Sizes_Card_Update>;
};

export type MediaFields_Sizes_Card_Create = {
  __typename?: 'MediaFields_sizes_card_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Delete = {
  __typename?: 'MediaFields_sizes_card_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Fields = {
  __typename?: 'MediaFields_sizes_card_Fields';
  filename: Maybe<MediaFields_Sizes_Card_Filename>;
  filesize: Maybe<MediaFields_Sizes_Card_Filesize>;
  height: Maybe<MediaFields_Sizes_Card_Height>;
  mimeType: Maybe<MediaFields_Sizes_Card_MimeType>;
  url: Maybe<MediaFields_Sizes_Card_Url>;
  width: Maybe<MediaFields_Sizes_Card_Width>;
};

export type MediaFields_Sizes_Card_Read = {
  __typename?: 'MediaFields_sizes_card_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Update = {
  __typename?: 'MediaFields_sizes_card_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filename = {
  __typename?: 'MediaFields_sizes_card_filename';
  create: Maybe<MediaFields_Sizes_Card_Filename_Create>;
  delete: Maybe<MediaFields_Sizes_Card_Filename_Delete>;
  read: Maybe<MediaFields_Sizes_Card_Filename_Read>;
  update: Maybe<MediaFields_Sizes_Card_Filename_Update>;
};

export type MediaFields_Sizes_Card_Filename_Create = {
  __typename?: 'MediaFields_sizes_card_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filename_Delete = {
  __typename?: 'MediaFields_sizes_card_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filename_Read = {
  __typename?: 'MediaFields_sizes_card_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filename_Update = {
  __typename?: 'MediaFields_sizes_card_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filesize = {
  __typename?: 'MediaFields_sizes_card_filesize';
  create: Maybe<MediaFields_Sizes_Card_Filesize_Create>;
  delete: Maybe<MediaFields_Sizes_Card_Filesize_Delete>;
  read: Maybe<MediaFields_Sizes_Card_Filesize_Read>;
  update: Maybe<MediaFields_Sizes_Card_Filesize_Update>;
};

export type MediaFields_Sizes_Card_Filesize_Create = {
  __typename?: 'MediaFields_sizes_card_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filesize_Delete = {
  __typename?: 'MediaFields_sizes_card_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filesize_Read = {
  __typename?: 'MediaFields_sizes_card_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Filesize_Update = {
  __typename?: 'MediaFields_sizes_card_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Height = {
  __typename?: 'MediaFields_sizes_card_height';
  create: Maybe<MediaFields_Sizes_Card_Height_Create>;
  delete: Maybe<MediaFields_Sizes_Card_Height_Delete>;
  read: Maybe<MediaFields_Sizes_Card_Height_Read>;
  update: Maybe<MediaFields_Sizes_Card_Height_Update>;
};

export type MediaFields_Sizes_Card_Height_Create = {
  __typename?: 'MediaFields_sizes_card_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Height_Delete = {
  __typename?: 'MediaFields_sizes_card_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Height_Read = {
  __typename?: 'MediaFields_sizes_card_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Height_Update = {
  __typename?: 'MediaFields_sizes_card_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_MimeType = {
  __typename?: 'MediaFields_sizes_card_mimeType';
  create: Maybe<MediaFields_Sizes_Card_MimeType_Create>;
  delete: Maybe<MediaFields_Sizes_Card_MimeType_Delete>;
  read: Maybe<MediaFields_Sizes_Card_MimeType_Read>;
  update: Maybe<MediaFields_Sizes_Card_MimeType_Update>;
};

export type MediaFields_Sizes_Card_MimeType_Create = {
  __typename?: 'MediaFields_sizes_card_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_MimeType_Delete = {
  __typename?: 'MediaFields_sizes_card_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_MimeType_Read = {
  __typename?: 'MediaFields_sizes_card_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_MimeType_Update = {
  __typename?: 'MediaFields_sizes_card_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Url = {
  __typename?: 'MediaFields_sizes_card_url';
  create: Maybe<MediaFields_Sizes_Card_Url_Create>;
  delete: Maybe<MediaFields_Sizes_Card_Url_Delete>;
  read: Maybe<MediaFields_Sizes_Card_Url_Read>;
  update: Maybe<MediaFields_Sizes_Card_Url_Update>;
};

export type MediaFields_Sizes_Card_Url_Create = {
  __typename?: 'MediaFields_sizes_card_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Url_Delete = {
  __typename?: 'MediaFields_sizes_card_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Url_Read = {
  __typename?: 'MediaFields_sizes_card_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Url_Update = {
  __typename?: 'MediaFields_sizes_card_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Width = {
  __typename?: 'MediaFields_sizes_card_width';
  create: Maybe<MediaFields_Sizes_Card_Width_Create>;
  delete: Maybe<MediaFields_Sizes_Card_Width_Delete>;
  read: Maybe<MediaFields_Sizes_Card_Width_Read>;
  update: Maybe<MediaFields_Sizes_Card_Width_Update>;
};

export type MediaFields_Sizes_Card_Width_Create = {
  __typename?: 'MediaFields_sizes_card_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Width_Delete = {
  __typename?: 'MediaFields_sizes_card_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Width_Read = {
  __typename?: 'MediaFields_sizes_card_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Card_Width_Update = {
  __typename?: 'MediaFields_sizes_card_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet = {
  __typename?: 'MediaFields_sizes_tablet';
  create: Maybe<MediaFields_Sizes_Tablet_Create>;
  delete: Maybe<MediaFields_Sizes_Tablet_Delete>;
  fields: Maybe<MediaFields_Sizes_Tablet_Fields>;
  read: Maybe<MediaFields_Sizes_Tablet_Read>;
  update: Maybe<MediaFields_Sizes_Tablet_Update>;
};

export type MediaFields_Sizes_Tablet_Create = {
  __typename?: 'MediaFields_sizes_tablet_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Delete = {
  __typename?: 'MediaFields_sizes_tablet_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Fields = {
  __typename?: 'MediaFields_sizes_tablet_Fields';
  filename: Maybe<MediaFields_Sizes_Tablet_Filename>;
  filesize: Maybe<MediaFields_Sizes_Tablet_Filesize>;
  height: Maybe<MediaFields_Sizes_Tablet_Height>;
  mimeType: Maybe<MediaFields_Sizes_Tablet_MimeType>;
  url: Maybe<MediaFields_Sizes_Tablet_Url>;
  width: Maybe<MediaFields_Sizes_Tablet_Width>;
};

export type MediaFields_Sizes_Tablet_Read = {
  __typename?: 'MediaFields_sizes_tablet_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Update = {
  __typename?: 'MediaFields_sizes_tablet_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filename = {
  __typename?: 'MediaFields_sizes_tablet_filename';
  create: Maybe<MediaFields_Sizes_Tablet_Filename_Create>;
  delete: Maybe<MediaFields_Sizes_Tablet_Filename_Delete>;
  read: Maybe<MediaFields_Sizes_Tablet_Filename_Read>;
  update: Maybe<MediaFields_Sizes_Tablet_Filename_Update>;
};

export type MediaFields_Sizes_Tablet_Filename_Create = {
  __typename?: 'MediaFields_sizes_tablet_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filename_Delete = {
  __typename?: 'MediaFields_sizes_tablet_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filename_Read = {
  __typename?: 'MediaFields_sizes_tablet_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filename_Update = {
  __typename?: 'MediaFields_sizes_tablet_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filesize = {
  __typename?: 'MediaFields_sizes_tablet_filesize';
  create: Maybe<MediaFields_Sizes_Tablet_Filesize_Create>;
  delete: Maybe<MediaFields_Sizes_Tablet_Filesize_Delete>;
  read: Maybe<MediaFields_Sizes_Tablet_Filesize_Read>;
  update: Maybe<MediaFields_Sizes_Tablet_Filesize_Update>;
};

export type MediaFields_Sizes_Tablet_Filesize_Create = {
  __typename?: 'MediaFields_sizes_tablet_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filesize_Delete = {
  __typename?: 'MediaFields_sizes_tablet_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filesize_Read = {
  __typename?: 'MediaFields_sizes_tablet_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Filesize_Update = {
  __typename?: 'MediaFields_sizes_tablet_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Height = {
  __typename?: 'MediaFields_sizes_tablet_height';
  create: Maybe<MediaFields_Sizes_Tablet_Height_Create>;
  delete: Maybe<MediaFields_Sizes_Tablet_Height_Delete>;
  read: Maybe<MediaFields_Sizes_Tablet_Height_Read>;
  update: Maybe<MediaFields_Sizes_Tablet_Height_Update>;
};

export type MediaFields_Sizes_Tablet_Height_Create = {
  __typename?: 'MediaFields_sizes_tablet_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Height_Delete = {
  __typename?: 'MediaFields_sizes_tablet_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Height_Read = {
  __typename?: 'MediaFields_sizes_tablet_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Height_Update = {
  __typename?: 'MediaFields_sizes_tablet_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_MimeType = {
  __typename?: 'MediaFields_sizes_tablet_mimeType';
  create: Maybe<MediaFields_Sizes_Tablet_MimeType_Create>;
  delete: Maybe<MediaFields_Sizes_Tablet_MimeType_Delete>;
  read: Maybe<MediaFields_Sizes_Tablet_MimeType_Read>;
  update: Maybe<MediaFields_Sizes_Tablet_MimeType_Update>;
};

export type MediaFields_Sizes_Tablet_MimeType_Create = {
  __typename?: 'MediaFields_sizes_tablet_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_MimeType_Delete = {
  __typename?: 'MediaFields_sizes_tablet_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_MimeType_Read = {
  __typename?: 'MediaFields_sizes_tablet_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_MimeType_Update = {
  __typename?: 'MediaFields_sizes_tablet_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Url = {
  __typename?: 'MediaFields_sizes_tablet_url';
  create: Maybe<MediaFields_Sizes_Tablet_Url_Create>;
  delete: Maybe<MediaFields_Sizes_Tablet_Url_Delete>;
  read: Maybe<MediaFields_Sizes_Tablet_Url_Read>;
  update: Maybe<MediaFields_Sizes_Tablet_Url_Update>;
};

export type MediaFields_Sizes_Tablet_Url_Create = {
  __typename?: 'MediaFields_sizes_tablet_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Url_Delete = {
  __typename?: 'MediaFields_sizes_tablet_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Url_Read = {
  __typename?: 'MediaFields_sizes_tablet_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Url_Update = {
  __typename?: 'MediaFields_sizes_tablet_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Width = {
  __typename?: 'MediaFields_sizes_tablet_width';
  create: Maybe<MediaFields_Sizes_Tablet_Width_Create>;
  delete: Maybe<MediaFields_Sizes_Tablet_Width_Delete>;
  read: Maybe<MediaFields_Sizes_Tablet_Width_Read>;
  update: Maybe<MediaFields_Sizes_Tablet_Width_Update>;
};

export type MediaFields_Sizes_Tablet_Width_Create = {
  __typename?: 'MediaFields_sizes_tablet_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Width_Delete = {
  __typename?: 'MediaFields_sizes_tablet_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Width_Read = {
  __typename?: 'MediaFields_sizes_tablet_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Tablet_Width_Update = {
  __typename?: 'MediaFields_sizes_tablet_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail = {
  __typename?: 'MediaFields_sizes_thumbnail';
  create: Maybe<MediaFields_Sizes_Thumbnail_Create>;
  delete: Maybe<MediaFields_Sizes_Thumbnail_Delete>;
  fields: Maybe<MediaFields_Sizes_Thumbnail_Fields>;
  read: Maybe<MediaFields_Sizes_Thumbnail_Read>;
  update: Maybe<MediaFields_Sizes_Thumbnail_Update>;
};

export type MediaFields_Sizes_Thumbnail_Create = {
  __typename?: 'MediaFields_sizes_thumbnail_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Delete = {
  __typename?: 'MediaFields_sizes_thumbnail_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Fields = {
  __typename?: 'MediaFields_sizes_thumbnail_Fields';
  filename: Maybe<MediaFields_Sizes_Thumbnail_Filename>;
  filesize: Maybe<MediaFields_Sizes_Thumbnail_Filesize>;
  height: Maybe<MediaFields_Sizes_Thumbnail_Height>;
  mimeType: Maybe<MediaFields_Sizes_Thumbnail_MimeType>;
  url: Maybe<MediaFields_Sizes_Thumbnail_Url>;
  width: Maybe<MediaFields_Sizes_Thumbnail_Width>;
};

export type MediaFields_Sizes_Thumbnail_Read = {
  __typename?: 'MediaFields_sizes_thumbnail_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Update = {
  __typename?: 'MediaFields_sizes_thumbnail_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filename = {
  __typename?: 'MediaFields_sizes_thumbnail_filename';
  create: Maybe<MediaFields_Sizes_Thumbnail_Filename_Create>;
  delete: Maybe<MediaFields_Sizes_Thumbnail_Filename_Delete>;
  read: Maybe<MediaFields_Sizes_Thumbnail_Filename_Read>;
  update: Maybe<MediaFields_Sizes_Thumbnail_Filename_Update>;
};

export type MediaFields_Sizes_Thumbnail_Filename_Create = {
  __typename?: 'MediaFields_sizes_thumbnail_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filename_Delete = {
  __typename?: 'MediaFields_sizes_thumbnail_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filename_Read = {
  __typename?: 'MediaFields_sizes_thumbnail_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filename_Update = {
  __typename?: 'MediaFields_sizes_thumbnail_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filesize = {
  __typename?: 'MediaFields_sizes_thumbnail_filesize';
  create: Maybe<MediaFields_Sizes_Thumbnail_Filesize_Create>;
  delete: Maybe<MediaFields_Sizes_Thumbnail_Filesize_Delete>;
  read: Maybe<MediaFields_Sizes_Thumbnail_Filesize_Read>;
  update: Maybe<MediaFields_Sizes_Thumbnail_Filesize_Update>;
};

export type MediaFields_Sizes_Thumbnail_Filesize_Create = {
  __typename?: 'MediaFields_sizes_thumbnail_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filesize_Delete = {
  __typename?: 'MediaFields_sizes_thumbnail_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filesize_Read = {
  __typename?: 'MediaFields_sizes_thumbnail_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Filesize_Update = {
  __typename?: 'MediaFields_sizes_thumbnail_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Height = {
  __typename?: 'MediaFields_sizes_thumbnail_height';
  create: Maybe<MediaFields_Sizes_Thumbnail_Height_Create>;
  delete: Maybe<MediaFields_Sizes_Thumbnail_Height_Delete>;
  read: Maybe<MediaFields_Sizes_Thumbnail_Height_Read>;
  update: Maybe<MediaFields_Sizes_Thumbnail_Height_Update>;
};

export type MediaFields_Sizes_Thumbnail_Height_Create = {
  __typename?: 'MediaFields_sizes_thumbnail_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Height_Delete = {
  __typename?: 'MediaFields_sizes_thumbnail_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Height_Read = {
  __typename?: 'MediaFields_sizes_thumbnail_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Height_Update = {
  __typename?: 'MediaFields_sizes_thumbnail_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_MimeType = {
  __typename?: 'MediaFields_sizes_thumbnail_mimeType';
  create: Maybe<MediaFields_Sizes_Thumbnail_MimeType_Create>;
  delete: Maybe<MediaFields_Sizes_Thumbnail_MimeType_Delete>;
  read: Maybe<MediaFields_Sizes_Thumbnail_MimeType_Read>;
  update: Maybe<MediaFields_Sizes_Thumbnail_MimeType_Update>;
};

export type MediaFields_Sizes_Thumbnail_MimeType_Create = {
  __typename?: 'MediaFields_sizes_thumbnail_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_MimeType_Delete = {
  __typename?: 'MediaFields_sizes_thumbnail_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_MimeType_Read = {
  __typename?: 'MediaFields_sizes_thumbnail_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_MimeType_Update = {
  __typename?: 'MediaFields_sizes_thumbnail_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Url = {
  __typename?: 'MediaFields_sizes_thumbnail_url';
  create: Maybe<MediaFields_Sizes_Thumbnail_Url_Create>;
  delete: Maybe<MediaFields_Sizes_Thumbnail_Url_Delete>;
  read: Maybe<MediaFields_Sizes_Thumbnail_Url_Read>;
  update: Maybe<MediaFields_Sizes_Thumbnail_Url_Update>;
};

export type MediaFields_Sizes_Thumbnail_Url_Create = {
  __typename?: 'MediaFields_sizes_thumbnail_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Url_Delete = {
  __typename?: 'MediaFields_sizes_thumbnail_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Url_Read = {
  __typename?: 'MediaFields_sizes_thumbnail_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Url_Update = {
  __typename?: 'MediaFields_sizes_thumbnail_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Width = {
  __typename?: 'MediaFields_sizes_thumbnail_width';
  create: Maybe<MediaFields_Sizes_Thumbnail_Width_Create>;
  delete: Maybe<MediaFields_Sizes_Thumbnail_Width_Delete>;
  read: Maybe<MediaFields_Sizes_Thumbnail_Width_Read>;
  update: Maybe<MediaFields_Sizes_Thumbnail_Width_Update>;
};

export type MediaFields_Sizes_Thumbnail_Width_Create = {
  __typename?: 'MediaFields_sizes_thumbnail_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Width_Delete = {
  __typename?: 'MediaFields_sizes_thumbnail_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Width_Read = {
  __typename?: 'MediaFields_sizes_thumbnail_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Sizes_Thumbnail_Width_Update = {
  __typename?: 'MediaFields_sizes_thumbnail_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_ThumbnailUrl = {
  __typename?: 'MediaFields_thumbnailURL';
  create: Maybe<MediaFields_ThumbnailUrl_Create>;
  delete: Maybe<MediaFields_ThumbnailUrl_Delete>;
  read: Maybe<MediaFields_ThumbnailUrl_Read>;
  update: Maybe<MediaFields_ThumbnailUrl_Update>;
};

export type MediaFields_ThumbnailUrl_Create = {
  __typename?: 'MediaFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_ThumbnailUrl_Delete = {
  __typename?: 'MediaFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_ThumbnailUrl_Read = {
  __typename?: 'MediaFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_ThumbnailUrl_Update = {
  __typename?: 'MediaFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_UpdatedAt = {
  __typename?: 'MediaFields_updatedAt';
  create: Maybe<MediaFields_UpdatedAt_Create>;
  delete: Maybe<MediaFields_UpdatedAt_Delete>;
  read: Maybe<MediaFields_UpdatedAt_Read>;
  update: Maybe<MediaFields_UpdatedAt_Update>;
};

export type MediaFields_UpdatedAt_Create = {
  __typename?: 'MediaFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_UpdatedAt_Delete = {
  __typename?: 'MediaFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_UpdatedAt_Read = {
  __typename?: 'MediaFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_UpdatedAt_Update = {
  __typename?: 'MediaFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Url = {
  __typename?: 'MediaFields_url';
  create: Maybe<MediaFields_Url_Create>;
  delete: Maybe<MediaFields_Url_Delete>;
  read: Maybe<MediaFields_Url_Read>;
  update: Maybe<MediaFields_Url_Update>;
};

export type MediaFields_Url_Create = {
  __typename?: 'MediaFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Url_Delete = {
  __typename?: 'MediaFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Url_Read = {
  __typename?: 'MediaFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Url_Update = {
  __typename?: 'MediaFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Width = {
  __typename?: 'MediaFields_width';
  create: Maybe<MediaFields_Width_Create>;
  delete: Maybe<MediaFields_Width_Delete>;
  read: Maybe<MediaFields_Width_Read>;
  update: Maybe<MediaFields_Width_Update>;
};

export type MediaFields_Width_Create = {
  __typename?: 'MediaFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Width_Delete = {
  __typename?: 'MediaFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Width_Read = {
  __typename?: 'MediaFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type MediaFields_Width_Update = {
  __typename?: 'MediaFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type MediaReadAccess = {
  __typename?: 'MediaReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type MediaReadDocAccess = {
  __typename?: 'MediaReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type MediaUpdateAccess = {
  __typename?: 'MediaUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type MediaUpdateDocAccess = {
  __typename?: 'MediaUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Media_Sizes = {
  __typename?: 'Media_Sizes';
  card: Maybe<Media_Sizes_Card>;
  tablet: Maybe<Media_Sizes_Tablet>;
  thumbnail: Maybe<Media_Sizes_Thumbnail>;
};

export type Media_Sizes_Card = {
  __typename?: 'Media_Sizes_Card';
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  mimeType: Maybe<Scalars['String']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type Media_Sizes_Tablet = {
  __typename?: 'Media_Sizes_Tablet';
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  mimeType: Maybe<Scalars['String']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type Media_Sizes_Thumbnail = {
  __typename?: 'Media_Sizes_Thumbnail';
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  mimeType: Maybe<Scalars['String']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type Media_Alt_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Media_Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_FocalX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_FocalY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Media_MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Card__Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Card__Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Card__Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Card__MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Card__Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Card__Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Tablet__Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Tablet__Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Tablet__Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Tablet__MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Tablet__Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Tablet__Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Thumbnail__Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Thumbnail__Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Thumbnail__Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_Sizes__Thumbnail__MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Thumbnail__Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Sizes__Thumbnail__Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Media_ThumbnailUrl_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Media_Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Media_Where = {
  AND: InputMaybe<Array<InputMaybe<Media_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Media_Where_Or>>>;
  alt: InputMaybe<Media_Alt_Operator>;
  createdAt: InputMaybe<Media_CreatedAt_Operator>;
  filename: InputMaybe<Media_Filename_Operator>;
  filesize: InputMaybe<Media_Filesize_Operator>;
  focalX: InputMaybe<Media_FocalX_Operator>;
  focalY: InputMaybe<Media_FocalY_Operator>;
  height: InputMaybe<Media_Height_Operator>;
  id: InputMaybe<Media_Id_Operator>;
  mimeType: InputMaybe<Media_MimeType_Operator>;
  sizes__card__filename: InputMaybe<Media_Sizes__Card__Filename_Operator>;
  sizes__card__filesize: InputMaybe<Media_Sizes__Card__Filesize_Operator>;
  sizes__card__height: InputMaybe<Media_Sizes__Card__Height_Operator>;
  sizes__card__mimeType: InputMaybe<Media_Sizes__Card__MimeType_Operator>;
  sizes__card__url: InputMaybe<Media_Sizes__Card__Url_Operator>;
  sizes__card__width: InputMaybe<Media_Sizes__Card__Width_Operator>;
  sizes__tablet__filename: InputMaybe<Media_Sizes__Tablet__Filename_Operator>;
  sizes__tablet__filesize: InputMaybe<Media_Sizes__Tablet__Filesize_Operator>;
  sizes__tablet__height: InputMaybe<Media_Sizes__Tablet__Height_Operator>;
  sizes__tablet__mimeType: InputMaybe<Media_Sizes__Tablet__MimeType_Operator>;
  sizes__tablet__url: InputMaybe<Media_Sizes__Tablet__Url_Operator>;
  sizes__tablet__width: InputMaybe<Media_Sizes__Tablet__Width_Operator>;
  sizes__thumbnail__filename: InputMaybe<Media_Sizes__Thumbnail__Filename_Operator>;
  sizes__thumbnail__filesize: InputMaybe<Media_Sizes__Thumbnail__Filesize_Operator>;
  sizes__thumbnail__height: InputMaybe<Media_Sizes__Thumbnail__Height_Operator>;
  sizes__thumbnail__mimeType: InputMaybe<Media_Sizes__Thumbnail__MimeType_Operator>;
  sizes__thumbnail__url: InputMaybe<Media_Sizes__Thumbnail__Url_Operator>;
  sizes__thumbnail__width: InputMaybe<Media_Sizes__Thumbnail__Width_Operator>;
  thumbnailURL: InputMaybe<Media_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<Media_UpdatedAt_Operator>;
  url: InputMaybe<Media_Url_Operator>;
  width: InputMaybe<Media_Width_Operator>;
};

export type Media_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Media_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Media_Where_Or>>>;
  alt: InputMaybe<Media_Alt_Operator>;
  createdAt: InputMaybe<Media_CreatedAt_Operator>;
  filename: InputMaybe<Media_Filename_Operator>;
  filesize: InputMaybe<Media_Filesize_Operator>;
  focalX: InputMaybe<Media_FocalX_Operator>;
  focalY: InputMaybe<Media_FocalY_Operator>;
  height: InputMaybe<Media_Height_Operator>;
  id: InputMaybe<Media_Id_Operator>;
  mimeType: InputMaybe<Media_MimeType_Operator>;
  sizes__card__filename: InputMaybe<Media_Sizes__Card__Filename_Operator>;
  sizes__card__filesize: InputMaybe<Media_Sizes__Card__Filesize_Operator>;
  sizes__card__height: InputMaybe<Media_Sizes__Card__Height_Operator>;
  sizes__card__mimeType: InputMaybe<Media_Sizes__Card__MimeType_Operator>;
  sizes__card__url: InputMaybe<Media_Sizes__Card__Url_Operator>;
  sizes__card__width: InputMaybe<Media_Sizes__Card__Width_Operator>;
  sizes__tablet__filename: InputMaybe<Media_Sizes__Tablet__Filename_Operator>;
  sizes__tablet__filesize: InputMaybe<Media_Sizes__Tablet__Filesize_Operator>;
  sizes__tablet__height: InputMaybe<Media_Sizes__Tablet__Height_Operator>;
  sizes__tablet__mimeType: InputMaybe<Media_Sizes__Tablet__MimeType_Operator>;
  sizes__tablet__url: InputMaybe<Media_Sizes__Tablet__Url_Operator>;
  sizes__tablet__width: InputMaybe<Media_Sizes__Tablet__Width_Operator>;
  sizes__thumbnail__filename: InputMaybe<Media_Sizes__Thumbnail__Filename_Operator>;
  sizes__thumbnail__filesize: InputMaybe<Media_Sizes__Thumbnail__Filesize_Operator>;
  sizes__thumbnail__height: InputMaybe<Media_Sizes__Thumbnail__Height_Operator>;
  sizes__thumbnail__mimeType: InputMaybe<Media_Sizes__Thumbnail__MimeType_Operator>;
  sizes__thumbnail__url: InputMaybe<Media_Sizes__Thumbnail__Url_Operator>;
  sizes__thumbnail__width: InputMaybe<Media_Sizes__Thumbnail__Width_Operator>;
  thumbnailURL: InputMaybe<Media_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<Media_UpdatedAt_Operator>;
  url: InputMaybe<Media_Url_Operator>;
  width: InputMaybe<Media_Width_Operator>;
};

export type Media_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Media_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Media_Where_Or>>>;
  alt: InputMaybe<Media_Alt_Operator>;
  createdAt: InputMaybe<Media_CreatedAt_Operator>;
  filename: InputMaybe<Media_Filename_Operator>;
  filesize: InputMaybe<Media_Filesize_Operator>;
  focalX: InputMaybe<Media_FocalX_Operator>;
  focalY: InputMaybe<Media_FocalY_Operator>;
  height: InputMaybe<Media_Height_Operator>;
  id: InputMaybe<Media_Id_Operator>;
  mimeType: InputMaybe<Media_MimeType_Operator>;
  sizes__card__filename: InputMaybe<Media_Sizes__Card__Filename_Operator>;
  sizes__card__filesize: InputMaybe<Media_Sizes__Card__Filesize_Operator>;
  sizes__card__height: InputMaybe<Media_Sizes__Card__Height_Operator>;
  sizes__card__mimeType: InputMaybe<Media_Sizes__Card__MimeType_Operator>;
  sizes__card__url: InputMaybe<Media_Sizes__Card__Url_Operator>;
  sizes__card__width: InputMaybe<Media_Sizes__Card__Width_Operator>;
  sizes__tablet__filename: InputMaybe<Media_Sizes__Tablet__Filename_Operator>;
  sizes__tablet__filesize: InputMaybe<Media_Sizes__Tablet__Filesize_Operator>;
  sizes__tablet__height: InputMaybe<Media_Sizes__Tablet__Height_Operator>;
  sizes__tablet__mimeType: InputMaybe<Media_Sizes__Tablet__MimeType_Operator>;
  sizes__tablet__url: InputMaybe<Media_Sizes__Tablet__Url_Operator>;
  sizes__tablet__width: InputMaybe<Media_Sizes__Tablet__Width_Operator>;
  sizes__thumbnail__filename: InputMaybe<Media_Sizes__Thumbnail__Filename_Operator>;
  sizes__thumbnail__filesize: InputMaybe<Media_Sizes__Thumbnail__Filesize_Operator>;
  sizes__thumbnail__height: InputMaybe<Media_Sizes__Thumbnail__Height_Operator>;
  sizes__thumbnail__mimeType: InputMaybe<Media_Sizes__Thumbnail__MimeType_Operator>;
  sizes__thumbnail__url: InputMaybe<Media_Sizes__Thumbnail__Url_Operator>;
  sizes__thumbnail__width: InputMaybe<Media_Sizes__Thumbnail__Width_Operator>;
  thumbnailURL: InputMaybe<Media_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<Media_UpdatedAt_Operator>;
  url: InputMaybe<Media_Url_Operator>;
  width: InputMaybe<Media_Width_Operator>;
};

export type Media_Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Mutation = {
  __typename?: 'Mutation';
  createBatch: Maybe<Batch>;
  createDocument: Maybe<Document>;
  createEgo: Maybe<Ego>;
  createEsminiDat: Maybe<EsminiDat>;
  createKeyPerformanceIndicator: Maybe<KeyPerformanceIndicator>;
  createMedia: Maybe<Media>;
  createObservation: Maybe<Observation>;
  createOpenDrive: Maybe<OpenDrive>;
  createOpenScenario: Maybe<OpenScenario>;
  createPayloadLockedDocument: Maybe<PayloadLockedDocument>;
  createPayloadPreference: Maybe<PayloadPreference>;
  createSampling: Maybe<Sampling>;
  createScenario: Maybe<Scenario>;
  createSession: Maybe<Session>;
  createTrial: Maybe<Trial>;
  createUser: Maybe<User>;
  deleteBatch: Maybe<Batch>;
  deleteDocument: Maybe<Document>;
  deleteEgo: Maybe<Ego>;
  deleteEsminiDat: Maybe<EsminiDat>;
  deleteKeyPerformanceIndicator: Maybe<KeyPerformanceIndicator>;
  deleteMedia: Maybe<Media>;
  deleteObservation: Maybe<Observation>;
  deleteOpenDrive: Maybe<OpenDrive>;
  deleteOpenScenario: Maybe<OpenScenario>;
  deletePayloadLockedDocument: Maybe<PayloadLockedDocument>;
  deletePayloadPreference: Maybe<PayloadPreference>;
  deleteSampling: Maybe<Sampling>;
  deleteScenario: Maybe<Scenario>;
  deleteSession: Maybe<Session>;
  deleteTrial: Maybe<Trial>;
  deleteUser: Maybe<User>;
  duplicateBatch: Maybe<Batch>;
  duplicateDocument: Maybe<Document>;
  duplicateEgo: Maybe<Ego>;
  duplicateEsminiDat: Maybe<EsminiDat>;
  duplicateKeyPerformanceIndicator: Maybe<KeyPerformanceIndicator>;
  duplicateMedia: Maybe<Media>;
  duplicateObservation: Maybe<Observation>;
  duplicateOpenDrive: Maybe<OpenDrive>;
  duplicateOpenScenario: Maybe<OpenScenario>;
  duplicatePayloadLockedDocument: Maybe<PayloadLockedDocument>;
  duplicatePayloadPreference: Maybe<PayloadPreference>;
  duplicateSampling: Maybe<Sampling>;
  duplicateScenario: Maybe<Scenario>;
  duplicateSession: Maybe<Session>;
  duplicateTrial: Maybe<Trial>;
  forgotPasswordUser: Scalars['Boolean']['output'];
  loginUser: Maybe<UsersLoginResult>;
  logoutUser: Maybe<Scalars['String']['output']>;
  refreshTokenUser: Maybe<UsersRefreshedUser>;
  resetPasswordUser: Maybe<UsersResetPassword>;
  restoreVersionSampling: Maybe<Sampling>;
  restoreVersionScenario: Maybe<Scenario>;
  restoreVersionSession: Maybe<Session>;
  unlockUser: Scalars['Boolean']['output'];
  updateBatch: Maybe<Batch>;
  updateDocument: Maybe<Document>;
  updateEgo: Maybe<Ego>;
  updateEsminiDat: Maybe<EsminiDat>;
  updateKeyPerformanceIndicator: Maybe<KeyPerformanceIndicator>;
  updateMedia: Maybe<Media>;
  updateObservation: Maybe<Observation>;
  updateOpenDrive: Maybe<OpenDrive>;
  updateOpenScenario: Maybe<OpenScenario>;
  updatePayloadLockedDocument: Maybe<PayloadLockedDocument>;
  updatePayloadPreference: Maybe<PayloadPreference>;
  updateSampling: Maybe<Sampling>;
  updateScenario: Maybe<Scenario>;
  updateSession: Maybe<Session>;
  updateTrial: Maybe<Trial>;
  updateUser: Maybe<User>;
  verifyEmailUser: Maybe<Scalars['Boolean']['output']>;
};


export type MutationCreateBatchArgs = {
  data: MutationBatchInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateDocumentArgs = {
  data: MutationDocumentInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateEgoArgs = {
  data: MutationEgoInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateEsminiDatArgs = {
  data: MutationEsminiDatInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateKeyPerformanceIndicatorArgs = {
  data: MutationKeyPerformanceIndicatorInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateMediaArgs = {
  data: MutationMediaInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateObservationArgs = {
  data: MutationObservationInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateOpenDriveArgs = {
  data: MutationOpenDriveInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateOpenScenarioArgs = {
  data: MutationOpenScenarioInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreatePayloadLockedDocumentArgs = {
  data: MutationPayloadLockedDocumentInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreatePayloadPreferenceArgs = {
  data: MutationPayloadPreferenceInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateSamplingArgs = {
  data: MutationSamplingInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateScenarioArgs = {
  data: MutationScenarioInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateSessionArgs = {
  data: MutationSessionInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateTrialArgs = {
  data: MutationTrialInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationCreateUserArgs = {
  data: MutationUserInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteBatchArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteDocumentArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteEgoArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteEsminiDatArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteKeyPerformanceIndicatorArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteMediaArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteObservationArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteOpenDriveArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteOpenScenarioArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeletePayloadLockedDocumentArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeletePayloadPreferenceArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteSamplingArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteScenarioArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteSessionArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteTrialArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDeleteUserArgs = {
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationDuplicateBatchArgs = {
  data: MutationBatchInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateDocumentArgs = {
  data: MutationDocumentInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateEgoArgs = {
  data: MutationEgoInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateEsminiDatArgs = {
  data: MutationEsminiDatInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateKeyPerformanceIndicatorArgs = {
  data: MutationKeyPerformanceIndicatorInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateMediaArgs = {
  data: MutationMediaInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateObservationArgs = {
  data: MutationObservationInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateOpenDriveArgs = {
  data: MutationOpenDriveInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateOpenScenarioArgs = {
  data: MutationOpenScenarioInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicatePayloadLockedDocumentArgs = {
  data: MutationPayloadLockedDocumentInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicatePayloadPreferenceArgs = {
  data: MutationPayloadPreferenceInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateSamplingArgs = {
  data: MutationSamplingInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateScenarioArgs = {
  data: MutationScenarioInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateSessionArgs = {
  data: MutationSessionInput;
  id: Scalars['Int']['input'];
};


export type MutationDuplicateTrialArgs = {
  data: MutationTrialInput;
  id: Scalars['Int']['input'];
};


export type MutationForgotPasswordUserArgs = {
  disableEmail: InputMaybe<Scalars['Boolean']['input']>;
  email: Scalars['String']['input'];
  expiration: InputMaybe<Scalars['Int']['input']>;
};


export type MutationLoginUserArgs = {
  email: Scalars['String']['input'];
  password: InputMaybe<Scalars['String']['input']>;
};


export type MutationLogoutUserArgs = {
  allSessions: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationResetPasswordUserArgs = {
  password: InputMaybe<Scalars['String']['input']>;
  token: InputMaybe<Scalars['String']['input']>;
};


export type MutationRestoreVersionSamplingArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: InputMaybe<Scalars['Int']['input']>;
};


export type MutationRestoreVersionScenarioArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: InputMaybe<Scalars['Int']['input']>;
};


export type MutationRestoreVersionSessionArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: InputMaybe<Scalars['Int']['input']>;
};


export type MutationUnlockUserArgs = {
  email: Scalars['String']['input'];
};


export type MutationUpdateBatchArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationBatchUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateDocumentArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationDocumentUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateEgoArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationEgoUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateEsminiDatArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationEsminiDatUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateKeyPerformanceIndicatorArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationKeyPerformanceIndicatorUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateMediaArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationMediaUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateObservationArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationObservationUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateOpenDriveArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationOpenDriveUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateOpenScenarioArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationOpenScenarioUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdatePayloadLockedDocumentArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationPayloadLockedDocumentUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdatePayloadPreferenceArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationPayloadPreferenceUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateSamplingArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationSamplingUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateScenarioArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationScenarioUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateSessionArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationSessionUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateTrialArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationTrialUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationUpdateUserArgs = {
  autosave: InputMaybe<Scalars['Boolean']['input']>;
  data: MutationUserUpdateInput;
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type MutationVerifyEmailUserArgs = {
  token: InputMaybe<Scalars['String']['input']>;
};

export type Observation = {
  __typename?: 'Observation';
  agents: Maybe<Array<Observation_Agents>>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  ego: Ego;
  egoAcceleration: Maybe<Scalars['Float']['output']>;
  egoCurvature: Maybe<Scalars['Float']['output']>;
  egoJunctionId: Maybe<Scalars['Float']['output']>;
  egoLaneHeading: Maybe<Scalars['Float']['output']>;
  egoLaneId: Maybe<Scalars['Float']['output']>;
  egoLaneOffset: Maybe<Scalars['Float']['output']>;
  egoRoadId: Maybe<Scalars['Float']['output']>;
  egoS: Maybe<Scalars['Float']['output']>;
  egoSpeed: Maybe<Scalars['Float']['output']>;
  egoSpeedCmd: Maybe<Scalars['Float']['output']>;
  egoSteerCmd: Maybe<Scalars['Float']['output']>;
  egoT: Maybe<Scalars['Float']['output']>;
  egoX: Maybe<Scalars['Float']['output']>;
  egoY: Maybe<Scalars['Float']['output']>;
  egoYaw: Maybe<Scalars['Float']['output']>;
  egoYawRate: Maybe<Scalars['Float']['output']>;
  esminiSeconds: Maybe<Scalars['Float']['output']>;
  id: Scalars['Int']['output'];
  time: Maybe<Scalars['Float']['output']>;
  trial: Maybe<Trial>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export type Observation_Agents = {
  __typename?: 'Observation_Agents';
  accReq: Maybe<Scalars['Float']['output']>;
  acceleration: Maybe<Scalars['Float']['output']>;
  collisionRisk: Maybe<Scalars['Float']['output']>;
  curvature: Maybe<Scalars['Float']['output']>;
  dce: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  id: Maybe<Scalars['String']['output']>;
  isRssSafe: Maybe<Scalars['Float']['output']>;
  junctionId: Maybe<Scalars['Float']['output']>;
  laneHeading: Maybe<Scalars['Float']['output']>;
  laneId: Maybe<Scalars['Float']['output']>;
  laneOffset: Maybe<Scalars['Float']['output']>;
  length: Maybe<Scalars['Float']['output']>;
  localX: Maybe<Scalars['Float']['output']>;
  localY: Maybe<Scalars['Float']['output']>;
  localYaw: Maybe<Scalars['Float']['output']>;
  name: Maybe<Scalars['String']['output']>;
  pret: Maybe<Scalars['Float']['output']>;
  relativeAccelerationX: Maybe<Scalars['Float']['output']>;
  relativeAccelerationY: Maybe<Scalars['Float']['output']>;
  relativeDistance: Maybe<Scalars['Float']['output']>;
  relativeVelocityX: Maybe<Scalars['Float']['output']>;
  relativeVelocityY: Maybe<Scalars['Float']['output']>;
  relativeYawRate: Maybe<Scalars['Float']['output']>;
  roadId: Maybe<Scalars['Float']['output']>;
  rssRatio: Maybe<Scalars['Float']['output']>;
  s: Maybe<Scalars['Float']['output']>;
  speed: Maybe<Scalars['Float']['output']>;
  spret: Maybe<Scalars['Float']['output']>;
  t: Maybe<Scalars['Float']['output']>;
  ttc: Maybe<Scalars['Float']['output']>;
  ttce: Maybe<Scalars['Float']['output']>;
  width: Maybe<Scalars['Float']['output']>;
  x: Maybe<Scalars['Float']['output']>;
  y: Maybe<Scalars['Float']['output']>;
  yaw: Maybe<Scalars['Float']['output']>;
  yawRate: Maybe<Scalars['Float']['output']>;
};

export type Observation_Agents__AccReq_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Acceleration_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__CollisionRisk_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Curvature_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Dce_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Observation_Agents__IsRssSafe_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__JunctionId_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__LaneHeading_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__LaneId_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__LaneOffset_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Length_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__LocalX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__LocalY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__LocalYaw_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Observation_Agents__Pret_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RelativeAccelerationX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RelativeAccelerationY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RelativeDistance_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RelativeVelocityX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RelativeVelocityY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RelativeYawRate_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RoadId_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__RssRatio_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__S_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Speed_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Spret_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__T_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Ttc_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Ttce_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__X_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Y_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__YawRate_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Agents__Yaw_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Observation_EgoAcceleration_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoCurvature_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoJunctionId_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoLaneHeading_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoLaneId_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoLaneOffset_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoRoadId_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoS_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoSpeedCmd_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoSpeed_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoSteerCmd_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoT_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoYawRate_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_EgoYaw_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Ego_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Observation_EsminiSeconds_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Observation_Time_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Observation_Trial_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Observation_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Observation_Where = {
  AND: InputMaybe<Array<InputMaybe<Observation_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Observation_Where_Or>>>;
  agents__accReq: InputMaybe<Observation_Agents__AccReq_Operator>;
  agents__acceleration: InputMaybe<Observation_Agents__Acceleration_Operator>;
  agents__collisionRisk: InputMaybe<Observation_Agents__CollisionRisk_Operator>;
  agents__curvature: InputMaybe<Observation_Agents__Curvature_Operator>;
  agents__dce: InputMaybe<Observation_Agents__Dce_Operator>;
  agents__height: InputMaybe<Observation_Agents__Height_Operator>;
  agents__id: InputMaybe<Observation_Agents__Id_Operator>;
  agents__isRssSafe: InputMaybe<Observation_Agents__IsRssSafe_Operator>;
  agents__junctionId: InputMaybe<Observation_Agents__JunctionId_Operator>;
  agents__laneHeading: InputMaybe<Observation_Agents__LaneHeading_Operator>;
  agents__laneId: InputMaybe<Observation_Agents__LaneId_Operator>;
  agents__laneOffset: InputMaybe<Observation_Agents__LaneOffset_Operator>;
  agents__length: InputMaybe<Observation_Agents__Length_Operator>;
  agents__localX: InputMaybe<Observation_Agents__LocalX_Operator>;
  agents__localY: InputMaybe<Observation_Agents__LocalY_Operator>;
  agents__localYaw: InputMaybe<Observation_Agents__LocalYaw_Operator>;
  agents__name: InputMaybe<Observation_Agents__Name_Operator>;
  agents__pret: InputMaybe<Observation_Agents__Pret_Operator>;
  agents__relativeAccelerationX: InputMaybe<Observation_Agents__RelativeAccelerationX_Operator>;
  agents__relativeAccelerationY: InputMaybe<Observation_Agents__RelativeAccelerationY_Operator>;
  agents__relativeDistance: InputMaybe<Observation_Agents__RelativeDistance_Operator>;
  agents__relativeVelocityX: InputMaybe<Observation_Agents__RelativeVelocityX_Operator>;
  agents__relativeVelocityY: InputMaybe<Observation_Agents__RelativeVelocityY_Operator>;
  agents__relativeYawRate: InputMaybe<Observation_Agents__RelativeYawRate_Operator>;
  agents__roadId: InputMaybe<Observation_Agents__RoadId_Operator>;
  agents__rssRatio: InputMaybe<Observation_Agents__RssRatio_Operator>;
  agents__s: InputMaybe<Observation_Agents__S_Operator>;
  agents__speed: InputMaybe<Observation_Agents__Speed_Operator>;
  agents__spret: InputMaybe<Observation_Agents__Spret_Operator>;
  agents__t: InputMaybe<Observation_Agents__T_Operator>;
  agents__ttc: InputMaybe<Observation_Agents__Ttc_Operator>;
  agents__ttce: InputMaybe<Observation_Agents__Ttce_Operator>;
  agents__width: InputMaybe<Observation_Agents__Width_Operator>;
  agents__x: InputMaybe<Observation_Agents__X_Operator>;
  agents__y: InputMaybe<Observation_Agents__Y_Operator>;
  agents__yaw: InputMaybe<Observation_Agents__Yaw_Operator>;
  agents__yawRate: InputMaybe<Observation_Agents__YawRate_Operator>;
  createdAt: InputMaybe<Observation_CreatedAt_Operator>;
  ego: InputMaybe<Observation_Ego_Operator>;
  egoAcceleration: InputMaybe<Observation_EgoAcceleration_Operator>;
  egoCurvature: InputMaybe<Observation_EgoCurvature_Operator>;
  egoJunctionId: InputMaybe<Observation_EgoJunctionId_Operator>;
  egoLaneHeading: InputMaybe<Observation_EgoLaneHeading_Operator>;
  egoLaneId: InputMaybe<Observation_EgoLaneId_Operator>;
  egoLaneOffset: InputMaybe<Observation_EgoLaneOffset_Operator>;
  egoRoadId: InputMaybe<Observation_EgoRoadId_Operator>;
  egoS: InputMaybe<Observation_EgoS_Operator>;
  egoSpeed: InputMaybe<Observation_EgoSpeed_Operator>;
  egoSpeedCmd: InputMaybe<Observation_EgoSpeedCmd_Operator>;
  egoSteerCmd: InputMaybe<Observation_EgoSteerCmd_Operator>;
  egoT: InputMaybe<Observation_EgoT_Operator>;
  egoX: InputMaybe<Observation_EgoX_Operator>;
  egoY: InputMaybe<Observation_EgoY_Operator>;
  egoYaw: InputMaybe<Observation_EgoYaw_Operator>;
  egoYawRate: InputMaybe<Observation_EgoYawRate_Operator>;
  esminiSeconds: InputMaybe<Observation_EsminiSeconds_Operator>;
  id: InputMaybe<Observation_Id_Operator>;
  time: InputMaybe<Observation_Time_Operator>;
  trial: InputMaybe<Observation_Trial_Operator>;
  updatedAt: InputMaybe<Observation_UpdatedAt_Operator>;
};

export type Observation_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Observation_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Observation_Where_Or>>>;
  agents__accReq: InputMaybe<Observation_Agents__AccReq_Operator>;
  agents__acceleration: InputMaybe<Observation_Agents__Acceleration_Operator>;
  agents__collisionRisk: InputMaybe<Observation_Agents__CollisionRisk_Operator>;
  agents__curvature: InputMaybe<Observation_Agents__Curvature_Operator>;
  agents__dce: InputMaybe<Observation_Agents__Dce_Operator>;
  agents__height: InputMaybe<Observation_Agents__Height_Operator>;
  agents__id: InputMaybe<Observation_Agents__Id_Operator>;
  agents__isRssSafe: InputMaybe<Observation_Agents__IsRssSafe_Operator>;
  agents__junctionId: InputMaybe<Observation_Agents__JunctionId_Operator>;
  agents__laneHeading: InputMaybe<Observation_Agents__LaneHeading_Operator>;
  agents__laneId: InputMaybe<Observation_Agents__LaneId_Operator>;
  agents__laneOffset: InputMaybe<Observation_Agents__LaneOffset_Operator>;
  agents__length: InputMaybe<Observation_Agents__Length_Operator>;
  agents__localX: InputMaybe<Observation_Agents__LocalX_Operator>;
  agents__localY: InputMaybe<Observation_Agents__LocalY_Operator>;
  agents__localYaw: InputMaybe<Observation_Agents__LocalYaw_Operator>;
  agents__name: InputMaybe<Observation_Agents__Name_Operator>;
  agents__pret: InputMaybe<Observation_Agents__Pret_Operator>;
  agents__relativeAccelerationX: InputMaybe<Observation_Agents__RelativeAccelerationX_Operator>;
  agents__relativeAccelerationY: InputMaybe<Observation_Agents__RelativeAccelerationY_Operator>;
  agents__relativeDistance: InputMaybe<Observation_Agents__RelativeDistance_Operator>;
  agents__relativeVelocityX: InputMaybe<Observation_Agents__RelativeVelocityX_Operator>;
  agents__relativeVelocityY: InputMaybe<Observation_Agents__RelativeVelocityY_Operator>;
  agents__relativeYawRate: InputMaybe<Observation_Agents__RelativeYawRate_Operator>;
  agents__roadId: InputMaybe<Observation_Agents__RoadId_Operator>;
  agents__rssRatio: InputMaybe<Observation_Agents__RssRatio_Operator>;
  agents__s: InputMaybe<Observation_Agents__S_Operator>;
  agents__speed: InputMaybe<Observation_Agents__Speed_Operator>;
  agents__spret: InputMaybe<Observation_Agents__Spret_Operator>;
  agents__t: InputMaybe<Observation_Agents__T_Operator>;
  agents__ttc: InputMaybe<Observation_Agents__Ttc_Operator>;
  agents__ttce: InputMaybe<Observation_Agents__Ttce_Operator>;
  agents__width: InputMaybe<Observation_Agents__Width_Operator>;
  agents__x: InputMaybe<Observation_Agents__X_Operator>;
  agents__y: InputMaybe<Observation_Agents__Y_Operator>;
  agents__yaw: InputMaybe<Observation_Agents__Yaw_Operator>;
  agents__yawRate: InputMaybe<Observation_Agents__YawRate_Operator>;
  createdAt: InputMaybe<Observation_CreatedAt_Operator>;
  ego: InputMaybe<Observation_Ego_Operator>;
  egoAcceleration: InputMaybe<Observation_EgoAcceleration_Operator>;
  egoCurvature: InputMaybe<Observation_EgoCurvature_Operator>;
  egoJunctionId: InputMaybe<Observation_EgoJunctionId_Operator>;
  egoLaneHeading: InputMaybe<Observation_EgoLaneHeading_Operator>;
  egoLaneId: InputMaybe<Observation_EgoLaneId_Operator>;
  egoLaneOffset: InputMaybe<Observation_EgoLaneOffset_Operator>;
  egoRoadId: InputMaybe<Observation_EgoRoadId_Operator>;
  egoS: InputMaybe<Observation_EgoS_Operator>;
  egoSpeed: InputMaybe<Observation_EgoSpeed_Operator>;
  egoSpeedCmd: InputMaybe<Observation_EgoSpeedCmd_Operator>;
  egoSteerCmd: InputMaybe<Observation_EgoSteerCmd_Operator>;
  egoT: InputMaybe<Observation_EgoT_Operator>;
  egoX: InputMaybe<Observation_EgoX_Operator>;
  egoY: InputMaybe<Observation_EgoY_Operator>;
  egoYaw: InputMaybe<Observation_EgoYaw_Operator>;
  egoYawRate: InputMaybe<Observation_EgoYawRate_Operator>;
  esminiSeconds: InputMaybe<Observation_EsminiSeconds_Operator>;
  id: InputMaybe<Observation_Id_Operator>;
  time: InputMaybe<Observation_Time_Operator>;
  trial: InputMaybe<Observation_Trial_Operator>;
  updatedAt: InputMaybe<Observation_UpdatedAt_Operator>;
};

export type Observation_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Observation_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Observation_Where_Or>>>;
  agents__accReq: InputMaybe<Observation_Agents__AccReq_Operator>;
  agents__acceleration: InputMaybe<Observation_Agents__Acceleration_Operator>;
  agents__collisionRisk: InputMaybe<Observation_Agents__CollisionRisk_Operator>;
  agents__curvature: InputMaybe<Observation_Agents__Curvature_Operator>;
  agents__dce: InputMaybe<Observation_Agents__Dce_Operator>;
  agents__height: InputMaybe<Observation_Agents__Height_Operator>;
  agents__id: InputMaybe<Observation_Agents__Id_Operator>;
  agents__isRssSafe: InputMaybe<Observation_Agents__IsRssSafe_Operator>;
  agents__junctionId: InputMaybe<Observation_Agents__JunctionId_Operator>;
  agents__laneHeading: InputMaybe<Observation_Agents__LaneHeading_Operator>;
  agents__laneId: InputMaybe<Observation_Agents__LaneId_Operator>;
  agents__laneOffset: InputMaybe<Observation_Agents__LaneOffset_Operator>;
  agents__length: InputMaybe<Observation_Agents__Length_Operator>;
  agents__localX: InputMaybe<Observation_Agents__LocalX_Operator>;
  agents__localY: InputMaybe<Observation_Agents__LocalY_Operator>;
  agents__localYaw: InputMaybe<Observation_Agents__LocalYaw_Operator>;
  agents__name: InputMaybe<Observation_Agents__Name_Operator>;
  agents__pret: InputMaybe<Observation_Agents__Pret_Operator>;
  agents__relativeAccelerationX: InputMaybe<Observation_Agents__RelativeAccelerationX_Operator>;
  agents__relativeAccelerationY: InputMaybe<Observation_Agents__RelativeAccelerationY_Operator>;
  agents__relativeDistance: InputMaybe<Observation_Agents__RelativeDistance_Operator>;
  agents__relativeVelocityX: InputMaybe<Observation_Agents__RelativeVelocityX_Operator>;
  agents__relativeVelocityY: InputMaybe<Observation_Agents__RelativeVelocityY_Operator>;
  agents__relativeYawRate: InputMaybe<Observation_Agents__RelativeYawRate_Operator>;
  agents__roadId: InputMaybe<Observation_Agents__RoadId_Operator>;
  agents__rssRatio: InputMaybe<Observation_Agents__RssRatio_Operator>;
  agents__s: InputMaybe<Observation_Agents__S_Operator>;
  agents__speed: InputMaybe<Observation_Agents__Speed_Operator>;
  agents__spret: InputMaybe<Observation_Agents__Spret_Operator>;
  agents__t: InputMaybe<Observation_Agents__T_Operator>;
  agents__ttc: InputMaybe<Observation_Agents__Ttc_Operator>;
  agents__ttce: InputMaybe<Observation_Agents__Ttce_Operator>;
  agents__width: InputMaybe<Observation_Agents__Width_Operator>;
  agents__x: InputMaybe<Observation_Agents__X_Operator>;
  agents__y: InputMaybe<Observation_Agents__Y_Operator>;
  agents__yaw: InputMaybe<Observation_Agents__Yaw_Operator>;
  agents__yawRate: InputMaybe<Observation_Agents__YawRate_Operator>;
  createdAt: InputMaybe<Observation_CreatedAt_Operator>;
  ego: InputMaybe<Observation_Ego_Operator>;
  egoAcceleration: InputMaybe<Observation_EgoAcceleration_Operator>;
  egoCurvature: InputMaybe<Observation_EgoCurvature_Operator>;
  egoJunctionId: InputMaybe<Observation_EgoJunctionId_Operator>;
  egoLaneHeading: InputMaybe<Observation_EgoLaneHeading_Operator>;
  egoLaneId: InputMaybe<Observation_EgoLaneId_Operator>;
  egoLaneOffset: InputMaybe<Observation_EgoLaneOffset_Operator>;
  egoRoadId: InputMaybe<Observation_EgoRoadId_Operator>;
  egoS: InputMaybe<Observation_EgoS_Operator>;
  egoSpeed: InputMaybe<Observation_EgoSpeed_Operator>;
  egoSpeedCmd: InputMaybe<Observation_EgoSpeedCmd_Operator>;
  egoSteerCmd: InputMaybe<Observation_EgoSteerCmd_Operator>;
  egoT: InputMaybe<Observation_EgoT_Operator>;
  egoX: InputMaybe<Observation_EgoX_Operator>;
  egoY: InputMaybe<Observation_EgoY_Operator>;
  egoYaw: InputMaybe<Observation_EgoYaw_Operator>;
  egoYawRate: InputMaybe<Observation_EgoYawRate_Operator>;
  esminiSeconds: InputMaybe<Observation_EsminiSeconds_Operator>;
  id: InputMaybe<Observation_Id_Operator>;
  time: InputMaybe<Observation_Time_Operator>;
  trial: InputMaybe<Observation_Trial_Operator>;
  updatedAt: InputMaybe<Observation_UpdatedAt_Operator>;
};

export type Observations = {
  __typename?: 'Observations';
  docs: Array<Observation>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type ObservationsCreateAccess = {
  __typename?: 'ObservationsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ObservationsCreateDocAccess = {
  __typename?: 'ObservationsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ObservationsDeleteAccess = {
  __typename?: 'ObservationsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ObservationsDeleteDocAccess = {
  __typename?: 'ObservationsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ObservationsDocAccessFields = {
  __typename?: 'ObservationsDocAccessFields';
  agents: Maybe<ObservationsDocAccessFields_Agents>;
  createdAt: Maybe<ObservationsDocAccessFields_CreatedAt>;
  ego: Maybe<ObservationsDocAccessFields_Ego>;
  egoAcceleration: Maybe<ObservationsDocAccessFields_EgoAcceleration>;
  egoCurvature: Maybe<ObservationsDocAccessFields_EgoCurvature>;
  egoJunctionId: Maybe<ObservationsDocAccessFields_EgoJunctionId>;
  egoLaneHeading: Maybe<ObservationsDocAccessFields_EgoLaneHeading>;
  egoLaneId: Maybe<ObservationsDocAccessFields_EgoLaneId>;
  egoLaneOffset: Maybe<ObservationsDocAccessFields_EgoLaneOffset>;
  egoRoadId: Maybe<ObservationsDocAccessFields_EgoRoadId>;
  egoS: Maybe<ObservationsDocAccessFields_EgoS>;
  egoSpeed: Maybe<ObservationsDocAccessFields_EgoSpeed>;
  egoSpeedCmd: Maybe<ObservationsDocAccessFields_EgoSpeedCmd>;
  egoSteerCmd: Maybe<ObservationsDocAccessFields_EgoSteerCmd>;
  egoT: Maybe<ObservationsDocAccessFields_EgoT>;
  egoX: Maybe<ObservationsDocAccessFields_EgoX>;
  egoY: Maybe<ObservationsDocAccessFields_EgoY>;
  egoYaw: Maybe<ObservationsDocAccessFields_EgoYaw>;
  egoYawRate: Maybe<ObservationsDocAccessFields_EgoYawRate>;
  esminiSeconds: Maybe<ObservationsDocAccessFields_EsminiSeconds>;
  time: Maybe<ObservationsDocAccessFields_Time>;
  trial: Maybe<ObservationsDocAccessFields_Trial>;
  updatedAt: Maybe<ObservationsDocAccessFields_UpdatedAt>;
};

export type ObservationsDocAccessFields_Agents = {
  __typename?: 'ObservationsDocAccessFields_agents';
  create: Maybe<ObservationsDocAccessFields_Agents_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Delete>;
  fields: Maybe<ObservationsDocAccessFields_Agents_Fields>;
  read: Maybe<ObservationsDocAccessFields_Agents_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Update>;
};

export type ObservationsDocAccessFields_Agents_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Fields = {
  __typename?: 'ObservationsDocAccessFields_agents_Fields';
  accReq: Maybe<ObservationsDocAccessFields_Agents_AccReq>;
  acceleration: Maybe<ObservationsDocAccessFields_Agents_Acceleration>;
  collisionRisk: Maybe<ObservationsDocAccessFields_Agents_CollisionRisk>;
  curvature: Maybe<ObservationsDocAccessFields_Agents_Curvature>;
  dce: Maybe<ObservationsDocAccessFields_Agents_Dce>;
  height: Maybe<ObservationsDocAccessFields_Agents_Height>;
  id: Maybe<ObservationsDocAccessFields_Agents_Id>;
  isRssSafe: Maybe<ObservationsDocAccessFields_Agents_IsRssSafe>;
  junctionId: Maybe<ObservationsDocAccessFields_Agents_JunctionId>;
  laneHeading: Maybe<ObservationsDocAccessFields_Agents_LaneHeading>;
  laneId: Maybe<ObservationsDocAccessFields_Agents_LaneId>;
  laneOffset: Maybe<ObservationsDocAccessFields_Agents_LaneOffset>;
  length: Maybe<ObservationsDocAccessFields_Agents_Length>;
  localX: Maybe<ObservationsDocAccessFields_Agents_LocalX>;
  localY: Maybe<ObservationsDocAccessFields_Agents_LocalY>;
  localYaw: Maybe<ObservationsDocAccessFields_Agents_LocalYaw>;
  name: Maybe<ObservationsDocAccessFields_Agents_Name>;
  pret: Maybe<ObservationsDocAccessFields_Agents_Pret>;
  relativeAccelerationX: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationX>;
  relativeAccelerationY: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationY>;
  relativeDistance: Maybe<ObservationsDocAccessFields_Agents_RelativeDistance>;
  relativeVelocityX: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityX>;
  relativeVelocityY: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityY>;
  relativeYawRate: Maybe<ObservationsDocAccessFields_Agents_RelativeYawRate>;
  roadId: Maybe<ObservationsDocAccessFields_Agents_RoadId>;
  rssRatio: Maybe<ObservationsDocAccessFields_Agents_RssRatio>;
  s: Maybe<ObservationsDocAccessFields_Agents_S>;
  speed: Maybe<ObservationsDocAccessFields_Agents_Speed>;
  spret: Maybe<ObservationsDocAccessFields_Agents_Spret>;
  t: Maybe<ObservationsDocAccessFields_Agents_T>;
  ttc: Maybe<ObservationsDocAccessFields_Agents_Ttc>;
  ttce: Maybe<ObservationsDocAccessFields_Agents_Ttce>;
  width: Maybe<ObservationsDocAccessFields_Agents_Width>;
  x: Maybe<ObservationsDocAccessFields_Agents_X>;
  y: Maybe<ObservationsDocAccessFields_Agents_Y>;
  yaw: Maybe<ObservationsDocAccessFields_Agents_Yaw>;
  yawRate: Maybe<ObservationsDocAccessFields_Agents_YawRate>;
};

export type ObservationsDocAccessFields_Agents_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_AccReq = {
  __typename?: 'ObservationsDocAccessFields_agents_accReq';
  create: Maybe<ObservationsDocAccessFields_Agents_AccReq_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_AccReq_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_AccReq_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_AccReq_Update>;
};

export type ObservationsDocAccessFields_Agents_AccReq_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_accReq_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_AccReq_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_accReq_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_AccReq_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_accReq_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_AccReq_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_accReq_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Acceleration = {
  __typename?: 'ObservationsDocAccessFields_agents_acceleration';
  create: Maybe<ObservationsDocAccessFields_Agents_Acceleration_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Acceleration_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Acceleration_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Acceleration_Update>;
};

export type ObservationsDocAccessFields_Agents_Acceleration_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_acceleration_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Acceleration_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_acceleration_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Acceleration_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_acceleration_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Acceleration_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_acceleration_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_CollisionRisk = {
  __typename?: 'ObservationsDocAccessFields_agents_collisionRisk';
  create: Maybe<ObservationsDocAccessFields_Agents_CollisionRisk_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_CollisionRisk_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_CollisionRisk_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_CollisionRisk_Update>;
};

export type ObservationsDocAccessFields_Agents_CollisionRisk_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_collisionRisk_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_CollisionRisk_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_collisionRisk_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_CollisionRisk_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_collisionRisk_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_CollisionRisk_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_collisionRisk_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Curvature = {
  __typename?: 'ObservationsDocAccessFields_agents_curvature';
  create: Maybe<ObservationsDocAccessFields_Agents_Curvature_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Curvature_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Curvature_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Curvature_Update>;
};

export type ObservationsDocAccessFields_Agents_Curvature_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_curvature_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Curvature_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_curvature_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Curvature_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_curvature_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Curvature_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_curvature_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Dce = {
  __typename?: 'ObservationsDocAccessFields_agents_dce';
  create: Maybe<ObservationsDocAccessFields_Agents_Dce_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Dce_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Dce_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Dce_Update>;
};

export type ObservationsDocAccessFields_Agents_Dce_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_dce_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Dce_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_dce_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Dce_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_dce_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Dce_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_dce_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Height = {
  __typename?: 'ObservationsDocAccessFields_agents_height';
  create: Maybe<ObservationsDocAccessFields_Agents_Height_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Height_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Height_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Height_Update>;
};

export type ObservationsDocAccessFields_Agents_Height_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Height_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Height_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Height_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Id = {
  __typename?: 'ObservationsDocAccessFields_agents_id';
  create: Maybe<ObservationsDocAccessFields_Agents_Id_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Id_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Id_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Id_Update>;
};

export type ObservationsDocAccessFields_Agents_Id_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Id_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Id_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Id_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_IsRssSafe = {
  __typename?: 'ObservationsDocAccessFields_agents_isRssSafe';
  create: Maybe<ObservationsDocAccessFields_Agents_IsRssSafe_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_IsRssSafe_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_IsRssSafe_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_IsRssSafe_Update>;
};

export type ObservationsDocAccessFields_Agents_IsRssSafe_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_isRssSafe_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_IsRssSafe_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_isRssSafe_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_IsRssSafe_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_isRssSafe_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_IsRssSafe_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_isRssSafe_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_JunctionId = {
  __typename?: 'ObservationsDocAccessFields_agents_junctionId';
  create: Maybe<ObservationsDocAccessFields_Agents_JunctionId_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_JunctionId_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_JunctionId_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_JunctionId_Update>;
};

export type ObservationsDocAccessFields_Agents_JunctionId_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_junctionId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_JunctionId_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_junctionId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_JunctionId_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_junctionId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_JunctionId_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_junctionId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneHeading = {
  __typename?: 'ObservationsDocAccessFields_agents_laneHeading';
  create: Maybe<ObservationsDocAccessFields_Agents_LaneHeading_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_LaneHeading_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_LaneHeading_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_LaneHeading_Update>;
};

export type ObservationsDocAccessFields_Agents_LaneHeading_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_laneHeading_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneHeading_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_laneHeading_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneHeading_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_laneHeading_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneHeading_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_laneHeading_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneId = {
  __typename?: 'ObservationsDocAccessFields_agents_laneId';
  create: Maybe<ObservationsDocAccessFields_Agents_LaneId_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_LaneId_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_LaneId_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_LaneId_Update>;
};

export type ObservationsDocAccessFields_Agents_LaneId_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_laneId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneId_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_laneId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneId_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_laneId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneId_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_laneId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneOffset = {
  __typename?: 'ObservationsDocAccessFields_agents_laneOffset';
  create: Maybe<ObservationsDocAccessFields_Agents_LaneOffset_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_LaneOffset_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_LaneOffset_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_LaneOffset_Update>;
};

export type ObservationsDocAccessFields_Agents_LaneOffset_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_laneOffset_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneOffset_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_laneOffset_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneOffset_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_laneOffset_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LaneOffset_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_laneOffset_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Length = {
  __typename?: 'ObservationsDocAccessFields_agents_length';
  create: Maybe<ObservationsDocAccessFields_Agents_Length_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Length_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Length_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Length_Update>;
};

export type ObservationsDocAccessFields_Agents_Length_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_length_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Length_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_length_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Length_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_length_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Length_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_length_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalX = {
  __typename?: 'ObservationsDocAccessFields_agents_localX';
  create: Maybe<ObservationsDocAccessFields_Agents_LocalX_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_LocalX_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_LocalX_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_LocalX_Update>;
};

export type ObservationsDocAccessFields_Agents_LocalX_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_localX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalX_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_localX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalX_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_localX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalX_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_localX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalY = {
  __typename?: 'ObservationsDocAccessFields_agents_localY';
  create: Maybe<ObservationsDocAccessFields_Agents_LocalY_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_LocalY_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_LocalY_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_LocalY_Update>;
};

export type ObservationsDocAccessFields_Agents_LocalY_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_localY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalY_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_localY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalY_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_localY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalY_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_localY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalYaw = {
  __typename?: 'ObservationsDocAccessFields_agents_localYaw';
  create: Maybe<ObservationsDocAccessFields_Agents_LocalYaw_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_LocalYaw_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_LocalYaw_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_LocalYaw_Update>;
};

export type ObservationsDocAccessFields_Agents_LocalYaw_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_localYaw_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalYaw_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_localYaw_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalYaw_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_localYaw_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_LocalYaw_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_localYaw_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Name = {
  __typename?: 'ObservationsDocAccessFields_agents_name';
  create: Maybe<ObservationsDocAccessFields_Agents_Name_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Name_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Name_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Name_Update>;
};

export type ObservationsDocAccessFields_Agents_Name_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Name_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Name_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Name_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Pret = {
  __typename?: 'ObservationsDocAccessFields_agents_pret';
  create: Maybe<ObservationsDocAccessFields_Agents_Pret_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Pret_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Pret_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Pret_Update>;
};

export type ObservationsDocAccessFields_Agents_Pret_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_pret_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Pret_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_pret_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Pret_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_pret_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Pret_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_pret_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationX = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationX';
  create: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationX_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationX_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationX_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationX_Update>;
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationX_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationX_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationX_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationX_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationY = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationY';
  create: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationY_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationY_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationY_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RelativeAccelerationY_Update>;
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationY_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationY_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationY_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeAccelerationY_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeAccelerationY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeDistance = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeDistance';
  create: Maybe<ObservationsDocAccessFields_Agents_RelativeDistance_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RelativeDistance_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RelativeDistance_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RelativeDistance_Update>;
};

export type ObservationsDocAccessFields_Agents_RelativeDistance_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeDistance_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeDistance_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeDistance_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeDistance_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeDistance_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeDistance_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeDistance_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityX = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityX';
  create: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityX_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityX_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityX_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityX_Update>;
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityX_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityX_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityX_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityX_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityY = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityY';
  create: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityY_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityY_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityY_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RelativeVelocityY_Update>;
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityY_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityY_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityY_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeVelocityY_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeVelocityY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeYawRate = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeYawRate';
  create: Maybe<ObservationsDocAccessFields_Agents_RelativeYawRate_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RelativeYawRate_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RelativeYawRate_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RelativeYawRate_Update>;
};

export type ObservationsDocAccessFields_Agents_RelativeYawRate_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeYawRate_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeYawRate_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeYawRate_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeYawRate_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeYawRate_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RelativeYawRate_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_relativeYawRate_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RoadId = {
  __typename?: 'ObservationsDocAccessFields_agents_roadId';
  create: Maybe<ObservationsDocAccessFields_Agents_RoadId_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RoadId_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RoadId_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RoadId_Update>;
};

export type ObservationsDocAccessFields_Agents_RoadId_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_roadId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RoadId_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_roadId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RoadId_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_roadId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RoadId_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_roadId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RssRatio = {
  __typename?: 'ObservationsDocAccessFields_agents_rssRatio';
  create: Maybe<ObservationsDocAccessFields_Agents_RssRatio_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_RssRatio_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_RssRatio_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_RssRatio_Update>;
};

export type ObservationsDocAccessFields_Agents_RssRatio_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_rssRatio_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RssRatio_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_rssRatio_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RssRatio_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_rssRatio_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_RssRatio_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_rssRatio_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_S = {
  __typename?: 'ObservationsDocAccessFields_agents_s';
  create: Maybe<ObservationsDocAccessFields_Agents_S_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_S_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_S_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_S_Update>;
};

export type ObservationsDocAccessFields_Agents_S_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_s_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_S_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_s_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_S_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_s_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_S_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_s_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Speed = {
  __typename?: 'ObservationsDocAccessFields_agents_speed';
  create: Maybe<ObservationsDocAccessFields_Agents_Speed_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Speed_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Speed_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Speed_Update>;
};

export type ObservationsDocAccessFields_Agents_Speed_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_speed_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Speed_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_speed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Speed_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_speed_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Speed_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_speed_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Spret = {
  __typename?: 'ObservationsDocAccessFields_agents_spret';
  create: Maybe<ObservationsDocAccessFields_Agents_Spret_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Spret_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Spret_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Spret_Update>;
};

export type ObservationsDocAccessFields_Agents_Spret_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_spret_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Spret_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_spret_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Spret_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_spret_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Spret_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_spret_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_T = {
  __typename?: 'ObservationsDocAccessFields_agents_t';
  create: Maybe<ObservationsDocAccessFields_Agents_T_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_T_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_T_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_T_Update>;
};

export type ObservationsDocAccessFields_Agents_T_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_t_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_T_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_t_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_T_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_t_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_T_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_t_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttc = {
  __typename?: 'ObservationsDocAccessFields_agents_ttc';
  create: Maybe<ObservationsDocAccessFields_Agents_Ttc_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Ttc_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Ttc_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Ttc_Update>;
};

export type ObservationsDocAccessFields_Agents_Ttc_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_ttc_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttc_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_ttc_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttc_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_ttc_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttc_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_ttc_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttce = {
  __typename?: 'ObservationsDocAccessFields_agents_ttce';
  create: Maybe<ObservationsDocAccessFields_Agents_Ttce_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Ttce_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Ttce_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Ttce_Update>;
};

export type ObservationsDocAccessFields_Agents_Ttce_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_ttce_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttce_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_ttce_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttce_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_ttce_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Ttce_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_ttce_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Width = {
  __typename?: 'ObservationsDocAccessFields_agents_width';
  create: Maybe<ObservationsDocAccessFields_Agents_Width_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Width_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Width_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Width_Update>;
};

export type ObservationsDocAccessFields_Agents_Width_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Width_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Width_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Width_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_X = {
  __typename?: 'ObservationsDocAccessFields_agents_x';
  create: Maybe<ObservationsDocAccessFields_Agents_X_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_X_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_X_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_X_Update>;
};

export type ObservationsDocAccessFields_Agents_X_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_x_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_X_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_x_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_X_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_x_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_X_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_x_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Y = {
  __typename?: 'ObservationsDocAccessFields_agents_y';
  create: Maybe<ObservationsDocAccessFields_Agents_Y_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Y_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Y_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Y_Update>;
};

export type ObservationsDocAccessFields_Agents_Y_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_y_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Y_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_y_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Y_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_y_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Y_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_y_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Yaw = {
  __typename?: 'ObservationsDocAccessFields_agents_yaw';
  create: Maybe<ObservationsDocAccessFields_Agents_Yaw_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_Yaw_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_Yaw_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_Yaw_Update>;
};

export type ObservationsDocAccessFields_Agents_YawRate = {
  __typename?: 'ObservationsDocAccessFields_agents_yawRate';
  create: Maybe<ObservationsDocAccessFields_Agents_YawRate_Create>;
  delete: Maybe<ObservationsDocAccessFields_Agents_YawRate_Delete>;
  read: Maybe<ObservationsDocAccessFields_Agents_YawRate_Read>;
  update: Maybe<ObservationsDocAccessFields_Agents_YawRate_Update>;
};

export type ObservationsDocAccessFields_Agents_YawRate_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_yawRate_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_YawRate_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_yawRate_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_YawRate_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_yawRate_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_YawRate_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_yawRate_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Yaw_Create = {
  __typename?: 'ObservationsDocAccessFields_agents_yaw_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Yaw_Delete = {
  __typename?: 'ObservationsDocAccessFields_agents_yaw_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Yaw_Read = {
  __typename?: 'ObservationsDocAccessFields_agents_yaw_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Agents_Yaw_Update = {
  __typename?: 'ObservationsDocAccessFields_agents_yaw_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_CreatedAt = {
  __typename?: 'ObservationsDocAccessFields_createdAt';
  create: Maybe<ObservationsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<ObservationsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<ObservationsDocAccessFields_CreatedAt_Read>;
  update: Maybe<ObservationsDocAccessFields_CreatedAt_Update>;
};

export type ObservationsDocAccessFields_CreatedAt_Create = {
  __typename?: 'ObservationsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'ObservationsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_CreatedAt_Read = {
  __typename?: 'ObservationsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_CreatedAt_Update = {
  __typename?: 'ObservationsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Ego = {
  __typename?: 'ObservationsDocAccessFields_ego';
  create: Maybe<ObservationsDocAccessFields_Ego_Create>;
  delete: Maybe<ObservationsDocAccessFields_Ego_Delete>;
  read: Maybe<ObservationsDocAccessFields_Ego_Read>;
  update: Maybe<ObservationsDocAccessFields_Ego_Update>;
};

export type ObservationsDocAccessFields_EgoAcceleration = {
  __typename?: 'ObservationsDocAccessFields_egoAcceleration';
  create: Maybe<ObservationsDocAccessFields_EgoAcceleration_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoAcceleration_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoAcceleration_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoAcceleration_Update>;
};

export type ObservationsDocAccessFields_EgoAcceleration_Create = {
  __typename?: 'ObservationsDocAccessFields_egoAcceleration_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoAcceleration_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoAcceleration_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoAcceleration_Read = {
  __typename?: 'ObservationsDocAccessFields_egoAcceleration_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoAcceleration_Update = {
  __typename?: 'ObservationsDocAccessFields_egoAcceleration_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoCurvature = {
  __typename?: 'ObservationsDocAccessFields_egoCurvature';
  create: Maybe<ObservationsDocAccessFields_EgoCurvature_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoCurvature_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoCurvature_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoCurvature_Update>;
};

export type ObservationsDocAccessFields_EgoCurvature_Create = {
  __typename?: 'ObservationsDocAccessFields_egoCurvature_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoCurvature_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoCurvature_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoCurvature_Read = {
  __typename?: 'ObservationsDocAccessFields_egoCurvature_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoCurvature_Update = {
  __typename?: 'ObservationsDocAccessFields_egoCurvature_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoJunctionId = {
  __typename?: 'ObservationsDocAccessFields_egoJunctionId';
  create: Maybe<ObservationsDocAccessFields_EgoJunctionId_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoJunctionId_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoJunctionId_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoJunctionId_Update>;
};

export type ObservationsDocAccessFields_EgoJunctionId_Create = {
  __typename?: 'ObservationsDocAccessFields_egoJunctionId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoJunctionId_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoJunctionId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoJunctionId_Read = {
  __typename?: 'ObservationsDocAccessFields_egoJunctionId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoJunctionId_Update = {
  __typename?: 'ObservationsDocAccessFields_egoJunctionId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneHeading = {
  __typename?: 'ObservationsDocAccessFields_egoLaneHeading';
  create: Maybe<ObservationsDocAccessFields_EgoLaneHeading_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoLaneHeading_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoLaneHeading_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoLaneHeading_Update>;
};

export type ObservationsDocAccessFields_EgoLaneHeading_Create = {
  __typename?: 'ObservationsDocAccessFields_egoLaneHeading_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneHeading_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoLaneHeading_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneHeading_Read = {
  __typename?: 'ObservationsDocAccessFields_egoLaneHeading_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneHeading_Update = {
  __typename?: 'ObservationsDocAccessFields_egoLaneHeading_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneId = {
  __typename?: 'ObservationsDocAccessFields_egoLaneId';
  create: Maybe<ObservationsDocAccessFields_EgoLaneId_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoLaneId_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoLaneId_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoLaneId_Update>;
};

export type ObservationsDocAccessFields_EgoLaneId_Create = {
  __typename?: 'ObservationsDocAccessFields_egoLaneId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneId_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoLaneId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneId_Read = {
  __typename?: 'ObservationsDocAccessFields_egoLaneId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneId_Update = {
  __typename?: 'ObservationsDocAccessFields_egoLaneId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneOffset = {
  __typename?: 'ObservationsDocAccessFields_egoLaneOffset';
  create: Maybe<ObservationsDocAccessFields_EgoLaneOffset_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoLaneOffset_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoLaneOffset_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoLaneOffset_Update>;
};

export type ObservationsDocAccessFields_EgoLaneOffset_Create = {
  __typename?: 'ObservationsDocAccessFields_egoLaneOffset_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneOffset_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoLaneOffset_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneOffset_Read = {
  __typename?: 'ObservationsDocAccessFields_egoLaneOffset_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoLaneOffset_Update = {
  __typename?: 'ObservationsDocAccessFields_egoLaneOffset_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoRoadId = {
  __typename?: 'ObservationsDocAccessFields_egoRoadId';
  create: Maybe<ObservationsDocAccessFields_EgoRoadId_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoRoadId_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoRoadId_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoRoadId_Update>;
};

export type ObservationsDocAccessFields_EgoRoadId_Create = {
  __typename?: 'ObservationsDocAccessFields_egoRoadId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoRoadId_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoRoadId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoRoadId_Read = {
  __typename?: 'ObservationsDocAccessFields_egoRoadId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoRoadId_Update = {
  __typename?: 'ObservationsDocAccessFields_egoRoadId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoS = {
  __typename?: 'ObservationsDocAccessFields_egoS';
  create: Maybe<ObservationsDocAccessFields_EgoS_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoS_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoS_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoS_Update>;
};

export type ObservationsDocAccessFields_EgoS_Create = {
  __typename?: 'ObservationsDocAccessFields_egoS_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoS_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoS_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoS_Read = {
  __typename?: 'ObservationsDocAccessFields_egoS_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoS_Update = {
  __typename?: 'ObservationsDocAccessFields_egoS_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeed = {
  __typename?: 'ObservationsDocAccessFields_egoSpeed';
  create: Maybe<ObservationsDocAccessFields_EgoSpeed_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoSpeed_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoSpeed_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoSpeed_Update>;
};

export type ObservationsDocAccessFields_EgoSpeedCmd = {
  __typename?: 'ObservationsDocAccessFields_egoSpeedCmd';
  create: Maybe<ObservationsDocAccessFields_EgoSpeedCmd_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoSpeedCmd_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoSpeedCmd_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoSpeedCmd_Update>;
};

export type ObservationsDocAccessFields_EgoSpeedCmd_Create = {
  __typename?: 'ObservationsDocAccessFields_egoSpeedCmd_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeedCmd_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoSpeedCmd_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeedCmd_Read = {
  __typename?: 'ObservationsDocAccessFields_egoSpeedCmd_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeedCmd_Update = {
  __typename?: 'ObservationsDocAccessFields_egoSpeedCmd_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeed_Create = {
  __typename?: 'ObservationsDocAccessFields_egoSpeed_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeed_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoSpeed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeed_Read = {
  __typename?: 'ObservationsDocAccessFields_egoSpeed_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSpeed_Update = {
  __typename?: 'ObservationsDocAccessFields_egoSpeed_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSteerCmd = {
  __typename?: 'ObservationsDocAccessFields_egoSteerCmd';
  create: Maybe<ObservationsDocAccessFields_EgoSteerCmd_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoSteerCmd_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoSteerCmd_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoSteerCmd_Update>;
};

export type ObservationsDocAccessFields_EgoSteerCmd_Create = {
  __typename?: 'ObservationsDocAccessFields_egoSteerCmd_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSteerCmd_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoSteerCmd_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSteerCmd_Read = {
  __typename?: 'ObservationsDocAccessFields_egoSteerCmd_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoSteerCmd_Update = {
  __typename?: 'ObservationsDocAccessFields_egoSteerCmd_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoT = {
  __typename?: 'ObservationsDocAccessFields_egoT';
  create: Maybe<ObservationsDocAccessFields_EgoT_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoT_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoT_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoT_Update>;
};

export type ObservationsDocAccessFields_EgoT_Create = {
  __typename?: 'ObservationsDocAccessFields_egoT_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoT_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoT_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoT_Read = {
  __typename?: 'ObservationsDocAccessFields_egoT_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoT_Update = {
  __typename?: 'ObservationsDocAccessFields_egoT_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoX = {
  __typename?: 'ObservationsDocAccessFields_egoX';
  create: Maybe<ObservationsDocAccessFields_EgoX_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoX_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoX_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoX_Update>;
};

export type ObservationsDocAccessFields_EgoX_Create = {
  __typename?: 'ObservationsDocAccessFields_egoX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoX_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoX_Read = {
  __typename?: 'ObservationsDocAccessFields_egoX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoX_Update = {
  __typename?: 'ObservationsDocAccessFields_egoX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoY = {
  __typename?: 'ObservationsDocAccessFields_egoY';
  create: Maybe<ObservationsDocAccessFields_EgoY_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoY_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoY_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoY_Update>;
};

export type ObservationsDocAccessFields_EgoY_Create = {
  __typename?: 'ObservationsDocAccessFields_egoY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoY_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoY_Read = {
  __typename?: 'ObservationsDocAccessFields_egoY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoY_Update = {
  __typename?: 'ObservationsDocAccessFields_egoY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYaw = {
  __typename?: 'ObservationsDocAccessFields_egoYaw';
  create: Maybe<ObservationsDocAccessFields_EgoYaw_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoYaw_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoYaw_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoYaw_Update>;
};

export type ObservationsDocAccessFields_EgoYawRate = {
  __typename?: 'ObservationsDocAccessFields_egoYawRate';
  create: Maybe<ObservationsDocAccessFields_EgoYawRate_Create>;
  delete: Maybe<ObservationsDocAccessFields_EgoYawRate_Delete>;
  read: Maybe<ObservationsDocAccessFields_EgoYawRate_Read>;
  update: Maybe<ObservationsDocAccessFields_EgoYawRate_Update>;
};

export type ObservationsDocAccessFields_EgoYawRate_Create = {
  __typename?: 'ObservationsDocAccessFields_egoYawRate_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYawRate_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoYawRate_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYawRate_Read = {
  __typename?: 'ObservationsDocAccessFields_egoYawRate_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYawRate_Update = {
  __typename?: 'ObservationsDocAccessFields_egoYawRate_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYaw_Create = {
  __typename?: 'ObservationsDocAccessFields_egoYaw_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYaw_Delete = {
  __typename?: 'ObservationsDocAccessFields_egoYaw_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYaw_Read = {
  __typename?: 'ObservationsDocAccessFields_egoYaw_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EgoYaw_Update = {
  __typename?: 'ObservationsDocAccessFields_egoYaw_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Ego_Create = {
  __typename?: 'ObservationsDocAccessFields_ego_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Ego_Delete = {
  __typename?: 'ObservationsDocAccessFields_ego_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Ego_Read = {
  __typename?: 'ObservationsDocAccessFields_ego_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Ego_Update = {
  __typename?: 'ObservationsDocAccessFields_ego_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EsminiSeconds = {
  __typename?: 'ObservationsDocAccessFields_esminiSeconds';
  create: Maybe<ObservationsDocAccessFields_EsminiSeconds_Create>;
  delete: Maybe<ObservationsDocAccessFields_EsminiSeconds_Delete>;
  read: Maybe<ObservationsDocAccessFields_EsminiSeconds_Read>;
  update: Maybe<ObservationsDocAccessFields_EsminiSeconds_Update>;
};

export type ObservationsDocAccessFields_EsminiSeconds_Create = {
  __typename?: 'ObservationsDocAccessFields_esminiSeconds_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EsminiSeconds_Delete = {
  __typename?: 'ObservationsDocAccessFields_esminiSeconds_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EsminiSeconds_Read = {
  __typename?: 'ObservationsDocAccessFields_esminiSeconds_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_EsminiSeconds_Update = {
  __typename?: 'ObservationsDocAccessFields_esminiSeconds_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Time = {
  __typename?: 'ObservationsDocAccessFields_time';
  create: Maybe<ObservationsDocAccessFields_Time_Create>;
  delete: Maybe<ObservationsDocAccessFields_Time_Delete>;
  read: Maybe<ObservationsDocAccessFields_Time_Read>;
  update: Maybe<ObservationsDocAccessFields_Time_Update>;
};

export type ObservationsDocAccessFields_Time_Create = {
  __typename?: 'ObservationsDocAccessFields_time_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Time_Delete = {
  __typename?: 'ObservationsDocAccessFields_time_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Time_Read = {
  __typename?: 'ObservationsDocAccessFields_time_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Time_Update = {
  __typename?: 'ObservationsDocAccessFields_time_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Trial = {
  __typename?: 'ObservationsDocAccessFields_trial';
  create: Maybe<ObservationsDocAccessFields_Trial_Create>;
  delete: Maybe<ObservationsDocAccessFields_Trial_Delete>;
  read: Maybe<ObservationsDocAccessFields_Trial_Read>;
  update: Maybe<ObservationsDocAccessFields_Trial_Update>;
};

export type ObservationsDocAccessFields_Trial_Create = {
  __typename?: 'ObservationsDocAccessFields_trial_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Trial_Delete = {
  __typename?: 'ObservationsDocAccessFields_trial_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Trial_Read = {
  __typename?: 'ObservationsDocAccessFields_trial_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_Trial_Update = {
  __typename?: 'ObservationsDocAccessFields_trial_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_UpdatedAt = {
  __typename?: 'ObservationsDocAccessFields_updatedAt';
  create: Maybe<ObservationsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<ObservationsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<ObservationsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<ObservationsDocAccessFields_UpdatedAt_Update>;
};

export type ObservationsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'ObservationsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'ObservationsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'ObservationsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'ObservationsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields = {
  __typename?: 'ObservationsFields';
  agents: Maybe<ObservationsFields_Agents>;
  createdAt: Maybe<ObservationsFields_CreatedAt>;
  ego: Maybe<ObservationsFields_Ego>;
  egoAcceleration: Maybe<ObservationsFields_EgoAcceleration>;
  egoCurvature: Maybe<ObservationsFields_EgoCurvature>;
  egoJunctionId: Maybe<ObservationsFields_EgoJunctionId>;
  egoLaneHeading: Maybe<ObservationsFields_EgoLaneHeading>;
  egoLaneId: Maybe<ObservationsFields_EgoLaneId>;
  egoLaneOffset: Maybe<ObservationsFields_EgoLaneOffset>;
  egoRoadId: Maybe<ObservationsFields_EgoRoadId>;
  egoS: Maybe<ObservationsFields_EgoS>;
  egoSpeed: Maybe<ObservationsFields_EgoSpeed>;
  egoSpeedCmd: Maybe<ObservationsFields_EgoSpeedCmd>;
  egoSteerCmd: Maybe<ObservationsFields_EgoSteerCmd>;
  egoT: Maybe<ObservationsFields_EgoT>;
  egoX: Maybe<ObservationsFields_EgoX>;
  egoY: Maybe<ObservationsFields_EgoY>;
  egoYaw: Maybe<ObservationsFields_EgoYaw>;
  egoYawRate: Maybe<ObservationsFields_EgoYawRate>;
  esminiSeconds: Maybe<ObservationsFields_EsminiSeconds>;
  time: Maybe<ObservationsFields_Time>;
  trial: Maybe<ObservationsFields_Trial>;
  updatedAt: Maybe<ObservationsFields_UpdatedAt>;
};

export type ObservationsFields_Agents = {
  __typename?: 'ObservationsFields_agents';
  create: Maybe<ObservationsFields_Agents_Create>;
  delete: Maybe<ObservationsFields_Agents_Delete>;
  fields: Maybe<ObservationsFields_Agents_Fields>;
  read: Maybe<ObservationsFields_Agents_Read>;
  update: Maybe<ObservationsFields_Agents_Update>;
};

export type ObservationsFields_Agents_Create = {
  __typename?: 'ObservationsFields_agents_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Delete = {
  __typename?: 'ObservationsFields_agents_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Fields = {
  __typename?: 'ObservationsFields_agents_Fields';
  accReq: Maybe<ObservationsFields_Agents_AccReq>;
  acceleration: Maybe<ObservationsFields_Agents_Acceleration>;
  collisionRisk: Maybe<ObservationsFields_Agents_CollisionRisk>;
  curvature: Maybe<ObservationsFields_Agents_Curvature>;
  dce: Maybe<ObservationsFields_Agents_Dce>;
  height: Maybe<ObservationsFields_Agents_Height>;
  id: Maybe<ObservationsFields_Agents_Id>;
  isRssSafe: Maybe<ObservationsFields_Agents_IsRssSafe>;
  junctionId: Maybe<ObservationsFields_Agents_JunctionId>;
  laneHeading: Maybe<ObservationsFields_Agents_LaneHeading>;
  laneId: Maybe<ObservationsFields_Agents_LaneId>;
  laneOffset: Maybe<ObservationsFields_Agents_LaneOffset>;
  length: Maybe<ObservationsFields_Agents_Length>;
  localX: Maybe<ObservationsFields_Agents_LocalX>;
  localY: Maybe<ObservationsFields_Agents_LocalY>;
  localYaw: Maybe<ObservationsFields_Agents_LocalYaw>;
  name: Maybe<ObservationsFields_Agents_Name>;
  pret: Maybe<ObservationsFields_Agents_Pret>;
  relativeAccelerationX: Maybe<ObservationsFields_Agents_RelativeAccelerationX>;
  relativeAccelerationY: Maybe<ObservationsFields_Agents_RelativeAccelerationY>;
  relativeDistance: Maybe<ObservationsFields_Agents_RelativeDistance>;
  relativeVelocityX: Maybe<ObservationsFields_Agents_RelativeVelocityX>;
  relativeVelocityY: Maybe<ObservationsFields_Agents_RelativeVelocityY>;
  relativeYawRate: Maybe<ObservationsFields_Agents_RelativeYawRate>;
  roadId: Maybe<ObservationsFields_Agents_RoadId>;
  rssRatio: Maybe<ObservationsFields_Agents_RssRatio>;
  s: Maybe<ObservationsFields_Agents_S>;
  speed: Maybe<ObservationsFields_Agents_Speed>;
  spret: Maybe<ObservationsFields_Agents_Spret>;
  t: Maybe<ObservationsFields_Agents_T>;
  ttc: Maybe<ObservationsFields_Agents_Ttc>;
  ttce: Maybe<ObservationsFields_Agents_Ttce>;
  width: Maybe<ObservationsFields_Agents_Width>;
  x: Maybe<ObservationsFields_Agents_X>;
  y: Maybe<ObservationsFields_Agents_Y>;
  yaw: Maybe<ObservationsFields_Agents_Yaw>;
  yawRate: Maybe<ObservationsFields_Agents_YawRate>;
};

export type ObservationsFields_Agents_Read = {
  __typename?: 'ObservationsFields_agents_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Update = {
  __typename?: 'ObservationsFields_agents_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_AccReq = {
  __typename?: 'ObservationsFields_agents_accReq';
  create: Maybe<ObservationsFields_Agents_AccReq_Create>;
  delete: Maybe<ObservationsFields_Agents_AccReq_Delete>;
  read: Maybe<ObservationsFields_Agents_AccReq_Read>;
  update: Maybe<ObservationsFields_Agents_AccReq_Update>;
};

export type ObservationsFields_Agents_AccReq_Create = {
  __typename?: 'ObservationsFields_agents_accReq_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_AccReq_Delete = {
  __typename?: 'ObservationsFields_agents_accReq_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_AccReq_Read = {
  __typename?: 'ObservationsFields_agents_accReq_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_AccReq_Update = {
  __typename?: 'ObservationsFields_agents_accReq_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Acceleration = {
  __typename?: 'ObservationsFields_agents_acceleration';
  create: Maybe<ObservationsFields_Agents_Acceleration_Create>;
  delete: Maybe<ObservationsFields_Agents_Acceleration_Delete>;
  read: Maybe<ObservationsFields_Agents_Acceleration_Read>;
  update: Maybe<ObservationsFields_Agents_Acceleration_Update>;
};

export type ObservationsFields_Agents_Acceleration_Create = {
  __typename?: 'ObservationsFields_agents_acceleration_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Acceleration_Delete = {
  __typename?: 'ObservationsFields_agents_acceleration_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Acceleration_Read = {
  __typename?: 'ObservationsFields_agents_acceleration_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Acceleration_Update = {
  __typename?: 'ObservationsFields_agents_acceleration_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_CollisionRisk = {
  __typename?: 'ObservationsFields_agents_collisionRisk';
  create: Maybe<ObservationsFields_Agents_CollisionRisk_Create>;
  delete: Maybe<ObservationsFields_Agents_CollisionRisk_Delete>;
  read: Maybe<ObservationsFields_Agents_CollisionRisk_Read>;
  update: Maybe<ObservationsFields_Agents_CollisionRisk_Update>;
};

export type ObservationsFields_Agents_CollisionRisk_Create = {
  __typename?: 'ObservationsFields_agents_collisionRisk_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_CollisionRisk_Delete = {
  __typename?: 'ObservationsFields_agents_collisionRisk_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_CollisionRisk_Read = {
  __typename?: 'ObservationsFields_agents_collisionRisk_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_CollisionRisk_Update = {
  __typename?: 'ObservationsFields_agents_collisionRisk_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Curvature = {
  __typename?: 'ObservationsFields_agents_curvature';
  create: Maybe<ObservationsFields_Agents_Curvature_Create>;
  delete: Maybe<ObservationsFields_Agents_Curvature_Delete>;
  read: Maybe<ObservationsFields_Agents_Curvature_Read>;
  update: Maybe<ObservationsFields_Agents_Curvature_Update>;
};

export type ObservationsFields_Agents_Curvature_Create = {
  __typename?: 'ObservationsFields_agents_curvature_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Curvature_Delete = {
  __typename?: 'ObservationsFields_agents_curvature_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Curvature_Read = {
  __typename?: 'ObservationsFields_agents_curvature_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Curvature_Update = {
  __typename?: 'ObservationsFields_agents_curvature_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Dce = {
  __typename?: 'ObservationsFields_agents_dce';
  create: Maybe<ObservationsFields_Agents_Dce_Create>;
  delete: Maybe<ObservationsFields_Agents_Dce_Delete>;
  read: Maybe<ObservationsFields_Agents_Dce_Read>;
  update: Maybe<ObservationsFields_Agents_Dce_Update>;
};

export type ObservationsFields_Agents_Dce_Create = {
  __typename?: 'ObservationsFields_agents_dce_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Dce_Delete = {
  __typename?: 'ObservationsFields_agents_dce_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Dce_Read = {
  __typename?: 'ObservationsFields_agents_dce_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Dce_Update = {
  __typename?: 'ObservationsFields_agents_dce_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Height = {
  __typename?: 'ObservationsFields_agents_height';
  create: Maybe<ObservationsFields_Agents_Height_Create>;
  delete: Maybe<ObservationsFields_Agents_Height_Delete>;
  read: Maybe<ObservationsFields_Agents_Height_Read>;
  update: Maybe<ObservationsFields_Agents_Height_Update>;
};

export type ObservationsFields_Agents_Height_Create = {
  __typename?: 'ObservationsFields_agents_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Height_Delete = {
  __typename?: 'ObservationsFields_agents_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Height_Read = {
  __typename?: 'ObservationsFields_agents_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Height_Update = {
  __typename?: 'ObservationsFields_agents_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Id = {
  __typename?: 'ObservationsFields_agents_id';
  create: Maybe<ObservationsFields_Agents_Id_Create>;
  delete: Maybe<ObservationsFields_Agents_Id_Delete>;
  read: Maybe<ObservationsFields_Agents_Id_Read>;
  update: Maybe<ObservationsFields_Agents_Id_Update>;
};

export type ObservationsFields_Agents_Id_Create = {
  __typename?: 'ObservationsFields_agents_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Id_Delete = {
  __typename?: 'ObservationsFields_agents_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Id_Read = {
  __typename?: 'ObservationsFields_agents_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Id_Update = {
  __typename?: 'ObservationsFields_agents_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_IsRssSafe = {
  __typename?: 'ObservationsFields_agents_isRssSafe';
  create: Maybe<ObservationsFields_Agents_IsRssSafe_Create>;
  delete: Maybe<ObservationsFields_Agents_IsRssSafe_Delete>;
  read: Maybe<ObservationsFields_Agents_IsRssSafe_Read>;
  update: Maybe<ObservationsFields_Agents_IsRssSafe_Update>;
};

export type ObservationsFields_Agents_IsRssSafe_Create = {
  __typename?: 'ObservationsFields_agents_isRssSafe_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_IsRssSafe_Delete = {
  __typename?: 'ObservationsFields_agents_isRssSafe_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_IsRssSafe_Read = {
  __typename?: 'ObservationsFields_agents_isRssSafe_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_IsRssSafe_Update = {
  __typename?: 'ObservationsFields_agents_isRssSafe_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_JunctionId = {
  __typename?: 'ObservationsFields_agents_junctionId';
  create: Maybe<ObservationsFields_Agents_JunctionId_Create>;
  delete: Maybe<ObservationsFields_Agents_JunctionId_Delete>;
  read: Maybe<ObservationsFields_Agents_JunctionId_Read>;
  update: Maybe<ObservationsFields_Agents_JunctionId_Update>;
};

export type ObservationsFields_Agents_JunctionId_Create = {
  __typename?: 'ObservationsFields_agents_junctionId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_JunctionId_Delete = {
  __typename?: 'ObservationsFields_agents_junctionId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_JunctionId_Read = {
  __typename?: 'ObservationsFields_agents_junctionId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_JunctionId_Update = {
  __typename?: 'ObservationsFields_agents_junctionId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneHeading = {
  __typename?: 'ObservationsFields_agents_laneHeading';
  create: Maybe<ObservationsFields_Agents_LaneHeading_Create>;
  delete: Maybe<ObservationsFields_Agents_LaneHeading_Delete>;
  read: Maybe<ObservationsFields_Agents_LaneHeading_Read>;
  update: Maybe<ObservationsFields_Agents_LaneHeading_Update>;
};

export type ObservationsFields_Agents_LaneHeading_Create = {
  __typename?: 'ObservationsFields_agents_laneHeading_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneHeading_Delete = {
  __typename?: 'ObservationsFields_agents_laneHeading_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneHeading_Read = {
  __typename?: 'ObservationsFields_agents_laneHeading_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneHeading_Update = {
  __typename?: 'ObservationsFields_agents_laneHeading_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneId = {
  __typename?: 'ObservationsFields_agents_laneId';
  create: Maybe<ObservationsFields_Agents_LaneId_Create>;
  delete: Maybe<ObservationsFields_Agents_LaneId_Delete>;
  read: Maybe<ObservationsFields_Agents_LaneId_Read>;
  update: Maybe<ObservationsFields_Agents_LaneId_Update>;
};

export type ObservationsFields_Agents_LaneId_Create = {
  __typename?: 'ObservationsFields_agents_laneId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneId_Delete = {
  __typename?: 'ObservationsFields_agents_laneId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneId_Read = {
  __typename?: 'ObservationsFields_agents_laneId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneId_Update = {
  __typename?: 'ObservationsFields_agents_laneId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneOffset = {
  __typename?: 'ObservationsFields_agents_laneOffset';
  create: Maybe<ObservationsFields_Agents_LaneOffset_Create>;
  delete: Maybe<ObservationsFields_Agents_LaneOffset_Delete>;
  read: Maybe<ObservationsFields_Agents_LaneOffset_Read>;
  update: Maybe<ObservationsFields_Agents_LaneOffset_Update>;
};

export type ObservationsFields_Agents_LaneOffset_Create = {
  __typename?: 'ObservationsFields_agents_laneOffset_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneOffset_Delete = {
  __typename?: 'ObservationsFields_agents_laneOffset_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneOffset_Read = {
  __typename?: 'ObservationsFields_agents_laneOffset_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LaneOffset_Update = {
  __typename?: 'ObservationsFields_agents_laneOffset_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Length = {
  __typename?: 'ObservationsFields_agents_length';
  create: Maybe<ObservationsFields_Agents_Length_Create>;
  delete: Maybe<ObservationsFields_Agents_Length_Delete>;
  read: Maybe<ObservationsFields_Agents_Length_Read>;
  update: Maybe<ObservationsFields_Agents_Length_Update>;
};

export type ObservationsFields_Agents_Length_Create = {
  __typename?: 'ObservationsFields_agents_length_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Length_Delete = {
  __typename?: 'ObservationsFields_agents_length_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Length_Read = {
  __typename?: 'ObservationsFields_agents_length_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Length_Update = {
  __typename?: 'ObservationsFields_agents_length_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalX = {
  __typename?: 'ObservationsFields_agents_localX';
  create: Maybe<ObservationsFields_Agents_LocalX_Create>;
  delete: Maybe<ObservationsFields_Agents_LocalX_Delete>;
  read: Maybe<ObservationsFields_Agents_LocalX_Read>;
  update: Maybe<ObservationsFields_Agents_LocalX_Update>;
};

export type ObservationsFields_Agents_LocalX_Create = {
  __typename?: 'ObservationsFields_agents_localX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalX_Delete = {
  __typename?: 'ObservationsFields_agents_localX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalX_Read = {
  __typename?: 'ObservationsFields_agents_localX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalX_Update = {
  __typename?: 'ObservationsFields_agents_localX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalY = {
  __typename?: 'ObservationsFields_agents_localY';
  create: Maybe<ObservationsFields_Agents_LocalY_Create>;
  delete: Maybe<ObservationsFields_Agents_LocalY_Delete>;
  read: Maybe<ObservationsFields_Agents_LocalY_Read>;
  update: Maybe<ObservationsFields_Agents_LocalY_Update>;
};

export type ObservationsFields_Agents_LocalY_Create = {
  __typename?: 'ObservationsFields_agents_localY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalY_Delete = {
  __typename?: 'ObservationsFields_agents_localY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalY_Read = {
  __typename?: 'ObservationsFields_agents_localY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalY_Update = {
  __typename?: 'ObservationsFields_agents_localY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalYaw = {
  __typename?: 'ObservationsFields_agents_localYaw';
  create: Maybe<ObservationsFields_Agents_LocalYaw_Create>;
  delete: Maybe<ObservationsFields_Agents_LocalYaw_Delete>;
  read: Maybe<ObservationsFields_Agents_LocalYaw_Read>;
  update: Maybe<ObservationsFields_Agents_LocalYaw_Update>;
};

export type ObservationsFields_Agents_LocalYaw_Create = {
  __typename?: 'ObservationsFields_agents_localYaw_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalYaw_Delete = {
  __typename?: 'ObservationsFields_agents_localYaw_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalYaw_Read = {
  __typename?: 'ObservationsFields_agents_localYaw_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_LocalYaw_Update = {
  __typename?: 'ObservationsFields_agents_localYaw_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Name = {
  __typename?: 'ObservationsFields_agents_name';
  create: Maybe<ObservationsFields_Agents_Name_Create>;
  delete: Maybe<ObservationsFields_Agents_Name_Delete>;
  read: Maybe<ObservationsFields_Agents_Name_Read>;
  update: Maybe<ObservationsFields_Agents_Name_Update>;
};

export type ObservationsFields_Agents_Name_Create = {
  __typename?: 'ObservationsFields_agents_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Name_Delete = {
  __typename?: 'ObservationsFields_agents_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Name_Read = {
  __typename?: 'ObservationsFields_agents_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Name_Update = {
  __typename?: 'ObservationsFields_agents_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Pret = {
  __typename?: 'ObservationsFields_agents_pret';
  create: Maybe<ObservationsFields_Agents_Pret_Create>;
  delete: Maybe<ObservationsFields_Agents_Pret_Delete>;
  read: Maybe<ObservationsFields_Agents_Pret_Read>;
  update: Maybe<ObservationsFields_Agents_Pret_Update>;
};

export type ObservationsFields_Agents_Pret_Create = {
  __typename?: 'ObservationsFields_agents_pret_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Pret_Delete = {
  __typename?: 'ObservationsFields_agents_pret_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Pret_Read = {
  __typename?: 'ObservationsFields_agents_pret_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Pret_Update = {
  __typename?: 'ObservationsFields_agents_pret_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationX = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationX';
  create: Maybe<ObservationsFields_Agents_RelativeAccelerationX_Create>;
  delete: Maybe<ObservationsFields_Agents_RelativeAccelerationX_Delete>;
  read: Maybe<ObservationsFields_Agents_RelativeAccelerationX_Read>;
  update: Maybe<ObservationsFields_Agents_RelativeAccelerationX_Update>;
};

export type ObservationsFields_Agents_RelativeAccelerationX_Create = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationX_Delete = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationX_Read = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationX_Update = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationY = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationY';
  create: Maybe<ObservationsFields_Agents_RelativeAccelerationY_Create>;
  delete: Maybe<ObservationsFields_Agents_RelativeAccelerationY_Delete>;
  read: Maybe<ObservationsFields_Agents_RelativeAccelerationY_Read>;
  update: Maybe<ObservationsFields_Agents_RelativeAccelerationY_Update>;
};

export type ObservationsFields_Agents_RelativeAccelerationY_Create = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationY_Delete = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationY_Read = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeAccelerationY_Update = {
  __typename?: 'ObservationsFields_agents_relativeAccelerationY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeDistance = {
  __typename?: 'ObservationsFields_agents_relativeDistance';
  create: Maybe<ObservationsFields_Agents_RelativeDistance_Create>;
  delete: Maybe<ObservationsFields_Agents_RelativeDistance_Delete>;
  read: Maybe<ObservationsFields_Agents_RelativeDistance_Read>;
  update: Maybe<ObservationsFields_Agents_RelativeDistance_Update>;
};

export type ObservationsFields_Agents_RelativeDistance_Create = {
  __typename?: 'ObservationsFields_agents_relativeDistance_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeDistance_Delete = {
  __typename?: 'ObservationsFields_agents_relativeDistance_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeDistance_Read = {
  __typename?: 'ObservationsFields_agents_relativeDistance_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeDistance_Update = {
  __typename?: 'ObservationsFields_agents_relativeDistance_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityX = {
  __typename?: 'ObservationsFields_agents_relativeVelocityX';
  create: Maybe<ObservationsFields_Agents_RelativeVelocityX_Create>;
  delete: Maybe<ObservationsFields_Agents_RelativeVelocityX_Delete>;
  read: Maybe<ObservationsFields_Agents_RelativeVelocityX_Read>;
  update: Maybe<ObservationsFields_Agents_RelativeVelocityX_Update>;
};

export type ObservationsFields_Agents_RelativeVelocityX_Create = {
  __typename?: 'ObservationsFields_agents_relativeVelocityX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityX_Delete = {
  __typename?: 'ObservationsFields_agents_relativeVelocityX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityX_Read = {
  __typename?: 'ObservationsFields_agents_relativeVelocityX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityX_Update = {
  __typename?: 'ObservationsFields_agents_relativeVelocityX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityY = {
  __typename?: 'ObservationsFields_agents_relativeVelocityY';
  create: Maybe<ObservationsFields_Agents_RelativeVelocityY_Create>;
  delete: Maybe<ObservationsFields_Agents_RelativeVelocityY_Delete>;
  read: Maybe<ObservationsFields_Agents_RelativeVelocityY_Read>;
  update: Maybe<ObservationsFields_Agents_RelativeVelocityY_Update>;
};

export type ObservationsFields_Agents_RelativeVelocityY_Create = {
  __typename?: 'ObservationsFields_agents_relativeVelocityY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityY_Delete = {
  __typename?: 'ObservationsFields_agents_relativeVelocityY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityY_Read = {
  __typename?: 'ObservationsFields_agents_relativeVelocityY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeVelocityY_Update = {
  __typename?: 'ObservationsFields_agents_relativeVelocityY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeYawRate = {
  __typename?: 'ObservationsFields_agents_relativeYawRate';
  create: Maybe<ObservationsFields_Agents_RelativeYawRate_Create>;
  delete: Maybe<ObservationsFields_Agents_RelativeYawRate_Delete>;
  read: Maybe<ObservationsFields_Agents_RelativeYawRate_Read>;
  update: Maybe<ObservationsFields_Agents_RelativeYawRate_Update>;
};

export type ObservationsFields_Agents_RelativeYawRate_Create = {
  __typename?: 'ObservationsFields_agents_relativeYawRate_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeYawRate_Delete = {
  __typename?: 'ObservationsFields_agents_relativeYawRate_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeYawRate_Read = {
  __typename?: 'ObservationsFields_agents_relativeYawRate_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RelativeYawRate_Update = {
  __typename?: 'ObservationsFields_agents_relativeYawRate_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RoadId = {
  __typename?: 'ObservationsFields_agents_roadId';
  create: Maybe<ObservationsFields_Agents_RoadId_Create>;
  delete: Maybe<ObservationsFields_Agents_RoadId_Delete>;
  read: Maybe<ObservationsFields_Agents_RoadId_Read>;
  update: Maybe<ObservationsFields_Agents_RoadId_Update>;
};

export type ObservationsFields_Agents_RoadId_Create = {
  __typename?: 'ObservationsFields_agents_roadId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RoadId_Delete = {
  __typename?: 'ObservationsFields_agents_roadId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RoadId_Read = {
  __typename?: 'ObservationsFields_agents_roadId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RoadId_Update = {
  __typename?: 'ObservationsFields_agents_roadId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RssRatio = {
  __typename?: 'ObservationsFields_agents_rssRatio';
  create: Maybe<ObservationsFields_Agents_RssRatio_Create>;
  delete: Maybe<ObservationsFields_Agents_RssRatio_Delete>;
  read: Maybe<ObservationsFields_Agents_RssRatio_Read>;
  update: Maybe<ObservationsFields_Agents_RssRatio_Update>;
};

export type ObservationsFields_Agents_RssRatio_Create = {
  __typename?: 'ObservationsFields_agents_rssRatio_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RssRatio_Delete = {
  __typename?: 'ObservationsFields_agents_rssRatio_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RssRatio_Read = {
  __typename?: 'ObservationsFields_agents_rssRatio_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_RssRatio_Update = {
  __typename?: 'ObservationsFields_agents_rssRatio_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_S = {
  __typename?: 'ObservationsFields_agents_s';
  create: Maybe<ObservationsFields_Agents_S_Create>;
  delete: Maybe<ObservationsFields_Agents_S_Delete>;
  read: Maybe<ObservationsFields_Agents_S_Read>;
  update: Maybe<ObservationsFields_Agents_S_Update>;
};

export type ObservationsFields_Agents_S_Create = {
  __typename?: 'ObservationsFields_agents_s_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_S_Delete = {
  __typename?: 'ObservationsFields_agents_s_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_S_Read = {
  __typename?: 'ObservationsFields_agents_s_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_S_Update = {
  __typename?: 'ObservationsFields_agents_s_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Speed = {
  __typename?: 'ObservationsFields_agents_speed';
  create: Maybe<ObservationsFields_Agents_Speed_Create>;
  delete: Maybe<ObservationsFields_Agents_Speed_Delete>;
  read: Maybe<ObservationsFields_Agents_Speed_Read>;
  update: Maybe<ObservationsFields_Agents_Speed_Update>;
};

export type ObservationsFields_Agents_Speed_Create = {
  __typename?: 'ObservationsFields_agents_speed_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Speed_Delete = {
  __typename?: 'ObservationsFields_agents_speed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Speed_Read = {
  __typename?: 'ObservationsFields_agents_speed_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Speed_Update = {
  __typename?: 'ObservationsFields_agents_speed_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Spret = {
  __typename?: 'ObservationsFields_agents_spret';
  create: Maybe<ObservationsFields_Agents_Spret_Create>;
  delete: Maybe<ObservationsFields_Agents_Spret_Delete>;
  read: Maybe<ObservationsFields_Agents_Spret_Read>;
  update: Maybe<ObservationsFields_Agents_Spret_Update>;
};

export type ObservationsFields_Agents_Spret_Create = {
  __typename?: 'ObservationsFields_agents_spret_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Spret_Delete = {
  __typename?: 'ObservationsFields_agents_spret_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Spret_Read = {
  __typename?: 'ObservationsFields_agents_spret_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Spret_Update = {
  __typename?: 'ObservationsFields_agents_spret_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_T = {
  __typename?: 'ObservationsFields_agents_t';
  create: Maybe<ObservationsFields_Agents_T_Create>;
  delete: Maybe<ObservationsFields_Agents_T_Delete>;
  read: Maybe<ObservationsFields_Agents_T_Read>;
  update: Maybe<ObservationsFields_Agents_T_Update>;
};

export type ObservationsFields_Agents_T_Create = {
  __typename?: 'ObservationsFields_agents_t_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_T_Delete = {
  __typename?: 'ObservationsFields_agents_t_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_T_Read = {
  __typename?: 'ObservationsFields_agents_t_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_T_Update = {
  __typename?: 'ObservationsFields_agents_t_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttc = {
  __typename?: 'ObservationsFields_agents_ttc';
  create: Maybe<ObservationsFields_Agents_Ttc_Create>;
  delete: Maybe<ObservationsFields_Agents_Ttc_Delete>;
  read: Maybe<ObservationsFields_Agents_Ttc_Read>;
  update: Maybe<ObservationsFields_Agents_Ttc_Update>;
};

export type ObservationsFields_Agents_Ttc_Create = {
  __typename?: 'ObservationsFields_agents_ttc_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttc_Delete = {
  __typename?: 'ObservationsFields_agents_ttc_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttc_Read = {
  __typename?: 'ObservationsFields_agents_ttc_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttc_Update = {
  __typename?: 'ObservationsFields_agents_ttc_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttce = {
  __typename?: 'ObservationsFields_agents_ttce';
  create: Maybe<ObservationsFields_Agents_Ttce_Create>;
  delete: Maybe<ObservationsFields_Agents_Ttce_Delete>;
  read: Maybe<ObservationsFields_Agents_Ttce_Read>;
  update: Maybe<ObservationsFields_Agents_Ttce_Update>;
};

export type ObservationsFields_Agents_Ttce_Create = {
  __typename?: 'ObservationsFields_agents_ttce_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttce_Delete = {
  __typename?: 'ObservationsFields_agents_ttce_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttce_Read = {
  __typename?: 'ObservationsFields_agents_ttce_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Ttce_Update = {
  __typename?: 'ObservationsFields_agents_ttce_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Width = {
  __typename?: 'ObservationsFields_agents_width';
  create: Maybe<ObservationsFields_Agents_Width_Create>;
  delete: Maybe<ObservationsFields_Agents_Width_Delete>;
  read: Maybe<ObservationsFields_Agents_Width_Read>;
  update: Maybe<ObservationsFields_Agents_Width_Update>;
};

export type ObservationsFields_Agents_Width_Create = {
  __typename?: 'ObservationsFields_agents_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Width_Delete = {
  __typename?: 'ObservationsFields_agents_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Width_Read = {
  __typename?: 'ObservationsFields_agents_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Width_Update = {
  __typename?: 'ObservationsFields_agents_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_X = {
  __typename?: 'ObservationsFields_agents_x';
  create: Maybe<ObservationsFields_Agents_X_Create>;
  delete: Maybe<ObservationsFields_Agents_X_Delete>;
  read: Maybe<ObservationsFields_Agents_X_Read>;
  update: Maybe<ObservationsFields_Agents_X_Update>;
};

export type ObservationsFields_Agents_X_Create = {
  __typename?: 'ObservationsFields_agents_x_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_X_Delete = {
  __typename?: 'ObservationsFields_agents_x_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_X_Read = {
  __typename?: 'ObservationsFields_agents_x_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_X_Update = {
  __typename?: 'ObservationsFields_agents_x_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Y = {
  __typename?: 'ObservationsFields_agents_y';
  create: Maybe<ObservationsFields_Agents_Y_Create>;
  delete: Maybe<ObservationsFields_Agents_Y_Delete>;
  read: Maybe<ObservationsFields_Agents_Y_Read>;
  update: Maybe<ObservationsFields_Agents_Y_Update>;
};

export type ObservationsFields_Agents_Y_Create = {
  __typename?: 'ObservationsFields_agents_y_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Y_Delete = {
  __typename?: 'ObservationsFields_agents_y_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Y_Read = {
  __typename?: 'ObservationsFields_agents_y_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Y_Update = {
  __typename?: 'ObservationsFields_agents_y_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Yaw = {
  __typename?: 'ObservationsFields_agents_yaw';
  create: Maybe<ObservationsFields_Agents_Yaw_Create>;
  delete: Maybe<ObservationsFields_Agents_Yaw_Delete>;
  read: Maybe<ObservationsFields_Agents_Yaw_Read>;
  update: Maybe<ObservationsFields_Agents_Yaw_Update>;
};

export type ObservationsFields_Agents_YawRate = {
  __typename?: 'ObservationsFields_agents_yawRate';
  create: Maybe<ObservationsFields_Agents_YawRate_Create>;
  delete: Maybe<ObservationsFields_Agents_YawRate_Delete>;
  read: Maybe<ObservationsFields_Agents_YawRate_Read>;
  update: Maybe<ObservationsFields_Agents_YawRate_Update>;
};

export type ObservationsFields_Agents_YawRate_Create = {
  __typename?: 'ObservationsFields_agents_yawRate_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_YawRate_Delete = {
  __typename?: 'ObservationsFields_agents_yawRate_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_YawRate_Read = {
  __typename?: 'ObservationsFields_agents_yawRate_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_YawRate_Update = {
  __typename?: 'ObservationsFields_agents_yawRate_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Yaw_Create = {
  __typename?: 'ObservationsFields_agents_yaw_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Yaw_Delete = {
  __typename?: 'ObservationsFields_agents_yaw_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Yaw_Read = {
  __typename?: 'ObservationsFields_agents_yaw_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Agents_Yaw_Update = {
  __typename?: 'ObservationsFields_agents_yaw_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_CreatedAt = {
  __typename?: 'ObservationsFields_createdAt';
  create: Maybe<ObservationsFields_CreatedAt_Create>;
  delete: Maybe<ObservationsFields_CreatedAt_Delete>;
  read: Maybe<ObservationsFields_CreatedAt_Read>;
  update: Maybe<ObservationsFields_CreatedAt_Update>;
};

export type ObservationsFields_CreatedAt_Create = {
  __typename?: 'ObservationsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_CreatedAt_Delete = {
  __typename?: 'ObservationsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_CreatedAt_Read = {
  __typename?: 'ObservationsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_CreatedAt_Update = {
  __typename?: 'ObservationsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Ego = {
  __typename?: 'ObservationsFields_ego';
  create: Maybe<ObservationsFields_Ego_Create>;
  delete: Maybe<ObservationsFields_Ego_Delete>;
  read: Maybe<ObservationsFields_Ego_Read>;
  update: Maybe<ObservationsFields_Ego_Update>;
};

export type ObservationsFields_EgoAcceleration = {
  __typename?: 'ObservationsFields_egoAcceleration';
  create: Maybe<ObservationsFields_EgoAcceleration_Create>;
  delete: Maybe<ObservationsFields_EgoAcceleration_Delete>;
  read: Maybe<ObservationsFields_EgoAcceleration_Read>;
  update: Maybe<ObservationsFields_EgoAcceleration_Update>;
};

export type ObservationsFields_EgoAcceleration_Create = {
  __typename?: 'ObservationsFields_egoAcceleration_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoAcceleration_Delete = {
  __typename?: 'ObservationsFields_egoAcceleration_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoAcceleration_Read = {
  __typename?: 'ObservationsFields_egoAcceleration_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoAcceleration_Update = {
  __typename?: 'ObservationsFields_egoAcceleration_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoCurvature = {
  __typename?: 'ObservationsFields_egoCurvature';
  create: Maybe<ObservationsFields_EgoCurvature_Create>;
  delete: Maybe<ObservationsFields_EgoCurvature_Delete>;
  read: Maybe<ObservationsFields_EgoCurvature_Read>;
  update: Maybe<ObservationsFields_EgoCurvature_Update>;
};

export type ObservationsFields_EgoCurvature_Create = {
  __typename?: 'ObservationsFields_egoCurvature_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoCurvature_Delete = {
  __typename?: 'ObservationsFields_egoCurvature_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoCurvature_Read = {
  __typename?: 'ObservationsFields_egoCurvature_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoCurvature_Update = {
  __typename?: 'ObservationsFields_egoCurvature_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoJunctionId = {
  __typename?: 'ObservationsFields_egoJunctionId';
  create: Maybe<ObservationsFields_EgoJunctionId_Create>;
  delete: Maybe<ObservationsFields_EgoJunctionId_Delete>;
  read: Maybe<ObservationsFields_EgoJunctionId_Read>;
  update: Maybe<ObservationsFields_EgoJunctionId_Update>;
};

export type ObservationsFields_EgoJunctionId_Create = {
  __typename?: 'ObservationsFields_egoJunctionId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoJunctionId_Delete = {
  __typename?: 'ObservationsFields_egoJunctionId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoJunctionId_Read = {
  __typename?: 'ObservationsFields_egoJunctionId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoJunctionId_Update = {
  __typename?: 'ObservationsFields_egoJunctionId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneHeading = {
  __typename?: 'ObservationsFields_egoLaneHeading';
  create: Maybe<ObservationsFields_EgoLaneHeading_Create>;
  delete: Maybe<ObservationsFields_EgoLaneHeading_Delete>;
  read: Maybe<ObservationsFields_EgoLaneHeading_Read>;
  update: Maybe<ObservationsFields_EgoLaneHeading_Update>;
};

export type ObservationsFields_EgoLaneHeading_Create = {
  __typename?: 'ObservationsFields_egoLaneHeading_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneHeading_Delete = {
  __typename?: 'ObservationsFields_egoLaneHeading_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneHeading_Read = {
  __typename?: 'ObservationsFields_egoLaneHeading_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneHeading_Update = {
  __typename?: 'ObservationsFields_egoLaneHeading_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneId = {
  __typename?: 'ObservationsFields_egoLaneId';
  create: Maybe<ObservationsFields_EgoLaneId_Create>;
  delete: Maybe<ObservationsFields_EgoLaneId_Delete>;
  read: Maybe<ObservationsFields_EgoLaneId_Read>;
  update: Maybe<ObservationsFields_EgoLaneId_Update>;
};

export type ObservationsFields_EgoLaneId_Create = {
  __typename?: 'ObservationsFields_egoLaneId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneId_Delete = {
  __typename?: 'ObservationsFields_egoLaneId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneId_Read = {
  __typename?: 'ObservationsFields_egoLaneId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneId_Update = {
  __typename?: 'ObservationsFields_egoLaneId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneOffset = {
  __typename?: 'ObservationsFields_egoLaneOffset';
  create: Maybe<ObservationsFields_EgoLaneOffset_Create>;
  delete: Maybe<ObservationsFields_EgoLaneOffset_Delete>;
  read: Maybe<ObservationsFields_EgoLaneOffset_Read>;
  update: Maybe<ObservationsFields_EgoLaneOffset_Update>;
};

export type ObservationsFields_EgoLaneOffset_Create = {
  __typename?: 'ObservationsFields_egoLaneOffset_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneOffset_Delete = {
  __typename?: 'ObservationsFields_egoLaneOffset_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneOffset_Read = {
  __typename?: 'ObservationsFields_egoLaneOffset_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoLaneOffset_Update = {
  __typename?: 'ObservationsFields_egoLaneOffset_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoRoadId = {
  __typename?: 'ObservationsFields_egoRoadId';
  create: Maybe<ObservationsFields_EgoRoadId_Create>;
  delete: Maybe<ObservationsFields_EgoRoadId_Delete>;
  read: Maybe<ObservationsFields_EgoRoadId_Read>;
  update: Maybe<ObservationsFields_EgoRoadId_Update>;
};

export type ObservationsFields_EgoRoadId_Create = {
  __typename?: 'ObservationsFields_egoRoadId_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoRoadId_Delete = {
  __typename?: 'ObservationsFields_egoRoadId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoRoadId_Read = {
  __typename?: 'ObservationsFields_egoRoadId_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoRoadId_Update = {
  __typename?: 'ObservationsFields_egoRoadId_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoS = {
  __typename?: 'ObservationsFields_egoS';
  create: Maybe<ObservationsFields_EgoS_Create>;
  delete: Maybe<ObservationsFields_EgoS_Delete>;
  read: Maybe<ObservationsFields_EgoS_Read>;
  update: Maybe<ObservationsFields_EgoS_Update>;
};

export type ObservationsFields_EgoS_Create = {
  __typename?: 'ObservationsFields_egoS_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoS_Delete = {
  __typename?: 'ObservationsFields_egoS_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoS_Read = {
  __typename?: 'ObservationsFields_egoS_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoS_Update = {
  __typename?: 'ObservationsFields_egoS_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeed = {
  __typename?: 'ObservationsFields_egoSpeed';
  create: Maybe<ObservationsFields_EgoSpeed_Create>;
  delete: Maybe<ObservationsFields_EgoSpeed_Delete>;
  read: Maybe<ObservationsFields_EgoSpeed_Read>;
  update: Maybe<ObservationsFields_EgoSpeed_Update>;
};

export type ObservationsFields_EgoSpeedCmd = {
  __typename?: 'ObservationsFields_egoSpeedCmd';
  create: Maybe<ObservationsFields_EgoSpeedCmd_Create>;
  delete: Maybe<ObservationsFields_EgoSpeedCmd_Delete>;
  read: Maybe<ObservationsFields_EgoSpeedCmd_Read>;
  update: Maybe<ObservationsFields_EgoSpeedCmd_Update>;
};

export type ObservationsFields_EgoSpeedCmd_Create = {
  __typename?: 'ObservationsFields_egoSpeedCmd_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeedCmd_Delete = {
  __typename?: 'ObservationsFields_egoSpeedCmd_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeedCmd_Read = {
  __typename?: 'ObservationsFields_egoSpeedCmd_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeedCmd_Update = {
  __typename?: 'ObservationsFields_egoSpeedCmd_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeed_Create = {
  __typename?: 'ObservationsFields_egoSpeed_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeed_Delete = {
  __typename?: 'ObservationsFields_egoSpeed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeed_Read = {
  __typename?: 'ObservationsFields_egoSpeed_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSpeed_Update = {
  __typename?: 'ObservationsFields_egoSpeed_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSteerCmd = {
  __typename?: 'ObservationsFields_egoSteerCmd';
  create: Maybe<ObservationsFields_EgoSteerCmd_Create>;
  delete: Maybe<ObservationsFields_EgoSteerCmd_Delete>;
  read: Maybe<ObservationsFields_EgoSteerCmd_Read>;
  update: Maybe<ObservationsFields_EgoSteerCmd_Update>;
};

export type ObservationsFields_EgoSteerCmd_Create = {
  __typename?: 'ObservationsFields_egoSteerCmd_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSteerCmd_Delete = {
  __typename?: 'ObservationsFields_egoSteerCmd_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSteerCmd_Read = {
  __typename?: 'ObservationsFields_egoSteerCmd_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoSteerCmd_Update = {
  __typename?: 'ObservationsFields_egoSteerCmd_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoT = {
  __typename?: 'ObservationsFields_egoT';
  create: Maybe<ObservationsFields_EgoT_Create>;
  delete: Maybe<ObservationsFields_EgoT_Delete>;
  read: Maybe<ObservationsFields_EgoT_Read>;
  update: Maybe<ObservationsFields_EgoT_Update>;
};

export type ObservationsFields_EgoT_Create = {
  __typename?: 'ObservationsFields_egoT_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoT_Delete = {
  __typename?: 'ObservationsFields_egoT_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoT_Read = {
  __typename?: 'ObservationsFields_egoT_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoT_Update = {
  __typename?: 'ObservationsFields_egoT_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoX = {
  __typename?: 'ObservationsFields_egoX';
  create: Maybe<ObservationsFields_EgoX_Create>;
  delete: Maybe<ObservationsFields_EgoX_Delete>;
  read: Maybe<ObservationsFields_EgoX_Read>;
  update: Maybe<ObservationsFields_EgoX_Update>;
};

export type ObservationsFields_EgoX_Create = {
  __typename?: 'ObservationsFields_egoX_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoX_Delete = {
  __typename?: 'ObservationsFields_egoX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoX_Read = {
  __typename?: 'ObservationsFields_egoX_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoX_Update = {
  __typename?: 'ObservationsFields_egoX_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoY = {
  __typename?: 'ObservationsFields_egoY';
  create: Maybe<ObservationsFields_EgoY_Create>;
  delete: Maybe<ObservationsFields_EgoY_Delete>;
  read: Maybe<ObservationsFields_EgoY_Read>;
  update: Maybe<ObservationsFields_EgoY_Update>;
};

export type ObservationsFields_EgoY_Create = {
  __typename?: 'ObservationsFields_egoY_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoY_Delete = {
  __typename?: 'ObservationsFields_egoY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoY_Read = {
  __typename?: 'ObservationsFields_egoY_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoY_Update = {
  __typename?: 'ObservationsFields_egoY_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYaw = {
  __typename?: 'ObservationsFields_egoYaw';
  create: Maybe<ObservationsFields_EgoYaw_Create>;
  delete: Maybe<ObservationsFields_EgoYaw_Delete>;
  read: Maybe<ObservationsFields_EgoYaw_Read>;
  update: Maybe<ObservationsFields_EgoYaw_Update>;
};

export type ObservationsFields_EgoYawRate = {
  __typename?: 'ObservationsFields_egoYawRate';
  create: Maybe<ObservationsFields_EgoYawRate_Create>;
  delete: Maybe<ObservationsFields_EgoYawRate_Delete>;
  read: Maybe<ObservationsFields_EgoYawRate_Read>;
  update: Maybe<ObservationsFields_EgoYawRate_Update>;
};

export type ObservationsFields_EgoYawRate_Create = {
  __typename?: 'ObservationsFields_egoYawRate_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYawRate_Delete = {
  __typename?: 'ObservationsFields_egoYawRate_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYawRate_Read = {
  __typename?: 'ObservationsFields_egoYawRate_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYawRate_Update = {
  __typename?: 'ObservationsFields_egoYawRate_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYaw_Create = {
  __typename?: 'ObservationsFields_egoYaw_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYaw_Delete = {
  __typename?: 'ObservationsFields_egoYaw_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYaw_Read = {
  __typename?: 'ObservationsFields_egoYaw_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EgoYaw_Update = {
  __typename?: 'ObservationsFields_egoYaw_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Ego_Create = {
  __typename?: 'ObservationsFields_ego_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Ego_Delete = {
  __typename?: 'ObservationsFields_ego_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Ego_Read = {
  __typename?: 'ObservationsFields_ego_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Ego_Update = {
  __typename?: 'ObservationsFields_ego_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EsminiSeconds = {
  __typename?: 'ObservationsFields_esminiSeconds';
  create: Maybe<ObservationsFields_EsminiSeconds_Create>;
  delete: Maybe<ObservationsFields_EsminiSeconds_Delete>;
  read: Maybe<ObservationsFields_EsminiSeconds_Read>;
  update: Maybe<ObservationsFields_EsminiSeconds_Update>;
};

export type ObservationsFields_EsminiSeconds_Create = {
  __typename?: 'ObservationsFields_esminiSeconds_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EsminiSeconds_Delete = {
  __typename?: 'ObservationsFields_esminiSeconds_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EsminiSeconds_Read = {
  __typename?: 'ObservationsFields_esminiSeconds_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_EsminiSeconds_Update = {
  __typename?: 'ObservationsFields_esminiSeconds_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Time = {
  __typename?: 'ObservationsFields_time';
  create: Maybe<ObservationsFields_Time_Create>;
  delete: Maybe<ObservationsFields_Time_Delete>;
  read: Maybe<ObservationsFields_Time_Read>;
  update: Maybe<ObservationsFields_Time_Update>;
};

export type ObservationsFields_Time_Create = {
  __typename?: 'ObservationsFields_time_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Time_Delete = {
  __typename?: 'ObservationsFields_time_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Time_Read = {
  __typename?: 'ObservationsFields_time_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Time_Update = {
  __typename?: 'ObservationsFields_time_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Trial = {
  __typename?: 'ObservationsFields_trial';
  create: Maybe<ObservationsFields_Trial_Create>;
  delete: Maybe<ObservationsFields_Trial_Delete>;
  read: Maybe<ObservationsFields_Trial_Read>;
  update: Maybe<ObservationsFields_Trial_Update>;
};

export type ObservationsFields_Trial_Create = {
  __typename?: 'ObservationsFields_trial_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Trial_Delete = {
  __typename?: 'ObservationsFields_trial_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Trial_Read = {
  __typename?: 'ObservationsFields_trial_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_Trial_Update = {
  __typename?: 'ObservationsFields_trial_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_UpdatedAt = {
  __typename?: 'ObservationsFields_updatedAt';
  create: Maybe<ObservationsFields_UpdatedAt_Create>;
  delete: Maybe<ObservationsFields_UpdatedAt_Delete>;
  read: Maybe<ObservationsFields_UpdatedAt_Read>;
  update: Maybe<ObservationsFields_UpdatedAt_Update>;
};

export type ObservationsFields_UpdatedAt_Create = {
  __typename?: 'ObservationsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_UpdatedAt_Delete = {
  __typename?: 'ObservationsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_UpdatedAt_Read = {
  __typename?: 'ObservationsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsFields_UpdatedAt_Update = {
  __typename?: 'ObservationsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ObservationsReadAccess = {
  __typename?: 'ObservationsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ObservationsReadDocAccess = {
  __typename?: 'ObservationsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ObservationsUpdateAccess = {
  __typename?: 'ObservationsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ObservationsUpdateDocAccess = {
  __typename?: 'ObservationsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrive = {
  __typename?: 'OpenDrive';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  focalX: Maybe<Scalars['Float']['output']>;
  focalY: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  id: Scalars['Int']['output'];
  mimeType: Maybe<Scalars['String']['output']>;
  thumbnailURL: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type OpenDrive_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type OpenDrive_Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenDrive_Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenDrive_FocalX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenDrive_FocalY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenDrive_Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenDrive_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type OpenDrive_MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenDrive_ThumbnailUrl_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenDrive_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type OpenDrive_Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenDrive_Where = {
  AND: InputMaybe<Array<InputMaybe<OpenDrive_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<OpenDrive_Where_Or>>>;
  createdAt: InputMaybe<OpenDrive_CreatedAt_Operator>;
  filename: InputMaybe<OpenDrive_Filename_Operator>;
  filesize: InputMaybe<OpenDrive_Filesize_Operator>;
  focalX: InputMaybe<OpenDrive_FocalX_Operator>;
  focalY: InputMaybe<OpenDrive_FocalY_Operator>;
  height: InputMaybe<OpenDrive_Height_Operator>;
  id: InputMaybe<OpenDrive_Id_Operator>;
  mimeType: InputMaybe<OpenDrive_MimeType_Operator>;
  thumbnailURL: InputMaybe<OpenDrive_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<OpenDrive_UpdatedAt_Operator>;
  url: InputMaybe<OpenDrive_Url_Operator>;
  width: InputMaybe<OpenDrive_Width_Operator>;
};

export type OpenDrive_Where_And = {
  AND: InputMaybe<Array<InputMaybe<OpenDrive_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<OpenDrive_Where_Or>>>;
  createdAt: InputMaybe<OpenDrive_CreatedAt_Operator>;
  filename: InputMaybe<OpenDrive_Filename_Operator>;
  filesize: InputMaybe<OpenDrive_Filesize_Operator>;
  focalX: InputMaybe<OpenDrive_FocalX_Operator>;
  focalY: InputMaybe<OpenDrive_FocalY_Operator>;
  height: InputMaybe<OpenDrive_Height_Operator>;
  id: InputMaybe<OpenDrive_Id_Operator>;
  mimeType: InputMaybe<OpenDrive_MimeType_Operator>;
  thumbnailURL: InputMaybe<OpenDrive_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<OpenDrive_UpdatedAt_Operator>;
  url: InputMaybe<OpenDrive_Url_Operator>;
  width: InputMaybe<OpenDrive_Width_Operator>;
};

export type OpenDrive_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<OpenDrive_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<OpenDrive_Where_Or>>>;
  createdAt: InputMaybe<OpenDrive_CreatedAt_Operator>;
  filename: InputMaybe<OpenDrive_Filename_Operator>;
  filesize: InputMaybe<OpenDrive_Filesize_Operator>;
  focalX: InputMaybe<OpenDrive_FocalX_Operator>;
  focalY: InputMaybe<OpenDrive_FocalY_Operator>;
  height: InputMaybe<OpenDrive_Height_Operator>;
  id: InputMaybe<OpenDrive_Id_Operator>;
  mimeType: InputMaybe<OpenDrive_MimeType_Operator>;
  thumbnailURL: InputMaybe<OpenDrive_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<OpenDrive_UpdatedAt_Operator>;
  url: InputMaybe<OpenDrive_Url_Operator>;
  width: InputMaybe<OpenDrive_Width_Operator>;
};

export type OpenDrive_Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenDrives = {
  __typename?: 'OpenDrives';
  docs: Array<OpenDrive>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type OpenDrivesCreateAccess = {
  __typename?: 'OpenDrivesCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrivesCreateDocAccess = {
  __typename?: 'OpenDrivesCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrivesDeleteAccess = {
  __typename?: 'OpenDrivesDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrivesDeleteDocAccess = {
  __typename?: 'OpenDrivesDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrivesDocAccessFields = {
  __typename?: 'OpenDrivesDocAccessFields';
  createdAt: Maybe<OpenDrivesDocAccessFields_CreatedAt>;
  filename: Maybe<OpenDrivesDocAccessFields_Filename>;
  filesize: Maybe<OpenDrivesDocAccessFields_Filesize>;
  focalX: Maybe<OpenDrivesDocAccessFields_FocalX>;
  focalY: Maybe<OpenDrivesDocAccessFields_FocalY>;
  height: Maybe<OpenDrivesDocAccessFields_Height>;
  mimeType: Maybe<OpenDrivesDocAccessFields_MimeType>;
  thumbnailURL: Maybe<OpenDrivesDocAccessFields_ThumbnailUrl>;
  updatedAt: Maybe<OpenDrivesDocAccessFields_UpdatedAt>;
  url: Maybe<OpenDrivesDocAccessFields_Url>;
  width: Maybe<OpenDrivesDocAccessFields_Width>;
};

export type OpenDrivesDocAccessFields_CreatedAt = {
  __typename?: 'OpenDrivesDocAccessFields_createdAt';
  create: Maybe<OpenDrivesDocAccessFields_CreatedAt_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_CreatedAt_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_CreatedAt_Read>;
  update: Maybe<OpenDrivesDocAccessFields_CreatedAt_Update>;
};

export type OpenDrivesDocAccessFields_CreatedAt_Create = {
  __typename?: 'OpenDrivesDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_CreatedAt_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_CreatedAt_Read = {
  __typename?: 'OpenDrivesDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_CreatedAt_Update = {
  __typename?: 'OpenDrivesDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filename = {
  __typename?: 'OpenDrivesDocAccessFields_filename';
  create: Maybe<OpenDrivesDocAccessFields_Filename_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_Filename_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_Filename_Read>;
  update: Maybe<OpenDrivesDocAccessFields_Filename_Update>;
};

export type OpenDrivesDocAccessFields_Filename_Create = {
  __typename?: 'OpenDrivesDocAccessFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filename_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filename_Read = {
  __typename?: 'OpenDrivesDocAccessFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filename_Update = {
  __typename?: 'OpenDrivesDocAccessFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filesize = {
  __typename?: 'OpenDrivesDocAccessFields_filesize';
  create: Maybe<OpenDrivesDocAccessFields_Filesize_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_Filesize_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_Filesize_Read>;
  update: Maybe<OpenDrivesDocAccessFields_Filesize_Update>;
};

export type OpenDrivesDocAccessFields_Filesize_Create = {
  __typename?: 'OpenDrivesDocAccessFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filesize_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filesize_Read = {
  __typename?: 'OpenDrivesDocAccessFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Filesize_Update = {
  __typename?: 'OpenDrivesDocAccessFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalX = {
  __typename?: 'OpenDrivesDocAccessFields_focalX';
  create: Maybe<OpenDrivesDocAccessFields_FocalX_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_FocalX_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_FocalX_Read>;
  update: Maybe<OpenDrivesDocAccessFields_FocalX_Update>;
};

export type OpenDrivesDocAccessFields_FocalX_Create = {
  __typename?: 'OpenDrivesDocAccessFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalX_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalX_Read = {
  __typename?: 'OpenDrivesDocAccessFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalX_Update = {
  __typename?: 'OpenDrivesDocAccessFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalY = {
  __typename?: 'OpenDrivesDocAccessFields_focalY';
  create: Maybe<OpenDrivesDocAccessFields_FocalY_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_FocalY_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_FocalY_Read>;
  update: Maybe<OpenDrivesDocAccessFields_FocalY_Update>;
};

export type OpenDrivesDocAccessFields_FocalY_Create = {
  __typename?: 'OpenDrivesDocAccessFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalY_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalY_Read = {
  __typename?: 'OpenDrivesDocAccessFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_FocalY_Update = {
  __typename?: 'OpenDrivesDocAccessFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Height = {
  __typename?: 'OpenDrivesDocAccessFields_height';
  create: Maybe<OpenDrivesDocAccessFields_Height_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_Height_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_Height_Read>;
  update: Maybe<OpenDrivesDocAccessFields_Height_Update>;
};

export type OpenDrivesDocAccessFields_Height_Create = {
  __typename?: 'OpenDrivesDocAccessFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Height_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Height_Read = {
  __typename?: 'OpenDrivesDocAccessFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Height_Update = {
  __typename?: 'OpenDrivesDocAccessFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_MimeType = {
  __typename?: 'OpenDrivesDocAccessFields_mimeType';
  create: Maybe<OpenDrivesDocAccessFields_MimeType_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_MimeType_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_MimeType_Read>;
  update: Maybe<OpenDrivesDocAccessFields_MimeType_Update>;
};

export type OpenDrivesDocAccessFields_MimeType_Create = {
  __typename?: 'OpenDrivesDocAccessFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_MimeType_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_MimeType_Read = {
  __typename?: 'OpenDrivesDocAccessFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_MimeType_Update = {
  __typename?: 'OpenDrivesDocAccessFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_ThumbnailUrl = {
  __typename?: 'OpenDrivesDocAccessFields_thumbnailURL';
  create: Maybe<OpenDrivesDocAccessFields_ThumbnailUrl_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_ThumbnailUrl_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_ThumbnailUrl_Read>;
  update: Maybe<OpenDrivesDocAccessFields_ThumbnailUrl_Update>;
};

export type OpenDrivesDocAccessFields_ThumbnailUrl_Create = {
  __typename?: 'OpenDrivesDocAccessFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_ThumbnailUrl_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_ThumbnailUrl_Read = {
  __typename?: 'OpenDrivesDocAccessFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_ThumbnailUrl_Update = {
  __typename?: 'OpenDrivesDocAccessFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_UpdatedAt = {
  __typename?: 'OpenDrivesDocAccessFields_updatedAt';
  create: Maybe<OpenDrivesDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_UpdatedAt_Read>;
  update: Maybe<OpenDrivesDocAccessFields_UpdatedAt_Update>;
};

export type OpenDrivesDocAccessFields_UpdatedAt_Create = {
  __typename?: 'OpenDrivesDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_UpdatedAt_Read = {
  __typename?: 'OpenDrivesDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_UpdatedAt_Update = {
  __typename?: 'OpenDrivesDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Url = {
  __typename?: 'OpenDrivesDocAccessFields_url';
  create: Maybe<OpenDrivesDocAccessFields_Url_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_Url_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_Url_Read>;
  update: Maybe<OpenDrivesDocAccessFields_Url_Update>;
};

export type OpenDrivesDocAccessFields_Url_Create = {
  __typename?: 'OpenDrivesDocAccessFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Url_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Url_Read = {
  __typename?: 'OpenDrivesDocAccessFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Url_Update = {
  __typename?: 'OpenDrivesDocAccessFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Width = {
  __typename?: 'OpenDrivesDocAccessFields_width';
  create: Maybe<OpenDrivesDocAccessFields_Width_Create>;
  delete: Maybe<OpenDrivesDocAccessFields_Width_Delete>;
  read: Maybe<OpenDrivesDocAccessFields_Width_Read>;
  update: Maybe<OpenDrivesDocAccessFields_Width_Update>;
};

export type OpenDrivesDocAccessFields_Width_Create = {
  __typename?: 'OpenDrivesDocAccessFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Width_Delete = {
  __typename?: 'OpenDrivesDocAccessFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Width_Read = {
  __typename?: 'OpenDrivesDocAccessFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesDocAccessFields_Width_Update = {
  __typename?: 'OpenDrivesDocAccessFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields = {
  __typename?: 'OpenDrivesFields';
  createdAt: Maybe<OpenDrivesFields_CreatedAt>;
  filename: Maybe<OpenDrivesFields_Filename>;
  filesize: Maybe<OpenDrivesFields_Filesize>;
  focalX: Maybe<OpenDrivesFields_FocalX>;
  focalY: Maybe<OpenDrivesFields_FocalY>;
  height: Maybe<OpenDrivesFields_Height>;
  mimeType: Maybe<OpenDrivesFields_MimeType>;
  thumbnailURL: Maybe<OpenDrivesFields_ThumbnailUrl>;
  updatedAt: Maybe<OpenDrivesFields_UpdatedAt>;
  url: Maybe<OpenDrivesFields_Url>;
  width: Maybe<OpenDrivesFields_Width>;
};

export type OpenDrivesFields_CreatedAt = {
  __typename?: 'OpenDrivesFields_createdAt';
  create: Maybe<OpenDrivesFields_CreatedAt_Create>;
  delete: Maybe<OpenDrivesFields_CreatedAt_Delete>;
  read: Maybe<OpenDrivesFields_CreatedAt_Read>;
  update: Maybe<OpenDrivesFields_CreatedAt_Update>;
};

export type OpenDrivesFields_CreatedAt_Create = {
  __typename?: 'OpenDrivesFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_CreatedAt_Delete = {
  __typename?: 'OpenDrivesFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_CreatedAt_Read = {
  __typename?: 'OpenDrivesFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_CreatedAt_Update = {
  __typename?: 'OpenDrivesFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filename = {
  __typename?: 'OpenDrivesFields_filename';
  create: Maybe<OpenDrivesFields_Filename_Create>;
  delete: Maybe<OpenDrivesFields_Filename_Delete>;
  read: Maybe<OpenDrivesFields_Filename_Read>;
  update: Maybe<OpenDrivesFields_Filename_Update>;
};

export type OpenDrivesFields_Filename_Create = {
  __typename?: 'OpenDrivesFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filename_Delete = {
  __typename?: 'OpenDrivesFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filename_Read = {
  __typename?: 'OpenDrivesFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filename_Update = {
  __typename?: 'OpenDrivesFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filesize = {
  __typename?: 'OpenDrivesFields_filesize';
  create: Maybe<OpenDrivesFields_Filesize_Create>;
  delete: Maybe<OpenDrivesFields_Filesize_Delete>;
  read: Maybe<OpenDrivesFields_Filesize_Read>;
  update: Maybe<OpenDrivesFields_Filesize_Update>;
};

export type OpenDrivesFields_Filesize_Create = {
  __typename?: 'OpenDrivesFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filesize_Delete = {
  __typename?: 'OpenDrivesFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filesize_Read = {
  __typename?: 'OpenDrivesFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Filesize_Update = {
  __typename?: 'OpenDrivesFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalX = {
  __typename?: 'OpenDrivesFields_focalX';
  create: Maybe<OpenDrivesFields_FocalX_Create>;
  delete: Maybe<OpenDrivesFields_FocalX_Delete>;
  read: Maybe<OpenDrivesFields_FocalX_Read>;
  update: Maybe<OpenDrivesFields_FocalX_Update>;
};

export type OpenDrivesFields_FocalX_Create = {
  __typename?: 'OpenDrivesFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalX_Delete = {
  __typename?: 'OpenDrivesFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalX_Read = {
  __typename?: 'OpenDrivesFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalX_Update = {
  __typename?: 'OpenDrivesFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalY = {
  __typename?: 'OpenDrivesFields_focalY';
  create: Maybe<OpenDrivesFields_FocalY_Create>;
  delete: Maybe<OpenDrivesFields_FocalY_Delete>;
  read: Maybe<OpenDrivesFields_FocalY_Read>;
  update: Maybe<OpenDrivesFields_FocalY_Update>;
};

export type OpenDrivesFields_FocalY_Create = {
  __typename?: 'OpenDrivesFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalY_Delete = {
  __typename?: 'OpenDrivesFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalY_Read = {
  __typename?: 'OpenDrivesFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_FocalY_Update = {
  __typename?: 'OpenDrivesFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Height = {
  __typename?: 'OpenDrivesFields_height';
  create: Maybe<OpenDrivesFields_Height_Create>;
  delete: Maybe<OpenDrivesFields_Height_Delete>;
  read: Maybe<OpenDrivesFields_Height_Read>;
  update: Maybe<OpenDrivesFields_Height_Update>;
};

export type OpenDrivesFields_Height_Create = {
  __typename?: 'OpenDrivesFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Height_Delete = {
  __typename?: 'OpenDrivesFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Height_Read = {
  __typename?: 'OpenDrivesFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Height_Update = {
  __typename?: 'OpenDrivesFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_MimeType = {
  __typename?: 'OpenDrivesFields_mimeType';
  create: Maybe<OpenDrivesFields_MimeType_Create>;
  delete: Maybe<OpenDrivesFields_MimeType_Delete>;
  read: Maybe<OpenDrivesFields_MimeType_Read>;
  update: Maybe<OpenDrivesFields_MimeType_Update>;
};

export type OpenDrivesFields_MimeType_Create = {
  __typename?: 'OpenDrivesFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_MimeType_Delete = {
  __typename?: 'OpenDrivesFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_MimeType_Read = {
  __typename?: 'OpenDrivesFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_MimeType_Update = {
  __typename?: 'OpenDrivesFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_ThumbnailUrl = {
  __typename?: 'OpenDrivesFields_thumbnailURL';
  create: Maybe<OpenDrivesFields_ThumbnailUrl_Create>;
  delete: Maybe<OpenDrivesFields_ThumbnailUrl_Delete>;
  read: Maybe<OpenDrivesFields_ThumbnailUrl_Read>;
  update: Maybe<OpenDrivesFields_ThumbnailUrl_Update>;
};

export type OpenDrivesFields_ThumbnailUrl_Create = {
  __typename?: 'OpenDrivesFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_ThumbnailUrl_Delete = {
  __typename?: 'OpenDrivesFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_ThumbnailUrl_Read = {
  __typename?: 'OpenDrivesFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_ThumbnailUrl_Update = {
  __typename?: 'OpenDrivesFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_UpdatedAt = {
  __typename?: 'OpenDrivesFields_updatedAt';
  create: Maybe<OpenDrivesFields_UpdatedAt_Create>;
  delete: Maybe<OpenDrivesFields_UpdatedAt_Delete>;
  read: Maybe<OpenDrivesFields_UpdatedAt_Read>;
  update: Maybe<OpenDrivesFields_UpdatedAt_Update>;
};

export type OpenDrivesFields_UpdatedAt_Create = {
  __typename?: 'OpenDrivesFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_UpdatedAt_Delete = {
  __typename?: 'OpenDrivesFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_UpdatedAt_Read = {
  __typename?: 'OpenDrivesFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_UpdatedAt_Update = {
  __typename?: 'OpenDrivesFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Url = {
  __typename?: 'OpenDrivesFields_url';
  create: Maybe<OpenDrivesFields_Url_Create>;
  delete: Maybe<OpenDrivesFields_Url_Delete>;
  read: Maybe<OpenDrivesFields_Url_Read>;
  update: Maybe<OpenDrivesFields_Url_Update>;
};

export type OpenDrivesFields_Url_Create = {
  __typename?: 'OpenDrivesFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Url_Delete = {
  __typename?: 'OpenDrivesFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Url_Read = {
  __typename?: 'OpenDrivesFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Url_Update = {
  __typename?: 'OpenDrivesFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Width = {
  __typename?: 'OpenDrivesFields_width';
  create: Maybe<OpenDrivesFields_Width_Create>;
  delete: Maybe<OpenDrivesFields_Width_Delete>;
  read: Maybe<OpenDrivesFields_Width_Read>;
  update: Maybe<OpenDrivesFields_Width_Update>;
};

export type OpenDrivesFields_Width_Create = {
  __typename?: 'OpenDrivesFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Width_Delete = {
  __typename?: 'OpenDrivesFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Width_Read = {
  __typename?: 'OpenDrivesFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesFields_Width_Update = {
  __typename?: 'OpenDrivesFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenDrivesReadAccess = {
  __typename?: 'OpenDrivesReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrivesReadDocAccess = {
  __typename?: 'OpenDrivesReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrivesUpdateAccess = {
  __typename?: 'OpenDrivesUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenDrivesUpdateDocAccess = {
  __typename?: 'OpenDrivesUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenario = {
  __typename?: 'OpenScenario';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  filename: Maybe<Scalars['String']['output']>;
  filesize: Maybe<Scalars['Float']['output']>;
  focalX: Maybe<Scalars['Float']['output']>;
  focalY: Maybe<Scalars['Float']['output']>;
  height: Maybe<Scalars['Float']['output']>;
  id: Scalars['Int']['output'];
  mimeType: Maybe<Scalars['String']['output']>;
  thumbnailURL: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  url: Maybe<Scalars['String']['output']>;
  width: Maybe<Scalars['Float']['output']>;
};

export type OpenScenario_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type OpenScenario_Filename_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenScenario_Filesize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenScenario_FocalX_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenScenario_FocalY_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenScenario_Height_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenScenario_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type OpenScenario_MimeType_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenScenario_ThumbnailUrl_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenScenario_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type OpenScenario_Url_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type OpenScenario_Where = {
  AND: InputMaybe<Array<InputMaybe<OpenScenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<OpenScenario_Where_Or>>>;
  createdAt: InputMaybe<OpenScenario_CreatedAt_Operator>;
  filename: InputMaybe<OpenScenario_Filename_Operator>;
  filesize: InputMaybe<OpenScenario_Filesize_Operator>;
  focalX: InputMaybe<OpenScenario_FocalX_Operator>;
  focalY: InputMaybe<OpenScenario_FocalY_Operator>;
  height: InputMaybe<OpenScenario_Height_Operator>;
  id: InputMaybe<OpenScenario_Id_Operator>;
  mimeType: InputMaybe<OpenScenario_MimeType_Operator>;
  thumbnailURL: InputMaybe<OpenScenario_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<OpenScenario_UpdatedAt_Operator>;
  url: InputMaybe<OpenScenario_Url_Operator>;
  width: InputMaybe<OpenScenario_Width_Operator>;
};

export type OpenScenario_Where_And = {
  AND: InputMaybe<Array<InputMaybe<OpenScenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<OpenScenario_Where_Or>>>;
  createdAt: InputMaybe<OpenScenario_CreatedAt_Operator>;
  filename: InputMaybe<OpenScenario_Filename_Operator>;
  filesize: InputMaybe<OpenScenario_Filesize_Operator>;
  focalX: InputMaybe<OpenScenario_FocalX_Operator>;
  focalY: InputMaybe<OpenScenario_FocalY_Operator>;
  height: InputMaybe<OpenScenario_Height_Operator>;
  id: InputMaybe<OpenScenario_Id_Operator>;
  mimeType: InputMaybe<OpenScenario_MimeType_Operator>;
  thumbnailURL: InputMaybe<OpenScenario_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<OpenScenario_UpdatedAt_Operator>;
  url: InputMaybe<OpenScenario_Url_Operator>;
  width: InputMaybe<OpenScenario_Width_Operator>;
};

export type OpenScenario_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<OpenScenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<OpenScenario_Where_Or>>>;
  createdAt: InputMaybe<OpenScenario_CreatedAt_Operator>;
  filename: InputMaybe<OpenScenario_Filename_Operator>;
  filesize: InputMaybe<OpenScenario_Filesize_Operator>;
  focalX: InputMaybe<OpenScenario_FocalX_Operator>;
  focalY: InputMaybe<OpenScenario_FocalY_Operator>;
  height: InputMaybe<OpenScenario_Height_Operator>;
  id: InputMaybe<OpenScenario_Id_Operator>;
  mimeType: InputMaybe<OpenScenario_MimeType_Operator>;
  thumbnailURL: InputMaybe<OpenScenario_ThumbnailUrl_Operator>;
  updatedAt: InputMaybe<OpenScenario_UpdatedAt_Operator>;
  url: InputMaybe<OpenScenario_Url_Operator>;
  width: InputMaybe<OpenScenario_Width_Operator>;
};

export type OpenScenario_Width_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type OpenScenarios = {
  __typename?: 'OpenScenarios';
  docs: Array<OpenScenario>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type OpenScenariosCreateAccess = {
  __typename?: 'OpenScenariosCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenariosCreateDocAccess = {
  __typename?: 'OpenScenariosCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenariosDeleteAccess = {
  __typename?: 'OpenScenariosDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenariosDeleteDocAccess = {
  __typename?: 'OpenScenariosDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenariosDocAccessFields = {
  __typename?: 'OpenScenariosDocAccessFields';
  createdAt: Maybe<OpenScenariosDocAccessFields_CreatedAt>;
  filename: Maybe<OpenScenariosDocAccessFields_Filename>;
  filesize: Maybe<OpenScenariosDocAccessFields_Filesize>;
  focalX: Maybe<OpenScenariosDocAccessFields_FocalX>;
  focalY: Maybe<OpenScenariosDocAccessFields_FocalY>;
  height: Maybe<OpenScenariosDocAccessFields_Height>;
  mimeType: Maybe<OpenScenariosDocAccessFields_MimeType>;
  thumbnailURL: Maybe<OpenScenariosDocAccessFields_ThumbnailUrl>;
  updatedAt: Maybe<OpenScenariosDocAccessFields_UpdatedAt>;
  url: Maybe<OpenScenariosDocAccessFields_Url>;
  width: Maybe<OpenScenariosDocAccessFields_Width>;
};

export type OpenScenariosDocAccessFields_CreatedAt = {
  __typename?: 'OpenScenariosDocAccessFields_createdAt';
  create: Maybe<OpenScenariosDocAccessFields_CreatedAt_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_CreatedAt_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_CreatedAt_Read>;
  update: Maybe<OpenScenariosDocAccessFields_CreatedAt_Update>;
};

export type OpenScenariosDocAccessFields_CreatedAt_Create = {
  __typename?: 'OpenScenariosDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_CreatedAt_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_CreatedAt_Read = {
  __typename?: 'OpenScenariosDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_CreatedAt_Update = {
  __typename?: 'OpenScenariosDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filename = {
  __typename?: 'OpenScenariosDocAccessFields_filename';
  create: Maybe<OpenScenariosDocAccessFields_Filename_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_Filename_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_Filename_Read>;
  update: Maybe<OpenScenariosDocAccessFields_Filename_Update>;
};

export type OpenScenariosDocAccessFields_Filename_Create = {
  __typename?: 'OpenScenariosDocAccessFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filename_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filename_Read = {
  __typename?: 'OpenScenariosDocAccessFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filename_Update = {
  __typename?: 'OpenScenariosDocAccessFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filesize = {
  __typename?: 'OpenScenariosDocAccessFields_filesize';
  create: Maybe<OpenScenariosDocAccessFields_Filesize_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_Filesize_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_Filesize_Read>;
  update: Maybe<OpenScenariosDocAccessFields_Filesize_Update>;
};

export type OpenScenariosDocAccessFields_Filesize_Create = {
  __typename?: 'OpenScenariosDocAccessFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filesize_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filesize_Read = {
  __typename?: 'OpenScenariosDocAccessFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Filesize_Update = {
  __typename?: 'OpenScenariosDocAccessFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalX = {
  __typename?: 'OpenScenariosDocAccessFields_focalX';
  create: Maybe<OpenScenariosDocAccessFields_FocalX_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_FocalX_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_FocalX_Read>;
  update: Maybe<OpenScenariosDocAccessFields_FocalX_Update>;
};

export type OpenScenariosDocAccessFields_FocalX_Create = {
  __typename?: 'OpenScenariosDocAccessFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalX_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalX_Read = {
  __typename?: 'OpenScenariosDocAccessFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalX_Update = {
  __typename?: 'OpenScenariosDocAccessFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalY = {
  __typename?: 'OpenScenariosDocAccessFields_focalY';
  create: Maybe<OpenScenariosDocAccessFields_FocalY_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_FocalY_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_FocalY_Read>;
  update: Maybe<OpenScenariosDocAccessFields_FocalY_Update>;
};

export type OpenScenariosDocAccessFields_FocalY_Create = {
  __typename?: 'OpenScenariosDocAccessFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalY_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalY_Read = {
  __typename?: 'OpenScenariosDocAccessFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_FocalY_Update = {
  __typename?: 'OpenScenariosDocAccessFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Height = {
  __typename?: 'OpenScenariosDocAccessFields_height';
  create: Maybe<OpenScenariosDocAccessFields_Height_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_Height_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_Height_Read>;
  update: Maybe<OpenScenariosDocAccessFields_Height_Update>;
};

export type OpenScenariosDocAccessFields_Height_Create = {
  __typename?: 'OpenScenariosDocAccessFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Height_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Height_Read = {
  __typename?: 'OpenScenariosDocAccessFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Height_Update = {
  __typename?: 'OpenScenariosDocAccessFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_MimeType = {
  __typename?: 'OpenScenariosDocAccessFields_mimeType';
  create: Maybe<OpenScenariosDocAccessFields_MimeType_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_MimeType_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_MimeType_Read>;
  update: Maybe<OpenScenariosDocAccessFields_MimeType_Update>;
};

export type OpenScenariosDocAccessFields_MimeType_Create = {
  __typename?: 'OpenScenariosDocAccessFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_MimeType_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_MimeType_Read = {
  __typename?: 'OpenScenariosDocAccessFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_MimeType_Update = {
  __typename?: 'OpenScenariosDocAccessFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_ThumbnailUrl = {
  __typename?: 'OpenScenariosDocAccessFields_thumbnailURL';
  create: Maybe<OpenScenariosDocAccessFields_ThumbnailUrl_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_ThumbnailUrl_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_ThumbnailUrl_Read>;
  update: Maybe<OpenScenariosDocAccessFields_ThumbnailUrl_Update>;
};

export type OpenScenariosDocAccessFields_ThumbnailUrl_Create = {
  __typename?: 'OpenScenariosDocAccessFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_ThumbnailUrl_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_ThumbnailUrl_Read = {
  __typename?: 'OpenScenariosDocAccessFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_ThumbnailUrl_Update = {
  __typename?: 'OpenScenariosDocAccessFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_UpdatedAt = {
  __typename?: 'OpenScenariosDocAccessFields_updatedAt';
  create: Maybe<OpenScenariosDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_UpdatedAt_Read>;
  update: Maybe<OpenScenariosDocAccessFields_UpdatedAt_Update>;
};

export type OpenScenariosDocAccessFields_UpdatedAt_Create = {
  __typename?: 'OpenScenariosDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_UpdatedAt_Read = {
  __typename?: 'OpenScenariosDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_UpdatedAt_Update = {
  __typename?: 'OpenScenariosDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Url = {
  __typename?: 'OpenScenariosDocAccessFields_url';
  create: Maybe<OpenScenariosDocAccessFields_Url_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_Url_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_Url_Read>;
  update: Maybe<OpenScenariosDocAccessFields_Url_Update>;
};

export type OpenScenariosDocAccessFields_Url_Create = {
  __typename?: 'OpenScenariosDocAccessFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Url_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Url_Read = {
  __typename?: 'OpenScenariosDocAccessFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Url_Update = {
  __typename?: 'OpenScenariosDocAccessFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Width = {
  __typename?: 'OpenScenariosDocAccessFields_width';
  create: Maybe<OpenScenariosDocAccessFields_Width_Create>;
  delete: Maybe<OpenScenariosDocAccessFields_Width_Delete>;
  read: Maybe<OpenScenariosDocAccessFields_Width_Read>;
  update: Maybe<OpenScenariosDocAccessFields_Width_Update>;
};

export type OpenScenariosDocAccessFields_Width_Create = {
  __typename?: 'OpenScenariosDocAccessFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Width_Delete = {
  __typename?: 'OpenScenariosDocAccessFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Width_Read = {
  __typename?: 'OpenScenariosDocAccessFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosDocAccessFields_Width_Update = {
  __typename?: 'OpenScenariosDocAccessFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields = {
  __typename?: 'OpenScenariosFields';
  createdAt: Maybe<OpenScenariosFields_CreatedAt>;
  filename: Maybe<OpenScenariosFields_Filename>;
  filesize: Maybe<OpenScenariosFields_Filesize>;
  focalX: Maybe<OpenScenariosFields_FocalX>;
  focalY: Maybe<OpenScenariosFields_FocalY>;
  height: Maybe<OpenScenariosFields_Height>;
  mimeType: Maybe<OpenScenariosFields_MimeType>;
  thumbnailURL: Maybe<OpenScenariosFields_ThumbnailUrl>;
  updatedAt: Maybe<OpenScenariosFields_UpdatedAt>;
  url: Maybe<OpenScenariosFields_Url>;
  width: Maybe<OpenScenariosFields_Width>;
};

export type OpenScenariosFields_CreatedAt = {
  __typename?: 'OpenScenariosFields_createdAt';
  create: Maybe<OpenScenariosFields_CreatedAt_Create>;
  delete: Maybe<OpenScenariosFields_CreatedAt_Delete>;
  read: Maybe<OpenScenariosFields_CreatedAt_Read>;
  update: Maybe<OpenScenariosFields_CreatedAt_Update>;
};

export type OpenScenariosFields_CreatedAt_Create = {
  __typename?: 'OpenScenariosFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_CreatedAt_Delete = {
  __typename?: 'OpenScenariosFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_CreatedAt_Read = {
  __typename?: 'OpenScenariosFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_CreatedAt_Update = {
  __typename?: 'OpenScenariosFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filename = {
  __typename?: 'OpenScenariosFields_filename';
  create: Maybe<OpenScenariosFields_Filename_Create>;
  delete: Maybe<OpenScenariosFields_Filename_Delete>;
  read: Maybe<OpenScenariosFields_Filename_Read>;
  update: Maybe<OpenScenariosFields_Filename_Update>;
};

export type OpenScenariosFields_Filename_Create = {
  __typename?: 'OpenScenariosFields_filename_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filename_Delete = {
  __typename?: 'OpenScenariosFields_filename_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filename_Read = {
  __typename?: 'OpenScenariosFields_filename_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filename_Update = {
  __typename?: 'OpenScenariosFields_filename_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filesize = {
  __typename?: 'OpenScenariosFields_filesize';
  create: Maybe<OpenScenariosFields_Filesize_Create>;
  delete: Maybe<OpenScenariosFields_Filesize_Delete>;
  read: Maybe<OpenScenariosFields_Filesize_Read>;
  update: Maybe<OpenScenariosFields_Filesize_Update>;
};

export type OpenScenariosFields_Filesize_Create = {
  __typename?: 'OpenScenariosFields_filesize_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filesize_Delete = {
  __typename?: 'OpenScenariosFields_filesize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filesize_Read = {
  __typename?: 'OpenScenariosFields_filesize_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Filesize_Update = {
  __typename?: 'OpenScenariosFields_filesize_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalX = {
  __typename?: 'OpenScenariosFields_focalX';
  create: Maybe<OpenScenariosFields_FocalX_Create>;
  delete: Maybe<OpenScenariosFields_FocalX_Delete>;
  read: Maybe<OpenScenariosFields_FocalX_Read>;
  update: Maybe<OpenScenariosFields_FocalX_Update>;
};

export type OpenScenariosFields_FocalX_Create = {
  __typename?: 'OpenScenariosFields_focalX_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalX_Delete = {
  __typename?: 'OpenScenariosFields_focalX_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalX_Read = {
  __typename?: 'OpenScenariosFields_focalX_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalX_Update = {
  __typename?: 'OpenScenariosFields_focalX_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalY = {
  __typename?: 'OpenScenariosFields_focalY';
  create: Maybe<OpenScenariosFields_FocalY_Create>;
  delete: Maybe<OpenScenariosFields_FocalY_Delete>;
  read: Maybe<OpenScenariosFields_FocalY_Read>;
  update: Maybe<OpenScenariosFields_FocalY_Update>;
};

export type OpenScenariosFields_FocalY_Create = {
  __typename?: 'OpenScenariosFields_focalY_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalY_Delete = {
  __typename?: 'OpenScenariosFields_focalY_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalY_Read = {
  __typename?: 'OpenScenariosFields_focalY_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_FocalY_Update = {
  __typename?: 'OpenScenariosFields_focalY_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Height = {
  __typename?: 'OpenScenariosFields_height';
  create: Maybe<OpenScenariosFields_Height_Create>;
  delete: Maybe<OpenScenariosFields_Height_Delete>;
  read: Maybe<OpenScenariosFields_Height_Read>;
  update: Maybe<OpenScenariosFields_Height_Update>;
};

export type OpenScenariosFields_Height_Create = {
  __typename?: 'OpenScenariosFields_height_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Height_Delete = {
  __typename?: 'OpenScenariosFields_height_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Height_Read = {
  __typename?: 'OpenScenariosFields_height_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Height_Update = {
  __typename?: 'OpenScenariosFields_height_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_MimeType = {
  __typename?: 'OpenScenariosFields_mimeType';
  create: Maybe<OpenScenariosFields_MimeType_Create>;
  delete: Maybe<OpenScenariosFields_MimeType_Delete>;
  read: Maybe<OpenScenariosFields_MimeType_Read>;
  update: Maybe<OpenScenariosFields_MimeType_Update>;
};

export type OpenScenariosFields_MimeType_Create = {
  __typename?: 'OpenScenariosFields_mimeType_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_MimeType_Delete = {
  __typename?: 'OpenScenariosFields_mimeType_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_MimeType_Read = {
  __typename?: 'OpenScenariosFields_mimeType_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_MimeType_Update = {
  __typename?: 'OpenScenariosFields_mimeType_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_ThumbnailUrl = {
  __typename?: 'OpenScenariosFields_thumbnailURL';
  create: Maybe<OpenScenariosFields_ThumbnailUrl_Create>;
  delete: Maybe<OpenScenariosFields_ThumbnailUrl_Delete>;
  read: Maybe<OpenScenariosFields_ThumbnailUrl_Read>;
  update: Maybe<OpenScenariosFields_ThumbnailUrl_Update>;
};

export type OpenScenariosFields_ThumbnailUrl_Create = {
  __typename?: 'OpenScenariosFields_thumbnailURL_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_ThumbnailUrl_Delete = {
  __typename?: 'OpenScenariosFields_thumbnailURL_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_ThumbnailUrl_Read = {
  __typename?: 'OpenScenariosFields_thumbnailURL_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_ThumbnailUrl_Update = {
  __typename?: 'OpenScenariosFields_thumbnailURL_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_UpdatedAt = {
  __typename?: 'OpenScenariosFields_updatedAt';
  create: Maybe<OpenScenariosFields_UpdatedAt_Create>;
  delete: Maybe<OpenScenariosFields_UpdatedAt_Delete>;
  read: Maybe<OpenScenariosFields_UpdatedAt_Read>;
  update: Maybe<OpenScenariosFields_UpdatedAt_Update>;
};

export type OpenScenariosFields_UpdatedAt_Create = {
  __typename?: 'OpenScenariosFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_UpdatedAt_Delete = {
  __typename?: 'OpenScenariosFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_UpdatedAt_Read = {
  __typename?: 'OpenScenariosFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_UpdatedAt_Update = {
  __typename?: 'OpenScenariosFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Url = {
  __typename?: 'OpenScenariosFields_url';
  create: Maybe<OpenScenariosFields_Url_Create>;
  delete: Maybe<OpenScenariosFields_Url_Delete>;
  read: Maybe<OpenScenariosFields_Url_Read>;
  update: Maybe<OpenScenariosFields_Url_Update>;
};

export type OpenScenariosFields_Url_Create = {
  __typename?: 'OpenScenariosFields_url_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Url_Delete = {
  __typename?: 'OpenScenariosFields_url_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Url_Read = {
  __typename?: 'OpenScenariosFields_url_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Url_Update = {
  __typename?: 'OpenScenariosFields_url_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Width = {
  __typename?: 'OpenScenariosFields_width';
  create: Maybe<OpenScenariosFields_Width_Create>;
  delete: Maybe<OpenScenariosFields_Width_Delete>;
  read: Maybe<OpenScenariosFields_Width_Read>;
  update: Maybe<OpenScenariosFields_Width_Update>;
};

export type OpenScenariosFields_Width_Create = {
  __typename?: 'OpenScenariosFields_width_Create';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Width_Delete = {
  __typename?: 'OpenScenariosFields_width_Delete';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Width_Read = {
  __typename?: 'OpenScenariosFields_width_Read';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosFields_Width_Update = {
  __typename?: 'OpenScenariosFields_width_Update';
  permission: Scalars['Boolean']['output'];
};

export type OpenScenariosReadAccess = {
  __typename?: 'OpenScenariosReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenariosReadDocAccess = {
  __typename?: 'OpenScenariosReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenariosUpdateAccess = {
  __typename?: 'OpenScenariosUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type OpenScenariosUpdateDocAccess = {
  __typename?: 'OpenScenariosUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocument = {
  __typename?: 'PayloadLockedDocument';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  document: Maybe<PayloadLockedDocument_Document_Relationship>;
  globalSlug: Maybe<Scalars['String']['output']>;
  id: Scalars['Int']['output'];
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  user: PayloadLockedDocument_User_Relationship;
};


export type PayloadLockedDocumentDocumentArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
};

export type PayloadLockedDocumentUpdate_DocumentRelationshipInput = {
  relationTo: InputMaybe<PayloadLockedDocumentUpdate_DocumentRelationshipInputRelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadLockedDocumentUpdate_DocumentRelationshipInputRelationTo {
  Batches = 'batches',
  Documents = 'documents',
  Egos = 'egos',
  EsminiDats = 'esminiDats',
  KeyPerformanceIndicators = 'keyPerformanceIndicators',
  Media = 'media',
  Observations = 'observations',
  OpenDrives = 'openDrives',
  OpenScenarios = 'openScenarios',
  Samplings = 'samplings',
  Scenarios = 'scenarios',
  Sessions = 'sessions',
  Trials = 'trials',
  Users = 'users'
}

export type PayloadLockedDocumentUpdate_UserRelationshipInput = {
  relationTo: InputMaybe<PayloadLockedDocumentUpdate_UserRelationshipInputRelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadLockedDocumentUpdate_UserRelationshipInputRelationTo {
  Users = 'users'
}

export type PayloadLockedDocument_Document = Batch | Document | Ego | EsminiDat | KeyPerformanceIndicator | Media | Observation | OpenDrive | OpenScenario | Sampling | Scenario | Session | Trial | User;

export type PayloadLockedDocument_DocumentRelationshipInput = {
  relationTo: InputMaybe<PayloadLockedDocument_DocumentRelationshipInputRelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadLockedDocument_DocumentRelationshipInputRelationTo {
  Batches = 'batches',
  Documents = 'documents',
  Egos = 'egos',
  EsminiDats = 'esminiDats',
  KeyPerformanceIndicators = 'keyPerformanceIndicators',
  Media = 'media',
  Observations = 'observations',
  OpenDrives = 'openDrives',
  OpenScenarios = 'openScenarios',
  Samplings = 'samplings',
  Scenarios = 'scenarios',
  Sessions = 'sessions',
  Trials = 'trials',
  Users = 'users'
}

export enum PayloadLockedDocument_Document_RelationTo {
  Batches = 'batches',
  Documents = 'documents',
  Egos = 'egos',
  EsminiDats = 'esminiDats',
  KeyPerformanceIndicators = 'keyPerformanceIndicators',
  Media = 'media',
  Observations = 'observations',
  OpenDrives = 'openDrives',
  OpenScenarios = 'openScenarios',
  Samplings = 'samplings',
  Scenarios = 'scenarios',
  Sessions = 'sessions',
  Trials = 'trials',
  Users = 'users'
}

export type PayloadLockedDocument_Document_Relationship = {
  __typename?: 'PayloadLockedDocument_Document_Relationship';
  relationTo: Maybe<PayloadLockedDocument_Document_RelationTo>;
  value: Maybe<PayloadLockedDocument_Document>;
};

export type PayloadLockedDocument_User = User;

export type PayloadLockedDocument_UserRelationshipInput = {
  relationTo: InputMaybe<PayloadLockedDocument_UserRelationshipInputRelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadLockedDocument_UserRelationshipInputRelationTo {
  Users = 'users'
}

export enum PayloadLockedDocument_User_RelationTo {
  Users = 'users'
}

export type PayloadLockedDocument_User_Relationship = {
  __typename?: 'PayloadLockedDocument_User_Relationship';
  relationTo: Maybe<PayloadLockedDocument_User_RelationTo>;
  value: Maybe<PayloadLockedDocument_User>;
};

export type PayloadLockedDocument_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type PayloadLockedDocument_Document_Relation = {
  relationTo: InputMaybe<PayloadLockedDocument_Document_Relation_RelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadLockedDocument_Document_Relation_RelationTo {
  Batches = 'batches',
  Documents = 'documents',
  Egos = 'egos',
  EsminiDats = 'esminiDats',
  KeyPerformanceIndicators = 'keyPerformanceIndicators',
  Media = 'media',
  Observations = 'observations',
  OpenDrives = 'openDrives',
  OpenScenarios = 'openScenarios',
  Samplings = 'samplings',
  Scenarios = 'scenarios',
  Sessions = 'sessions',
  Trials = 'trials',
  Users = 'users'
}

export type PayloadLockedDocument_GlobalSlug_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type PayloadLockedDocument_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type PayloadLockedDocument_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type PayloadLockedDocument_User_Relation = {
  relationTo: InputMaybe<PayloadLockedDocument_User_Relation_RelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadLockedDocument_User_Relation_RelationTo {
  Users = 'users'
}

export type PayloadLockedDocument_Where = {
  AND: InputMaybe<Array<InputMaybe<PayloadLockedDocument_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<PayloadLockedDocument_Where_Or>>>;
  createdAt: InputMaybe<PayloadLockedDocument_CreatedAt_Operator>;
  document: InputMaybe<PayloadLockedDocument_Document_Relation>;
  globalSlug: InputMaybe<PayloadLockedDocument_GlobalSlug_Operator>;
  id: InputMaybe<PayloadLockedDocument_Id_Operator>;
  updatedAt: InputMaybe<PayloadLockedDocument_UpdatedAt_Operator>;
  user: InputMaybe<PayloadLockedDocument_User_Relation>;
};

export type PayloadLockedDocument_Where_And = {
  AND: InputMaybe<Array<InputMaybe<PayloadLockedDocument_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<PayloadLockedDocument_Where_Or>>>;
  createdAt: InputMaybe<PayloadLockedDocument_CreatedAt_Operator>;
  document: InputMaybe<PayloadLockedDocument_Document_Relation>;
  globalSlug: InputMaybe<PayloadLockedDocument_GlobalSlug_Operator>;
  id: InputMaybe<PayloadLockedDocument_Id_Operator>;
  updatedAt: InputMaybe<PayloadLockedDocument_UpdatedAt_Operator>;
  user: InputMaybe<PayloadLockedDocument_User_Relation>;
};

export type PayloadLockedDocument_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<PayloadLockedDocument_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<PayloadLockedDocument_Where_Or>>>;
  createdAt: InputMaybe<PayloadLockedDocument_CreatedAt_Operator>;
  document: InputMaybe<PayloadLockedDocument_Document_Relation>;
  globalSlug: InputMaybe<PayloadLockedDocument_GlobalSlug_Operator>;
  id: InputMaybe<PayloadLockedDocument_Id_Operator>;
  updatedAt: InputMaybe<PayloadLockedDocument_UpdatedAt_Operator>;
  user: InputMaybe<PayloadLockedDocument_User_Relation>;
};

export type PayloadLockedDocuments = {
  __typename?: 'PayloadLockedDocuments';
  docs: Array<PayloadLockedDocument>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type PayloadLockedDocumentsCreateAccess = {
  __typename?: 'PayloadLockedDocumentsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocumentsCreateDocAccess = {
  __typename?: 'PayloadLockedDocumentsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocumentsDeleteAccess = {
  __typename?: 'PayloadLockedDocumentsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocumentsDeleteDocAccess = {
  __typename?: 'PayloadLockedDocumentsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocumentsDocAccessFields = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields';
  createdAt: Maybe<PayloadLockedDocumentsDocAccessFields_CreatedAt>;
  document: Maybe<PayloadLockedDocumentsDocAccessFields_Document>;
  globalSlug: Maybe<PayloadLockedDocumentsDocAccessFields_GlobalSlug>;
  updatedAt: Maybe<PayloadLockedDocumentsDocAccessFields_UpdatedAt>;
  user: Maybe<PayloadLockedDocumentsDocAccessFields_User>;
};

export type PayloadLockedDocumentsDocAccessFields_CreatedAt = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_createdAt';
  create: Maybe<PayloadLockedDocumentsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<PayloadLockedDocumentsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<PayloadLockedDocumentsDocAccessFields_CreatedAt_Read>;
  update: Maybe<PayloadLockedDocumentsDocAccessFields_CreatedAt_Update>;
};

export type PayloadLockedDocumentsDocAccessFields_CreatedAt_Create = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_CreatedAt_Read = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_CreatedAt_Update = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_Document = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_document';
  create: Maybe<PayloadLockedDocumentsDocAccessFields_Document_Create>;
  delete: Maybe<PayloadLockedDocumentsDocAccessFields_Document_Delete>;
  read: Maybe<PayloadLockedDocumentsDocAccessFields_Document_Read>;
  update: Maybe<PayloadLockedDocumentsDocAccessFields_Document_Update>;
};

export type PayloadLockedDocumentsDocAccessFields_Document_Create = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_document_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_Document_Delete = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_document_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_Document_Read = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_document_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_Document_Update = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_document_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_GlobalSlug = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_globalSlug';
  create: Maybe<PayloadLockedDocumentsDocAccessFields_GlobalSlug_Create>;
  delete: Maybe<PayloadLockedDocumentsDocAccessFields_GlobalSlug_Delete>;
  read: Maybe<PayloadLockedDocumentsDocAccessFields_GlobalSlug_Read>;
  update: Maybe<PayloadLockedDocumentsDocAccessFields_GlobalSlug_Update>;
};

export type PayloadLockedDocumentsDocAccessFields_GlobalSlug_Create = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_globalSlug_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_GlobalSlug_Delete = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_globalSlug_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_GlobalSlug_Read = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_globalSlug_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_GlobalSlug_Update = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_globalSlug_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_UpdatedAt = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_updatedAt';
  create: Maybe<PayloadLockedDocumentsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<PayloadLockedDocumentsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<PayloadLockedDocumentsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<PayloadLockedDocumentsDocAccessFields_UpdatedAt_Update>;
};

export type PayloadLockedDocumentsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_User = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_user';
  create: Maybe<PayloadLockedDocumentsDocAccessFields_User_Create>;
  delete: Maybe<PayloadLockedDocumentsDocAccessFields_User_Delete>;
  read: Maybe<PayloadLockedDocumentsDocAccessFields_User_Read>;
  update: Maybe<PayloadLockedDocumentsDocAccessFields_User_Update>;
};

export type PayloadLockedDocumentsDocAccessFields_User_Create = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_user_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_User_Delete = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_user_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_User_Read = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_user_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsDocAccessFields_User_Update = {
  __typename?: 'PayloadLockedDocumentsDocAccessFields_user_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields = {
  __typename?: 'PayloadLockedDocumentsFields';
  createdAt: Maybe<PayloadLockedDocumentsFields_CreatedAt>;
  document: Maybe<PayloadLockedDocumentsFields_Document>;
  globalSlug: Maybe<PayloadLockedDocumentsFields_GlobalSlug>;
  updatedAt: Maybe<PayloadLockedDocumentsFields_UpdatedAt>;
  user: Maybe<PayloadLockedDocumentsFields_User>;
};

export type PayloadLockedDocumentsFields_CreatedAt = {
  __typename?: 'PayloadLockedDocumentsFields_createdAt';
  create: Maybe<PayloadLockedDocumentsFields_CreatedAt_Create>;
  delete: Maybe<PayloadLockedDocumentsFields_CreatedAt_Delete>;
  read: Maybe<PayloadLockedDocumentsFields_CreatedAt_Read>;
  update: Maybe<PayloadLockedDocumentsFields_CreatedAt_Update>;
};

export type PayloadLockedDocumentsFields_CreatedAt_Create = {
  __typename?: 'PayloadLockedDocumentsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_CreatedAt_Delete = {
  __typename?: 'PayloadLockedDocumentsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_CreatedAt_Read = {
  __typename?: 'PayloadLockedDocumentsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_CreatedAt_Update = {
  __typename?: 'PayloadLockedDocumentsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_Document = {
  __typename?: 'PayloadLockedDocumentsFields_document';
  create: Maybe<PayloadLockedDocumentsFields_Document_Create>;
  delete: Maybe<PayloadLockedDocumentsFields_Document_Delete>;
  read: Maybe<PayloadLockedDocumentsFields_Document_Read>;
  update: Maybe<PayloadLockedDocumentsFields_Document_Update>;
};

export type PayloadLockedDocumentsFields_Document_Create = {
  __typename?: 'PayloadLockedDocumentsFields_document_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_Document_Delete = {
  __typename?: 'PayloadLockedDocumentsFields_document_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_Document_Read = {
  __typename?: 'PayloadLockedDocumentsFields_document_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_Document_Update = {
  __typename?: 'PayloadLockedDocumentsFields_document_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_GlobalSlug = {
  __typename?: 'PayloadLockedDocumentsFields_globalSlug';
  create: Maybe<PayloadLockedDocumentsFields_GlobalSlug_Create>;
  delete: Maybe<PayloadLockedDocumentsFields_GlobalSlug_Delete>;
  read: Maybe<PayloadLockedDocumentsFields_GlobalSlug_Read>;
  update: Maybe<PayloadLockedDocumentsFields_GlobalSlug_Update>;
};

export type PayloadLockedDocumentsFields_GlobalSlug_Create = {
  __typename?: 'PayloadLockedDocumentsFields_globalSlug_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_GlobalSlug_Delete = {
  __typename?: 'PayloadLockedDocumentsFields_globalSlug_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_GlobalSlug_Read = {
  __typename?: 'PayloadLockedDocumentsFields_globalSlug_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_GlobalSlug_Update = {
  __typename?: 'PayloadLockedDocumentsFields_globalSlug_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_UpdatedAt = {
  __typename?: 'PayloadLockedDocumentsFields_updatedAt';
  create: Maybe<PayloadLockedDocumentsFields_UpdatedAt_Create>;
  delete: Maybe<PayloadLockedDocumentsFields_UpdatedAt_Delete>;
  read: Maybe<PayloadLockedDocumentsFields_UpdatedAt_Read>;
  update: Maybe<PayloadLockedDocumentsFields_UpdatedAt_Update>;
};

export type PayloadLockedDocumentsFields_UpdatedAt_Create = {
  __typename?: 'PayloadLockedDocumentsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_UpdatedAt_Delete = {
  __typename?: 'PayloadLockedDocumentsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_UpdatedAt_Read = {
  __typename?: 'PayloadLockedDocumentsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_UpdatedAt_Update = {
  __typename?: 'PayloadLockedDocumentsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_User = {
  __typename?: 'PayloadLockedDocumentsFields_user';
  create: Maybe<PayloadLockedDocumentsFields_User_Create>;
  delete: Maybe<PayloadLockedDocumentsFields_User_Delete>;
  read: Maybe<PayloadLockedDocumentsFields_User_Read>;
  update: Maybe<PayloadLockedDocumentsFields_User_Update>;
};

export type PayloadLockedDocumentsFields_User_Create = {
  __typename?: 'PayloadLockedDocumentsFields_user_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_User_Delete = {
  __typename?: 'PayloadLockedDocumentsFields_user_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_User_Read = {
  __typename?: 'PayloadLockedDocumentsFields_user_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsFields_User_Update = {
  __typename?: 'PayloadLockedDocumentsFields_user_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadLockedDocumentsReadAccess = {
  __typename?: 'PayloadLockedDocumentsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocumentsReadDocAccess = {
  __typename?: 'PayloadLockedDocumentsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocumentsUpdateAccess = {
  __typename?: 'PayloadLockedDocumentsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadLockedDocumentsUpdateDocAccess = {
  __typename?: 'PayloadLockedDocumentsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreference = {
  __typename?: 'PayloadPreference';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  id: Scalars['Int']['output'];
  key: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  user: PayloadPreference_User_Relationship;
  value: Maybe<Scalars['JSON']['output']>;
};

export type PayloadPreferenceUpdate_UserRelationshipInput = {
  relationTo: InputMaybe<PayloadPreferenceUpdate_UserRelationshipInputRelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadPreferenceUpdate_UserRelationshipInputRelationTo {
  Users = 'users'
}

export type PayloadPreference_User = User;

export type PayloadPreference_UserRelationshipInput = {
  relationTo: InputMaybe<PayloadPreference_UserRelationshipInputRelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadPreference_UserRelationshipInputRelationTo {
  Users = 'users'
}

export enum PayloadPreference_User_RelationTo {
  Users = 'users'
}

export type PayloadPreference_User_Relationship = {
  __typename?: 'PayloadPreference_User_Relationship';
  relationTo: Maybe<PayloadPreference_User_RelationTo>;
  value: Maybe<PayloadPreference_User>;
};

export type PayloadPreference_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type PayloadPreference_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type PayloadPreference_Key_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type PayloadPreference_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type PayloadPreference_User_Relation = {
  relationTo: InputMaybe<PayloadPreference_User_Relation_RelationTo>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export enum PayloadPreference_User_Relation_RelationTo {
  Users = 'users'
}

export type PayloadPreference_Value_Operator = {
  contains: InputMaybe<Scalars['JSON']['input']>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  intersects: InputMaybe<Scalars['JSON']['input']>;
  like: InputMaybe<Scalars['JSON']['input']>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  within: InputMaybe<Scalars['JSON']['input']>;
};

export type PayloadPreference_Where = {
  AND: InputMaybe<Array<InputMaybe<PayloadPreference_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<PayloadPreference_Where_Or>>>;
  createdAt: InputMaybe<PayloadPreference_CreatedAt_Operator>;
  id: InputMaybe<PayloadPreference_Id_Operator>;
  key: InputMaybe<PayloadPreference_Key_Operator>;
  updatedAt: InputMaybe<PayloadPreference_UpdatedAt_Operator>;
  user: InputMaybe<PayloadPreference_User_Relation>;
  value: InputMaybe<PayloadPreference_Value_Operator>;
};

export type PayloadPreference_Where_And = {
  AND: InputMaybe<Array<InputMaybe<PayloadPreference_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<PayloadPreference_Where_Or>>>;
  createdAt: InputMaybe<PayloadPreference_CreatedAt_Operator>;
  id: InputMaybe<PayloadPreference_Id_Operator>;
  key: InputMaybe<PayloadPreference_Key_Operator>;
  updatedAt: InputMaybe<PayloadPreference_UpdatedAt_Operator>;
  user: InputMaybe<PayloadPreference_User_Relation>;
  value: InputMaybe<PayloadPreference_Value_Operator>;
};

export type PayloadPreference_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<PayloadPreference_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<PayloadPreference_Where_Or>>>;
  createdAt: InputMaybe<PayloadPreference_CreatedAt_Operator>;
  id: InputMaybe<PayloadPreference_Id_Operator>;
  key: InputMaybe<PayloadPreference_Key_Operator>;
  updatedAt: InputMaybe<PayloadPreference_UpdatedAt_Operator>;
  user: InputMaybe<PayloadPreference_User_Relation>;
  value: InputMaybe<PayloadPreference_Value_Operator>;
};

export type PayloadPreferences = {
  __typename?: 'PayloadPreferences';
  docs: Array<PayloadPreference>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type PayloadPreferencesCreateAccess = {
  __typename?: 'PayloadPreferencesCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreferencesCreateDocAccess = {
  __typename?: 'PayloadPreferencesCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreferencesDeleteAccess = {
  __typename?: 'PayloadPreferencesDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreferencesDeleteDocAccess = {
  __typename?: 'PayloadPreferencesDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreferencesDocAccessFields = {
  __typename?: 'PayloadPreferencesDocAccessFields';
  createdAt: Maybe<PayloadPreferencesDocAccessFields_CreatedAt>;
  key: Maybe<PayloadPreferencesDocAccessFields_Key>;
  updatedAt: Maybe<PayloadPreferencesDocAccessFields_UpdatedAt>;
  user: Maybe<PayloadPreferencesDocAccessFields_User>;
  value: Maybe<PayloadPreferencesDocAccessFields_Value>;
};

export type PayloadPreferencesDocAccessFields_CreatedAt = {
  __typename?: 'PayloadPreferencesDocAccessFields_createdAt';
  create: Maybe<PayloadPreferencesDocAccessFields_CreatedAt_Create>;
  delete: Maybe<PayloadPreferencesDocAccessFields_CreatedAt_Delete>;
  read: Maybe<PayloadPreferencesDocAccessFields_CreatedAt_Read>;
  update: Maybe<PayloadPreferencesDocAccessFields_CreatedAt_Update>;
};

export type PayloadPreferencesDocAccessFields_CreatedAt_Create = {
  __typename?: 'PayloadPreferencesDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_CreatedAt_Delete = {
  __typename?: 'PayloadPreferencesDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_CreatedAt_Read = {
  __typename?: 'PayloadPreferencesDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_CreatedAt_Update = {
  __typename?: 'PayloadPreferencesDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Key = {
  __typename?: 'PayloadPreferencesDocAccessFields_key';
  create: Maybe<PayloadPreferencesDocAccessFields_Key_Create>;
  delete: Maybe<PayloadPreferencesDocAccessFields_Key_Delete>;
  read: Maybe<PayloadPreferencesDocAccessFields_Key_Read>;
  update: Maybe<PayloadPreferencesDocAccessFields_Key_Update>;
};

export type PayloadPreferencesDocAccessFields_Key_Create = {
  __typename?: 'PayloadPreferencesDocAccessFields_key_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Key_Delete = {
  __typename?: 'PayloadPreferencesDocAccessFields_key_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Key_Read = {
  __typename?: 'PayloadPreferencesDocAccessFields_key_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Key_Update = {
  __typename?: 'PayloadPreferencesDocAccessFields_key_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_UpdatedAt = {
  __typename?: 'PayloadPreferencesDocAccessFields_updatedAt';
  create: Maybe<PayloadPreferencesDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<PayloadPreferencesDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<PayloadPreferencesDocAccessFields_UpdatedAt_Read>;
  update: Maybe<PayloadPreferencesDocAccessFields_UpdatedAt_Update>;
};

export type PayloadPreferencesDocAccessFields_UpdatedAt_Create = {
  __typename?: 'PayloadPreferencesDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'PayloadPreferencesDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_UpdatedAt_Read = {
  __typename?: 'PayloadPreferencesDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_UpdatedAt_Update = {
  __typename?: 'PayloadPreferencesDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_User = {
  __typename?: 'PayloadPreferencesDocAccessFields_user';
  create: Maybe<PayloadPreferencesDocAccessFields_User_Create>;
  delete: Maybe<PayloadPreferencesDocAccessFields_User_Delete>;
  read: Maybe<PayloadPreferencesDocAccessFields_User_Read>;
  update: Maybe<PayloadPreferencesDocAccessFields_User_Update>;
};

export type PayloadPreferencesDocAccessFields_User_Create = {
  __typename?: 'PayloadPreferencesDocAccessFields_user_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_User_Delete = {
  __typename?: 'PayloadPreferencesDocAccessFields_user_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_User_Read = {
  __typename?: 'PayloadPreferencesDocAccessFields_user_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_User_Update = {
  __typename?: 'PayloadPreferencesDocAccessFields_user_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Value = {
  __typename?: 'PayloadPreferencesDocAccessFields_value';
  create: Maybe<PayloadPreferencesDocAccessFields_Value_Create>;
  delete: Maybe<PayloadPreferencesDocAccessFields_Value_Delete>;
  read: Maybe<PayloadPreferencesDocAccessFields_Value_Read>;
  update: Maybe<PayloadPreferencesDocAccessFields_Value_Update>;
};

export type PayloadPreferencesDocAccessFields_Value_Create = {
  __typename?: 'PayloadPreferencesDocAccessFields_value_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Value_Delete = {
  __typename?: 'PayloadPreferencesDocAccessFields_value_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Value_Read = {
  __typename?: 'PayloadPreferencesDocAccessFields_value_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesDocAccessFields_Value_Update = {
  __typename?: 'PayloadPreferencesDocAccessFields_value_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields = {
  __typename?: 'PayloadPreferencesFields';
  createdAt: Maybe<PayloadPreferencesFields_CreatedAt>;
  key: Maybe<PayloadPreferencesFields_Key>;
  updatedAt: Maybe<PayloadPreferencesFields_UpdatedAt>;
  user: Maybe<PayloadPreferencesFields_User>;
  value: Maybe<PayloadPreferencesFields_Value>;
};

export type PayloadPreferencesFields_CreatedAt = {
  __typename?: 'PayloadPreferencesFields_createdAt';
  create: Maybe<PayloadPreferencesFields_CreatedAt_Create>;
  delete: Maybe<PayloadPreferencesFields_CreatedAt_Delete>;
  read: Maybe<PayloadPreferencesFields_CreatedAt_Read>;
  update: Maybe<PayloadPreferencesFields_CreatedAt_Update>;
};

export type PayloadPreferencesFields_CreatedAt_Create = {
  __typename?: 'PayloadPreferencesFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_CreatedAt_Delete = {
  __typename?: 'PayloadPreferencesFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_CreatedAt_Read = {
  __typename?: 'PayloadPreferencesFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_CreatedAt_Update = {
  __typename?: 'PayloadPreferencesFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Key = {
  __typename?: 'PayloadPreferencesFields_key';
  create: Maybe<PayloadPreferencesFields_Key_Create>;
  delete: Maybe<PayloadPreferencesFields_Key_Delete>;
  read: Maybe<PayloadPreferencesFields_Key_Read>;
  update: Maybe<PayloadPreferencesFields_Key_Update>;
};

export type PayloadPreferencesFields_Key_Create = {
  __typename?: 'PayloadPreferencesFields_key_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Key_Delete = {
  __typename?: 'PayloadPreferencesFields_key_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Key_Read = {
  __typename?: 'PayloadPreferencesFields_key_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Key_Update = {
  __typename?: 'PayloadPreferencesFields_key_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_UpdatedAt = {
  __typename?: 'PayloadPreferencesFields_updatedAt';
  create: Maybe<PayloadPreferencesFields_UpdatedAt_Create>;
  delete: Maybe<PayloadPreferencesFields_UpdatedAt_Delete>;
  read: Maybe<PayloadPreferencesFields_UpdatedAt_Read>;
  update: Maybe<PayloadPreferencesFields_UpdatedAt_Update>;
};

export type PayloadPreferencesFields_UpdatedAt_Create = {
  __typename?: 'PayloadPreferencesFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_UpdatedAt_Delete = {
  __typename?: 'PayloadPreferencesFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_UpdatedAt_Read = {
  __typename?: 'PayloadPreferencesFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_UpdatedAt_Update = {
  __typename?: 'PayloadPreferencesFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_User = {
  __typename?: 'PayloadPreferencesFields_user';
  create: Maybe<PayloadPreferencesFields_User_Create>;
  delete: Maybe<PayloadPreferencesFields_User_Delete>;
  read: Maybe<PayloadPreferencesFields_User_Read>;
  update: Maybe<PayloadPreferencesFields_User_Update>;
};

export type PayloadPreferencesFields_User_Create = {
  __typename?: 'PayloadPreferencesFields_user_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_User_Delete = {
  __typename?: 'PayloadPreferencesFields_user_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_User_Read = {
  __typename?: 'PayloadPreferencesFields_user_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_User_Update = {
  __typename?: 'PayloadPreferencesFields_user_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Value = {
  __typename?: 'PayloadPreferencesFields_value';
  create: Maybe<PayloadPreferencesFields_Value_Create>;
  delete: Maybe<PayloadPreferencesFields_Value_Delete>;
  read: Maybe<PayloadPreferencesFields_Value_Read>;
  update: Maybe<PayloadPreferencesFields_Value_Update>;
};

export type PayloadPreferencesFields_Value_Create = {
  __typename?: 'PayloadPreferencesFields_value_Create';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Value_Delete = {
  __typename?: 'PayloadPreferencesFields_value_Delete';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Value_Read = {
  __typename?: 'PayloadPreferencesFields_value_Read';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesFields_Value_Update = {
  __typename?: 'PayloadPreferencesFields_value_Update';
  permission: Scalars['Boolean']['output'];
};

export type PayloadPreferencesReadAccess = {
  __typename?: 'PayloadPreferencesReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreferencesReadDocAccess = {
  __typename?: 'PayloadPreferencesReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreferencesUpdateAccess = {
  __typename?: 'PayloadPreferencesUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type PayloadPreferencesUpdateDocAccess = {
  __typename?: 'PayloadPreferencesUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Query = {
  __typename?: 'Query';
  Access: Maybe<Access>;
  Batch: Maybe<Batch>;
  Batches: Maybe<Batches>;
  Document: Maybe<Document>;
  Documents: Maybe<Documents>;
  Ego: Maybe<Ego>;
  Egos: Maybe<Egos>;
  EsminiDat: Maybe<EsminiDat>;
  EsminiDats: Maybe<EsminiDats>;
  KeyPerformanceIndicator: Maybe<KeyPerformanceIndicator>;
  KeyPerformanceIndicators: Maybe<KeyPerformanceIndicators>;
  Media: Maybe<Media>;
  Observation: Maybe<Observation>;
  Observations: Maybe<Observations>;
  OpenDrive: Maybe<OpenDrive>;
  OpenDrives: Maybe<OpenDrives>;
  OpenScenario: Maybe<OpenScenario>;
  OpenScenarios: Maybe<OpenScenarios>;
  PayloadLockedDocument: Maybe<PayloadLockedDocument>;
  PayloadLockedDocuments: Maybe<PayloadLockedDocuments>;
  PayloadPreference: Maybe<PayloadPreference>;
  PayloadPreferences: Maybe<PayloadPreferences>;
  Sampling: Maybe<Sampling>;
  Samplings: Maybe<Samplings>;
  Scenario: Maybe<Scenario>;
  Scenarios: Maybe<Scenarios>;
  Session: Maybe<Session>;
  Sessions: Maybe<Sessions>;
  Trial: Maybe<Trial>;
  Trials: Maybe<Trials>;
  User: Maybe<User>;
  Users: Maybe<Users>;
  allMedia: Maybe<AllMedia>;
  countBatches: Maybe<CountBatches>;
  countDocuments: Maybe<CountDocuments>;
  countEgos: Maybe<CountEgos>;
  countEsminiDats: Maybe<CountEsminiDats>;
  countKeyPerformanceIndicators: Maybe<CountKeyPerformanceIndicators>;
  countObservations: Maybe<CountObservations>;
  countOpenDrives: Maybe<CountOpenDrives>;
  countOpenScenarios: Maybe<CountOpenScenarios>;
  countPayloadLockedDocuments: Maybe<CountPayloadLockedDocuments>;
  countPayloadPreferences: Maybe<CountPayloadPreferences>;
  countSamplings: Maybe<CountSamplings>;
  countScenarios: Maybe<CountScenarios>;
  countSessions: Maybe<CountSessions>;
  countTrials: Maybe<CountTrials>;
  countUsers: Maybe<CountUsers>;
  countallMedia: Maybe<CountallMedia>;
  docAccessBatch: Maybe<BatchesDocAccess>;
  docAccessDocument: Maybe<DocumentsDocAccess>;
  docAccessEgo: Maybe<EgosDocAccess>;
  docAccessEsminiDat: Maybe<EsminiDatsDocAccess>;
  docAccessKeyPerformanceIndicator: Maybe<KeyPerformanceIndicatorsDocAccess>;
  docAccessMedia: Maybe<MediaDocAccess>;
  docAccessObservation: Maybe<ObservationsDocAccess>;
  docAccessOpenDrive: Maybe<OpenDrivesDocAccess>;
  docAccessOpenScenario: Maybe<OpenScenariosDocAccess>;
  docAccessPayloadLockedDocument: Maybe<Payload_Locked_DocumentsDocAccess>;
  docAccessPayloadPreference: Maybe<Payload_PreferencesDocAccess>;
  docAccessSampling: Maybe<SamplingsDocAccess>;
  docAccessScenario: Maybe<ScenariosDocAccess>;
  docAccessSession: Maybe<SessionsDocAccess>;
  docAccessTrial: Maybe<TrialsDocAccess>;
  docAccessUser: Maybe<UsersDocAccess>;
  initializedUser: Maybe<Scalars['Boolean']['output']>;
  meUser: Maybe<UsersMe>;
  versionSampling: Maybe<SamplingVersion>;
  versionScenario: Maybe<ScenarioVersion>;
  versionSession: Maybe<SessionVersion>;
  versionsSamplings: Maybe<VersionsSamplings>;
  versionsScenarios: Maybe<VersionsScenarios>;
  versionsSessions: Maybe<VersionsSessions>;
};


export type QueryBatchArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryBatchesArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Batch_Where>;
};


export type QueryDocumentArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryDocumentsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Document_Where>;
};


export type QueryEgoArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryEgosArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Ego_Where>;
};


export type QueryEsminiDatArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryEsminiDatsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<EsminiDat_Where>;
};


export type QueryKeyPerformanceIndicatorArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryKeyPerformanceIndicatorsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<KeyPerformanceIndicator_Where>;
};


export type QueryMediaArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryObservationArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryObservationsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Observation_Where>;
};


export type QueryOpenDriveArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryOpenDrivesArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<OpenDrive_Where>;
};


export type QueryOpenScenarioArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryOpenScenariosArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<OpenScenario_Where>;
};


export type QueryPayloadLockedDocumentArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryPayloadLockedDocumentsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<PayloadLockedDocument_Where>;
};


export type QueryPayloadPreferenceArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryPayloadPreferencesArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<PayloadPreference_Where>;
};


export type QuerySamplingArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QuerySamplingsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Sampling_Where>;
};


export type QueryScenarioArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryScenariosArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Scenario_Where>;
};


export type QuerySessionArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QuerySessionsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Session_Where>;
};


export type QueryTrialArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryTrialsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Trial_Where>;
};


export type QueryUserArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  id: Scalars['Int']['input'];
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryUsersArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<User_Where>;
};


export type QueryAllMediaArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Media_Where>;
};


export type QueryCountBatchesArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Batch_Where>;
};


export type QueryCountDocumentsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Document_Where>;
};


export type QueryCountEgosArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Ego_Where>;
};


export type QueryCountEsminiDatsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<EsminiDat_Where>;
};


export type QueryCountKeyPerformanceIndicatorsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<KeyPerformanceIndicator_Where>;
};


export type QueryCountObservationsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Observation_Where>;
};


export type QueryCountOpenDrivesArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<OpenDrive_Where>;
};


export type QueryCountOpenScenariosArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<OpenScenario_Where>;
};


export type QueryCountPayloadLockedDocumentsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<PayloadLockedDocument_Where>;
};


export type QueryCountPayloadPreferencesArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<PayloadPreference_Where>;
};


export type QueryCountSamplingsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Sampling_Where>;
};


export type QueryCountScenariosArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Scenario_Where>;
};


export type QueryCountSessionsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Session_Where>;
};


export type QueryCountTrialsArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Trial_Where>;
};


export type QueryCountUsersArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<User_Where>;
};


export type QueryCountallMediaArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<Media_Where>;
};


export type QueryDocAccessBatchArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessDocumentArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessEgoArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessEsminiDatArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessKeyPerformanceIndicatorArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessMediaArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessObservationArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessOpenDriveArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessOpenScenarioArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessPayloadLockedDocumentArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessPayloadPreferenceArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessSamplingArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessScenarioArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessSessionArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessTrialArgs = {
  id: Scalars['Int']['input'];
};


export type QueryDocAccessUserArgs = {
  id: Scalars['Int']['input'];
};


export type QueryVersionSamplingArgs = {
  id: InputMaybe<Scalars['Int']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryVersionScenarioArgs = {
  id: InputMaybe<Scalars['Int']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryVersionSessionArgs = {
  id: InputMaybe<Scalars['Int']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
};


export type QueryVersionsSamplingsArgs = {
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<VersionsSampling_Where>;
};


export type QueryVersionsScenariosArgs = {
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<VersionsScenario_Where>;
};


export type QueryVersionsSessionsArgs = {
  limit: InputMaybe<Scalars['Int']['input']>;
  page: InputMaybe<Scalars['Int']['input']>;
  pagination: InputMaybe<Scalars['Boolean']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  trash: InputMaybe<Scalars['Boolean']['input']>;
  where: InputMaybe<VersionsSession_Where>;
};

export type Sampling = {
  __typename?: 'Sampling';
  _status: Maybe<Sampling__Status>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  id: Scalars['Int']['output'];
  steps: Maybe<Array<Sampling_Steps>>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export enum SamplingUpdate_Steps_Method_MutationInput {
  Sobol = 'sobol',
  Straddle = 'straddle',
  Uniform = 'uniform'
}

export enum SamplingUpdate__Status_MutationInput {
  Draft = 'draft',
  Published = 'published'
}

export type SamplingVersion = {
  __typename?: 'SamplingVersion';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  id: Maybe<Scalars['Int']['output']>;
  latest: Maybe<Scalars['Boolean']['output']>;
  parent: Maybe<Sampling>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  version: Maybe<SamplingVersion_Version>;
};


export type SamplingVersionParentArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
};

export type SamplingVersion_Version = {
  __typename?: 'SamplingVersion_Version';
  _status: Maybe<SamplingVersion_Version__Status>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  steps: Maybe<Array<SamplingVersion_Version_Steps>>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export type SamplingVersion_Version_Steps = {
  __typename?: 'SamplingVersion_Version_Steps';
  acquisitionExplorationFactor: Maybe<Scalars['Float']['output']>;
  acquisitionSampleSize: Maybe<Scalars['Float']['output']>;
  id: Maybe<Scalars['String']['output']>;
  maxSurrogateTrainingSampleSize: Maybe<Scalars['Float']['output']>;
  method: Maybe<SamplingVersion_Version_Steps_Method>;
  parallelCounts: Maybe<Scalars['Float']['output']>;
  sampleSize: Maybe<Scalars['Float']['output']>;
};

export enum SamplingVersion_Version_Steps_Method {
  Sobol = 'sobol',
  Straddle = 'straddle',
  Uniform = 'uniform'
}

export enum SamplingVersion_Version__Status {
  Draft = 'draft',
  Published = 'published'
}

export type Sampling_Steps = {
  __typename?: 'Sampling_Steps';
  acquisitionExplorationFactor: Maybe<Scalars['Float']['output']>;
  acquisitionSampleSize: Maybe<Scalars['Float']['output']>;
  id: Maybe<Scalars['String']['output']>;
  maxSurrogateTrainingSampleSize: Maybe<Scalars['Float']['output']>;
  method: Maybe<Sampling_Steps_Method>;
  parallelCounts: Maybe<Scalars['Float']['output']>;
  sampleSize: Maybe<Scalars['Float']['output']>;
};

export enum Sampling_Steps_Method {
  Sobol = 'sobol',
  Straddle = 'straddle',
  Uniform = 'uniform'
}

export enum Sampling_Steps_Method_MutationInput {
  Sobol = 'sobol',
  Straddle = 'straddle',
  Uniform = 'uniform'
}

export enum Sampling__Status {
  Draft = 'draft',
  Published = 'published'
}

export enum Sampling__Status_Input {
  Draft = 'draft',
  Published = 'published'
}

export enum Sampling__Status_MutationInput {
  Draft = 'draft',
  Published = 'published'
}

export type Sampling__Status_Operator = {
  all: InputMaybe<Array<InputMaybe<Sampling__Status_Input>>>;
  equals: InputMaybe<Sampling__Status_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Sampling__Status_Input>>>;
  not_equals: InputMaybe<Sampling__Status_Input>;
  not_in: InputMaybe<Array<InputMaybe<Sampling__Status_Input>>>;
};

export type Sampling_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Sampling_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Sampling_Steps__AcquisitionExplorationFactor_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Sampling_Steps__AcquisitionSampleSize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Sampling_Steps__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Sampling_Steps__MaxSurrogateTrainingSampleSize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export enum Sampling_Steps__Method_Input {
  Sobol = 'sobol',
  Straddle = 'straddle',
  Uniform = 'uniform'
}

export type Sampling_Steps__Method_Operator = {
  all: InputMaybe<Array<InputMaybe<Sampling_Steps__Method_Input>>>;
  equals: InputMaybe<Sampling_Steps__Method_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Sampling_Steps__Method_Input>>>;
  not_equals: InputMaybe<Sampling_Steps__Method_Input>;
  not_in: InputMaybe<Array<InputMaybe<Sampling_Steps__Method_Input>>>;
};

export type Sampling_Steps__ParallelCounts_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Sampling_Steps__SampleSize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Sampling_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Sampling_Where = {
  AND: InputMaybe<Array<InputMaybe<Sampling_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Sampling_Where_Or>>>;
  _status: InputMaybe<Sampling__Status_Operator>;
  createdAt: InputMaybe<Sampling_CreatedAt_Operator>;
  id: InputMaybe<Sampling_Id_Operator>;
  steps__acquisitionExplorationFactor: InputMaybe<Sampling_Steps__AcquisitionExplorationFactor_Operator>;
  steps__acquisitionSampleSize: InputMaybe<Sampling_Steps__AcquisitionSampleSize_Operator>;
  steps__id: InputMaybe<Sampling_Steps__Id_Operator>;
  steps__maxSurrogateTrainingSampleSize: InputMaybe<Sampling_Steps__MaxSurrogateTrainingSampleSize_Operator>;
  steps__method: InputMaybe<Sampling_Steps__Method_Operator>;
  steps__parallelCounts: InputMaybe<Sampling_Steps__ParallelCounts_Operator>;
  steps__sampleSize: InputMaybe<Sampling_Steps__SampleSize_Operator>;
  updatedAt: InputMaybe<Sampling_UpdatedAt_Operator>;
};

export type Sampling_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Sampling_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Sampling_Where_Or>>>;
  _status: InputMaybe<Sampling__Status_Operator>;
  createdAt: InputMaybe<Sampling_CreatedAt_Operator>;
  id: InputMaybe<Sampling_Id_Operator>;
  steps__acquisitionExplorationFactor: InputMaybe<Sampling_Steps__AcquisitionExplorationFactor_Operator>;
  steps__acquisitionSampleSize: InputMaybe<Sampling_Steps__AcquisitionSampleSize_Operator>;
  steps__id: InputMaybe<Sampling_Steps__Id_Operator>;
  steps__maxSurrogateTrainingSampleSize: InputMaybe<Sampling_Steps__MaxSurrogateTrainingSampleSize_Operator>;
  steps__method: InputMaybe<Sampling_Steps__Method_Operator>;
  steps__parallelCounts: InputMaybe<Sampling_Steps__ParallelCounts_Operator>;
  steps__sampleSize: InputMaybe<Sampling_Steps__SampleSize_Operator>;
  updatedAt: InputMaybe<Sampling_UpdatedAt_Operator>;
};

export type Sampling_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Sampling_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Sampling_Where_Or>>>;
  _status: InputMaybe<Sampling__Status_Operator>;
  createdAt: InputMaybe<Sampling_CreatedAt_Operator>;
  id: InputMaybe<Sampling_Id_Operator>;
  steps__acquisitionExplorationFactor: InputMaybe<Sampling_Steps__AcquisitionExplorationFactor_Operator>;
  steps__acquisitionSampleSize: InputMaybe<Sampling_Steps__AcquisitionSampleSize_Operator>;
  steps__id: InputMaybe<Sampling_Steps__Id_Operator>;
  steps__maxSurrogateTrainingSampleSize: InputMaybe<Sampling_Steps__MaxSurrogateTrainingSampleSize_Operator>;
  steps__method: InputMaybe<Sampling_Steps__Method_Operator>;
  steps__parallelCounts: InputMaybe<Sampling_Steps__ParallelCounts_Operator>;
  steps__sampleSize: InputMaybe<Sampling_Steps__SampleSize_Operator>;
  updatedAt: InputMaybe<Sampling_UpdatedAt_Operator>;
};

export type Samplings = {
  __typename?: 'Samplings';
  docs: Array<Sampling>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type SamplingsCreateAccess = {
  __typename?: 'SamplingsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsCreateDocAccess = {
  __typename?: 'SamplingsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsDeleteAccess = {
  __typename?: 'SamplingsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsDeleteDocAccess = {
  __typename?: 'SamplingsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsDocAccessFields = {
  __typename?: 'SamplingsDocAccessFields';
  _status: Maybe<SamplingsDocAccessFields__Status>;
  createdAt: Maybe<SamplingsDocAccessFields_CreatedAt>;
  steps: Maybe<SamplingsDocAccessFields_Steps>;
  updatedAt: Maybe<SamplingsDocAccessFields_UpdatedAt>;
};

export type SamplingsDocAccessFields__Status = {
  __typename?: 'SamplingsDocAccessFields__status';
  create: Maybe<SamplingsDocAccessFields__Status_Create>;
  delete: Maybe<SamplingsDocAccessFields__Status_Delete>;
  read: Maybe<SamplingsDocAccessFields__Status_Read>;
  update: Maybe<SamplingsDocAccessFields__Status_Update>;
};

export type SamplingsDocAccessFields__Status_Create = {
  __typename?: 'SamplingsDocAccessFields__status_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields__Status_Delete = {
  __typename?: 'SamplingsDocAccessFields__status_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields__Status_Read = {
  __typename?: 'SamplingsDocAccessFields__status_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields__Status_Update = {
  __typename?: 'SamplingsDocAccessFields__status_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_CreatedAt = {
  __typename?: 'SamplingsDocAccessFields_createdAt';
  create: Maybe<SamplingsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<SamplingsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<SamplingsDocAccessFields_CreatedAt_Read>;
  update: Maybe<SamplingsDocAccessFields_CreatedAt_Update>;
};

export type SamplingsDocAccessFields_CreatedAt_Create = {
  __typename?: 'SamplingsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'SamplingsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_CreatedAt_Read = {
  __typename?: 'SamplingsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_CreatedAt_Update = {
  __typename?: 'SamplingsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps = {
  __typename?: 'SamplingsDocAccessFields_steps';
  create: Maybe<SamplingsDocAccessFields_Steps_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_Delete>;
  fields: Maybe<SamplingsDocAccessFields_Steps_Fields>;
  read: Maybe<SamplingsDocAccessFields_Steps_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_Update>;
};

export type SamplingsDocAccessFields_Steps_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Fields = {
  __typename?: 'SamplingsDocAccessFields_steps_Fields';
  acquisitionExplorationFactor: Maybe<SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor>;
  acquisitionSampleSize: Maybe<SamplingsDocAccessFields_Steps_AcquisitionSampleSize>;
  id: Maybe<SamplingsDocAccessFields_Steps_Id>;
  maxSurrogateTrainingSampleSize: Maybe<SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize>;
  method: Maybe<SamplingsDocAccessFields_Steps_Method>;
  parallelCounts: Maybe<SamplingsDocAccessFields_Steps_ParallelCounts>;
  sampleSize: Maybe<SamplingsDocAccessFields_Steps_SampleSize>;
};

export type SamplingsDocAccessFields_Steps_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionExplorationFactor';
  create: Maybe<SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Delete>;
  read: Maybe<SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Update>;
};

export type SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionExplorationFactor_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionExplorationFactor_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionExplorationFactor_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionExplorationFactor_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionExplorationFactor_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionSampleSize = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionSampleSize';
  create: Maybe<SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Delete>;
  read: Maybe<SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Update>;
};

export type SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionSampleSize_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionSampleSize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionSampleSize_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_AcquisitionSampleSize_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_acquisitionSampleSize_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Id = {
  __typename?: 'SamplingsDocAccessFields_steps_id';
  create: Maybe<SamplingsDocAccessFields_Steps_Id_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_Id_Delete>;
  read: Maybe<SamplingsDocAccessFields_Steps_Id_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_Id_Update>;
};

export type SamplingsDocAccessFields_Steps_Id_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Id_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Id_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Id_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize = {
  __typename?: 'SamplingsDocAccessFields_steps_maxSurrogateTrainingSampleSize';
  create: Maybe<SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Delete>;
  read: Maybe<SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Update>;
};

export type SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_maxSurrogateTrainingSampleSize_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_maxSurrogateTrainingSampleSize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_maxSurrogateTrainingSampleSize_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_MaxSurrogateTrainingSampleSize_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_maxSurrogateTrainingSampleSize_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Method = {
  __typename?: 'SamplingsDocAccessFields_steps_method';
  create: Maybe<SamplingsDocAccessFields_Steps_Method_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_Method_Delete>;
  read: Maybe<SamplingsDocAccessFields_Steps_Method_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_Method_Update>;
};

export type SamplingsDocAccessFields_Steps_Method_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_method_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Method_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_method_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Method_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_method_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_Method_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_method_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_ParallelCounts = {
  __typename?: 'SamplingsDocAccessFields_steps_parallelCounts';
  create: Maybe<SamplingsDocAccessFields_Steps_ParallelCounts_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_ParallelCounts_Delete>;
  read: Maybe<SamplingsDocAccessFields_Steps_ParallelCounts_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_ParallelCounts_Update>;
};

export type SamplingsDocAccessFields_Steps_ParallelCounts_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_parallelCounts_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_ParallelCounts_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_parallelCounts_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_ParallelCounts_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_parallelCounts_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_ParallelCounts_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_parallelCounts_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_SampleSize = {
  __typename?: 'SamplingsDocAccessFields_steps_sampleSize';
  create: Maybe<SamplingsDocAccessFields_Steps_SampleSize_Create>;
  delete: Maybe<SamplingsDocAccessFields_Steps_SampleSize_Delete>;
  read: Maybe<SamplingsDocAccessFields_Steps_SampleSize_Read>;
  update: Maybe<SamplingsDocAccessFields_Steps_SampleSize_Update>;
};

export type SamplingsDocAccessFields_Steps_SampleSize_Create = {
  __typename?: 'SamplingsDocAccessFields_steps_sampleSize_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_SampleSize_Delete = {
  __typename?: 'SamplingsDocAccessFields_steps_sampleSize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_SampleSize_Read = {
  __typename?: 'SamplingsDocAccessFields_steps_sampleSize_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_Steps_SampleSize_Update = {
  __typename?: 'SamplingsDocAccessFields_steps_sampleSize_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_UpdatedAt = {
  __typename?: 'SamplingsDocAccessFields_updatedAt';
  create: Maybe<SamplingsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<SamplingsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<SamplingsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<SamplingsDocAccessFields_UpdatedAt_Update>;
};

export type SamplingsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'SamplingsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'SamplingsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'SamplingsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'SamplingsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields = {
  __typename?: 'SamplingsFields';
  _status: Maybe<SamplingsFields__Status>;
  createdAt: Maybe<SamplingsFields_CreatedAt>;
  steps: Maybe<SamplingsFields_Steps>;
  updatedAt: Maybe<SamplingsFields_UpdatedAt>;
};

export type SamplingsFields__Status = {
  __typename?: 'SamplingsFields__status';
  create: Maybe<SamplingsFields__Status_Create>;
  delete: Maybe<SamplingsFields__Status_Delete>;
  read: Maybe<SamplingsFields__Status_Read>;
  update: Maybe<SamplingsFields__Status_Update>;
};

export type SamplingsFields__Status_Create = {
  __typename?: 'SamplingsFields__status_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields__Status_Delete = {
  __typename?: 'SamplingsFields__status_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields__Status_Read = {
  __typename?: 'SamplingsFields__status_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields__Status_Update = {
  __typename?: 'SamplingsFields__status_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_CreatedAt = {
  __typename?: 'SamplingsFields_createdAt';
  create: Maybe<SamplingsFields_CreatedAt_Create>;
  delete: Maybe<SamplingsFields_CreatedAt_Delete>;
  read: Maybe<SamplingsFields_CreatedAt_Read>;
  update: Maybe<SamplingsFields_CreatedAt_Update>;
};

export type SamplingsFields_CreatedAt_Create = {
  __typename?: 'SamplingsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_CreatedAt_Delete = {
  __typename?: 'SamplingsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_CreatedAt_Read = {
  __typename?: 'SamplingsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_CreatedAt_Update = {
  __typename?: 'SamplingsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps = {
  __typename?: 'SamplingsFields_steps';
  create: Maybe<SamplingsFields_Steps_Create>;
  delete: Maybe<SamplingsFields_Steps_Delete>;
  fields: Maybe<SamplingsFields_Steps_Fields>;
  read: Maybe<SamplingsFields_Steps_Read>;
  update: Maybe<SamplingsFields_Steps_Update>;
};

export type SamplingsFields_Steps_Create = {
  __typename?: 'SamplingsFields_steps_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Delete = {
  __typename?: 'SamplingsFields_steps_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Fields = {
  __typename?: 'SamplingsFields_steps_Fields';
  acquisitionExplorationFactor: Maybe<SamplingsFields_Steps_AcquisitionExplorationFactor>;
  acquisitionSampleSize: Maybe<SamplingsFields_Steps_AcquisitionSampleSize>;
  id: Maybe<SamplingsFields_Steps_Id>;
  maxSurrogateTrainingSampleSize: Maybe<SamplingsFields_Steps_MaxSurrogateTrainingSampleSize>;
  method: Maybe<SamplingsFields_Steps_Method>;
  parallelCounts: Maybe<SamplingsFields_Steps_ParallelCounts>;
  sampleSize: Maybe<SamplingsFields_Steps_SampleSize>;
};

export type SamplingsFields_Steps_Read = {
  __typename?: 'SamplingsFields_steps_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Update = {
  __typename?: 'SamplingsFields_steps_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionExplorationFactor = {
  __typename?: 'SamplingsFields_steps_acquisitionExplorationFactor';
  create: Maybe<SamplingsFields_Steps_AcquisitionExplorationFactor_Create>;
  delete: Maybe<SamplingsFields_Steps_AcquisitionExplorationFactor_Delete>;
  read: Maybe<SamplingsFields_Steps_AcquisitionExplorationFactor_Read>;
  update: Maybe<SamplingsFields_Steps_AcquisitionExplorationFactor_Update>;
};

export type SamplingsFields_Steps_AcquisitionExplorationFactor_Create = {
  __typename?: 'SamplingsFields_steps_acquisitionExplorationFactor_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionExplorationFactor_Delete = {
  __typename?: 'SamplingsFields_steps_acquisitionExplorationFactor_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionExplorationFactor_Read = {
  __typename?: 'SamplingsFields_steps_acquisitionExplorationFactor_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionExplorationFactor_Update = {
  __typename?: 'SamplingsFields_steps_acquisitionExplorationFactor_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionSampleSize = {
  __typename?: 'SamplingsFields_steps_acquisitionSampleSize';
  create: Maybe<SamplingsFields_Steps_AcquisitionSampleSize_Create>;
  delete: Maybe<SamplingsFields_Steps_AcquisitionSampleSize_Delete>;
  read: Maybe<SamplingsFields_Steps_AcquisitionSampleSize_Read>;
  update: Maybe<SamplingsFields_Steps_AcquisitionSampleSize_Update>;
};

export type SamplingsFields_Steps_AcquisitionSampleSize_Create = {
  __typename?: 'SamplingsFields_steps_acquisitionSampleSize_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionSampleSize_Delete = {
  __typename?: 'SamplingsFields_steps_acquisitionSampleSize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionSampleSize_Read = {
  __typename?: 'SamplingsFields_steps_acquisitionSampleSize_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_AcquisitionSampleSize_Update = {
  __typename?: 'SamplingsFields_steps_acquisitionSampleSize_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Id = {
  __typename?: 'SamplingsFields_steps_id';
  create: Maybe<SamplingsFields_Steps_Id_Create>;
  delete: Maybe<SamplingsFields_Steps_Id_Delete>;
  read: Maybe<SamplingsFields_Steps_Id_Read>;
  update: Maybe<SamplingsFields_Steps_Id_Update>;
};

export type SamplingsFields_Steps_Id_Create = {
  __typename?: 'SamplingsFields_steps_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Id_Delete = {
  __typename?: 'SamplingsFields_steps_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Id_Read = {
  __typename?: 'SamplingsFields_steps_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Id_Update = {
  __typename?: 'SamplingsFields_steps_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_MaxSurrogateTrainingSampleSize = {
  __typename?: 'SamplingsFields_steps_maxSurrogateTrainingSampleSize';
  create: Maybe<SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Create>;
  delete: Maybe<SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Delete>;
  read: Maybe<SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Read>;
  update: Maybe<SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Update>;
};

export type SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Create = {
  __typename?: 'SamplingsFields_steps_maxSurrogateTrainingSampleSize_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Delete = {
  __typename?: 'SamplingsFields_steps_maxSurrogateTrainingSampleSize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Read = {
  __typename?: 'SamplingsFields_steps_maxSurrogateTrainingSampleSize_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_MaxSurrogateTrainingSampleSize_Update = {
  __typename?: 'SamplingsFields_steps_maxSurrogateTrainingSampleSize_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Method = {
  __typename?: 'SamplingsFields_steps_method';
  create: Maybe<SamplingsFields_Steps_Method_Create>;
  delete: Maybe<SamplingsFields_Steps_Method_Delete>;
  read: Maybe<SamplingsFields_Steps_Method_Read>;
  update: Maybe<SamplingsFields_Steps_Method_Update>;
};

export type SamplingsFields_Steps_Method_Create = {
  __typename?: 'SamplingsFields_steps_method_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Method_Delete = {
  __typename?: 'SamplingsFields_steps_method_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Method_Read = {
  __typename?: 'SamplingsFields_steps_method_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_Method_Update = {
  __typename?: 'SamplingsFields_steps_method_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_ParallelCounts = {
  __typename?: 'SamplingsFields_steps_parallelCounts';
  create: Maybe<SamplingsFields_Steps_ParallelCounts_Create>;
  delete: Maybe<SamplingsFields_Steps_ParallelCounts_Delete>;
  read: Maybe<SamplingsFields_Steps_ParallelCounts_Read>;
  update: Maybe<SamplingsFields_Steps_ParallelCounts_Update>;
};

export type SamplingsFields_Steps_ParallelCounts_Create = {
  __typename?: 'SamplingsFields_steps_parallelCounts_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_ParallelCounts_Delete = {
  __typename?: 'SamplingsFields_steps_parallelCounts_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_ParallelCounts_Read = {
  __typename?: 'SamplingsFields_steps_parallelCounts_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_ParallelCounts_Update = {
  __typename?: 'SamplingsFields_steps_parallelCounts_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_SampleSize = {
  __typename?: 'SamplingsFields_steps_sampleSize';
  create: Maybe<SamplingsFields_Steps_SampleSize_Create>;
  delete: Maybe<SamplingsFields_Steps_SampleSize_Delete>;
  read: Maybe<SamplingsFields_Steps_SampleSize_Read>;
  update: Maybe<SamplingsFields_Steps_SampleSize_Update>;
};

export type SamplingsFields_Steps_SampleSize_Create = {
  __typename?: 'SamplingsFields_steps_sampleSize_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_SampleSize_Delete = {
  __typename?: 'SamplingsFields_steps_sampleSize_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_SampleSize_Read = {
  __typename?: 'SamplingsFields_steps_sampleSize_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_Steps_SampleSize_Update = {
  __typename?: 'SamplingsFields_steps_sampleSize_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_UpdatedAt = {
  __typename?: 'SamplingsFields_updatedAt';
  create: Maybe<SamplingsFields_UpdatedAt_Create>;
  delete: Maybe<SamplingsFields_UpdatedAt_Delete>;
  read: Maybe<SamplingsFields_UpdatedAt_Read>;
  update: Maybe<SamplingsFields_UpdatedAt_Update>;
};

export type SamplingsFields_UpdatedAt_Create = {
  __typename?: 'SamplingsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_UpdatedAt_Delete = {
  __typename?: 'SamplingsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_UpdatedAt_Read = {
  __typename?: 'SamplingsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsFields_UpdatedAt_Update = {
  __typename?: 'SamplingsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SamplingsReadAccess = {
  __typename?: 'SamplingsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsReadDocAccess = {
  __typename?: 'SamplingsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsReadVersionsAccess = {
  __typename?: 'SamplingsReadVersionsAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsReadVersionsDocAccess = {
  __typename?: 'SamplingsReadVersionsDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsUpdateAccess = {
  __typename?: 'SamplingsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SamplingsUpdateDocAccess = {
  __typename?: 'SamplingsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Scenario = {
  __typename?: 'Scenario';
  _status: Maybe<Scenario__Status>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  description: Maybe<Scalars['String']['output']>;
  egoTargetSpeed: Maybe<Scalars['Float']['output']>;
  id: Scalars['Int']['output'];
  name: Maybe<Scalars['String']['output']>;
  observationRecordingAgents: Maybe<Array<Scenario_ObservationRecordingAgents>>;
  openDrive: Maybe<OpenDrive>;
  openScenarioField: Maybe<Scenario_OpenScenarioField>;
  parameterConstraints: Maybe<Array<Scenario_ParameterConstraints>>;
  parameters: Array<Scenario_Parameters>;
  schematic: Maybe<Media>;
  startObservationSamplingConditions: Maybe<Array<Scenario_StartObservationSamplingConditions>>;
  testObjectives: Maybe<Scenario_TestObjectives>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  validConditions: Maybe<Array<Scenario_ValidConditions>>;
};

export enum ScenarioUpdate_OpenScenarioField_Type_MutationInput {
  File = 'File',
  String = 'String'
}

export enum ScenarioUpdate__Status_MutationInput {
  Draft = 'draft',
  Published = 'published'
}

export type ScenarioVersion = {
  __typename?: 'ScenarioVersion';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  id: Maybe<Scalars['Int']['output']>;
  latest: Maybe<Scalars['Boolean']['output']>;
  parent: Maybe<Scenario>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  version: Maybe<ScenarioVersion_Version>;
};


export type ScenarioVersionParentArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
};

export type ScenarioVersion_Version = {
  __typename?: 'ScenarioVersion_Version';
  _status: Maybe<ScenarioVersion_Version__Status>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  description: Maybe<Scalars['String']['output']>;
  egoTargetSpeed: Maybe<Scalars['Float']['output']>;
  name: Maybe<Scalars['String']['output']>;
  observationRecordingAgents: Maybe<Array<ScenarioVersion_Version_ObservationRecordingAgents>>;
  openDrive: Maybe<OpenDrive>;
  openScenarioField: Maybe<ScenarioVersion_Version_OpenScenarioField>;
  parameterConstraints: Maybe<Array<ScenarioVersion_Version_ParameterConstraints>>;
  parameters: Array<ScenarioVersion_Version_Parameters>;
  schematic: Maybe<Media>;
  startObservationSamplingConditions: Maybe<Array<ScenarioVersion_Version_StartObservationSamplingConditions>>;
  testObjectives: Maybe<ScenarioVersion_Version_TestObjectives>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  validConditions: Maybe<Array<ScenarioVersion_Version_ValidConditions>>;
};

export type ScenarioVersion_Version_ObservationRecordingAgents = {
  __typename?: 'ScenarioVersion_Version_ObservationRecordingAgents';
  id: Maybe<Scalars['String']['output']>;
  name: Maybe<Scalars['String']['output']>;
};

export type ScenarioVersion_Version_OpenScenarioField = {
  __typename?: 'ScenarioVersion_Version_OpenScenarioField';
  content: Maybe<Scalars['String']['output']>;
  openScenario: Maybe<OpenScenario>;
  type: Maybe<ScenarioVersion_Version_OpenScenarioField_Type>;
};

export enum ScenarioVersion_Version_OpenScenarioField_Type {
  File = 'File',
  String = 'String'
}

export type ScenarioVersion_Version_ParameterConstraints = {
  __typename?: 'ScenarioVersion_Version_ParameterConstraints';
  expression: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
};

export type ScenarioVersion_Version_Parameters = {
  __typename?: 'ScenarioVersion_Version_Parameters';
  description: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
  max: Maybe<Scalars['Float']['output']>;
  min: Maybe<Scalars['Float']['output']>;
  name: Maybe<Scalars['String']['output']>;
  unit: Maybe<Scalars['String']['output']>;
};

export type ScenarioVersion_Version_StartObservationSamplingConditions = {
  __typename?: 'ScenarioVersion_Version_StartObservationSamplingConditions';
  condition: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
};

export type ScenarioVersion_Version_TestObjectives = {
  __typename?: 'ScenarioVersion_Version_TestObjectives';
  criticalityMetrics: Maybe<Array<ScenarioVersion_Version_TestObjectives_CriticalityMetrics>>;
};

export type ScenarioVersion_Version_TestObjectives_CriticalityMetrics = {
  __typename?: 'ScenarioVersion_Version_TestObjectives_CriticalityMetrics';
  description: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
  keyPerformanceIndicator: Maybe<KeyPerformanceIndicator>;
  threshold: Maybe<Scalars['Float']['output']>;
};

export type ScenarioVersion_Version_ValidConditions = {
  __typename?: 'ScenarioVersion_Version_ValidConditions';
  condition: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
};

export enum ScenarioVersion_Version__Status {
  Draft = 'draft',
  Published = 'published'
}

export type Scenario_ObservationRecordingAgents = {
  __typename?: 'Scenario_ObservationRecordingAgents';
  id: Maybe<Scalars['String']['output']>;
  name: Maybe<Scalars['String']['output']>;
};

export type Scenario_OpenScenarioField = {
  __typename?: 'Scenario_OpenScenarioField';
  content: Maybe<Scalars['String']['output']>;
  openScenario: Maybe<OpenScenario>;
  type: Maybe<Scenario_OpenScenarioField_Type>;
};

export enum Scenario_OpenScenarioField_Type {
  File = 'File',
  String = 'String'
}

export enum Scenario_OpenScenarioField_Type_MutationInput {
  File = 'File',
  String = 'String'
}

export type Scenario_ParameterConstraints = {
  __typename?: 'Scenario_ParameterConstraints';
  expression: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
};

export type Scenario_Parameters = {
  __typename?: 'Scenario_Parameters';
  description: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
  max: Maybe<Scalars['Float']['output']>;
  min: Maybe<Scalars['Float']['output']>;
  name: Maybe<Scalars['String']['output']>;
  unit: Maybe<Scalars['String']['output']>;
};

export type Scenario_StartObservationSamplingConditions = {
  __typename?: 'Scenario_StartObservationSamplingConditions';
  condition: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
};

export type Scenario_TestObjectives = {
  __typename?: 'Scenario_TestObjectives';
  criticalityMetrics: Maybe<Array<Scenario_TestObjectives_CriticalityMetrics>>;
};

export type Scenario_TestObjectives_CriticalityMetrics = {
  __typename?: 'Scenario_TestObjectives_CriticalityMetrics';
  description: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
  keyPerformanceIndicator: Maybe<KeyPerformanceIndicator>;
  threshold: Maybe<Scalars['Float']['output']>;
};

export type Scenario_ValidConditions = {
  __typename?: 'Scenario_ValidConditions';
  condition: Maybe<Scalars['String']['output']>;
  id: Maybe<Scalars['String']['output']>;
};

export enum Scenario__Status {
  Draft = 'draft',
  Published = 'published'
}

export enum Scenario__Status_Input {
  Draft = 'draft',
  Published = 'published'
}

export enum Scenario__Status_MutationInput {
  Draft = 'draft',
  Published = 'published'
}

export type Scenario__Status_Operator = {
  all: InputMaybe<Array<InputMaybe<Scenario__Status_Input>>>;
  equals: InputMaybe<Scenario__Status_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scenario__Status_Input>>>;
  not_equals: InputMaybe<Scenario__Status_Input>;
  not_in: InputMaybe<Array<InputMaybe<Scenario__Status_Input>>>;
};

export type Scenario_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Scenario_Description_Operator = {
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
};

export type Scenario_EgoTargetSpeed_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Scenario_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Scenario_Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_ObservationRecordingAgents__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_ObservationRecordingAgents__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_OpenDrive_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Scenario_OpenScenarioField__Content_Operator = {
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
};

export type Scenario_OpenScenarioField__OpenScenario_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export enum Scenario_OpenScenarioField__Type_Input {
  File = 'File',
  String = 'String'
}

export type Scenario_OpenScenarioField__Type_Operator = {
  all: InputMaybe<Array<InputMaybe<Scenario_OpenScenarioField__Type_Input>>>;
  equals: InputMaybe<Scenario_OpenScenarioField__Type_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scenario_OpenScenarioField__Type_Input>>>;
  not_equals: InputMaybe<Scenario_OpenScenarioField__Type_Input>;
  not_in: InputMaybe<Array<InputMaybe<Scenario_OpenScenarioField__Type_Input>>>;
};

export type Scenario_ParameterConstraints__Expression_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_ParameterConstraints__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_Parameters__Description_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_Parameters__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_Parameters__Max_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Scenario_Parameters__Min_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Scenario_Parameters__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_Parameters__Unit_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_Schematic_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Scenario_StartObservationSamplingConditions__Condition_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_StartObservationSamplingConditions__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_TestObjectives__CriticalityMetrics__Description_Operator = {
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
};

export type Scenario_TestObjectives__CriticalityMetrics__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Scenario_TestObjectives__CriticalityMetrics__Threshold_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Scenario_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Scenario_ValidConditions__Condition_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_ValidConditions__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Scenario_Where = {
  AND: InputMaybe<Array<InputMaybe<Scenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Scenario_Where_Or>>>;
  _status: InputMaybe<Scenario__Status_Operator>;
  createdAt: InputMaybe<Scenario_CreatedAt_Operator>;
  description: InputMaybe<Scenario_Description_Operator>;
  egoTargetSpeed: InputMaybe<Scenario_EgoTargetSpeed_Operator>;
  id: InputMaybe<Scenario_Id_Operator>;
  name: InputMaybe<Scenario_Name_Operator>;
  observationRecordingAgents__id: InputMaybe<Scenario_ObservationRecordingAgents__Id_Operator>;
  observationRecordingAgents__name: InputMaybe<Scenario_ObservationRecordingAgents__Name_Operator>;
  openDrive: InputMaybe<Scenario_OpenDrive_Operator>;
  openScenarioField__content: InputMaybe<Scenario_OpenScenarioField__Content_Operator>;
  openScenarioField__openScenario: InputMaybe<Scenario_OpenScenarioField__OpenScenario_Operator>;
  openScenarioField__type: InputMaybe<Scenario_OpenScenarioField__Type_Operator>;
  parameterConstraints__expression: InputMaybe<Scenario_ParameterConstraints__Expression_Operator>;
  parameterConstraints__id: InputMaybe<Scenario_ParameterConstraints__Id_Operator>;
  parameters__description: InputMaybe<Scenario_Parameters__Description_Operator>;
  parameters__id: InputMaybe<Scenario_Parameters__Id_Operator>;
  parameters__max: InputMaybe<Scenario_Parameters__Max_Operator>;
  parameters__min: InputMaybe<Scenario_Parameters__Min_Operator>;
  parameters__name: InputMaybe<Scenario_Parameters__Name_Operator>;
  parameters__unit: InputMaybe<Scenario_Parameters__Unit_Operator>;
  schematic: InputMaybe<Scenario_Schematic_Operator>;
  startObservationSamplingConditions__condition: InputMaybe<Scenario_StartObservationSamplingConditions__Condition_Operator>;
  startObservationSamplingConditions__id: InputMaybe<Scenario_StartObservationSamplingConditions__Id_Operator>;
  testObjectives__criticalityMetrics__description: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Description_Operator>;
  testObjectives__criticalityMetrics__id: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Id_Operator>;
  testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  testObjectives__criticalityMetrics__threshold: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Threshold_Operator>;
  updatedAt: InputMaybe<Scenario_UpdatedAt_Operator>;
  validConditions__condition: InputMaybe<Scenario_ValidConditions__Condition_Operator>;
  validConditions__id: InputMaybe<Scenario_ValidConditions__Id_Operator>;
};

export type Scenario_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Scenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Scenario_Where_Or>>>;
  _status: InputMaybe<Scenario__Status_Operator>;
  createdAt: InputMaybe<Scenario_CreatedAt_Operator>;
  description: InputMaybe<Scenario_Description_Operator>;
  egoTargetSpeed: InputMaybe<Scenario_EgoTargetSpeed_Operator>;
  id: InputMaybe<Scenario_Id_Operator>;
  name: InputMaybe<Scenario_Name_Operator>;
  observationRecordingAgents__id: InputMaybe<Scenario_ObservationRecordingAgents__Id_Operator>;
  observationRecordingAgents__name: InputMaybe<Scenario_ObservationRecordingAgents__Name_Operator>;
  openDrive: InputMaybe<Scenario_OpenDrive_Operator>;
  openScenarioField__content: InputMaybe<Scenario_OpenScenarioField__Content_Operator>;
  openScenarioField__openScenario: InputMaybe<Scenario_OpenScenarioField__OpenScenario_Operator>;
  openScenarioField__type: InputMaybe<Scenario_OpenScenarioField__Type_Operator>;
  parameterConstraints__expression: InputMaybe<Scenario_ParameterConstraints__Expression_Operator>;
  parameterConstraints__id: InputMaybe<Scenario_ParameterConstraints__Id_Operator>;
  parameters__description: InputMaybe<Scenario_Parameters__Description_Operator>;
  parameters__id: InputMaybe<Scenario_Parameters__Id_Operator>;
  parameters__max: InputMaybe<Scenario_Parameters__Max_Operator>;
  parameters__min: InputMaybe<Scenario_Parameters__Min_Operator>;
  parameters__name: InputMaybe<Scenario_Parameters__Name_Operator>;
  parameters__unit: InputMaybe<Scenario_Parameters__Unit_Operator>;
  schematic: InputMaybe<Scenario_Schematic_Operator>;
  startObservationSamplingConditions__condition: InputMaybe<Scenario_StartObservationSamplingConditions__Condition_Operator>;
  startObservationSamplingConditions__id: InputMaybe<Scenario_StartObservationSamplingConditions__Id_Operator>;
  testObjectives__criticalityMetrics__description: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Description_Operator>;
  testObjectives__criticalityMetrics__id: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Id_Operator>;
  testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  testObjectives__criticalityMetrics__threshold: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Threshold_Operator>;
  updatedAt: InputMaybe<Scenario_UpdatedAt_Operator>;
  validConditions__condition: InputMaybe<Scenario_ValidConditions__Condition_Operator>;
  validConditions__id: InputMaybe<Scenario_ValidConditions__Id_Operator>;
};

export type Scenario_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Scenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Scenario_Where_Or>>>;
  _status: InputMaybe<Scenario__Status_Operator>;
  createdAt: InputMaybe<Scenario_CreatedAt_Operator>;
  description: InputMaybe<Scenario_Description_Operator>;
  egoTargetSpeed: InputMaybe<Scenario_EgoTargetSpeed_Operator>;
  id: InputMaybe<Scenario_Id_Operator>;
  name: InputMaybe<Scenario_Name_Operator>;
  observationRecordingAgents__id: InputMaybe<Scenario_ObservationRecordingAgents__Id_Operator>;
  observationRecordingAgents__name: InputMaybe<Scenario_ObservationRecordingAgents__Name_Operator>;
  openDrive: InputMaybe<Scenario_OpenDrive_Operator>;
  openScenarioField__content: InputMaybe<Scenario_OpenScenarioField__Content_Operator>;
  openScenarioField__openScenario: InputMaybe<Scenario_OpenScenarioField__OpenScenario_Operator>;
  openScenarioField__type: InputMaybe<Scenario_OpenScenarioField__Type_Operator>;
  parameterConstraints__expression: InputMaybe<Scenario_ParameterConstraints__Expression_Operator>;
  parameterConstraints__id: InputMaybe<Scenario_ParameterConstraints__Id_Operator>;
  parameters__description: InputMaybe<Scenario_Parameters__Description_Operator>;
  parameters__id: InputMaybe<Scenario_Parameters__Id_Operator>;
  parameters__max: InputMaybe<Scenario_Parameters__Max_Operator>;
  parameters__min: InputMaybe<Scenario_Parameters__Min_Operator>;
  parameters__name: InputMaybe<Scenario_Parameters__Name_Operator>;
  parameters__unit: InputMaybe<Scenario_Parameters__Unit_Operator>;
  schematic: InputMaybe<Scenario_Schematic_Operator>;
  startObservationSamplingConditions__condition: InputMaybe<Scenario_StartObservationSamplingConditions__Condition_Operator>;
  startObservationSamplingConditions__id: InputMaybe<Scenario_StartObservationSamplingConditions__Id_Operator>;
  testObjectives__criticalityMetrics__description: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Description_Operator>;
  testObjectives__criticalityMetrics__id: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Id_Operator>;
  testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  testObjectives__criticalityMetrics__threshold: InputMaybe<Scenario_TestObjectives__CriticalityMetrics__Threshold_Operator>;
  updatedAt: InputMaybe<Scenario_UpdatedAt_Operator>;
  validConditions__condition: InputMaybe<Scenario_ValidConditions__Condition_Operator>;
  validConditions__id: InputMaybe<Scenario_ValidConditions__Id_Operator>;
};

export type Scenarios = {
  __typename?: 'Scenarios';
  docs: Array<Scenario>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type ScenariosCreateAccess = {
  __typename?: 'ScenariosCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosCreateDocAccess = {
  __typename?: 'ScenariosCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosDeleteAccess = {
  __typename?: 'ScenariosDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosDeleteDocAccess = {
  __typename?: 'ScenariosDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosDocAccessFields = {
  __typename?: 'ScenariosDocAccessFields';
  _status: Maybe<ScenariosDocAccessFields__Status>;
  createdAt: Maybe<ScenariosDocAccessFields_CreatedAt>;
  description: Maybe<ScenariosDocAccessFields_Description>;
  egoTargetSpeed: Maybe<ScenariosDocAccessFields_EgoTargetSpeed>;
  name: Maybe<ScenariosDocAccessFields_Name>;
  observationRecordingAgents: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents>;
  openDrive: Maybe<ScenariosDocAccessFields_OpenDrive>;
  openScenarioField: Maybe<ScenariosDocAccessFields_OpenScenarioField>;
  parameterConstraints: Maybe<ScenariosDocAccessFields_ParameterConstraints>;
  parameters: Maybe<ScenariosDocAccessFields_Parameters>;
  schematic: Maybe<ScenariosDocAccessFields_Schematic>;
  startObservationSamplingConditions: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions>;
  testObjectives: Maybe<ScenariosDocAccessFields_TestObjectives>;
  updatedAt: Maybe<ScenariosDocAccessFields_UpdatedAt>;
  validConditions: Maybe<ScenariosDocAccessFields_ValidConditions>;
};

export type ScenariosDocAccessFields__Status = {
  __typename?: 'ScenariosDocAccessFields__status';
  create: Maybe<ScenariosDocAccessFields__Status_Create>;
  delete: Maybe<ScenariosDocAccessFields__Status_Delete>;
  read: Maybe<ScenariosDocAccessFields__Status_Read>;
  update: Maybe<ScenariosDocAccessFields__Status_Update>;
};

export type ScenariosDocAccessFields__Status_Create = {
  __typename?: 'ScenariosDocAccessFields__status_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields__Status_Delete = {
  __typename?: 'ScenariosDocAccessFields__status_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields__Status_Read = {
  __typename?: 'ScenariosDocAccessFields__status_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields__Status_Update = {
  __typename?: 'ScenariosDocAccessFields__status_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_CreatedAt = {
  __typename?: 'ScenariosDocAccessFields_createdAt';
  create: Maybe<ScenariosDocAccessFields_CreatedAt_Create>;
  delete: Maybe<ScenariosDocAccessFields_CreatedAt_Delete>;
  read: Maybe<ScenariosDocAccessFields_CreatedAt_Read>;
  update: Maybe<ScenariosDocAccessFields_CreatedAt_Update>;
};

export type ScenariosDocAccessFields_CreatedAt_Create = {
  __typename?: 'ScenariosDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_CreatedAt_Delete = {
  __typename?: 'ScenariosDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_CreatedAt_Read = {
  __typename?: 'ScenariosDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_CreatedAt_Update = {
  __typename?: 'ScenariosDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Description = {
  __typename?: 'ScenariosDocAccessFields_description';
  create: Maybe<ScenariosDocAccessFields_Description_Create>;
  delete: Maybe<ScenariosDocAccessFields_Description_Delete>;
  read: Maybe<ScenariosDocAccessFields_Description_Read>;
  update: Maybe<ScenariosDocAccessFields_Description_Update>;
};

export type ScenariosDocAccessFields_Description_Create = {
  __typename?: 'ScenariosDocAccessFields_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Description_Delete = {
  __typename?: 'ScenariosDocAccessFields_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Description_Read = {
  __typename?: 'ScenariosDocAccessFields_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Description_Update = {
  __typename?: 'ScenariosDocAccessFields_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_EgoTargetSpeed = {
  __typename?: 'ScenariosDocAccessFields_egoTargetSpeed';
  create: Maybe<ScenariosDocAccessFields_EgoTargetSpeed_Create>;
  delete: Maybe<ScenariosDocAccessFields_EgoTargetSpeed_Delete>;
  read: Maybe<ScenariosDocAccessFields_EgoTargetSpeed_Read>;
  update: Maybe<ScenariosDocAccessFields_EgoTargetSpeed_Update>;
};

export type ScenariosDocAccessFields_EgoTargetSpeed_Create = {
  __typename?: 'ScenariosDocAccessFields_egoTargetSpeed_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_EgoTargetSpeed_Delete = {
  __typename?: 'ScenariosDocAccessFields_egoTargetSpeed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_EgoTargetSpeed_Read = {
  __typename?: 'ScenariosDocAccessFields_egoTargetSpeed_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_EgoTargetSpeed_Update = {
  __typename?: 'ScenariosDocAccessFields_egoTargetSpeed_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Name = {
  __typename?: 'ScenariosDocAccessFields_name';
  create: Maybe<ScenariosDocAccessFields_Name_Create>;
  delete: Maybe<ScenariosDocAccessFields_Name_Delete>;
  read: Maybe<ScenariosDocAccessFields_Name_Read>;
  update: Maybe<ScenariosDocAccessFields_Name_Update>;
};

export type ScenariosDocAccessFields_Name_Create = {
  __typename?: 'ScenariosDocAccessFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Name_Delete = {
  __typename?: 'ScenariosDocAccessFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Name_Read = {
  __typename?: 'ScenariosDocAccessFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Name_Update = {
  __typename?: 'ScenariosDocAccessFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents';
  create: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Create>;
  delete: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Delete>;
  fields: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Fields>;
  read: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Read>;
  update: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Update>;
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Create = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Delete = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Fields = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_Fields';
  id: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Id>;
  name: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Name>;
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Read = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Update = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Id = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_id';
  create: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Id_Create>;
  delete: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Id_Delete>;
  read: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Id_Read>;
  update: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Id_Update>;
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Id_Create = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Id_Delete = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Id_Read = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Id_Update = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Name = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_name';
  create: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Name_Create>;
  delete: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Name_Delete>;
  read: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Name_Read>;
  update: Maybe<ScenariosDocAccessFields_ObservationRecordingAgents_Name_Update>;
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Name_Create = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Name_Delete = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Name_Read = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ObservationRecordingAgents_Name_Update = {
  __typename?: 'ScenariosDocAccessFields_observationRecordingAgents_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenDrive = {
  __typename?: 'ScenariosDocAccessFields_openDrive';
  create: Maybe<ScenariosDocAccessFields_OpenDrive_Create>;
  delete: Maybe<ScenariosDocAccessFields_OpenDrive_Delete>;
  read: Maybe<ScenariosDocAccessFields_OpenDrive_Read>;
  update: Maybe<ScenariosDocAccessFields_OpenDrive_Update>;
};

export type ScenariosDocAccessFields_OpenDrive_Create = {
  __typename?: 'ScenariosDocAccessFields_openDrive_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenDrive_Delete = {
  __typename?: 'ScenariosDocAccessFields_openDrive_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenDrive_Read = {
  __typename?: 'ScenariosDocAccessFields_openDrive_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenDrive_Update = {
  __typename?: 'ScenariosDocAccessFields_openDrive_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField';
  create: Maybe<ScenariosDocAccessFields_OpenScenarioField_Create>;
  delete: Maybe<ScenariosDocAccessFields_OpenScenarioField_Delete>;
  fields: Maybe<ScenariosDocAccessFields_OpenScenarioField_Fields>;
  read: Maybe<ScenariosDocAccessFields_OpenScenarioField_Read>;
  update: Maybe<ScenariosDocAccessFields_OpenScenarioField_Update>;
};

export type ScenariosDocAccessFields_OpenScenarioField_Create = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Delete = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Fields = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_Fields';
  content: Maybe<ScenariosDocAccessFields_OpenScenarioField_Content>;
  openScenario: Maybe<ScenariosDocAccessFields_OpenScenarioField_OpenScenario>;
  type: Maybe<ScenariosDocAccessFields_OpenScenarioField_Type>;
};

export type ScenariosDocAccessFields_OpenScenarioField_Read = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Update = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Content = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_content';
  create: Maybe<ScenariosDocAccessFields_OpenScenarioField_Content_Create>;
  delete: Maybe<ScenariosDocAccessFields_OpenScenarioField_Content_Delete>;
  read: Maybe<ScenariosDocAccessFields_OpenScenarioField_Content_Read>;
  update: Maybe<ScenariosDocAccessFields_OpenScenarioField_Content_Update>;
};

export type ScenariosDocAccessFields_OpenScenarioField_Content_Create = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_content_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Content_Delete = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_content_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Content_Read = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_content_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Content_Update = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_content_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_OpenScenario = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_openScenario';
  create: Maybe<ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Create>;
  delete: Maybe<ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Delete>;
  read: Maybe<ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Read>;
  update: Maybe<ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Update>;
};

export type ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Create = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_openScenario_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Delete = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_openScenario_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Read = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_openScenario_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_OpenScenario_Update = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_openScenario_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Type = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_type';
  create: Maybe<ScenariosDocAccessFields_OpenScenarioField_Type_Create>;
  delete: Maybe<ScenariosDocAccessFields_OpenScenarioField_Type_Delete>;
  read: Maybe<ScenariosDocAccessFields_OpenScenarioField_Type_Read>;
  update: Maybe<ScenariosDocAccessFields_OpenScenarioField_Type_Update>;
};

export type ScenariosDocAccessFields_OpenScenarioField_Type_Create = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_type_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Type_Delete = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_type_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Type_Read = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_type_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_OpenScenarioField_Type_Update = {
  __typename?: 'ScenariosDocAccessFields_openScenarioField_type_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints';
  create: Maybe<ScenariosDocAccessFields_ParameterConstraints_Create>;
  delete: Maybe<ScenariosDocAccessFields_ParameterConstraints_Delete>;
  fields: Maybe<ScenariosDocAccessFields_ParameterConstraints_Fields>;
  read: Maybe<ScenariosDocAccessFields_ParameterConstraints_Read>;
  update: Maybe<ScenariosDocAccessFields_ParameterConstraints_Update>;
};

export type ScenariosDocAccessFields_ParameterConstraints_Create = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Fields = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_Fields';
  expression: Maybe<ScenariosDocAccessFields_ParameterConstraints_Expression>;
  id: Maybe<ScenariosDocAccessFields_ParameterConstraints_Id>;
};

export type ScenariosDocAccessFields_ParameterConstraints_Read = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Update = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Expression = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_expression';
  create: Maybe<ScenariosDocAccessFields_ParameterConstraints_Expression_Create>;
  delete: Maybe<ScenariosDocAccessFields_ParameterConstraints_Expression_Delete>;
  read: Maybe<ScenariosDocAccessFields_ParameterConstraints_Expression_Read>;
  update: Maybe<ScenariosDocAccessFields_ParameterConstraints_Expression_Update>;
};

export type ScenariosDocAccessFields_ParameterConstraints_Expression_Create = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_expression_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Expression_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_expression_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Expression_Read = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_expression_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Expression_Update = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_expression_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Id = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_id';
  create: Maybe<ScenariosDocAccessFields_ParameterConstraints_Id_Create>;
  delete: Maybe<ScenariosDocAccessFields_ParameterConstraints_Id_Delete>;
  read: Maybe<ScenariosDocAccessFields_ParameterConstraints_Id_Read>;
  update: Maybe<ScenariosDocAccessFields_ParameterConstraints_Id_Update>;
};

export type ScenariosDocAccessFields_ParameterConstraints_Id_Create = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Id_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Id_Read = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ParameterConstraints_Id_Update = {
  __typename?: 'ScenariosDocAccessFields_parameterConstraints_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters = {
  __typename?: 'ScenariosDocAccessFields_parameters';
  create: Maybe<ScenariosDocAccessFields_Parameters_Create>;
  delete: Maybe<ScenariosDocAccessFields_Parameters_Delete>;
  fields: Maybe<ScenariosDocAccessFields_Parameters_Fields>;
  read: Maybe<ScenariosDocAccessFields_Parameters_Read>;
  update: Maybe<ScenariosDocAccessFields_Parameters_Update>;
};

export type ScenariosDocAccessFields_Parameters_Create = {
  __typename?: 'ScenariosDocAccessFields_parameters_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameters_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Fields = {
  __typename?: 'ScenariosDocAccessFields_parameters_Fields';
  description: Maybe<ScenariosDocAccessFields_Parameters_Description>;
  id: Maybe<ScenariosDocAccessFields_Parameters_Id>;
  max: Maybe<ScenariosDocAccessFields_Parameters_Max>;
  min: Maybe<ScenariosDocAccessFields_Parameters_Min>;
  name: Maybe<ScenariosDocAccessFields_Parameters_Name>;
  unit: Maybe<ScenariosDocAccessFields_Parameters_Unit>;
};

export type ScenariosDocAccessFields_Parameters_Read = {
  __typename?: 'ScenariosDocAccessFields_parameters_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Update = {
  __typename?: 'ScenariosDocAccessFields_parameters_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Description = {
  __typename?: 'ScenariosDocAccessFields_parameters_description';
  create: Maybe<ScenariosDocAccessFields_Parameters_Description_Create>;
  delete: Maybe<ScenariosDocAccessFields_Parameters_Description_Delete>;
  read: Maybe<ScenariosDocAccessFields_Parameters_Description_Read>;
  update: Maybe<ScenariosDocAccessFields_Parameters_Description_Update>;
};

export type ScenariosDocAccessFields_Parameters_Description_Create = {
  __typename?: 'ScenariosDocAccessFields_parameters_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Description_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameters_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Description_Read = {
  __typename?: 'ScenariosDocAccessFields_parameters_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Description_Update = {
  __typename?: 'ScenariosDocAccessFields_parameters_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Id = {
  __typename?: 'ScenariosDocAccessFields_parameters_id';
  create: Maybe<ScenariosDocAccessFields_Parameters_Id_Create>;
  delete: Maybe<ScenariosDocAccessFields_Parameters_Id_Delete>;
  read: Maybe<ScenariosDocAccessFields_Parameters_Id_Read>;
  update: Maybe<ScenariosDocAccessFields_Parameters_Id_Update>;
};

export type ScenariosDocAccessFields_Parameters_Id_Create = {
  __typename?: 'ScenariosDocAccessFields_parameters_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Id_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameters_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Id_Read = {
  __typename?: 'ScenariosDocAccessFields_parameters_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Id_Update = {
  __typename?: 'ScenariosDocAccessFields_parameters_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Max = {
  __typename?: 'ScenariosDocAccessFields_parameters_max';
  create: Maybe<ScenariosDocAccessFields_Parameters_Max_Create>;
  delete: Maybe<ScenariosDocAccessFields_Parameters_Max_Delete>;
  read: Maybe<ScenariosDocAccessFields_Parameters_Max_Read>;
  update: Maybe<ScenariosDocAccessFields_Parameters_Max_Update>;
};

export type ScenariosDocAccessFields_Parameters_Max_Create = {
  __typename?: 'ScenariosDocAccessFields_parameters_max_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Max_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameters_max_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Max_Read = {
  __typename?: 'ScenariosDocAccessFields_parameters_max_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Max_Update = {
  __typename?: 'ScenariosDocAccessFields_parameters_max_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Min = {
  __typename?: 'ScenariosDocAccessFields_parameters_min';
  create: Maybe<ScenariosDocAccessFields_Parameters_Min_Create>;
  delete: Maybe<ScenariosDocAccessFields_Parameters_Min_Delete>;
  read: Maybe<ScenariosDocAccessFields_Parameters_Min_Read>;
  update: Maybe<ScenariosDocAccessFields_Parameters_Min_Update>;
};

export type ScenariosDocAccessFields_Parameters_Min_Create = {
  __typename?: 'ScenariosDocAccessFields_parameters_min_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Min_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameters_min_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Min_Read = {
  __typename?: 'ScenariosDocAccessFields_parameters_min_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Min_Update = {
  __typename?: 'ScenariosDocAccessFields_parameters_min_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Name = {
  __typename?: 'ScenariosDocAccessFields_parameters_name';
  create: Maybe<ScenariosDocAccessFields_Parameters_Name_Create>;
  delete: Maybe<ScenariosDocAccessFields_Parameters_Name_Delete>;
  read: Maybe<ScenariosDocAccessFields_Parameters_Name_Read>;
  update: Maybe<ScenariosDocAccessFields_Parameters_Name_Update>;
};

export type ScenariosDocAccessFields_Parameters_Name_Create = {
  __typename?: 'ScenariosDocAccessFields_parameters_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Name_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameters_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Name_Read = {
  __typename?: 'ScenariosDocAccessFields_parameters_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Name_Update = {
  __typename?: 'ScenariosDocAccessFields_parameters_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Unit = {
  __typename?: 'ScenariosDocAccessFields_parameters_unit';
  create: Maybe<ScenariosDocAccessFields_Parameters_Unit_Create>;
  delete: Maybe<ScenariosDocAccessFields_Parameters_Unit_Delete>;
  read: Maybe<ScenariosDocAccessFields_Parameters_Unit_Read>;
  update: Maybe<ScenariosDocAccessFields_Parameters_Unit_Update>;
};

export type ScenariosDocAccessFields_Parameters_Unit_Create = {
  __typename?: 'ScenariosDocAccessFields_parameters_unit_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Unit_Delete = {
  __typename?: 'ScenariosDocAccessFields_parameters_unit_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Unit_Read = {
  __typename?: 'ScenariosDocAccessFields_parameters_unit_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Parameters_Unit_Update = {
  __typename?: 'ScenariosDocAccessFields_parameters_unit_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Schematic = {
  __typename?: 'ScenariosDocAccessFields_schematic';
  create: Maybe<ScenariosDocAccessFields_Schematic_Create>;
  delete: Maybe<ScenariosDocAccessFields_Schematic_Delete>;
  read: Maybe<ScenariosDocAccessFields_Schematic_Read>;
  update: Maybe<ScenariosDocAccessFields_Schematic_Update>;
};

export type ScenariosDocAccessFields_Schematic_Create = {
  __typename?: 'ScenariosDocAccessFields_schematic_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Schematic_Delete = {
  __typename?: 'ScenariosDocAccessFields_schematic_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Schematic_Read = {
  __typename?: 'ScenariosDocAccessFields_schematic_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_Schematic_Update = {
  __typename?: 'ScenariosDocAccessFields_schematic_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions';
  create: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Create>;
  delete: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Delete>;
  fields: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Fields>;
  read: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Read>;
  update: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Update>;
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Create = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Delete = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Fields = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_Fields';
  condition: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Condition>;
  id: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Id>;
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Read = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Update = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Condition = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_condition';
  create: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Create>;
  delete: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Delete>;
  read: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Read>;
  update: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Update>;
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Create = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_condition_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Delete = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_condition_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Read = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_condition_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Condition_Update = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_condition_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Id = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_id';
  create: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Create>;
  delete: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Delete>;
  read: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Read>;
  update: Maybe<ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Update>;
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Create = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Delete = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Read = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_StartObservationSamplingConditions_Id_Update = {
  __typename?: 'ScenariosDocAccessFields_startObservationSamplingConditions_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives = {
  __typename?: 'ScenariosDocAccessFields_testObjectives';
  create: Maybe<ScenariosDocAccessFields_TestObjectives_Create>;
  delete: Maybe<ScenariosDocAccessFields_TestObjectives_Delete>;
  fields: Maybe<ScenariosDocAccessFields_TestObjectives_Fields>;
  read: Maybe<ScenariosDocAccessFields_TestObjectives_Read>;
  update: Maybe<ScenariosDocAccessFields_TestObjectives_Update>;
};

export type ScenariosDocAccessFields_TestObjectives_Create = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_Delete = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_Fields = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_Fields';
  criticalityMetrics: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics>;
};

export type ScenariosDocAccessFields_TestObjectives_Read = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_Update = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics';
  create: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Create>;
  delete: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Delete>;
  fields: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Fields>;
  read: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Read>;
  update: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Update>;
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Create = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Delete = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Fields = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_Fields';
  description: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description>;
  id: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id>;
  keyPerformanceIndicator: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator>;
  threshold: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold>;
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Read = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Update = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_description';
  create: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Create>;
  delete: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Delete>;
  read: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Read>;
  update: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Update>;
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Create = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Delete = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Read = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Description_Update = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_id';
  create: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Create>;
  delete: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Delete>;
  read: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Read>;
  update: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Update>;
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Create = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Delete = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Read = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Id_Update = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator';
  create: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create>;
  delete: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete>;
  read: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read>;
  update: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update>;
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_threshold';
  create: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Create>;
  delete: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Delete>;
  read: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Read>;
  update: Maybe<ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Update>;
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Create = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_threshold_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Delete = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_threshold_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Read = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_threshold_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_TestObjectives_CriticalityMetrics_Threshold_Update = {
  __typename?: 'ScenariosDocAccessFields_testObjectives_criticalityMetrics_threshold_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_UpdatedAt = {
  __typename?: 'ScenariosDocAccessFields_updatedAt';
  create: Maybe<ScenariosDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<ScenariosDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<ScenariosDocAccessFields_UpdatedAt_Read>;
  update: Maybe<ScenariosDocAccessFields_UpdatedAt_Update>;
};

export type ScenariosDocAccessFields_UpdatedAt_Create = {
  __typename?: 'ScenariosDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'ScenariosDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_UpdatedAt_Read = {
  __typename?: 'ScenariosDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_UpdatedAt_Update = {
  __typename?: 'ScenariosDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions = {
  __typename?: 'ScenariosDocAccessFields_validConditions';
  create: Maybe<ScenariosDocAccessFields_ValidConditions_Create>;
  delete: Maybe<ScenariosDocAccessFields_ValidConditions_Delete>;
  fields: Maybe<ScenariosDocAccessFields_ValidConditions_Fields>;
  read: Maybe<ScenariosDocAccessFields_ValidConditions_Read>;
  update: Maybe<ScenariosDocAccessFields_ValidConditions_Update>;
};

export type ScenariosDocAccessFields_ValidConditions_Create = {
  __typename?: 'ScenariosDocAccessFields_validConditions_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Delete = {
  __typename?: 'ScenariosDocAccessFields_validConditions_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Fields = {
  __typename?: 'ScenariosDocAccessFields_validConditions_Fields';
  condition: Maybe<ScenariosDocAccessFields_ValidConditions_Condition>;
  id: Maybe<ScenariosDocAccessFields_ValidConditions_Id>;
};

export type ScenariosDocAccessFields_ValidConditions_Read = {
  __typename?: 'ScenariosDocAccessFields_validConditions_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Update = {
  __typename?: 'ScenariosDocAccessFields_validConditions_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Condition = {
  __typename?: 'ScenariosDocAccessFields_validConditions_condition';
  create: Maybe<ScenariosDocAccessFields_ValidConditions_Condition_Create>;
  delete: Maybe<ScenariosDocAccessFields_ValidConditions_Condition_Delete>;
  read: Maybe<ScenariosDocAccessFields_ValidConditions_Condition_Read>;
  update: Maybe<ScenariosDocAccessFields_ValidConditions_Condition_Update>;
};

export type ScenariosDocAccessFields_ValidConditions_Condition_Create = {
  __typename?: 'ScenariosDocAccessFields_validConditions_condition_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Condition_Delete = {
  __typename?: 'ScenariosDocAccessFields_validConditions_condition_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Condition_Read = {
  __typename?: 'ScenariosDocAccessFields_validConditions_condition_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Condition_Update = {
  __typename?: 'ScenariosDocAccessFields_validConditions_condition_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Id = {
  __typename?: 'ScenariosDocAccessFields_validConditions_id';
  create: Maybe<ScenariosDocAccessFields_ValidConditions_Id_Create>;
  delete: Maybe<ScenariosDocAccessFields_ValidConditions_Id_Delete>;
  read: Maybe<ScenariosDocAccessFields_ValidConditions_Id_Read>;
  update: Maybe<ScenariosDocAccessFields_ValidConditions_Id_Update>;
};

export type ScenariosDocAccessFields_ValidConditions_Id_Create = {
  __typename?: 'ScenariosDocAccessFields_validConditions_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Id_Delete = {
  __typename?: 'ScenariosDocAccessFields_validConditions_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Id_Read = {
  __typename?: 'ScenariosDocAccessFields_validConditions_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosDocAccessFields_ValidConditions_Id_Update = {
  __typename?: 'ScenariosDocAccessFields_validConditions_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields = {
  __typename?: 'ScenariosFields';
  _status: Maybe<ScenariosFields__Status>;
  createdAt: Maybe<ScenariosFields_CreatedAt>;
  description: Maybe<ScenariosFields_Description>;
  egoTargetSpeed: Maybe<ScenariosFields_EgoTargetSpeed>;
  name: Maybe<ScenariosFields_Name>;
  observationRecordingAgents: Maybe<ScenariosFields_ObservationRecordingAgents>;
  openDrive: Maybe<ScenariosFields_OpenDrive>;
  openScenarioField: Maybe<ScenariosFields_OpenScenarioField>;
  parameterConstraints: Maybe<ScenariosFields_ParameterConstraints>;
  parameters: Maybe<ScenariosFields_Parameters>;
  schematic: Maybe<ScenariosFields_Schematic>;
  startObservationSamplingConditions: Maybe<ScenariosFields_StartObservationSamplingConditions>;
  testObjectives: Maybe<ScenariosFields_TestObjectives>;
  updatedAt: Maybe<ScenariosFields_UpdatedAt>;
  validConditions: Maybe<ScenariosFields_ValidConditions>;
};

export type ScenariosFields__Status = {
  __typename?: 'ScenariosFields__status';
  create: Maybe<ScenariosFields__Status_Create>;
  delete: Maybe<ScenariosFields__Status_Delete>;
  read: Maybe<ScenariosFields__Status_Read>;
  update: Maybe<ScenariosFields__Status_Update>;
};

export type ScenariosFields__Status_Create = {
  __typename?: 'ScenariosFields__status_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields__Status_Delete = {
  __typename?: 'ScenariosFields__status_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields__Status_Read = {
  __typename?: 'ScenariosFields__status_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields__Status_Update = {
  __typename?: 'ScenariosFields__status_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_CreatedAt = {
  __typename?: 'ScenariosFields_createdAt';
  create: Maybe<ScenariosFields_CreatedAt_Create>;
  delete: Maybe<ScenariosFields_CreatedAt_Delete>;
  read: Maybe<ScenariosFields_CreatedAt_Read>;
  update: Maybe<ScenariosFields_CreatedAt_Update>;
};

export type ScenariosFields_CreatedAt_Create = {
  __typename?: 'ScenariosFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_CreatedAt_Delete = {
  __typename?: 'ScenariosFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_CreatedAt_Read = {
  __typename?: 'ScenariosFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_CreatedAt_Update = {
  __typename?: 'ScenariosFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Description = {
  __typename?: 'ScenariosFields_description';
  create: Maybe<ScenariosFields_Description_Create>;
  delete: Maybe<ScenariosFields_Description_Delete>;
  read: Maybe<ScenariosFields_Description_Read>;
  update: Maybe<ScenariosFields_Description_Update>;
};

export type ScenariosFields_Description_Create = {
  __typename?: 'ScenariosFields_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Description_Delete = {
  __typename?: 'ScenariosFields_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Description_Read = {
  __typename?: 'ScenariosFields_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Description_Update = {
  __typename?: 'ScenariosFields_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_EgoTargetSpeed = {
  __typename?: 'ScenariosFields_egoTargetSpeed';
  create: Maybe<ScenariosFields_EgoTargetSpeed_Create>;
  delete: Maybe<ScenariosFields_EgoTargetSpeed_Delete>;
  read: Maybe<ScenariosFields_EgoTargetSpeed_Read>;
  update: Maybe<ScenariosFields_EgoTargetSpeed_Update>;
};

export type ScenariosFields_EgoTargetSpeed_Create = {
  __typename?: 'ScenariosFields_egoTargetSpeed_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_EgoTargetSpeed_Delete = {
  __typename?: 'ScenariosFields_egoTargetSpeed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_EgoTargetSpeed_Read = {
  __typename?: 'ScenariosFields_egoTargetSpeed_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_EgoTargetSpeed_Update = {
  __typename?: 'ScenariosFields_egoTargetSpeed_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Name = {
  __typename?: 'ScenariosFields_name';
  create: Maybe<ScenariosFields_Name_Create>;
  delete: Maybe<ScenariosFields_Name_Delete>;
  read: Maybe<ScenariosFields_Name_Read>;
  update: Maybe<ScenariosFields_Name_Update>;
};

export type ScenariosFields_Name_Create = {
  __typename?: 'ScenariosFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Name_Delete = {
  __typename?: 'ScenariosFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Name_Read = {
  __typename?: 'ScenariosFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Name_Update = {
  __typename?: 'ScenariosFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents = {
  __typename?: 'ScenariosFields_observationRecordingAgents';
  create: Maybe<ScenariosFields_ObservationRecordingAgents_Create>;
  delete: Maybe<ScenariosFields_ObservationRecordingAgents_Delete>;
  fields: Maybe<ScenariosFields_ObservationRecordingAgents_Fields>;
  read: Maybe<ScenariosFields_ObservationRecordingAgents_Read>;
  update: Maybe<ScenariosFields_ObservationRecordingAgents_Update>;
};

export type ScenariosFields_ObservationRecordingAgents_Create = {
  __typename?: 'ScenariosFields_observationRecordingAgents_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Delete = {
  __typename?: 'ScenariosFields_observationRecordingAgents_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Fields = {
  __typename?: 'ScenariosFields_observationRecordingAgents_Fields';
  id: Maybe<ScenariosFields_ObservationRecordingAgents_Id>;
  name: Maybe<ScenariosFields_ObservationRecordingAgents_Name>;
};

export type ScenariosFields_ObservationRecordingAgents_Read = {
  __typename?: 'ScenariosFields_observationRecordingAgents_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Update = {
  __typename?: 'ScenariosFields_observationRecordingAgents_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Id = {
  __typename?: 'ScenariosFields_observationRecordingAgents_id';
  create: Maybe<ScenariosFields_ObservationRecordingAgents_Id_Create>;
  delete: Maybe<ScenariosFields_ObservationRecordingAgents_Id_Delete>;
  read: Maybe<ScenariosFields_ObservationRecordingAgents_Id_Read>;
  update: Maybe<ScenariosFields_ObservationRecordingAgents_Id_Update>;
};

export type ScenariosFields_ObservationRecordingAgents_Id_Create = {
  __typename?: 'ScenariosFields_observationRecordingAgents_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Id_Delete = {
  __typename?: 'ScenariosFields_observationRecordingAgents_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Id_Read = {
  __typename?: 'ScenariosFields_observationRecordingAgents_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Id_Update = {
  __typename?: 'ScenariosFields_observationRecordingAgents_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Name = {
  __typename?: 'ScenariosFields_observationRecordingAgents_name';
  create: Maybe<ScenariosFields_ObservationRecordingAgents_Name_Create>;
  delete: Maybe<ScenariosFields_ObservationRecordingAgents_Name_Delete>;
  read: Maybe<ScenariosFields_ObservationRecordingAgents_Name_Read>;
  update: Maybe<ScenariosFields_ObservationRecordingAgents_Name_Update>;
};

export type ScenariosFields_ObservationRecordingAgents_Name_Create = {
  __typename?: 'ScenariosFields_observationRecordingAgents_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Name_Delete = {
  __typename?: 'ScenariosFields_observationRecordingAgents_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Name_Read = {
  __typename?: 'ScenariosFields_observationRecordingAgents_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ObservationRecordingAgents_Name_Update = {
  __typename?: 'ScenariosFields_observationRecordingAgents_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenDrive = {
  __typename?: 'ScenariosFields_openDrive';
  create: Maybe<ScenariosFields_OpenDrive_Create>;
  delete: Maybe<ScenariosFields_OpenDrive_Delete>;
  read: Maybe<ScenariosFields_OpenDrive_Read>;
  update: Maybe<ScenariosFields_OpenDrive_Update>;
};

export type ScenariosFields_OpenDrive_Create = {
  __typename?: 'ScenariosFields_openDrive_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenDrive_Delete = {
  __typename?: 'ScenariosFields_openDrive_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenDrive_Read = {
  __typename?: 'ScenariosFields_openDrive_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenDrive_Update = {
  __typename?: 'ScenariosFields_openDrive_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField = {
  __typename?: 'ScenariosFields_openScenarioField';
  create: Maybe<ScenariosFields_OpenScenarioField_Create>;
  delete: Maybe<ScenariosFields_OpenScenarioField_Delete>;
  fields: Maybe<ScenariosFields_OpenScenarioField_Fields>;
  read: Maybe<ScenariosFields_OpenScenarioField_Read>;
  update: Maybe<ScenariosFields_OpenScenarioField_Update>;
};

export type ScenariosFields_OpenScenarioField_Create = {
  __typename?: 'ScenariosFields_openScenarioField_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Delete = {
  __typename?: 'ScenariosFields_openScenarioField_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Fields = {
  __typename?: 'ScenariosFields_openScenarioField_Fields';
  content: Maybe<ScenariosFields_OpenScenarioField_Content>;
  openScenario: Maybe<ScenariosFields_OpenScenarioField_OpenScenario>;
  type: Maybe<ScenariosFields_OpenScenarioField_Type>;
};

export type ScenariosFields_OpenScenarioField_Read = {
  __typename?: 'ScenariosFields_openScenarioField_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Update = {
  __typename?: 'ScenariosFields_openScenarioField_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Content = {
  __typename?: 'ScenariosFields_openScenarioField_content';
  create: Maybe<ScenariosFields_OpenScenarioField_Content_Create>;
  delete: Maybe<ScenariosFields_OpenScenarioField_Content_Delete>;
  read: Maybe<ScenariosFields_OpenScenarioField_Content_Read>;
  update: Maybe<ScenariosFields_OpenScenarioField_Content_Update>;
};

export type ScenariosFields_OpenScenarioField_Content_Create = {
  __typename?: 'ScenariosFields_openScenarioField_content_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Content_Delete = {
  __typename?: 'ScenariosFields_openScenarioField_content_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Content_Read = {
  __typename?: 'ScenariosFields_openScenarioField_content_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Content_Update = {
  __typename?: 'ScenariosFields_openScenarioField_content_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_OpenScenario = {
  __typename?: 'ScenariosFields_openScenarioField_openScenario';
  create: Maybe<ScenariosFields_OpenScenarioField_OpenScenario_Create>;
  delete: Maybe<ScenariosFields_OpenScenarioField_OpenScenario_Delete>;
  read: Maybe<ScenariosFields_OpenScenarioField_OpenScenario_Read>;
  update: Maybe<ScenariosFields_OpenScenarioField_OpenScenario_Update>;
};

export type ScenariosFields_OpenScenarioField_OpenScenario_Create = {
  __typename?: 'ScenariosFields_openScenarioField_openScenario_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_OpenScenario_Delete = {
  __typename?: 'ScenariosFields_openScenarioField_openScenario_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_OpenScenario_Read = {
  __typename?: 'ScenariosFields_openScenarioField_openScenario_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_OpenScenario_Update = {
  __typename?: 'ScenariosFields_openScenarioField_openScenario_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Type = {
  __typename?: 'ScenariosFields_openScenarioField_type';
  create: Maybe<ScenariosFields_OpenScenarioField_Type_Create>;
  delete: Maybe<ScenariosFields_OpenScenarioField_Type_Delete>;
  read: Maybe<ScenariosFields_OpenScenarioField_Type_Read>;
  update: Maybe<ScenariosFields_OpenScenarioField_Type_Update>;
};

export type ScenariosFields_OpenScenarioField_Type_Create = {
  __typename?: 'ScenariosFields_openScenarioField_type_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Type_Delete = {
  __typename?: 'ScenariosFields_openScenarioField_type_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Type_Read = {
  __typename?: 'ScenariosFields_openScenarioField_type_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_OpenScenarioField_Type_Update = {
  __typename?: 'ScenariosFields_openScenarioField_type_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints = {
  __typename?: 'ScenariosFields_parameterConstraints';
  create: Maybe<ScenariosFields_ParameterConstraints_Create>;
  delete: Maybe<ScenariosFields_ParameterConstraints_Delete>;
  fields: Maybe<ScenariosFields_ParameterConstraints_Fields>;
  read: Maybe<ScenariosFields_ParameterConstraints_Read>;
  update: Maybe<ScenariosFields_ParameterConstraints_Update>;
};

export type ScenariosFields_ParameterConstraints_Create = {
  __typename?: 'ScenariosFields_parameterConstraints_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Delete = {
  __typename?: 'ScenariosFields_parameterConstraints_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Fields = {
  __typename?: 'ScenariosFields_parameterConstraints_Fields';
  expression: Maybe<ScenariosFields_ParameterConstraints_Expression>;
  id: Maybe<ScenariosFields_ParameterConstraints_Id>;
};

export type ScenariosFields_ParameterConstraints_Read = {
  __typename?: 'ScenariosFields_parameterConstraints_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Update = {
  __typename?: 'ScenariosFields_parameterConstraints_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Expression = {
  __typename?: 'ScenariosFields_parameterConstraints_expression';
  create: Maybe<ScenariosFields_ParameterConstraints_Expression_Create>;
  delete: Maybe<ScenariosFields_ParameterConstraints_Expression_Delete>;
  read: Maybe<ScenariosFields_ParameterConstraints_Expression_Read>;
  update: Maybe<ScenariosFields_ParameterConstraints_Expression_Update>;
};

export type ScenariosFields_ParameterConstraints_Expression_Create = {
  __typename?: 'ScenariosFields_parameterConstraints_expression_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Expression_Delete = {
  __typename?: 'ScenariosFields_parameterConstraints_expression_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Expression_Read = {
  __typename?: 'ScenariosFields_parameterConstraints_expression_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Expression_Update = {
  __typename?: 'ScenariosFields_parameterConstraints_expression_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Id = {
  __typename?: 'ScenariosFields_parameterConstraints_id';
  create: Maybe<ScenariosFields_ParameterConstraints_Id_Create>;
  delete: Maybe<ScenariosFields_ParameterConstraints_Id_Delete>;
  read: Maybe<ScenariosFields_ParameterConstraints_Id_Read>;
  update: Maybe<ScenariosFields_ParameterConstraints_Id_Update>;
};

export type ScenariosFields_ParameterConstraints_Id_Create = {
  __typename?: 'ScenariosFields_parameterConstraints_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Id_Delete = {
  __typename?: 'ScenariosFields_parameterConstraints_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Id_Read = {
  __typename?: 'ScenariosFields_parameterConstraints_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ParameterConstraints_Id_Update = {
  __typename?: 'ScenariosFields_parameterConstraints_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters = {
  __typename?: 'ScenariosFields_parameters';
  create: Maybe<ScenariosFields_Parameters_Create>;
  delete: Maybe<ScenariosFields_Parameters_Delete>;
  fields: Maybe<ScenariosFields_Parameters_Fields>;
  read: Maybe<ScenariosFields_Parameters_Read>;
  update: Maybe<ScenariosFields_Parameters_Update>;
};

export type ScenariosFields_Parameters_Create = {
  __typename?: 'ScenariosFields_parameters_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Delete = {
  __typename?: 'ScenariosFields_parameters_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Fields = {
  __typename?: 'ScenariosFields_parameters_Fields';
  description: Maybe<ScenariosFields_Parameters_Description>;
  id: Maybe<ScenariosFields_Parameters_Id>;
  max: Maybe<ScenariosFields_Parameters_Max>;
  min: Maybe<ScenariosFields_Parameters_Min>;
  name: Maybe<ScenariosFields_Parameters_Name>;
  unit: Maybe<ScenariosFields_Parameters_Unit>;
};

export type ScenariosFields_Parameters_Read = {
  __typename?: 'ScenariosFields_parameters_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Update = {
  __typename?: 'ScenariosFields_parameters_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Description = {
  __typename?: 'ScenariosFields_parameters_description';
  create: Maybe<ScenariosFields_Parameters_Description_Create>;
  delete: Maybe<ScenariosFields_Parameters_Description_Delete>;
  read: Maybe<ScenariosFields_Parameters_Description_Read>;
  update: Maybe<ScenariosFields_Parameters_Description_Update>;
};

export type ScenariosFields_Parameters_Description_Create = {
  __typename?: 'ScenariosFields_parameters_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Description_Delete = {
  __typename?: 'ScenariosFields_parameters_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Description_Read = {
  __typename?: 'ScenariosFields_parameters_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Description_Update = {
  __typename?: 'ScenariosFields_parameters_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Id = {
  __typename?: 'ScenariosFields_parameters_id';
  create: Maybe<ScenariosFields_Parameters_Id_Create>;
  delete: Maybe<ScenariosFields_Parameters_Id_Delete>;
  read: Maybe<ScenariosFields_Parameters_Id_Read>;
  update: Maybe<ScenariosFields_Parameters_Id_Update>;
};

export type ScenariosFields_Parameters_Id_Create = {
  __typename?: 'ScenariosFields_parameters_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Id_Delete = {
  __typename?: 'ScenariosFields_parameters_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Id_Read = {
  __typename?: 'ScenariosFields_parameters_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Id_Update = {
  __typename?: 'ScenariosFields_parameters_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Max = {
  __typename?: 'ScenariosFields_parameters_max';
  create: Maybe<ScenariosFields_Parameters_Max_Create>;
  delete: Maybe<ScenariosFields_Parameters_Max_Delete>;
  read: Maybe<ScenariosFields_Parameters_Max_Read>;
  update: Maybe<ScenariosFields_Parameters_Max_Update>;
};

export type ScenariosFields_Parameters_Max_Create = {
  __typename?: 'ScenariosFields_parameters_max_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Max_Delete = {
  __typename?: 'ScenariosFields_parameters_max_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Max_Read = {
  __typename?: 'ScenariosFields_parameters_max_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Max_Update = {
  __typename?: 'ScenariosFields_parameters_max_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Min = {
  __typename?: 'ScenariosFields_parameters_min';
  create: Maybe<ScenariosFields_Parameters_Min_Create>;
  delete: Maybe<ScenariosFields_Parameters_Min_Delete>;
  read: Maybe<ScenariosFields_Parameters_Min_Read>;
  update: Maybe<ScenariosFields_Parameters_Min_Update>;
};

export type ScenariosFields_Parameters_Min_Create = {
  __typename?: 'ScenariosFields_parameters_min_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Min_Delete = {
  __typename?: 'ScenariosFields_parameters_min_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Min_Read = {
  __typename?: 'ScenariosFields_parameters_min_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Min_Update = {
  __typename?: 'ScenariosFields_parameters_min_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Name = {
  __typename?: 'ScenariosFields_parameters_name';
  create: Maybe<ScenariosFields_Parameters_Name_Create>;
  delete: Maybe<ScenariosFields_Parameters_Name_Delete>;
  read: Maybe<ScenariosFields_Parameters_Name_Read>;
  update: Maybe<ScenariosFields_Parameters_Name_Update>;
};

export type ScenariosFields_Parameters_Name_Create = {
  __typename?: 'ScenariosFields_parameters_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Name_Delete = {
  __typename?: 'ScenariosFields_parameters_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Name_Read = {
  __typename?: 'ScenariosFields_parameters_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Name_Update = {
  __typename?: 'ScenariosFields_parameters_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Unit = {
  __typename?: 'ScenariosFields_parameters_unit';
  create: Maybe<ScenariosFields_Parameters_Unit_Create>;
  delete: Maybe<ScenariosFields_Parameters_Unit_Delete>;
  read: Maybe<ScenariosFields_Parameters_Unit_Read>;
  update: Maybe<ScenariosFields_Parameters_Unit_Update>;
};

export type ScenariosFields_Parameters_Unit_Create = {
  __typename?: 'ScenariosFields_parameters_unit_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Unit_Delete = {
  __typename?: 'ScenariosFields_parameters_unit_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Unit_Read = {
  __typename?: 'ScenariosFields_parameters_unit_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Parameters_Unit_Update = {
  __typename?: 'ScenariosFields_parameters_unit_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Schematic = {
  __typename?: 'ScenariosFields_schematic';
  create: Maybe<ScenariosFields_Schematic_Create>;
  delete: Maybe<ScenariosFields_Schematic_Delete>;
  read: Maybe<ScenariosFields_Schematic_Read>;
  update: Maybe<ScenariosFields_Schematic_Update>;
};

export type ScenariosFields_Schematic_Create = {
  __typename?: 'ScenariosFields_schematic_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Schematic_Delete = {
  __typename?: 'ScenariosFields_schematic_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Schematic_Read = {
  __typename?: 'ScenariosFields_schematic_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_Schematic_Update = {
  __typename?: 'ScenariosFields_schematic_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions';
  create: Maybe<ScenariosFields_StartObservationSamplingConditions_Create>;
  delete: Maybe<ScenariosFields_StartObservationSamplingConditions_Delete>;
  fields: Maybe<ScenariosFields_StartObservationSamplingConditions_Fields>;
  read: Maybe<ScenariosFields_StartObservationSamplingConditions_Read>;
  update: Maybe<ScenariosFields_StartObservationSamplingConditions_Update>;
};

export type ScenariosFields_StartObservationSamplingConditions_Create = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Delete = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Fields = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_Fields';
  condition: Maybe<ScenariosFields_StartObservationSamplingConditions_Condition>;
  id: Maybe<ScenariosFields_StartObservationSamplingConditions_Id>;
};

export type ScenariosFields_StartObservationSamplingConditions_Read = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Update = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Condition = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_condition';
  create: Maybe<ScenariosFields_StartObservationSamplingConditions_Condition_Create>;
  delete: Maybe<ScenariosFields_StartObservationSamplingConditions_Condition_Delete>;
  read: Maybe<ScenariosFields_StartObservationSamplingConditions_Condition_Read>;
  update: Maybe<ScenariosFields_StartObservationSamplingConditions_Condition_Update>;
};

export type ScenariosFields_StartObservationSamplingConditions_Condition_Create = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_condition_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Condition_Delete = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_condition_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Condition_Read = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_condition_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Condition_Update = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_condition_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Id = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_id';
  create: Maybe<ScenariosFields_StartObservationSamplingConditions_Id_Create>;
  delete: Maybe<ScenariosFields_StartObservationSamplingConditions_Id_Delete>;
  read: Maybe<ScenariosFields_StartObservationSamplingConditions_Id_Read>;
  update: Maybe<ScenariosFields_StartObservationSamplingConditions_Id_Update>;
};

export type ScenariosFields_StartObservationSamplingConditions_Id_Create = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Id_Delete = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Id_Read = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_StartObservationSamplingConditions_Id_Update = {
  __typename?: 'ScenariosFields_startObservationSamplingConditions_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives = {
  __typename?: 'ScenariosFields_testObjectives';
  create: Maybe<ScenariosFields_TestObjectives_Create>;
  delete: Maybe<ScenariosFields_TestObjectives_Delete>;
  fields: Maybe<ScenariosFields_TestObjectives_Fields>;
  read: Maybe<ScenariosFields_TestObjectives_Read>;
  update: Maybe<ScenariosFields_TestObjectives_Update>;
};

export type ScenariosFields_TestObjectives_Create = {
  __typename?: 'ScenariosFields_testObjectives_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_Delete = {
  __typename?: 'ScenariosFields_testObjectives_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_Fields = {
  __typename?: 'ScenariosFields_testObjectives_Fields';
  criticalityMetrics: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics>;
};

export type ScenariosFields_TestObjectives_Read = {
  __typename?: 'ScenariosFields_testObjectives_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_Update = {
  __typename?: 'ScenariosFields_testObjectives_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics';
  create: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Create>;
  delete: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Delete>;
  fields: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Fields>;
  read: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Read>;
  update: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Update>;
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Create = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Delete = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Fields = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_Fields';
  description: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Description>;
  id: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Id>;
  keyPerformanceIndicator: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator>;
  threshold: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Threshold>;
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Read = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Update = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Description = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_description';
  create: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Description_Create>;
  delete: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Description_Delete>;
  read: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Description_Read>;
  update: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Description_Update>;
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Description_Create = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_description_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Description_Delete = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_description_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Description_Read = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_description_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Description_Update = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_description_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Id = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_id';
  create: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Id_Create>;
  delete: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Id_Delete>;
  read: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Id_Read>;
  update: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Id_Update>;
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Id_Create = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Id_Delete = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Id_Read = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Id_Update = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_keyPerformanceIndicator';
  create: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create>;
  delete: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete>;
  read: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read>;
  update: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update>;
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Threshold = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_threshold';
  create: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Create>;
  delete: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Delete>;
  read: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Read>;
  update: Maybe<ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Update>;
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Create = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_threshold_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Delete = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_threshold_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Read = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_threshold_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_TestObjectives_CriticalityMetrics_Threshold_Update = {
  __typename?: 'ScenariosFields_testObjectives_criticalityMetrics_threshold_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_UpdatedAt = {
  __typename?: 'ScenariosFields_updatedAt';
  create: Maybe<ScenariosFields_UpdatedAt_Create>;
  delete: Maybe<ScenariosFields_UpdatedAt_Delete>;
  read: Maybe<ScenariosFields_UpdatedAt_Read>;
  update: Maybe<ScenariosFields_UpdatedAt_Update>;
};

export type ScenariosFields_UpdatedAt_Create = {
  __typename?: 'ScenariosFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_UpdatedAt_Delete = {
  __typename?: 'ScenariosFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_UpdatedAt_Read = {
  __typename?: 'ScenariosFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_UpdatedAt_Update = {
  __typename?: 'ScenariosFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions = {
  __typename?: 'ScenariosFields_validConditions';
  create: Maybe<ScenariosFields_ValidConditions_Create>;
  delete: Maybe<ScenariosFields_ValidConditions_Delete>;
  fields: Maybe<ScenariosFields_ValidConditions_Fields>;
  read: Maybe<ScenariosFields_ValidConditions_Read>;
  update: Maybe<ScenariosFields_ValidConditions_Update>;
};

export type ScenariosFields_ValidConditions_Create = {
  __typename?: 'ScenariosFields_validConditions_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Delete = {
  __typename?: 'ScenariosFields_validConditions_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Fields = {
  __typename?: 'ScenariosFields_validConditions_Fields';
  condition: Maybe<ScenariosFields_ValidConditions_Condition>;
  id: Maybe<ScenariosFields_ValidConditions_Id>;
};

export type ScenariosFields_ValidConditions_Read = {
  __typename?: 'ScenariosFields_validConditions_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Update = {
  __typename?: 'ScenariosFields_validConditions_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Condition = {
  __typename?: 'ScenariosFields_validConditions_condition';
  create: Maybe<ScenariosFields_ValidConditions_Condition_Create>;
  delete: Maybe<ScenariosFields_ValidConditions_Condition_Delete>;
  read: Maybe<ScenariosFields_ValidConditions_Condition_Read>;
  update: Maybe<ScenariosFields_ValidConditions_Condition_Update>;
};

export type ScenariosFields_ValidConditions_Condition_Create = {
  __typename?: 'ScenariosFields_validConditions_condition_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Condition_Delete = {
  __typename?: 'ScenariosFields_validConditions_condition_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Condition_Read = {
  __typename?: 'ScenariosFields_validConditions_condition_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Condition_Update = {
  __typename?: 'ScenariosFields_validConditions_condition_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Id = {
  __typename?: 'ScenariosFields_validConditions_id';
  create: Maybe<ScenariosFields_ValidConditions_Id_Create>;
  delete: Maybe<ScenariosFields_ValidConditions_Id_Delete>;
  read: Maybe<ScenariosFields_ValidConditions_Id_Read>;
  update: Maybe<ScenariosFields_ValidConditions_Id_Update>;
};

export type ScenariosFields_ValidConditions_Id_Create = {
  __typename?: 'ScenariosFields_validConditions_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Id_Delete = {
  __typename?: 'ScenariosFields_validConditions_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Id_Read = {
  __typename?: 'ScenariosFields_validConditions_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosFields_ValidConditions_Id_Update = {
  __typename?: 'ScenariosFields_validConditions_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type ScenariosReadAccess = {
  __typename?: 'ScenariosReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosReadDocAccess = {
  __typename?: 'ScenariosReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosReadVersionsAccess = {
  __typename?: 'ScenariosReadVersionsAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosReadVersionsDocAccess = {
  __typename?: 'ScenariosReadVersionsDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosUpdateAccess = {
  __typename?: 'ScenariosUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type ScenariosUpdateDocAccess = {
  __typename?: 'ScenariosUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Session = {
  __typename?: 'Session';
  _status: Maybe<Session__Status>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  id: Scalars['Int']['output'];
  name: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export enum SessionUpdate__Status_MutationInput {
  Draft = 'draft',
  Published = 'published'
}

export type SessionVersion = {
  __typename?: 'SessionVersion';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  id: Maybe<Scalars['Int']['output']>;
  latest: Maybe<Scalars['Boolean']['output']>;
  parent: Maybe<Session>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
  version: Maybe<SessionVersion_Version>;
};


export type SessionVersionParentArgs = {
  draft: InputMaybe<Scalars['Boolean']['input']>;
};

export type SessionVersion_Version = {
  __typename?: 'SessionVersion_Version';
  _status: Maybe<SessionVersion_Version__Status>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  name: Maybe<Scalars['String']['output']>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export enum SessionVersion_Version__Status {
  Draft = 'draft',
  Published = 'published'
}

export enum Session__Status {
  Draft = 'draft',
  Published = 'published'
}

export enum Session__Status_Input {
  Draft = 'draft',
  Published = 'published'
}

export enum Session__Status_MutationInput {
  Draft = 'draft',
  Published = 'published'
}

export type Session__Status_Operator = {
  all: InputMaybe<Array<InputMaybe<Session__Status_Input>>>;
  equals: InputMaybe<Session__Status_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Session__Status_Input>>>;
  not_equals: InputMaybe<Session__Status_Input>;
  not_in: InputMaybe<Array<InputMaybe<Session__Status_Input>>>;
};

export type Session_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Session_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Session_Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Session_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Session_Where = {
  AND: InputMaybe<Array<InputMaybe<Session_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Session_Where_Or>>>;
  _status: InputMaybe<Session__Status_Operator>;
  createdAt: InputMaybe<Session_CreatedAt_Operator>;
  id: InputMaybe<Session_Id_Operator>;
  name: InputMaybe<Session_Name_Operator>;
  updatedAt: InputMaybe<Session_UpdatedAt_Operator>;
};

export type Session_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Session_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Session_Where_Or>>>;
  _status: InputMaybe<Session__Status_Operator>;
  createdAt: InputMaybe<Session_CreatedAt_Operator>;
  id: InputMaybe<Session_Id_Operator>;
  name: InputMaybe<Session_Name_Operator>;
  updatedAt: InputMaybe<Session_UpdatedAt_Operator>;
};

export type Session_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Session_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Session_Where_Or>>>;
  _status: InputMaybe<Session__Status_Operator>;
  createdAt: InputMaybe<Session_CreatedAt_Operator>;
  id: InputMaybe<Session_Id_Operator>;
  name: InputMaybe<Session_Name_Operator>;
  updatedAt: InputMaybe<Session_UpdatedAt_Operator>;
};

export type Sessions = {
  __typename?: 'Sessions';
  docs: Array<Session>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type SessionsCreateAccess = {
  __typename?: 'SessionsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsCreateDocAccess = {
  __typename?: 'SessionsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsDeleteAccess = {
  __typename?: 'SessionsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsDeleteDocAccess = {
  __typename?: 'SessionsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsDocAccessFields = {
  __typename?: 'SessionsDocAccessFields';
  _status: Maybe<SessionsDocAccessFields__Status>;
  createdAt: Maybe<SessionsDocAccessFields_CreatedAt>;
  name: Maybe<SessionsDocAccessFields_Name>;
  updatedAt: Maybe<SessionsDocAccessFields_UpdatedAt>;
};

export type SessionsDocAccessFields__Status = {
  __typename?: 'SessionsDocAccessFields__status';
  create: Maybe<SessionsDocAccessFields__Status_Create>;
  delete: Maybe<SessionsDocAccessFields__Status_Delete>;
  read: Maybe<SessionsDocAccessFields__Status_Read>;
  update: Maybe<SessionsDocAccessFields__Status_Update>;
};

export type SessionsDocAccessFields__Status_Create = {
  __typename?: 'SessionsDocAccessFields__status_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields__Status_Delete = {
  __typename?: 'SessionsDocAccessFields__status_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields__Status_Read = {
  __typename?: 'SessionsDocAccessFields__status_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields__Status_Update = {
  __typename?: 'SessionsDocAccessFields__status_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_CreatedAt = {
  __typename?: 'SessionsDocAccessFields_createdAt';
  create: Maybe<SessionsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<SessionsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<SessionsDocAccessFields_CreatedAt_Read>;
  update: Maybe<SessionsDocAccessFields_CreatedAt_Update>;
};

export type SessionsDocAccessFields_CreatedAt_Create = {
  __typename?: 'SessionsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'SessionsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_CreatedAt_Read = {
  __typename?: 'SessionsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_CreatedAt_Update = {
  __typename?: 'SessionsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_Name = {
  __typename?: 'SessionsDocAccessFields_name';
  create: Maybe<SessionsDocAccessFields_Name_Create>;
  delete: Maybe<SessionsDocAccessFields_Name_Delete>;
  read: Maybe<SessionsDocAccessFields_Name_Read>;
  update: Maybe<SessionsDocAccessFields_Name_Update>;
};

export type SessionsDocAccessFields_Name_Create = {
  __typename?: 'SessionsDocAccessFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_Name_Delete = {
  __typename?: 'SessionsDocAccessFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_Name_Read = {
  __typename?: 'SessionsDocAccessFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_Name_Update = {
  __typename?: 'SessionsDocAccessFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_UpdatedAt = {
  __typename?: 'SessionsDocAccessFields_updatedAt';
  create: Maybe<SessionsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<SessionsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<SessionsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<SessionsDocAccessFields_UpdatedAt_Update>;
};

export type SessionsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'SessionsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'SessionsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'SessionsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'SessionsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields = {
  __typename?: 'SessionsFields';
  _status: Maybe<SessionsFields__Status>;
  createdAt: Maybe<SessionsFields_CreatedAt>;
  name: Maybe<SessionsFields_Name>;
  updatedAt: Maybe<SessionsFields_UpdatedAt>;
};

export type SessionsFields__Status = {
  __typename?: 'SessionsFields__status';
  create: Maybe<SessionsFields__Status_Create>;
  delete: Maybe<SessionsFields__Status_Delete>;
  read: Maybe<SessionsFields__Status_Read>;
  update: Maybe<SessionsFields__Status_Update>;
};

export type SessionsFields__Status_Create = {
  __typename?: 'SessionsFields__status_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields__Status_Delete = {
  __typename?: 'SessionsFields__status_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields__Status_Read = {
  __typename?: 'SessionsFields__status_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields__Status_Update = {
  __typename?: 'SessionsFields__status_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_CreatedAt = {
  __typename?: 'SessionsFields_createdAt';
  create: Maybe<SessionsFields_CreatedAt_Create>;
  delete: Maybe<SessionsFields_CreatedAt_Delete>;
  read: Maybe<SessionsFields_CreatedAt_Read>;
  update: Maybe<SessionsFields_CreatedAt_Update>;
};

export type SessionsFields_CreatedAt_Create = {
  __typename?: 'SessionsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_CreatedAt_Delete = {
  __typename?: 'SessionsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_CreatedAt_Read = {
  __typename?: 'SessionsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_CreatedAt_Update = {
  __typename?: 'SessionsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_Name = {
  __typename?: 'SessionsFields_name';
  create: Maybe<SessionsFields_Name_Create>;
  delete: Maybe<SessionsFields_Name_Delete>;
  read: Maybe<SessionsFields_Name_Read>;
  update: Maybe<SessionsFields_Name_Update>;
};

export type SessionsFields_Name_Create = {
  __typename?: 'SessionsFields_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_Name_Delete = {
  __typename?: 'SessionsFields_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_Name_Read = {
  __typename?: 'SessionsFields_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_Name_Update = {
  __typename?: 'SessionsFields_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_UpdatedAt = {
  __typename?: 'SessionsFields_updatedAt';
  create: Maybe<SessionsFields_UpdatedAt_Create>;
  delete: Maybe<SessionsFields_UpdatedAt_Delete>;
  read: Maybe<SessionsFields_UpdatedAt_Read>;
  update: Maybe<SessionsFields_UpdatedAt_Update>;
};

export type SessionsFields_UpdatedAt_Create = {
  __typename?: 'SessionsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_UpdatedAt_Delete = {
  __typename?: 'SessionsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_UpdatedAt_Read = {
  __typename?: 'SessionsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type SessionsFields_UpdatedAt_Update = {
  __typename?: 'SessionsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type SessionsReadAccess = {
  __typename?: 'SessionsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsReadDocAccess = {
  __typename?: 'SessionsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsReadVersionsAccess = {
  __typename?: 'SessionsReadVersionsAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsReadVersionsDocAccess = {
  __typename?: 'SessionsReadVersionsDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsUpdateAccess = {
  __typename?: 'SessionsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type SessionsUpdateDocAccess = {
  __typename?: 'SessionsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type Trial = {
  __typename?: 'Trial';
  batch: Batch;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  ego: Ego;
  esminiDat: EsminiDat;
  events: Maybe<Array<Trial_Events>>;
  id: Scalars['Int']['output'];
  parameters: Array<Trial_Parameters>;
  previewImage: Maybe<Media>;
  testObjectives: Maybe<Trial_TestObjectives>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export type Trial_Events = {
  __typename?: 'Trial_Events';
  esminiSeconds: Maybe<Scalars['Float']['output']>;
  id: Maybe<Scalars['String']['output']>;
  name: Maybe<Scalars['String']['output']>;
  observationIndex: Maybe<Scalars['Float']['output']>;
  previewImage: Maybe<Media>;
  time: Maybe<Scalars['Float']['output']>;
};

export type Trial_Parameters = {
  __typename?: 'Trial_Parameters';
  id: Maybe<Scalars['String']['output']>;
  parameterId: Maybe<Scalars['String']['output']>;
  value: Maybe<Scalars['Float']['output']>;
};

export type Trial_TestObjectives = {
  __typename?: 'Trial_TestObjectives';
  criticalityMetrics: Array<Trial_TestObjectives_CriticalityMetrics>;
  referenceModels: Maybe<Array<Trial_TestObjectives_ReferenceModels>>;
};

export type Trial_TestObjectives_CriticalityMetrics = {
  __typename?: 'Trial_TestObjectives_CriticalityMetrics';
  firstFailedObservationIndex: Maybe<Scalars['Float']['output']>;
  id: Maybe<Scalars['String']['output']>;
  keyPerformanceIndicator: KeyPerformanceIndicator;
  passed: Scalars['Boolean']['output'];
  value: Maybe<Scalars['Float']['output']>;
  worstObservation: Maybe<Observation>;
  worstObservationIndex: Maybe<Scalars['Float']['output']>;
};

export type Trial_TestObjectives_ReferenceModels = {
  __typename?: 'Trial_TestObjectives_ReferenceModels';
  id: Maybe<Scalars['String']['output']>;
  passed: Maybe<Scalars['Boolean']['output']>;
  referenceModel: Maybe<Scalars['String']['output']>;
};

export type Trial_Batch_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Trial_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Trial_Ego_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Trial_EsminiDat_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Trial_Events__EsminiSeconds_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Trial_Events__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Trial_Events__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Trial_Events__ObservationIndex_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Trial_Events__PreviewImage_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Trial_Events__Time_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Trial_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type Trial_Parameters__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Trial_Parameters__ParameterId_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Trial_Parameters__Value_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Trial_PreviewImage_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Trial_TestObjectives__CriticalityMetrics__FirstFailedObservationIndex_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Trial_TestObjectives__CriticalityMetrics__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Trial_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Trial_TestObjectives__CriticalityMetrics__Passed_Operator = {
  equals: InputMaybe<Scalars['Boolean']['input']>;
  not_equals: InputMaybe<Scalars['Boolean']['input']>;
};

export type Trial_TestObjectives__CriticalityMetrics__Value_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Trial_TestObjectives__CriticalityMetrics__WorstObservationIndex_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type Trial_TestObjectives__CriticalityMetrics__WorstObservation_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type Trial_TestObjectives__ReferenceModels__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Trial_TestObjectives__ReferenceModels__Passed_Operator = {
  equals: InputMaybe<Scalars['Boolean']['input']>;
  not_equals: InputMaybe<Scalars['Boolean']['input']>;
};

export type Trial_TestObjectives__ReferenceModels__ReferenceModel_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type Trial_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type Trial_Where = {
  AND: InputMaybe<Array<InputMaybe<Trial_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Trial_Where_Or>>>;
  batch: InputMaybe<Trial_Batch_Operator>;
  createdAt: InputMaybe<Trial_CreatedAt_Operator>;
  ego: InputMaybe<Trial_Ego_Operator>;
  esminiDat: InputMaybe<Trial_EsminiDat_Operator>;
  events__esminiSeconds: InputMaybe<Trial_Events__EsminiSeconds_Operator>;
  events__id: InputMaybe<Trial_Events__Id_Operator>;
  events__name: InputMaybe<Trial_Events__Name_Operator>;
  events__observationIndex: InputMaybe<Trial_Events__ObservationIndex_Operator>;
  events__previewImage: InputMaybe<Trial_Events__PreviewImage_Operator>;
  events__time: InputMaybe<Trial_Events__Time_Operator>;
  id: InputMaybe<Trial_Id_Operator>;
  parameters__id: InputMaybe<Trial_Parameters__Id_Operator>;
  parameters__parameterId: InputMaybe<Trial_Parameters__ParameterId_Operator>;
  parameters__value: InputMaybe<Trial_Parameters__Value_Operator>;
  previewImage: InputMaybe<Trial_PreviewImage_Operator>;
  testObjectives__criticalityMetrics__firstFailedObservationIndex: InputMaybe<Trial_TestObjectives__CriticalityMetrics__FirstFailedObservationIndex_Operator>;
  testObjectives__criticalityMetrics__id: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Id_Operator>;
  testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<Trial_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  testObjectives__criticalityMetrics__passed: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Passed_Operator>;
  testObjectives__criticalityMetrics__value: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Value_Operator>;
  testObjectives__criticalityMetrics__worstObservation: InputMaybe<Trial_TestObjectives__CriticalityMetrics__WorstObservation_Operator>;
  testObjectives__criticalityMetrics__worstObservationIndex: InputMaybe<Trial_TestObjectives__CriticalityMetrics__WorstObservationIndex_Operator>;
  testObjectives__referenceModels__id: InputMaybe<Trial_TestObjectives__ReferenceModels__Id_Operator>;
  testObjectives__referenceModels__passed: InputMaybe<Trial_TestObjectives__ReferenceModels__Passed_Operator>;
  testObjectives__referenceModels__referenceModel: InputMaybe<Trial_TestObjectives__ReferenceModels__ReferenceModel_Operator>;
  updatedAt: InputMaybe<Trial_UpdatedAt_Operator>;
};

export type Trial_Where_And = {
  AND: InputMaybe<Array<InputMaybe<Trial_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Trial_Where_Or>>>;
  batch: InputMaybe<Trial_Batch_Operator>;
  createdAt: InputMaybe<Trial_CreatedAt_Operator>;
  ego: InputMaybe<Trial_Ego_Operator>;
  esminiDat: InputMaybe<Trial_EsminiDat_Operator>;
  events__esminiSeconds: InputMaybe<Trial_Events__EsminiSeconds_Operator>;
  events__id: InputMaybe<Trial_Events__Id_Operator>;
  events__name: InputMaybe<Trial_Events__Name_Operator>;
  events__observationIndex: InputMaybe<Trial_Events__ObservationIndex_Operator>;
  events__previewImage: InputMaybe<Trial_Events__PreviewImage_Operator>;
  events__time: InputMaybe<Trial_Events__Time_Operator>;
  id: InputMaybe<Trial_Id_Operator>;
  parameters__id: InputMaybe<Trial_Parameters__Id_Operator>;
  parameters__parameterId: InputMaybe<Trial_Parameters__ParameterId_Operator>;
  parameters__value: InputMaybe<Trial_Parameters__Value_Operator>;
  previewImage: InputMaybe<Trial_PreviewImage_Operator>;
  testObjectives__criticalityMetrics__firstFailedObservationIndex: InputMaybe<Trial_TestObjectives__CriticalityMetrics__FirstFailedObservationIndex_Operator>;
  testObjectives__criticalityMetrics__id: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Id_Operator>;
  testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<Trial_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  testObjectives__criticalityMetrics__passed: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Passed_Operator>;
  testObjectives__criticalityMetrics__value: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Value_Operator>;
  testObjectives__criticalityMetrics__worstObservation: InputMaybe<Trial_TestObjectives__CriticalityMetrics__WorstObservation_Operator>;
  testObjectives__criticalityMetrics__worstObservationIndex: InputMaybe<Trial_TestObjectives__CriticalityMetrics__WorstObservationIndex_Operator>;
  testObjectives__referenceModels__id: InputMaybe<Trial_TestObjectives__ReferenceModels__Id_Operator>;
  testObjectives__referenceModels__passed: InputMaybe<Trial_TestObjectives__ReferenceModels__Passed_Operator>;
  testObjectives__referenceModels__referenceModel: InputMaybe<Trial_TestObjectives__ReferenceModels__ReferenceModel_Operator>;
  updatedAt: InputMaybe<Trial_UpdatedAt_Operator>;
};

export type Trial_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<Trial_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<Trial_Where_Or>>>;
  batch: InputMaybe<Trial_Batch_Operator>;
  createdAt: InputMaybe<Trial_CreatedAt_Operator>;
  ego: InputMaybe<Trial_Ego_Operator>;
  esminiDat: InputMaybe<Trial_EsminiDat_Operator>;
  events__esminiSeconds: InputMaybe<Trial_Events__EsminiSeconds_Operator>;
  events__id: InputMaybe<Trial_Events__Id_Operator>;
  events__name: InputMaybe<Trial_Events__Name_Operator>;
  events__observationIndex: InputMaybe<Trial_Events__ObservationIndex_Operator>;
  events__previewImage: InputMaybe<Trial_Events__PreviewImage_Operator>;
  events__time: InputMaybe<Trial_Events__Time_Operator>;
  id: InputMaybe<Trial_Id_Operator>;
  parameters__id: InputMaybe<Trial_Parameters__Id_Operator>;
  parameters__parameterId: InputMaybe<Trial_Parameters__ParameterId_Operator>;
  parameters__value: InputMaybe<Trial_Parameters__Value_Operator>;
  previewImage: InputMaybe<Trial_PreviewImage_Operator>;
  testObjectives__criticalityMetrics__firstFailedObservationIndex: InputMaybe<Trial_TestObjectives__CriticalityMetrics__FirstFailedObservationIndex_Operator>;
  testObjectives__criticalityMetrics__id: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Id_Operator>;
  testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<Trial_TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  testObjectives__criticalityMetrics__passed: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Passed_Operator>;
  testObjectives__criticalityMetrics__value: InputMaybe<Trial_TestObjectives__CriticalityMetrics__Value_Operator>;
  testObjectives__criticalityMetrics__worstObservation: InputMaybe<Trial_TestObjectives__CriticalityMetrics__WorstObservation_Operator>;
  testObjectives__criticalityMetrics__worstObservationIndex: InputMaybe<Trial_TestObjectives__CriticalityMetrics__WorstObservationIndex_Operator>;
  testObjectives__referenceModels__id: InputMaybe<Trial_TestObjectives__ReferenceModels__Id_Operator>;
  testObjectives__referenceModels__passed: InputMaybe<Trial_TestObjectives__ReferenceModels__Passed_Operator>;
  testObjectives__referenceModels__referenceModel: InputMaybe<Trial_TestObjectives__ReferenceModels__ReferenceModel_Operator>;
  updatedAt: InputMaybe<Trial_UpdatedAt_Operator>;
};

export type Trials = {
  __typename?: 'Trials';
  docs: Array<Trial>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type TrialsCreateAccess = {
  __typename?: 'TrialsCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type TrialsCreateDocAccess = {
  __typename?: 'TrialsCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type TrialsDeleteAccess = {
  __typename?: 'TrialsDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type TrialsDeleteDocAccess = {
  __typename?: 'TrialsDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type TrialsDocAccessFields = {
  __typename?: 'TrialsDocAccessFields';
  batch: Maybe<TrialsDocAccessFields_Batch>;
  createdAt: Maybe<TrialsDocAccessFields_CreatedAt>;
  ego: Maybe<TrialsDocAccessFields_Ego>;
  esminiDat: Maybe<TrialsDocAccessFields_EsminiDat>;
  events: Maybe<TrialsDocAccessFields_Events>;
  parameters: Maybe<TrialsDocAccessFields_Parameters>;
  previewImage: Maybe<TrialsDocAccessFields_PreviewImage>;
  testObjectives: Maybe<TrialsDocAccessFields_TestObjectives>;
  updatedAt: Maybe<TrialsDocAccessFields_UpdatedAt>;
};

export type TrialsDocAccessFields_Batch = {
  __typename?: 'TrialsDocAccessFields_batch';
  create: Maybe<TrialsDocAccessFields_Batch_Create>;
  delete: Maybe<TrialsDocAccessFields_Batch_Delete>;
  read: Maybe<TrialsDocAccessFields_Batch_Read>;
  update: Maybe<TrialsDocAccessFields_Batch_Update>;
};

export type TrialsDocAccessFields_Batch_Create = {
  __typename?: 'TrialsDocAccessFields_batch_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Batch_Delete = {
  __typename?: 'TrialsDocAccessFields_batch_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Batch_Read = {
  __typename?: 'TrialsDocAccessFields_batch_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Batch_Update = {
  __typename?: 'TrialsDocAccessFields_batch_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_CreatedAt = {
  __typename?: 'TrialsDocAccessFields_createdAt';
  create: Maybe<TrialsDocAccessFields_CreatedAt_Create>;
  delete: Maybe<TrialsDocAccessFields_CreatedAt_Delete>;
  read: Maybe<TrialsDocAccessFields_CreatedAt_Read>;
  update: Maybe<TrialsDocAccessFields_CreatedAt_Update>;
};

export type TrialsDocAccessFields_CreatedAt_Create = {
  __typename?: 'TrialsDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_CreatedAt_Delete = {
  __typename?: 'TrialsDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_CreatedAt_Read = {
  __typename?: 'TrialsDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_CreatedAt_Update = {
  __typename?: 'TrialsDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Ego = {
  __typename?: 'TrialsDocAccessFields_ego';
  create: Maybe<TrialsDocAccessFields_Ego_Create>;
  delete: Maybe<TrialsDocAccessFields_Ego_Delete>;
  read: Maybe<TrialsDocAccessFields_Ego_Read>;
  update: Maybe<TrialsDocAccessFields_Ego_Update>;
};

export type TrialsDocAccessFields_Ego_Create = {
  __typename?: 'TrialsDocAccessFields_ego_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Ego_Delete = {
  __typename?: 'TrialsDocAccessFields_ego_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Ego_Read = {
  __typename?: 'TrialsDocAccessFields_ego_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Ego_Update = {
  __typename?: 'TrialsDocAccessFields_ego_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_EsminiDat = {
  __typename?: 'TrialsDocAccessFields_esminiDat';
  create: Maybe<TrialsDocAccessFields_EsminiDat_Create>;
  delete: Maybe<TrialsDocAccessFields_EsminiDat_Delete>;
  read: Maybe<TrialsDocAccessFields_EsminiDat_Read>;
  update: Maybe<TrialsDocAccessFields_EsminiDat_Update>;
};

export type TrialsDocAccessFields_EsminiDat_Create = {
  __typename?: 'TrialsDocAccessFields_esminiDat_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_EsminiDat_Delete = {
  __typename?: 'TrialsDocAccessFields_esminiDat_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_EsminiDat_Read = {
  __typename?: 'TrialsDocAccessFields_esminiDat_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_EsminiDat_Update = {
  __typename?: 'TrialsDocAccessFields_esminiDat_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events = {
  __typename?: 'TrialsDocAccessFields_events';
  create: Maybe<TrialsDocAccessFields_Events_Create>;
  delete: Maybe<TrialsDocAccessFields_Events_Delete>;
  fields: Maybe<TrialsDocAccessFields_Events_Fields>;
  read: Maybe<TrialsDocAccessFields_Events_Read>;
  update: Maybe<TrialsDocAccessFields_Events_Update>;
};

export type TrialsDocAccessFields_Events_Create = {
  __typename?: 'TrialsDocAccessFields_events_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Delete = {
  __typename?: 'TrialsDocAccessFields_events_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Fields = {
  __typename?: 'TrialsDocAccessFields_events_Fields';
  esminiSeconds: Maybe<TrialsDocAccessFields_Events_EsminiSeconds>;
  id: Maybe<TrialsDocAccessFields_Events_Id>;
  name: Maybe<TrialsDocAccessFields_Events_Name>;
  observationIndex: Maybe<TrialsDocAccessFields_Events_ObservationIndex>;
  previewImage: Maybe<TrialsDocAccessFields_Events_PreviewImage>;
  time: Maybe<TrialsDocAccessFields_Events_Time>;
};

export type TrialsDocAccessFields_Events_Read = {
  __typename?: 'TrialsDocAccessFields_events_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Update = {
  __typename?: 'TrialsDocAccessFields_events_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_EsminiSeconds = {
  __typename?: 'TrialsDocAccessFields_events_esminiSeconds';
  create: Maybe<TrialsDocAccessFields_Events_EsminiSeconds_Create>;
  delete: Maybe<TrialsDocAccessFields_Events_EsminiSeconds_Delete>;
  read: Maybe<TrialsDocAccessFields_Events_EsminiSeconds_Read>;
  update: Maybe<TrialsDocAccessFields_Events_EsminiSeconds_Update>;
};

export type TrialsDocAccessFields_Events_EsminiSeconds_Create = {
  __typename?: 'TrialsDocAccessFields_events_esminiSeconds_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_EsminiSeconds_Delete = {
  __typename?: 'TrialsDocAccessFields_events_esminiSeconds_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_EsminiSeconds_Read = {
  __typename?: 'TrialsDocAccessFields_events_esminiSeconds_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_EsminiSeconds_Update = {
  __typename?: 'TrialsDocAccessFields_events_esminiSeconds_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Id = {
  __typename?: 'TrialsDocAccessFields_events_id';
  create: Maybe<TrialsDocAccessFields_Events_Id_Create>;
  delete: Maybe<TrialsDocAccessFields_Events_Id_Delete>;
  read: Maybe<TrialsDocAccessFields_Events_Id_Read>;
  update: Maybe<TrialsDocAccessFields_Events_Id_Update>;
};

export type TrialsDocAccessFields_Events_Id_Create = {
  __typename?: 'TrialsDocAccessFields_events_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Id_Delete = {
  __typename?: 'TrialsDocAccessFields_events_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Id_Read = {
  __typename?: 'TrialsDocAccessFields_events_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Id_Update = {
  __typename?: 'TrialsDocAccessFields_events_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Name = {
  __typename?: 'TrialsDocAccessFields_events_name';
  create: Maybe<TrialsDocAccessFields_Events_Name_Create>;
  delete: Maybe<TrialsDocAccessFields_Events_Name_Delete>;
  read: Maybe<TrialsDocAccessFields_Events_Name_Read>;
  update: Maybe<TrialsDocAccessFields_Events_Name_Update>;
};

export type TrialsDocAccessFields_Events_Name_Create = {
  __typename?: 'TrialsDocAccessFields_events_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Name_Delete = {
  __typename?: 'TrialsDocAccessFields_events_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Name_Read = {
  __typename?: 'TrialsDocAccessFields_events_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Name_Update = {
  __typename?: 'TrialsDocAccessFields_events_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_ObservationIndex = {
  __typename?: 'TrialsDocAccessFields_events_observationIndex';
  create: Maybe<TrialsDocAccessFields_Events_ObservationIndex_Create>;
  delete: Maybe<TrialsDocAccessFields_Events_ObservationIndex_Delete>;
  read: Maybe<TrialsDocAccessFields_Events_ObservationIndex_Read>;
  update: Maybe<TrialsDocAccessFields_Events_ObservationIndex_Update>;
};

export type TrialsDocAccessFields_Events_ObservationIndex_Create = {
  __typename?: 'TrialsDocAccessFields_events_observationIndex_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_ObservationIndex_Delete = {
  __typename?: 'TrialsDocAccessFields_events_observationIndex_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_ObservationIndex_Read = {
  __typename?: 'TrialsDocAccessFields_events_observationIndex_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_ObservationIndex_Update = {
  __typename?: 'TrialsDocAccessFields_events_observationIndex_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_PreviewImage = {
  __typename?: 'TrialsDocAccessFields_events_previewImage';
  create: Maybe<TrialsDocAccessFields_Events_PreviewImage_Create>;
  delete: Maybe<TrialsDocAccessFields_Events_PreviewImage_Delete>;
  read: Maybe<TrialsDocAccessFields_Events_PreviewImage_Read>;
  update: Maybe<TrialsDocAccessFields_Events_PreviewImage_Update>;
};

export type TrialsDocAccessFields_Events_PreviewImage_Create = {
  __typename?: 'TrialsDocAccessFields_events_previewImage_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_PreviewImage_Delete = {
  __typename?: 'TrialsDocAccessFields_events_previewImage_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_PreviewImage_Read = {
  __typename?: 'TrialsDocAccessFields_events_previewImage_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_PreviewImage_Update = {
  __typename?: 'TrialsDocAccessFields_events_previewImage_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Time = {
  __typename?: 'TrialsDocAccessFields_events_time';
  create: Maybe<TrialsDocAccessFields_Events_Time_Create>;
  delete: Maybe<TrialsDocAccessFields_Events_Time_Delete>;
  read: Maybe<TrialsDocAccessFields_Events_Time_Read>;
  update: Maybe<TrialsDocAccessFields_Events_Time_Update>;
};

export type TrialsDocAccessFields_Events_Time_Create = {
  __typename?: 'TrialsDocAccessFields_events_time_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Time_Delete = {
  __typename?: 'TrialsDocAccessFields_events_time_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Time_Read = {
  __typename?: 'TrialsDocAccessFields_events_time_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Events_Time_Update = {
  __typename?: 'TrialsDocAccessFields_events_time_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters = {
  __typename?: 'TrialsDocAccessFields_parameters';
  create: Maybe<TrialsDocAccessFields_Parameters_Create>;
  delete: Maybe<TrialsDocAccessFields_Parameters_Delete>;
  fields: Maybe<TrialsDocAccessFields_Parameters_Fields>;
  read: Maybe<TrialsDocAccessFields_Parameters_Read>;
  update: Maybe<TrialsDocAccessFields_Parameters_Update>;
};

export type TrialsDocAccessFields_Parameters_Create = {
  __typename?: 'TrialsDocAccessFields_parameters_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Delete = {
  __typename?: 'TrialsDocAccessFields_parameters_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Fields = {
  __typename?: 'TrialsDocAccessFields_parameters_Fields';
  id: Maybe<TrialsDocAccessFields_Parameters_Id>;
  parameterId: Maybe<TrialsDocAccessFields_Parameters_ParameterId>;
  value: Maybe<TrialsDocAccessFields_Parameters_Value>;
};

export type TrialsDocAccessFields_Parameters_Read = {
  __typename?: 'TrialsDocAccessFields_parameters_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Update = {
  __typename?: 'TrialsDocAccessFields_parameters_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Id = {
  __typename?: 'TrialsDocAccessFields_parameters_id';
  create: Maybe<TrialsDocAccessFields_Parameters_Id_Create>;
  delete: Maybe<TrialsDocAccessFields_Parameters_Id_Delete>;
  read: Maybe<TrialsDocAccessFields_Parameters_Id_Read>;
  update: Maybe<TrialsDocAccessFields_Parameters_Id_Update>;
};

export type TrialsDocAccessFields_Parameters_Id_Create = {
  __typename?: 'TrialsDocAccessFields_parameters_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Id_Delete = {
  __typename?: 'TrialsDocAccessFields_parameters_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Id_Read = {
  __typename?: 'TrialsDocAccessFields_parameters_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Id_Update = {
  __typename?: 'TrialsDocAccessFields_parameters_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_ParameterId = {
  __typename?: 'TrialsDocAccessFields_parameters_parameterId';
  create: Maybe<TrialsDocAccessFields_Parameters_ParameterId_Create>;
  delete: Maybe<TrialsDocAccessFields_Parameters_ParameterId_Delete>;
  read: Maybe<TrialsDocAccessFields_Parameters_ParameterId_Read>;
  update: Maybe<TrialsDocAccessFields_Parameters_ParameterId_Update>;
};

export type TrialsDocAccessFields_Parameters_ParameterId_Create = {
  __typename?: 'TrialsDocAccessFields_parameters_parameterId_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_ParameterId_Delete = {
  __typename?: 'TrialsDocAccessFields_parameters_parameterId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_ParameterId_Read = {
  __typename?: 'TrialsDocAccessFields_parameters_parameterId_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_ParameterId_Update = {
  __typename?: 'TrialsDocAccessFields_parameters_parameterId_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Value = {
  __typename?: 'TrialsDocAccessFields_parameters_value';
  create: Maybe<TrialsDocAccessFields_Parameters_Value_Create>;
  delete: Maybe<TrialsDocAccessFields_Parameters_Value_Delete>;
  read: Maybe<TrialsDocAccessFields_Parameters_Value_Read>;
  update: Maybe<TrialsDocAccessFields_Parameters_Value_Update>;
};

export type TrialsDocAccessFields_Parameters_Value_Create = {
  __typename?: 'TrialsDocAccessFields_parameters_value_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Value_Delete = {
  __typename?: 'TrialsDocAccessFields_parameters_value_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Value_Read = {
  __typename?: 'TrialsDocAccessFields_parameters_value_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_Parameters_Value_Update = {
  __typename?: 'TrialsDocAccessFields_parameters_value_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_PreviewImage = {
  __typename?: 'TrialsDocAccessFields_previewImage';
  create: Maybe<TrialsDocAccessFields_PreviewImage_Create>;
  delete: Maybe<TrialsDocAccessFields_PreviewImage_Delete>;
  read: Maybe<TrialsDocAccessFields_PreviewImage_Read>;
  update: Maybe<TrialsDocAccessFields_PreviewImage_Update>;
};

export type TrialsDocAccessFields_PreviewImage_Create = {
  __typename?: 'TrialsDocAccessFields_previewImage_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_PreviewImage_Delete = {
  __typename?: 'TrialsDocAccessFields_previewImage_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_PreviewImage_Read = {
  __typename?: 'TrialsDocAccessFields_previewImage_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_PreviewImage_Update = {
  __typename?: 'TrialsDocAccessFields_previewImage_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives = {
  __typename?: 'TrialsDocAccessFields_testObjectives';
  create: Maybe<TrialsDocAccessFields_TestObjectives_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_Delete>;
  fields: Maybe<TrialsDocAccessFields_TestObjectives_Fields>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_Update>;
};

export type TrialsDocAccessFields_TestObjectives_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_Fields = {
  __typename?: 'TrialsDocAccessFields_testObjectives_Fields';
  criticalityMetrics: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics>;
  referenceModels: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels>;
};

export type TrialsDocAccessFields_TestObjectives_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Delete>;
  fields: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Fields>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Fields = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_Fields';
  firstFailedObservationIndex: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex>;
  id: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id>;
  keyPerformanceIndicator: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator>;
  passed: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed>;
  value: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value>;
  worstObservation: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation>;
  worstObservationIndex: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_firstFailedObservationIndex';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_id';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Id_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_passed';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_passed_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_passed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_passed_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Passed_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_passed_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_value';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_value_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_value_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_value_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_Value_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_value_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservation';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservationIndex';
  create: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Update>;
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservationIndex_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservationIndex_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservationIndex_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservationIndex_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservation_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservation_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservation_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_CriticalityMetrics_WorstObservation_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_criticalityMetrics_worstObservation_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels';
  create: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Delete>;
  fields: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Fields>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Update>;
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Fields = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_Fields';
  id: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Id>;
  passed: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed>;
  referenceModel: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel>;
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Id = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_id';
  create: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Update>;
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Id_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_passed';
  create: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Update>;
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_passed_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_passed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_passed_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_Passed_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_passed_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_referenceModel';
  create: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Create>;
  delete: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Delete>;
  read: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Read>;
  update: Maybe<TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Update>;
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Create = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_referenceModel_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Delete = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_referenceModel_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Read = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_referenceModel_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_TestObjectives_ReferenceModels_ReferenceModel_Update = {
  __typename?: 'TrialsDocAccessFields_testObjectives_referenceModels_referenceModel_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_UpdatedAt = {
  __typename?: 'TrialsDocAccessFields_updatedAt';
  create: Maybe<TrialsDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<TrialsDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<TrialsDocAccessFields_UpdatedAt_Read>;
  update: Maybe<TrialsDocAccessFields_UpdatedAt_Update>;
};

export type TrialsDocAccessFields_UpdatedAt_Create = {
  __typename?: 'TrialsDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'TrialsDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_UpdatedAt_Read = {
  __typename?: 'TrialsDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsDocAccessFields_UpdatedAt_Update = {
  __typename?: 'TrialsDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields = {
  __typename?: 'TrialsFields';
  batch: Maybe<TrialsFields_Batch>;
  createdAt: Maybe<TrialsFields_CreatedAt>;
  ego: Maybe<TrialsFields_Ego>;
  esminiDat: Maybe<TrialsFields_EsminiDat>;
  events: Maybe<TrialsFields_Events>;
  parameters: Maybe<TrialsFields_Parameters>;
  previewImage: Maybe<TrialsFields_PreviewImage>;
  testObjectives: Maybe<TrialsFields_TestObjectives>;
  updatedAt: Maybe<TrialsFields_UpdatedAt>;
};

export type TrialsFields_Batch = {
  __typename?: 'TrialsFields_batch';
  create: Maybe<TrialsFields_Batch_Create>;
  delete: Maybe<TrialsFields_Batch_Delete>;
  read: Maybe<TrialsFields_Batch_Read>;
  update: Maybe<TrialsFields_Batch_Update>;
};

export type TrialsFields_Batch_Create = {
  __typename?: 'TrialsFields_batch_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Batch_Delete = {
  __typename?: 'TrialsFields_batch_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Batch_Read = {
  __typename?: 'TrialsFields_batch_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Batch_Update = {
  __typename?: 'TrialsFields_batch_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_CreatedAt = {
  __typename?: 'TrialsFields_createdAt';
  create: Maybe<TrialsFields_CreatedAt_Create>;
  delete: Maybe<TrialsFields_CreatedAt_Delete>;
  read: Maybe<TrialsFields_CreatedAt_Read>;
  update: Maybe<TrialsFields_CreatedAt_Update>;
};

export type TrialsFields_CreatedAt_Create = {
  __typename?: 'TrialsFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_CreatedAt_Delete = {
  __typename?: 'TrialsFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_CreatedAt_Read = {
  __typename?: 'TrialsFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_CreatedAt_Update = {
  __typename?: 'TrialsFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Ego = {
  __typename?: 'TrialsFields_ego';
  create: Maybe<TrialsFields_Ego_Create>;
  delete: Maybe<TrialsFields_Ego_Delete>;
  read: Maybe<TrialsFields_Ego_Read>;
  update: Maybe<TrialsFields_Ego_Update>;
};

export type TrialsFields_Ego_Create = {
  __typename?: 'TrialsFields_ego_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Ego_Delete = {
  __typename?: 'TrialsFields_ego_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Ego_Read = {
  __typename?: 'TrialsFields_ego_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Ego_Update = {
  __typename?: 'TrialsFields_ego_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_EsminiDat = {
  __typename?: 'TrialsFields_esminiDat';
  create: Maybe<TrialsFields_EsminiDat_Create>;
  delete: Maybe<TrialsFields_EsminiDat_Delete>;
  read: Maybe<TrialsFields_EsminiDat_Read>;
  update: Maybe<TrialsFields_EsminiDat_Update>;
};

export type TrialsFields_EsminiDat_Create = {
  __typename?: 'TrialsFields_esminiDat_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_EsminiDat_Delete = {
  __typename?: 'TrialsFields_esminiDat_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_EsminiDat_Read = {
  __typename?: 'TrialsFields_esminiDat_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_EsminiDat_Update = {
  __typename?: 'TrialsFields_esminiDat_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events = {
  __typename?: 'TrialsFields_events';
  create: Maybe<TrialsFields_Events_Create>;
  delete: Maybe<TrialsFields_Events_Delete>;
  fields: Maybe<TrialsFields_Events_Fields>;
  read: Maybe<TrialsFields_Events_Read>;
  update: Maybe<TrialsFields_Events_Update>;
};

export type TrialsFields_Events_Create = {
  __typename?: 'TrialsFields_events_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Delete = {
  __typename?: 'TrialsFields_events_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Fields = {
  __typename?: 'TrialsFields_events_Fields';
  esminiSeconds: Maybe<TrialsFields_Events_EsminiSeconds>;
  id: Maybe<TrialsFields_Events_Id>;
  name: Maybe<TrialsFields_Events_Name>;
  observationIndex: Maybe<TrialsFields_Events_ObservationIndex>;
  previewImage: Maybe<TrialsFields_Events_PreviewImage>;
  time: Maybe<TrialsFields_Events_Time>;
};

export type TrialsFields_Events_Read = {
  __typename?: 'TrialsFields_events_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Update = {
  __typename?: 'TrialsFields_events_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_EsminiSeconds = {
  __typename?: 'TrialsFields_events_esminiSeconds';
  create: Maybe<TrialsFields_Events_EsminiSeconds_Create>;
  delete: Maybe<TrialsFields_Events_EsminiSeconds_Delete>;
  read: Maybe<TrialsFields_Events_EsminiSeconds_Read>;
  update: Maybe<TrialsFields_Events_EsminiSeconds_Update>;
};

export type TrialsFields_Events_EsminiSeconds_Create = {
  __typename?: 'TrialsFields_events_esminiSeconds_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_EsminiSeconds_Delete = {
  __typename?: 'TrialsFields_events_esminiSeconds_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_EsminiSeconds_Read = {
  __typename?: 'TrialsFields_events_esminiSeconds_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_EsminiSeconds_Update = {
  __typename?: 'TrialsFields_events_esminiSeconds_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Id = {
  __typename?: 'TrialsFields_events_id';
  create: Maybe<TrialsFields_Events_Id_Create>;
  delete: Maybe<TrialsFields_Events_Id_Delete>;
  read: Maybe<TrialsFields_Events_Id_Read>;
  update: Maybe<TrialsFields_Events_Id_Update>;
};

export type TrialsFields_Events_Id_Create = {
  __typename?: 'TrialsFields_events_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Id_Delete = {
  __typename?: 'TrialsFields_events_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Id_Read = {
  __typename?: 'TrialsFields_events_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Id_Update = {
  __typename?: 'TrialsFields_events_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Name = {
  __typename?: 'TrialsFields_events_name';
  create: Maybe<TrialsFields_Events_Name_Create>;
  delete: Maybe<TrialsFields_Events_Name_Delete>;
  read: Maybe<TrialsFields_Events_Name_Read>;
  update: Maybe<TrialsFields_Events_Name_Update>;
};

export type TrialsFields_Events_Name_Create = {
  __typename?: 'TrialsFields_events_name_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Name_Delete = {
  __typename?: 'TrialsFields_events_name_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Name_Read = {
  __typename?: 'TrialsFields_events_name_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Name_Update = {
  __typename?: 'TrialsFields_events_name_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_ObservationIndex = {
  __typename?: 'TrialsFields_events_observationIndex';
  create: Maybe<TrialsFields_Events_ObservationIndex_Create>;
  delete: Maybe<TrialsFields_Events_ObservationIndex_Delete>;
  read: Maybe<TrialsFields_Events_ObservationIndex_Read>;
  update: Maybe<TrialsFields_Events_ObservationIndex_Update>;
};

export type TrialsFields_Events_ObservationIndex_Create = {
  __typename?: 'TrialsFields_events_observationIndex_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_ObservationIndex_Delete = {
  __typename?: 'TrialsFields_events_observationIndex_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_ObservationIndex_Read = {
  __typename?: 'TrialsFields_events_observationIndex_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_ObservationIndex_Update = {
  __typename?: 'TrialsFields_events_observationIndex_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_PreviewImage = {
  __typename?: 'TrialsFields_events_previewImage';
  create: Maybe<TrialsFields_Events_PreviewImage_Create>;
  delete: Maybe<TrialsFields_Events_PreviewImage_Delete>;
  read: Maybe<TrialsFields_Events_PreviewImage_Read>;
  update: Maybe<TrialsFields_Events_PreviewImage_Update>;
};

export type TrialsFields_Events_PreviewImage_Create = {
  __typename?: 'TrialsFields_events_previewImage_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_PreviewImage_Delete = {
  __typename?: 'TrialsFields_events_previewImage_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_PreviewImage_Read = {
  __typename?: 'TrialsFields_events_previewImage_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_PreviewImage_Update = {
  __typename?: 'TrialsFields_events_previewImage_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Time = {
  __typename?: 'TrialsFields_events_time';
  create: Maybe<TrialsFields_Events_Time_Create>;
  delete: Maybe<TrialsFields_Events_Time_Delete>;
  read: Maybe<TrialsFields_Events_Time_Read>;
  update: Maybe<TrialsFields_Events_Time_Update>;
};

export type TrialsFields_Events_Time_Create = {
  __typename?: 'TrialsFields_events_time_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Time_Delete = {
  __typename?: 'TrialsFields_events_time_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Time_Read = {
  __typename?: 'TrialsFields_events_time_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Events_Time_Update = {
  __typename?: 'TrialsFields_events_time_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters = {
  __typename?: 'TrialsFields_parameters';
  create: Maybe<TrialsFields_Parameters_Create>;
  delete: Maybe<TrialsFields_Parameters_Delete>;
  fields: Maybe<TrialsFields_Parameters_Fields>;
  read: Maybe<TrialsFields_Parameters_Read>;
  update: Maybe<TrialsFields_Parameters_Update>;
};

export type TrialsFields_Parameters_Create = {
  __typename?: 'TrialsFields_parameters_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Delete = {
  __typename?: 'TrialsFields_parameters_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Fields = {
  __typename?: 'TrialsFields_parameters_Fields';
  id: Maybe<TrialsFields_Parameters_Id>;
  parameterId: Maybe<TrialsFields_Parameters_ParameterId>;
  value: Maybe<TrialsFields_Parameters_Value>;
};

export type TrialsFields_Parameters_Read = {
  __typename?: 'TrialsFields_parameters_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Update = {
  __typename?: 'TrialsFields_parameters_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Id = {
  __typename?: 'TrialsFields_parameters_id';
  create: Maybe<TrialsFields_Parameters_Id_Create>;
  delete: Maybe<TrialsFields_Parameters_Id_Delete>;
  read: Maybe<TrialsFields_Parameters_Id_Read>;
  update: Maybe<TrialsFields_Parameters_Id_Update>;
};

export type TrialsFields_Parameters_Id_Create = {
  __typename?: 'TrialsFields_parameters_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Id_Delete = {
  __typename?: 'TrialsFields_parameters_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Id_Read = {
  __typename?: 'TrialsFields_parameters_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Id_Update = {
  __typename?: 'TrialsFields_parameters_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_ParameterId = {
  __typename?: 'TrialsFields_parameters_parameterId';
  create: Maybe<TrialsFields_Parameters_ParameterId_Create>;
  delete: Maybe<TrialsFields_Parameters_ParameterId_Delete>;
  read: Maybe<TrialsFields_Parameters_ParameterId_Read>;
  update: Maybe<TrialsFields_Parameters_ParameterId_Update>;
};

export type TrialsFields_Parameters_ParameterId_Create = {
  __typename?: 'TrialsFields_parameters_parameterId_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_ParameterId_Delete = {
  __typename?: 'TrialsFields_parameters_parameterId_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_ParameterId_Read = {
  __typename?: 'TrialsFields_parameters_parameterId_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_ParameterId_Update = {
  __typename?: 'TrialsFields_parameters_parameterId_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Value = {
  __typename?: 'TrialsFields_parameters_value';
  create: Maybe<TrialsFields_Parameters_Value_Create>;
  delete: Maybe<TrialsFields_Parameters_Value_Delete>;
  read: Maybe<TrialsFields_Parameters_Value_Read>;
  update: Maybe<TrialsFields_Parameters_Value_Update>;
};

export type TrialsFields_Parameters_Value_Create = {
  __typename?: 'TrialsFields_parameters_value_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Value_Delete = {
  __typename?: 'TrialsFields_parameters_value_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Value_Read = {
  __typename?: 'TrialsFields_parameters_value_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_Parameters_Value_Update = {
  __typename?: 'TrialsFields_parameters_value_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_PreviewImage = {
  __typename?: 'TrialsFields_previewImage';
  create: Maybe<TrialsFields_PreviewImage_Create>;
  delete: Maybe<TrialsFields_PreviewImage_Delete>;
  read: Maybe<TrialsFields_PreviewImage_Read>;
  update: Maybe<TrialsFields_PreviewImage_Update>;
};

export type TrialsFields_PreviewImage_Create = {
  __typename?: 'TrialsFields_previewImage_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_PreviewImage_Delete = {
  __typename?: 'TrialsFields_previewImage_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_PreviewImage_Read = {
  __typename?: 'TrialsFields_previewImage_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_PreviewImage_Update = {
  __typename?: 'TrialsFields_previewImage_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives = {
  __typename?: 'TrialsFields_testObjectives';
  create: Maybe<TrialsFields_TestObjectives_Create>;
  delete: Maybe<TrialsFields_TestObjectives_Delete>;
  fields: Maybe<TrialsFields_TestObjectives_Fields>;
  read: Maybe<TrialsFields_TestObjectives_Read>;
  update: Maybe<TrialsFields_TestObjectives_Update>;
};

export type TrialsFields_TestObjectives_Create = {
  __typename?: 'TrialsFields_testObjectives_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_Delete = {
  __typename?: 'TrialsFields_testObjectives_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_Fields = {
  __typename?: 'TrialsFields_testObjectives_Fields';
  criticalityMetrics: Maybe<TrialsFields_TestObjectives_CriticalityMetrics>;
  referenceModels: Maybe<TrialsFields_TestObjectives_ReferenceModels>;
};

export type TrialsFields_TestObjectives_Read = {
  __typename?: 'TrialsFields_testObjectives_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_Update = {
  __typename?: 'TrialsFields_testObjectives_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Delete>;
  fields: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Fields>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Fields = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_Fields';
  firstFailedObservationIndex: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex>;
  id: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Id>;
  keyPerformanceIndicator: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator>;
  passed: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Passed>;
  value: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Value>;
  worstObservation: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation>;
  worstObservationIndex: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_firstFailedObservationIndex';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Delete>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_FirstFailedObservationIndex_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_firstFailedObservationIndex_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Id = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_id';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Id_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Id_Delete>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Id_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Id_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Id_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Id_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Id_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Id_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_keyPerformanceIndicator';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_KeyPerformanceIndicator_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_keyPerformanceIndicator_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Passed = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_passed';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Passed_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Passed_Delete>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Passed_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Passed_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Passed_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_passed_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Passed_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_passed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Passed_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_passed_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Passed_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_passed_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Value = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_value';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Value_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Value_Delete>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Value_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_Value_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Value_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_value_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Value_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_value_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Value_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_value_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_Value_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_value_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservation';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Delete>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservationIndex';
  create: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Create>;
  delete: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Delete>;
  read: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Read>;
  update: Maybe<TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Update>;
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservationIndex_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservationIndex_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservationIndex_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservationIndex_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservationIndex_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Create = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservation_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Delete = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservation_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Read = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservation_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_CriticalityMetrics_WorstObservation_Update = {
  __typename?: 'TrialsFields_testObjectives_criticalityMetrics_worstObservation_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels = {
  __typename?: 'TrialsFields_testObjectives_referenceModels';
  create: Maybe<TrialsFields_TestObjectives_ReferenceModels_Create>;
  delete: Maybe<TrialsFields_TestObjectives_ReferenceModels_Delete>;
  fields: Maybe<TrialsFields_TestObjectives_ReferenceModels_Fields>;
  read: Maybe<TrialsFields_TestObjectives_ReferenceModels_Read>;
  update: Maybe<TrialsFields_TestObjectives_ReferenceModels_Update>;
};

export type TrialsFields_TestObjectives_ReferenceModels_Create = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Delete = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Fields = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_Fields';
  id: Maybe<TrialsFields_TestObjectives_ReferenceModels_Id>;
  passed: Maybe<TrialsFields_TestObjectives_ReferenceModels_Passed>;
  referenceModel: Maybe<TrialsFields_TestObjectives_ReferenceModels_ReferenceModel>;
};

export type TrialsFields_TestObjectives_ReferenceModels_Read = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Update = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Id = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_id';
  create: Maybe<TrialsFields_TestObjectives_ReferenceModels_Id_Create>;
  delete: Maybe<TrialsFields_TestObjectives_ReferenceModels_Id_Delete>;
  read: Maybe<TrialsFields_TestObjectives_ReferenceModels_Id_Read>;
  update: Maybe<TrialsFields_TestObjectives_ReferenceModels_Id_Update>;
};

export type TrialsFields_TestObjectives_ReferenceModels_Id_Create = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Id_Delete = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Id_Read = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Id_Update = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Passed = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_passed';
  create: Maybe<TrialsFields_TestObjectives_ReferenceModels_Passed_Create>;
  delete: Maybe<TrialsFields_TestObjectives_ReferenceModels_Passed_Delete>;
  read: Maybe<TrialsFields_TestObjectives_ReferenceModels_Passed_Read>;
  update: Maybe<TrialsFields_TestObjectives_ReferenceModels_Passed_Update>;
};

export type TrialsFields_TestObjectives_ReferenceModels_Passed_Create = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_passed_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Passed_Delete = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_passed_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Passed_Read = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_passed_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_Passed_Update = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_passed_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_ReferenceModel = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_referenceModel';
  create: Maybe<TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Create>;
  delete: Maybe<TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Delete>;
  read: Maybe<TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Read>;
  update: Maybe<TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Update>;
};

export type TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Create = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_referenceModel_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Delete = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_referenceModel_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Read = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_referenceModel_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_TestObjectives_ReferenceModels_ReferenceModel_Update = {
  __typename?: 'TrialsFields_testObjectives_referenceModels_referenceModel_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_UpdatedAt = {
  __typename?: 'TrialsFields_updatedAt';
  create: Maybe<TrialsFields_UpdatedAt_Create>;
  delete: Maybe<TrialsFields_UpdatedAt_Delete>;
  read: Maybe<TrialsFields_UpdatedAt_Read>;
  update: Maybe<TrialsFields_UpdatedAt_Update>;
};

export type TrialsFields_UpdatedAt_Create = {
  __typename?: 'TrialsFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_UpdatedAt_Delete = {
  __typename?: 'TrialsFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_UpdatedAt_Read = {
  __typename?: 'TrialsFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type TrialsFields_UpdatedAt_Update = {
  __typename?: 'TrialsFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type TrialsReadAccess = {
  __typename?: 'TrialsReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type TrialsReadDocAccess = {
  __typename?: 'TrialsReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type TrialsUpdateAccess = {
  __typename?: 'TrialsUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type TrialsUpdateDocAccess = {
  __typename?: 'TrialsUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type User = {
  __typename?: 'User';
  apiKey: Maybe<Scalars['String']['output']>;
  apiKeyIndex: Maybe<Scalars['String']['output']>;
  createdAt: Maybe<Scalars['DateTime']['output']>;
  email: Scalars['EmailAddress']['output'];
  enableAPIKey: Maybe<Scalars['Boolean']['output']>;
  hash: Maybe<Scalars['String']['output']>;
  id: Scalars['Int']['output'];
  lockUntil: Maybe<Scalars['DateTime']['output']>;
  loginAttempts: Maybe<Scalars['Float']['output']>;
  resetPasswordExpiration: Maybe<Scalars['DateTime']['output']>;
  resetPasswordToken: Maybe<Scalars['String']['output']>;
  salt: Maybe<Scalars['String']['output']>;
  sessions: Maybe<Array<User_Sessions>>;
  updatedAt: Maybe<Scalars['DateTime']['output']>;
};

export type User_Sessions = {
  __typename?: 'User_Sessions';
  createdAt: Maybe<Scalars['DateTime']['output']>;
  expiresAt: Maybe<Scalars['DateTime']['output']>;
  id: Maybe<Scalars['String']['output']>;
};

export type User_ApiKey_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type User_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type User_Email_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['EmailAddress']['input']>>>;
  contains: InputMaybe<Scalars['EmailAddress']['input']>;
  equals: InputMaybe<Scalars['EmailAddress']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['EmailAddress']['input']>>>;
  like: InputMaybe<Scalars['EmailAddress']['input']>;
  not_equals: InputMaybe<Scalars['EmailAddress']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['EmailAddress']['input']>>>;
};

export type User_EnableApiKey_Operator = {
  equals: InputMaybe<Scalars['Boolean']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  not_equals: InputMaybe<Scalars['Boolean']['input']>;
};

export type User_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type User_Sessions__CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type User_Sessions__ExpiresAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type User_Sessions__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type User_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type User_Where = {
  AND: InputMaybe<Array<InputMaybe<User_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<User_Where_Or>>>;
  apiKey: InputMaybe<User_ApiKey_Operator>;
  createdAt: InputMaybe<User_CreatedAt_Operator>;
  email: InputMaybe<User_Email_Operator>;
  enableAPIKey: InputMaybe<User_EnableApiKey_Operator>;
  id: InputMaybe<User_Id_Operator>;
  sessions__createdAt: InputMaybe<User_Sessions__CreatedAt_Operator>;
  sessions__expiresAt: InputMaybe<User_Sessions__ExpiresAt_Operator>;
  sessions__id: InputMaybe<User_Sessions__Id_Operator>;
  updatedAt: InputMaybe<User_UpdatedAt_Operator>;
};

export type User_Where_And = {
  AND: InputMaybe<Array<InputMaybe<User_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<User_Where_Or>>>;
  apiKey: InputMaybe<User_ApiKey_Operator>;
  createdAt: InputMaybe<User_CreatedAt_Operator>;
  email: InputMaybe<User_Email_Operator>;
  enableAPIKey: InputMaybe<User_EnableApiKey_Operator>;
  id: InputMaybe<User_Id_Operator>;
  sessions__createdAt: InputMaybe<User_Sessions__CreatedAt_Operator>;
  sessions__expiresAt: InputMaybe<User_Sessions__ExpiresAt_Operator>;
  sessions__id: InputMaybe<User_Sessions__Id_Operator>;
  updatedAt: InputMaybe<User_UpdatedAt_Operator>;
};

export type User_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<User_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<User_Where_Or>>>;
  apiKey: InputMaybe<User_ApiKey_Operator>;
  createdAt: InputMaybe<User_CreatedAt_Operator>;
  email: InputMaybe<User_Email_Operator>;
  enableAPIKey: InputMaybe<User_EnableApiKey_Operator>;
  id: InputMaybe<User_Id_Operator>;
  sessions__createdAt: InputMaybe<User_Sessions__CreatedAt_Operator>;
  sessions__expiresAt: InputMaybe<User_Sessions__ExpiresAt_Operator>;
  sessions__id: InputMaybe<User_Sessions__Id_Operator>;
  updatedAt: InputMaybe<User_UpdatedAt_Operator>;
};

export type Users = {
  __typename?: 'Users';
  docs: Array<User>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type UsersCreateAccess = {
  __typename?: 'UsersCreateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersCreateDocAccess = {
  __typename?: 'UsersCreateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersDeleteAccess = {
  __typename?: 'UsersDeleteAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersDeleteDocAccess = {
  __typename?: 'UsersDeleteDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersDocAccessFields = {
  __typename?: 'UsersDocAccessFields';
  apiKey: Maybe<UsersDocAccessFields_ApiKey>;
  createdAt: Maybe<UsersDocAccessFields_CreatedAt>;
  email: Maybe<UsersDocAccessFields_Email>;
  enableAPIKey: Maybe<UsersDocAccessFields_EnableApiKey>;
  sessions: Maybe<UsersDocAccessFields_Sessions>;
  updatedAt: Maybe<UsersDocAccessFields_UpdatedAt>;
};

export type UsersDocAccessFields_ApiKey = {
  __typename?: 'UsersDocAccessFields_apiKey';
  create: Maybe<UsersDocAccessFields_ApiKey_Create>;
  delete: Maybe<UsersDocAccessFields_ApiKey_Delete>;
  read: Maybe<UsersDocAccessFields_ApiKey_Read>;
  update: Maybe<UsersDocAccessFields_ApiKey_Update>;
};

export type UsersDocAccessFields_ApiKey_Create = {
  __typename?: 'UsersDocAccessFields_apiKey_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_ApiKey_Delete = {
  __typename?: 'UsersDocAccessFields_apiKey_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_ApiKey_Read = {
  __typename?: 'UsersDocAccessFields_apiKey_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_ApiKey_Update = {
  __typename?: 'UsersDocAccessFields_apiKey_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_CreatedAt = {
  __typename?: 'UsersDocAccessFields_createdAt';
  create: Maybe<UsersDocAccessFields_CreatedAt_Create>;
  delete: Maybe<UsersDocAccessFields_CreatedAt_Delete>;
  read: Maybe<UsersDocAccessFields_CreatedAt_Read>;
  update: Maybe<UsersDocAccessFields_CreatedAt_Update>;
};

export type UsersDocAccessFields_CreatedAt_Create = {
  __typename?: 'UsersDocAccessFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_CreatedAt_Delete = {
  __typename?: 'UsersDocAccessFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_CreatedAt_Read = {
  __typename?: 'UsersDocAccessFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_CreatedAt_Update = {
  __typename?: 'UsersDocAccessFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Email = {
  __typename?: 'UsersDocAccessFields_email';
  create: Maybe<UsersDocAccessFields_Email_Create>;
  delete: Maybe<UsersDocAccessFields_Email_Delete>;
  read: Maybe<UsersDocAccessFields_Email_Read>;
  update: Maybe<UsersDocAccessFields_Email_Update>;
};

export type UsersDocAccessFields_Email_Create = {
  __typename?: 'UsersDocAccessFields_email_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Email_Delete = {
  __typename?: 'UsersDocAccessFields_email_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Email_Read = {
  __typename?: 'UsersDocAccessFields_email_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Email_Update = {
  __typename?: 'UsersDocAccessFields_email_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_EnableApiKey = {
  __typename?: 'UsersDocAccessFields_enableAPIKey';
  create: Maybe<UsersDocAccessFields_EnableApiKey_Create>;
  delete: Maybe<UsersDocAccessFields_EnableApiKey_Delete>;
  read: Maybe<UsersDocAccessFields_EnableApiKey_Read>;
  update: Maybe<UsersDocAccessFields_EnableApiKey_Update>;
};

export type UsersDocAccessFields_EnableApiKey_Create = {
  __typename?: 'UsersDocAccessFields_enableAPIKey_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_EnableApiKey_Delete = {
  __typename?: 'UsersDocAccessFields_enableAPIKey_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_EnableApiKey_Read = {
  __typename?: 'UsersDocAccessFields_enableAPIKey_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_EnableApiKey_Update = {
  __typename?: 'UsersDocAccessFields_enableAPIKey_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions = {
  __typename?: 'UsersDocAccessFields_sessions';
  create: Maybe<UsersDocAccessFields_Sessions_Create>;
  delete: Maybe<UsersDocAccessFields_Sessions_Delete>;
  fields: Maybe<UsersDocAccessFields_Sessions_Fields>;
  read: Maybe<UsersDocAccessFields_Sessions_Read>;
  update: Maybe<UsersDocAccessFields_Sessions_Update>;
};

export type UsersDocAccessFields_Sessions_Create = {
  __typename?: 'UsersDocAccessFields_sessions_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_Delete = {
  __typename?: 'UsersDocAccessFields_sessions_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_Fields = {
  __typename?: 'UsersDocAccessFields_sessions_Fields';
  createdAt: Maybe<UsersDocAccessFields_Sessions_CreatedAt>;
  expiresAt: Maybe<UsersDocAccessFields_Sessions_ExpiresAt>;
  id: Maybe<UsersDocAccessFields_Sessions_Id>;
};

export type UsersDocAccessFields_Sessions_Read = {
  __typename?: 'UsersDocAccessFields_sessions_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_Update = {
  __typename?: 'UsersDocAccessFields_sessions_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_CreatedAt = {
  __typename?: 'UsersDocAccessFields_sessions_createdAt';
  create: Maybe<UsersDocAccessFields_Sessions_CreatedAt_Create>;
  delete: Maybe<UsersDocAccessFields_Sessions_CreatedAt_Delete>;
  read: Maybe<UsersDocAccessFields_Sessions_CreatedAt_Read>;
  update: Maybe<UsersDocAccessFields_Sessions_CreatedAt_Update>;
};

export type UsersDocAccessFields_Sessions_CreatedAt_Create = {
  __typename?: 'UsersDocAccessFields_sessions_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_CreatedAt_Delete = {
  __typename?: 'UsersDocAccessFields_sessions_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_CreatedAt_Read = {
  __typename?: 'UsersDocAccessFields_sessions_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_CreatedAt_Update = {
  __typename?: 'UsersDocAccessFields_sessions_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_ExpiresAt = {
  __typename?: 'UsersDocAccessFields_sessions_expiresAt';
  create: Maybe<UsersDocAccessFields_Sessions_ExpiresAt_Create>;
  delete: Maybe<UsersDocAccessFields_Sessions_ExpiresAt_Delete>;
  read: Maybe<UsersDocAccessFields_Sessions_ExpiresAt_Read>;
  update: Maybe<UsersDocAccessFields_Sessions_ExpiresAt_Update>;
};

export type UsersDocAccessFields_Sessions_ExpiresAt_Create = {
  __typename?: 'UsersDocAccessFields_sessions_expiresAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_ExpiresAt_Delete = {
  __typename?: 'UsersDocAccessFields_sessions_expiresAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_ExpiresAt_Read = {
  __typename?: 'UsersDocAccessFields_sessions_expiresAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_ExpiresAt_Update = {
  __typename?: 'UsersDocAccessFields_sessions_expiresAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_Id = {
  __typename?: 'UsersDocAccessFields_sessions_id';
  create: Maybe<UsersDocAccessFields_Sessions_Id_Create>;
  delete: Maybe<UsersDocAccessFields_Sessions_Id_Delete>;
  read: Maybe<UsersDocAccessFields_Sessions_Id_Read>;
  update: Maybe<UsersDocAccessFields_Sessions_Id_Update>;
};

export type UsersDocAccessFields_Sessions_Id_Create = {
  __typename?: 'UsersDocAccessFields_sessions_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_Id_Delete = {
  __typename?: 'UsersDocAccessFields_sessions_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_Id_Read = {
  __typename?: 'UsersDocAccessFields_sessions_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_Sessions_Id_Update = {
  __typename?: 'UsersDocAccessFields_sessions_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_UpdatedAt = {
  __typename?: 'UsersDocAccessFields_updatedAt';
  create: Maybe<UsersDocAccessFields_UpdatedAt_Create>;
  delete: Maybe<UsersDocAccessFields_UpdatedAt_Delete>;
  read: Maybe<UsersDocAccessFields_UpdatedAt_Read>;
  update: Maybe<UsersDocAccessFields_UpdatedAt_Update>;
};

export type UsersDocAccessFields_UpdatedAt_Create = {
  __typename?: 'UsersDocAccessFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_UpdatedAt_Delete = {
  __typename?: 'UsersDocAccessFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_UpdatedAt_Read = {
  __typename?: 'UsersDocAccessFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersDocAccessFields_UpdatedAt_Update = {
  __typename?: 'UsersDocAccessFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields = {
  __typename?: 'UsersFields';
  apiKey: Maybe<UsersFields_ApiKey>;
  createdAt: Maybe<UsersFields_CreatedAt>;
  email: Maybe<UsersFields_Email>;
  enableAPIKey: Maybe<UsersFields_EnableApiKey>;
  sessions: Maybe<UsersFields_Sessions>;
  updatedAt: Maybe<UsersFields_UpdatedAt>;
};

export type UsersFields_ApiKey = {
  __typename?: 'UsersFields_apiKey';
  create: Maybe<UsersFields_ApiKey_Create>;
  delete: Maybe<UsersFields_ApiKey_Delete>;
  read: Maybe<UsersFields_ApiKey_Read>;
  update: Maybe<UsersFields_ApiKey_Update>;
};

export type UsersFields_ApiKey_Create = {
  __typename?: 'UsersFields_apiKey_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_ApiKey_Delete = {
  __typename?: 'UsersFields_apiKey_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_ApiKey_Read = {
  __typename?: 'UsersFields_apiKey_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_ApiKey_Update = {
  __typename?: 'UsersFields_apiKey_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_CreatedAt = {
  __typename?: 'UsersFields_createdAt';
  create: Maybe<UsersFields_CreatedAt_Create>;
  delete: Maybe<UsersFields_CreatedAt_Delete>;
  read: Maybe<UsersFields_CreatedAt_Read>;
  update: Maybe<UsersFields_CreatedAt_Update>;
};

export type UsersFields_CreatedAt_Create = {
  __typename?: 'UsersFields_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_CreatedAt_Delete = {
  __typename?: 'UsersFields_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_CreatedAt_Read = {
  __typename?: 'UsersFields_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_CreatedAt_Update = {
  __typename?: 'UsersFields_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Email = {
  __typename?: 'UsersFields_email';
  create: Maybe<UsersFields_Email_Create>;
  delete: Maybe<UsersFields_Email_Delete>;
  read: Maybe<UsersFields_Email_Read>;
  update: Maybe<UsersFields_Email_Update>;
};

export type UsersFields_Email_Create = {
  __typename?: 'UsersFields_email_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Email_Delete = {
  __typename?: 'UsersFields_email_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Email_Read = {
  __typename?: 'UsersFields_email_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Email_Update = {
  __typename?: 'UsersFields_email_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_EnableApiKey = {
  __typename?: 'UsersFields_enableAPIKey';
  create: Maybe<UsersFields_EnableApiKey_Create>;
  delete: Maybe<UsersFields_EnableApiKey_Delete>;
  read: Maybe<UsersFields_EnableApiKey_Read>;
  update: Maybe<UsersFields_EnableApiKey_Update>;
};

export type UsersFields_EnableApiKey_Create = {
  __typename?: 'UsersFields_enableAPIKey_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_EnableApiKey_Delete = {
  __typename?: 'UsersFields_enableAPIKey_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_EnableApiKey_Read = {
  __typename?: 'UsersFields_enableAPIKey_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_EnableApiKey_Update = {
  __typename?: 'UsersFields_enableAPIKey_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions = {
  __typename?: 'UsersFields_sessions';
  create: Maybe<UsersFields_Sessions_Create>;
  delete: Maybe<UsersFields_Sessions_Delete>;
  fields: Maybe<UsersFields_Sessions_Fields>;
  read: Maybe<UsersFields_Sessions_Read>;
  update: Maybe<UsersFields_Sessions_Update>;
};

export type UsersFields_Sessions_Create = {
  __typename?: 'UsersFields_sessions_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_Delete = {
  __typename?: 'UsersFields_sessions_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_Fields = {
  __typename?: 'UsersFields_sessions_Fields';
  createdAt: Maybe<UsersFields_Sessions_CreatedAt>;
  expiresAt: Maybe<UsersFields_Sessions_ExpiresAt>;
  id: Maybe<UsersFields_Sessions_Id>;
};

export type UsersFields_Sessions_Read = {
  __typename?: 'UsersFields_sessions_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_Update = {
  __typename?: 'UsersFields_sessions_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_CreatedAt = {
  __typename?: 'UsersFields_sessions_createdAt';
  create: Maybe<UsersFields_Sessions_CreatedAt_Create>;
  delete: Maybe<UsersFields_Sessions_CreatedAt_Delete>;
  read: Maybe<UsersFields_Sessions_CreatedAt_Read>;
  update: Maybe<UsersFields_Sessions_CreatedAt_Update>;
};

export type UsersFields_Sessions_CreatedAt_Create = {
  __typename?: 'UsersFields_sessions_createdAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_CreatedAt_Delete = {
  __typename?: 'UsersFields_sessions_createdAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_CreatedAt_Read = {
  __typename?: 'UsersFields_sessions_createdAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_CreatedAt_Update = {
  __typename?: 'UsersFields_sessions_createdAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_ExpiresAt = {
  __typename?: 'UsersFields_sessions_expiresAt';
  create: Maybe<UsersFields_Sessions_ExpiresAt_Create>;
  delete: Maybe<UsersFields_Sessions_ExpiresAt_Delete>;
  read: Maybe<UsersFields_Sessions_ExpiresAt_Read>;
  update: Maybe<UsersFields_Sessions_ExpiresAt_Update>;
};

export type UsersFields_Sessions_ExpiresAt_Create = {
  __typename?: 'UsersFields_sessions_expiresAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_ExpiresAt_Delete = {
  __typename?: 'UsersFields_sessions_expiresAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_ExpiresAt_Read = {
  __typename?: 'UsersFields_sessions_expiresAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_ExpiresAt_Update = {
  __typename?: 'UsersFields_sessions_expiresAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_Id = {
  __typename?: 'UsersFields_sessions_id';
  create: Maybe<UsersFields_Sessions_Id_Create>;
  delete: Maybe<UsersFields_Sessions_Id_Delete>;
  read: Maybe<UsersFields_Sessions_Id_Read>;
  update: Maybe<UsersFields_Sessions_Id_Update>;
};

export type UsersFields_Sessions_Id_Create = {
  __typename?: 'UsersFields_sessions_id_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_Id_Delete = {
  __typename?: 'UsersFields_sessions_id_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_Id_Read = {
  __typename?: 'UsersFields_sessions_id_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_Sessions_Id_Update = {
  __typename?: 'UsersFields_sessions_id_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_UpdatedAt = {
  __typename?: 'UsersFields_updatedAt';
  create: Maybe<UsersFields_UpdatedAt_Create>;
  delete: Maybe<UsersFields_UpdatedAt_Delete>;
  read: Maybe<UsersFields_UpdatedAt_Read>;
  update: Maybe<UsersFields_UpdatedAt_Update>;
};

export type UsersFields_UpdatedAt_Create = {
  __typename?: 'UsersFields_updatedAt_Create';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_UpdatedAt_Delete = {
  __typename?: 'UsersFields_updatedAt_Delete';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_UpdatedAt_Read = {
  __typename?: 'UsersFields_updatedAt_Read';
  permission: Scalars['Boolean']['output'];
};

export type UsersFields_UpdatedAt_Update = {
  __typename?: 'UsersFields_updatedAt_Update';
  permission: Scalars['Boolean']['output'];
};

export type UsersReadAccess = {
  __typename?: 'UsersReadAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersReadDocAccess = {
  __typename?: 'UsersReadDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersUnlockAccess = {
  __typename?: 'UsersUnlockAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersUnlockDocAccess = {
  __typename?: 'UsersUnlockDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersUpdateAccess = {
  __typename?: 'UsersUpdateAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type UsersUpdateDocAccess = {
  __typename?: 'UsersUpdateDocAccess';
  permission: Scalars['Boolean']['output'];
  where: Maybe<Scalars['JSONObject']['output']>;
};

export type AllMedia = {
  __typename?: 'allMedia';
  docs: Array<Media>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type BatchesAccess = {
  __typename?: 'batchesAccess';
  create: Maybe<BatchesCreateAccess>;
  delete: Maybe<BatchesDeleteAccess>;
  fields: Maybe<BatchesFields>;
  read: Maybe<BatchesReadAccess>;
  update: Maybe<BatchesUpdateAccess>;
};

export type BatchesDocAccess = {
  __typename?: 'batchesDocAccess';
  create: Maybe<BatchesCreateDocAccess>;
  delete: Maybe<BatchesDeleteDocAccess>;
  fields: Maybe<BatchesDocAccessFields>;
  read: Maybe<BatchesReadDocAccess>;
  update: Maybe<BatchesUpdateDocAccess>;
};

export type CountBatches = {
  __typename?: 'countBatches';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountDocuments = {
  __typename?: 'countDocuments';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountEgos = {
  __typename?: 'countEgos';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountEsminiDats = {
  __typename?: 'countEsminiDats';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountKeyPerformanceIndicators = {
  __typename?: 'countKeyPerformanceIndicators';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountObservations = {
  __typename?: 'countObservations';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountOpenDrives = {
  __typename?: 'countOpenDrives';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountOpenScenarios = {
  __typename?: 'countOpenScenarios';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountPayloadLockedDocuments = {
  __typename?: 'countPayloadLockedDocuments';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountPayloadPreferences = {
  __typename?: 'countPayloadPreferences';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountSamplings = {
  __typename?: 'countSamplings';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountScenarios = {
  __typename?: 'countScenarios';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountSessions = {
  __typename?: 'countSessions';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountTrials = {
  __typename?: 'countTrials';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountUsers = {
  __typename?: 'countUsers';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type CountallMedia = {
  __typename?: 'countallMedia';
  totalDocs: Maybe<Scalars['Int']['output']>;
};

export type DocumentsAccess = {
  __typename?: 'documentsAccess';
  create: Maybe<DocumentsCreateAccess>;
  delete: Maybe<DocumentsDeleteAccess>;
  fields: Maybe<DocumentsFields>;
  read: Maybe<DocumentsReadAccess>;
  update: Maybe<DocumentsUpdateAccess>;
};

export type DocumentsDocAccess = {
  __typename?: 'documentsDocAccess';
  create: Maybe<DocumentsCreateDocAccess>;
  delete: Maybe<DocumentsDeleteDocAccess>;
  fields: Maybe<DocumentsDocAccessFields>;
  read: Maybe<DocumentsReadDocAccess>;
  update: Maybe<DocumentsUpdateDocAccess>;
};

export type EgosAccess = {
  __typename?: 'egosAccess';
  create: Maybe<EgosCreateAccess>;
  delete: Maybe<EgosDeleteAccess>;
  fields: Maybe<EgosFields>;
  read: Maybe<EgosReadAccess>;
  update: Maybe<EgosUpdateAccess>;
};

export type EgosDocAccess = {
  __typename?: 'egosDocAccess';
  create: Maybe<EgosCreateDocAccess>;
  delete: Maybe<EgosDeleteDocAccess>;
  fields: Maybe<EgosDocAccessFields>;
  read: Maybe<EgosReadDocAccess>;
  update: Maybe<EgosUpdateDocAccess>;
};

export type EsminiDatsAccess = {
  __typename?: 'esminiDatsAccess';
  create: Maybe<EsminiDatsCreateAccess>;
  delete: Maybe<EsminiDatsDeleteAccess>;
  fields: Maybe<EsminiDatsFields>;
  read: Maybe<EsminiDatsReadAccess>;
  update: Maybe<EsminiDatsUpdateAccess>;
};

export type EsminiDatsDocAccess = {
  __typename?: 'esminiDatsDocAccess';
  create: Maybe<EsminiDatsCreateDocAccess>;
  delete: Maybe<EsminiDatsDeleteDocAccess>;
  fields: Maybe<EsminiDatsDocAccessFields>;
  read: Maybe<EsminiDatsReadDocAccess>;
  update: Maybe<EsminiDatsUpdateDocAccess>;
};

export type KeyPerformanceIndicatorsAccess = {
  __typename?: 'keyPerformanceIndicatorsAccess';
  create: Maybe<KeyPerformanceIndicatorsCreateAccess>;
  delete: Maybe<KeyPerformanceIndicatorsDeleteAccess>;
  fields: Maybe<KeyPerformanceIndicatorsFields>;
  read: Maybe<KeyPerformanceIndicatorsReadAccess>;
  update: Maybe<KeyPerformanceIndicatorsUpdateAccess>;
};

export type KeyPerformanceIndicatorsDocAccess = {
  __typename?: 'keyPerformanceIndicatorsDocAccess';
  create: Maybe<KeyPerformanceIndicatorsCreateDocAccess>;
  delete: Maybe<KeyPerformanceIndicatorsDeleteDocAccess>;
  fields: Maybe<KeyPerformanceIndicatorsDocAccessFields>;
  read: Maybe<KeyPerformanceIndicatorsReadDocAccess>;
  update: Maybe<KeyPerformanceIndicatorsUpdateDocAccess>;
};

export type MediaAccess = {
  __typename?: 'mediaAccess';
  create: Maybe<MediaCreateAccess>;
  delete: Maybe<MediaDeleteAccess>;
  fields: Maybe<MediaFields>;
  read: Maybe<MediaReadAccess>;
  update: Maybe<MediaUpdateAccess>;
};

export type MediaDocAccess = {
  __typename?: 'mediaDocAccess';
  create: Maybe<MediaCreateDocAccess>;
  delete: Maybe<MediaDeleteDocAccess>;
  fields: Maybe<MediaDocAccessFields>;
  read: Maybe<MediaReadDocAccess>;
  update: Maybe<MediaUpdateDocAccess>;
};

export type MutationBatchInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  egos: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
  images: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
  requiredNumberOfTrials: Scalars['Float']['input'];
  sampling: InputMaybe<Scalars['Int']['input']>;
  savedTrajectoryAnalysis: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
  scenario: InputMaybe<Scalars['Int']['input']>;
  session: InputMaybe<Scalars['Int']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationBatchUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  egos: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
  images: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
  requiredNumberOfTrials: InputMaybe<Scalars['Float']['input']>;
  sampling: InputMaybe<Scalars['Int']['input']>;
  savedTrajectoryAnalysis: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
  scenario: InputMaybe<Scalars['Int']['input']>;
  session: InputMaybe<Scalars['Int']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationDocumentInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationDocumentUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationEgoInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  name: Scalars['String']['input'];
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationEgoUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationEsminiDatInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationEsminiDatUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationKeyPerformanceIndicatorInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  description: InputMaybe<Scalars['String']['input']>;
  name: Scalars['String']['input'];
  rule: KeyPerformanceIndicator_Rule_MutationInput;
  unit: Scalars['String']['input'];
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationKeyPerformanceIndicatorUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  description: InputMaybe<Scalars['String']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  rule: InputMaybe<KeyPerformanceIndicatorUpdate_Rule_MutationInput>;
  unit: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationMediaInput = {
  alt: Scalars['String']['input'];
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  sizes: InputMaybe<MutationMedia_SizesInput>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationMediaUpdateInput = {
  alt: InputMaybe<Scalars['String']['input']>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  sizes: InputMaybe<MutationMediaUpdate_SizesInput>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationMediaUpdate_SizesInput = {
  card: InputMaybe<MutationMediaUpdate_Sizes_CardInput>;
  tablet: InputMaybe<MutationMediaUpdate_Sizes_TabletInput>;
  thumbnail: InputMaybe<MutationMediaUpdate_Sizes_ThumbnailInput>;
};

export type MutationMediaUpdate_Sizes_CardInput = {
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationMediaUpdate_Sizes_TabletInput = {
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationMediaUpdate_Sizes_ThumbnailInput = {
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationMedia_SizesInput = {
  card: InputMaybe<MutationMedia_Sizes_CardInput>;
  tablet: InputMaybe<MutationMedia_Sizes_TabletInput>;
  thumbnail: InputMaybe<MutationMedia_Sizes_ThumbnailInput>;
};

export type MutationMedia_Sizes_CardInput = {
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationMedia_Sizes_TabletInput = {
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationMedia_Sizes_ThumbnailInput = {
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationObservationInput = {
  agents: InputMaybe<Array<InputMaybe<MutationObservation_AgentsInput>>>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  ego: InputMaybe<Scalars['Int']['input']>;
  egoAcceleration: InputMaybe<Scalars['Float']['input']>;
  egoCurvature: InputMaybe<Scalars['Float']['input']>;
  egoJunctionId: InputMaybe<Scalars['Float']['input']>;
  egoLaneHeading: InputMaybe<Scalars['Float']['input']>;
  egoLaneId: InputMaybe<Scalars['Float']['input']>;
  egoLaneOffset: InputMaybe<Scalars['Float']['input']>;
  egoRoadId: InputMaybe<Scalars['Float']['input']>;
  egoS: InputMaybe<Scalars['Float']['input']>;
  egoSpeed: InputMaybe<Scalars['Float']['input']>;
  egoSpeedCmd: InputMaybe<Scalars['Float']['input']>;
  egoSteerCmd: InputMaybe<Scalars['Float']['input']>;
  egoT: InputMaybe<Scalars['Float']['input']>;
  egoX: InputMaybe<Scalars['Float']['input']>;
  egoY: InputMaybe<Scalars['Float']['input']>;
  egoYaw: InputMaybe<Scalars['Float']['input']>;
  egoYawRate: InputMaybe<Scalars['Float']['input']>;
  esminiSeconds: InputMaybe<Scalars['Float']['input']>;
  time: InputMaybe<Scalars['Float']['input']>;
  trial: InputMaybe<Scalars['Int']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationObservationUpdateInput = {
  agents: InputMaybe<Array<InputMaybe<MutationObservationUpdate_AgentsInput>>>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  ego: InputMaybe<Scalars['Int']['input']>;
  egoAcceleration: InputMaybe<Scalars['Float']['input']>;
  egoCurvature: InputMaybe<Scalars['Float']['input']>;
  egoJunctionId: InputMaybe<Scalars['Float']['input']>;
  egoLaneHeading: InputMaybe<Scalars['Float']['input']>;
  egoLaneId: InputMaybe<Scalars['Float']['input']>;
  egoLaneOffset: InputMaybe<Scalars['Float']['input']>;
  egoRoadId: InputMaybe<Scalars['Float']['input']>;
  egoS: InputMaybe<Scalars['Float']['input']>;
  egoSpeed: InputMaybe<Scalars['Float']['input']>;
  egoSpeedCmd: InputMaybe<Scalars['Float']['input']>;
  egoSteerCmd: InputMaybe<Scalars['Float']['input']>;
  egoT: InputMaybe<Scalars['Float']['input']>;
  egoX: InputMaybe<Scalars['Float']['input']>;
  egoY: InputMaybe<Scalars['Float']['input']>;
  egoYaw: InputMaybe<Scalars['Float']['input']>;
  egoYawRate: InputMaybe<Scalars['Float']['input']>;
  esminiSeconds: InputMaybe<Scalars['Float']['input']>;
  time: InputMaybe<Scalars['Float']['input']>;
  trial: InputMaybe<Scalars['Int']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationObservationUpdate_AgentsInput = {
  accReq: InputMaybe<Scalars['Float']['input']>;
  acceleration: InputMaybe<Scalars['Float']['input']>;
  collisionRisk: InputMaybe<Scalars['Float']['input']>;
  curvature: InputMaybe<Scalars['Float']['input']>;
  dce: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  isRssSafe: InputMaybe<Scalars['Float']['input']>;
  junctionId: InputMaybe<Scalars['Float']['input']>;
  laneHeading: InputMaybe<Scalars['Float']['input']>;
  laneId: InputMaybe<Scalars['Float']['input']>;
  laneOffset: InputMaybe<Scalars['Float']['input']>;
  length: InputMaybe<Scalars['Float']['input']>;
  localX: InputMaybe<Scalars['Float']['input']>;
  localY: InputMaybe<Scalars['Float']['input']>;
  localYaw: InputMaybe<Scalars['Float']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  pret: InputMaybe<Scalars['Float']['input']>;
  relativeAccelerationX: InputMaybe<Scalars['Float']['input']>;
  relativeAccelerationY: InputMaybe<Scalars['Float']['input']>;
  relativeDistance: InputMaybe<Scalars['Float']['input']>;
  relativeVelocityX: InputMaybe<Scalars['Float']['input']>;
  relativeVelocityY: InputMaybe<Scalars['Float']['input']>;
  relativeYawRate: InputMaybe<Scalars['Float']['input']>;
  roadId: InputMaybe<Scalars['Float']['input']>;
  rssRatio: InputMaybe<Scalars['Float']['input']>;
  s: InputMaybe<Scalars['Float']['input']>;
  speed: InputMaybe<Scalars['Float']['input']>;
  spret: InputMaybe<Scalars['Float']['input']>;
  t: InputMaybe<Scalars['Float']['input']>;
  ttc: InputMaybe<Scalars['Float']['input']>;
  ttce: InputMaybe<Scalars['Float']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
  x: InputMaybe<Scalars['Float']['input']>;
  y: InputMaybe<Scalars['Float']['input']>;
  yaw: InputMaybe<Scalars['Float']['input']>;
  yawRate: InputMaybe<Scalars['Float']['input']>;
};

export type MutationObservation_AgentsInput = {
  accReq: InputMaybe<Scalars['Float']['input']>;
  acceleration: InputMaybe<Scalars['Float']['input']>;
  collisionRisk: InputMaybe<Scalars['Float']['input']>;
  curvature: InputMaybe<Scalars['Float']['input']>;
  dce: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  isRssSafe: InputMaybe<Scalars['Float']['input']>;
  junctionId: InputMaybe<Scalars['Float']['input']>;
  laneHeading: InputMaybe<Scalars['Float']['input']>;
  laneId: InputMaybe<Scalars['Float']['input']>;
  laneOffset: InputMaybe<Scalars['Float']['input']>;
  length: InputMaybe<Scalars['Float']['input']>;
  localX: InputMaybe<Scalars['Float']['input']>;
  localY: InputMaybe<Scalars['Float']['input']>;
  localYaw: InputMaybe<Scalars['Float']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  pret: InputMaybe<Scalars['Float']['input']>;
  relativeAccelerationX: InputMaybe<Scalars['Float']['input']>;
  relativeAccelerationY: InputMaybe<Scalars['Float']['input']>;
  relativeDistance: InputMaybe<Scalars['Float']['input']>;
  relativeVelocityX: InputMaybe<Scalars['Float']['input']>;
  relativeVelocityY: InputMaybe<Scalars['Float']['input']>;
  relativeYawRate: InputMaybe<Scalars['Float']['input']>;
  roadId: InputMaybe<Scalars['Float']['input']>;
  rssRatio: InputMaybe<Scalars['Float']['input']>;
  s: InputMaybe<Scalars['Float']['input']>;
  speed: InputMaybe<Scalars['Float']['input']>;
  spret: InputMaybe<Scalars['Float']['input']>;
  t: InputMaybe<Scalars['Float']['input']>;
  ttc: InputMaybe<Scalars['Float']['input']>;
  ttce: InputMaybe<Scalars['Float']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
  x: InputMaybe<Scalars['Float']['input']>;
  y: InputMaybe<Scalars['Float']['input']>;
  yaw: InputMaybe<Scalars['Float']['input']>;
  yawRate: InputMaybe<Scalars['Float']['input']>;
};

export type MutationOpenDriveInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationOpenDriveUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationOpenScenarioInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationOpenScenarioUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  filename: InputMaybe<Scalars['String']['input']>;
  filesize: InputMaybe<Scalars['Float']['input']>;
  focalX: InputMaybe<Scalars['Float']['input']>;
  focalY: InputMaybe<Scalars['Float']['input']>;
  height: InputMaybe<Scalars['Float']['input']>;
  mimeType: InputMaybe<Scalars['String']['input']>;
  thumbnailURL: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  url: InputMaybe<Scalars['String']['input']>;
  width: InputMaybe<Scalars['Float']['input']>;
};

export type MutationPayloadLockedDocumentInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  document: InputMaybe<PayloadLockedDocument_DocumentRelationshipInput>;
  globalSlug: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  user: InputMaybe<PayloadLockedDocument_UserRelationshipInput>;
};

export type MutationPayloadLockedDocumentUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  document: InputMaybe<PayloadLockedDocumentUpdate_DocumentRelationshipInput>;
  globalSlug: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  user: InputMaybe<PayloadLockedDocumentUpdate_UserRelationshipInput>;
};

export type MutationPayloadPreferenceInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  key: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  user: InputMaybe<PayloadPreference_UserRelationshipInput>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export type MutationPayloadPreferenceUpdateInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  key: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  user: InputMaybe<PayloadPreferenceUpdate_UserRelationshipInput>;
  value: InputMaybe<Scalars['JSON']['input']>;
};

export type MutationSamplingInput = {
  _status: InputMaybe<Sampling__Status_MutationInput>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  steps: InputMaybe<Array<InputMaybe<MutationSampling_StepsInput>>>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationSamplingUpdateInput = {
  _status: InputMaybe<SamplingUpdate__Status_MutationInput>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  steps: InputMaybe<Array<InputMaybe<MutationSamplingUpdate_StepsInput>>>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationSamplingUpdate_StepsInput = {
  acquisitionExplorationFactor: InputMaybe<Scalars['Float']['input']>;
  acquisitionSampleSize: InputMaybe<Scalars['Float']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  maxSurrogateTrainingSampleSize: InputMaybe<Scalars['Float']['input']>;
  method: InputMaybe<SamplingUpdate_Steps_Method_MutationInput>;
  parallelCounts: InputMaybe<Scalars['Float']['input']>;
  sampleSize: Scalars['Float']['input'];
};

export type MutationSampling_StepsInput = {
  acquisitionExplorationFactor: InputMaybe<Scalars['Float']['input']>;
  acquisitionSampleSize: InputMaybe<Scalars['Float']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  maxSurrogateTrainingSampleSize: InputMaybe<Scalars['Float']['input']>;
  method: InputMaybe<Sampling_Steps_Method_MutationInput>;
  parallelCounts: InputMaybe<Scalars['Float']['input']>;
  sampleSize: Scalars['Float']['input'];
};

export type MutationScenarioInput = {
  _status: InputMaybe<Scenario__Status_MutationInput>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  description: Scalars['String']['input'];
  egoTargetSpeed: InputMaybe<Scalars['Float']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  observationRecordingAgents: InputMaybe<Array<InputMaybe<MutationScenario_ObservationRecordingAgentsInput>>>;
  openDrive: InputMaybe<Scalars['Int']['input']>;
  openScenarioField: InputMaybe<MutationScenario_OpenScenarioFieldInput>;
  parameterConstraints: InputMaybe<Array<InputMaybe<MutationScenario_ParameterConstraintsInput>>>;
  parameters: InputMaybe<Array<MutationScenario_ParametersInput>>;
  schematic: InputMaybe<Scalars['Int']['input']>;
  startObservationSamplingConditions: InputMaybe<Array<InputMaybe<MutationScenario_StartObservationSamplingConditionsInput>>>;
  testObjectives: InputMaybe<MutationScenario_TestObjectivesInput>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  validConditions: InputMaybe<Array<InputMaybe<MutationScenario_ValidConditionsInput>>>;
};

export type MutationScenarioUpdateInput = {
  _status: InputMaybe<ScenarioUpdate__Status_MutationInput>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  description: InputMaybe<Scalars['String']['input']>;
  egoTargetSpeed: InputMaybe<Scalars['Float']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  observationRecordingAgents: InputMaybe<Array<InputMaybe<MutationScenarioUpdate_ObservationRecordingAgentsInput>>>;
  openDrive: InputMaybe<Scalars['Int']['input']>;
  openScenarioField: InputMaybe<MutationScenarioUpdate_OpenScenarioFieldInput>;
  parameterConstraints: InputMaybe<Array<InputMaybe<MutationScenarioUpdate_ParameterConstraintsInput>>>;
  parameters: InputMaybe<Array<InputMaybe<MutationScenarioUpdate_ParametersInput>>>;
  schematic: InputMaybe<Scalars['Int']['input']>;
  startObservationSamplingConditions: InputMaybe<Array<InputMaybe<MutationScenarioUpdate_StartObservationSamplingConditionsInput>>>;
  testObjectives: InputMaybe<MutationScenarioUpdate_TestObjectivesInput>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
  validConditions: InputMaybe<Array<InputMaybe<MutationScenarioUpdate_ValidConditionsInput>>>;
};

export type MutationScenarioUpdate_ObservationRecordingAgentsInput = {
  id: InputMaybe<Scalars['String']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenarioUpdate_OpenScenarioFieldInput = {
  content: InputMaybe<Scalars['String']['input']>;
  openScenario: InputMaybe<Scalars['Int']['input']>;
  type: InputMaybe<ScenarioUpdate_OpenScenarioField_Type_MutationInput>;
};

export type MutationScenarioUpdate_ParameterConstraintsInput = {
  expression: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenarioUpdate_ParametersInput = {
  description: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  max: InputMaybe<Scalars['Float']['input']>;
  min: InputMaybe<Scalars['Float']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  unit: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenarioUpdate_StartObservationSamplingConditionsInput = {
  condition: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenarioUpdate_TestObjectivesInput = {
  criticalityMetrics: InputMaybe<Array<InputMaybe<MutationScenarioUpdate_TestObjectives_CriticalityMetricsInput>>>;
};

export type MutationScenarioUpdate_TestObjectives_CriticalityMetricsInput = {
  description: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  keyPerformanceIndicator: InputMaybe<Scalars['Int']['input']>;
  threshold: Scalars['Float']['input'];
};

export type MutationScenarioUpdate_ValidConditionsInput = {
  condition: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenario_ObservationRecordingAgentsInput = {
  id: InputMaybe<Scalars['String']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenario_OpenScenarioFieldInput = {
  content: InputMaybe<Scalars['String']['input']>;
  openScenario: InputMaybe<Scalars['Int']['input']>;
  type: InputMaybe<Scenario_OpenScenarioField_Type_MutationInput>;
};

export type MutationScenario_ParameterConstraintsInput = {
  expression: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenario_ParametersInput = {
  description: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  max: InputMaybe<Scalars['Float']['input']>;
  min: InputMaybe<Scalars['Float']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  unit: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenario_StartObservationSamplingConditionsInput = {
  condition: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
};

export type MutationScenario_TestObjectivesInput = {
  criticalityMetrics: InputMaybe<Array<InputMaybe<MutationScenario_TestObjectives_CriticalityMetricsInput>>>;
};

export type MutationScenario_TestObjectives_CriticalityMetricsInput = {
  description: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  keyPerformanceIndicator: InputMaybe<Scalars['Int']['input']>;
  threshold: Scalars['Float']['input'];
};

export type MutationScenario_ValidConditionsInput = {
  condition: InputMaybe<Scalars['String']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
};

export type MutationSessionInput = {
  _status: InputMaybe<Session__Status_MutationInput>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationSessionUpdateInput = {
  _status: InputMaybe<SessionUpdate__Status_MutationInput>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  name: InputMaybe<Scalars['String']['input']>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationTrialInput = {
  batch: InputMaybe<Scalars['Int']['input']>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  ego: InputMaybe<Scalars['Int']['input']>;
  esminiDat: InputMaybe<Scalars['Int']['input']>;
  events: InputMaybe<Array<InputMaybe<MutationTrial_EventsInput>>>;
  parameters: InputMaybe<Array<MutationTrial_ParametersInput>>;
  previewImage: InputMaybe<Scalars['Int']['input']>;
  testObjectives: MutationTrial_TestObjectivesInput;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationTrialUpdateInput = {
  batch: InputMaybe<Scalars['Int']['input']>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  ego: InputMaybe<Scalars['Int']['input']>;
  esminiDat: InputMaybe<Scalars['Int']['input']>;
  events: InputMaybe<Array<InputMaybe<MutationTrialUpdate_EventsInput>>>;
  parameters: InputMaybe<Array<InputMaybe<MutationTrialUpdate_ParametersInput>>>;
  previewImage: InputMaybe<Scalars['Int']['input']>;
  testObjectives: MutationTrialUpdate_TestObjectivesInput;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationTrialUpdate_EventsInput = {
  esminiSeconds: Scalars['Float']['input'];
  id: InputMaybe<Scalars['String']['input']>;
  name: Scalars['String']['input'];
  observationIndex: Scalars['Float']['input'];
  previewImage: InputMaybe<Scalars['Int']['input']>;
  time: Scalars['Float']['input'];
};

export type MutationTrialUpdate_ParametersInput = {
  id: InputMaybe<Scalars['String']['input']>;
  parameterId: Scalars['String']['input'];
  value: Scalars['Float']['input'];
};

export type MutationTrialUpdate_TestObjectivesInput = {
  criticalityMetrics: InputMaybe<Array<MutationTrialUpdate_TestObjectives_CriticalityMetricsInput>>;
  referenceModels: InputMaybe<Array<InputMaybe<MutationTrialUpdate_TestObjectives_ReferenceModelsInput>>>;
};

export type MutationTrialUpdate_TestObjectives_CriticalityMetricsInput = {
  firstFailedObservationIndex: InputMaybe<Scalars['Float']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  keyPerformanceIndicator: InputMaybe<Scalars['Int']['input']>;
  passed: InputMaybe<Scalars['Boolean']['input']>;
  value: InputMaybe<Scalars['Float']['input']>;
  worstObservation: InputMaybe<Scalars['Int']['input']>;
  worstObservationIndex: InputMaybe<Scalars['Float']['input']>;
};

export type MutationTrialUpdate_TestObjectives_ReferenceModelsInput = {
  id: InputMaybe<Scalars['String']['input']>;
  passed: InputMaybe<Scalars['Boolean']['input']>;
  referenceModel: InputMaybe<Scalars['String']['input']>;
};

export type MutationTrial_EventsInput = {
  esminiSeconds: Scalars['Float']['input'];
  id: InputMaybe<Scalars['String']['input']>;
  name: Scalars['String']['input'];
  observationIndex: Scalars['Float']['input'];
  previewImage: InputMaybe<Scalars['Int']['input']>;
  time: Scalars['Float']['input'];
};

export type MutationTrial_ParametersInput = {
  id: InputMaybe<Scalars['String']['input']>;
  parameterId: Scalars['String']['input'];
  value: Scalars['Float']['input'];
};

export type MutationTrial_TestObjectivesInput = {
  criticalityMetrics: InputMaybe<Array<MutationTrial_TestObjectives_CriticalityMetricsInput>>;
  referenceModels: InputMaybe<Array<InputMaybe<MutationTrial_TestObjectives_ReferenceModelsInput>>>;
};

export type MutationTrial_TestObjectives_CriticalityMetricsInput = {
  firstFailedObservationIndex: InputMaybe<Scalars['Float']['input']>;
  id: InputMaybe<Scalars['String']['input']>;
  keyPerformanceIndicator: InputMaybe<Scalars['Int']['input']>;
  passed: InputMaybe<Scalars['Boolean']['input']>;
  value: InputMaybe<Scalars['Float']['input']>;
  worstObservation: InputMaybe<Scalars['Int']['input']>;
  worstObservationIndex: InputMaybe<Scalars['Float']['input']>;
};

export type MutationTrial_TestObjectives_ReferenceModelsInput = {
  id: InputMaybe<Scalars['String']['input']>;
  passed: InputMaybe<Scalars['Boolean']['input']>;
  referenceModel: InputMaybe<Scalars['String']['input']>;
};

export type MutationUserInput = {
  apiKey: InputMaybe<Scalars['String']['input']>;
  apiKeyIndex: InputMaybe<Scalars['String']['input']>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  email: Scalars['String']['input'];
  enableAPIKey: InputMaybe<Scalars['Boolean']['input']>;
  hash: InputMaybe<Scalars['String']['input']>;
  lockUntil: InputMaybe<Scalars['String']['input']>;
  loginAttempts: InputMaybe<Scalars['Float']['input']>;
  password: Scalars['String']['input'];
  resetPasswordExpiration: InputMaybe<Scalars['String']['input']>;
  resetPasswordToken: InputMaybe<Scalars['String']['input']>;
  salt: InputMaybe<Scalars['String']['input']>;
  sessions: InputMaybe<Array<InputMaybe<MutationUser_SessionsInput>>>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationUserUpdateInput = {
  apiKey: InputMaybe<Scalars['String']['input']>;
  apiKeyIndex: InputMaybe<Scalars['String']['input']>;
  createdAt: InputMaybe<Scalars['String']['input']>;
  email: InputMaybe<Scalars['String']['input']>;
  enableAPIKey: InputMaybe<Scalars['Boolean']['input']>;
  hash: InputMaybe<Scalars['String']['input']>;
  lockUntil: InputMaybe<Scalars['String']['input']>;
  loginAttempts: InputMaybe<Scalars['Float']['input']>;
  password: InputMaybe<Scalars['String']['input']>;
  resetPasswordExpiration: InputMaybe<Scalars['String']['input']>;
  resetPasswordToken: InputMaybe<Scalars['String']['input']>;
  salt: InputMaybe<Scalars['String']['input']>;
  sessions: InputMaybe<Array<InputMaybe<MutationUserUpdate_SessionsInput>>>;
  updatedAt: InputMaybe<Scalars['String']['input']>;
};

export type MutationUserUpdate_SessionsInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  expiresAt: Scalars['String']['input'];
  id: Scalars['String']['input'];
};

export type MutationUser_SessionsInput = {
  createdAt: InputMaybe<Scalars['String']['input']>;
  expiresAt: Scalars['String']['input'];
  id: Scalars['String']['input'];
};

export type ObservationsAccess = {
  __typename?: 'observationsAccess';
  create: Maybe<ObservationsCreateAccess>;
  delete: Maybe<ObservationsDeleteAccess>;
  fields: Maybe<ObservationsFields>;
  read: Maybe<ObservationsReadAccess>;
  update: Maybe<ObservationsUpdateAccess>;
};

export type ObservationsDocAccess = {
  __typename?: 'observationsDocAccess';
  create: Maybe<ObservationsCreateDocAccess>;
  delete: Maybe<ObservationsDeleteDocAccess>;
  fields: Maybe<ObservationsDocAccessFields>;
  read: Maybe<ObservationsReadDocAccess>;
  update: Maybe<ObservationsUpdateDocAccess>;
};

export type OpenDrivesAccess = {
  __typename?: 'openDrivesAccess';
  create: Maybe<OpenDrivesCreateAccess>;
  delete: Maybe<OpenDrivesDeleteAccess>;
  fields: Maybe<OpenDrivesFields>;
  read: Maybe<OpenDrivesReadAccess>;
  update: Maybe<OpenDrivesUpdateAccess>;
};

export type OpenDrivesDocAccess = {
  __typename?: 'openDrivesDocAccess';
  create: Maybe<OpenDrivesCreateDocAccess>;
  delete: Maybe<OpenDrivesDeleteDocAccess>;
  fields: Maybe<OpenDrivesDocAccessFields>;
  read: Maybe<OpenDrivesReadDocAccess>;
  update: Maybe<OpenDrivesUpdateDocAccess>;
};

export type OpenScenariosAccess = {
  __typename?: 'openScenariosAccess';
  create: Maybe<OpenScenariosCreateAccess>;
  delete: Maybe<OpenScenariosDeleteAccess>;
  fields: Maybe<OpenScenariosFields>;
  read: Maybe<OpenScenariosReadAccess>;
  update: Maybe<OpenScenariosUpdateAccess>;
};

export type OpenScenariosDocAccess = {
  __typename?: 'openScenariosDocAccess';
  create: Maybe<OpenScenariosCreateDocAccess>;
  delete: Maybe<OpenScenariosDeleteDocAccess>;
  fields: Maybe<OpenScenariosDocAccessFields>;
  read: Maybe<OpenScenariosReadDocAccess>;
  update: Maybe<OpenScenariosUpdateDocAccess>;
};

export type Payload_Locked_DocumentsAccess = {
  __typename?: 'payload_locked_documentsAccess';
  create: Maybe<PayloadLockedDocumentsCreateAccess>;
  delete: Maybe<PayloadLockedDocumentsDeleteAccess>;
  fields: Maybe<PayloadLockedDocumentsFields>;
  read: Maybe<PayloadLockedDocumentsReadAccess>;
  update: Maybe<PayloadLockedDocumentsUpdateAccess>;
};

export type Payload_Locked_DocumentsDocAccess = {
  __typename?: 'payload_locked_documentsDocAccess';
  create: Maybe<PayloadLockedDocumentsCreateDocAccess>;
  delete: Maybe<PayloadLockedDocumentsDeleteDocAccess>;
  fields: Maybe<PayloadLockedDocumentsDocAccessFields>;
  read: Maybe<PayloadLockedDocumentsReadDocAccess>;
  update: Maybe<PayloadLockedDocumentsUpdateDocAccess>;
};

export type Payload_PreferencesAccess = {
  __typename?: 'payload_preferencesAccess';
  create: Maybe<PayloadPreferencesCreateAccess>;
  delete: Maybe<PayloadPreferencesDeleteAccess>;
  fields: Maybe<PayloadPreferencesFields>;
  read: Maybe<PayloadPreferencesReadAccess>;
  update: Maybe<PayloadPreferencesUpdateAccess>;
};

export type Payload_PreferencesDocAccess = {
  __typename?: 'payload_preferencesDocAccess';
  create: Maybe<PayloadPreferencesCreateDocAccess>;
  delete: Maybe<PayloadPreferencesDeleteDocAccess>;
  fields: Maybe<PayloadPreferencesDocAccessFields>;
  read: Maybe<PayloadPreferencesReadDocAccess>;
  update: Maybe<PayloadPreferencesUpdateDocAccess>;
};

export type SamplingsAccess = {
  __typename?: 'samplingsAccess';
  create: Maybe<SamplingsCreateAccess>;
  delete: Maybe<SamplingsDeleteAccess>;
  fields: Maybe<SamplingsFields>;
  read: Maybe<SamplingsReadAccess>;
  readVersions: Maybe<SamplingsReadVersionsAccess>;
  update: Maybe<SamplingsUpdateAccess>;
};

export type SamplingsDocAccess = {
  __typename?: 'samplingsDocAccess';
  create: Maybe<SamplingsCreateDocAccess>;
  delete: Maybe<SamplingsDeleteDocAccess>;
  fields: Maybe<SamplingsDocAccessFields>;
  read: Maybe<SamplingsReadDocAccess>;
  readVersions: Maybe<SamplingsReadVersionsDocAccess>;
  update: Maybe<SamplingsUpdateDocAccess>;
};

export type ScenariosAccess = {
  __typename?: 'scenariosAccess';
  create: Maybe<ScenariosCreateAccess>;
  delete: Maybe<ScenariosDeleteAccess>;
  fields: Maybe<ScenariosFields>;
  read: Maybe<ScenariosReadAccess>;
  readVersions: Maybe<ScenariosReadVersionsAccess>;
  update: Maybe<ScenariosUpdateAccess>;
};

export type ScenariosDocAccess = {
  __typename?: 'scenariosDocAccess';
  create: Maybe<ScenariosCreateDocAccess>;
  delete: Maybe<ScenariosDeleteDocAccess>;
  fields: Maybe<ScenariosDocAccessFields>;
  read: Maybe<ScenariosReadDocAccess>;
  readVersions: Maybe<ScenariosReadVersionsDocAccess>;
  update: Maybe<ScenariosUpdateDocAccess>;
};

export type SessionsAccess = {
  __typename?: 'sessionsAccess';
  create: Maybe<SessionsCreateAccess>;
  delete: Maybe<SessionsDeleteAccess>;
  fields: Maybe<SessionsFields>;
  read: Maybe<SessionsReadAccess>;
  readVersions: Maybe<SessionsReadVersionsAccess>;
  update: Maybe<SessionsUpdateAccess>;
};

export type SessionsDocAccess = {
  __typename?: 'sessionsDocAccess';
  create: Maybe<SessionsCreateDocAccess>;
  delete: Maybe<SessionsDeleteDocAccess>;
  fields: Maybe<SessionsDocAccessFields>;
  read: Maybe<SessionsReadDocAccess>;
  readVersions: Maybe<SessionsReadVersionsDocAccess>;
  update: Maybe<SessionsUpdateDocAccess>;
};

export type TrialsAccess = {
  __typename?: 'trialsAccess';
  create: Maybe<TrialsCreateAccess>;
  delete: Maybe<TrialsDeleteAccess>;
  fields: Maybe<TrialsFields>;
  read: Maybe<TrialsReadAccess>;
  update: Maybe<TrialsUpdateAccess>;
};

export type TrialsDocAccess = {
  __typename?: 'trialsDocAccess';
  create: Maybe<TrialsCreateDocAccess>;
  delete: Maybe<TrialsDeleteDocAccess>;
  fields: Maybe<TrialsDocAccessFields>;
  read: Maybe<TrialsReadDocAccess>;
  update: Maybe<TrialsUpdateDocAccess>;
};

export type UsersAccess = {
  __typename?: 'usersAccess';
  create: Maybe<UsersCreateAccess>;
  delete: Maybe<UsersDeleteAccess>;
  fields: Maybe<UsersFields>;
  read: Maybe<UsersReadAccess>;
  unlock: Maybe<UsersUnlockAccess>;
  update: Maybe<UsersUpdateAccess>;
};

export type UsersDocAccess = {
  __typename?: 'usersDocAccess';
  create: Maybe<UsersCreateDocAccess>;
  delete: Maybe<UsersDeleteDocAccess>;
  fields: Maybe<UsersDocAccessFields>;
  read: Maybe<UsersReadDocAccess>;
  unlock: Maybe<UsersUnlockDocAccess>;
  update: Maybe<UsersUpdateDocAccess>;
};

export type UsersJwt = {
  __typename?: 'usersJWT';
  collection: Scalars['String']['output'];
  email: Scalars['EmailAddress']['output'];
};

export type UsersLoginResult = {
  __typename?: 'usersLoginResult';
  exp: Maybe<Scalars['Int']['output']>;
  token: Maybe<Scalars['String']['output']>;
  user: Maybe<User>;
};

export type UsersMe = {
  __typename?: 'usersMe';
  collection: Maybe<Scalars['String']['output']>;
  exp: Maybe<Scalars['Int']['output']>;
  strategy: Maybe<Scalars['String']['output']>;
  token: Maybe<Scalars['String']['output']>;
  user: Maybe<User>;
};

export type UsersRefreshedUser = {
  __typename?: 'usersRefreshedUser';
  exp: Maybe<Scalars['Int']['output']>;
  refreshedToken: Maybe<Scalars['String']['output']>;
  strategy: Maybe<Scalars['String']['output']>;
  user: Maybe<UsersJwt>;
};

export type UsersResetPassword = {
  __typename?: 'usersResetPassword';
  token: Maybe<Scalars['String']['output']>;
  user: Maybe<User>;
};

export type VersionsSampling_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsSampling_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type VersionsSampling_Latest_Operator = {
  equals: InputMaybe<Scalars['Boolean']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  not_equals: InputMaybe<Scalars['Boolean']['input']>;
};

export type VersionsSampling_Parent_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type VersionsSampling_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export enum VersionsSampling_Version___Status_Input {
  Draft = 'draft',
  Published = 'published'
}

export type VersionsSampling_Version___Status_Operator = {
  all: InputMaybe<Array<InputMaybe<VersionsSampling_Version___Status_Input>>>;
  equals: InputMaybe<VersionsSampling_Version___Status_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<VersionsSampling_Version___Status_Input>>>;
  not_equals: InputMaybe<VersionsSampling_Version___Status_Input>;
  not_in: InputMaybe<Array<InputMaybe<VersionsSampling_Version___Status_Input>>>;
};

export type VersionsSampling_Version__CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsSampling_Version__Steps__AcquisitionExplorationFactor_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsSampling_Version__Steps__AcquisitionSampleSize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsSampling_Version__Steps__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsSampling_Version__Steps__MaxSurrogateTrainingSampleSize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export enum VersionsSampling_Version__Steps__Method_Input {
  Sobol = 'sobol',
  Straddle = 'straddle',
  Uniform = 'uniform'
}

export type VersionsSampling_Version__Steps__Method_Operator = {
  all: InputMaybe<Array<InputMaybe<VersionsSampling_Version__Steps__Method_Input>>>;
  equals: InputMaybe<VersionsSampling_Version__Steps__Method_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<VersionsSampling_Version__Steps__Method_Input>>>;
  not_equals: InputMaybe<VersionsSampling_Version__Steps__Method_Input>;
  not_in: InputMaybe<Array<InputMaybe<VersionsSampling_Version__Steps__Method_Input>>>;
};

export type VersionsSampling_Version__Steps__ParallelCounts_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsSampling_Version__Steps__SampleSize_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsSampling_Version__UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsSampling_Where = {
  AND: InputMaybe<Array<InputMaybe<VersionsSampling_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsSampling_Where_Or>>>;
  createdAt: InputMaybe<VersionsSampling_CreatedAt_Operator>;
  id: InputMaybe<VersionsSampling_Id_Operator>;
  latest: InputMaybe<VersionsSampling_Latest_Operator>;
  parent: InputMaybe<VersionsSampling_Parent_Operator>;
  updatedAt: InputMaybe<VersionsSampling_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsSampling_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsSampling_Version__CreatedAt_Operator>;
  version__steps__acquisitionExplorationFactor: InputMaybe<VersionsSampling_Version__Steps__AcquisitionExplorationFactor_Operator>;
  version__steps__acquisitionSampleSize: InputMaybe<VersionsSampling_Version__Steps__AcquisitionSampleSize_Operator>;
  version__steps__id: InputMaybe<VersionsSampling_Version__Steps__Id_Operator>;
  version__steps__maxSurrogateTrainingSampleSize: InputMaybe<VersionsSampling_Version__Steps__MaxSurrogateTrainingSampleSize_Operator>;
  version__steps__method: InputMaybe<VersionsSampling_Version__Steps__Method_Operator>;
  version__steps__parallelCounts: InputMaybe<VersionsSampling_Version__Steps__ParallelCounts_Operator>;
  version__steps__sampleSize: InputMaybe<VersionsSampling_Version__Steps__SampleSize_Operator>;
  version__updatedAt: InputMaybe<VersionsSampling_Version__UpdatedAt_Operator>;
};

export type VersionsSampling_Where_And = {
  AND: InputMaybe<Array<InputMaybe<VersionsSampling_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsSampling_Where_Or>>>;
  createdAt: InputMaybe<VersionsSampling_CreatedAt_Operator>;
  id: InputMaybe<VersionsSampling_Id_Operator>;
  latest: InputMaybe<VersionsSampling_Latest_Operator>;
  parent: InputMaybe<VersionsSampling_Parent_Operator>;
  updatedAt: InputMaybe<VersionsSampling_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsSampling_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsSampling_Version__CreatedAt_Operator>;
  version__steps__acquisitionExplorationFactor: InputMaybe<VersionsSampling_Version__Steps__AcquisitionExplorationFactor_Operator>;
  version__steps__acquisitionSampleSize: InputMaybe<VersionsSampling_Version__Steps__AcquisitionSampleSize_Operator>;
  version__steps__id: InputMaybe<VersionsSampling_Version__Steps__Id_Operator>;
  version__steps__maxSurrogateTrainingSampleSize: InputMaybe<VersionsSampling_Version__Steps__MaxSurrogateTrainingSampleSize_Operator>;
  version__steps__method: InputMaybe<VersionsSampling_Version__Steps__Method_Operator>;
  version__steps__parallelCounts: InputMaybe<VersionsSampling_Version__Steps__ParallelCounts_Operator>;
  version__steps__sampleSize: InputMaybe<VersionsSampling_Version__Steps__SampleSize_Operator>;
  version__updatedAt: InputMaybe<VersionsSampling_Version__UpdatedAt_Operator>;
};

export type VersionsSampling_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<VersionsSampling_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsSampling_Where_Or>>>;
  createdAt: InputMaybe<VersionsSampling_CreatedAt_Operator>;
  id: InputMaybe<VersionsSampling_Id_Operator>;
  latest: InputMaybe<VersionsSampling_Latest_Operator>;
  parent: InputMaybe<VersionsSampling_Parent_Operator>;
  updatedAt: InputMaybe<VersionsSampling_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsSampling_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsSampling_Version__CreatedAt_Operator>;
  version__steps__acquisitionExplorationFactor: InputMaybe<VersionsSampling_Version__Steps__AcquisitionExplorationFactor_Operator>;
  version__steps__acquisitionSampleSize: InputMaybe<VersionsSampling_Version__Steps__AcquisitionSampleSize_Operator>;
  version__steps__id: InputMaybe<VersionsSampling_Version__Steps__Id_Operator>;
  version__steps__maxSurrogateTrainingSampleSize: InputMaybe<VersionsSampling_Version__Steps__MaxSurrogateTrainingSampleSize_Operator>;
  version__steps__method: InputMaybe<VersionsSampling_Version__Steps__Method_Operator>;
  version__steps__parallelCounts: InputMaybe<VersionsSampling_Version__Steps__ParallelCounts_Operator>;
  version__steps__sampleSize: InputMaybe<VersionsSampling_Version__Steps__SampleSize_Operator>;
  version__updatedAt: InputMaybe<VersionsSampling_Version__UpdatedAt_Operator>;
};

export type VersionsSamplings = {
  __typename?: 'versionsSamplings';
  docs: Array<SamplingVersion>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type VersionsScenario_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsScenario_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type VersionsScenario_Latest_Operator = {
  equals: InputMaybe<Scalars['Boolean']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  not_equals: InputMaybe<Scalars['Boolean']['input']>;
};

export type VersionsScenario_Parent_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type VersionsScenario_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export enum VersionsScenario_Version___Status_Input {
  Draft = 'draft',
  Published = 'published'
}

export type VersionsScenario_Version___Status_Operator = {
  all: InputMaybe<Array<InputMaybe<VersionsScenario_Version___Status_Input>>>;
  equals: InputMaybe<VersionsScenario_Version___Status_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<VersionsScenario_Version___Status_Input>>>;
  not_equals: InputMaybe<VersionsScenario_Version___Status_Input>;
  not_in: InputMaybe<Array<InputMaybe<VersionsScenario_Version___Status_Input>>>;
};

export type VersionsScenario_Version__CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsScenario_Version__Description_Operator = {
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
};

export type VersionsScenario_Version__EgoTargetSpeed_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsScenario_Version__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__ObservationRecordingAgents__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__ObservationRecordingAgents__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__OpenDrive_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type VersionsScenario_Version__OpenScenarioField__Content_Operator = {
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
};

export type VersionsScenario_Version__OpenScenarioField__OpenScenario_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export enum VersionsScenario_Version__OpenScenarioField__Type_Input {
  File = 'File',
  String = 'String'
}

export type VersionsScenario_Version__OpenScenarioField__Type_Operator = {
  all: InputMaybe<Array<InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Input>>>;
  equals: InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Input>>>;
  not_equals: InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Input>;
  not_in: InputMaybe<Array<InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Input>>>;
};

export type VersionsScenario_Version__ParameterConstraints__Expression_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__ParameterConstraints__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__Parameters__Description_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__Parameters__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__Parameters__Max_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsScenario_Version__Parameters__Min_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsScenario_Version__Parameters__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__Parameters__Unit_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__Schematic_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type VersionsScenario_Version__StartObservationSamplingConditions__Condition_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__StartObservationSamplingConditions__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__TestObjectives__CriticalityMetrics__Description_Operator = {
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
};

export type VersionsScenario_Version__TestObjectives__CriticalityMetrics__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type VersionsScenario_Version__TestObjectives__CriticalityMetrics__Threshold_Operator = {
  equals: InputMaybe<Scalars['Float']['input']>;
  greater_than: InputMaybe<Scalars['Float']['input']>;
  greater_than_equal: InputMaybe<Scalars['Float']['input']>;
  less_than: InputMaybe<Scalars['Float']['input']>;
  less_than_equal: InputMaybe<Scalars['Float']['input']>;
  not_equals: InputMaybe<Scalars['Float']['input']>;
};

export type VersionsScenario_Version__UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsScenario_Version__ValidConditions__Condition_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Version__ValidConditions__Id_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsScenario_Where = {
  AND: InputMaybe<Array<InputMaybe<VersionsScenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsScenario_Where_Or>>>;
  createdAt: InputMaybe<VersionsScenario_CreatedAt_Operator>;
  id: InputMaybe<VersionsScenario_Id_Operator>;
  latest: InputMaybe<VersionsScenario_Latest_Operator>;
  parent: InputMaybe<VersionsScenario_Parent_Operator>;
  updatedAt: InputMaybe<VersionsScenario_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsScenario_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsScenario_Version__CreatedAt_Operator>;
  version__description: InputMaybe<VersionsScenario_Version__Description_Operator>;
  version__egoTargetSpeed: InputMaybe<VersionsScenario_Version__EgoTargetSpeed_Operator>;
  version__name: InputMaybe<VersionsScenario_Version__Name_Operator>;
  version__observationRecordingAgents__id: InputMaybe<VersionsScenario_Version__ObservationRecordingAgents__Id_Operator>;
  version__observationRecordingAgents__name: InputMaybe<VersionsScenario_Version__ObservationRecordingAgents__Name_Operator>;
  version__openDrive: InputMaybe<VersionsScenario_Version__OpenDrive_Operator>;
  version__openScenarioField__content: InputMaybe<VersionsScenario_Version__OpenScenarioField__Content_Operator>;
  version__openScenarioField__openScenario: InputMaybe<VersionsScenario_Version__OpenScenarioField__OpenScenario_Operator>;
  version__openScenarioField__type: InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Operator>;
  version__parameterConstraints__expression: InputMaybe<VersionsScenario_Version__ParameterConstraints__Expression_Operator>;
  version__parameterConstraints__id: InputMaybe<VersionsScenario_Version__ParameterConstraints__Id_Operator>;
  version__parameters__description: InputMaybe<VersionsScenario_Version__Parameters__Description_Operator>;
  version__parameters__id: InputMaybe<VersionsScenario_Version__Parameters__Id_Operator>;
  version__parameters__max: InputMaybe<VersionsScenario_Version__Parameters__Max_Operator>;
  version__parameters__min: InputMaybe<VersionsScenario_Version__Parameters__Min_Operator>;
  version__parameters__name: InputMaybe<VersionsScenario_Version__Parameters__Name_Operator>;
  version__parameters__unit: InputMaybe<VersionsScenario_Version__Parameters__Unit_Operator>;
  version__schematic: InputMaybe<VersionsScenario_Version__Schematic_Operator>;
  version__startObservationSamplingConditions__condition: InputMaybe<VersionsScenario_Version__StartObservationSamplingConditions__Condition_Operator>;
  version__startObservationSamplingConditions__id: InputMaybe<VersionsScenario_Version__StartObservationSamplingConditions__Id_Operator>;
  version__testObjectives__criticalityMetrics__description: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Description_Operator>;
  version__testObjectives__criticalityMetrics__id: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Id_Operator>;
  version__testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  version__testObjectives__criticalityMetrics__threshold: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Threshold_Operator>;
  version__updatedAt: InputMaybe<VersionsScenario_Version__UpdatedAt_Operator>;
  version__validConditions__condition: InputMaybe<VersionsScenario_Version__ValidConditions__Condition_Operator>;
  version__validConditions__id: InputMaybe<VersionsScenario_Version__ValidConditions__Id_Operator>;
};

export type VersionsScenario_Where_And = {
  AND: InputMaybe<Array<InputMaybe<VersionsScenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsScenario_Where_Or>>>;
  createdAt: InputMaybe<VersionsScenario_CreatedAt_Operator>;
  id: InputMaybe<VersionsScenario_Id_Operator>;
  latest: InputMaybe<VersionsScenario_Latest_Operator>;
  parent: InputMaybe<VersionsScenario_Parent_Operator>;
  updatedAt: InputMaybe<VersionsScenario_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsScenario_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsScenario_Version__CreatedAt_Operator>;
  version__description: InputMaybe<VersionsScenario_Version__Description_Operator>;
  version__egoTargetSpeed: InputMaybe<VersionsScenario_Version__EgoTargetSpeed_Operator>;
  version__name: InputMaybe<VersionsScenario_Version__Name_Operator>;
  version__observationRecordingAgents__id: InputMaybe<VersionsScenario_Version__ObservationRecordingAgents__Id_Operator>;
  version__observationRecordingAgents__name: InputMaybe<VersionsScenario_Version__ObservationRecordingAgents__Name_Operator>;
  version__openDrive: InputMaybe<VersionsScenario_Version__OpenDrive_Operator>;
  version__openScenarioField__content: InputMaybe<VersionsScenario_Version__OpenScenarioField__Content_Operator>;
  version__openScenarioField__openScenario: InputMaybe<VersionsScenario_Version__OpenScenarioField__OpenScenario_Operator>;
  version__openScenarioField__type: InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Operator>;
  version__parameterConstraints__expression: InputMaybe<VersionsScenario_Version__ParameterConstraints__Expression_Operator>;
  version__parameterConstraints__id: InputMaybe<VersionsScenario_Version__ParameterConstraints__Id_Operator>;
  version__parameters__description: InputMaybe<VersionsScenario_Version__Parameters__Description_Operator>;
  version__parameters__id: InputMaybe<VersionsScenario_Version__Parameters__Id_Operator>;
  version__parameters__max: InputMaybe<VersionsScenario_Version__Parameters__Max_Operator>;
  version__parameters__min: InputMaybe<VersionsScenario_Version__Parameters__Min_Operator>;
  version__parameters__name: InputMaybe<VersionsScenario_Version__Parameters__Name_Operator>;
  version__parameters__unit: InputMaybe<VersionsScenario_Version__Parameters__Unit_Operator>;
  version__schematic: InputMaybe<VersionsScenario_Version__Schematic_Operator>;
  version__startObservationSamplingConditions__condition: InputMaybe<VersionsScenario_Version__StartObservationSamplingConditions__Condition_Operator>;
  version__startObservationSamplingConditions__id: InputMaybe<VersionsScenario_Version__StartObservationSamplingConditions__Id_Operator>;
  version__testObjectives__criticalityMetrics__description: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Description_Operator>;
  version__testObjectives__criticalityMetrics__id: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Id_Operator>;
  version__testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  version__testObjectives__criticalityMetrics__threshold: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Threshold_Operator>;
  version__updatedAt: InputMaybe<VersionsScenario_Version__UpdatedAt_Operator>;
  version__validConditions__condition: InputMaybe<VersionsScenario_Version__ValidConditions__Condition_Operator>;
  version__validConditions__id: InputMaybe<VersionsScenario_Version__ValidConditions__Id_Operator>;
};

export type VersionsScenario_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<VersionsScenario_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsScenario_Where_Or>>>;
  createdAt: InputMaybe<VersionsScenario_CreatedAt_Operator>;
  id: InputMaybe<VersionsScenario_Id_Operator>;
  latest: InputMaybe<VersionsScenario_Latest_Operator>;
  parent: InputMaybe<VersionsScenario_Parent_Operator>;
  updatedAt: InputMaybe<VersionsScenario_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsScenario_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsScenario_Version__CreatedAt_Operator>;
  version__description: InputMaybe<VersionsScenario_Version__Description_Operator>;
  version__egoTargetSpeed: InputMaybe<VersionsScenario_Version__EgoTargetSpeed_Operator>;
  version__name: InputMaybe<VersionsScenario_Version__Name_Operator>;
  version__observationRecordingAgents__id: InputMaybe<VersionsScenario_Version__ObservationRecordingAgents__Id_Operator>;
  version__observationRecordingAgents__name: InputMaybe<VersionsScenario_Version__ObservationRecordingAgents__Name_Operator>;
  version__openDrive: InputMaybe<VersionsScenario_Version__OpenDrive_Operator>;
  version__openScenarioField__content: InputMaybe<VersionsScenario_Version__OpenScenarioField__Content_Operator>;
  version__openScenarioField__openScenario: InputMaybe<VersionsScenario_Version__OpenScenarioField__OpenScenario_Operator>;
  version__openScenarioField__type: InputMaybe<VersionsScenario_Version__OpenScenarioField__Type_Operator>;
  version__parameterConstraints__expression: InputMaybe<VersionsScenario_Version__ParameterConstraints__Expression_Operator>;
  version__parameterConstraints__id: InputMaybe<VersionsScenario_Version__ParameterConstraints__Id_Operator>;
  version__parameters__description: InputMaybe<VersionsScenario_Version__Parameters__Description_Operator>;
  version__parameters__id: InputMaybe<VersionsScenario_Version__Parameters__Id_Operator>;
  version__parameters__max: InputMaybe<VersionsScenario_Version__Parameters__Max_Operator>;
  version__parameters__min: InputMaybe<VersionsScenario_Version__Parameters__Min_Operator>;
  version__parameters__name: InputMaybe<VersionsScenario_Version__Parameters__Name_Operator>;
  version__parameters__unit: InputMaybe<VersionsScenario_Version__Parameters__Unit_Operator>;
  version__schematic: InputMaybe<VersionsScenario_Version__Schematic_Operator>;
  version__startObservationSamplingConditions__condition: InputMaybe<VersionsScenario_Version__StartObservationSamplingConditions__Condition_Operator>;
  version__startObservationSamplingConditions__id: InputMaybe<VersionsScenario_Version__StartObservationSamplingConditions__Id_Operator>;
  version__testObjectives__criticalityMetrics__description: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Description_Operator>;
  version__testObjectives__criticalityMetrics__id: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Id_Operator>;
  version__testObjectives__criticalityMetrics__keyPerformanceIndicator: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__KeyPerformanceIndicator_Operator>;
  version__testObjectives__criticalityMetrics__threshold: InputMaybe<VersionsScenario_Version__TestObjectives__CriticalityMetrics__Threshold_Operator>;
  version__updatedAt: InputMaybe<VersionsScenario_Version__UpdatedAt_Operator>;
  version__validConditions__condition: InputMaybe<VersionsScenario_Version__ValidConditions__Condition_Operator>;
  version__validConditions__id: InputMaybe<VersionsScenario_Version__ValidConditions__Id_Operator>;
};

export type VersionsScenarios = {
  __typename?: 'versionsScenarios';
  docs: Array<ScenarioVersion>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type VersionsSession_CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsSession_Id_Operator = {
  equals: InputMaybe<Scalars['Int']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['Int']['input']>;
  greater_than_equal: InputMaybe<Scalars['Int']['input']>;
  less_than: InputMaybe<Scalars['Int']['input']>;
  less_than_equal: InputMaybe<Scalars['Int']['input']>;
  not_equals: InputMaybe<Scalars['Int']['input']>;
};

export type VersionsSession_Latest_Operator = {
  equals: InputMaybe<Scalars['Boolean']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  not_equals: InputMaybe<Scalars['Boolean']['input']>;
};

export type VersionsSession_Parent_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  equals: InputMaybe<Scalars['JSON']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
  not_equals: InputMaybe<Scalars['JSON']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['JSON']['input']>>>;
};

export type VersionsSession_UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export enum VersionsSession_Version___Status_Input {
  Draft = 'draft',
  Published = 'published'
}

export type VersionsSession_Version___Status_Operator = {
  all: InputMaybe<Array<InputMaybe<VersionsSession_Version___Status_Input>>>;
  equals: InputMaybe<VersionsSession_Version___Status_Input>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<VersionsSession_Version___Status_Input>>>;
  not_equals: InputMaybe<VersionsSession_Version___Status_Input>;
  not_in: InputMaybe<Array<InputMaybe<VersionsSession_Version___Status_Input>>>;
};

export type VersionsSession_Version__CreatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsSession_Version__Name_Operator = {
  all: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  contains: InputMaybe<Scalars['String']['input']>;
  equals: InputMaybe<Scalars['String']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  like: InputMaybe<Scalars['String']['input']>;
  not_equals: InputMaybe<Scalars['String']['input']>;
  not_in: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
};

export type VersionsSession_Version__UpdatedAt_Operator = {
  equals: InputMaybe<Scalars['DateTime']['input']>;
  exists: InputMaybe<Scalars['Boolean']['input']>;
  greater_than: InputMaybe<Scalars['DateTime']['input']>;
  greater_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  less_than: InputMaybe<Scalars['DateTime']['input']>;
  less_than_equal: InputMaybe<Scalars['DateTime']['input']>;
  like: InputMaybe<Scalars['DateTime']['input']>;
  not_equals: InputMaybe<Scalars['DateTime']['input']>;
};

export type VersionsSession_Where = {
  AND: InputMaybe<Array<InputMaybe<VersionsSession_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsSession_Where_Or>>>;
  createdAt: InputMaybe<VersionsSession_CreatedAt_Operator>;
  id: InputMaybe<VersionsSession_Id_Operator>;
  latest: InputMaybe<VersionsSession_Latest_Operator>;
  parent: InputMaybe<VersionsSession_Parent_Operator>;
  updatedAt: InputMaybe<VersionsSession_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsSession_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsSession_Version__CreatedAt_Operator>;
  version__name: InputMaybe<VersionsSession_Version__Name_Operator>;
  version__updatedAt: InputMaybe<VersionsSession_Version__UpdatedAt_Operator>;
};

export type VersionsSession_Where_And = {
  AND: InputMaybe<Array<InputMaybe<VersionsSession_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsSession_Where_Or>>>;
  createdAt: InputMaybe<VersionsSession_CreatedAt_Operator>;
  id: InputMaybe<VersionsSession_Id_Operator>;
  latest: InputMaybe<VersionsSession_Latest_Operator>;
  parent: InputMaybe<VersionsSession_Parent_Operator>;
  updatedAt: InputMaybe<VersionsSession_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsSession_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsSession_Version__CreatedAt_Operator>;
  version__name: InputMaybe<VersionsSession_Version__Name_Operator>;
  version__updatedAt: InputMaybe<VersionsSession_Version__UpdatedAt_Operator>;
};

export type VersionsSession_Where_Or = {
  AND: InputMaybe<Array<InputMaybe<VersionsSession_Where_And>>>;
  OR: InputMaybe<Array<InputMaybe<VersionsSession_Where_Or>>>;
  createdAt: InputMaybe<VersionsSession_CreatedAt_Operator>;
  id: InputMaybe<VersionsSession_Id_Operator>;
  latest: InputMaybe<VersionsSession_Latest_Operator>;
  parent: InputMaybe<VersionsSession_Parent_Operator>;
  updatedAt: InputMaybe<VersionsSession_UpdatedAt_Operator>;
  version___status: InputMaybe<VersionsSession_Version___Status_Operator>;
  version__createdAt: InputMaybe<VersionsSession_Version__CreatedAt_Operator>;
  version__name: InputMaybe<VersionsSession_Version__Name_Operator>;
  version__updatedAt: InputMaybe<VersionsSession_Version__UpdatedAt_Operator>;
};

export type VersionsSessions = {
  __typename?: 'versionsSessions';
  docs: Array<SessionVersion>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPrevPage: Scalars['Boolean']['output'];
  limit: Scalars['Int']['output'];
  nextPage: Maybe<Scalars['Int']['output']>;
  offset: Maybe<Scalars['Int']['output']>;
  page: Scalars['Int']['output'];
  pagingCounter: Scalars['Int']['output'];
  prevPage: Maybe<Scalars['Int']['output']>;
  totalDocs: Scalars['Int']['output'];
  totalPages: Scalars['Int']['output'];
};

export type GetBatchesQueryVariables = Exact<{
  limit: InputMaybe<Scalars['Int']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  where: InputMaybe<Batch_Where>;
  page: InputMaybe<Scalars['Int']['input']>;
}>;


export type GetBatchesQuery = { __typename?: 'Query', Batches: { __typename?: 'Batches', page: number, totalPages: number, totalDocs: number, docs: Array<{ __typename?: 'Batch', id: number, session: { __typename?: 'Session', id: number }, egos: Array<{ __typename?: 'Ego', id: number, name: string }> | null, scenario: { __typename?: 'Scenario', id: number, name: string | null, parameters: Array<{ __typename?: 'Scenario_Parameters', id: string | null, max: number | null, min: number | null, name: string | null, unit: string | null }>, testObjectives: { __typename?: 'Scenario_TestObjectives', criticalityMetrics: Array<{ __typename?: 'Scenario_TestObjectives_CriticalityMetrics', id: string | null, threshold: number | null, keyPerformanceIndicator: { __typename?: 'KeyPerformanceIndicator', id: number, name: string, rule: KeyPerformanceIndicator_Rule, unit: string } | null }> | null } | null, schematic: { __typename?: 'Media', sizes: { __typename?: 'Media_Sizes', tablet: { __typename?: 'Media_Sizes_Tablet', url: string | null } | null } | null } | null } }> } | null };

export type GetBatchTrajectoryAnalysisQueryVariables = Exact<{
  id: Scalars['Int']['input'];
}>;


export type GetBatchTrajectoryAnalysisQuery = { __typename?: 'Query', Batch: { __typename?: 'Batch', savedTrajectoryAnalysis: Array<{ __typename?: 'Document', id: number, url: string | null, filename: string | null }> | null } | null };

export type GetBatchImagesQueryVariables = Exact<{
  id: Scalars['Int']['input'];
}>;


export type GetBatchImagesQuery = { __typename?: 'Query', Batch: { __typename?: 'Batch', id: number, images: Array<{ __typename?: 'Document', id: number, url: string | null, filename: string | null }> | null } | null };

export type GetBatchQueryVariables = Exact<{
  id: Scalars['Int']['input'];
}>;


export type GetBatchQuery = { __typename?: 'Query', Batch: { __typename?: 'Batch', id: number, egos: Array<{ __typename?: 'Ego', id: number, name: string }> | null, scenario: { __typename?: 'Scenario', id: number, name: string | null, parameters: Array<{ __typename?: 'Scenario_Parameters', id: string | null, max: number | null, min: number | null, name: string | null, unit: string | null }>, testObjectives: { __typename?: 'Scenario_TestObjectives', criticalityMetrics: Array<{ __typename?: 'Scenario_TestObjectives_CriticalityMetrics', id: string | null, threshold: number | null, keyPerformanceIndicator: { __typename?: 'KeyPerformanceIndicator', id: number, name: string, rule: KeyPerformanceIndicator_Rule, unit: string } | null }> | null } | null } } | null };

export type GetBatchInfoQueryVariables = Exact<{
  id: Scalars['Int']['input'];
}>;


export type GetBatchInfoQuery = { __typename?: 'Query', Batch: { __typename?: 'Batch', id: number, scenario: { __typename?: 'Scenario', parameters: Array<{ __typename?: 'Scenario_Parameters', id: string | null, name: string | null, min: number | null, max: number | null, unit: string | null }>, testObjectives: { __typename?: 'Scenario_TestObjectives', criticalityMetrics: Array<{ __typename?: 'Scenario_TestObjectives_CriticalityMetrics', id: string | null, threshold: number | null, keyPerformanceIndicator: { __typename?: 'KeyPerformanceIndicator', id: number, name: string, rule: KeyPerformanceIndicator_Rule, unit: string } | null }> | null } | null } } | null };

export type GetTrialsQueryVariables = Exact<{
  limit: InputMaybe<Scalars['Int']['input']>;
  sort: InputMaybe<Scalars['String']['input']>;
  where: InputMaybe<Trial_Where>;
  page: InputMaybe<Scalars['Int']['input']>;
}>;


export type GetTrialsQuery = { __typename?: 'Query', Trials: { __typename?: 'Trials', docs: Array<{ __typename?: 'Trial', id: number, ego: { __typename?: 'Ego', id: number, name: string }, parameters: Array<{ __typename?: 'Trial_Parameters', parameterId: string | null, value: number | null }>, testObjectives: { __typename?: 'Trial_TestObjectives', criticalityMetrics: Array<{ __typename?: 'Trial_TestObjectives_CriticalityMetrics', value: number | null, passed: boolean, keyPerformanceIndicator: { __typename?: 'KeyPerformanceIndicator', id: number, name: string } }> } | null }> } | null };


export const GetBatchesDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"GetBatches"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"sort"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Batch_where"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"page"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"Batches"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"sort"},"value":{"kind":"Variable","name":{"kind":"Name","value":"sort"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}},{"kind":"Argument","name":{"kind":"Name","value":"page"},"value":{"kind":"Variable","name":{"kind":"Name","value":"page"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"docs"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"session"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}}]}},{"kind":"Field","name":{"kind":"Name","value":"egos"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"scenario"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"parameters"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"max"}},{"kind":"Field","name":{"kind":"Name","value":"min"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"unit"}}]}},{"kind":"Field","name":{"kind":"Name","value":"testObjectives"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"criticalityMetrics"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"threshold"}},{"kind":"Field","name":{"kind":"Name","value":"keyPerformanceIndicator"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"rule"}},{"kind":"Field","name":{"kind":"Name","value":"unit"}}]}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"schematic"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"sizes"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"tablet"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"url"}}]}}]}}]}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"page"}},{"kind":"Field","name":{"kind":"Name","value":"totalPages"}},{"kind":"Field","name":{"kind":"Name","value":"totalDocs"}}]}}]}}]} as unknown as DocumentNode<GetBatchesQuery, GetBatchesQueryVariables>;
export const GetBatchTrajectoryAnalysisDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"GetBatchTrajectoryAnalysis"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"id"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"Batch"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"id"},"value":{"kind":"Variable","name":{"kind":"Name","value":"id"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"savedTrajectoryAnalysis"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"url"}},{"kind":"Field","name":{"kind":"Name","value":"filename"}}]}}]}}]}}]} as unknown as DocumentNode<GetBatchTrajectoryAnalysisQuery, GetBatchTrajectoryAnalysisQueryVariables>;
export const GetBatchImagesDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"GetBatchImages"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"id"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"Batch"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"id"},"value":{"kind":"Variable","name":{"kind":"Name","value":"id"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"images"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"url"}},{"kind":"Field","name":{"kind":"Name","value":"filename"}}]}}]}}]}}]} as unknown as DocumentNode<GetBatchImagesQuery, GetBatchImagesQueryVariables>;
export const GetBatchDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"GetBatch"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"id"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"Batch"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"id"},"value":{"kind":"Variable","name":{"kind":"Name","value":"id"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"egos"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"scenario"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"parameters"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"max"}},{"kind":"Field","name":{"kind":"Name","value":"min"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"unit"}}]}},{"kind":"Field","name":{"kind":"Name","value":"testObjectives"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"criticalityMetrics"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"threshold"}},{"kind":"Field","name":{"kind":"Name","value":"keyPerformanceIndicator"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"rule"}},{"kind":"Field","name":{"kind":"Name","value":"unit"}}]}}]}}]}}]}}]}}]}}]} as unknown as DocumentNode<GetBatchQuery, GetBatchQueryVariables>;
export const GetBatchInfoDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"GetBatchInfo"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"id"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"Batch"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"id"},"value":{"kind":"Variable","name":{"kind":"Name","value":"id"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"scenario"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"parameters"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"min"}},{"kind":"Field","name":{"kind":"Name","value":"max"}},{"kind":"Field","name":{"kind":"Name","value":"unit"}}]}},{"kind":"Field","name":{"kind":"Name","value":"testObjectives"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"criticalityMetrics"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"threshold"}},{"kind":"Field","name":{"kind":"Name","value":"keyPerformanceIndicator"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"rule"}},{"kind":"Field","name":{"kind":"Name","value":"unit"}}]}}]}}]}}]}}]}}]}}]} as unknown as DocumentNode<GetBatchInfoQuery, GetBatchInfoQueryVariables>;
export const GetTrialsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"GetTrials"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"sort"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Trial_where"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"page"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"Trials"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"sort"},"value":{"kind":"Variable","name":{"kind":"Name","value":"sort"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}},{"kind":"Argument","name":{"kind":"Name","value":"page"},"value":{"kind":"Variable","name":{"kind":"Name","value":"page"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"docs"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"ego"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"parameters"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"parameterId"}},{"kind":"Field","name":{"kind":"Name","value":"value"}}]}},{"kind":"Field","name":{"kind":"Name","value":"testObjectives"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"criticalityMetrics"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"value"}},{"kind":"Field","name":{"kind":"Name","value":"passed"}},{"kind":"Field","name":{"kind":"Name","value":"keyPerformanceIndicator"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}}]}}]}}]}}]}}]} as unknown as DocumentNode<GetTrialsQuery, GetTrialsQueryVariables>;