import { NextRequest, NextResponse } from "next/server";
import { spawn } from "child_process";
import path from "path";

/**
 * POST /api/cluster-evaluate/run
 *
 * Body: { batchId: number, folder: string, model?: string, apiKey?: string }
 *
 * Triggers the cross-cluster LLM evaluation for one clustering configuration
 * directory (results/batch<id>/<folder>/), then re-scores to update
 * clustering_quality.json.  Returns the updated quality JSON.
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

function runPythonScript(
  scriptPath: string,
  args: string[],
  env: NodeJS.ProcessEnv,
  timeoutMs = 300_000
): Promise<{ stdout: string; stderr: string; code: number }> {
  return new Promise((resolve) => {
    const proc = spawn("python3", [scriptPath, ...args], {
      env: { ...process.env, ...env },
      cwd: path.dirname(scriptPath),
    });
    let stdout = "";
    let stderr = "";
    proc.stdout.on("data", (d) => (stdout += d));
    proc.stderr.on("data", (d) => (stderr += d));
    const timer = setTimeout(() => {
      proc.kill("SIGTERM");
      resolve({ stdout, stderr: stderr + "\n[timeout]", code: 124 });
    }, timeoutMs);
    proc.on("close", (code) => {
      clearTimeout(timer);
      resolve({ stdout, stderr, code: code ?? 1 });
    });
  });
}

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));
  const { batchId, folder, model, apiKey } = body as {
    batchId?: number;
    folder?: string;
    model?: string;
    apiKey?: string;
  };

  if (!batchId || !folder) {
    return NextResponse.json(
      { error: "batchId and folder are required" },
      { status: 400 }
    );
  }

  const root = findProjectRoot(__dirname);
  const runDir = path.join(root, "results", `batch${batchId}`, folder);

  if (!require("fs").existsSync(runDir)) {
    return NextResponse.json({ error: `Run dir not found: ${folder}` }, { status: 404 });
  }

  // Run cross_cluster_eval + rescore via a small Python helper CLI
  const scriptPath = path.join(
    root,
    "app",
    "llm_pipeline",
    "python",
    "llm_pipeline",
    "cli.py"
  );

  const args = ["cross-cluster-eval", "--run-dir", runDir];
  if (model) args.push("--model", model);
  const env: NodeJS.ProcessEnv = {};
  if (apiKey) {
    env.GOOGLE_API_KEY = apiKey;
    env.OPENAI_API_KEY = apiKey;
  }

  const result = await runPythonScript(scriptPath, args, env);

  if (result.code !== 0) {
    return NextResponse.json(
      { error: "Cross-cluster eval failed", stderr: result.stderr },
      { status: 500 }
    );
  }

  // Read updated quality.json
  const qualityPath = path.join(runDir, "clustering_quality.json");
  let quality: Record<string, unknown> = {};
  try {
    quality = JSON.parse(require("fs").readFileSync(qualityPath, "utf-8"));
  } catch {
    // not fatal — return what we have
  }

  return NextResponse.json({ ok: true, quality, stdout: result.stdout });
}
