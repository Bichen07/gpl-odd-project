import { gql } from "src/__generated__";
import { Trial_Where } from "src/__generated__/graphql";
import { client } from "src/api/apollo-client";
import qs from "qs";
import http from "src/api/http-common";

const GET_TRIAL_PREVIEW_IMAGES = gql(`query GetTrials($where: Trial_where) {
  Trials(where: $where, limit: 8000) {
  	docs {
      id
      previewImage {
        url
        sizes {
          thumbnail {
            url
          }
        }
      }
    }
  }
}`);

export const getTrialPreviewImages = async (where: Trial_Where) => {
  const { data, error } = await client.query({
    query: GET_TRIAL_PREVIEW_IMAGES,
    variables: {
      where,
    },
  });
  console.error(error);
  return data.Trials?.docs;
};

export type TrajectoryResponseData = {
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
  },
) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return http.get<TrajectoryResponseData>(
    `/trials/${trialId}/trajectory${stringifiedQuery}`,
  );
};
export const getTrajectories = async (data: TrajectoryRequest) => {
  return http.post<TrajectoryResponseData>(`/trials/trajectories`, data);
};

export const getTrialTrajectoryUrl = (
  trialId: string,
  query: {
    index: number;
    duration: number;
    frames: number;
    standardized?: boolean;
  },
) => {
  const stringifiedQuery = qs.stringify(query, { addQueryPrefix: true });
  return `${http.getUri()}/trials/${trialId}/trajectory${stringifiedQuery}`;
};
