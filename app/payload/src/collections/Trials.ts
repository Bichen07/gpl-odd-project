import { BulkOperationResult } from "payload/dist/collections/config/types";
import { EsminiDat, Observation } from "payload/generated-types";
import { CollectionConfig, PayloadRequest } from "payload/types";
import { usersAccess } from "../access";
import { Vector3 } from "threejs-math";
import _ from "lodash";

export type TrajectoryQuery = {
  trialId: string;
  index: number;
  nFrames: number;
  framePeriod: number;
  duration: number;
  standardized?: boolean;
  forward: boolean;
};
export type TrajectoriesRequestBody = {
  queries: TrajectoryQuery[];
};

const getTrajectory = async (
  req: PayloadRequest<any>,
  query: TrajectoryQuery
) => {
  const {
    index,
    duration,
    framePeriod,
    nFrames,
    trialId,
    standardized,
    forward,
  } = query;

  const trial = await req.payload.findByID({
    collection: "trials",
    id: trialId,
    depth: 0,
  });

  if (!trial.observations || trial.observations.length === 0) {
    throw Error(`trial ${trialId} has no observations`);
  }
  if (trial.observations.length < 3) {
    throw Error(`trial ${trialId}: length of observations is too small`);
  }
  const observation2 = await req.payload.findByID({
    collection: "observations",
    id: `${trial.observations[1]}`,
    depth: 0,
  });
  const observation1 = await req.payload.findByID({
    collection: "observations",
    id: `${trial.observations[0]}`,
    depth: 0,
  });

  let startIndex = null;
  let endIndex = null;
  let durationIndexStep = 0;

  if (duration === -1) {
    startIndex = 0;
    endIndex = (trial.observations?.length ?? 1) - 1;
  } else {
    const period = observation2.esminiSeconds - observation1.esminiSeconds;
    let durationIndexStep = Math.floor((duration + 3.0) / period);
    startIndex = Math.max(index - durationIndexStep, 0);
    endIndex = index;
    if (index === -1) {
      endIndex = (trial.observations?.length ?? 1) - 1;
    }
  }

  let observationIds = trial.observations.slice(
    startIndex,
    endIndex + 1
  ) as string[];
  // console.log(observationIds[observationIds.length - 1]);

  if (forward) {
    console.log(`${trial.id} is forward: ${forward}`);
    startIndex = index;
    endIndex = Math.min(
      startIndex + durationIndexStep,
      trial.observations.length - 1
    );
    observationIds = trial.observations.slice(
      startIndex,
      endIndex + 1
    ) as string[];
    console.log(
      `length of observations of trajectory ${observationIds.length}`
    );
  }

  const promises: Promise<Observation>[] = [];
  for (const observationId of observationIds) {
    promises.push(
      req.payload.findByID({
        collection: "observations",
        id: observationId,
        depth: 0,
      })
    );
  }

  const data = await Promise.all(promises);

  function linspace(start: number, stop: number, num: number) {
    const arr = [];
    const step = (stop - start) / (num - 1);

    for (let i = 0; i <= num; i++) {
      arr.push(start + step * i);
    }

    return arr;
  }

  function steps(start: number, stop: number, period: number) {
    const arr = [];

    for (let i = 0; start + i * period < stop; i++) {
      const newTime = start + i * period;
      if (newTime > stop) {
        break;
      }
      arr.push(newTime);
    }
    arr.push(stop);

    return arr;
  }

  function interpolate(newTime: number, data: any, key: string) {
    let prevPoint = null;
    let nextPoint = null;

    for (let i = 0; i < data.length; i++) {
      if (data[i].esminiSeconds === newTime) {
        return data[i][key];
      } else if (data[i].esminiSeconds < newTime) {
        prevPoint = data[i];
      } else if (data[i].esminiSeconds > newTime) {
        nextPoint = data[i];
        break;
      }
    }

    if (prevPoint && nextPoint) {
      const t1 = prevPoint.esminiSeconds;
      const t2 = nextPoint.esminiSeconds;
      const v1 = prevPoint[key];
      const v2 = nextPoint[key];

      return v1 + ((newTime - t1) * (v2 - v1)) / (t2 - t1);
    }

    return null;
  }

  const lastItem = [...data].reverse().find((item) => "agents" in item);
  const agentNames = lastItem.agents.map((agent) => agent.name);
  // console.log(data[data.length - 1]);
  // console.log("last item");
  // console.log(lastItem);

  let endSeconds = lastItem.esminiSeconds;
  let startSeconds = 0;
  if (duration === -1) {
    startSeconds = data[0].esminiSeconds;
  } else {
    startSeconds = endSeconds - duration;
  }
  if (forward) {
    const firstItem = data[0];
    startSeconds = firstItem.esminiSeconds;
    endSeconds = startSeconds + duration;
  }
  // console.log(endSeconds);

  // const newTimePoints = linspace(startSeconds, endSeconds, nFrames);
  const newTimePoints =
    framePeriod != null
      ? steps(startSeconds, endSeconds, framePeriod)
      : linspace(startSeconds, endSeconds, nFrames);

  const result = {
    trialId: query.trialId,
    startObservationIndex: startIndex,
    endObservationIndex: endIndex,
    time: newTimePoints.map((time) => time - newTimePoints[0]),
    anchor: {
      x: 0,
      y: 0,
      h: 0,
    },
    trajectory: {},
    events: "events" in trial && trial["events"] ? trial["events"] : [],
  };

  const keys = Object.keys(data[0]);
  let egoInterpolated = newTimePoints.map((time) => {
    const interpolatedValues = {};
    keys
      .filter((key) => key.includes("ego"))
      .forEach((key) => {
        const newKey = key.charAt(3).toLowerCase() + key.slice(4);
        interpolatedValues[newKey] = interpolate(time, data, key);
      });
    return interpolatedValues;
  });

  result.trajectory["Ego"] = egoInterpolated;

  if ("agents" in lastItem && lastItem.agents && lastItem.agents.length) {
    const agentKeys = Object.keys(lastItem.agents[0]).filter(
      (key) => key !== "id" && key !== "name"
    );
    for (const agentIndex in agentNames) {
      const agentName = agentNames[agentIndex];
      const agentData = data.map((item) => ({
        ...item.agents[agentIndex],
        esminiSeconds: item.esminiSeconds,
      }));
      let agentInterpolated = newTimePoints.map((time, _index) => {
        const interpolatedValues = {};
        agentKeys.forEach((key) => {
          interpolatedValues[key] = interpolate(time, agentData, key);
        });
        return interpolatedValues;
      });
      // console.log(agentInterpolated);
      result.trajectory[agentName] = agentInterpolated;
    }
  }

  const egoTraj = _.cloneDeep(result.trajectory["Ego"]);
  // const anchorEgoState = egoTraj[egoTraj.length - 1];
  const anchorEgoState = egoTraj[0];
  // result.anchor.x = egoTraj[0].x;
  // result.anchor.y = egoTraj[0].y;
  // result.anchor.h = egoTraj[0].yaw - egoTraj[0].laneHeading;

  result.anchor.x = anchorEgoState.x;
  result.anchor.y = anchorEgoState.y;
  // result.anchor.h = anchorEgoState.yaw - anchorEgoState.laneHeading;
  result.anchor.h = anchorEgoState.yaw;
  // result.anchor.h = anchorEgoState.laneHeading;

  if (standardized) {
    // console.log("standardized")
    for (const [actorName, actorTraj] of Object.entries(
      result.trajectory ?? {}
    )) {
      for (let i = 0; i < result.time.length; i++) {
        actorTraj[i].globalX = actorTraj[i].x;
        actorTraj[i].globalY = actorTraj[i].y;
        const newPosition = new Vector3(
          actorTraj[i].x - anchorEgoState.x,
          actorTraj[i].y - anchorEgoState.y,
          0.0
        ).applyAxisAngle(new Vector3(0, 0, 1), -result.anchor.h);
        const newYaw = actorTraj[i].yaw - result.anchor.h;
        actorTraj[i].x = newPosition.x;
        actorTraj[i].y = newPosition.y;
        // actorTraj[i].laneYaw = actorTraj[i].yaw - egoTraj[i].laneHeading;
        actorTraj[i].yaw = newYaw;
      }
    }
  }

  return result;
};

const Trials: CollectionConfig = {
  slug: "trials",
  admin: {
    useAsTitle: "id",
    group: "Simulation",
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  endpoints: [
    {
      path: "/trajectories",
      method: "post",
      handler: async (req, res, next) => {
        const requestBody = req.body as TrajectoriesRequestBody;

        // console.time("total");
        const data: any[] = [];
        for (const query of requestBody.queries) {
          // console.time(query.trialId);
          try {
            const result = await getTrajectory(req, { ...query });
            data.push(result);
          } catch (error) {
            console.error(error);
          }
          // console.timeEnd(query.trialId);
        }
        // console.timeEnd("total");

        return res.status(200).send(data);
      },
    },
    {
      path: "/:id/trajectory",
      method: "get",
      handler: async (req, res, next) => {
        const index = Number(req.query["index"]);
        const duration = Number(req.query["duration"]) ?? 3;
        const nFrames = Number(req.query["nFrames"]) ?? null;
        const framePeriod = Number(req.query["framePeriod"]) ?? null;
        const standardized = req.query["standardized"] === "true";
        const forward = req.query["forward"] === "true";
        const trialId = req.params.id;
        try {
          const result = await getTrajectory(req, {
            index,
            duration,
            nFrames,
            framePeriod,
            trialId,
            standardized,
            forward,
          });
          return res.status(200).send(result);
        } catch (error) {
          console.error(error);
          return res.status(400).send({
            error: error.message,
          });
        }
      },
    },
    {
      path: "/delete",
      method: "delete",
      handler: async (req, res, next) => {
        const trials = await req.payload.delete({
          collection: "trials",
          where: req.body["where"],
          depth: 0,
        });

        let promisesObservations: Promise<
          BulkOperationResult<"observations">
        >[] = [];
        let promisesEsminiDats: Promise<EsminiDat>[] = [];
        for (const trial of trials.docs) {
          promisesObservations.push(
            req.payload.delete({
              collection: "observations",
              depth: 0,
              where: {
                trial: { equals: trial.id },
              },
            })
          );
          promisesEsminiDats.push(
            req.payload.delete({
              collection: "esminiDats",
              depth: 0,
              id: trial.esminiDat as string,
            })
          );
        }

        await Promise.all(promisesObservations).catch((error) => {
          console.error("Error:", error);
          return res.status(400).send({
            error: "some of the observations are failed to delete",
          });
        });

        await Promise.all(promisesEsminiDats).catch((error) => {
          console.error("Error:", error);
          return res.status(400).send({
            error: "some of the esminiDats are failed to delete",
          });
        });

        return res.status(200).send(trials);
      },
    },
  ],
  fields: [
    {
      name: "batch",
      type: "relationship",
      label: "Batch",
      relationTo: "batches",
      hasMany: false,
      required: true,
    },
    {
      name: "parameters",
      type: "array",
      label: "Parameters",
      required: true,
      fields: [
        {
          name: "parameterId",
          label: "Parameter ID",
          type: "text",
          required: true,
        },
        {
          name: "value",
          label: "Value",
          type: "number",
          required: true,
        },
      ],
    },
    {
      name: "events",
      type: "array",
      fields: [
        {
          name: "name",
          type: "text",
          required: true,
        },
        {
          name: "time",
          type: "number",
          required: true,
        },
        {
          name: "esminiSeconds",
          type: "number",
          required: true,
        },
        {
          name: "observationIndex",
          type: "number",
          required: true,
        },
        {
          name: "previewImage",
          type: "relationship",
          relationTo: "media",
          hasMany: false,
        },
      ],
    },
    {
      name: "previewImage",
      type: "relationship",
      relationTo: "media",
      hasMany: false,
    },
    {
      name: "testObjectives",
      type: "group",
      fields: [
        {
          name: "criticalityMetrics",
          type: "array",
          required: true,
          fields: [
            {
              name: "keyPerformanceIndicator",
              type: "relationship",
              relationTo: "keyPerformanceIndicators",
              hasMany: false,
              required: true,
            },
            {
              name: "value",
              label: "Value",
              type: "number",
              // required: true,
            },
            {
              name: "passed",
              label: "Passed",
              type: "checkbox",
              required: true,
            },
            {
              name: "worstObservation",
              type: "relationship",
              relationTo: "observations",
              hasMany: false,
            },
            {
              name: "worstObservationIndex",
              type: "number",
            },
            {
              name: "firstFailedObservationIndex",
              type: "number",
            },
          ],
        },
        {
          name: "referenceModels",
          type: "array",
          fields: [
            {
              name: "referenceModel",
              type: "text",
            },
            {
              name: "passed",
              label: "Passed",
              type: "checkbox",
              required: true,
            },
          ],
        },
      ],
    },
    {
      name: "esminiDat",
      label: "Esmini Dat",
      type: "relationship",
      relationTo: "esminiDats",
      hasMany: false,
      required: true,
    },
    {
      name: "observations",
      type: "relationship",
      relationTo: "observations",
      hasMany: true,
    },
  ],
};

export default Trials;
