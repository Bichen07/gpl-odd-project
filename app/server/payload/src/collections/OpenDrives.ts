import path from "path";
import { CollectionConfig } from "payload/types";

const OpenDrives: CollectionConfig = {
  slug: "openDrives",
  access: {
    create: () => true,
    read: () => true,
    update: () => true,
    delete: () => true,
  },
  upload: {
    staticURL: "/xodr",
    staticDir: "/data/uploads/xodr",
    mimeTypes: ["application/octet-stream"],
  },
  fields: [],
};

export default OpenDrives;
