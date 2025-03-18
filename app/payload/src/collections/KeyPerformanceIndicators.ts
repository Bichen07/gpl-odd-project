import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";

const KeyPerformanceIndicators: CollectionConfig = {
  slug: "keyPerformanceIndicators",
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    useAsTitle: "name",
    group: "Configs",
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

export default KeyPerformanceIndicators;
