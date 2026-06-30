import { NextRequest, NextResponse } from "next/server";
import { spawn } from "child_process";
import fs from "fs";
import os from "os";
import path from "path";

/**
 * POST /api/cluster-analyze/run
 *
 * Runs cluster interpretation on a builder results folder with UI overrides,
 * then returns each cluster's interpretation YAML + token usage.
 *
 * Body: {
 *   batchId, folder, clusters?: number[], model, apiKey?, temperature?,
 *   review?: boolean, prompts?: {system,common_sense,interaction,reviewer},
 *   selectedImages?: { [clusterId]: string[] }, dryRun?: boolean
 * }
 *
 * The API key is ephemeral: injected into the spawned process env only and
 * never written to disk or echoed back in logs.
 */

const MAX_RUN_MS = 15 * 60 * 1000; // generous: multiple clusters x 2 LLM passes

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

export async function POST(req: NextRequest) {
  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "invalid JSON body" }, { status: 400 });
  }

  const batchId = String(body.batchId ?? "");
  const folder = String(body.folder ?? "");
  const model = String(body.model ?? "gemini-2.5-flash");
  const apiKey = typeof body.apiKey === "string" ? body.apiKey : "";
  const temperature = typeof body.temperature === "number" ? body.temperature : 0.1;
  const review = body.review !== false; // default on
  const dryRun = body.dryRun === true;
  const clusters = Array.isArray(body.clusters) ? body.clusters.map((c) => Number(c)) : null;
  const prompts = (body.prompts ?? {}) as Record<string, string>;
  const selectedImages = (body.selectedImages ?? {}) as Record<string, string[]>;

  if (!/^\d+$/.test(batchId) || !/^\d+_cluster_s=[-0-9.]+$/.test(folder)) {
    return NextResponse.json({ error: "invalid batchId or folder" }, { status: 400 });
  }

  const projectRoot = findProjectRoot(process.cwd());
  const resultsDir = path.join(projectRoot, "results", `batch${batchId}`, folder);
  if (!fs.existsSync(resultsDir)) {
    return NextResponse.json({ error: `results dir not found: ${resultsDir}` }, { status: 404 });
  }

  // Write overrides to an ephemeral temp dir.
  const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "gpl-odd-analyze-"));
  const promptsPath = path.join(tmpDir, "prompts.json");
  const imagesPath = path.join(tmpDir, "images.json");
  fs.writeFileSync(promptsPath, JSON.stringify(prompts), "utf-8");
  fs.writeFileSync(imagesPath, JSON.stringify(selectedImages), "utf-8");

  const args = [
    path.join(projectRoot, "scripts", "run_cluster_analyze.sh"),
    "--results-dir",
    resultsDir,
    "--batch-id",
    batchId,
    "--model",
    model,
    "--temperature",
    String(temperature),
    "--prompts-json",
    promptsPath,
    "--images-json",
    imagesPath,
  ];
  if (!review) args.push("--no-review");
  if (dryRun) args.push("--dry-run");
  if (clusters && clusters.length > 0) {
    args.push("--clusters", clusters.join(","));
  }

  // Inject API key into the correct provider env var (ephemeral).
  const env: NodeJS.ProcessEnv = { ...process.env };
  if (apiKey) {
    if (model.startsWith("gpt") || model.startsWith("o")) {
      env.OPENAI_API_KEY = apiKey;
    } else {
      env.GOOGLE_API_KEY = apiKey;
    }
  }

  const logs: string[] = [];
  const exitCode = await new Promise<number>((resolve) => {
    const child = spawn("bash", args, { cwd: projectRoot, env });
    const timer = setTimeout(() => {
      child.kill("SIGKILL");
      logs.push("[timeout] analysis exceeded time limit");
    }, MAX_RUN_MS);
    child.stdout.on("data", (d) => logs.push(d.toString()));
    child.stderr.on("data", (d) => logs.push(d.toString()));
    child.on("close", (code) => {
      clearTimeout(timer);
      resolve(code ?? -1);
    });
    child.on("error", (err) => {
      clearTimeout(timer);
      logs.push(`[spawn error] ${String(err)}`);
      resolve(-1);
    });
  });

  // Clean up temp overrides (key was never written here, but be tidy).
  try {
    fs.rmSync(tmpDir, { recursive: true, force: true });
  } catch {
    /* ignore */
  }

  // Collect per-cluster results.
  const results: Array<Record<string, unknown>> = [];
  for (const entry of fs.readdirSync(resultsDir, { withFileTypes: true })) {
    const m = entry.isDirectory() ? entry.name.match(/^cluster(\d+)$/) : null;
    if (!m) continue;
    const cid = parseInt(m[1], 10);
    if (clusters && clusters.length > 0 && !clusters.includes(cid)) continue;
    const clusterDir = path.join(resultsDir, entry.name);
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
      results.push({ cluster: cid, meta, rawYaml });
    }
  }
  results.sort((a, b) => (a.cluster as number) - (b.cluster as number));

  return NextResponse.json({
    ok: exitCode === 0,
    exitCode,
    logs: logs.join(""),
    results,
  });
}
