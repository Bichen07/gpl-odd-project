import { usersAccess } from '@/access'
import { CollectionConfig } from 'payload'

const EsminiDats: CollectionConfig = {
  slug: 'esminiDats',
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
    staticDir:
      process.env.NODE_ENV == 'production' ? '/data/uploads/esminiDat' : './uploads/esminiDat',
    mimeTypes: ['application/octet-stream'],
  },
  fields: [],
}

export default EsminiDats
