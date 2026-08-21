import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";

/**
 * S2 — ODD boundary export.
 *
 * POST /api/odd-boundary-export
 *   Body: { batchId, folder, kNN, kpi: {id, name}, clustersIncluded: string[],
 *           collision_boundary, cluster_boundary, all_trials? }
 *   Writes (all read-then-write only — no LLM call):
 *     - $RUN/odd_boundary_export.json            (latest — what Run report / S4 read)
 *     - $RUN/odd_boundary_export.kNN{k}.json     (dated snapshot, so re-exporting
 *       with a different kNN does not silently erase the previous one; useful
 *       for a kNN sensitivity check before trusting one value)
 *     - $RUN/odd_all_trials.json                 (if `all_trials` present — every
 *       trial's scenario params + KPI pass/fail + cluster label; input for S3
 *       CART training, which must see ALL trials, not just boundary ones)
 *
 * GET /api/odd-boundary-export?batchId=&folder=
 *   Returns the cached "latest" export, or 404 if it has not been built yet.
 *
 * The kNN / distance computation itself happens client-side in the Filtering
 * panel (it reuses the exact same kd-tree the "On Collision/Cluster Boundary"
 * checkboxes use — see explore/lib/boundaryExport.ts). This route only
 * persists the result so Run report / S3 / S5 can read it from disk.
 */

function findProjectRoot(start: string): string {
  let current = start;
  for (let i = 0; i < 8; i += 1) {
    if (path.basename(current) === "gpl-odd-project") return current;
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  return path.resolve(start, "..", "..");
}

function runDirFor(batchId: string, folder: string): string {
  const projectRoot = findProjectRoot(process.cwd());
  return path.join(projectRoot, "results", `batch${batchId}`, folder);
}

const EXPORT_FILENAME = "odd_boundary_export.json";
const ALL_TRIALS_FILENAME = "odd_all_trials.json";

export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const batchId = url.searchParams.get("batchId") ?? "";
  const folder = url.searchParams.get("folder") ?? "";
  if (!/^\d+$/.test(batchId) || !folder) {
    return NextResponse.json(
      { error: "batchId (int) and folder required" },
      { status: 400 },
    );
  }
  const filePath = path.join(runDirFor(batchId, folder), EXPORT_FILENAME);
  if (!fs.existsSync(filePath)) {
    return NextResponse.json({ error: "not_built" }, { status: 404 });
  }
  try {
    const doc = JSON.parse(fs.readFileSync(filePath, "utf-8"));
    return NextResponse.json(doc);
  } catch {
    return NextResponse.json({ error: "corrupt_export" }, { status: 500 });
  }
}

export async function POST(req: NextRequest) {
  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "invalid JSON body" }, { status: 400 });
  }

  const batchId = String(body.batchId ?? "");
  const folder = String(body.folder ?? "");
  if (!/^\d+$/.test(batchId) || !folder) {
    return NextResponse.json(
      { error: "batchId (int) and folder required" },
      { status: 400 },
    );
  }

  const runDir = runDirFor(batchId, folder);
  if (!fs.existsSync(runDir)) {
    return NextResponse.json(
      { error: `Run directory not found: ${folder}` },
      { status: 404 },
    );
  }

  const kNN = body.kNN ?? null;
  const generatedAt = new Date().toISOString();

  const doc = {
    generated_at: generatedAt,
    batch_id: Number(batchId),
    folder,
    kNN,
    kpi: body.kpi ?? null,
    clusters_included: body.clustersIncluded ?? [],
    n_trials_considered: body.nTrialsConsidered ?? null,
    n_trials_without_cluster_label: body.nTrialsWithoutClusterLabel ?? null,
    // Explore's kNN uses min-max normalized L2 over scenario parameters —
    // NOT the z-scored L2 used by compute_parameter_space_boundaries. Do not
    // compare param_dist here against parameter_space_pairs/*/pair.json.
    distance_note:
      "min-max normalized L2 over scenario parameters (same metric as Filtering UI); not comparable to parameter-space pair z-score distance",
    collision_boundary: body.collision_boundary ?? { boundary_trials: [], edges: [] },
    cluster_boundary: body.cluster_boundary ?? { boundary_trials: [], edges: [] },
  };

  const filePath = path.join(runDir, EXPORT_FILENAME);
  const snapshotPath =
    kNN != null
      ? path.join(runDir, `odd_boundary_export.kNN${kNN}.json`)
      : null;

  try {
    const serialized = JSON.stringify(doc, null, 2);
    fs.writeFileSync(filePath, serialized, "utf-8");
    if (snapshotPath) fs.writeFileSync(snapshotPath, serialized, "utf-8");
  } catch (e) {
    return NextResponse.json(
      { error: `failed to write export: ${String(e)}` },
      { status: 500 },
    );
  }

  let allTrialsPath: string | null = null;
  if (Array.isArray(body.all_trials) && body.all_trials.length > 0) {
    allTrialsPath = path.join(runDir, ALL_TRIALS_FILENAME);
    try {
      fs.writeFileSync(
        allTrialsPath,
        JSON.stringify(
          {
            generated_at: generatedAt,
            batch_id: Number(batchId),
            folder,
            n_trials: body.all_trials.length,
            trials: body.all_trials,
          },
          null,
          2,
        ),
        "utf-8",
      );
    } catch (e) {
      return NextResponse.json(
        { error: `failed to write odd_all_trials.json: ${String(e)}` },
        { status: 500 },
      );
    }
  }

  return NextResponse.json({
    ok: true,
    path: filePath,
    snapshotPath,
    allTrialsPath,
    doc,
  });
}
