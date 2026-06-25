import { NextRequest, NextResponse } from "next/server";
import { spawn } from "child_process";
import path from "path";
import fs from "fs";

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
  const body = await req.json();
  const {
    runId,
    dataset,
    model = "gemini-2.5-flash",
    apiKey,
    dryRun = false,
  } = body as {
    runId: string;
    dataset: string;
    model?: string;
    apiKey?: string;
    dryRun?: boolean;
  };

  if (!runId || !dataset) {
    return NextResponse.json(
      { error: "runId and dataset are required" },
      { status: 400 },
    );
  }

  const projectRoot = findProjectRoot(process.cwd());
  const runDir = path.join(projectRoot, "llm_artifacts", runId);

  if (!fs.existsSync(runDir)) {
    return NextResponse.json(
      {
        error: `Run directory not found: llm_artifacts/${runId}. Build Phase 4 artifacts first.`,
      },
      { status: 404 },
    );
  }

  const analyzerSrc = path.join(projectRoot, "app", "analyzer", "src");
  const pipelinePython = path.join(
    projectRoot,
    "app",
    "llm_pipeline",
    "python",
  );

  const env: NodeJS.ProcessEnv = {
    ...process.env,
    PYTHONPATH: `${pipelinePython}:${analyzerSrc}:${process.env.PYTHONPATH || ""}`,
  };
  if (apiKey) {
    const m = String(model).toLowerCase();
    if (m.startsWith("gemini")) {
      env.GOOGLE_API_KEY = apiKey;
    } else {
      env.OPENAI_API_KEY = apiKey;
    }
  }

  const args = [
    "-m",
    "llm_pipeline.cli",
    "cluster-interpret",
    "--run-id",
    runId,
    "--dataset",
    dataset,
    "--model",
    model,
  ];
  if (dryRun) {
    args.push("--dry-run");
  }

  return new Promise<NextResponse>((resolve) => {
    const logs: string[] = [];
    const child = spawn("python3", args, { cwd: projectRoot, env });

    const timeout = setTimeout(() => {
      child.kill("SIGTERM");
      logs.push("⏱️ Timeout: process killed after 120s");
      resolve(
        NextResponse.json({ ok: false, logs: logs.join("\n") }, { status: 504 }),
      );
    }, 120_000);

    child.stdout.on("data", (d) => logs.push(d.toString()));
    child.stderr.on("data", (d) => logs.push(d.toString()));
    child.on("close", (code) => {
      clearTimeout(timeout);
      resolve(
        NextResponse.json({ ok: code === 0, exitCode: code, logs: logs.join("\n") }),
      );
    });
    child.on("error", (err) => {
      clearTimeout(timeout);
      resolve(
        NextResponse.json(
          { ok: false, error: err.message, logs: logs.join("\n") },
          { status: 500 },
        ),
      );
    });
  });
}
