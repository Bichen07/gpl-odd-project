import { BulkOperationResult } from "payload/dist/collections/config/types";
import { EsminiDat } from "payload/generated-types";
import { CollectionConfig } from "payload/types";

const Trials: CollectionConfig = {
  slug: "trials",
  admin: {
    useAsTitle: "id",
  },
  access: {
    create: () => true,
    read: () => true,
    update: () => true,
    delete: () => true,
  },
  endpoints: [
    {
      path: "/delete",
      method: "delete",
      handler: async (req, res, next) => {
        const trials = await req.payload.delete({
          collection: "trials",
          where: req.body["where"],
          depth: 0,
        });

        let promisesObservations: Promise<
          BulkOperationResult<"observations">
        >[] = [];
        let promisesEsminiDats: Promise<EsminiDat>[] = [];
        for (const trial of trials.docs) {
          promisesObservations.push(
            req.payload.delete({
              collection: "observations",
              depth: 0,
              where: {
                trial: { equals: trial.id },
              },
            })
          );
          promisesEsminiDats.push(
            req.payload.delete({
              collection: "esminiDats",
              depth: 0,
              id: trial.esminiDat as string,
            })
          );
        }

        await Promise.all(promisesObservations).catch((error) => {
          console.error("Error:", error);
          return res.status(400).send({
            error: "some of the ego observations are failed to delete",
          });
        });

        await Promise.all(promisesEsminiDats).catch((error) => {
          console.error("Error:", error);
          return res.status(400).send({
            error: "some of the ego observations are failed to delete",
          });
        });

        return res.status(200).send(trials);
      },
    },
  ],
  fields: [
    {
      name: "search",
      type: "relationship",
      label: "Search",
      relationTo: "searches",
      hasMany: false,
      required: true,
    },
    {
      name: "machineId",
      type: "text",
      label: "Machine ID",
    },
    {
      name: "samplingMethod",
      type: "text",
      label: "SamplingMethod",
    },
    {
      name: "parameters",
      type: "array",
      label: "Parameters",
      required: true,
      fields: [
        {
          name: "parameterId",
          label: "Parameter ID",
          type: "text",
          required: true,
        },
        {
          name: "value",
          label: "Value",
          type: "number",
          required: true,
        },
      ],
    },
    {
      name: "safetyRequirements",
      label: "Safety Requirements",
      type: "array",
      required: true,
      fields: [
        {
          name: "criticalityMetric",
          label: "Criticality Metric",
          type: "relationship",
          relationTo: "criticalityMetrics",
          hasMany: false,
          required: true,
        },
        {
          name: "value",
          label: "Value",
          type: "number",
          required: true,
        },
        {
          name: "passed",
          label: "Passed",
          type: "checkbox",
          required: true,
        },
      ],
    },
    {
      name: "esminiDat",
      label: "Esmini Dat",
      type: "relationship",
      relationTo: "esminiDats",
      hasMany: false,
      required: true,
    },
  ],
};

export default Trials;
