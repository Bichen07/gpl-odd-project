import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";
import {
  clusterArtifactExists,
  resolveClusterArtifact,
  resolveHighlightSubdir,
} from "../_lib/clusterPaths";
import { metaFromYamlPath } from "../_lib/readYaml";

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

type ParamBoundaryPair = {
  cluster_a: number | string;
  trial_a: string;
  cluster_b: number | string;
  trial_b: string;
  param_dist?: number;
  param_names?: string[];
  ic_match?: boolean;
  card_role?: string;
};

type FolderStatus = {
  has_analysis: boolean;
  has_preprocess: boolean;
  has_medoid_trial: boolean;
  has_cluster_summary: boolean;
  has_ic_pairs: boolean;
  medoids: Record<string, string>;
  /** Primary (materialized) outlier trial per cluster */
  outliers: Record<string, string>;
  boundary_trials: Record<string, string[]>;
  boundary_pairs: BoundaryPair[];
  param_boundary_trials: Record<string, string[]>;
  param_boundary_pairs: ParamBoundaryPair[];
  /** HDBSCAN task from clustering/selectedClusteringResult.json */
  task: Record<string, unknown> | null;
  interpretations: Record<
    string,
    {
      cluster_label?: string;
      ego_perspective_summary?: unknown;
      motive_summary?: string;
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
  paramBoundaryPairs: ParamBoundaryPair[],
): boolean {
  if (clusterNames.length === 0) return false;

  for (const name of clusterNames) {
    const clusterDir = path.join(runDir, name);
    const cjPath = resolveClusterArtifact(clusterDir, "cluster.json");
    const cj = cjPath ? readJsonSafe(cjPath) : null;
    const medoid = cj?.medoid as Record<string, unknown> | undefined;
    if (medoid?.trial_id == null) return false;
    if (!clusterArtifactExists(clusterDir, "action.yaml")) return false;

    const clusterMeta = (cj?.cluster ?? {}) as Record<string, unknown>;
    const intra = (clusterMeta.intra_variance ?? {}) as Record<string, unknown>;
    const outlierIds = (intra.outlier_trial_ids ?? []) as unknown[];
    if (outlierIds.length > 0) {
      const od = resolveHighlightSubdir(clusterDir, "outlier_trials");
      if (!od || !hasTrialSubdirs(od)) return false;
    }

    const neighbors = (intra.boundary_neighbors ?? {}) as Record<string, string>;
    for (const tgt of Object.keys(neighbors)) {
      const bd = resolveHighlightSubdir(clusterDir, `boundary_c${tgt}`);
      if (!bd || !hasTrialSubdirs(bd)) return false;
    }
  }

  // Every declared closest-pair must have both side folders on disk.
  for (const bp of boundaryPairs) {
    const a = String(bp.cluster_a);
    const b = String(bp.cluster_b);
    const ab = resolveHighlightSubdir(path.join(runDir, `cluster${a}`), `boundary_c${b}`);
    const ba = resolveHighlightSubdir(path.join(runDir, `cluster${b}`), `boundary_c${a}`);
    if (!ab || !hasTrialSubdirs(ab)) return false;
    if (!ba || !hasTrialSubdirs(ba)) return false;
  }

  // IC matched pairs live under ic_pairs/cA-cB/ (gated by param_dist).
  for (const bp of paramBoundaryPairs) {
    const matched = (bp as ParamBoundaryPair & { ic_match?: boolean }).ic_match;
    if (matched === false) continue;
    const a = Number(bp.cluster_a);
    const b = Number(bp.cluster_b);
    const lo = Math.min(a, b);
    const hi = Math.max(a, b);
    const pack = path.join(runDir, "ic_pairs", `c${lo}-c${hi}`);
    if (!fs.existsSync(pack) || !fs.statSync(pack).isDirectory()) return false;
    const sides = fs
      .readdirSync(pack, { withFileTypes: true })
      .filter((e) => e.isDirectory() && /^c\d+_trial_/.test(e.name));
    if (sides.length < 2) return false;
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

    const paramBoundaryPairs = (
      (manifest?.param_boundary_pairs ?? []) as ParamBoundaryPair[]
    ).map((bp) => ({
      cluster_a: bp.cluster_a,
      trial_a: String(bp.trial_a),
      cluster_b: bp.cluster_b,
      trial_b: String(bp.trial_b),
      param_dist:
        typeof bp.param_dist === "number" ? bp.param_dist : undefined,
      param_names: Array.isArray(bp.param_names)
        ? bp.param_names.map(String)
        : undefined,
      ic_match: typeof bp.ic_match === "boolean" ? bp.ic_match : undefined,
      card_role: typeof bp.card_role === "string" ? bp.card_role : undefined,
    }));

    const outliers: Record<string, string> = {};
    const boundaryTrials: Record<string, string[]> = {};
    const paramBoundaryTrials: Record<string, string[]> = {};
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
      const cjPath = resolveClusterArtifact(clusterDir, "cluster.json");
      const cj = cjPath ? readJsonSafe(cjPath) : null;

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
      // Only the top outlier is materialized under highlight_trials/outlier_trials/trial_*.
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

      const paramNeighborMap = (intra.param_boundary_neighbors ?? {}) as Record<
        string,
        string
      >;
      const fromParamNeighbors = Object.values(paramNeighborMap)
        .map((id) => String(id))
        .filter(Boolean);
      const fromParamPairs: string[] = [];
      for (const bp of paramBoundaryPairs) {
        if (String(bp.cluster_a) === label) fromParamPairs.push(String(bp.trial_a));
        if (String(bp.cluster_b) === label) fromParamPairs.push(String(bp.trial_b));
      }
      const paramUniq = [...new Set([...fromParamNeighbors, ...fromParamPairs])];
      if (paramUniq.length > 0) {
        paramBoundaryTrials[label] = paramUniq;
      }

      const summaryPath = resolveClusterArtifact(clusterDir, "cluster_summary.yaml");
      const medoidPath = resolveClusterArtifact(clusterDir, "medoid_trial.yaml");
      const summaryMeta = metaFromYamlPath(summaryPath);
      const medoidMeta = metaFromYamlPath(medoidPath);
      const summaryParsed = (summaryMeta?.parsed as Record<string, unknown> | undefined) ?? null;
      const medoidParsed = (medoidMeta?.parsed as Record<string, unknown> | undefined) ?? null;

      const hasSplit =
        clusterArtifactExists(clusterDir, "cluster_summary.yaml") ||
        clusterArtifactExists(clusterDir, "medoid_trial.yaml");
      if (!hasSplit) continue;

      hasAnalysis = true;

      // Label from summary when present; Replayer timeline from medoid only.
      const clusterLabel = summaryParsed?.label as string | undefined;
      const egoSummary = medoidParsed?.decision_timeline as unknown;

      interpretations[label] = {
        cluster_label: clusterLabel,
        ego_perspective_summary: egoSummary,
        motive_summary:
          typeof medoidParsed?.motive_summary === "string" &&
          medoidParsed.motive_summary !== "parse_failed"
            ? medoidParsed.motive_summary
            : undefined,
      };
    }

    let hasMedoidTrial = false;
    let hasClusterSummary = false;
    for (const name of clusterNames) {
      const clusterDir = path.join(runDir, name);
      if (clusterArtifactExists(clusterDir, "medoid_trial.yaml")) {
        hasMedoidTrial = true;
        hasAnalysis = true;
      }
      if (clusterArtifactExists(clusterDir, "cluster_summary.yaml")) {
        hasClusterSummary = true;
        hasAnalysis = true;
      }
    }
    const icPairsDir = path.join(runDir, "ic_pairs");
    const hasIcPairs =
      fs.existsSync(icPairsDir) &&
      fs.readdirSync(icPairsDir).some((f) => {
        const p = path.join(icPairsDir, f);
        if (f.endsWith(".yaml") && fs.statSync(p).isFile()) return true;
        return (
          fs.statSync(p).isDirectory() &&
          fs.existsSync(path.join(p, "contrast.yaml"))
        );
      });
    if (hasIcPairs) hasAnalysis = true;

    const hasPreprocess = checkPreprocessComplete(
      runDir,
      clusterNames,
      boundaryPairs,
      paramBoundaryPairs,
    );

    folders[entry.name] = {
      has_analysis: hasAnalysis,
      has_preprocess: hasPreprocess,
      has_medoid_trial: hasMedoidTrial,
      has_cluster_summary: hasClusterSummary,
      has_ic_pairs: hasIcPairs,
      medoids,
      outliers,
      boundary_trials: boundaryTrials,
      boundary_pairs: boundaryPairs,
      param_boundary_trials: paramBoundaryTrials,
      param_boundary_pairs: paramBoundaryPairs,
      task: savedTask,
      interpretations,
    };
  }

  return NextResponse.json({ folders });
}
