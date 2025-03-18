import path from "path";

import { payloadCloud } from "@payloadcms/plugin-cloud";
import { mongooseAdapter } from "@payloadcms/db-mongodb";
import { webpackBundler } from "@payloadcms/bundler-webpack";
import { slateEditor } from "@payloadcms/richtext-slate";
import { buildConfig } from "payload/config";

import Users from "./collections/Users";
import OpenScenarios from "./collections/OpenScenarios";
import OpenDrives from "./collections/OpenDrives";
import Scenarios from "./collections/Scenarios";
import Media from "./collections/Media";
import CriticalityMetrics from "./collections/CriticalityMetrics";
import Searches from "./collections/Searches";
import Trials from "./collections/Trials";
import Observations from "./collections/Observations";
import EsminiDats from "./collections/EsminiDats";
import Clients from "./collections/Clients";
import { analysisEndpoints } from "./endpoints/analysis";

export default buildConfig({
  serverURL: process.env.SERVER_URL,
  cors: "*",
  admin: {
    user: Users.slug,
    bundler: webpackBundler(),
  },
  editor: slateEditor({}),
  collections: [
    Users,
    Scenarios,
    Searches,
    Trials,
    Observations,
    CriticalityMetrics,
    Media,
    OpenScenarios,
    OpenDrives,
    EsminiDats,
    Clients,
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
  endpoints: [...analysisEndpoints],
});
