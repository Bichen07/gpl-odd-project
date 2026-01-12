import { CollectionConfig } from 'payload'
import { usersAccess } from '../access'

export const Documents: CollectionConfig = {
  slug: 'documents',
  admin: {
    group: 'Uploads',
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  upload: {
    staticDir:
      process.env.NODE_ENV == 'production' ? '/data/uploads/documents' : './uploads/documents',
    mimeTypes: [
      'text/csv',
      'text/plain',
      'application/json',
      'application/octet-stream',
      'application/zip',
      'application/xml',
      'image/png',
      'image/jpeg',
      'application/x-zip-compressed',
    ],
  },
  fields: [],
}
