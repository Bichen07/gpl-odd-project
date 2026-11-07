import { getPayload, Payload } from 'payload'
import config from '@/payload.config'

import { describe, it, beforeAll, afterAll, expect } from 'vitest'

let payload: Payload
let phaseATrialId: number | string | undefined
let phaseAObservationId: number | string | undefined

describe('API', () => {
  beforeAll(async () => {
    const payloadConfig = await config
    payload = await getPayload({ config: payloadConfig })
  })

  it('fetches users', async () => {
    const users = await payload.find({
      collection: 'users',
    })
    expect(users).toBeDefined()
  })

  it('persists a recorded event relationship and canonical capability artifact', async () => {
    // Payload relationship values are deliberately minimal: this verifies the
    // Trial/Observation event round trip, not scenario configuration validity.
    const trial = await payload.create({
      collection: 'trials',
      data: {
        batch: 1,
        ego: 1,
        parameters: [{ parameterId: 'phase-a-fixture', value: 1 }],
        testObjectives: {
          criticalityMetrics: [{ keyPerformanceIndicator: 1, passed: true }],
        },
        esminiDat: 1,
      },
      depth: 0,
    })
    phaseATrialId = trial.id
    const observation = await payload.create({
      collection: 'observations',
      data: {
        trial: trial.id,
        ego: 1,
        time: 12.5,
        esminiSeconds: 4.25,
      },
      depth: 0,
    })
    phaseAObservationId = observation.id

    const updated = await payload.update({
      collection: 'trials',
      id: trial.id,
      data: {
        events: [
          {
            name: 'collisionWithFixture',
            time: 12.5,
            esminiSeconds: 4.25,
            observationIndex: 0,
            observation: observation.id,
            source: 'sampler_collision_callback',
            timeStatus: 'recorded',
          },
        ],
        analysisArtifacts: {
          capabilityCardPath: 'results/phase-a/processed/capability.yaml',
          capabilityCardSha256: 'a'.repeat(64),
        },
      },
      depth: 0,
    })

    expect(updated.events).toHaveLength(1)
    expect(updated.events?.[0]?.observation).toBe(observation.id)
    expect(updated.events?.[0]?.timeStatus).toBe('recorded')
    expect(updated.analysisArtifacts?.capabilityCardPath).toContain('capability.yaml')
    expect(updated.analysisArtifacts?.capabilityCardSha256).toHaveLength(64)
  })

  afterAll(async () => {
    if (phaseATrialId !== undefined) {
      await payload.delete({ collection: 'trials', id: phaseATrialId, depth: 0 })
    }
    if (phaseAObservationId !== undefined) {
      await payload.delete({ collection: 'observations', id: phaseAObservationId, depth: 0 })
    }
  })
})
