import { describe, expect, it } from 'vitest'
import { Trials } from '@/collections/Trials'

type NamedField = {
  name?: string
  type?: string
  required?: boolean
  fields?: Array<NamedField>
}

function field(name: string): NamedField | undefined {
  return (Trials.fields as unknown as NamedField[]).find((candidate) => candidate.name === name)
}

describe('Trial Phase A schemas', () => {
  it('requires an observation-linked event with provenance', () => {
    const events = field('events')
    expect(events?.type).toBe('array')
    const fields = events?.fields ?? []
    expect(fields.find((item) => item.name === 'observation')?.required).toBe(true)
    expect(fields.find((item) => item.name === 'source')?.required).toBe(true)
    expect(fields.find((item) => item.name === 'timeStatus')?.required).toBe(true)
  })

  it('publishes a compact snapshot and capability-card provenance fields', () => {
    expect(field('capabilitySnapshot')?.type).toBe('group')
    expect(field('analysisArtifacts')?.type).toBe('group')
    const artifactFields = field('analysisArtifacts')?.fields ?? []
    expect(artifactFields.find((item) => item.name === 'capabilityCardPath')?.type).toBe('text')
    expect(artifactFields.find((item) => item.name === 'capabilityCardSha256')?.type).toBe('text')
  })
})
