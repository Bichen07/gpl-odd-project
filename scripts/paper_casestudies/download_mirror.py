#!/usr/bin/env python3
"""Download IEEE paper case-study assets from senior Payload into data/paper_casestudies/.

Layer A (Explore offline / Path-A export):
  - analysis zips (casestudy1/2/3)
  - linked heatmap-*.zip + trajectories-*.zip
  - OpenDRIVE / OpenSCENARIO for each batch

Usage:
  python3 scripts/paper_casestudies/download_mirror.py
  python3 scripts/paper_casestudies/download_mirror.py --base https://gpl-odd-payloadcms.chiu41.com \\
      --api-key <key>
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
OUT = REPO / "data" / "paper_casestudies"
MANIFEST = Path(__file__).resolve().parent / "manifest.json"

# Files to fetch: (relative_out_path, api_path_or_url_suffix)
LAYER_A = [
    # Case 1 / batch 7
    ("case1/casestudy1_twoAVs.zip", "/api/documents/file/casestudy1_twoAVs.zip"),
    ("case1/heatmap-272.zip", "/api/documents/file/heatmap-272.zip"),
    ("case1/heatmap-273.zip", "/api/documents/file/heatmap-273.zip"),
    ("case1/trajectories-270.zip", "/api/documents/file/trajectories-270.zip"),
    ("case1/trajectories-271.zip", "/api/documents/file/trajectories-271.zip"),
    ("case1/hct_6-2.xodr", "/api/openDrives/file/hct_6-2.xodr"),
    (
        "case1/scenario1_obstacle_start_oldvehicle-3.xosc",
        "/api/openScenarios/file/scenario1_obstacle_start_oldvehicle-3.xosc",
    ),
    # Case 2 / batch 9
    ("case2/casestudy2.zip", "/api/documents/file/casestudy2.zip"),
    ("case2/analysis-3.zip", "/api/documents/file/analysis-3.zip"),
    ("case2/heatmap-261.zip", "/api/documents/file/heatmap-261.zip"),
    ("case2/trajectories-259.zip", "/api/documents/file/trajectories-259.zip"),
    ("case2/hct_6-1.xodr", "/api/openDrives/file/hct_6-1.xodr"),
    ("case2/scenario3.xosc", "/api/openScenarios/file/scenario3.xosc"),
    # Case 3 / batch 8
    ("case3/casestudy3.zip", "/api/documents/file/casestudy3.zip"),
    ("case3/heatmap-251.zip", "/api/documents/file/heatmap-251.zip"),
    ("case3/trajectories-249.zip", "/api/documents/file/trajectories-249.zip"),
    ("case3/hct_6-1.xodr", "/api/openDrives/file/hct_6-1.xodr"),
    ("case3/scenario3.xosc", "/api/openScenarios/file/scenario3.xosc"),
]


def _sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def _download(url: str, dest: Path, api_key: str, force: bool) -> dict:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file() and not force:
        return {
            "path": str(dest.relative_to(OUT)),
            "bytes": dest.stat().st_size,
            "sha256": _sha256(dest),
            "skipped": True,
        }
    req = urllib.request.Request(
        url, headers={"Authorization": f"users API-Key {api_key}"}
    )
    print(f"  ↓ {url}")
    with urllib.request.urlopen(req, timeout=300) as resp:
        data = resp.read()
    dest.write_bytes(data)
    return {
        "path": str(dest.relative_to(OUT)),
        "bytes": len(data),
        "sha256": _sha256(dest),
        "skipped": False,
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--base",
        default=os.environ.get(
            "PAYLOAD_API_URL", "https://gpl-odd-payloadcms.chiu41.com"
        ),
    )
    ap.add_argument(
        "--api-key",
        default=os.environ.get(
            "PAYLOAD_API_KEY",
            os.environ.get(
                "NEXT_PUBLIC_PAYLOAD_API_KEY",
                "fca12850-1a88-43c0-a547-e9fabf061439",
            ),
        ),
    )
    ap.add_argument("--force", action="store_true", help="Re-download even if present")
    args = ap.parse_args()
    base = args.base.rstrip("/")
    if not args.api_key:
        print("❌ Need --api-key or PAYLOAD_API_KEY / NEXT_PUBLIC_PAYLOAD_API_KEY")
        return 1

    OUT.mkdir(parents=True, exist_ok=True)
    # copy semantic manifest beside downloads
    if MANIFEST.is_file():
        (OUT / "manifest.json").write_text(MANIFEST.read_text(encoding="utf-8"))

    inventory = {
        "source": base,
        "files": [],
    }
    print(f"Mirroring Layer A → {OUT}")
    for rel, path in LAYER_A:
        url = base + path
        try:
            meta = _download(url, OUT / rel, args.api_key, args.force)
        except (urllib.error.URLError, TimeoutError, OSError) as exc:
            print(f"  ❌ FAILED {rel}: {exc}")
            return 1
        inventory["files"].append(meta)
        flag = "skip" if meta["skipped"] else "ok"
        print(f"  [{flag}] {rel} ({meta['bytes']} bytes)")

    inv_path = OUT / "INVENTORY.json"
    inv_path.write_text(json.dumps(inventory, indent=2), encoding="utf-8")
    print(f"✓ Wrote {inv_path.relative_to(REPO)} ({len(inventory['files'])} files)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
