import { NextRequest, NextResponse } from "next/server";
import { spawn, type ChildProcess } from "child_process";
import { randomUUID } from "crypto";
import fs from "fs";
import path from "path";
import { runArtifactPath } from "../../_lib/runArtifactPaths";

/**
 * POST /api/cluster-evaluate/run
 *
 * Body: { batchId: number, folder: string, model?: string, apiKey?: string }
 *   or  { action: "stop", jobId: string }
 *
 * Streams NDJSON:
 *   { type: "start", jobId }
 *   { type: "log", data }
 *   { type: "progress", stage, pct? }
 *   { type: "done", ok, exitCode, stopped?, quality?, logFile? }
 */

export const dynamic = "force-dynamic";

const MAX_RUN_MS = 10 * 60 * 1000;

type EvalJob = { child: ChildProcess; killed: boolean };
const evalJobs = new Map<string, EvalJob>();

function findProjectRoot(start: string): string {
  let current = path.resolve(start);
  for (let i = 0; i < 16; i++) {
    const named = path.basename(current) === "gpl-odd-project";
    const marked =
      fs.existsSync(path.join(current, "results")) &&
      fs.existsSync(path.join(current, "app"));
    if (named || marked) return current;
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  return path.resolve(start, "..", "..");
}

function killEvalJob(job: EvalJob) {
  job.killed = true;
  try {
    if (job.child.pid) process.kill(-job.child.pid, "SIGTERM");
  } catch {
    try {
      job.child.kill("SIGTERM");
    } catch {
      /* ignore */
    }
  }
}

function inferProgress(chunk: string): { stage: string; pct: number } | null {
  if (/\[selection-eval\]/i.test(chunk)) return { stage: "selection-eval", pct: 20 };
  if (/CrossClusterEvaluator|medoid|neighbor rollup|Invok|LLM/i.test(chunk)) {
    return { stage: "cross-cluster LLM", pct: 55 };
  }
  if (/\[scorer\]/i.test(chunk)) return { stage: "rescoring quality", pct: 90 };
  if (/cross_cluster_eval written/i.test(chunk)) return { stage: "done", pct: 100 };
  return null;
}

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));

  if (body.action === "stop") {
    const jobId = String(body.jobId ?? "");
    const job = evalJobs.get(jobId);
    if (job) killEvalJob(job);
    return NextResponse.json({ ok: true });
  }

  const { batchId, folder, model, apiKey } = body as {
    batchId?: number;
    folder?: string;
    model?: string;
    apiKey?: string;
  };

  if (!batchId || !folder) {
    return NextResponse.json(
      { error: "batchId and folder are required" },
      { status: 400 },
    );
  }

  const root = findProjectRoot(process.cwd());
  const runDir = path.join(root, "results", `batch${batchId}`, folder);

  if (!fs.existsSync(runDir)) {
    return NextResponse.json(
      { error: `Run dir not found: ${folder}`, lookedIn: runDir },
      { status: 404 },
    );
  }

  const llmPy = path.join(root, "app", "llm_pipeline", "python");
  const analyzerSrc = path.join(root, "app", "analyzer", "src");
  const pythonPath = [llmPy, analyzerSrc, process.env.PYTHONPATH ?? ""]
    .filter(Boolean)
    .join(path.delimiter);

  const args = ["-m", "llm_pipeline.cli", "cross-cluster-eval", "--run-dir", runDir];
  if (model) args.push("--model", String(model));
  if (apiKey) args.push("--api-key", String(apiKey));

  const env: NodeJS.ProcessEnv = {
    ...process.env,
    PYTHONPATH: pythonPath,
    PYTHONUNBUFFERED: "1",
  };
  delete env.GOOGLE_API_KEY;
  delete env.OPENAI_API_KEY;
  const trimmedKey = String(apiKey ?? "").trim();
  if (trimmedKey) {
    const m = String(model ?? "");
    if (m.startsWith("gpt") || m.startsWith("o")) env.OPENAI_API_KEY = trimmedKey;
    else env.GOOGLE_API_KEY = trimmedKey;
  }

  const encoder = new TextEncoder();
  const allLogs: string[] = [];

  const stream = new ReadableStream({
    start(controller) {
      const send = (obj: Record<string, unknown>) => {
        try {
          controller.enqueue(encoder.encode(JSON.stringify(obj) + "\n"));
        } catch {
          /* closed */
        }
      };

      const jobId = randomUUID();
      send({ type: "start", jobId });
      send({
        type: "log",
        data: `▶ Cross-cluster eval on ${folder} (${model || "default model"})\n`,
      });
      send({ type: "progress", stage: "starting", pct: 5 });

      const child = spawn("python3", args, {
        cwd: root,
        env,
        detached: true,
      });
      evalJobs.set(jobId, { child, killed: false });

      req.signal.addEventListener("abort", () => {
        const job = evalJobs.get(jobId);
        if (job) killEvalJob(job);
      });

      const timer = setTimeout(() => {
        const job = evalJobs.get(jobId);
        if (job) killEvalJob(job);
        const msg = "[timeout] cross-cluster eval exceeded time limit\n";
        allLogs.push(msg);
        send({ type: "log", data: msg });
      }, MAX_RUN_MS);

      const onData = (d: Buffer) => {
        const text = d.toString();
        allLogs.push(text);
        send({ type: "log", data: text });
        const prog = inferProgress(text);
        if (prog) send({ type: "progress", stage: prog.stage, pct: prog.pct });
      };
      child.stdout.on("data", onData);
      child.stderr.on("data", onData);

      const finish = (exitCode: number) => {
        clearTimeout(timer);
        const job = evalJobs.get(jobId);
        const wasKilled = job?.killed === true;
        evalJobs.delete(jobId);

        let quality: Record<string, unknown> = {};
        try {
          quality = JSON.parse(
            fs.readFileSync(runArtifactPath(runDir, "quality"), "utf-8"),
          );
        } catch {
          /* ignore */
        }

        let logFile = "";
        try {
          const logsDir = path.join(runDir, "logs");
          fs.mkdirSync(logsDir, { recursive: true });
          const stamp = new Date().toISOString().replace(/[:.]/g, "-");
          logFile = path.join(logsDir, `cross_cluster_eval_${stamp}.log`);
          fs.writeFileSync(
            logFile,
            `# Cross-cluster eval\n# folder: ${folder}\n# exit: ${wasKilled ? -2 : exitCode}\n\n` +
              allLogs.join(""),
            "utf-8",
          );
          logFile = path.relative(root, logFile);
        } catch {
          logFile = "";
        }

        send({
          type: "done",
          ok: !wasKilled && exitCode === 0,
          exitCode: wasKilled ? -2 : exitCode,
          stopped: wasKilled,
          quality,
          logFile,
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
