import { CollectionConfig } from "payload/types";
import { adminFieldAccess, usersAccess } from "../access";
import ScenarioFilterPreviewField from "../fields/ScenarioFilterPreview";
import tagTreeField from "../fields/TagTrees";
import { CreateBatchesAfterDecidingFilters } from "./handlers/sessionHandlers";
import { DeleteBatchesAfterSessionDeleted } from "./handlers/sessionHandlers";
import { ComboField } from "@nouance/payload-better-fields-plugin";

// A batch is a collections of trials, which means concrete scenarios of a logical scenario

const Sessions: CollectionConfig = {
  slug: "sessions",
  admin: {
    useAsTitle: "id",
    group: "Configs",
  },
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  versions: {
    drafts: true,
  },
  endpoints: [
    {
      path: "/:id/next_batch",
      method: "get",
      handler: async (req, res) => {
        try {
          // /[session_id]/get_next_batch
          const { depth } = req.query;
          const id = req.params.id;
          const currSession = await req.payload.findByID({
            collection: "sessions",
            id,
          });
          if (!currSession) {
            console.log("Session not found");
            return res.status(404).send({ message: "Session not found" });
          }
          const runningBatches = currSession.batches.running ?? [];
          const pendingBatches = currSession.batches.pending ?? [];
          console.log("Running batches: ", runningBatches.length);
          console.log("Pending batches: ", pendingBatches.length);
          for (const batch of runningBatches) {
            console.log("batch: ", batch);
            console.log("type of batch: ", typeof batch);
            if (
              typeof batch !== "string" &&
              batch.trials.length < batch.requiredNumberOfTrials
            ) {
              return res.status(200).send(batch);
            }
          }
          // Get batch from pending
          if (pendingBatches.length === 0) {
            return res
              .status(204)
              .send({ message: "Almost Done. No more batch to run." });
          }
          return res.status(200).send(pendingBatches[0]);
        } catch (error) {
          return res.status(400).send(error);
        }
      },
    },
  ],
  hooks: {
    afterDelete: [
      async ({ req, doc }): Promise<void> => {
        await DeleteBatchesAfterSessionDeleted(req, doc);
      },
    ],
    afterChange: [
      async ({ context, req, doc, operation }): Promise<void> => {
        await CreateBatchesAfterDecidingFilters(context, req, doc, operation);
      },
    ],
  },
  fields: [
    ...ComboField(
      {
        name: "id",
        label: "Session ID",
        admin: { readOnly: true },
      },
      ["client", "name", "vehicle"],
      {
        initial:
          new Date()
            .toISOString()
            .replace(/[-:]/g, "-")
            .replace("T", "-")
            .split(".")[0] + "-",
        separator: "-",
        callback: (field) =>
          field
            .toLowerCase()
            .replace(/[^a-z0-9]/g, " ")
            .replace(/\s+/g, "-"),
      }
    ),
    {
      name: "name",
      type: "text",
      label: "Session Name",
      hasMany: false,
    },
    {
      name: "client",
      type: "relationship",
      label: "Client",
      relationTo: "clients",
      hasMany: false,
    },
    {
      name: "vehicle",
      type: "relationship",
      label: "Vehicle",
      relationTo: "vehicles",
    },
    {
      name: "startDate",
      type: "date",
      label: "Start Date",
    },
    {
      name: "endDate",
      type: "date",
      label: "End Date",
    },
    {
      name: "variancePerBatch",
      type: "number",
      label: "Variance Per Batch",
      defaultValue: 5000,
    },
    {
      name: "savedClustering",
      type: "relationship",
      relationTo: "documents",
      hasMany: true,
    },
    {
      name: "savedTrajectoryAnalysis",
      type: "relationship",
      relationTo: "documents",
      hasMany: true,
    },
    {
      name: "savedStateAnalysis",
      type: "relationship",
      relationTo: "documents",
      hasMany: true,
    },
    {
      name: "filter",
      type: "group",
      fields: [
        ScenarioFilterPreviewField,
        {
          name: "tags",
          type: "group",
          fields: [
            {
              name: "interested",
              type: "relationship",
              relationTo: "tags",
              hasMany: true,
              label: "Interested",
            },
            {
              name: "required",
              type: "relationship",
              relationTo: "tags",
              hasMany: true,
              label: "Required",
            },
            {
              name: "unwanted",
              type: "relationship",
              relationTo: "tags",
              hasMany: true,
              label: "Unwanted",
            },
          ],
        },
        {
          name: "tagTrees",
          type: "group",
          fields: [
            {
              name: "interested",
              type: "array",
              label: "Interested",
              fields: [tagTreeField],
            },
            {
              name: "required",
              type: "array",
              label: "Required",
              fields: [tagTreeField],
            },
            {
              name: "unwanted",
              type: "array",
              label: "Unwanted",
              fields: [tagTreeField],
            },
          ],
        },
      ],
    },
    {
      name: "batches",
      type: "group",
      label: "Batches",
      fields: [
        {
          name: "pending",
          type: "relationship",
          relationTo: "batches",
          hasMany: true,
          label: "Pending",
          // admin: { readOnly: true },
          // access: {
          //   update: () => false,
          // },
        },
        {
          name: "running",
          type: "relationship",
          relationTo: "batches",
          hasMany: true,
          label: "Running",
          // admin: { readOnly: true },
          // access: {
          //   update: () => false,
          // },
        },
        {
          name: "completed",
          type: "relationship",
          relationTo: "batches",
          hasMany: true,
          label: "Completed",
          // admin: { readOnly: true },
          // access: {
          //   update: () => false,
          // },
        },
        {
          name: "discarded",
          type: "relationship",
          relationTo: "batches",
          hasMany: true,
          label: "Discarded",
          // admin: { readOnly: true },
          // access: {
          //   update: () => false,
          // },
        },
      ],
    },
    {
      name: "createdBy",
      label: "Created By",
      type: "text",
      hasMany: false,
      access: {
        read: () => true,
        create: adminFieldAccess,
        update: adminFieldAccess,
      },
      admin: {
        width: "50%",
      },
      hooks: {
        beforeChange: [
          async ({ data, req, operation }) => {
            if (operation === "create") {
              data = req.user.name;
              return data;
            }
          },
        ],
      },
    },
  ],
};

export default Sessions;
