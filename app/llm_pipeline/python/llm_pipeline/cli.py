from __future__ import annotations

import argparse
from pathlib import Path

from .context_builder import build_context
from .cluster_interpret import cluster_interpret
from .evaluate import evaluate_run
from .llm_runner import run_llm
from .prompt_builder import build_prompt


def _source_path() -> Path:
    return Path(__file__).resolve()


def main() -> None:
    parser = argparse.ArgumentParser(description="GPL-ODD LLM pipeline CLI")
    sub = parser.add_subparsers(dest="cmd", required=True)
    for name in ("context", "prompt", "llm", "eval", "cluster-interpret"):
        p = sub.add_parser(name)
        p.add_argument("--run-id", required=True)

    ci = sub.choices["cluster-interpret"]
    ci.add_argument("--dataset", help="dataset1|dataset2|dataset3 (else manifest)")
    ci.add_argument(
        "--model",
        nargs="+",
        default=["gemini-2.5-flash"],
        help="LLM model (default gemini-2.5-flash; GOOGLE_API_KEY for gemini-*)",
    )
    ci.add_argument(
        "--dry-run",
        action="store_true",
        help="Write stub YAML without calling the LLM",
    )

    args = parser.parse_args()
    source = _source_path()
    if args.cmd == "context":
        out = build_context(source, args.run_id)
    elif args.cmd == "prompt":
        out = build_prompt(source, args.run_id)
    elif args.cmd == "llm":
        out = run_llm(source, args.run_id)
    elif args.cmd == "cluster-interpret":
        model = " ".join(getattr(args, "model", ["gemini-2.5-flash"]))
        out = cluster_interpret(
            source,
            args.run_id,
            dataset=getattr(args, "dataset", None),
            model=model,
            dry_run=getattr(args, "dry_run", False),
        )
    else:
        out = evaluate_run(source, args.run_id)
    print(out)


if __name__ == "__main__":
    main()
