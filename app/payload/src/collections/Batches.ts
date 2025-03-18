import { CollectionConfig } from "payload/types";
import { usersAccess } from "../access";
import { StatusUpdate } from "./handlers/batchHandlers";

// A batch is a collections of trials, which means concrete scenarios of a logical scenario

const Batches: CollectionConfig = {
  slug: "batches",
  admin: {
    useAsTitle: "id",
    group: "Simulation",
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  endpoints: [
    {
      path: "/:id/status",
      method: "get",
      handler: async (req, res) => {
        try {
          const batch = await req.payload.findByID({
            collection: "batches",
            id: req.params.id,
          });
          if (!batch) {
            return res.status(404).send({ message: "Batch not found" });
          }
          const requiredNumberOfTrials = batch.requiredNumberOfTrials;
          const actualNumberOfTrials = (batch.trials as any[])?.length ?? 0;
          return res.send({
            status: batch.status,
            required: requiredNumberOfTrials,
            actual: actualNumberOfTrials,
          });
        } catch (error) {
          console.log(error);
          return res.status(400).send(error);
        }
      },
    },
  ],
  hooks: {
    afterChange: [
      async ({ req, doc, previousDoc, operation }): Promise<void> => {
        await StatusUpdate(req, doc, previousDoc, operation);
      },
    ],
  },
  fields: [
    {
      name: "scenario",
      type: "relationship",
      label: "Scenario",
      relationTo: "scenarios",
      hasMany: false,
      required: true,
      // admin: { readOnly: true },
    },
    {
      name: "session",
      type: "relationship",
      label: "Session",
      relationTo: "sessions",
      hasMany: false,
      required: true,
      // admin: { readOnly: true },
    },
    {
      name: "samplingServiceUrl",
      type: "text",
    },
    {
      name: "sampling",
      type: "relationship",
      relationTo: "samplings",
      hasMany: false,
    },
    {
      name: "trials",
      type: "relationship",
      label: "Trials",
      relationTo: "trials",
      hasMany: true,
      required: false,
      // admin: { readOnly: true },
    },
    {
      name: "requiredNumberOfTrials",
      type: "number",
      label: "Required number of trials",
      defaultValue: 5000,
      required: true,
      // admin: { readOnly: true },
    },
    {
      name: "status",
      type: "select",
      label: "Status",
      options: [
        { label: "Pending", value: "pending" },
        { label: "Running", value: "running" },
        { label: "Discarded", value: "discarded" },
        { label: "Completed", value: "completed" },
      ],
      defaultValue: "pending",
    },
  ],
};

export default Batches;
