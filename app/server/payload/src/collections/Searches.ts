import { CollectionConfig } from "payload/types";

const Searches: CollectionConfig = {
  slug: "searches",
  admin: {
    useAsTitle: "id",
  },
  access: {
    create: () => true,
    read: () => true,
    update: () => true,
    delete: () => true,
  },
  fields: [
    {
      name: "scenario",
      type: "relationship",
      label: "Scenario",
      relationTo: "scenarios",
      hasMany: false,
      required: true,
    },
    {
      name: "client",
      label: "Client",
      type: "relationship",
      relationTo: "clients",
      hasMany: false,
      required: true,
    },
    {
      name: "softwareVersion",
      label: "Software Version",
      type: "text",
      required: true,
    },
    {
      name: "machineAllocations",
      type: "array",
      label: "Machine Allocations",
      validate: async (val) => {
        if (val === undefined) {
          return true;
        }
        let counter = 0;
        for (const machine of val) {
          if (machine.role === "sampling") {
            counter += 1;
          }
          if (counter > 1) {
            return "There can only be one sampling server.";
          }
        }
        return val.length >= 2
          ? true
          : "There should be at least two machines. One is sampling server. One is simulation device.";
      },
      fields: [
        {
          name: "name",
          type: "text",
          label: "Name",
        },
        {
          name: "role",
          label: "Role",
          type: "select",
          hasMany: false,
          required: true,
          options: [
            {
              label: "Sampling",
              value: "sampling",
            },
            {
              label: "Simulation",
              value: "simulation",
            },
          ],
        },
        {
          name: "url",
          type: "text",
          label: "Connection URL",
          required: true,
        },
        {
          name: "parallel",
          type: "number",
          label: "Parallel",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined && sibilingData.role === "simulation"
              );
            },
          },
        },
      ],
    },
    {
      name: "parameterRanges",
      type: "array",
      label: "Parameter Ranges",
      required: true,
      fields: [
        {
          name: "parameterId",
          type: "text",
          label: "Parameter ID",
        },
        {
          name: "min",
          type: "number",
          label: "Range Min",
        },
        {
          name: "max",
          type: "number",
          label: "Range Max",
        },
      ],
    },
    {
      name: "parameterConstraints",
      type: "array",
      label: "Parameter Constraints",
      fields: [
        {
          name: "expression",
          type: "text",
          label: "Constraint Expression",
        },
      ],
    },
    {
      name: "samplingSteps",
      label: "Sampling Steps",
      type: "array",
      required: true,
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

export default Searches;
