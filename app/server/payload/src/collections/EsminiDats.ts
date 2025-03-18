import { CollectionConfig } from "payload/types";

const EsminiDats: CollectionConfig = {
  slug: "esminiDats",
  access: {
    create: () => true,
    read: () => true,
    update: () => true,
    delete: () => true,
  },
  upload: {
    staticURL: "/esminiDats",
    staticDir: "/data/uploads/esminiDat",
    mimeTypes: ["application/octet-stream"],
  },
  fields: [],
};

export default EsminiDats;
