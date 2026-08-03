from __future__ import annotations

import argparse
from pathlib import Path


def _source_path() -> Path:
    return Path(__file__).resolve()


def main() -> None:
    parser = argparse.ArgumentParser(description="GPL-ODD LLM pipeline CLI")
    sub = parser.add_subparsers(dest="cmd", required=True)

    # cluster-interpret runs on the builder layout:
    # results/batch<id>/<k>_cluster_s=.../cluster<N>/ (via --results-dir).
    ci = sub.add_parser("cluster-interpret")
    ci.add_argument("--results-dir", required=True,
                    help="results/batch<id>/<k>_cluster_s=.../ (builder layout)")
    ci.add_argument("--batch-id", type=int, default=None,
                    help="Payload batch id (resolves dataset via dataset_config). Preferred.")
    ci.add_argument("--dataset", help="Internal alias dataset1|dataset2|dataset3 (else manifest)")
    ci.add_argument(
        "--model",
        nargs="+",
        default=["gemini-2.5-flash"],
        help="LLM model (default gemini-2.5-flash; GOOGLE_API_KEY for gemini-*)",
    )
    ci.add_argument(
        "--products",
        default="medoid",
        help="Comma list: medoid[,summary][,ic-pairs]. Default is medoid only "
             "(one YAML: output/medoid_trial.yaml). Use 'all' for all products.",
    )
    ci.add_argument("--api-key", default=None, help="API key (overrides env; ephemeral)")
    ci.add_argument("--clusters", default=None,
                    help="Comma list of cluster ids to run (default: all)")
    ci.add_argument("--prompts-json", default=None,
                    help="Path to JSON with prompt overrides (system|common_sense|interaction|reviewer)")
    ci.add_argument("--images-json", default=None,
                    help="Path to JSON mapping cluster id -> [snapshot file names]")
    ci.add_argument("--temperature", type=float, default=0.1)
    ci.add_argument("--max-llm-snapshots", type=int, default=10,
                    help="Even-subsample cap when no explicit image selection (0 = all)")
    ci.add_argument(
        "--dry-run",
        action="store_true",
        help="Write stub YAML without calling the LLM",
    )

    # cross-cluster-eval: run Phase 6b + rescore for one run directory
    cce = sub.add_parser("cross-cluster-eval")
    cce.add_argument("--run-dir", required=True,
                     help="results/batch<id>/<k>_cluster_s=.../ directory to evaluate")
    cce.add_argument("--model", default="gemini-2.5-flash",
                     help="LLM model (default gemini-2.5-flash)")
    cce.add_argument("--api-key", default=None)
    cce.add_argument("--temperature", type=float, default=0.1)
    cce.add_argument("--dry-run", action="store_true")

    args = parser.parse_args()
    source = _source_path()
    if args.cmd == "cross-cluster-eval":
        from .cross_cluster_evaluator import run_cross_cluster_eval
        from .clustering_quality_scorer import score_run_dir

        result_path = run_cross_cluster_eval(
            run_dir=Path(args.run_dir),
            model=getattr(args, "model", "gemini-2.5-flash"),
            temperature=getattr(args, "temperature", 0.1),
            api_key=getattr(args, "api_key", None),
            dry_run=getattr(args, "dry_run", False),
        )
        if result_path:
            score_run_dir(Path(args.run_dir))
            out = f"cross_cluster_eval written to {result_path}"
        else:
            out = "cross-cluster-eval failed"
    elif args.cmd == "cluster-interpret":
        import json as _json
        model = " ".join(getattr(args, "model", ["gemini-2.5-flash"]))
        dataset = getattr(args, "dataset", None)
        batch_id = getattr(args, "batch_id", None)
        if not dataset and batch_id is not None:
            import sys as _sys
            _sys.path.insert(0, str(source.parents[3] / "analyzer" / "src"))
            try:
                from dataset_config import dataset_for_batch_id
                dataset = dataset_for_batch_id(batch_id)
            except Exception:
                dataset = None

        # Builder layout: results/batch<id>/<k>_cluster_s=.../cluster<N>/
        from .split_analysis import run_split_analysis

        prompt_overrides = None
        pj = getattr(args, "prompts_json", None)
        if pj and Path(pj).is_file():
            prompt_overrides = _json.loads(Path(pj).read_text(encoding="utf-8"))
        images_by_cluster = None
        ij = getattr(args, "images_json", None)
        if ij and Path(ij).is_file():
            images_by_cluster = _json.loads(Path(ij).read_text(encoding="utf-8"))
        clusters = None
        cl = getattr(args, "clusters", None)
        if cl:
            clusters = [int(x) for x in str(cl).split(",") if x.strip() != ""]
        max_snaps = getattr(args, "max_llm_snapshots", 10)
        products = getattr(args, "products", "medoid")
        result = run_split_analysis(
            Path(args.results_dir),
            batch_id=batch_id,
            dataset=dataset,
            model=model,
            api_key=getattr(args, "api_key", None),
            products=products,
            clusters=clusters,
            dry_run=getattr(args, "dry_run", False),
            temperature=getattr(args, "temperature", 0.1),
            max_llm_snapshots=max_snaps if max_snaps and max_snaps > 0 else None,
        )
        out = (
            f"Split analysis done: clusters={list((result.get('clusters') or {}).keys())} "
            f"ic_pairs={len(result.get('ic_pairs') or [])}"
        )
    else:
        parser.error(f"unknown command: {args.cmd}")  # type: ignore[unreachable]
    print(out)


if __name__ == "__main__":
    main()
