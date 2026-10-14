import { NextRequest, NextResponse } from "next/server";
import { spawn } from "child_process";
import fs from "fs";
import path from "path";
import { runArtifactPath } from "@/app/api/_lib/runArtifactPaths";

/**
 * Switch the Report CART depth for one run.
 *
 * POST /api/odd-rules
 *   body: { batchId, folder, maxDepth }   maxDepth is 1–5
 *
 * A depth that was already fit is copied from odd/output/cart_by_depth/.
 * A new depth is fit once, then saved there, so the next selection is a file copy.
 * odd_parameter_rules.json stays the active depth the Report and Q&A read.
 */

export const dynamic = "force-dynamic";

const MAX_RUN_MS = 120 * 1000;
const ALLOWED_DEPTHS = new Set([1, 2, 3, 4, 5]);

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

function cacheFile(runDir: string, depth: number): string {
  const active = runArtifactPath(runDir, "oddRules", { forWrite: true });
  return path.join(path.dirname(active), "cart_by_depth", `depth_${depth}.json`);
}

function readRules(filePath: string): Record<string, unknown> | null {
  if (!fs.existsSync(filePath)) return null;
  try {
    const doc = JSON.parse(fs.readFileSync(filePath, "utf-8"));
    return doc && typeof doc === "object" ? doc : null;
  } catch {
    return null;
  }
}

function remember(runDir: string, doc: Record<string, unknown>): void {
  const depth = Number(doc.max_depth);
  if (!ALLOWED_DEPTHS.has(depth)) return;
  const dest = cacheFile(runDir, depth);
  fs.mkdirSync(path.dirname(dest), { recursive: true });
  fs.writeFileSync(dest, JSON.stringify(doc, null, 2), "utf-8");
}

function activate(runDir: string, doc: Record<string, unknown>): void {
  const active = runArtifactPath(runDir, "oddRules", { forWrite: true });
  fs.mkdirSync(path.dirname(active), { recursive: true });
  fs.writeFileSync(active, JSON.stringify(doc, null, 2), "utf-8");
  remember(runDir, doc);

  const briefingPath = runArtifactPath(runDir, "oddBriefing");
  if (!fs.existsSync(briefingPath)) return;
  try {
    const briefing = JSON.parse(fs.readFileSync(briefingPath, "utf-8"));
    briefing.rules = ((doc.rules as Array<Record<string, unknown>>) ?? []).map((rule) => ({
      id: rule.id,
      predicate: rule.predicate,
      predicted: rule.predicted,
      support: rule.support,
      precision: rule.precision,
      boundary_trial_hits: rule.boundary_trial_hits ?? null,
    }));
    const out = runArtifactPath(runDir, "oddBriefing", { forWrite: true });
    fs.mkdirSync(path.dirname(out), { recursive: true });
    fs.writeFileSync(out, JSON.stringify(briefing, null, 2), "utf-8");
  } catch {
    /* The Report plot reads the rules file. A briefing rewrite can wait. */
  }
}

function payload(doc: Record<string, unknown>, cached: boolean) {
  const metrics = (doc.metrics as Record<string, unknown>) ?? {};
  return {
    cached,
    generatedAt: doc.generated_at ?? null,
    maxDepth: doc.max_depth ?? null,
    nTrialsUsed: doc.n_trials_used ?? null,
    trainAcc: metrics.train_acc ?? null,
    cvAcc: metrics.cv_acc ?? null,
    rules: ((doc.rules as Array<Record<string, unknown>>) ?? []).map((rule) => ({
      id: rule.id,
      predicate: rule.predicate,
      predicted: rule.predicted,
      support: rule.support,
      precision: rule.precision,
      boundaryTrialHits: rule.boundary_trial_hits ?? null,
    })),
  };
}

function fitDepth(projectRoot: string, runDir: string, maxDepth: number): Promise<{ ok: true } | { ok: false; error: string }> {
  const script = `
set -euo pipefail
CONDA_BASE=$(conda info --base 2>/dev/null || echo "$HOME/miniconda3")
source "$CONDA_BASE/etc/profile.d/conda.sh"
conda activate analyzer
export PYTHONPATH="${projectRoot}/app/llm_pipeline/python:${projectRoot}/app/analyzer/src:\${PYTHONPATH:-}"
python3 -m llm_pipeline.cli odd-rules --run-dir "$ODD_RUN_DIR" --max-depth "$ODD_MAX_DEPTH"
`;
  return new Promise((resolve) => {
    const child = spawn("bash", ["-lc", script], {
      cwd: projectRoot,
      env: {
        ...process.env,
        PYTHONUNBUFFERED: "1",
        ODD_RUN_DIR: runDir,
        ODD_MAX_DEPTH: String(maxDepth),
      },
    });
    let stderr = "";
    const timer = setTimeout(() => child.kill("SIGKILL"), MAX_RUN_MS);
    child.stderr.on("data", (chunk) => {
      stderr += chunk.toString();
    });
    child.on("error", (err) => {
      clearTimeout(timer);
      resolve({ ok: false, error: `spawn error: ${String(err)}` });
    });
    child.on("close", (code) => {
      clearTimeout(timer);
      if (code !== 0) resolve({ ok: false, error: `odd-rules exited with code ${code}: ${stderr.slice(-2000)}` });
      else resolve({ ok: true });
    });
  });
}

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));
  const batchId = String(body.batchId ?? "");
  const folder = String(body.folder ?? "");
  const maxDepth = Number(body.maxDepth);

  if (!/^\d+$/.test(batchId) || !folder || folder.includes("..") || folder.includes("/") || folder.includes("\\")) {
    return NextResponse.json({ error: "batchId (int) and folder required" }, { status: 400 });
  }
  if (!ALLOWED_DEPTHS.has(maxDepth)) {
    return NextResponse.json({ error: "maxDepth must be 1, 2, 3, 4, or 5" }, { status: 400 });
  }

  const projectRoot = findProjectRoot(process.cwd());
  const runDir = path.join(projectRoot, "results", `batch${batchId}`, folder);
  if (!fs.existsSync(runDir)) {
    return NextResponse.json({ error: `Run directory not found: ${folder}` }, { status: 404 });
  }
  if (!fs.existsSync(runArtifactPath(runDir, "oddAllTrials"))) {
    return NextResponse.json(
      { error: "odd_all_trials.json is missing. Export the ODD boundary first." },
      { status: 400 },
    );
  }

  const active = readRules(runArtifactPath(runDir, "oddRules"));
  if (active) remember(runDir, active);

  const cached = readRules(cacheFile(runDir, maxDepth));
  if (cached && Number(cached.max_depth) === maxDepth) {
    activate(runDir, cached);
    return NextResponse.json(payload(cached, true));
  }

  const fitted = await fitDepth(projectRoot, runDir, maxDepth);
  if (!fitted.ok) return NextResponse.json({ error: fitted.error }, { status: 500 });

  const doc = readRules(runArtifactPath(runDir, "oddRules"));
  if (!doc || Number(doc.max_depth) !== maxDepth) {
    return NextResponse.json({ error: "odd-rules finished without a rules file" }, { status: 500 });
  }
  remember(runDir, doc);
  activate(runDir, doc);
  return NextResponse.json(payload(doc, false));
}
