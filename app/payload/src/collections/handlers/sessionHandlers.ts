import type {
    PayloadRequest,
    RequestContext,
} from "payload/dist/express/types";
import requestFilter from "../../utils/requestFilter";

// handle after session delete
export async function DeleteBatchesAfterSessionDeleted(
    req: PayloadRequest,
    doc: any
): Promise<void> {
    const batchIds = doc.batches.pending.map((batch) => batch.id);
    await req.payload.delete({
        collection: "batches",
        where: { id: { in: batchIds } },
        depth: 0,
    });
}

// handle after session change
export async function CreateBatchesAfterDecidingFilters(
    context: RequestContext,
    req: PayloadRequest,
    doc: any,
    operation: "create" | "update"
): Promise<void> {
    if (context.triggerAfterChange === false) {
        return;
    }

    // Fetch scenarios based on the provided filter
    const { interested = [], unwanted = [], required = [] } = doc.filter.tags;

    const tagTreeFilters = doc.filter.tagTrees;
    const statuses = ["interested", "unwanted", "required"];
    for (const status of statuses) {
        for (const tagTree of tagTreeFilters[status]) {
            delete tagTree["id"];
            if ("actors" in tagTree && Array.isArray(tagTree["actors"])) {
                for (const actor of tagTree["actors"]) {
                    delete actor["id"];
                }
            }
        }
    }

    const filterPattern = {
        tags: {
            interested: (interested.join(",") || (" " as string)).trim(),
            unwanted: (unwanted.join(",") || (" " as string)).trim(),
            required: (required.join(",") || (" " as string)).trim(),
        },
        tagTrees: {
            interested: tagTreeFilters["interested"],
            unwanted: tagTreeFilters["unwanted"],
            required: tagTreeFilters["required"],
        },
    };
    const scenarioIdList = await requestFilter({
        value: filterPattern,
        field: "id",
    });

    // Fetch existing logical scenarios in the session
    const combinedBatchIds = [
        ...(doc.batches.pending || []),
        ...(doc.batches.running || []),
        ...(doc.batches.completed || [])
    ];

    const existsScenarioIDs: string[] = await Promise.all(
        (combinedBatchIds || []).map(async batchID => {
            const batch = await req.payload.findByID({
                collection: "batches",
                id: batchID,
            });
            const scenarioId =
                typeof batch.scenario === "string"
                    ? batch.scenario
                    : (batch.scenario as { id: string }).id;
            return scenarioId;
        })
    );

    // Gather batches to create if logical scenario is not in the session
    const batches = await Promise.all(
        scenarioIdList
            .filter(
                (scenarioId) =>
                    !existsScenarioIDs.find((id) => id === scenarioId)
            )
            .map(async (scenarioId) => {
                const batch = await req.payload.create({
                    collection: "batches",
                    data: {
                        scenario: scenarioId,
                        session: doc.id,
                        requiredNumberOfTrials: doc.variancePerBatch,
                        status: "pending",
                    },
                });
                return batch.id;
            })
    );

    if (!batches.length && operation === "create") return;

    // // Update the session with the new batches
    if (!doc.batches.pending) doc.batches.pending = [];
    if (!doc.batches.discard) doc.batches.discard = [];
    if (!doc.batches.running) doc.batches.running = [];
    if (!doc.batches.completed) doc.batches.completed = [];
    batches.push(...doc.batches.pending);

    // first find the scenariosId that is not in existsScenarioIDs but not in scenarioIdList
    const scenarioIdToDiscard = existsScenarioIDs.filter((scenarioId) => !scenarioIdList.includes(scenarioId));

    // Update the newly created batches to pending
    await req.payload.update({
        collection: 'sessions',
        id: doc.id,
        data: { batches: { pending: batches } },
        context: { triggerAfterChange: false }
    });

   if (!scenarioIdToDiscard.length) return;

    // get all the batches id in doc.batches.pending and doc.batches.running
    const PendingAndRunningBatchesId = [...doc.batches.pending, ...doc.batches.running];

    // Find batches that are in Pending or Running status and should be discarded
    const batchToDiscardId = (
        await req.payload.find({
            collection: "batches",
            where: {
                scenario: { in: scenarioIdToDiscard },
                id: { in: PendingAndRunningBatchesId }, // not in batches
            },
        })
    ).docs.map((batch) => batch.id);

    // Move Batches to Discarded one by one
    for (const batchId of batchToDiscardId) {
        await req.payload.update({
            collection: 'batches',
            id: batchId,
            data: { status: 'discarded' }
        });
    }
}

