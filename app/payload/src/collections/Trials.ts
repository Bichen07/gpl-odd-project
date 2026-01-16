import { CollectionConfig, PayloadRequest, BulkOperationResult } from 'payload'
import { usersAccess } from '../access'
import { Vector3 } from 'three'
import _ from 'lodash'

export type TrajectoriesQuery = {
  trialIds: number[]
  framePeriod: number
  standardized?: boolean
}

// Efficient batch interpolation
function batchInterpolate(times: number[], values: number[], newTimes: number[]): number[] {
  let j = 0
  const results: number[] = []

  for (const nt of newTimes) {
    while (j < times.length - 2 && times[j + 1] < nt) j++
    const t1 = times[j],
      t2 = times[j + 1]
    const v1 = values[j],
      v2 = values[j + 1]
    results.push(t1 === t2 ? v1 : v1 + ((nt - t1) * (v2 - v1)) / (t2 - t1))
  }

  return results
}

async function buildTrajectory(data: any[], query: any) {
  const { framePeriod, standardized } = query

  if (!data.length) return null

  const lastItem = [...data].reverse().find((item) => 'agents' in item)
  const agentNames = lastItem?.agents?.map((agent: any) => agent.name) ?? []
  const endSeconds = lastItem?.esminiSeconds ?? 0
  const startSeconds = data[0].esminiSeconds ?? 0

  function steps(start: number, stop: number, period: number) {
    const arr = []
    for (let i = 0; start + i * period < stop; i++) {
      arr.push(start + i * period)
    }
    arr.push(stop)
    return arr
  }

  const newTimePoints = steps(startSeconds, endSeconds, framePeriod)

  const result = {
    trialId: query.trialId,
    startObservationIndex: 0,
    endObservationIndex: data.length - 1,
    time: newTimePoints.map((time) => time - newTimePoints[0]),
    anchor: { x: 0, y: 0, h: 0 },
    trajectory: {} as { [actor: string]: any[] },
    events: [],
  }

  // ---- Ego interpolation ----
  const keys = Object.keys(data[0]).filter((k) => k.includes('ego'))
  const times = data.map((d) => d.esminiSeconds)
  for (const key of keys) {
    const values = data.map((d) => d[key])
    const newKey = key.charAt(3).toLowerCase() + key.slice(4)
    const interp = batchInterpolate(times, values, newTimePoints)
    interp.forEach((v, i) => {
      if (!result.trajectory['Ego']) result.trajectory['Ego'] = []
      result.trajectory['Ego'][i] = {
        ...(result.trajectory['Ego'][i] || {}),
        [newKey]: v,
      }
    })
  }

  // ---- Agents interpolation ----
  if (lastItem?.agents?.length) {
    const agentKeys = Object.keys(lastItem.agents[0]).filter((k) => k !== 'id' && k !== 'name')
    for (const [agentIndex, agentName] of agentNames.entries()) {
      const agentData = data.map((item) => ({
        ...item.agents![agentIndex],
        esminiSeconds: item.esminiSeconds,
      }))
      const agentTimes = agentData.map((d) => d.esminiSeconds)

      for (const key of agentKeys) {
        const values = agentData.map((d) => d[key])
        const interp = batchInterpolate(agentTimes, values, newTimePoints)
        interp.forEach((v, i) => {
          if (!result.trajectory[agentName]) result.trajectory[agentName] = []
          result.trajectory[agentName][i] = {
            ...(result.trajectory[agentName][i] || {}),
            [key]: v,
          }
        })
      }
    }
  }

  // ---- Anchor setup ----
  const egoTraj = _.cloneDeep(result.trajectory['Ego'])
  const anchorEgoState = egoTraj[0]
  result.anchor.x = anchorEgoState.x
  result.anchor.y = anchorEgoState.y
  result.anchor.h = anchorEgoState.yaw

  // ---- Standardization ----
  if (standardized) {
    for (const [actorName, actorTraj] of Object.entries(result.trajectory ?? {})) {
      for (let i = 0; i < result.time.length; i++) {
        actorTraj[i].globalX = actorTraj[i].x
        actorTraj[i].globalY = actorTraj[i].y
        const newPosition = new Vector3(
          actorTraj[i].x - anchorEgoState.x,
          actorTraj[i].y - anchorEgoState.y,
          0.0,
        ).applyAxisAngle(new Vector3(0, 0, 1), -result.anchor.h)
        const newYaw = actorTraj[i].yaw - result.anchor.h
        actorTraj[i].x = newPosition.x
        actorTraj[i].y = newPosition.y
        actorTraj[i].yaw = newYaw
      }
    }
  }

  return result
}

export const Trials: CollectionConfig = {
  slug: 'trials',
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
    {
      path: '/trajectories',
      method: 'post',
      handler: async (req: PayloadRequest) => {
        if (!req.json) return Response.json({ error: 'No data' }, { status: 400 })
        let requestBody: TrajectoriesQuery
        try {
          requestBody = (await req?.json()) as TrajectoriesQuery
        } catch (err) {
          console.error('Invalid JSON body:', err)
          return Response.json({ error: 'Invalid request body' }, { status: 400 })
        }

        const { trialIds, framePeriod, standardized } = requestBody
        console.log(trialIds)

        // ---- Validate inputs ----
        if (!Array.isArray(trialIds) || trialIds.length === 0) {
          return Response.json({ error: 'trialIds must be a non-empty array' }, { status: 400 })
        }

        const numericTrialIds = trialIds
          .map((id) => Number(id))
          .filter((id) => !isNaN(id) && id > 0)

        if (numericTrialIds.length === 0) {
          return Response.json({ error: 'All trialIds are invalid' }, { status: 400 })
        }

        const numericFramePeriod = Number(framePeriod)
        if (isNaN(numericFramePeriod) || numericFramePeriod <= 0) {
          return Response.json({ error: 'framePeriod must be a positive number' }, { status: 400 })
        }

        // ---- Query observations ----
        let observations
        try {
          observations = await req.payload.find({
            collection: 'observations',
            limit: 0,
            depth: 0,
            sort: 'esminiSeconds',
            where: {
              trial: { in: numericTrialIds },
            },
          })
        } catch (error) {
          console.error('DB query failed:', error)
          return Response.json({ error: 'Fail to get observations' }, { status: 500 })
        }

        // ---- Build trajectories grouped by trial ----
        try {
          const grouped = _.groupBy(observations.docs, 'trial')

          const results = await Promise.all(
            numericTrialIds.map((trialId) =>
              buildTrajectory(grouped[trialId] || [], {
                trialId,
                framePeriod: numericFramePeriod,
                standardized,
              }),
            ),
          )

          const filtered = results.filter(Boolean)
          return Response.json(filtered)
        } catch (error) {
          console.error('Trajectory building failed:', error)
          return Response.json({ error: 'Failed to build trajectories' }, { status: 500 })
        }
      },
    },
    // {
    //   path: '/:id/trajectory',
    //   method: 'get',
    //   handler: async (req: PayloadRequest) => {
    //     const index = Number(req.query['index'])
    //     const duration = Number(req.query['duration']) ?? 3
    //     const nFrames = Number(req.query['nFrames']) ?? null
    //     const framePeriod = Number(req.query['framePeriod']) ?? null
    //     const standardized = req.query['standardized'] === 'true'
    //     const forward = req.query['forward'] === 'true'
    //     const trialId = (req.routeParams?.id ?? 'unknown') as string
    //
    //     try {
    //       const result = await buildTrajectory(req, {
    //         index,
    //         duration,
    //         nFrames,
    //         framePeriod,
    //         trialId,
    //         standardized,
    //         forward,
    //       })
    //       return Response.json(result)
    //     } catch (error) {
    //       console.error(error)
    //       return Response.json({
    //         error: 'Cannot get trjaectory from id',
    //       })
    //     }
    //   },
    // },
    //   {
    //     path: '/delete',
    //     method: 'delete',
    //     handler: async (req, res, next) => {
    //       const trials = await req.payload.delete({
    //         collection: 'trials',
    //         where: req.body['where'],
    //         depth: 0,
    //       })
    //
    //       let promisesObservations: Promise<BulkOperationResult<'observations'>>[] = []
    //       let promisesEsminiDats: Promise<EsminiDat>[] = []
    //       for (const trial of trials.docs) {
    //         promisesObservations.push(
    //           req.payload.delete({
    //             collection: 'observations',
    //             depth: 0,
    //             where: {
    //               trial: { equals: trial.id },
    //             },
    //           }),
    //         )
    //         promisesEsminiDats.push(
    //           req.payload.delete({
    //             collection: 'esminiDats',
    //             depth: 0,
    //             id: trial.esminiDat as string,
    //           }),
    //         )
    //       }
    //
    //       await Promise.all(promisesObservations).catch((error) => {
    //         console.error('Error:', error)
    //         return res.status(400).send({
    //           error: 'some of the observations are failed to delete',
    //         })
    //       })
    //
    //       await Promise.all(promisesEsminiDats).catch((error) => {
    //         console.error('Error:', error)
    //         return res.status(400).send({
    //           error: 'some of the esminiDats are failed to delete',
    //         })
    //       })
    //
    //       return res.status(200).send(trials)
    //     },
    //   },
  ],
  fields: [
    {
      name: 'batch',
      type: 'relationship',
      label: 'Batch',
      relationTo: 'batches',
      hasMany: false,
      required: true,
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
      name: 'parameters',
      type: 'array',
      label: 'Parameters',
      required: true,
      fields: [
        {
          name: 'parameterId',
          label: 'Parameter ID',
          type: 'text',
          required: true,
        },
        {
          name: 'value',
          label: 'Value',
          type: 'number',
          required: true,
        },
      ],
    },
    {
      name: 'events',
      type: 'array',
      fields: [
        {
          name: 'name',
          type: 'text',
          required: true,
        },
        {
          name: 'time',
          type: 'number',
          required: true,
        },
        {
          name: 'esminiSeconds',
          type: 'number',
          required: true,
        },
        {
          name: 'observationIndex',
          type: 'number',
          required: true,
        },
        {
          name: 'previewImage',
          type: 'relationship',
          relationTo: 'media',
          hasMany: false,
        },
      ],
    },
    {
      name: 'previewImage',
      type: 'relationship',
      relationTo: 'media',
      hasMany: false,
    },
    {
      name: 'testObjectives',
      type: 'group',
      fields: [
        {
          name: 'criticalityMetrics',
          type: 'array',
          required: true,
          fields: [
            {
              name: 'keyPerformanceIndicator',
              type: 'relationship',
              relationTo: 'keyPerformanceIndicators',
              hasMany: false,
              required: true,
            },
            {
              name: 'value',
              label: 'Value',
              type: 'number',
              // required: true,
            },
            {
              name: 'passed',
              label: 'Passed',
              type: 'checkbox',
              required: true,
            },
            {
              name: 'worstObservation',
              type: 'relationship',
              relationTo: 'observations',
              hasMany: false,
            },
            {
              name: 'worstObservationIndex',
              type: 'number',
            },
            {
              name: 'firstFailedObservationIndex',
              type: 'number',
            },
          ],
        },
        {
          name: 'referenceModels',
          type: 'array',
          fields: [
            {
              name: 'referenceModel',
              type: 'text',
            },
            {
              name: 'passed',
              label: 'Passed',
              type: 'checkbox',
              required: true,
            },
          ],
        },
      ],
    },
    {
      name: 'esminiDat',
      label: 'Esmini Dat',
      type: 'relationship',
      relationTo: 'esminiDats',
      hasMany: false,
      required: true,
    },
  ],
}
