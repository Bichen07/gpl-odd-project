#!/usr/bin/env python3
"""Build a local-only, source-labelled Phase A card for one archived trial.

This command never contacts or modifies Payload.  It is intentionally explicit
about all paths so an archived trial cannot be silently substituted.
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import yaml


REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / "app/analyzer/src"))

from capability_analysis import build_capability_card, save_capability_card  # noqa: E402
from capability_sources import sha256_file  # noqa: E402
from visibility_analysis import (  # noqa: E402
    build_visibility_evidence,
    evaluate_profile_response_window,
    save_visibility_evidence,
)


def _under_results(path: str) -> Path:
    resolved = Path(path).resolve()
    results = (REPO_ROOT / "results").resolve()
    try:
        resolved.relative_to(results)
    except ValueError as exc:
        raise argparse.ArgumentTypeError("path must be inside repository results/") from exc
    return resolved


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--trial-id", required=True)
    parser.add_argument(
        "--archive-batch-label",
        required=True,
        type=int,
        help="Batch number encoded by the local archive path; this is not Payload identity proof.",
    )
    parser.add_argument("--trajectory", required=True, type=_under_results)
    parser.add_argument("--action", required=True, type=_under_results)
    parser.add_argument("--output", required=True, type=_under_results)
    parser.add_argument(
        "--visibility-output",
        type=_under_results,
        help="Optional output path under results/. Defaults to visibility.yaml next to --output.",
    )
    parser.add_argument(
        "--perception-profile",
        type=Path,
        help="Versioned assumed/configured profile YAML. Omit it to preserve unavailable visibility/detection fields.",
    )
    parser.add_argument(
        "--geometry-evidence",
        type=Path,
        help="Optional geometry coverage/occluder YAML. A clear visibility result requires coverage: complete.",
    )
    args = parser.parse_args()
    if not args.trajectory.is_file() or not args.action.is_file():
        parser.error("--trajectory and --action must name existing files")
    action_data = yaml.safe_load(args.action.read_text(encoding="utf-8")) or {}
    profile = None
    if args.perception_profile:
        if not args.perception_profile.is_file():
            parser.error("--perception-profile must name an existing YAML file")
        profile = yaml.safe_load(args.perception_profile.read_text(encoding="utf-8")) or {}
    geometry = None
    if args.geometry_evidence:
        if not args.geometry_evidence.is_file():
            parser.error("--geometry-evidence must name an existing YAML file")
        geometry = yaml.safe_load(args.geometry_evidence.read_text(encoding="utf-8")) or {}
    ego_actor = next(
        (str(agent.get("track_id")) for agent in action_data.get("agents", []) if str(agent.get("role")).lower() == "ego"),
        "Ego",
    )
    collision = next(
        (item for item in action_data.get("interactions", []) if item.get("type") == "COLLISION"),
        {},
    )
    target_actor = collision.get("with_track_id")
    visibility = build_visibility_evidence(
        trial_id=args.trial_id,
        trajectory_path=args.trajectory,
        ego_actor=ego_actor,
        target_actor=str(target_actor) if target_actor is not None else None,
        profile=profile,
        geometry=geometry,
    )
    visibility_output = args.visibility_output or args.output.with_name("visibility.yaml")
    save_visibility_evidence(visibility, visibility_output)
    sensitivity = []
    if profile is not None:
        collision_time = {"status": "unavailable"}
        if collision.get("key_time") is not None:
            collision_time = {"value": collision["key_time"], "unit": "s", "status": "derived"}
        sensitivity.append(
            evaluate_profile_response_window(
                visibility=visibility, collision_time=collision_time, profile=profile
            )
        )
    card = build_capability_card(
        trial_id=args.trial_id,
        trajectory_path=args.trajectory,
        action_data=action_data,
        analysis_context={
            "batch_id": {
                "status": "unavailable",
                "rationale": (
                    "The local archive path is labelled batch {}. A matching Payload "
                    "trial ID or archive folder name is not sufficient to establish "
                    "run identity; record a source-file hash and trajectory fingerprint "
                    "before promoting this to a recorded batch identity."
                ).format(args.archive_batch_label),
            },
            "scenario_archetype": {
                "status": "unavailable",
                "rationale": "No persisted archetype source is attached to this archived single-case card.",
            },
        },
        visibility_evidence=visibility,
        profile_sensitivity=sensitivity,
        include_illustrative_assumptions=True,
    )
    save_capability_card(card, args.output)
    print("wrote {}".format(args.output.relative_to(REPO_ROOT)))
    print("wrote {}".format(visibility_output.relative_to(REPO_ROOT)))
    print("sha256 {}".format(sha256_file(args.output)))
    print("primary verdict {}".format(card["verdict"]["label"]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
