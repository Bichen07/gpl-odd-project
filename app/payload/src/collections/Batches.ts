import { CollectionConfig } from 'payload'
import { usersAccess } from '../access'

// A batch is a collections of trials, which means concrete scenarios of a logical scenario

const Batches: CollectionConfig = {
  slug: 'batches',
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
  fields: [
    {
      name: 'scenario',
      type: 'relationship',
      label: 'Scenario',
      relationTo: 'scenarios',
      hasMany: false,
      required: true,
    },
    {
      name: 'egos',
      type: 'relationship',
      relationTo: 'egos',
      hasMany: true,
    },
    {
      name: 'session',
      type: 'relationship',
      label: 'Session',
      relationTo: 'sessions',
      hasMany: false,
      required: true,
    },
    {
      name: 'sampling',
      type: 'relationship',
      relationTo: 'samplings',
      hasMany: false,
    },
    {
      name: 'savedTrajectoryAnalysis',
      type: 'relationship',
      relationTo: 'documents',
      hasMany: true,
    },
    {
      name: 'images',
      type: 'relationship',
      relationTo: 'documents',
      hasMany: true,
    },
    {
      name: 'requiredNumberOfTrials',
      type: 'number',
      label: 'Required number of trials',
      defaultValue: 5000,
      required: true,
      // admin: { readOnly: true },
    },
  ],
}

export default Batches
