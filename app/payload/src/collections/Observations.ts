import { CollectionConfig, PayloadRequest } from 'payload'
import { usersAccess } from '../access'

export const Observations: CollectionConfig = {
  slug: 'observations',
  admin: {
    useAsTitle: 'id',
    group: 'Simulation',
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  endpoints: [
    // {
    //   path: "/getFromIDs",
    //   method: "post",
    //   handler: async (req, res, _next) => {
    //     let promises = [];
    //
    //     for (const observationId of req.body) {
    //       promises.push(
    //         req.payload.findByID({
    //           collection: "observations",
    //           id: observationId,
    //           depth: 0,
    //         })
    //       );
    //     }
    //
    //     let data = null;
    //     await Promise.all(promises)
    //       .then((results) => {
    //         data = results;
    //       })
    //       .catch((error) => {
    //         return res.status(400).send({
    //           message: error.message,
    //         });
    //       });
    //
    //     return res.status(200).send(data);
    //   },
    // },
    {
      path: '/bulk',
      method: 'post',
      handler: async (req: PayloadRequest) => {
        try {
          if (!req.json) return Response.json({ error: 'No data' }, { status: 400 })
          // if (!Array.isArray(req.body)) {
          //   return Response.json(
          //     { error: 'Body must be an array of observations' },
          //     { status: 400 },
          //   )
          // }

          const data = await req.json()

          const results = await Promise.all(
            data.map((observation: any) =>
              req.payload.create({
                collection: 'observations',
                data: observation,
              }),
            ),
          )

          return Response.json(results)
        } catch (error) {
          console.error('Bulk create error:', error)
          return Response.json(
            {
              error: 'Some of the observations failed to create',
              // details: error.message,
            },
            { status: 500 },
          )
        }
      },
    },
  ],
  fields: [
    {
      name: 'trial',
      type: 'relationship',
      label: 'Trial',
      relationTo: 'trials',
      hasMany: false,
    },
    {
      name: 'ego',
      type: 'relationship',
      label: 'Ego',
      relationTo: 'egos',
      hasMany: false,
      required: true,
    },
    {
      name: 'time',
      type: 'number',
      label: 'time',
    },
    {
      name: 'esminiSeconds',
      type: 'number',
    },
    {
      name: 'egoX',
      type: 'number',
      label: 'Ego X',
    },
    {
      name: 'egoY',
      type: 'number',
      label: 'Ego Y',
    },
    {
      name: 'egoYaw',
      type: 'number',
      label: 'Ego Yaw',
    },
    {
      name: 'egoRoadId',
      type: 'number',
      label: 'Ego Road ID',
    },
    {
      name: 'egoS',
      type: 'number',
      label: 'Ego S',
    },
    {
      name: 'egoT',
      type: 'number',
      label: 'Ego T',
    },
    {
      name: 'egoJunctionId',
      type: 'number',
      label: 'Ego Junction ID',
    },
    {
      name: 'egoLaneId',
      type: 'number',
      label: 'Ego Lane ID',
    },
    {
      name: 'egoLaneOffset',
      type: 'number',
      label: 'Ego Lane Offset',
    },
    {
      name: 'egoLaneHeading',
      type: 'number',
    },
    {
      name: 'egoCurvature',
      type: 'number',
    },
    {
      name: 'egoSpeed',
      type: 'number',
      label: 'Ego Speed',
    },
    {
      name: 'egoAcceleration',
      type: 'number',
      label: 'Ego Acceleration',
    },
    {
      name: 'egoYawRate',
      type: 'number',
      label: 'Ego Yaw Rate',
    },
    {
      name: 'egoSpeedCmd',
      type: 'number',
      label: 'Ego Speed Command',
    },
    {
      name: 'egoSteerCmd',
      type: 'number',
      label: 'Ego Steer Command',
    },
    {
      name: 'agents',
      type: 'array',
      label: 'Agents',
      fields: [
        {
          name: 'name',
          label: 'name',
          type: 'text',
        },
        {
          name: 'ttc',
          type: 'number',
        },
        {
          name: 'x',
          label: 'x',
          type: 'number',
        },
        {
          name: 'y',
          label: 'y',
          type: 'number',
        },
        {
          name: 'yaw',
          label: 'yaw',
          type: 'number',
        },
        {
          name: 'roadId',
          label: 'Road ID',
          type: 'number',
        },
        {
          name: 's',
          label: 's',
          type: 'number',
        },
        {
          name: 't',
          label: 't',
          type: 'number',
        },
        {
          name: 'junctionId',
          label: 'Junction ID',
          type: 'number',
        },
        {
          name: 'laneId',
          label: 'Lane ID',
          type: 'number',
        },
        {
          name: 'laneOffset',
          label: 'Lane Offset',
          type: 'number',
        },
        {
          name: 'laneHeading',
          type: 'number',
        },
        {
          name: 'curvature',
          type: 'number',
        },
        {
          name: 'yawRate',
          label: 'Yaw Rate',
          type: 'number',
        },
        {
          name: 'speed',
          label: 'Speed',
          type: 'number',
        },
        {
          name: 'acceleration',
          label: 'Acceleration',
          type: 'number',
        },
        {
          name: 'relativeDistance',
          type: 'number',
        },
        {
          name: 'ttce',
          type: 'number',
        },
        {
          name: 'dce',
          type: 'number',
        },
        {
          name: 'rssRatio',
          type: 'number',
        },
        {
          name: 'isRssSafe',
          type: 'number',
        },
        {
          name: 'collisionRisk',
          type: 'number',
        },
        {
          name: 'accReq',
          type: 'number',
        },
        {
          name: 'spret',
          type: 'number',
        },
        {
          name: 'pret',
          type: 'number',
        },
        // {
        //   name: "relativeYaw",
        //   type: "number",
        // },
        // {
        //   name: "relativeSpeed",
        //   type: "number",
        // },
        // {
        //   name: "relativeSpeedYaw",
        //   type: "number",
        // },
        // {
        //   name: "relativeAcceleration",
        //   type: "number",
        // },
        // {
        //   name: "relativeAccelerationYaw",
        //   type: "number",
        // },
        {
          name: 'width',
          label: 'Width',
          type: 'number',
        },
        {
          name: 'length',
          label: 'Length',
          type: 'number',
        },
        {
          name: 'height',
          label: 'Height',
          type: 'number',
        },
        {
          name: 'localX',
          label: 'Local X',
          type: 'number',
        },
        {
          name: 'localY',
          label: 'Local Y',
          type: 'number',
        },
        {
          name: 'localYaw',
          label: 'Local Yaw',
          type: 'number',
        },
        {
          name: 'relativeYawRate',
          label: 'Relative Yaw Rate',
          type: 'number',
        },
        {
          name: 'relativeVelocityX',
          label: 'Relative Velocity X',
          type: 'number',
        },
        {
          name: 'relativeVelocityY',
          label: 'Relative Velocity Y',
          type: 'number',
        },
        {
          name: 'relativeAccelerationX',
          label: 'Relative Acceleration X',
          type: 'number',
        },
        {
          name: 'relativeAccelerationY',
          label: 'Relative Acceleration Y',
          type: 'number',
        },
      ],
    },
  ],
}
