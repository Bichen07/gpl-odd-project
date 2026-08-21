import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import path from "path";
import { resolveClusterArtifact } from "@/app/api/_lib/clusterPaths";
import { readYamlDoc } from "@/app/api/_lib/readYaml";

/**
 * Run Report API — assembles all existing analysis artifacts for one $RUN
 * into a single typed DTO for the Run Report tab.
 *
 * GET /api/cluster-run-report?batchId=8&folder=3_cluster_s=0.8032
 *
 * Reads only — no LLM calls, no file writes.
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

function readJsonSafe(p: string): Record<string, unknown> | null {
  if (!fs.existsSync(p)) return null;
  try {
    return JSON.parse(fs.readFileSync(p, "utf-8"));
  } catch {
    return null;
  }
}

// ── Types ────────────────────────────────────────────────────────────────────

type ReportCluster = {
  id: number;
  label: string | null;
  n: number;
  collisionRate: number | null;
  collisionCount: number | null;
  parameterRanges: Record<string, [number, number]> | null;
  neighborhoodSeparation: string | null;
  medoidMotive: string | null;
  medoidOutcome: string | null;
  medoidResolution: string | null;
  summaryCaption: string | null;
  riskLevel: string | null;
  consistencyNote: string | null;
  hasMedoid: boolean;
  hasSummary: boolean;
};

type ReportPair = {
  folder: string;
  clusters: [number, number];
  paramDist: number | null;
  outcomeFlip: boolean;
  separationCall: string | null;
  separationReason: string | null;
  contrastExplanation: string | null;
  hasContrast: boolean;
};

type RunReportDTO = {
  header: {
    batchId: string;
    folder: string;
    k: number | null;
    silhouette: number | null;
    qualityScore: number | null;
    qualityRuleScore: number | null;
    selectionScore: number | null;
  };
  clusters: ReportCluster[];
  pairs: ReportPair[];
  selectionFindings: string[];
  mergeCandidates: Array<{
    clusters: [number, number];
    sharedMotive: string;
    collisionRate: [number, number];
    paramOverlap: number;
  }>;
  // S2 — present once the Filtering panel "Export ODD boundary" button (or
  // the `odd-export` CLI command) has been used on this folder.
  boundaryExport: {
    generatedAt: string | null;
    kNN: number | null;
    kpiName: string | null;
    clustersIncluded: string[];
    nTrialsConsidered: number | null;
    nTrialsWithoutClusterLabel: number | null;
    collisionBoundaryCount: number;
    clusterBoundaryCount: number;
  } | null;
  // S3 — present once `odd-rules` (CLI) has been run for this folder.
  parameterRules: {
    generatedAt: string | null;
    maxDepth: number | null;
    features: string[];
    nTrialsUsed: number | null;
    trainAcc: number | null;
    cvAcc: number | null;
    rules: Array<{
      id: string;
      predicate: string;
      predicted: string;
      support: number;
      precision: number;
      boundaryTrialHits: number | null;
    }>;
  } | null;
  // S4 — present once `odd-join` (CLI) has been run for this folder.
  boundaryPairsJoin: {
    nPairs: number;
    nPairsTouchingBoundary: number;
  } | null;
};

// ── Handler ──────────────────────────────────────────────────────────────────

export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const batchId = url.searchParams.get("batchId") ?? "";
  const folder = url.searchParams.get("folder") ?? "";

  if (!/^\d+$/.test(batchId) || !folder) {
    return NextResponse.json(
      { error: "batchId (int) and folder required" },
      { status: 400 },
    );
  }

  const projectRoot = findProjectRoot(process.cwd());
  const runDir = path.join(projectRoot, "results", `batch${batchId}`, folder);

  if (!fs.existsSync(runDir)) {
    return NextResponse.json(
      { error: `Run directory not found: ${folder}` },
      { status: 404 },
    );
  }

  // ── Parse folder name → k, silhouette ─────────────────────────────────

  const folderMatch = folder.match(/^(\d+)_cluster_s=([-0-9.]+)$/);
  const k = folderMatch ? parseInt(folderMatch[1], 10) : null;
  const silhouette = folderMatch ? parseFloat(folderMatch[2]) : null;

  // ── Quality / selection JSON ──────────────────────────────────────────

  const qualityJson = readJsonSafe(
    path.join(runDir, "clustering_quality.json"),
  ) as Record<string, any> | null;
  const selectionJson = readJsonSafe(
    path.join(runDir, "cluster_selection_eval.json"),
  ) as Record<string, any> | null;

  // ── Clusters ──────────────────────────────────────────────────────────

  const clusters: ReportCluster[] = [];

  for (const entry of fs.readdirSync(runDir, { withFileTypes: true })) {
    const m = entry.isDirectory() ? entry.name.match(/^cluster(\d+)$/) : null;
    if (!m) continue;
    const cid = parseInt(m[1], 10);
    const clusterDir = path.join(runDir, entry.name);

    // cluster.json (raw stats)
    const cjPath = resolveClusterArtifact(clusterDir, "cluster.json");
    const cj = cjPath ? readJsonSafe(cjPath) : null;
    const clusterStats = (cj as Record<string, any>)?.cluster ?? null;

    // medoid_trial.yaml
    const medoidPath = resolveClusterArtifact(clusterDir, "medoid_trial.yaml");
    const medoid = readYamlDoc(medoidPath);

    // cluster_summary.yaml
    const summaryPath = resolveClusterArtifact(clusterDir, "cluster_summary.yaml");
    const summary = readYamlDoc(summaryPath);

    clusters.push({
      id: cid,
      label: (summary?.label as string) ?? null,
      n: clusterStats?.n_trials ?? clusterStats?.size ?? 0,
      collisionRate: clusterStats?.collision_rate ?? null,
      collisionCount: clusterStats?.collision_count ?? null,
      parameterRanges: clusterStats?.parameter_ranges ?? null,
      neighborhoodSeparation:
        (summary?.neighbor_comparison as any[])?.[0]?.separation ??
        (summary?.neighborhood_separation as string) ??
        null,
      medoidMotive: (medoid?.primary_motive as string) ?? null,
      medoidOutcome: (medoid?.outcome as string) ?? null,
      medoidResolution: (medoid?.interaction_resolution as string) ?? null,
      summaryCaption: (summary?.caption as string) ?? null,
      riskLevel: (summary?.risk_level as string) ?? null,
      consistencyNote: (summary?.consistency_note as string) ?? null,
      hasMedoid: medoid != null,
      hasSummary: summary != null,
    });
  }

  // Sort by collision rate descending (nulls last)
  clusters.sort((a, b) => {
    const ra = a.collisionRate ?? -1;
    const rb = b.collisionRate ?? -1;
    return rb - ra;
  });

  // ── Parameter-space pairs ─────────────────────────────────────────────

  const pairs: ReportPair[] = [];
  const pairsDir = path.join(runDir, "parameter_space_pairs");

  if (fs.existsSync(pairsDir)) {
    for (const f of fs.readdirSync(pairsDir).sort()) {
      const pairDir = path.join(pairsDir, f);
      if (!fs.statSync(pairDir).isDirectory()) continue;

      const pm = f.match(/^c(\d+)-c(\d+)$/);
      if (!pm) continue;
      const ca = parseInt(pm[1], 10);
      const cb = parseInt(pm[2], 10);

      // pair.json (deterministic)
      const pairJson = readJsonSafe(
        path.join(pairDir, "pair.json"),
      ) as Record<string, any> | null;

      // contrast.yaml (LLM output)
      const contrastPath = fs.existsSync(path.join(pairDir, "output", "contrast.yaml"))
        ? path.join(pairDir, "output", "contrast.yaml")
        : fs.existsSync(path.join(pairDir, "contrast.yaml"))
          ? path.join(pairDir, "contrast.yaml")
          : null;
      const contrast = contrastPath ? readYamlDoc(contrastPath) : null;

      const outcomeFlip =
        pairJson?.collided_a !== pairJson?.collided_b &&
        pairJson?.collided_a != null;

      pairs.push({
        folder: f,
        clusters: [ca, cb],
        paramDist: pairJson?.param_dist ?? null,
        outcomeFlip,
        separationCall: (contrast?.separation_call as string) ?? null,
        separationReason: (contrast?.separation_reason as string) ?? null,
        contrastExplanation: (contrast?.contrast_explanation as string) ?? null,
        hasContrast: contrast != null,
      });
    }
  }

  // ── S2 boundary export (optional) ─────────────────────────────────────

  const boundaryExportJson = readJsonSafe(
    path.join(runDir, "odd_boundary_export.json"),
  ) as Record<string, any> | null;

  const boundaryExport = boundaryExportJson
    ? {
        generatedAt: boundaryExportJson.generated_at ?? null,
        kNN: boundaryExportJson.kNN ?? null,
        kpiName: boundaryExportJson.kpi?.name ?? null,
        clustersIncluded: boundaryExportJson.clusters_included ?? [],
        nTrialsConsidered: boundaryExportJson.n_trials_considered ?? null,
        nTrialsWithoutClusterLabel:
          boundaryExportJson.n_trials_without_cluster_label ?? null,
        collisionBoundaryCount:
          boundaryExportJson.collision_boundary?.boundary_trials?.length ?? 0,
        clusterBoundaryCount:
          boundaryExportJson.cluster_boundary?.boundary_trials?.length ?? 0,
      }
    : null;

  // ── S3 parameter rules (optional, written by the `odd-rules` CLI) ─────

  const rulesJson = readJsonSafe(
    path.join(runDir, "odd_parameter_rules.json"),
  ) as Record<string, any> | null;

  const parameterRules = rulesJson
    ? {
        generatedAt: rulesJson.generated_at ?? null,
        maxDepth: rulesJson.max_depth ?? null,
        features: rulesJson.features ?? [],
        nTrialsUsed: rulesJson.n_trials_used ?? null,
        trainAcc: rulesJson.metrics?.train_acc ?? null,
        cvAcc: rulesJson.metrics?.cv_acc ?? null,
        rules: ((rulesJson.rules as any[]) ?? []).map((r) => ({
          id: r.id,
          predicate: r.predicate,
          predicted: r.predicted,
          support: r.support,
          precision: r.precision,
          boundaryTrialHits: r.boundary_trial_hits ?? null,
        })),
      }
    : null;

  // ── S4 boundary <-> pairs join (optional, written by `odd-join` CLI) ──

  const joinJson = readJsonSafe(
    path.join(runDir, "odd_boundary_pairs_join.json"),
  ) as Record<string, any> | null;

  const boundaryPairsJoin = joinJson
    ? {
        nPairs: joinJson.n_pairs ?? 0,
        nPairsTouchingBoundary: joinJson.n_pairs_touching_boundary ?? 0,
      }
    : null;

  // ── Assemble DTO ──────────────────────────────────────────────────────

  const dto: RunReportDTO = {
    header: {
      batchId,
      folder,
      k,
      silhouette,
      qualityScore: qualityJson?.final_score ?? null,
      qualityRuleScore: qualityJson?.rule_score ?? null,
      selectionScore: selectionJson?.selection_score ?? null,
    },
    clusters,
    pairs,
    selectionFindings: (selectionJson?.findings as string[]) ?? [],
    mergeCandidates: ((selectionJson?.merge_candidates as any[]) ?? []).map(
      (mc: any) => ({
        clusters: mc.clusters as [number, number],
        sharedMotive: mc.shared_motive ?? "",
        collisionRate: mc.collision_rate as [number, number],
        paramOverlap: mc.param_overlap ?? 0,
      }),
    ),
    boundaryExport,
    parameterRules,
    boundaryPairsJoin,
  };

  return NextResponse.json(dto);
}
