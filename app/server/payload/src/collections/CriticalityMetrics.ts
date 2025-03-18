import { CollectionConfig } from "payload/types";

const CriticalityMetrics: CollectionConfig = {
  slug: "criticalityMetrics",
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
      required: true,
    },
    {
      name: "unit",
      type: "text",
      label: "Unit",
      required: true,
    },
    {
      name: "rule",
      type: "select",
      label: "Rule",
      required: true,
      options: [
        {
          label: "Greater Than",
          value: "greaterThan",
        },
        {
          label: "Less Than",
          value: "lessThan",
        },
      ],
    },
    {
      name: "description",
      type: "textarea",
      label: "Description",
    },
  ],
};

export default CriticalityMetrics;
