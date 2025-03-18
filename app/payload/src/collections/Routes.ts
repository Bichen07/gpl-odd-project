import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";

const Routes: CollectionConfig = {
  slug: "routes",
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    useAsTitle: "name",
    group: "Client Configs - ITRI",
  },
  fields: [
    {
      name: "name",
      type: "relationship",
      label: "Map Name",
      required: true,
      relationTo: "semanticMap",
      access: {
        update: () => false,
      },
    },
    {
      name: "routeConfigs",
      type: "array",
      label: "Route Configs",
      fields: [
        {
          name: "routeName",
          type: "text",
          label: "Route Name",
          required: true,
        },
        {
          name: "routeFormat",
          type: "select",
          label: "Route Format",
          options: ["ITRI", "other"],
        },
        {
          name: "lanes",
          type: "text",
          label: "lanes",
          defaultValue: " ",
          admin: {
            condition: (_, siblingData) => siblingData.routeFormat === "ITRI",
          },
          hooks: {
            beforeValidate: [({ value }) => value.trim()],
          },
        },
        {
          name: "navgcroad",
          type: "text",
          label: "navgcroad",
          required: true,
          admin: {
            condition: (_, siblingData) => siblingData.routeFormat === "ITRI",
          },
        },
      ],
    },
  ],
};

export default Routes;
function getUrl(arg0: string): string {
  throw new Error("Function not implemented.");
}
