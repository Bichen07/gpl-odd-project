import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";
import { resolveClusterArtifact } from "../_lib/clusterPaths";
import { readYamlDoc } from "../_lib/readYaml";

/**
 * GET /api/cluster-evaluate?batchId=2
 *
 * Scans results/batch<id>/<k>_cluster_s=<sil>/clustering_quality.json for all
 * available clustering configurations, assigns ranks (by final_score desc), and
 * returns the sorted array along with per-config cluster intra-variance data.
 *
 * Also returns boundary_pairs from each config's manifest.json.
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
  const { searchParams } = req.nextUrl;
  const batchId = searchParams.get("batchId");

  if (!batchId) {
    return NextResponse.json(
      { error: "batchId is required" },
      { status: 400 }
    );
  }

  const root = findProjectRoot(__dirname);
  const batchDir = path.join(root, "results", `batch${batchId}`);

  if (!fs.existsSync(batchDir)) {
    return NextResponse.json({ configs: [] });
  }

  const entries = fs
    .readdirSync(batchDir, { withFileTypes: true })
    .filter(
      (e) =>
        e.isDirectory() &&
        /^\d+_cluster(?:_s=[\d.]+)?$/.test(e.name)
    );

  const configs: Record<string, unknown>[] = [];

  for (const entry of entries) {
    const runDir = path.join(batchDir, entry.name);
    const qualityPath = path.join(runDir, "clustering_quality.json");
    const crossPath = path.join(runDir, "cross_cluster_eval.json");
    const manifestPath = path.join(runDir, "manifest.json");

    const quality = readJsonSafe(qualityPath);
    if (!quality) continue;

    const crossEval = readJsonSafe(crossPath);
    const manifest = readJsonSafe(manifestPath);

    // Collect per-cluster intra_variance from each cluster dir
    const clusterIntra: Record<string, unknown> = {};
    for (const sub of fs
      .readdirSync(runDir, { withFileTypes: true })
      .filter(
        (e) => e.isDirectory() && /^cluster\d+$/.test(e.name)
      )) {
      const cjPath = resolveClusterArtifact(
        path.join(runDir, sub.name),
        "cluster.json",
      );
      const cj = cjPath ? readJsonSafe(cjPath) : null;
      if (cj) {
        const clusterBlock = (cj as Record<string, unknown>).cluster as
          | Record<string, unknown>
          | undefined;
        if (clusterBlock) {
          const label = String(clusterBlock.label ?? sub.name.replace("cluster", ""));
          clusterIntra[label] = {
            intra_variance: clusterBlock.intra_variance ?? null,
            collision_rate: clusterBlock.collision_rate ?? null,
            mean_ttc: clusterBlock.mean_ttc ?? null,
            n_trials: clusterBlock.n_trials ?? null,
          };
        }
      }

      const summaryDoc = readYamlDoc(
        resolveClusterArtifact(path.join(runDir, sub.name), "cluster_summary.yaml"),
      );
      if (summaryDoc) {
        const label = String(
          ((cj as Record<string, unknown> | null)?.cluster as Record<string, unknown> | undefined)
            ?.label ?? sub.name.replace("cluster", ""),
        );
        const existing = clusterIntra[label] as Record<string, unknown> | undefined;
        if (existing) {
          existing.cluster_label = summaryDoc.label ?? null;
        }
      }
    }

    configs.push({
      ...quality,
      folder: entry.name,
      cross_cluster_eval: crossEval,
      boundary_pairs: (manifest as Record<string, unknown> | null)?.boundary_pairs ?? [],
      cluster_intra: clusterIntra,
    });
  }

  // Assign ranks by final_score descending
  configs.sort(
    (a, b) =>
      ((b.final_score as number) ?? 0) - ((a.final_score as number) ?? 0)
  );
  configs.forEach((c, i) => {
    c.rank = i + 1;
  });

  return NextResponse.json({ configs });
}
