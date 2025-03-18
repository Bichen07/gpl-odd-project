import path from "path";
import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";

const OpenScenarios: CollectionConfig = {
  slug: "openScenarios",
  admin: {
    group: "Uploads",
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  upload: {
    staticURL: "/xosc",
    staticDir: "/data/uploads/xosc",
    mimeTypes: ["application/octet-stream"],
  },
  fields: [],
};

export default OpenScenarios;
