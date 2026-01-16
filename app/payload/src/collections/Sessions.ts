import { CollectionConfig } from 'payload'
import { usersAccess } from '../access'

const Sessions: CollectionConfig = {
  slug: 'sessions',
  admin: {
    useAsTitle: 'name',
    group: 'Configs',
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  versions: {
    drafts: true,
  },
  fields: [
    {
      name: 'name',
      type: 'text',
      label: 'Session Name',
      hasMany: false,
    },
  ],
}

export default Sessions
