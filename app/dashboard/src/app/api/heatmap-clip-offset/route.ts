import { NextRequest, NextResponse } from "next/server";
import {
  computeHeatmapClipOffset,
  findEsminiCsvForHeatmapOffset,
  findProjectRoot,
} from "../_lib/esminiTrajectory";

/**
 * GET /api/heatmap-clip-offset?batchId=2
 * Optional: &folder=...&label=0  or  &csvBatch=7&trialIndex=1067
 *
 * Returns seconds between baked Heatmap origin (always current_startvalid) and
 * the active clip_conditions.yaml profile — used to shift the Heatmap playhead.
 *
 * Offset is trial-dependent (speed between gates differs). Prefer folder/label
 * or csvBatch/trialIndex when known; otherwise uses a results medoid CSV
 * (needed for batch8/9 which reuse batch7 records and have no esmini_9_* files).
 */
export async function GET(req: NextRequest) {
  const sp = req.nextUrl.searchParams;
  const batchId = sp.get("batchId");
  if (!batchId || !/^\d+$/.test(batchId)) {
    return NextResponse.json({ error: "valid batchId required" }, { status: 400 });
  }

  const folder = sp.get("folder") ?? undefined;
  const label = sp.get("label") ?? undefined;
  const csvBatch = sp.get("csvBatch") ?? undefined;
  const trialIndex = sp.get("trialIndex") ?? undefined;

  const root = findProjectRoot(process.cwd());
  const found = findEsminiCsvForHeatmapOffset(root, batchId, {
    folder,
    label,
    csvBatch,
    trialIndex,
  });
  if (found == null) {
    return NextResponse.json(
      {
        heatmapClipOffsetSec: 0,
        clipStartEsminiS: null,
        heatmapOriginEsminiS: null,
        warning: `no esmini CSV resolved for batch ${batchId}`,
      },
      {
        status: 200,
        headers: { "Cache-Control": "no-store" },
      },
    );
  }

  const result = computeHeatmapClipOffset(found.csvPath, {
    batchId: found.clipBatchId,
    projectRoot: root,
  });
  if (result == null) {
    return NextResponse.json(
      {
        heatmapClipOffsetSec: 0,
        clipStartEsminiS: null,
        heatmapOriginEsminiS: null,
        warning: "could not resolve clip from CSV",
      },
      {
        status: 200,
        headers: { "Cache-Control": "no-store" },
      },
    );
  }

  return NextResponse.json(
    {
      heatmapClipOffsetSec: result.heatmapClipOffsetSec,
      clipStartEsminiS: result.clipStartEsminiS,
      heatmapOriginEsminiS: result.heatmapOriginEsminiS,
      clipProfile: result.clipProfile,
      heatmapOriginProfile: result.heatmapOriginProfile,
      mapId: result.mapId,
      csv: result.csvPath.split(/[/\\]/).pop() ?? null,
      clipBatchId: found.clipBatchId,
    },
    {
      headers: {
        "Cache-Control": "no-store",
      },
    },
  );
}
