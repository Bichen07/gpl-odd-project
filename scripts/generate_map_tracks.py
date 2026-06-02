#!/usr/bin/env python3
"""
Generate odrplot tracks CSV from OpenDRIVE using esmini odrplot.

Usage:
    python3 scripts/generate_map_tracks.py
    python3 scripts/generate_map_tracks.py --dataset dataset2
    python3 scripts/generate_map_tracks.py --all
"""
from __future__ import annotations

import argparse
import os
import subprocess
import sys
from pathlib import Path


def find_odrplot(repo_root: Path) -> Path | None:
    candidates = [
        repo_root / "simulation/ros/src/esmini/bin/odrplot",
        repo_root / "simulation/ros/src/esmini/build/EnvironmentSimulator/Applications/odrplot/odrplot",
        Path(os.environ.get("ESMINI_ODRPLOT", "")),
        Path(__file__).resolve().parents[2] / "xosc_gen/esmini/bin/odrplot",
        Path(__file__).resolve().parents[2] / "esmini/bin/odrplot",
    ]
    for c in candidates:
        if c and c.is_file() and os.access(c, os.X_OK):
            return c
    return None


def generate_one(repo: Path, xodr: Path, out: Path, step: float, odrplot: Path) -> None:
    if not xodr.is_file():
        alt = repo / "simulation/ros/.cache/scenario_search" / xodr.name
        if alt.is_file():
            xodr = alt
        else:
            raise FileNotFoundError(f"OpenDRIVE not found: {xodr}")
    out.parent.mkdir(parents=True, exist_ok=True)
    cmd = [str(odrplot), str(xodr), str(out), str(step)]
    print("Running:", " ".join(cmd))
    subprocess.run(cmd, check=True)
    print(f"✓ Wrote {out} ({out.stat().st_size // 1024} KB)")


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate odrplot tracks CSV for HCT map(s)")
    parser.add_argument("--step", type=float, default=2.0, help="odrplot sampling step (m)")
    parser.add_argument(
        "--dataset",
        default="dataset1",
        help="dataset1|dataset2|dataset3 (selects xodr + output tracks name)",
    )
    parser.add_argument(
        "--all",
        action="store_true",
        help="Generate tracks for every dataset map variant",
    )
    args = parser.parse_args()

    repo = Path(__file__).resolve().parents[1]
    sys.path.insert(0, str(repo / "app/analyzer/src"))
    from data.dataset_config import DATASETS, XODR_DIR

    odrplot = find_odrplot(repo)
    if odrplot is None:
        print(
            "ERROR: odrplot binary not found. Set ESMINI_ODRPLOT or build esmini.",
            file=sys.stderr,
        )
        return 1

    datasets = list(DATASETS) if args.all else [args.dataset]
    try:
        for ds in datasets:
            cfg = DATASETS[ds]
            xodr = XODR_DIR / cfg["xodr"]
            out = XODR_DIR / cfg["tracks"]
            print(f"=== {ds}: {cfg['description']} ===")
            generate_one(repo, xodr, out, args.step, odrplot)
    except FileNotFoundError as e:
        print(f"ERROR: {e}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
