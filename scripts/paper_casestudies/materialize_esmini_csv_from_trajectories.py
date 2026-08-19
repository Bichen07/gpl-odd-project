#!/usr/bin/env python3
"""Materialize esmini_*.csv under simulation/ros/.cache from paper trajectories zip.

Paper Path A results (results/batch9/…) only have cluster skeletons. Local sim
cache has no esmini_7_*.csv for senior paper batch 7. This script converts
``rawTrajectories.json`` (already mirrored under data/paper_casestudies/) into
esmini-compatible CSVs so ``dataset_builder --from-run`` can build BEV packs.

Usage:
  python3 scripts/paper_casestudies/materialize_esmini_csv_from_trajectories.py \\
    --analysis-zip data/paper_casestudies/case2/casestudy2.zip \\
    --trajectories-zip data/paper_casestudies/case2/trajectories-259.zip \\
    --results-dir results/batch9/4_cluster_s=0.7482
"""
from __future__ import annotations

import argparse
import json
import math
import re
import zipfile
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Set, Tuple

REPO = Path(__file__).resolve().parents[2]
CACHE = REPO / "simulation/ros/.cache/scenario_search/records"
_DAT_PAT = re.compile(r"esmini_(\d+)_(\d+)(?:-\d+)?\.dat$")
_DAT_CLEAN_PAT = re.compile(r"esmini_(\d+)_(\d+)\.dat$")
SIDECAR = CACHE / "trial_csv_index_map.json"


def _load_trial_index_map(analysis_zip: Path, ego: str = "ITRI") -> Dict[str, Tuple[int, int]]:
    """Assign every trial a unique ``(batch_id, csv_index)``.

    Payload appends ``-N`` when an uploaded filename collides with an existing
    one, so the index embedded in ``esminiDat.filename`` is *not* unique: in
    Case Study 3, 3869 trials share only 2129 distinct embedded indices. Trials
    with an unsuffixed filename keep their embedded index (those match the CSVs
    already on disk); the rest are allocated fresh indices above the highest one
    in use. Allocation is ordered by trial id so it is stable across runs.
    """
    with zipfile.ZipFile(analysis_zip) as zf:
        doc = json.loads(zf.read(zf.namelist()[0]))
    trials = (doc.get(ego) or {}).get("trials") or {}

    names: Dict[str, str] = {}
    for tid, info in trials.items():
        if not isinstance(info, dict):
            continue
        edat = info.get("esminiDat")
        if not isinstance(edat, dict):
            continue
        names[str(tid)] = str(edat.get("filename") or "")

    def _tid_sort(tid: str) -> int:
        return int(tid) if tid.isdigit() else 0

    out: Dict[str, Tuple[int, int]] = {}
    claimed: Dict[int, Set[int]] = {}
    for tid in sorted(names, key=_tid_sort):
        m = _DAT_CLEAN_PAT.match(names[tid])
        if m:
            batch_id, idx = int(m.group(1)), int(m.group(2))
            out[tid] = (batch_id, idx)
            claimed.setdefault(batch_id, set()).add(idx)

    next_free: Dict[int, int] = {b: max(s) + 1 for b, s in claimed.items()}
    n_alloc = 0
    for tid in sorted(names, key=_tid_sort):
        if tid in out:
            continue
        m = _DAT_PAT.match(names[tid])
        if not m:
            continue
        batch_id, idx = int(m.group(1)), int(m.group(2))
        taken = claimed.setdefault(batch_id, set())
        if idx in taken:
            idx = next_free.get(batch_id, 1)
            while idx in taken:
                idx += 1
            next_free[batch_id] = idx + 1
            n_alloc += 1
        taken.add(idx)
        out[tid] = (batch_id, idx)

    if n_alloc:
        print(f"  allocated {n_alloc} fresh CSV indices for collided Payload filenames")
    return out


def _write_sidecar(index_map: Dict[str, Tuple[int, int]]) -> None:
    """Persist the map so dataset_builder resolves the same trial→CSV pairing."""
    data: Dict[str, Dict[str, int]] = {}
    if SIDECAR.is_file():
        try:
            data = json.loads(SIDECAR.read_text())
        except Exception:
            data = {}
    for tid, (batch_id, idx) in index_map.items():
        data.setdefault(str(batch_id), {})[str(tid)] = idx
    SIDECAR.parent.mkdir(parents=True, exist_ok=True)
    SIDECAR.write_text(json.dumps(data, indent=1, sort_keys=True) + "\n")
    print(f"  wrote {SIDECAR.relative_to(REPO)} ({sum(len(v) for v in data.values())} entries)")


def _needed_trial_ids(results_dir: Path) -> Set[str]:
    ids: Set[str] = set()
    man = results_dir / "manifest.json"
    if man.is_file():
        for c in (json.loads(man.read_text()).get("clusters") or []):
            if c.get("trial_id") is not None:
                ids.add(str(c["trial_id"]))
    for cdir in results_dir.glob("cluster*"):
        cj = cdir / "cluster.json"
        if not cj.is_file():
            continue
        data = json.loads(cj.read_text())
        med = data.get("medoid") or {}
        if med.get("trial_id") is not None:
            ids.add(str(med["trial_id"]))
        for mem in data.get("members") or []:
            ids.add(str(mem))
    return ids


def _estimate_speeds(times: List[float], frames: List[Dict[str, Any]]) -> List[float]:
    n = len(frames)
    speeds = [0.0] * n
    for i in range(n):
        if i == 0 and n > 1:
            dt = max(1e-3, float(times[1]) - float(times[0]))
            dx = float(frames[1]["x"]) - float(frames[0]["x"])
            dy = float(frames[1]["y"]) - float(frames[0]["y"])
        elif i == 0:
            speeds[i] = float(frames[i].get("speed") or 0.0)
            continue
        else:
            dt = max(1e-3, float(times[i]) - float(times[i - 1]))
            dx = float(frames[i]["x"]) - float(frames[i - 1]["x"])
            dy = float(frames[i]["y"]) - float(frames[i - 1]["y"])
        speeds[i] = math.hypot(dx, dy) / dt
    return speeds


def _write_esmini_csv(
    out_path: Path,
    times: List[float],
    trajectory: Dict[str, List[Dict[str, Any]]],
    *,
    xodr_ref: str = "hct_6.xodr",
) -> None:
    agents = list(trajectory.keys())
    # Stable id: Ego=0, others 1..
    order = (["Ego"] if "Ego" in agents else []) + sorted(a for a in agents if a != "Ego")
    speeds = {name: _estimate_speeds(times, trajectory[name]) for name in order}

    lines = [
        f"Version: 2, OpenDRIVE: {xodr_ref}, 3DModel: ",
        "time, id, name, x, y, z, h, p, r, roadId, laneId, offset, t, s, speed, wheel_angle, wheel_rot",
    ]
    for ti, t in enumerate(times):
        for aid, name in enumerate(order):
            fr = trajectory[name][ti] if ti < len(trajectory[name]) else trajectory[name][-1]
            w = float(fr.get("width") or (2.2 if name != "Ego" else 2.2))
            ln = float(fr.get("length") or (5.04 if name != "Ego" else 5.17))
            if w <= 0:
                w = 2.2
            if ln <= 0:
                ln = 5.17 if name == "Ego" else 5.04
            road = int(fr.get("roadId") or 0)
            s = float(fr.get("s") or 0.0)
            h = float(fr.get("yaw") if "yaw" in fr else fr.get("h") or 0.0)
            spd = float(fr.get("speed") if fr.get("speed") is not None else speeds[name][ti])
            # Match local esmini CSV layout (extra trailing dim columns OK; loader keeps named cols)
            lines.append(
                f"{float(t):.3f}, {aid}, {name}, "
                f"{float(fr['x']):.3f}, {float(fr['y']):.3f}, 0.000, "
                f"{h:.3f}, 0.000, 0.000, "
                f"{road}, 0, 0.000, 0.000, {s:.3f}, {spd:.3f}, 0.000, 0.000, "
                f"0.000, 0.000, 0.750, {w:.3f}, {ln:.3f}, 1.500, 2, 255"
            )
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines) + "\n")


def materialize(
    analysis_zip: Path,
    trajectories_zip: Path,
    results_dir: Optional[Path],
    *,
    ego: str = "ITRI",
    only_medoids: bool = False,
    force: bool = False,
) -> int:
    index_map = _load_trial_index_map(analysis_zip, ego=ego)
    print(f"trial→esmini map: {len(index_map)} from {analysis_zip.name}")
    _write_sidecar(index_map)

    if results_dir and results_dir.is_dir():
        needed = _needed_trial_ids(results_dir)
        if only_medoids:
            man = json.loads((results_dir / "manifest.json").read_text())
            needed = {str(c["trial_id"]) for c in man.get("clusters") or []}
        print(f"needed trial ids: {len(needed)} (only_medoids={only_medoids})")
    else:
        needed = set(index_map.keys())
        print(f"materializing all mapped trials: {len(needed)}")

    with zipfile.ZipFile(trajectories_zip) as zf:
        raw = json.loads(zf.read("rawTrajectories.json"))
    print(f"rawTrajectories: {len(raw)} trials")

    written = skipped = missing_traj = missing_map = 0
    for tid in sorted(needed, key=lambda x: int(x) if str(x).isdigit() else 0):
        if tid not in index_map:
            missing_map += 1
            continue
        if tid not in raw:
            missing_traj += 1
            continue
        batch_id, trial_index = index_map[tid]
        out = CACHE / f"esmini_{batch_id}_{trial_index}.csv"
        if out.exists() and out.stat().st_size > 1000 and not force:
            skipped += 1
            continue
        item = raw[tid]
        times = [float(t) for t in item["time"]]
        traj = item["trajectory"]
        _write_esmini_csv(out, times, traj)
        written += 1
        if written <= 8 or written % 500 == 0:
            print(f"  wrote {out.name} ({out.stat().st_size} bytes) trial_id={tid}")

    print(
        f"done: written={written} skipped_existing={skipped} "
        f"missing_traj={missing_traj} missing_map={missing_map}"
    )
    return 0 if written or skipped else 1


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--analysis-zip", type=Path, required=True)
    ap.add_argument("--trajectories-zip", type=Path, required=True)
    ap.add_argument("--results-dir", type=Path, default=None)
    ap.add_argument("--ego-name", default="ITRI")
    ap.add_argument("--only-medoids", action="store_true")
    ap.add_argument("--force", action="store_true")
    args = ap.parse_args()
    return materialize(
        args.analysis_zip,
        args.trajectories_zip,
        args.results_dir,
        ego=args.ego_name,
        only_medoids=args.only_medoids,
        force=args.force,
    )


if __name__ == "__main__":
    raise SystemExit(main())
