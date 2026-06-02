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

export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const runId = url.searchParams.get("runId");
  const cluster = url.searchParams.get("cluster");
  const file = url.searchParams.get("file");
  const projectRoot = findProjectRoot(process.cwd());

  if (runId && cluster && file) {
    const imgPath = path.join(
      projectRoot,
      "llm_artifacts",
      runId,
      "clusters",
      `cluster_${cluster}`,
      "bev",
      file,
    );
    if (fs.existsSync(imgPath)) {
      const buf = fs.readFileSync(imgPath);
      const ext = path.extname(file).toLowerCase();
      const ct = ext === ".png" ? "image/png" : "image/jpeg";
      return new NextResponse(buf, {
        headers: { "Content-Type": ct, "Cache-Control": "public, max-age=3600" },
      });
    }
    return NextResponse.json({ error: "not found" }, { status: 404 });
  }

  if (!runId) {
    return NextResponse.json({ error: "runId required" }, { status: 400 });
  }

  const clustersDir = path.join(projectRoot, "llm_artifacts", runId, "clusters");
  if (!fs.existsSync(clustersDir)) {
    return NextResponse.json({ clusters: [] });
  }

  const clusters: { clusterId: string; bevFiles: string[] }[] = [];
  for (const entry of fs.readdirSync(clustersDir, { withFileTypes: true })) {
    if (!entry.isDirectory() || !entry.name.startsWith("cluster_")) continue;
    const bevDir = path.join(clustersDir, entry.name, "bev");
    const bevFiles: string[] = [];
    if (fs.existsSync(bevDir)) {
      for (const f of fs.readdirSync(bevDir)) {
        if (/\.(jpg|jpeg|png)$/i.test(f)) bevFiles.push(f);
      }
    }
    clusters.push({
      clusterId: entry.name.replace("cluster_", ""),
      bevFiles: bevFiles.sort(),
    });
  }

  return NextResponse.json({ clusters: clusters.sort((a, b) => a.clusterId.localeCompare(b.clusterId)) });
}
