import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";

const EsminiCsvs: CollectionConfig = {
  slug: "documents",
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
    staticURL: "/Documents",
    staticDir: "/data/uploads/documents",
    mimeTypes: ["text/csv", "application/json", "application/octet-stream"],
  },
  fields: [],
};

export default EsminiCsvs;
