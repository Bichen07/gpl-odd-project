import path from "path";

import { payloadCloud } from "@payloadcms/plugin-cloud";
import { mongooseAdapter } from "@payloadcms/db-mongodb";
import { webpackBundler } from "@payloadcms/bundler-webpack";
import { slateEditor } from "@payloadcms/richtext-slate";
import { buildConfig } from "payload/config";

import Clients from "./collections/Clients";
import KeyPerformanceIndicators from "./collections/KeyPerformanceIndicators";
import EsminiDats from "./collections/EsminiDats";
import Media from "./collections/Media";
import Observations from "./collections/Observations";
import OpenScenarios from "./collections/OpenScenarios";
import OpenDrives from "./collections/OpenDrives";
import Routes from "./collections/Routes";
import Scenarios from "./collections/Scenarios";
import SemanticMap from "./collections/SemanticMap";
import Trials from "./collections/Trials";
import Users from "./collections/Users";
import Vehicles from "./collections/Vehicles";
import Batches from "./collections/Batches";
import Sessions from "./collections/Sessions";
import Tags from "./collections/Tags";
import Samplings from "./collections/Samplings";
import EsminiCsvs from "./collections/EsminiCsvs";
import Documents from "./collections/Documents";
import { trajectories } from "./endpoints/trajectory";
import { collisionTrajectories } from "./endpoints/collisionTrajectories";
import { cluster } from "./endpoints/analysis";

export default buildConfig({
  serverURL: process.env.SERVER_URL,
  cors: "*",
  admin: {
    user: Users.slug,
    bundler: webpackBundler(),
  },
  rateLimit: {
    window: 1 * 1000,
    max: 100000,
  },
  editor: slateEditor({}),
  endpoints: [cluster, trajectories, collisionTrajectories],
  collections: [
    Users,
    Batches,
    Trials,
    Observations,
    Clients,
    Vehicles,
    KeyPerformanceIndicators,
    Scenarios,
    Samplings,
    SemanticMap,
    Routes,
    OpenScenarios,
    OpenDrives,
    EsminiDats,
    Media,
    EsminiCsvs,
    Documents,
    Tags,
    Sessions,
  ],
  typescript: {
    outputFile: path.resolve(__dirname, "payload-types.ts"),
  },
  graphQL: {
    schemaOutputFile: path.resolve(__dirname, "generated-schema.graphql"),
  },
  plugins: [payloadCloud()],
  db: mongooseAdapter({
    url: process.env.DATABASE_URI,
  }),
  express: {
    json: {
      limit: 5000000000,
    },
  },
});
