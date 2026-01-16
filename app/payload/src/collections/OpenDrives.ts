import { usersAccess } from '@/access'
import { CollectionConfig } from 'payload'

export const OpenDrives: CollectionConfig = {
  slug: 'openDrives',
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
    staticDir: process.env.NODE_ENV == 'production' ? '/data/uploads/xodr' : './uploads/xodr',
    mimeTypes: ['application/octet-stream', 'application/xml'],
  },
  fields: [],
}
