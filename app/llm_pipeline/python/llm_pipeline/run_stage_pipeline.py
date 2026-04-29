from __future__ import annotations

import argparse
from pathlib import Path

from .context_builder import build_context
from .evaluate import evaluate_run
from .llm_runner import run_llm
from .prompt_builder import build_prompt


def main() -> None:
    parser = argparse.ArgumentParser(description="Run stage2-stage5 pipeline")
    parser.add_argument("--run-id", required=True)
    args = parser.parse_args()

    source = Path(__file__).resolve()
    build_context(source, args.run_id)
    build_prompt(source, args.run_id)
    run_llm(source, args.run_id)
    report = evaluate_run(source, args.run_id)
    print(report)


if __name__ == "__main__":
    main()
