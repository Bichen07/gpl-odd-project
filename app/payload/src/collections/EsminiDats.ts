import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";

const EsminiDats: CollectionConfig = {
  slug: "esminiDats",
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
    staticURL: "/esminiDats",
    staticDir: "/data/uploads/esminiDat",
    mimeTypes: ["application/octet-stream"],
  },
  fields: [],
};

export default EsminiDats;
