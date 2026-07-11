import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";

/**
 * GET /api/cluster-analysis-status?batchId=2
 *
 * Scans clustering result folders for:
 * - preprocess artifacts (medoid + closest-pair + outlier)
 * - LLM analysis
 * - trial IDs for medoids / outliers / boundary (closest-pair) highlights
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

function hasTrialSubdirs(dir: string): boolean {
  if (!fs.existsSync(dir)) return false;
  try {
    return fs
      .readdirSync(dir, { withFileTypes: true })
      .some((e) => e.isDirectory() && /^trial_/.test(e.name));
  } catch {
    return false;
  }
}

type BoundaryPair = {
  cluster_a: number | string;
  trial_a: string;
  cluster_b: number | string;
  trial_b: string;
  embedding_dist?: number;
};

type FolderStatus = {
  has_analysis: boolean;
  has_preprocess: boolean;
  medoids: Record<string, string>;
  /** Primary (materialized) outlier trial per cluster */
  outliers: Record<string, string>;
  boundary_trials: Record<string, string[]>;
  boundary_pairs: BoundaryPair[];
  /** HDBSCAN task from clustering/selectedClusteringResult.json */
  task: Record<string, unknown> | null;
  interpretations: Record<
    string,
    {
      cluster_label?: string;
      ego_perspective_summary?: unknown;
    }
  >;
};

function scanClusterDirs(runDir: string): string[] {
  return fs
    .readdirSync(runDir, { withFileTypes: true })
    .filter((e) => e.isDirectory() && /^cluster\d+$/.test(e.name))
    .map((e) => e.name)
    .sort((a, b) => Number(a.replace("cluster", "")) - Number(b.replace("cluster", "")));
}

function checkPreprocessComplete(
  runDir: string,
  clusterNames: string[],
  boundaryPairs: BoundaryPair[],
): boolean {
  if (clusterNames.length === 0) return false;

  for (const name of clusterNames) {
    const clusterDir = path.join(runDir, name);
    const cj = readJsonSafe(path.join(clusterDir, "cluster.json"));
    const medoid = cj?.medoid as Record<string, unknown> | undefined;
    if (medoid?.trial_id == null) return false;
    if (!fs.existsSync(path.join(clusterDir, "action.yaml"))) return false;

    const clusterMeta = (cj?.cluster ?? {}) as Record<string, unknown>;
    const intra = (clusterMeta.intra_variance ?? {}) as Record<string, unknown>;
    const outlierIds = (intra.outlier_trial_ids ?? []) as unknown[];
    if (outlierIds.length > 0) {
      if (!hasTrialSubdirs(path.join(clusterDir, "outlier_trials"))) return false;
    }

    const neighbors = (intra.boundary_neighbors ?? {}) as Record<string, string>;
    for (const tgt of Object.keys(neighbors)) {
      if (!hasTrialSubdirs(path.join(clusterDir, `boundary_c${tgt}`))) return false;
    }
  }

  // Every declared closest-pair must have both side folders on disk.
  for (const bp of boundaryPairs) {
    const a = String(bp.cluster_a);
    const b = String(bp.cluster_b);
    if (!hasTrialSubdirs(path.join(runDir, `cluster${a}`, `boundary_c${b}`))) {
      return false;
    }
    if (!hasTrialSubdirs(path.join(runDir, `cluster${b}`, `boundary_c${a}`))) {
      return false;
    }
  }

  return true;
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

  const folders: Record<string, FolderStatus> = {};

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

    const boundaryPairs = (
      (manifest?.boundary_pairs ?? []) as BoundaryPair[]
    ).map((bp) => ({
      cluster_a: bp.cluster_a,
      trial_a: String(bp.trial_a),
      cluster_b: bp.cluster_b,
      trial_b: String(bp.trial_b),
      embedding_dist:
        typeof bp.embedding_dist === "number" ? bp.embedding_dist : undefined,
    }));

    const outliers: Record<string, string> = {};
    const boundaryTrials: Record<string, string[]> = {};
    const interpretations: FolderStatus["interpretations"] = {};
    let hasAnalysis = false;

    const savedClustering = readJsonSafe(
      path.join(runDir, "clustering", "selectedClusteringResult.json"),
    );
    const savedTask =
      (savedClustering?.task as Record<string, unknown> | undefined) ?? null;

    const clusterNames = scanClusterDirs(runDir);

    for (const name of clusterNames) {
      const label = name.replace("cluster", "");
      const clusterDir = path.join(runDir, name);
      const cj = readJsonSafe(path.join(clusterDir, "cluster.json"));

      if (!medoids[label]) {
        const medoid = cj?.medoid as Record<string, unknown> | undefined;
        if (medoid?.trial_id != null) {
          medoids[label] = String(medoid.trial_id);
        }
      }

      const clusterMeta = (cj?.cluster ?? {}) as Record<string, unknown>;
      const intra = (clusterMeta.intra_variance ?? {}) as Record<string, unknown>;
      const outlierIds = ((intra.outlier_trial_ids ?? []) as unknown[])
        .map((id) => String(id))
        .filter(Boolean);
      // Only the top outlier is materialized under outlier_trials/trial_*.
      if (outlierIds.length > 0) {
        outliers[label] = outlierIds[0];
      }

      const neighborMap = (intra.boundary_neighbors ?? {}) as Record<
        string,
        string
      >;
      const fromNeighbors = Object.values(neighborMap)
        .map((id) => String(id))
        .filter(Boolean);

      // Also collect this cluster's side of each closest pair.
      const fromPairs: string[] = [];
      for (const bp of boundaryPairs) {
        if (String(bp.cluster_a) === label) fromPairs.push(String(bp.trial_a));
        if (String(bp.cluster_b) === label) fromPairs.push(String(bp.trial_b));
      }

      const uniq = [...new Set([...fromNeighbors, ...fromPairs])];
      if (uniq.length > 0) {
        boundaryTrials[label] = uniq;
      }

      const metaPath = path.join(clusterDir, "interpretation_meta.json");
      const yamlPath = path.join(clusterDir, "cluster_interpretation.yaml");
      const meta = readJsonSafe(metaPath);
      if (!meta && !fs.existsSync(yamlPath)) continue;

      hasAnalysis = true;
      interpretations[label] = {
        cluster_label: meta?.cluster_label as string | undefined,
        ego_perspective_summary: meta?.ego_perspective_summary,
      };
    }

    const hasPreprocess = checkPreprocessComplete(
      runDir,
      clusterNames,
      boundaryPairs,
    );

    folders[entry.name] = {
      has_analysis: hasAnalysis,
      has_preprocess: hasPreprocess,
      medoids,
      outliers,
      boundary_trials: boundaryTrials,
      boundary_pairs: boundaryPairs,
      task: savedTask,
      interpretations,
    };
  }

  return NextResponse.json({ folders });
}
