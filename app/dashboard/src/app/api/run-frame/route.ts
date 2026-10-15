import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";

export const dynamic = "force-dynamic";

const ALLOWED =
  /^(cluster\d+\/processed\/snapshots\/|conversation_trials\/trial_\d+\/snapshots\/|parameter_space_pairs\/c\d+-c\d+\/).+\.jpg$/;

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

export async function GET(req: NextRequest) {
  const batchId = req.nextUrl.searchParams.get("batchId") ?? "";
  const folder = req.nextUrl.searchParams.get("folder") ?? "";
  const rel = req.nextUrl.searchParams.get("rel") ?? "";
  if (!/^\d+$/.test(batchId) || !folder || !ALLOWED.test(rel) || rel.includes("..")) {
    return NextResponse.json({ error: "batchId, folder, and a jpg path are required" }, { status: 400 });
  }
  const projectRoot = findProjectRoot(process.cwd());
  const runDir = path.join(projectRoot, "results", `batch${batchId}`, folder);
  const filePath = path.resolve(runDir, rel);
  if (!filePath.startsWith(path.resolve(runDir) + path.sep) || !fs.existsSync(filePath)) {
    return NextResponse.json({ error: "frame not found" }, { status: 404 });
  }
  const bytes = fs.readFileSync(filePath);
  return new NextResponse(bytes, {
    headers: { "Content-Type": "image/jpeg", "Cache-Control": "private, max-age=3600" },
  });
}
