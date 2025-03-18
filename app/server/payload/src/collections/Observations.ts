import { CollectionConfig } from "payload/types";

export const clusteringSpaces = ["umap", "original"] as const;
export type ClusteringSpace = (typeof clusteringSpaces)[number];

export type ClusteringRequestBody = {
  clusteringSpace: ClusteringSpace;
  representations: { [trialId: string]: number[] };
};

const Observations: CollectionConfig = {
  slug: "observations",
  admin: {
    useAsTitle: "id",
  },
  access: {
    create: () => true,
    read: () => true,
    update: () => true,
    delete: () => true,
  },
  endpoints: [
    {
      path: "/cluster",
      method: "post",
      handler: async (req, res, next) => {
        const requestBody = req.body as ClusteringRequestBody;
        const x = Object.values(requestBody.representations);
        try {
          const response = await fetch("http://analysis:8001/cluster", {
            method: "POST",
            body: JSON.stringify({ x }),
          });
          const clusterRepsonseBody: {
            clusters: number[];
            memberships: number[];
          } = await response.json();
          const result: {
            [key: string]: { cluster: number; membership: number };
          } = {};
          const trialIds = Object.keys(requestBody.representations);
          for (let index = 0; index < trialIds.length; index++) {
            const trialId = trialIds[index];
            result[trialId] = {
              cluster: clusterRepsonseBody.clusters[index],
              membership: clusterRepsonseBody.memberships[index],
            };
          }
          return res.status(200).send(result);
        } catch (error) {
          return res.status(400).send(error);
        }
      },
    },
    {
      path: "/batch",
      method: "post",
      handler: async (req, res, next) => {
        let promises = [];

        for (const observation of req.body) {
          promises.push(
            req.payload.create({
              collection: "observations",
              data: observation,
            })
          );
        }

        let data = null;
        await Promise.all(promises)
          .then((results) => {
            data = results;
          })
          .catch((error) => {
            return res.status(400).send({
              error: "some of the observations are failed to create",
            });
          });

        return res.status(200).send(data);
      },
    },
  ],
  fields: [
    {
      name: "trial",
      type: "relationship",
      label: "Trial",
      relationTo: "trials",
      hasMany: false,
      required: true,
    },
    {
      name: "isFinal",
      type: "checkbox",
      label: "Is Final",
    },
    {
      name: "time",
      type: "number",
      label: "time",
    },
    {
      name: "egoX",
      type: "number",
      label: "Ego X",
    },
    {
      name: "egoY",
      type: "number",
      label: "Ego Y",
    },
    {
      name: "egoYaw",
      type: "number",
      label: "Ego Yaw",
    },
    {
      name: "egoRoadId",
      type: "number",
      label: "Ego Road ID",
    },
    {
      name: "egoS",
      type: "number",
      label: "Ego S",
    },
    {
      name: "egoT",
      type: "number",
      label: "Ego T",
    },
    {
      name: "egoJunctionId",
      type: "number",
      label: "Ego Junction ID",
    },
    {
      name: "egoLaneId",
      type: "number",
      label: "Ego Lane ID",
    },
    {
      name: "egoLaneOffset",
      type: "number",
      label: "Ego Lane Offset",
    },
    {
      name: "egoSpeed",
      type: "number",
      label: "Ego Speed",
    },
    {
      name: "egoAcceleration",
      type: "number",
      label: "Ego Acceleration",
    },
    {
      name: "egoYawRate",
      type: "number",
      label: "Ego Yaw Rate",
    },
    {
      name: "egoSpeedCmd",
      type: "number",
      label: "Ego Speed Command",
    },
    {
      name: "egoSteerCmd",
      type: "number",
      label: "Ego Steer Command",
    },
    {
      name: "agents",
      type: "array",
      label: "Agents",
      fields: [
        {
          name: "name",
          label: "name",
          type: "text",
        },
        {
          name: "x",
          label: "x",
          type: "number",
        },
        {
          name: "y",
          label: "y",
          type: "number",
        },
        {
          name: "yaw",
          label: "yaw",
          type: "number",
        },
        {
          name: "roadId",
          label: "Road ID",
          type: "number",
        },
        {
          name: "s",
          label: "s",
          type: "number",
        },
        {
          name: "t",
          label: "t",
          type: "number",
        },
        {
          name: "junctionId",
          label: "Junction ID",
          type: "number",
        },
        {
          name: "laneId",
          label: "Lane ID",
          type: "number",
        },
        {
          name: "laneOffset",
          label: "Lane Offset",
          type: "number",
        },
        {
          name: "speed",
          label: "Speed",
          type: "number",
        },
        {
          name: "acceleration",
          label: "Acceleration",
          type: "number",
        },
        {
          name: "yawRate",
          label: "Yaw Rate",
          type: "number",
        },
        {
          name: "width",
          label: "Width",
          type: "number",
        },
        {
          name: "length",
          label: "Length",
          type: "number",
        },
        {
          name: "height",
          label: "Height",
          type: "number",
        },
        {
          name: "localX",
          label: "Local X",
          type: "number",
        },
        {
          name: "localY",
          label: "Local Y",
          type: "number",
        },
        {
          name: "localYaw",
          label: "Local Yaw",
          type: "number",
        },
        {
          name: "relativeYawRate",
          label: "Relative Yaw Rate",
          type: "number",
        },
        {
          name: "relativeVelocityX",
          label: "Relative Velocity X",
          type: "number",
        },
        {
          name: "relativeVelocityY",
          label: "Relative Velocity Y",
          type: "number",
        },
        {
          name: "relativeAccelerationX",
          label: "Relative Acceleration X",
          type: "number",
        },
        {
          name: "relativeAccelerationY",
          label: "Relative Acceleration Y",
          type: "number",
        },
      ],
    },
  ],
};

export default Observations;
