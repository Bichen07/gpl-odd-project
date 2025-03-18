import { CollectionConfig } from "payload/types";
import { usersAccess, adminFieldAccess } from "../access";
import { ComboField } from "@nouance/payload-better-fields-plugin";

const Tags: CollectionConfig = {
  slug: "tags",
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    useAsTitle: "id",
    group: "Configs",
  },
  hooks: {
    beforeChange: [
      async ({ data }) => {
        data.name = data.id;
        return data;
      },
    ],
  },
  fields: [
    ...ComboField(
      {
        name: "id",
        label: "Tag ID",
        admin: { readOnly: true },
      },
      ["name"],
      {
        initial: "",
        separator: "",
        callback: (field) =>
          field
            .toLowerCase()
            .replace(/[^a-z0-9:]/g, " ")
            .replace(/\s+/g, "-"),
      }
    ),
    {
      name: "name",
      type: "text",
      label: "Tag Name",
      required: true,
      access: {
        update: () => false,
      },
    },
    {
      name: "description",
      type: "textarea",
      label: "Description",
    },
    {
      name: "createdBy",
      label: "Created By",
      type: "text",
      hasMany: false,
      access: {
        read: () => true,
        create: adminFieldAccess,
        update: adminFieldAccess,
      },
      admin: {
        width: "50%",
      },
      hooks: {
        beforeChange: [
          async ({ data, req, operation }) => {
            if (operation === "create") {
              data = req.user.name;
              return data;
            }
          },
        ],
      },
    },
  ],
};

export default Tags;
