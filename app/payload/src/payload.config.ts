// storage-adapter-import-placeholder
import { postgresAdapter } from '@payloadcms/db-postgres'
import { payloadCloudPlugin } from '@payloadcms/payload-cloud'
import { lexicalEditor } from '@payloadcms/richtext-lexical'
import path from 'path'
import { buildConfig, PayloadRequest } from 'payload'
import { fileURLToPath } from 'url'
import sharp from 'sharp'

import { Users } from './collections/Users'
import { Media } from './collections/Media'
import { Observations } from './collections/Observations'
import { Trials } from './collections/Trials'
import EsminiDats from './collections/EsminiDats'
import { OpenDrives } from './collections/OpenDrives'
import { OpenScenarios } from './collections/OpenScenarios'
import Samplings from './collections/Samplings'
import Scenarios from './collections/Scenarios'
import Batches from './collections/Batches'
import Sessions from './collections/Sessions'
import { KeyPerformanceIndicators } from './collections/KeyPerformanceIndicator'
import { Documents } from './collections/Documents'
import { Egos } from './collections/Egos'
import { heatmapOrdering } from './endpoints/heatmapOrdering'

const filename = fileURLToPath(import.meta.url)
const dirname = path.dirname(filename)

export default buildConfig({
  serverURL: process.env.PAYLOAD_PUBLIC_SERVER_URL,
  cors: [
    process.env.PAYLOAD_PUBLIC_SERVER_URL,
    process.env.PAYLOAD_CLIENT_URL,
    'http://localhost:9099',
    'http://localhost:3000',
    'https://gpl-odd-dashboard.chiu41.com',
  ].filter((url) => url !== null && url !== undefined),
  admin: {
    user: Users.slug,
    importMap: {
      baseDir: path.resolve(dirname),
    },
  },
  collections: [
    Users,
    Media,
    Observations,
    Trials,
    EsminiDats,
    OpenDrives,
    OpenScenarios,
    Samplings,
    Scenarios,
    Batches,
    Sessions,
    KeyPerformanceIndicators,
    Documents,
    Egos,
  ],
  endpoints: [heatmapOrdering],
  editor: lexicalEditor(),
  secret: process.env.PAYLOAD_SECRET || '',
  typescript: {
    outputFile: path.resolve(dirname, 'payload-types.ts'),
  },
  graphQL: {
    disableIntrospectionInProduction: false,
  },
  db: postgresAdapter({
    pool: {
      connectionString: process.env.DATABASE_URI || '',
    },
  }),
  sharp,
  plugins: [
    payloadCloudPlugin(),
    // storage-adapter-placeholder
  ],
})
