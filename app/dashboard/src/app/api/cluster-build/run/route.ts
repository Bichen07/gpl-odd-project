import { NextRequest } from "next/server";
import { spawn, type ChildProcess } from "child_process";
import fs from "fs";
import path from "path";
import { randomUUID } from "crypto";

/**
 * POST /api/cluster-build/run
 *
 * Spawns `python3 app/analyzer/src/dataset_builder.py --batch-id … --k …
 * --silhouette …` (conda env `analyzer`) and streams NDJSON progress:
 *   { type: "start", jobId }
 *   { type: "log", data }
 *   { type: "progress", pct, stage }
 *   { type: "done", ok, exitCode, folder, jobId }
 *
 * POST /api/cluster-build/stop  { jobId }  → kill the running build.
 */

export const dynamic = "force-dynamic";

const MAX_RUN_MS = 60 * 60 * 1000; // BEV builds can be long

type Job = {
  child: ChildProcess;
  killed: boolean;
};

// In-process job registry (single Next.js server instance).
const jobs = new Map<string, Job>();

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

function estimateProgress(logText: string, k: number): { pct: number; stage: string } {
  const lower = logText;
  if (/✅\s*LLM dataset build complete|Done!\s*See the/i.test(lower)) {
    return { pct: 100, stage: "done" };
  }
  if (/Processing auxiliary|Outlier cluster|boundary/i.test(lower)) {
    return { pct: 90, stage: "auxiliary trials" };
  }
  const clusterHits = lower.match(/🔹 Processing cluster/g)?.length ?? 0;
  if (clusterHits > 0 && k > 0) {
    // Reserve 10% for load, 80% for clusters, 10% for wrap-up.
    const frac = Math.min(clusterHits / k, 1);
    return {
      pct: Math.min(90, Math.round(10 + frac * 80)),
      stage: `cluster ${Math.min(clusterHits, k)} / ${k}`,
    };
  }
  if (/Computing cluster medoids|Selected k=/i.test(lower)) {
    return { pct: 8, stage: "selecting clustering" };
  }
  if (/Loading clustering from Payload|Building LLM dataset/i.test(lower)) {
    return { pct: 3, stage: "loading analysis" };
  }
  return { pct: 1, stage: "starting" };
}

function parseOutputFolder(allLogs: string): string | null {
  const m = allLogs.match(/📁 Output dir:\s*(results\/batch\d+\/[^\s]+)/);
  if (m) {
    const parts = m[1].split("/");
    return parts[parts.length - 1] ?? null;
  }
  return null;
}

function buildSpawnCommand(
  projectRoot: string,
  batchId: string,
  k: string,
  s: string,
): { cmd: string; args: string[]; display: string } {
  const py = path.join(projectRoot, "app", "analyzer", "src", "dataset_builder.py");
  const llmPy = path.join(projectRoot, "app", "llm_pipeline", "python");
  const analyzerSrc = path.join(projectRoot, "app", "analyzer", "src");
  const display =
    `python3 app/analyzer/src/dataset_builder.py ` +
    `--batch-id ${batchId} --k ${k} --silhouette ${s}`;
  // Activate conda analyzer (pandas etc.) then run dataset_builder.
  const shell = [
    `cd ${JSON.stringify(projectRoot)}`,
    `source "$(conda info --base)/etc/profile.d/conda.sh"`,
    `conda activate analyzer`,
    `export PYTHONPATH=${JSON.stringify(`${llmPy}:${analyzerSrc}`)}:\${PYTHONPATH:-}`,
    `export PYTHONUNBUFFERED=1`,
    `exec python3 ${JSON.stringify(py)} --batch-id ${batchId} --k ${k} --silhouette ${s}`,
  ].join(" && ");
  return { cmd: "bash", args: ["-lc", shell], display };
}

export async function POST(req: NextRequest) {
  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }

  // Stop an in-flight build.
  if (body.action === "stop") {
    const jobId = String(body.jobId ?? "");
    const job = jobs.get(jobId);
    if (!job) {
      return Response.json({ ok: true, message: "no such job (already finished?)" });
    }
    job.killed = true;
    try {
      // Kill the whole process group started with detached:true / setsid.
      if (job.child.pid) {
        process.kill(-job.child.pid, "SIGTERM");
      }
    } catch {
      try {
        job.child.kill("SIGTERM");
      } catch {
        /* ignore */
      }
    }
    setTimeout(() => {
      try {
        if (job.child.pid) process.kill(-job.child.pid, "SIGKILL");
      } catch {
        try {
          job.child.kill("SIGKILL");
        } catch {
          /* ignore */
        }
      }
    }, 2000);
    return Response.json({ ok: true, stopped: true, jobId });
  }

  const batchId = String(body.batchId ?? "");
  const k = String(body.k ?? "");
  const s = String(body.s ?? "");
  if (!/^\d+$/.test(batchId) || !/^\d+$/.test(k) || !/^[-0-9.]+$/.test(s)) {
    return Response.json(
      { error: "valid batchId, k, and silhouette (s) required" },
      { status: 400 },
    );
  }

  const projectRoot = findProjectRoot(process.cwd());
  const py = path.join(projectRoot, "app", "analyzer", "src", "dataset_builder.py");
  if (!fs.existsSync(py)) {
    return Response.json({ error: `dataset_builder not found: ${py}` }, { status: 500 });
  }

  const kNum = Number(k);
  const jobId = randomUUID();
  const { cmd, args, display } = buildSpawnCommand(projectRoot, batchId, k, s);

  const encoder = new TextEncoder();
  const allLogs: string[] = [];
  let lastPct = 0;

  const stream = new ReadableStream({
    start(controller) {
      const send = (obj: Record<string, unknown>) => {
        try {
          controller.enqueue(encoder.encode(JSON.stringify(obj) + "\n"));
        } catch {
          /* closed */
        }
      };

      send({ type: "start", jobId });
      send({ type: "log", data: `▶ ${display}\n` });

      // Start a new process group so Stop can kill children (conda/python).
      const child = spawn(cmd, args, {
        cwd: projectRoot,
        env: { ...process.env, PYTHONUNBUFFERED: "1" },
        detached: true,
      });
      jobs.set(jobId, { child, killed: false });

      const timer = setTimeout(() => {
        const job = jobs.get(jobId);
        if (!job) return;
        job.killed = true;
        try {
          if (child.pid) process.kill(-child.pid, "SIGKILL");
        } catch {
          child.kill("SIGKILL");
        }
        const msg = "[timeout] dataset build exceeded time limit\n";
        allLogs.push(msg);
        send({ type: "log", data: msg });
      }, MAX_RUN_MS);

      const onData = (d: Buffer) => {
        const text = d.toString();
        allLogs.push(text);
        send({ type: "log", data: text });
        const { pct, stage } = estimateProgress(allLogs.join(""), kNum);
        if (pct > lastPct) {
          lastPct = pct;
          send({ type: "progress", pct, stage });
        }
      };
      child.stdout.on("data", onData);
      child.stderr.on("data", onData);

      const finish = (exitCode: number) => {
        clearTimeout(timer);
        const job = jobs.get(jobId);
        const wasKilled = job?.killed === true;
        jobs.delete(jobId);

        const folder = parseOutputFolder(allLogs.join(""));
        if (!wasKilled && exitCode === 0) {
          send({ type: "progress", pct: 100, stage: "done" });
        }
        send({
          type: "done",
          ok: !wasKilled && exitCode === 0,
          exitCode: wasKilled ? -2 : exitCode,
          stopped: wasKilled,
          folder,
          jobId,
        });
        controller.close();
      };

      child.on("close", (code) => finish(code ?? -1));
      child.on("error", (err) => {
        allLogs.push(`[spawn error] ${String(err)}\n`);
        send({ type: "log", data: `[spawn error] ${String(err)}\n` });
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
