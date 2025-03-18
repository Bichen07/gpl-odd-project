import path from "path";
import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";
import { ComboField } from "@nouance/payload-better-fields-plugin";

const SemanticMap: CollectionConfig = {
  slug: "semanticMap",
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    group: "Client Configs - ITRI",
  },
  fields: [
    ...ComboField(
      {
        name: "id",
        label: "Map ID",
        admin: { readOnly: true },
      },
      ["mapFormat", "alias", "version"],
      {
        separator: "-",
        initial: "",
        callback: (field) => field.toLowerCase().replace(/[^a-z0-9\.]/g, "_"),
      }
    ),
    {
      name: "mapFormat",
      type: "select",
      label: "Map Format",
      required: true,
      options: ["ITRI", "xodr", "osm"],
      access: {
        update: () => false,
      },
    },
    {
      name: "alias",
      type: "text",
      label: "Alias",
      required: true,
      access: {
        update: () => false,
      },
    },
    {
      name: "version",
      type: "text",
      label: "Version",
      defaultValue: "1.0",
      access: {
        update: () => false,
      },
    },
    {
      name: "notes",
      type: "textarea",
    },
    {
      name: "identicalTo",
      type: "relationship",
      relationTo: "semanticMap",
      hasMany: true,
    },
    {
      name: "mapFile",
      type: "upload",
      relationTo: "openDrives",
      admin: {
        condition: (_, siblingData) => siblingData.mapFormat === "xodr",
      },
      access: {
        update: () => false,
      },
    },
  ],
};

export default SemanticMap;
