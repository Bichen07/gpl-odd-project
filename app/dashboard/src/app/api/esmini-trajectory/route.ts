import { NextRequest, NextResponse } from "next/server";
import path from "path";
import {
  RECORDS_DIR,
  buildEsminiTrajectory,
  findProjectRoot,
  readJsonSafe,
} from "../_lib/esminiTrajectory";
import { resolveClusterArtifact } from "../_lib/clusterPaths";

/**
 * GET /api/esmini-trajectory
 *
 * Returns the FULL esmini ground-truth trajectory for a trial, in the Replayer's
 * TrajectoryResponseData shape. This lets any trajectory play the full, un-clipped
 * scenario timeline so it starts at the same initial frame as the CSV / BEV
 * snapshots (the Payload API trajectories are start-clipped and time-rebased).
 *
 * The esmini CSV is named esmini_<batch>_<trialIndex>.csv. There are two ways to
 * resolve which CSV to load — pick whichever the caller has on hand:
 *
 *   1. Medoid mode  ?batchId=2&folder=4_cluster_s%3D0.6945&label=0
 *      Reads the medoid's (batch_id, trial_index) from the cluster's cluster.json.
 *      Use this when the caller only knows the cluster, not the esmini index
 *      (cluster.json is the authoritative source for a medoid).
 *
 *   2. Trial mode   ?batchId=2&trialId=3269[&trialIndex=17]
 *      trialIndex (from the trial's esminiDat.filename) is authoritative; when it
 *      is absent we fall back to resolving trialId -> trialIndex via the Payload
 *      REST API (best-effort — clustering trial IDs may not exist in Payload).
 *
 * See ../_lib/esminiTrajectory.ts for why esmini (not Payload obs) is used.
 */

// trialId -> trialIndex, cached for the lifetime of the server process.
const trialIndexCache = new Map<string, number>();

async function resolveTrialIndex(trialId: string): Promise<number | null> {
  if (trialIndexCache.has(trialId)) {
    return trialIndexCache.get(trialId) ?? null;
  }
  const base = process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS;
  const key = process.env.NEXT_PUBLIC_PAYLOAD_API_KEY;
  if (!base) {
    return null;
  }
  try {
    const resp = await fetch(`${base}/api/trials/${trialId}?depth=0`, {
      headers: key ? { Authorization: `users API-Key ${key}` } : {},
      cache: "no-store",
    });
    if (!resp.ok) {
      return null;
    }
    const data = (await resp.json()) as Record<string, unknown>;
    const idx = data?.trialIndex;
    if (typeof idx === "number" && Number.isFinite(idx)) {
      trialIndexCache.set(trialId, idx);
      return idx;
    }
    return null;
  } catch {
    return null;
  }
}

/** Resolve a cluster medoid's (csvBatch, trialIndex, trialId) from cluster.json. */
function resolveMedoid(
  root: string,
  batchId: string,
  folder: string,
  label: string,
): { csvBatch: string; trialIndex: string; trialId: number } | null {
  const clusterDir = path.join(
    root,
    "results",
    `batch${batchId}`,
    folder,
    `cluster${label}`,
  );
  const cjPath = resolveClusterArtifact(clusterDir, "cluster.json");
  const clusterJson = cjPath ? readJsonSafe(cjPath) : null;
  const medoid = (clusterJson?.medoid ?? {}) as Record<string, unknown>;
  if (medoid.batch_id == null || medoid.trial_index == null) {
    return null;
  }
  return {
    csvBatch: String(medoid.batch_id),
    trialIndex: String(medoid.trial_index),
    trialId: medoid.trial_id != null ? Number(medoid.trial_id) : -1,
  };
}

export async function GET(req: NextRequest) {
  const sp = req.nextUrl.searchParams;
  const batchId = sp.get("batchId");
  const trialId = sp.get("trialId");
  const trialIndexParam = sp.get("trialIndex");
  const folder = sp.get("folder");
  const label = sp.get("label");
  const framePeriod = Number(sp.get("framePeriod") ?? "0.1") || 0.1;

  if (!batchId || !/^\d+$/.test(batchId)) {
    return NextResponse.json({ error: "valid batchId required" }, { status: 400 });
  }

  const root = findProjectRoot(process.cwd());

  let csvBatch = batchId;
  let trialIndex: number | null = null;
  let responseTrialId = trialId != null ? Number(trialId) : -1;

  if (folder != null && label != null) {
    // --- Medoid mode ---
    if (folder.includes("..") || folder.includes("/") || !/^\d+$/.test(label)) {
      return NextResponse.json(
        { error: "invalid folder or label" },
        { status: 400 },
      );
    }
    const medoid = resolveMedoid(root, batchId, folder, label);
    if (medoid == null) {
      return NextResponse.json(
        { error: "medoid batch_id/trial_index not found in cluster.json" },
        { status: 404 },
      );
    }
    csvBatch = medoid.csvBatch;
    trialIndex = Number(medoid.trialIndex);
    responseTrialId = medoid.trialId;
  } else {
    // --- Trial mode ---
    if (!trialId || !/^\d+$/.test(trialId)) {
      return NextResponse.json({ error: "valid trialId required" }, { status: 400 });
    }
    if (trialIndexParam != null && /^\d+$/.test(trialIndexParam)) {
      trialIndex = Number(trialIndexParam);
    } else {
      trialIndex = await resolveTrialIndex(trialId);
    }
    if (trialIndex == null) {
      return NextResponse.json(
        { error: `could not resolve trialIndex for trial ${trialId}` },
        { status: 404 },
      );
    }
  }

  const csvPath = path.join(
    root,
    RECORDS_DIR,
    `esmini_${csvBatch}_${trialIndex}.csv`,
  );

  const result = buildEsminiTrajectory(csvPath, responseTrialId, framePeriod);
  if (result == null) {
    return NextResponse.json(
      { error: `esmini CSV missing or empty: esmini_${csvBatch}_${trialIndex}.csv` },
      { status: 404 },
    );
  }

  return NextResponse.json(result);
}
