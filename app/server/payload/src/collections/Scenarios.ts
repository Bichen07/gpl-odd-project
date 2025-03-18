import { CollectionConfig } from "payload/types";

const Scenarios: CollectionConfig = {
  slug: "scenarios",
  access: {
    create: () => true,
    read: () => true,
    update: () => true,
    delete: () => true,
  },
  admin: {
    useAsTitle: "name",
  },
  fields: [
    {
      name: "name",
      type: "text",
      label: "Name",
    },
    {
      name: "clients",
      label: "Clients",
      type: "relationship",
      relationTo: "clients",
      hasMany: true,
    },
    {
      name: "semanticMap",
      type: "select",
      label: "Semantic Map",
      required: true,
      options: [
        {
          value: "hct_logistic",
          label: "HCT Logistic",
        },
        {
          value: "alks_straight",
          label: "ALKS Straight",
        },
        {
          value: "III_itri",
          label: "III ITRI",
        },
      ],
    },
    {
      name: "egoRoute",
      type: "text",
      label: "Ego Route",
      required: true,
      admin: {
        description: "Filename of the route in the sematic_map folder.",
        width: "50%",
      },
    },
    {
      name: "egoInitialPose",
      type: "group",
      label: "Ego Initial Pose",
      fields: [
        {
          name: "x",
          type: "number",
          label: "x",
          required: true,
        },
        {
          name: "y",
          type: "number",
          label: "y",
          required: true,
        },
        {
          name: "yaw",
          type: "number",
          label: "Yaw (Degrees)",
          required: true,
        },
      ],
    },
    {
      name: "openScenario",
      type: "upload",
      label: "OpenSCENARIO",
      relationTo: "openScenarios",
      required: true,
    },
    {
      name: "openDrive",
      type: "upload",
      label: "OpenDRIVE",
      relationTo: "openDrives",
      required: true,
    },
    {
      name: "description",
      type: "textarea",
      label: "Description",
    },
    {
      name: "schematic",
      type: "upload",
      label: "Schematic",
      relationTo: "media",
    },
    {
      name: "parameters",
      type: "array",
      label: "Parameters",
      required: true,
      admin: {
        description:
          "IMPORTANT! Parameters must be declared and selected from the OpenSCENARIO.",
        width: "50%",
      },
      fields: [
        {
          name: "name",
          type: "text",
          label: "Name",
          required: true,
        },
        {
          name: "unit",
          type: "text",
          label: "Unit",
          required: true,
        },
        {
          name: "description",
          type: "text",
          label: "Description",
        },
      ],
    },
    {
      name: "safetyRequirements",
      label: "Safety Requirements",
      type: "array",
      required: true,
      fields: [
        {
          name: "criticalityMetric",
          type: "relationship",
          label: "Criticality Metric",
          relationTo: "criticalityMetrics",
          hasMany: false,
          required: true,
        },
        {
          name: "threshold",
          type: "number",
          label: "Threshold",
          required: true,
        },
      ],
    },
    {
      name: "validConditions",
      type: "array",
      label: "Valid Conditions",
      admin: {
        description:
          "The conditions specified in the OpenSCENARIO that must be triggered to deem a valid trial. If left empty, every trial is considered valid.",
        width: "50%",
      },
      fields: [
        {
          name: "condition",
          type: "text",
          label: "Condition",
        },
      ],
    },
    {
      name: "startObservationSamplingConditions",
      type: "array",
      label: "Start Observation Sampling Conditions",
      admin: {
        description:
          "The conditions specified in the OpenSCENARIO that must be triggered to start observation sampling. If left empty, observation sampling will start in the beginning.",
        width: "50%",
      },
      fields: [
        {
          name: "condition",
          type: "text",
          label: "Condition",
        },
      ],
    },
    {
      name: "observationRecordingAgents",
      type: "array",
      label: "Observation Recording Agents",
      admin: {
        description:
          "Agents which their names specified in the OpenSCENARIO that we need to tracking its observations.",
        width: "50%",
      },
      fields: [
        {
          name: "name",
          type: "text",
          label: "Name",
        },
      ],
    },
  ],
};

export default Scenarios;
