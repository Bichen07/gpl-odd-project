import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";
import _ from "lodash";

const Samplings: CollectionConfig = {
  slug: "samplings",
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    group: "Configs",
  },
  versions: {
    drafts: true,
  },
  fields: [
    {
      name: "steps",
      type: "array",
      fields: [
        {
          name: "method",
          label: "Method",
          type: "select",
          hasMany: false,
          options: [
            {
              value: "sobol",
              label: "Sobol",
            },
            {
              value: "uniform",
              label: "Uniform",
            },
            {
              value: "straddle",
              label: "Straddle",
            },
          ],
        },
        {
          name: "sampleSize",
          label: "Sample Size",
          type: "number",
          required: true,
          validate: async (val) => {
            return val === -1 || val > 0
              ? true
              : "Sampling size must be positive or -1 for unlimited samples.";
          },
        },
        {
          name: "parallelCounts",
          type: "number",
          required: true,
          validate: async (val, { sibilingData }) => {
            if (
              sibilingData &&
              sibilingData.method === "straddle" &&
              val === undefined
            ) {
              return "Cannot be empty for straddle generation method!";
            }
            return val > 0 ? true : "Value must be positive!";
          },
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined && sibilingData.method === "straddle"
              );
            },
          },
        },
        {
          name: "maxSurrogateTrainingSampleSize",
          label: "Max Surrogate Training Sample Size",
          type: "number",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined && sibilingData.method === "straddle"
              );
            },
          },
          validate: async (val, { sibilingData }) => {
            if (
              sibilingData &&
              sibilingData.method === "straddle" &&
              val === undefined
            ) {
              return "Cannot be empty for straddle generation method!";
            }
            return val > 0 ? true : "Value must be positive!";
          },
        },
        {
          name: "acquisitionSampleSize",
          label: "Acquisition Sample Size",
          type: "number",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined && sibilingData.method === "straddle"
              );
            },
          },
          validate: async (val, { sibilingData }) => {
            if (
              sibilingData &&
              sibilingData.method === "straddle" &&
              val === undefined
            ) {
              return "Cannot be empty for straddle generation method!";
            }
            return val > 0 ? true : "Value must be positive!";
          },
        },
        {
          name: "acquisitionExplorationFactor",
          label: "Acquisition Exploration Factor",
          type: "number",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined && sibilingData.method === "straddle"
              );
            },
          },
          validate: async (val, { sibilingData }) => {
            if (
              sibilingData &&
              sibilingData.method === "straddle" &&
              val === undefined
            ) {
              return "Cannot be empty for straddle generation method!";
            }
            return true;
          },
        },
      ],
    },
  ],
};

export default Samplings;
