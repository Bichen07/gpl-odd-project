import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";

const EsminiCsvs: CollectionConfig = {
  slug: "esminiCsvs",
  admin: {
    group: "Uploads",
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  endpoints: [
    {
      path: "/getFromIDs",
      method: "post",
      handler: async (req, res, _next) => {
        let promises = [];

        for (const id of req.body) {
          promises.push(
            req.payload.findByID({
              collection: "esminiCsvs",
              id,
              depth: 0,
            })
          );
          // promises.push(async () => {
          //   try {
          //     const result = await req.payload.findByID({
          //       collection: "esminiCsvs",
          //       id,
          //       depth: 0,
          //     });
          //     return result;
          //   } catch (error) {
          //     return id;
          //   }
          // });
        }

        let data = [];
        await Promise.all(promises).then((results) => {
          for (const result of results) {
            if (typeof result === "string") {
              console.log(result);
              continue;
            }
            data.push(result);
          }
        });

        return res.status(200).send(data);
      },
    },
  ],
  upload: {
    staticURL: "/esminiCsvs",
    staticDir: "/data/uploads/esminiCsv",
    mimeTypes: ["text/csv"],
  },
  fields: [],
};

export default EsminiCsvs;
