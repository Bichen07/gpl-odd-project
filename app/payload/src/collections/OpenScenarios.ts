import { usersAccess } from '@/access'
import { CollectionConfig } from 'payload'

export const OpenScenarios: CollectionConfig = {
  slug: 'openScenarios',
  admin: {
    group: 'Uploads',
  },
  access: {
    read: () => true,
    create: usersAccess,
    update: usersAccess,
    delete: usersAccess,
  },
  upload: {
    staticDir: process.env.NODE_ENV == 'production' ? '/data/uploads/xosc' : './uploads/xosc',
    mimeTypes: ['application/octet-stream', 'application/xml'],
  },
  fields: [],
}
