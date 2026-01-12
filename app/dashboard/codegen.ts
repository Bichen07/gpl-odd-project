import { CodegenConfig } from "@graphql-codegen/cli";
import "./envConfig.ts";

const config: CodegenConfig = {
  schema: process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS + "/api/graphql",
  documents: ["src/**/*.{ts,tsx}"],
  generates: {
    "./src/app/_shared/graphql/__generated__/": {
      preset: "client",
      plugins: [],
      presetConfig: {
        gqlTagName: "gql",
      },
      config: {
        avoidOptionals: true,
      },
    },
  },
  ignoreNoDocuments: true,
};

export default config;
