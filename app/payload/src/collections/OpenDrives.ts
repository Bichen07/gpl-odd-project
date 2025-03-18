import path from "path";
import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";

const OpenDrives: CollectionConfig = {
  slug: "openDrives",
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
    staticURL: "/xodr",
    staticDir: "/data/uploads/xodr",
    mimeTypes: ["application/octet-stream"],
  },
  fields: [],
};

export default OpenDrives;
