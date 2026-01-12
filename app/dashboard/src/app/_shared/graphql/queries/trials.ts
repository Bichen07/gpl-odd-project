import { gql } from "@/app/_shared/graphql/__generated__/gql";
import request from "graphql-request";
import qs from "qs";
import { api } from "@/app/_shared/api";
import {
  GetTrialsQuery,
  GetTrialsQueryVariables,
} from "../__generated__/graphql";
import { O } from "ts-toolbelt";

const GET_TRIALS = gql(`
  query GetTrials(
    $limit: Int
    $sort: String
    $where: Trial_where
    $page: Int
  ) {
    Trials(limit: $limit, sort: $sort, where: $where, page: $page) {
  	  docs {
        id
        ego {
          id
          name
        }
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

export type Trial = O.Path<GetTrialsQuery, ["Trials", "docs", "0"]>;

export const getTrials = async (variables: GetTrialsQueryVariables) => {
  return request(
    `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/graphql`,
    GET_TRIALS,
    variables
  ).then((response) => response.Trials?.docs);
};

export type TrajectoryResponseData = {
  trialId: number;
  time: number[];
  anchor: {
    x: number;
    y: number;
    h: number;
  };
  trajectory: {
    [actor: string]: {
      x: number;
      y: number;
      yaw: number;
      laneHeading: number;
      globalX: number;
      globalY: number;
      localX?: number;
      localY?: number;
      width?: number;
      length?: number;
      s_ratio: number;
    }[];
  };
};
export type TrajectoryQuery = {
  trialId: string;
  index: number;
  duration: number;
  framePeriod: number;
  standardized?: boolean;
  forward: boolean;
};
export type TrajectoryRequest = {
  queries: TrajectoryQuery[];
};
export const getTrajectoryFromTrial = async (
  trialId: string,
  query: {
    index: number;
    duration: number;
    framePeriod: number;
    standardized?: boolean;
  }
) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return api.get<TrajectoryResponseData>(
    `/trials/${trialId}/trajectory${stringifiedQuery}`
  );
};
export const getTrajectories = async (data: {
  trialIds: number[];
  framePeriod: number;
  standardized?: boolean;
}) => {
  return api.post<TrajectoryResponseData[]>(`/trials/trajectories`, data);
};

export type TrajectoryHeatmapsRequest = {
  queries: TrajectoryQuery[];
  attributes: string[];
  resolution: number;
};
export const getTrajectoryHeatmaps = async (
  data: TrajectoryHeatmapsRequest
) => {
  return api.post<TrajectoryResponseData[]>(`/trials/trajectoryHeatmaps`, data);
};

export const getTrialTrajectoryUrl = (
  trialId: string,
  query: {
    index: number;
    duration: number;
    frames: number;
    standardized?: boolean;
  }
) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return `${api.getUri()} / trials / ${trialId} / trajectory${stringifiedQuery}`;
};
