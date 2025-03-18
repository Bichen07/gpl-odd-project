import type {
    PayloadRequest,
    RequestContext,
} from "payload/dist/express/types";
import payload from "payload";

// find the status of the batch
function findBatchStatus(batchId, session) {
    return (
        Object.keys(session.batches).find((status) =>
            session.batches[status].some((batch) => batch.id === batchId)
        ) || null
    );
}

// update the status of the batch
export async function StatusUpdate(
    req: PayloadRequest,
    doc: any,
    previousDoc: any,
    operation: "create" | "update"
): Promise<void> {
    if (operation === "create") return;
    if (doc.status === previousDoc.status) return;
    // get the belonging session
    const foundSession = await payload.findByID({
        collection: "sessions",
        id: typeof doc.session === "string" ? doc.session : doc.session.id,
    });
    const foundedStatus = findBatchStatus(doc.id, foundSession);

    if (doc.status !== foundedStatus) {
        // Remove the batch from its current status array
        const batchIndex = foundSession.batches[foundedStatus].findIndex(
            (b) => b.id === doc.id
        );
        if (batchIndex > -1) {
            foundSession.batches[foundedStatus].splice(batchIndex, 1);
        }
        // Turn the array of batch objects into an array of batch ids
        Object.keys(foundSession.batches).forEach((status) => {
            foundSession.batches[status] = foundSession.batches[status].map(
                (batch) => batch.id
            );
        });
        // Add the new status array if it doesn't exist
        ["pending", "running", "completed", "discarded"].forEach((status) => {
            foundSession.batches[status] = foundSession.batches[status] || [];
        });
        // Add the batch to the new status array
        foundSession.batches[doc.status].push(doc.id);
    }

    // update the session with the new batches
    await req.payload.update({
        collection: "sessions",
        id: typeof doc.session === "string" ? doc.session : doc.session.id,
        data: { batches: foundSession.batches },
        context: { triggerAfterChange: false },
    });
}
