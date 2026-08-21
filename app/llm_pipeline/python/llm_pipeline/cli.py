from __future__ import annotations

import argparse
import json as _json
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
        help="Comma list: medoid[,summary][,parameter-space-pairs][,cross-eval]. Default is medoid "
             "only (one YAML: output/medoid_trial.yaml). cross-eval grades the whole "
             "partition from the medoid + Parameter-space pair cards. Use 'all' for all products.",
    )
    ci.add_argument("--api-key", default=None, help="API key (overrides env; ephemeral)")
    ci.add_argument("--clusters", default=None,
                    help="Comma list of cluster ids to run (default: all)")
    ci.add_argument(
        "--pairs",
        default=None,
        help="Comma list of Parameter-space pair folder names to run (e.g. c0-c4,c1-c2). "
             "When set, only these packs are LLM'd (overrides cluster-touch filter).",
    )
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

    # selection-eval: deterministic selection quality only — no LLM, no network
    se = sub.add_parser("selection-eval")
    se.add_argument("--run-dir", required=True,
                    help="results/batch<id>/<k>_cluster_s=.../ directory to evaluate")

    # odd-export (S2 Python twin): deterministic, no LLM. Needs network (saved
    # analysis zip) unless --analysis-zip is a local file.
    oe = sub.add_parser("odd-export", help="S2 — write odd_boundary_export.json + odd_all_trials.json")
    oe.add_argument("--run-dir", required=True, help="results/batch<id>/<k>_cluster_s=.../")
    oe.add_argument("--kNN", type=int, default=10)
    oe.add_argument("--ego-name", default="ITRI")
    oe.add_argument("--duration-mode", default="full")
    oe.add_argument("--save-doc-id", type=int, default=None,
                     help="Specific savedTrajectoryAnalysis doc id (default: latest)")
    oe.add_argument("--analysis-zip", default=None, help="Local zip path instead of Payload download")

    # odd-rules (S3): deterministic, no LLM, no network.
    orl = sub.add_parser("odd-rules", help="S3 — shallow CART -> odd_parameter_rules.json")
    orl.add_argument("--run-dir", required=True)
    orl.add_argument("--max-depth", type=int, default=3)
    orl.add_argument("--min-samples-leaf", type=int, default=10)
    orl.add_argument("--cv-folds", type=int, default=5)

    # odd-join (S4): deterministic, no LLM, no network.
    oj = sub.add_parser("odd-join", help="S4 — join boundary trials <-> parameter_space_pairs")
    oj.add_argument("--run-dir", required=True)

    # odd-briefing (S5 part 1): deterministic, no LLM, no network.
    ob = sub.add_parser("odd-briefing", help="S5 — assemble odd_chat_briefing.json")
    ob.add_argument("--run-dir", required=True)

    # odd-chat (S5 part 2): one grounded Q&A turn. Needs an LLM call unless --dry-run.
    oc = sub.add_parser("odd-chat", help="S5 — ask one grounded question over odd_chat_briefing.json")
    oc.add_argument("--run-dir", required=True)
    oc.add_argument("--question", required=True)
    oc.add_argument("--model", default="gemini-2.5-flash")
    oc.add_argument("--api-key", default=None)
    oc.add_argument("--temperature", type=float, default=0.1)
    oc.add_argument("--history-json", default=None,
                     help="Path to a JSON list of {role, content} turns (role: user|assistant)")
    oc.add_argument("--dry-run", action="store_true")
    oc.add_argument("--no-log", action="store_true", help="Do not append to odd_chat_log.jsonl")

    args = parser.parse_args()
    source = _source_path()
    if args.cmd == "selection-eval":
        from .cluster_selection_eval import write_eval

        path = write_eval(Path(args.run_dir))
        out = (
            f"cluster_selection_eval written to {path}"
            if path
            else "selection-eval failed (no cluster dirs)"
        )
    elif args.cmd == "cross-cluster-eval":
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
    elif args.cmd == "odd-export":
        from .odd_export import export_run_dir

        summary = export_run_dir(
            Path(args.run_dir),
            kNN=args.kNN,
            ego_name=args.ego_name,
            duration_mode=args.duration_mode,
            save_doc_id=args.save_doc_id,
            analysis_zip=args.analysis_zip,
        )
        out = _json.dumps(summary, indent=2)
    elif args.cmd == "odd-rules":
        from .odd_rules import train_rules

        summary = train_rules(
            Path(args.run_dir),
            max_depth=args.max_depth,
            min_samples_leaf=args.min_samples_leaf,
            cv_folds=args.cv_folds,
        )
        out = _json.dumps(summary, indent=2)
    elif args.cmd == "odd-join":
        from .odd_join import join_run_dir

        out = _json.dumps(join_run_dir(Path(args.run_dir)), indent=2)
    elif args.cmd == "odd-briefing":
        from .odd_briefing import build_briefing

        doc = build_briefing(Path(args.run_dir))
        out = _json.dumps(
            {
                "briefing_path": str(Path(args.run_dir) / "odd_chat_briefing.json"),
                "n_clusters": len(doc.get("clusters") or []),
                "n_pairs": len(doc.get("pairs") or []),
                "n_rules": len(doc.get("rules") or []),
                "missing": doc.get("missing"),
            },
            indent=2,
        )
    elif args.cmd == "odd-chat":
        from .odd_chat import answer

        history = None
        if args.history_json and Path(args.history_json).is_file():
            history = _json.loads(Path(args.history_json).read_text(encoding="utf-8"))
        result = answer(
            Path(args.run_dir),
            args.question,
            model=args.model,
            api_key=args.api_key,
            temperature=args.temperature,
            history=history,
            dry_run=args.dry_run,
            log=not args.no_log,
        )
        out = _json.dumps(result, indent=2)
    elif args.cmd == "cluster-interpret":
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
        pairs = None
        pr = getattr(args, "pairs", None)
        if pr:
            pairs = [x.strip() for x in str(pr).split(",") if x.strip()]
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
            pairs=pairs,
            dry_run=getattr(args, "dry_run", False),
            temperature=getattr(args, "temperature", 0.1),
            max_llm_snapshots=max_snaps if max_snaps and max_snaps > 0 else None,
        )
        out = (
            f"Split analysis done: clusters={list((result.get('clusters') or {}).keys())} "
            f"parameter_space_pairs={len(result.get('parameter_space_pairs') or [])}"
        )
    else:
        parser.error(f"unknown command: {args.cmd}")  # type: ignore[unreachable]
    print(out)


if __name__ == "__main__":
    main()
