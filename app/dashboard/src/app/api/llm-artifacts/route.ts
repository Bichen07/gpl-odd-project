import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";

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

function readFileSafe(filePath: string): string {
  if (!fs.existsSync(filePath)) return "";
  return fs.readFileSync(filePath, "utf-8");
}

export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const runId = url.searchParams.get("runId");
  const projectRoot = findProjectRoot(process.cwd());
  const artifactsRoot = path.join(projectRoot, "app", "llm_pipeline", "artifacts");

  if (!fs.existsSync(artifactsRoot)) {
    return NextResponse.json({ runs: [], stages: {}, root: artifactsRoot });
  }

  const stageDirs = fs
    .readdirSync(artifactsRoot, { withFileTypes: true })
    .filter((d) => d.isDirectory())
    .map((d) => d.name);

  const runSet = new Set<string>();
  for (const stage of stageDirs) {
    const stagePath = path.join(artifactsRoot, stage);
    for (const entry of fs.readdirSync(stagePath, { withFileTypes: true })) {
      if (entry.isDirectory()) runSet.add(entry.name);
    }
  }
  const runs = Array.from(runSet).sort().reverse();
  const selectedRunId = runId && runSet.has(runId) ? runId : runs[0] || null;

  const stages: Record<string, { files: string[]; preview: string }> = {};
  if (selectedRunId) {
    for (const stage of stageDirs) {
      const dir = path.join(artifactsRoot, stage, selectedRunId);
      if (!fs.existsSync(dir)) continue;
      const files = fs
        .readdirSync(dir, { withFileTypes: true })
        .filter((f) => f.isFile())
        .map((f) => f.name)
        .sort();
      const previewFile = files.find((f) => f.endsWith(".md")) || files.find((f) => f.endsWith(".txt")) || files.find((f) => f.endsWith(".json"));
      const preview = previewFile ? readFileSafe(path.join(dir, previewFile)).slice(0, 8000) : "";
      stages[stage] = { files, preview };
    }
  }

  return NextResponse.json({
    root: artifactsRoot,
    runs,
    selectedRunId,
    stages,
  });
}
