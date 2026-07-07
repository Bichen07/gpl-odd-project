import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";

/**
 * GET /api/cluster-analysis-status?batchId=2
 *
 * Scans all clustering result folders and reports which have LLM analysis,
 * medoid trial IDs (from manifest.json), and per-cluster interpretation summaries.
 */

function findProjectRoot(start: string): string {
  let current = start;
  for (let i = 0; i < 8; i++) {
    if (path.basename(current) === "gpl-odd-project") return current;
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  return path.resolve(start, "..", "..");
}

function readJsonSafe(p: string): Record<string, unknown> | null {
  try {
    return JSON.parse(fs.readFileSync(p, "utf-8"));
  } catch {
    return null;
  }
}

export async function GET(req: NextRequest) {
  const batchId = req.nextUrl.searchParams.get("batchId");
  if (!batchId || !/^\d+$/.test(batchId)) {
    return NextResponse.json({ error: "valid batchId required" }, { status: 400 });
  }

  const root = findProjectRoot(process.cwd());
  const batchDir = path.join(root, "results", `batch${batchId}`);
  if (!fs.existsSync(batchDir)) {
    return NextResponse.json({ folders: {} });
  }

  const folders: Record<string, {
    has_analysis: boolean;
    medoids: Record<string, string>;
    interpretations: Record<string, {
      cluster_label?: string;
      ego_perspective_summary?: unknown;
    }>;
  }> = {};

  for (const entry of fs.readdirSync(batchDir, { withFileTypes: true })) {
    if (!entry.isDirectory()) continue;
    if (!/^\d+_cluster/.test(entry.name)) continue;

    const runDir = path.join(batchDir, entry.name);
    const manifest = readJsonSafe(path.join(runDir, "manifest.json"));

    const medoids: Record<string, string> = {};
    const clusters = (manifest?.clusters ?? []) as Array<Record<string, unknown>>;
    for (const c of clusters) {
      const label = String(c.label ?? "");
      const trialId = String(c.trial_id ?? "");
      if (label && trialId) medoids[label] = trialId;
    }

    const interpretations: Record<string, {
      cluster_label?: string;
      ego_perspective_summary?: unknown;
    }> = {};
    let hasAnalysis = false;

    for (const sub of fs.readdirSync(runDir, { withFileTypes: true })) {
      if (!sub.isDirectory() || !/^cluster\d+$/.test(sub.name)) continue;
      const label = sub.name.replace("cluster", "");
      const metaPath = path.join(runDir, sub.name, "interpretation_meta.json");
      const yamlPath = path.join(runDir, sub.name, "cluster_interpretation.yaml");
      const meta = readJsonSafe(metaPath);
      if (!meta && !fs.existsSync(yamlPath)) continue;

      hasAnalysis = true;
      interpretations[label] = {
        cluster_label: meta?.cluster_label as string | undefined,
        ego_perspective_summary: meta?.ego_perspective_summary,
      };

      if (!medoids[label]) {
        const cj = readJsonSafe(path.join(runDir, sub.name, "cluster.json"));
        const medoid = cj?.medoid as Record<string, unknown> | undefined;
        if (medoid?.trial_id != null) {
          medoids[label] = String(medoid.trial_id);
        }
      }
    }

    folders[entry.name] = { has_analysis: hasAnalysis, medoids, interpretations };
  }

  return NextResponse.json({ folders });
}
