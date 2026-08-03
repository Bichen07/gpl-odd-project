import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";
import {
  selectDefaultSnapshots,
  snapshotTimestamp,
  type LlmSnapshotsDoc,
} from "@/app/_shared/utils/snapshotSelection";
import { resolveClusterArtifact, resolveHighlightSubdir } from "@/app/api/_lib/clusterPaths";
import { metaFromYamlPath } from "@/app/api/_lib/readYaml";

/**
 * Config + image server for the "Select and analyze" page.
 *
 * Operates on the builder layout:
 *   results/batch<id>/<k>_cluster_s=<sil>/cluster<N>/{raw,processed,output}/
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
  system: "system_prompt.txt",
  common_sense: "common_sense.txt",
  medoid: "medoid_trial_prompt.txt",
  summary: "cluster_summary_prompt.txt",
  ic_pair: "ic_pair_prompt.txt",
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

// results/batch<id>/<k>_cluster_s=<sil>/ — exact match only (tiny float
// tolerance for toFixed(4) rounding). Do NOT fall back to a different
// silhouette: that silently shows the wrong BEV / analysis (e.g. user picks
// s=0.6988 but the page loads 3_cluster_s=0.7036).
function resolveFolder(batchDir: string, k: string, s: string): string | null {
  if (!fs.existsSync(batchDir)) return null;
  const exact = `${k}_cluster_s=${s}`;
  if (fs.existsSync(path.join(batchDir, exact))) return exact;

  const prefix = `${k}_cluster_s=`;
  const target = parseFloat(s);
  if (Number.isNaN(target)) return null;
  for (const entry of fs.readdirSync(batchDir, { withFileTypes: true })) {
    if (!entry.isDirectory() || !entry.name.startsWith(prefix)) continue;
    const sil = parseFloat(entry.name.slice(prefix.length));
    // Match within half of the last displayed digit (toFixed(4)).
    if (!Number.isNaN(sil) && Math.abs(sil - target) < 5e-5) return entry.name;
  }
  return null;
}

function listAvailableFolders(batchDir: string, k?: string): string[] {
  if (!fs.existsSync(batchDir)) return [];
  const prefix = k && /^\d+$/.test(k) ? `${k}_cluster_s=` : null;
  return fs
    .readdirSync(batchDir, { withFileTypes: true })
    .filter(
      (e) =>
        e.isDirectory() &&
        /^\d+_cluster_s=[-0-9.]+$/.test(e.name) &&
        (prefix == null || e.name.startsWith(prefix)),
    )
    .map((e) => e.name)
    .sort();
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

  // --- boundary description mode ---
  const boundaryDesc = url.searchParams.get("boundaryDesc");
  if (boundaryDesc) {
    const cluster = url.searchParams.get("cluster") ?? "";
    const batchFolder = url.searchParams.get("batchFolder") ?? "";
    const boundaryWith = url.searchParams.get("boundaryWith") ?? "";
    if (!/^\d+$/.test(cluster) || !batchFolder || !/^\d+$/.test(boundaryWith)) {
      return NextResponse.json({ error: "invalid boundary request" }, { status: 400 });
    }
    const boundaryDir =
      resolveHighlightSubdir(
        path.join(batchDir, batchFolder, `cluster${cluster}`),
        `boundary_c${boundaryWith}`,
      ) ??
      path.join(
        batchDir,
        batchFolder,
        `cluster${cluster}`,
        `boundary_c${boundaryWith}`,
      );
    if (!fs.existsSync(boundaryDir)) {
      return new NextResponse("(no boundary data generated)", { headers: { "Content-Type": "text/plain" } });
    }
    const subs = fs.readdirSync(boundaryDir, { withFileTypes: true })
      .filter((e) => e.isDirectory() && e.name.startsWith("trial_"));
    if (subs.length === 0) {
      return new NextResponse("(no trial sub-directory)", { headers: { "Content-Type": "text/plain" } });
    }
    const trialRoot = path.join(boundaryDir, subs[0].name);
    const descPath =
      resolveClusterArtifact(trialRoot, "description.txt") ??
      path.join(trialRoot, "description.txt");
    const text = fs.existsSync(descPath)
      ? fs.readFileSync(descPath, "utf-8")
      : "(description.txt not found)";
    return new NextResponse(text, { headers: { "Content-Type": "text/plain" } });
  }

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
    const clusterDir = path.join(batchDir, folder, `cluster${cluster}`);
    const snapDir = resolveClusterArtifact(clusterDir, "snapshots");
    const imgPath = snapDir
      ? path.join(snapDir, file)
      : path.join(clusterDir, "snapshots", file);
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
    const promptDir = path.join(projectRoot, "app", "llm_pipeline", "prompt_templates");
    const prompts: Record<string, string> = {};
    for (const [key, fname] of Object.entries(PROMPT_FILES)) {
      const p = path.join(promptDir, fname);
      prompts[key] = fs.existsSync(p) ? fs.readFileSync(p, "utf-8") : "";
    }
    const requestedFolder = s ? `${k}_cluster_s=${s}` : `${k}_cluster`;
    return NextResponse.json(
      {
        missing: true,
        error: `no preprocess dataset for batch${batchId} ${requestedFolder}`,
        batchId,
        k,
        s,
        requestedFolder,
        availableFolders: listAvailableFolders(batchDir, k),
        prompts,
        models: MODELS,
        clusters: [],
        results: [],
      },
      { status: 404 },
    );
  }
  const runDir = path.join(batchDir, folder);

  const clusters: Array<{
    cluster: number;
    stats: unknown;
    medoid: unknown;
    intraVariance: unknown;
    snapshots: string[];
    defaultSnapshots: string[];
  }> = [];
  for (const entry of fs.readdirSync(runDir, { withFileTypes: true })) {
    const m = entry.isDirectory() ? entry.name.match(/^cluster(\d+)$/) : null;
    if (!m) continue;
    const clusterDir = path.join(runDir, entry.name);
    let stats: unknown = null;
    let medoid: unknown = null;
    let intraVariance: unknown = null;
    const cjPath = resolveClusterArtifact(clusterDir, "cluster.json");
    if (cjPath) {
      try {
        const doc = JSON.parse(fs.readFileSync(cjPath, "utf-8"));
        stats = doc.cluster ?? null;
        medoid = doc.medoid ?? null;
        intraVariance = (doc.cluster as Record<string, unknown>)?.intra_variance ?? null;
      } catch {
        /* ignore malformed cluster.json */
      }
    }
    const snapDir = resolveClusterArtifact(clusterDir, "snapshots");
    let snapshots: string[] = [];
    let llmSnapshots: LlmSnapshotsDoc | null = null;
    if (snapDir) {
      snapshots = fs
        .readdirSync(snapDir)
        .filter((f) => /\.(jpg|jpeg|png)$/i.test(f))
        .sort((a, b) => snapshotTimestamp(a) - snapshotTimestamp(b));
      const llmPath = path.join(snapDir, "llm_snapshots.json");
      if (fs.existsSync(llmPath)) {
        try {
          llmSnapshots = JSON.parse(fs.readFileSync(llmPath, "utf-8")) as LlmSnapshotsDoc;
        } catch {
          llmSnapshots = null;
        }
      }
    }
    clusters.push({
      cluster: parseInt(m[1], 10),
      stats,
      medoid,
      intraVariance,
      snapshots,
      defaultSnapshots: selectDefaultSnapshots(
        snapshots,
        10,
        medoid as Record<string, unknown> | null,
        2,
        llmSnapshots,
      ),
    });
  }
  clusters.sort((a, b) => a.cluster - b.cluster);

  // Previously-saved LLM products (so the page can show results without re-running).
  const results: Array<{
    cluster: number;
    meta: Record<string, unknown> | null;
    rawYaml: string;
  }> = [];
  const splitClusters: Array<Record<string, unknown>> = [];
  for (const entry of fs.readdirSync(runDir, { withFileTypes: true })) {
    const m = entry.isDirectory() ? entry.name.match(/^cluster(\d+)$/) : null;
    if (!m) continue;
    const clusterDir = path.join(runDir, entry.name);
    const cid = parseInt(m[1], 10);

    const medoidYamlPath = resolveClusterArtifact(clusterDir, "medoid_trial.yaml");
    const summaryYamlPath = resolveClusterArtifact(clusterDir, "cluster_summary.yaml");
    const medoidMeta = metaFromYamlPath(medoidYamlPath);
    const summaryMeta = metaFromYamlPath(summaryYamlPath);
    const medoidYaml =
      medoidYamlPath && fs.existsSync(medoidYamlPath)
        ? fs.readFileSync(medoidYamlPath, "utf-8")
        : "";
    const summaryYaml =
      summaryYamlPath && fs.existsSync(summaryYamlPath)
        ? fs.readFileSync(summaryYamlPath, "utf-8")
        : "";

    // Card list prefers medoid narrative; fall back to summary caption.
    if (medoidMeta || medoidYaml || summaryMeta || summaryYaml) {
      const parsed = (medoidMeta?.parsed ?? summaryMeta?.parsed ?? null) as
        | Record<string, unknown>
        | null;
      const cardMeta: Record<string, unknown> | null = medoidMeta
        ? {
            ...medoidMeta,
            cluster_label:
              (summaryMeta?.parsed as Record<string, unknown> | undefined)?.label ??
              (parsed as Record<string, unknown> | null)?.label,
            behavior_description:
              (summaryMeta?.parsed as Record<string, unknown> | undefined)?.caption ??
              (parsed as Record<string, unknown> | null)?.motive_summary,
            ego_perspective_summary: (parsed as Record<string, unknown> | null)
              ?.decision_timeline,
            safety_assessment: {
              risk_level: (summaryMeta?.parsed as Record<string, unknown> | undefined)
                ?.risk_level,
              failure_mode: (summaryMeta?.parsed as Record<string, unknown> | undefined)
                ?.consistency_note,
            },
          }
        : summaryMeta
          ? {
              ...summaryMeta,
              cluster_label: (summaryMeta.parsed as Record<string, unknown> | undefined)
                ?.label,
              behavior_description: (
                summaryMeta.parsed as Record<string, unknown> | undefined
              )?.caption,
              safety_assessment: {
                risk_level: (summaryMeta.parsed as Record<string, unknown> | undefined)
                  ?.risk_level,
                failure_mode: (
                  summaryMeta.parsed as Record<string, unknown> | undefined
                )?.consistency_note,
              },
            }
          : null;
      results.push({
        cluster: cid,
        meta: cardMeta,
        rawYaml: medoidYaml || summaryYaml,
      });
    }

    const readJson = (p: string | null) => {
      if (!p || !fs.existsSync(p)) return null;
      try {
        return JSON.parse(fs.readFileSync(p, "utf-8"));
      } catch {
        return null;
      }
    };
    splitClusters.push({
      cluster: cid,
      aggregate: readJson(resolveClusterArtifact(clusterDir, "cluster_aggregate.json")),
      summaryYaml,
      summaryMeta,
      medoidYaml,
      medoidMeta,
    });
  }
  results.sort((a, b) => a.cluster - b.cluster);
  splitClusters.sort(
    (a, b) => Number(a.cluster) - Number(b.cluster),
  );

  const icPairsDir = path.join(runDir, "ic_pairs");
  const icPairs: Array<{ name: string; yaml: string }> = [];
  if (fs.existsSync(icPairsDir)) {
    for (const f of fs.readdirSync(icPairsDir).sort()) {
      const flat = path.join(icPairsDir, f);
      if (f.endsWith(".yaml") && fs.statSync(flat).isFile()) {
        icPairs.push({ name: f, yaml: fs.readFileSync(flat, "utf-8") });
        continue;
      }
      // New layout: ic_pairs/cA-cB/contrast.yaml
      if (!fs.statSync(flat).isDirectory()) continue;
      const contrast = path.join(flat, "contrast.yaml");
      if (fs.existsSync(contrast)) {
        icPairs.push({
          name: `${f}/contrast.yaml`,
          yaml: fs.readFileSync(contrast, "utf-8"),
        });
      }
    }
  }
  const promptDir = path.join(projectRoot, "app", "llm_pipeline", "prompt_templates");
  const prompts: Record<string, string> = {};
  for (const [key, fname] of Object.entries(PROMPT_FILES)) {
    const p = path.join(promptDir, fname);
    prompts[key] = fs.existsSync(p) ? fs.readFileSync(p, "utf-8") : "";
  }

  return NextResponse.json({
    batchId,
    folder,
    clusters,
    prompts,
    models: MODELS,
    results,
    splitAnalysis: {
      clusters: splitClusters,
      icPairs,
    },
  });
}
