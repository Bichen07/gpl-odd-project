import { NextRequest } from "next/server";
import { spawn } from "child_process";
import fs from "fs";
import os from "os";
import path from "path";

/**
 * POST /api/cluster-analyze/run
 *
 * Runs cluster interpretation on a builder results folder with UI overrides and
 * STREAMS progress back as NDJSON (one JSON object per line):
 *   { "type": "log",  "data": "<chunk of stdout/stderr>" }
 *   { "type": "done", "ok": bool, "exitCode": n, "results": [...], "logFile": "..." }
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

export const dynamic = "force-dynamic";

const MAX_RUN_MS = 15 * 60 * 1000; // generous: multiple clusters x 2 LLM passes

// Taiwan (UTC+8) timestamp for log filenames + headers.
function taipeiNow(): { stamp: string; human: string } {
  const parts = new Intl.DateTimeFormat("sv-SE", {
    timeZone: "Asia/Taipei",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
    hour12: false,
  }).format(new Date()); // e.g. "2026-06-30 13:36:03"
  return {
    human: `${parts} (UTC+8)`,
    stamp: parts.replace(" ", "_").replace(/:/g, "-"), // 2026-06-30_13-36-03
  };
}

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

function collectResults(
  resultsDir: string,
  clusters: number[] | null,
): Array<Record<string, unknown>> {
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
    if (meta || rawYaml) results.push({ cluster: cid, meta, rawYaml });
  }
  results.sort((a, b) => (a.cluster as number) - (b.cluster as number));
  return results;
}

export async function POST(req: NextRequest) {
  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
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
  const products =
    typeof body.products === "string" && body.products.trim()
      ? body.products.trim()
      : "medoid,summary,ic-pairs";

  if (!/^\d+$/.test(batchId) || !/^\d+_cluster_s=[-0-9.]+$/.test(folder)) {
    return Response.json({ error: "invalid batchId or folder" }, { status: 400 });
  }

  const projectRoot = findProjectRoot(process.cwd());
  const resultsDir = path.join(projectRoot, "results", `batch${batchId}`, folder);
  if (!fs.existsSync(resultsDir)) {
    return Response.json({ error: `results dir not found: ${resultsDir}` }, { status: 404 });
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
    "--products",
    products,
  ];
  if (!review) args.push("--no-review");
  if (dryRun) args.push("--dry-run");
  if (clusters && clusters.length > 0) args.push("--clusters", clusters.join(","));

  // Inject API key into the correct provider env var (ephemeral). PYTHONUNBUFFERED
  // makes the child's progress prints stream live instead of buffering.
  const env: NodeJS.ProcessEnv = { ...process.env, PYTHONUNBUFFERED: "1" };
  if (apiKey) {
    if (model.startsWith("gpt") || model.startsWith("o")) env.OPENAI_API_KEY = apiKey;
    else env.GOOGLE_API_KEY = apiKey;
  }

  const encoder = new TextEncoder();
  const allLogs: string[] = [];

  const stream = new ReadableStream({
    start(controller) {
      const send = (obj: Record<string, unknown>) => {
        try {
          controller.enqueue(encoder.encode(JSON.stringify(obj) + "\n"));
        } catch {
          /* controller already closed */
        }
      };

      send({ type: "log", data: `▶ Running ${clusters && clusters.length ? `cluster(s) ${clusters.join(", ")}` : "all clusters"} with ${model}${dryRun ? " (dry run)" : ""}\n` });

      const child = spawn("bash", args, { cwd: projectRoot, env });
      const timer = setTimeout(() => {
        child.kill("SIGKILL");
        const msg = "[timeout] analysis exceeded time limit\n";
        allLogs.push(msg);
        send({ type: "log", data: msg });
      }, MAX_RUN_MS);

      const onData = (d: Buffer) => {
        const text = d.toString();
        allLogs.push(text);
        send({ type: "log", data: text });
      };
      child.stdout.on("data", onData);
      child.stderr.on("data", onData);

      const finish = (exitCode: number) => {
        clearTimeout(timer);
        // Clean up ephemeral overrides.
        try {
          fs.rmSync(tmpDir, { recursive: true, force: true });
        } catch {
          /* ignore */
        }

        const results = collectResults(resultsDir, clusters);

        // Persist the run log for later analysis (no API key is ever logged).
        let logFile = "";
        try {
          const logsDir = path.join(resultsDir, "logs");
          fs.mkdirSync(logsDir, { recursive: true });
          const { stamp, human } = taipeiNow();
          const tag = clusters && clusters.length ? `c${clusters.join("-")}` : "all";
          logFile = path.join(logsDir, `analysis_${stamp}_${tag}.log`);
          const header =
            `# LLM cluster analysis run\n` +
            `# time: ${human}\n` +
            `# model: ${model} | temperature: ${temperature} | review: ${review} | dryRun: ${dryRun}\n` +
            `# clusters: ${clusters && clusters.length ? clusters.join(", ") : "all"}\n` +
            `# exitCode: ${exitCode}\n\n`;
          fs.writeFileSync(logFile, header + allLogs.join(""), "utf-8");
        } catch {
          logFile = "";
        }

        send({
          type: "done",
          ok: exitCode === 0,
          exitCode,
          results,
          logFile: logFile ? path.relative(projectRoot, logFile) : "",
        });
        controller.close();
      };

      child.on("close", (code) => finish(code ?? -1));
      child.on("error", (err) => {
        const msg = `[spawn error] ${String(err)}\n`;
        allLogs.push(msg);
        send({ type: "log", data: msg });
        finish(-1);
      });
    },
  });

  return new Response(stream, {
    headers: {
      "Content-Type": "application/x-ndjson; charset=utf-8",
      "Cache-Control": "no-cache, no-transform",
      "X-Accel-Buffering": "no",
    },
  });
}
