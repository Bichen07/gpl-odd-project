import { CollectionConfig } from 'payload'
import { usersAccess } from '../access'

export const Egos: CollectionConfig = {
  slug: 'egos',
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
  fields: [
    {
      type: 'text',
      name: 'name',
      required: true,
    },
  ],
}
