import path from "path";
import { CollectionConfig } from "payload/types";

const OpenScenarios: CollectionConfig = {
  slug: "openScenarios",
  access: {
    create: () => true,
    read: () => true,
    update: () => true,
    delete: () => true,
  },
  upload: {
    staticURL: "/xosc",
    staticDir: "/data/uploads/xosc",
    mimeTypes: ["application/octet-stream"],
  },
  fields: [],
};

export default OpenScenarios;
