import { NextRequest, NextResponse } from "next/server";
import { spawn } from "child_process";
import fs from "fs";
import path from "path";

export const dynamic = "force-dynamic";

const MAX_RUN_MS = 180 * 1000;

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

function resolveRunDir(batchId: string, folder: string): string | null {
  const projectRoot = findProjectRoot(process.cwd());
  const runDir = path.join(projectRoot, "results", `batch${batchId}`, folder);
  return fs.existsSync(runDir) ? runDir : null;
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
  const rawIds = Array.isArray(body.trialIds) ? body.trialIds : [];
  const trialIds = rawIds.map((item) => String(item)).filter((item) => /^\d+$/.test(item));
  if (!/^\d+$/.test(batchId) || !folder || trialIds.length === 0) {
    return NextResponse.json({ error: "batchId, folder, and trialIds are required" }, { status: 400 });
  }
  const projectRoot = findProjectRoot(process.cwd());
  const runDir = resolveRunDir(batchId, folder);
  if (!runDir) {
    return NextResponse.json({ error: `Run directory not found: ${folder}` }, { status: 404 });
  }
  const preview = body.preview === true;
  const source = body.source === "lasso" ? "lasso" : "filter";
  const args = [
    path.join(projectRoot, "scripts", "run_conversation_trials.sh"),
    "--run-dir",
    runDir,
    "--trial-ids",
    trialIds.join(","),
    "--batch-id",
    batchId,
    ...(preview ? ["--sample-only", "--source", source] : ["--build"]),
  ];
  return new Promise<NextResponse>((resolve) => {
    const child = spawn("bash", args, {
      cwd: projectRoot,
      env: { ...process.env, PYTHONUNBUFFERED: "1" },
    });
    let stdout = "";
    let stderr = "";
    const timer = setTimeout(() => child.kill("SIGKILL"), MAX_RUN_MS);
    child.stdout.on("data", (d) => {
      stdout += d.toString();
    });
    child.stderr.on("data", (d) => {
      stderr += d.toString();
    });
    child.on("close", (code) => {
      clearTimeout(timer);
      if (code !== 0) {
        resolve(
          NextResponse.json(
            { error: `conversation-trials exited with code ${code}`, stderr: stderr.slice(-4000) },
            { status: 500 },
          ),
        );
        return;
      }
      try {
        const jsonStart = stdout.indexOf("{");
        resolve(NextResponse.json(JSON.parse(stdout.slice(jsonStart))));
      } catch {
        resolve(
          NextResponse.json(
            { error: "Could not parse conversation-trials output", stdout: stdout.slice(-4000) },
            { status: 500 },
          ),
        );
      }
    });
    child.on("error", (err) => {
      clearTimeout(timer);
      resolve(NextResponse.json({ error: `spawn error: ${String(err)}` }, { status: 500 }));
    });
  });
}
