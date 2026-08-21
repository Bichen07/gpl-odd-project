import { NextRequest, NextResponse } from "next/server";
import { spawn } from "child_process";
import fs from "fs";
import os from "os";
import path from "path";

/**
 * S5 (part 2) — ODD Q&A over one run's `odd_chat_briefing.json`.
 *
 * GET  /api/odd-chat?batchId=8&folder=6_cluster_s=0.6113
 *   Reads back the persisted conversation for this run from
 *   `odd_chat_log.jsonl` (one line per turn, appended by every previous POST
 *   — including turns asked from a plain terminal via
 *   `python -m llm_pipeline.cli odd-chat`). This is what lets the dashboard
 *   show prior history again after closing and reopening the browser tab —
 *   the history lives in the run folder, not in browser storage.
 *
 * POST /api/odd-chat
 *   body: { batchId, folder, question, model?, apiKey?, historyTurns? }
 *   Spawns scripts/run_odd_chat.sh (analyzer conda env) -> `llm_pipeline.cli
 *   odd-chat`, which (a) re-attaches the deterministic briefing JSON fresh on
 *   every turn, (b) sends only the last `historyTurns` dialog turns (default
 *   8) as short-term memory, (c) calls the LLM, and (d) appends the new turn
 *   to odd_chat_log.jsonl itself — so this route never has to manage
 *   conversation storage; the CLI/Python side is the single source of truth.
 *
 * The API key is ephemeral: injected into the spawned process env only and
 * never written to disk or echoed back in logs (same convention as
 * /api/cluster-analyze/run).
 */

export const dynamic = "force-dynamic";

const MAX_RUN_MS = 90 * 1000; // one grounded Q&A turn, not a whole analysis run

type ChatLogEntry = {
  timestamp: string;
  question: string;
  answer: string;
  citations: string[];
  model: string;
  dry_run: boolean;
  briefing_generated_at?: string | null;
};

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

function readChatLog(runDir: string): ChatLogEntry[] {
  const p = path.join(runDir, "odd_chat_log.jsonl");
  if (!fs.existsSync(p)) return [];
  const lines = fs.readFileSync(p, "utf-8").split("\n").filter((l) => l.trim());
  const out: ChatLogEntry[] = [];
  for (const line of lines) {
    try {
      out.push(JSON.parse(line));
    } catch {
      /* skip malformed line */
    }
  }
  return out;
}

// GET — hydrate prior conversation (persisted in the run folder, not the browser).
export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const batchId = url.searchParams.get("batchId") ?? "";
  const folder = url.searchParams.get("folder") ?? "";
  if (!/^\d+$/.test(batchId) || !folder) {
    return NextResponse.json({ error: "batchId (int) and folder required" }, { status: 400 });
  }
  const runDir = resolveRunDir(batchId, folder);
  if (!runDir) {
    return NextResponse.json({ error: `Run directory not found: ${folder}` }, { status: 404 });
  }

  const briefingPath = path.join(runDir, "odd_chat_briefing.json");
  const briefingAvailable = fs.existsSync(briefingPath);
  let missing: string[] = [];
  if (briefingAvailable) {
    try {
      const doc = JSON.parse(fs.readFileSync(briefingPath, "utf-8"));
      missing = doc.missing ?? [];
    } catch {
      /* leave missing empty */
    }
  }

  const history = readChatLog(runDir);
  return NextResponse.json({ briefingAvailable, missing, history });
}

// POST — ask one grounded question; the CLI appends it to the persisted log itself.
export async function POST(req: NextRequest) {
  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "invalid JSON body" }, { status: 400 });
  }

  const batchId = String(body.batchId ?? "");
  const folder = String(body.folder ?? "");
  const question = typeof body.question === "string" ? body.question.trim() : "";
  const model = typeof body.model === "string" && body.model ? body.model : "gemini-2.5-flash";
  const apiKey = typeof body.apiKey === "string" ? body.apiKey : "";
  const historyTurns = typeof body.historyTurns === "number" ? body.historyTurns : 8;

  if (!/^\d+$/.test(batchId) || !folder) {
    return NextResponse.json({ error: "batchId (int) and folder required" }, { status: 400 });
  }
  if (!question) {
    return NextResponse.json({ error: "question is required" }, { status: 400 });
  }

  const projectRoot = findProjectRoot(process.cwd());
  const runDir = resolveRunDir(batchId, folder);
  if (!runDir) {
    return NextResponse.json({ error: `Run directory not found: ${folder}` }, { status: 404 });
  }
  if (!fs.existsSync(path.join(runDir, "odd_chat_briefing.json"))) {
    return NextResponse.json(
      {
        error:
          "odd_chat_briefing.json not found for this run. Build it first: " +
          "python -m llm_pipeline.cli odd-briefing --run-dir results/batch" +
          batchId +
          "/" +
          folder +
          " (needs S2 odd-export first for the boundary section).",
      },
      { status: 400 },
    );
  }

  // Reconstruct the last N dialog turns (role/content) from the persisted
  // log so the LLM has short-term memory, matching odd_chat.py's own
  // `history` contract — the briefing itself is re-attached fresh by the
  // CLI every turn so old hallucinations can't silently "stick".
  const priorTurns = readChatLog(runDir);
  const asMessages: Array<{ role: string; content: string }> = [];
  for (const t of priorTurns.slice(-historyTurns)) {
    asMessages.push({ role: "user", content: t.question });
    asMessages.push({ role: "assistant", content: t.answer });
  }

  const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "gpl-odd-chat-"));
  const historyPath = path.join(tmpDir, "history.json");
  fs.writeFileSync(historyPath, JSON.stringify(asMessages), "utf-8");

  const args = [
    path.join(projectRoot, "scripts", "run_odd_chat.sh"),
    "--run-dir",
    runDir,
    "--question",
    question,
    "--model",
    model,
    "--history-json",
    historyPath,
    "--temperature",
    "0.1",
  ];

  const env: NodeJS.ProcessEnv = { ...process.env, PYTHONUNBUFFERED: "1" };
  if (apiKey) {
    if (model.startsWith("gpt") || model.startsWith("o")) env.OPENAI_API_KEY = apiKey;
    else env.GOOGLE_API_KEY = apiKey;
  }

  return new Promise<NextResponse>((resolve) => {
    const child = spawn("bash", args, { cwd: projectRoot, env });
    let stdout = "";
    let stderr = "";

    const timer = setTimeout(() => {
      child.kill("SIGKILL");
    }, MAX_RUN_MS);

    child.stdout.on("data", (d) => {
      stdout += d.toString();
    });
    child.stderr.on("data", (d) => {
      stderr += d.toString();
    });

    child.on("close", (code) => {
      clearTimeout(timer);
      try {
        fs.rmSync(tmpDir, { recursive: true, force: true });
      } catch {
        /* best effort cleanup */
      }
      if (code !== 0) {
        resolve(
          NextResponse.json(
            { error: `odd-chat exited with code ${code}`, stderr: stderr.slice(-4000) },
            { status: 500 },
          ),
        );
        return;
      }
      // cli.py prints the JSON result as the last stdout line (json.dumps(..., indent=2)).
      try {
        const jsonStart = stdout.indexOf("{");
        const parsed = JSON.parse(stdout.slice(jsonStart));
        resolve(NextResponse.json(parsed));
      } catch {
        resolve(
          NextResponse.json(
            { error: "Could not parse odd-chat output", stdout: stdout.slice(-4000) },
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
