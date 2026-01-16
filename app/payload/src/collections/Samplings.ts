import { CollectionConfig, FieldAccess } from 'payload'
import { usersAccess } from '../access'

const Samplings: CollectionConfig = {
  slug: 'samplings',
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    group: 'Configs',
  },
  versions: {
    drafts: true,
  },
  fields: [
    {
      name: 'steps',
      type: 'array',
      fields: [
        {
          name: 'method',
          label: 'Method',
          type: 'select',
          hasMany: false,
          options: [
            { value: 'sobol', label: 'Sobol' },
            { value: 'uniform', label: 'Uniform' },
            { value: 'straddle', label: 'Straddle' },
          ],
        },
        {
          name: 'sampleSize',
          label: 'Sample Size',
          type: 'number',
          required: true,
        },
        {
          name: 'parallelCounts',
          label: 'Parallel Counts',
          type: 'number',
          required: true,
          admin: {
            condition: (_data, siblingData) => siblingData?.method === 'straddle',
          },
        },
        {
          name: 'maxSurrogateTrainingSampleSize',
          label: 'Max Surrogate Training Sample Size',
          type: 'number',
          admin: {
            condition: (_data, siblingData) => siblingData?.method === 'straddle',
          },
        },
        {
          name: 'acquisitionSampleSize',
          label: 'Acquisition Sample Size',
          type: 'number',
          admin: {
            condition: (_data, siblingData) => siblingData?.method === 'straddle',
          },
        },
        {
          name: 'acquisitionExplorationFactor',
          label: 'Acquisition Exploration Factor',
          type: 'number',
          admin: {
            condition: (_data, siblingData) => siblingData?.method === 'straddle',
          },
        },
      ],
    },
  ],
}

export default Samplings
