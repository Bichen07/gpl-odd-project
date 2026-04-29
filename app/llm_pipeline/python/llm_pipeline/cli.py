from __future__ import annotations

import argparse
from pathlib import Path

from .context_builder import build_context
from .evaluate import evaluate_run
from .llm_runner import run_llm
from .prompt_builder import build_prompt


def _source_path() -> Path:
    return Path(__file__).resolve()


def main() -> None:
    parser = argparse.ArgumentParser(description="GPL-ODD LLM pipeline CLI")
    sub = parser.add_subparsers(dest="cmd", required=True)
    for name in ("context", "prompt", "llm", "eval"):
        p = sub.add_parser(name)
        p.add_argument("--run-id", required=True)

    args = parser.parse_args()
    source = _source_path()
    if args.cmd == "context":
        out = build_context(source, args.run_id)
    elif args.cmd == "prompt":
        out = build_prompt(source, args.run_id)
    elif args.cmd == "llm":
        out = run_llm(source, args.run_id)
    else:
        out = evaluate_run(source, args.run_id)
    print(out)


if __name__ == "__main__":
    main()
