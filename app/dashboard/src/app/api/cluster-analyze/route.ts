import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";

/**
 * Config + image server for the "Select and analyze" page.
 *
 * Operates on the builder layout:
 *   results/batch<id>/<k>_cluster_s=<sil>/cluster<N>/{cluster.json, snapshots/*.jpg}
 *
 * GET (list):  ?batchId=&k=&s=        -> { folder, clusters[], prompts, models }
 * GET (image): ?batchId=&folder=&cluster=&file=  -> raw image bytes
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

const PROMPT_FILES: Record<string, string> = {
  system: "cluster_system_prompt.txt",
  common_sense: "cluster_common_sense.txt",
  interaction: "cluster_interaction_prompt.txt",
  reviewer: "cluster_reviewer_prompt.txt",
};

// Keep this list to models that are currently served. gemini-2.0-flash was
// retired by Google (404 "no longer available") and must not be offered.
const MODELS = [
  { id: "gemini-2.5-flash", provider: "Google" },
  { id: "gemini-2.5-pro", provider: "Google" },
  { id: "gemini-2.5-flash-lite", provider: "Google" },
  { id: "gpt-4o", provider: "OpenAI" },
  { id: "gpt-4o-mini", provider: "OpenAI" },
  { id: "gpt-4-turbo", provider: "OpenAI" },
];

function snapshotTimestamp(name: string): number {
  const m = name.match(/_t_(\d+(?:\.\d+)?)/i);
  return m ? parseFloat(m[1]) : 0;
}

// results/batch<id>/<k>_cluster_s=<sil>/ — exact match, else closest silhouette.
function resolveFolder(batchDir: string, k: string, s: string): string | null {
  if (!fs.existsSync(batchDir)) return null;
  const exact = `${k}_cluster_s=${s}`;
  if (fs.existsSync(path.join(batchDir, exact))) return exact;
  const prefix = `${k}_cluster_s=`;
  const target = parseFloat(s);
  let best: { name: string; diff: number } | null = null;
  for (const entry of fs.readdirSync(batchDir, { withFileTypes: true })) {
    if (!entry.isDirectory() || !entry.name.startsWith(prefix)) continue;
    const sil = parseFloat(entry.name.slice(prefix.length));
    const diff = Number.isNaN(sil) || Number.isNaN(target) ? 0 : Math.abs(sil - target);
    if (best === null || diff < best.diff) best = { name: entry.name, diff };
  }
  return best?.name ?? null;
}

// Reject path-traversal in user-supplied path components.
function isSafeComponent(value: string, re: RegExp): boolean {
  return re.test(value) && !value.includes("..") && !value.includes("/");
}

export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const projectRoot = findProjectRoot(process.cwd());
  const batchId = url.searchParams.get("batchId") ?? "";

  if (!/^\d+$/.test(batchId)) {
    return NextResponse.json({ error: "valid batchId required" }, { status: 400 });
  }
  const batchDir = path.join(projectRoot, "results", `batch${batchId}`);

  // --- image mode ---
  const file = url.searchParams.get("file");
  if (file) {
    const folder = url.searchParams.get("folder") ?? "";
    const cluster = url.searchParams.get("cluster") ?? "";
    if (
      !isSafeComponent(folder, /^\d+_cluster_s=[-0-9.]+$/) ||
      !/^\d+$/.test(cluster) ||
      !isSafeComponent(file, /^[\w.\-+=]+\.(jpg|jpeg|png)$/i)
    ) {
      return NextResponse.json({ error: "invalid image request" }, { status: 400 });
    }
    const imgPath = path.join(batchDir, folder, `cluster${cluster}`, "snapshots", file);
    if (!fs.existsSync(imgPath)) {
      return NextResponse.json({ error: "image not found" }, { status: 404 });
    }
    const buf = fs.readFileSync(imgPath);
    const ct = path.extname(file).toLowerCase() === ".png" ? "image/png" : "image/jpeg";
    return new NextResponse(buf, {
      headers: { "Content-Type": ct, "Cache-Control": "public, max-age=3600" },
    });
  }

  // --- list mode ---
  const k = url.searchParams.get("k") ?? "";
  const s = url.searchParams.get("s") ?? "";
  if (!/^\d+$/.test(k)) {
    return NextResponse.json({ error: "valid k required" }, { status: 400 });
  }

  const folder = resolveFolder(batchDir, k, s);
  if (!folder) {
    return NextResponse.json(
      { error: `no results folder for batch${batchId} k=${k} s=${s}` },
      { status: 404 },
    );
  }
  const runDir = path.join(batchDir, folder);

  const clusters: Array<{
    cluster: number;
    stats: unknown;
    medoid: unknown;
    snapshots: string[];
  }> = [];
  for (const entry of fs.readdirSync(runDir, { withFileTypes: true })) {
    const m = entry.isDirectory() ? entry.name.match(/^cluster(\d+)$/) : null;
    if (!m) continue;
    const clusterDir = path.join(runDir, entry.name);
    let stats: unknown = null;
    let medoid: unknown = null;
    const cjPath = path.join(clusterDir, "cluster.json");
    if (fs.existsSync(cjPath)) {
      try {
        const doc = JSON.parse(fs.readFileSync(cjPath, "utf-8"));
        stats = doc.cluster ?? null;
        medoid = doc.medoid ?? null;
      } catch {
        /* ignore malformed cluster.json */
      }
    }
    const snapDir = path.join(clusterDir, "snapshots");
    let snapshots: string[] = [];
    if (fs.existsSync(snapDir)) {
      snapshots = fs
        .readdirSync(snapDir)
        .filter((f) => /\.(jpg|jpeg|png)$/i.test(f))
        .sort((a, b) => snapshotTimestamp(a) - snapshotTimestamp(b));
    }
    clusters.push({ cluster: parseInt(m[1], 10), stats, medoid, snapshots });
  }
  clusters.sort((a, b) => a.cluster - b.cluster);

  // Previously-saved interpretations (so the page can show results without re-running).
  const results: Array<{
    cluster: number;
    meta: Record<string, unknown> | null;
    rawYaml: string;
  }> = [];
  for (const entry of fs.readdirSync(runDir, { withFileTypes: true })) {
    const m = entry.isDirectory() ? entry.name.match(/^cluster(\d+)$/) : null;
    if (!m) continue;
    const clusterDir = path.join(runDir, entry.name);
    const metaPath = path.join(clusterDir, "interpretation_meta.json");
    const yamlPath = path.join(clusterDir, "cluster_interpretation.yaml");
    let meta: Record<string, unknown> | null = null;
    if (fs.existsSync(metaPath)) {
      try {
        meta = JSON.parse(fs.readFileSync(metaPath, "utf-8"));
      } catch {
        meta = null;
      }
    }
    let rawYaml = "";
    if (fs.existsSync(yamlPath)) rawYaml = fs.readFileSync(yamlPath, "utf-8");
    if (meta || rawYaml) {
      results.push({ cluster: parseInt(m[1], 10), meta, rawYaml });
    }
  }
  results.sort((a, b) => a.cluster - b.cluster);

  const promptDir = path.join(projectRoot, "app", "llm_pipeline", "prompt_templates");
  const prompts: Record<string, string> = {};
  for (const [key, fname] of Object.entries(PROMPT_FILES)) {
    const p = path.join(promptDir, fname);
    prompts[key] = fs.existsSync(p) ? fs.readFileSync(p, "utf-8") : "";
  }

  return NextResponse.json({ batchId, folder, clusters, prompts, models: MODELS, results });
}
