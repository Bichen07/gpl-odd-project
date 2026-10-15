"""Saved frames for one trial, and a sample of a large selection.

Lookup order: ``clusterN/trial_{id}/`` or ``noise/trial_{id}/`` for cluster -1,
then ``conversation_trials/trial_{id}/``, then the medoid whose ``trial_id``
matches, then a parameter-space pair that names the trial. A build writes only
a trial that does not already have a jpg, under that trial's cluster (or
``noise/``), and does not copy cluster-level files.

A selection above six trials keeps 1 to 3 trials from each cluster that appears
in it. The count follows that cluster's share of the selection. A trial that
already has context is taken before one that has none. The prompt carries that
context as text, plus at most three critical-time frame rows, and does not
attach jpg files.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Dict, List, Optional

import yaml

from .paths import run_artifact_path

SAMPLE_WHEN_ABOVE = 6
PER_CLUSTER_MIN = 1
PER_CLUSTER_MAX = 3
CRITICAL_FRAME_LIMIT = 3
_CRITICAL_LABEL = ("COLLISION", "NEAR_MISS", "DECELERAT", "BRAKE", "IMPACT")


def _legacy_trial_dir(run_dir: Path, trial_id: str) -> Path:
    return run_dir / "conversation_trials" / f"trial_{trial_id}"


def _cluster_folder(cluster: Any) -> Optional[str]:
    if cluster is None or cluster == "":
        return None
    text = str(cluster).strip()
    if text.endswith(".0"):
        text = text[:-2]
    if not text.lstrip("-").isdigit():
        return None
    if text in {"-1", "noise"}:
        return "noise"
    return f"cluster{text}"


def _cluster_trial_dir(run_dir: Path, trial_id: str, cluster: Any) -> Optional[Path]:
    name = _cluster_folder(cluster)
    if name is None:
        return None
    return Path(run_dir) / name / f"trial_{trial_id}"


def _find_cluster_trial_dir(run_dir: Path, trial_id: str, cluster: Any = None) -> Optional[Path]:
    direct = _cluster_trial_dir(run_dir, trial_id, cluster)
    if direct is not None and direct.is_dir():
        return direct
    matches = sorted(Path(run_dir).glob(f"cluster*/trial_{trial_id}"))
    noise = Path(run_dir) / "noise" / f"trial_{trial_id}"
    if noise.is_dir():
        matches.append(noise)
    return matches[0] if matches else None


def _read_yaml(path: Path) -> Dict[str, Any]:
    if not path.is_file():
        return {}
    doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
    return doc if isinstance(doc, dict) else {}


def _snapshot_images(run_dir: Path, snap_dir: Path, limit: int = 4) -> List[Dict[str, Any]]:
    table = snap_dir / "llm_snapshots.json"
    snaps: List[Dict[str, Any]] = []
    if table.is_file():
        try:
            doc = json.loads(table.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            doc = {}
        snaps = [row for row in (doc.get("snapshots") or []) if isinstance(row, dict)]
    rows: List[Dict[str, Any]] = []
    for snap in snaps:
        name = str(snap.get("file") or "")
        if not name:
            continue
        path = snap_dir / name
        if not path.is_file():
            continue
        rows.append(
            {
                "rel": str(path.relative_to(run_dir)),
                "t": snap.get("t"),
                "label": snap.get("label"),
            }
        )
    if not rows:
        for path in sorted(snap_dir.glob("*.jpg"))[:limit]:
            rows.append({"rel": str(path.relative_to(run_dir)), "t": None, "label": path.name})
    collision = [row for row in rows if "COLLISION" in str(row.get("label") or "").upper()]
    return (collision or rows)[:limit]


def _trial_index(run_dir: Path) -> Dict[str, Dict[str, Any]]:
    path = run_artifact_path(run_dir, "odd_all_trials")
    if not path.is_file():
        return {}
    try:
        doc = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return {}
    index: Dict[str, Dict[str, Any]] = {}
    for row in doc.get("trials") or []:
        if isinstance(row, dict) and row.get("trial_id") is not None:
            index[str(row.get("trial_id"))] = row
    return index


def _trial_row(run_dir: Path, trial_id: str) -> Dict[str, Any]:
    return _trial_index(run_dir).get(str(trial_id), {})


def _medoid_match(run_dir: Path, trial_id: str) -> Optional[Dict[str, Any]]:
    for path in sorted(run_dir.glob("cluster*/output/medoid_trial.yaml")):
        doc = _read_yaml(path)
        if str(doc.get("trial_id") or "") != str(trial_id):
            continue
        cluster_name = path.parents[1].name
        cluster_id = cluster_name.replace("cluster", "")
        snap_dir = path.parents[1] / "processed" / "snapshots"
        return {
            "source": f"medoid cluster {cluster_id}",
            "cluster": cluster_id,
            "images": _snapshot_images(run_dir, snap_dir),
            "has_table": (snap_dir / "llm_snapshots.json").is_file(),
        }
    return None


def _pair_match(run_dir: Path, trial_id: str) -> Optional[Dict[str, Any]]:
    needle = str(trial_id)
    for path in sorted(run_dir.glob("parameter_space_pairs/c*-c*/output/contrast.yaml")):
        doc = _read_yaml(path)
        folder = path.parents[1].name
        for side in ("left", "right"):
            block = doc.get(side) or {}
            raw = str(block.get("trial_id") or block.get("trial") or "")
            digits = "".join(ch for ch in raw if ch.isdigit())
            if needle not in (raw, digits):
                continue
            trial_dir = block.get("conflict_metrics") or {}
            snap_hint = Path(str(trial_dir.get("trial_dir") or ""))
            snap_dir = snap_hint / "snapshots" if snap_hint.parts else path.parents[1]
            if not snap_dir.is_dir():
                snap_dir = path.parents[1]
            return {
                "source": f"pair {folder}",
                "cluster": block.get("cluster"),
                "images": _snapshot_images(run_dir, snap_dir),
                "has_table": (snap_dir / "llm_snapshots.json").is_file(),
            }
    return None


def locate_trial(run_dir: Path, trial_id: str) -> Dict[str, Any]:
    """Return where this trial's frames already live. Does not render."""
    run_dir = Path(run_dir)
    trial_id = str(trial_id)
    row = _trial_row(run_dir, trial_id)
    cluster = row.get("cluster_label")
    found = None
    cluster_dir = _find_cluster_trial_dir(run_dir, trial_id, cluster)
    if cluster_dir is not None:
        snap_dir = cluster_dir / "processed" / "snapshots"
        images = _snapshot_images(run_dir, snap_dir)
        found = {
            "source": f"cluster trial {cluster_dir.parent.name}/{cluster_dir.name}",
            "cluster": cluster if cluster is not None else cluster_dir.parent.name.replace("cluster", ""),
            "images": images,
            "has_table": (snap_dir / "llm_snapshots.json").is_file(),
        }
    if found is None:
        own = _legacy_trial_dir(run_dir, trial_id)
        snap_dir = own / "snapshots"
        if own.is_dir():
            images = _snapshot_images(run_dir, snap_dir)
            found = {
                "source": "conversation_trials",
                "cluster": cluster,
                "images": images,
                "has_table": (snap_dir / "llm_snapshots.json").is_file(),
            }
    if found is None:
        found = _medoid_match(run_dir, trial_id) or _pair_match(run_dir, trial_id)
    if found is None:
        found = {"source": "not built", "cluster": cluster, "images": [], "has_table": False}
    return {
        "trial_id": trial_id,
        "passed": row.get("passed"),
        "cluster": found.get("cluster"),
        "source": found.get("source"),
        "images": found.get("images") or [],
        "has_table": bool(found.get("has_table")),
    }


def cluster_frames(run_dir: Path, cluster_id: int) -> Dict[str, Any]:
    """Jpg files already next to a cluster's snapshot table, plus the medoid id."""
    run_dir = Path(run_dir)
    snap_dir = run_dir / f"cluster{cluster_id}" / "processed" / "snapshots"
    medoid = _read_yaml(run_dir / f"cluster{cluster_id}" / "output" / "medoid_trial.yaml")
    return {
        "images": _snapshot_images(run_dir, snap_dir),
        "has_table": (snap_dir / "llm_snapshots.json").is_file(),
        "build_trial_id": str(medoid.get("trial_id") or "") or None,
    }


def _stored_trial_ids(run_dir: Path) -> set:
    """Trial ids that already have context, a frame table, or a jpg. Does not render."""
    run_dir = Path(run_dir)
    stored = set()
    snap_dirs = list(run_dir.glob("cluster*/trial_*/processed/snapshots"))
    snap_dirs.extend(run_dir.glob("noise/trial_*/processed/snapshots"))
    for snap_dir in snap_dirs:
        if (snap_dir / "llm_snapshots.json").is_file() or any(snap_dir.glob("*.jpg")):
            stored.add(snap_dir.parents[1].name.replace("trial_", "", 1))
    for context in list(run_dir.glob("cluster*/trial_*/processed/context.md")):
        stored.add(context.parents[1].name.replace("trial_", "", 1))
    for context in run_dir.glob("noise/trial_*/processed/context.md"):
        stored.add(context.parents[1].name.replace("trial_", "", 1))
    for folder in run_dir.glob("conversation_trials/trial_*"):
        snap_dir = folder / "snapshots"
        if folder.is_dir() and ((snap_dir / "llm_snapshots.json").is_file() or any(snap_dir.glob("*.jpg"))):
            stored.add(folder.name.replace("trial_", "", 1))
    for path in run_dir.glob("cluster*/output/medoid_trial.yaml"):
        tid = str(_read_yaml(path).get("trial_id") or "")
        snap_dir = path.parents[1] / "processed" / "snapshots"
        context = path.parents[1] / "processed" / "context_medoid.md"
        if tid and (
            context.is_file()
            or (snap_dir / "llm_snapshots.json").is_file()
            or any(snap_dir.glob("*.jpg"))
        ):
            stored.add(tid)
    for path in run_dir.glob("parameter_space_pairs/c*-c*/output/contrast.yaml"):
        doc = _read_yaml(path)
        for side in ("left", "right"):
            raw = str((doc.get(side) or {}).get("trial_id") or "")
            digits = "".join(ch for ch in raw if ch.isdigit())
            if digits:
                stored.add(digits)
    return stored


def _cluster_key(row: Dict[str, Any]) -> str:
    cluster = row.get("cluster_label")
    if cluster is None or cluster == "":
        return "none"
    text = str(cluster).strip()
    if text.endswith(".0"):
        text = text[:-2]
    return text


def _collision_first(passed: Any) -> int:
    return 0 if passed is False or passed == 0 else 1


def _sent_outcome(passed: Any) -> str:
    return "collision" if passed is False or passed == 0 else "passed"


def _cluster_sort_key(name: str) -> tuple:
    if name == "none":
        return (2, 0)
    if name in {"-1", "noise"}:
        return (1, 0)
    try:
        return (0, int(name))
    except ValueError:
        return (0, 999)


def _cluster_quotas(counts: Dict[str, int]) -> Dict[str, int]:
    """1, 2, or 3 trials from each cluster, from its share of the selection.

    One cluster alone gets up to 3. With several clusters, a share below
    three quarters of an even split gets 1, a share up to one and a half
    times an even split gets 2, and a larger share gets 3. Equal shares get
    the same count.
    """
    if not counts:
        return {}
    if len(counts) == 1:
        name, n = next(iter(counts.items()))
        return {name: min(PER_CLUSTER_MAX, n)}
    even = sum(counts.values()) / len(counts)
    quotas: Dict[str, int] = {}
    for name, n in counts.items():
        ratio = (n / even) if even else 1.0
        if ratio < 0.75:
            quota = 1
        elif ratio <= 1.5:
            quota = 2
        else:
            quota = 3
        quotas[name] = min(PER_CLUSTER_MAX, n, max(PER_CLUSTER_MIN, quota))
    return quotas


def _pick_cluster(
    pool: List[str],
    quota: int,
    rows: Dict[str, Dict[str, Any]],
    stored: set,
    ids: List[str],
) -> List[str]:
    """Stored context first. A second outcome fills a free slot when both exist."""
    def sort_key(tid: str) -> tuple:
        return (_collision_first(rows[tid].get("passed")), ids.index(tid))

    stored_pool = sorted((tid for tid in pool if tid in stored), key=sort_key)
    other = sorted((tid for tid in pool if tid not in stored), key=sort_key)
    chosen: List[str] = []
    for tid in stored_pool:
        if len(chosen) >= quota:
            break
        chosen.append(tid)
    outcomes = {rows[tid].get("passed") for tid in pool}
    if len(chosen) < quota and len(outcomes) > 1:
        have = {rows[tid].get("passed") for tid in chosen}
        for tid in stored_pool + other:
            if tid in chosen or rows[tid].get("passed") in have:
                continue
            chosen.append(tid)
            have.add(rows[tid].get("passed"))
            if len(chosen) >= quota:
                break
    for tid in other:
        if len(chosen) >= quota:
            break
        if tid not in chosen:
            chosen.append(tid)
    return chosen


def sample_trial_ids(run_dir: Path, trial_ids: List[str]) -> List[str]:
    """Keep every id up to 6. Above that, keep 1 to 3 ids from each cluster.

    The per-cluster count follows that cluster's share of the selection.
    A trial that already has context is taken before one that does not.
    Asking does not render a new frame.
    """
    run_dir = Path(run_dir)
    ids: List[str] = []
    seen = set()
    for raw in trial_ids:
        tid = str(raw).strip()
        if not tid.isdigit() or tid in seen:
            continue
        seen.add(tid)
        ids.append(tid)
    if len(ids) <= SAMPLE_WHEN_ABOVE:
        return ids

    index = _trial_index(run_dir)
    rows = {tid: index.get(tid, {}) for tid in ids}
    stored = _stored_trial_ids(run_dir)
    groups: Dict[str, List[str]] = {}
    for tid in ids:
        groups.setdefault(_cluster_key(rows[tid]), []).append(tid)
    quotas = _cluster_quotas({name: len(pool) for name, pool in groups.items()})
    picked: List[str] = []
    for cluster in sorted(groups, key=_cluster_sort_key):
        picked.extend(
            _pick_cluster(groups[cluster], quotas[cluster], rows, stored, ids)
        )
    return picked


def selection_label(run_dir: Path, trial_ids: List[str], source: str = "lasso") -> str:
    """Same count ``describe_selection`` sends. Does not build context."""
    ids = [str(item).strip() for item in trial_ids if str(item).strip().isdigit()]
    sampled = sample_trial_ids(run_dir, ids)
    total = len(ids)
    if len(sampled) < total:
        return f"{len(sampled)} of {total} {source} trials"
    return f"{len(sampled)} {source} trials"


def _snapshot_dir_for_trial(run_dir: Path, trial_id: str, cluster: Any) -> Optional[Path]:
    trial_dir = _find_cluster_trial_dir(run_dir, trial_id, cluster)
    if trial_dir is not None:
        snap = trial_dir / "processed" / "snapshots"
        if (snap / "llm_snapshots.json").is_file():
            return snap
    text = "" if cluster is None else str(cluster).strip()
    if text.endswith(".0"):
        text = text[:-2]
    if text not in {"", "none", "-1", "noise"}:
        medoid = _read_yaml(run_dir / f"cluster{text}" / "output" / "medoid_trial.yaml")
        if str(medoid.get("trial_id") or "") == str(trial_id):
            snap = run_dir / f"cluster{text}" / "processed" / "snapshots"
            if (snap / "llm_snapshots.json").is_file():
                return snap
    legacy = _legacy_trial_dir(run_dir, trial_id) / "snapshots"
    if (legacy / "llm_snapshots.json").is_file():
        return legacy
    return None


def _critical_frames(snap_dir: Optional[Path]) -> List[Dict[str, Any]]:
    """At most three frame rows. Collision, near-miss, and brake come first."""
    if snap_dir is None:
        return []
    table = snap_dir / "llm_snapshots.json"
    if not table.is_file():
        return []
    try:
        doc = json.loads(table.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return []
    snaps = [row for row in (doc.get("snapshots") or []) if isinstance(row, dict)]

    def rank(row: Dict[str, Any]) -> int:
        label = str(row.get("label") or "").upper()
        for index, key in enumerate(_CRITICAL_LABEL):
            if key in label:
                return index
        return 99

    critical = [row for row in snaps if rank(row) < 99]
    critical.sort(key=rank)
    if not critical and snaps:
        critical = snaps[-1:]
    frames = []
    for row in critical[:CRITICAL_FRAME_LIMIT]:
        frames.append(
            {
                "t": row.get("t"),
                "label": row.get("label"),
                "d": row.get("d"),
                "ttc": row.get("ttc"),
                "v_ego": row.get("v_ego"),
            }
        )
    return frames


def _trim_context(text: str, limit: int = 700) -> str:
    header: List[str] = []
    critical: List[str] = []
    for line in text.splitlines():
        stripped = line.strip()
        if not stripped:
            continue
        if stripped.startswith("- frame:") or stripped.startswith("frame:") or stripped.endswith(".jpg"):
            continue
        low = stripped.lower()
        if low.startswith("- at t=") or low.startswith("at t="):
            upper = stripped.upper()
            if any(key in upper for key in ("COLLISION", "NEAR-MISS", "NEAR_MISS", "DECELERAT", "BRAKE", "IMPACT")):
                action = stripped.split(";", 1)[0].lstrip("- ").strip()
                critical.append(action)
            continue
        if len(header) < 6:
            header.append(stripped)
    excerpt = " ".join(header + critical[:4])
    if len(excerpt) > limit:
        return excerpt[:limit].rstrip() + "…"
    return excerpt


def _context_excerpt(run_dir: Path, trial_id: str, cluster: Any) -> str:
    """Stored context text for this trial. Jpg lines are left out."""
    paths: List[Path] = []
    trial_dir = _find_cluster_trial_dir(run_dir, trial_id, cluster)
    if trial_dir is None:
        trial_dir = _cluster_trial_dir(run_dir, trial_id, cluster)
    if trial_dir is not None:
        paths.append(trial_dir / "processed" / "context.md")
    text = "" if cluster is None else str(cluster).strip()
    if text.endswith(".0"):
        text = text[:-2]
    if text not in {"", "none", "-1", "noise"}:
        medoid = _read_yaml(run_dir / f"cluster{text}" / "output" / "medoid_trial.yaml")
        if str(medoid.get("trial_id") or "") == str(trial_id):
            paths.append(run_dir / f"cluster{text}" / "processed" / "context_medoid.md")
    paths.append(_legacy_trial_dir(run_dir, trial_id) / "context.md")
    # A medoid's own timeline is the stored context. A short trial card must not hide it.
    medoid_paths = [path for path in paths if path.name == "context_medoid.md"]
    other_paths = [path for path in paths if path.name != "context_medoid.md"]
    for path in medoid_paths + other_paths:
        if path.is_file():
            return _trim_context(path.read_text(encoding="utf-8"))
    return ""


def _context_is_timeline(path: Path) -> bool:
    if not path.is_file():
        return False
    text = path.read_text(encoding="utf-8")
    return "## Conflict timeline" in text and "No BEV was rendered" not in text


def _build_action_context(run_dir: Path, trial_id: str, trial_dir: Path) -> Path:
    """Write ``action.yaml`` and a medoid-style ``context.md`` for one trial.

    Same steps as the medoid card: esmini CSV, trajectory, ``action.yaml``,
    then the conflict-timeline sentences. Does not render a jpg and does not
    write ``cluster.json`` or ``context_cluster.md``.
    """
    import sys

    analyzer = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer) not in sys.path:
        sys.path.insert(0, str(analyzer))
    from agent_labels import display_agent_name
    from cluster_paths import ensure_layout, write_path
    from conflict_frame_selector import (
        format_conflict_timeline_sentences,
        select_action_frames,
    )
    from csv_roadid_loader import csv_exists, get_csv_road_data
    from dataset_builder import _df_to_observations, _load_csv_index_sidecar
    from dataset_config import map_tracks_path_for_dataset, xodr_path_for_dataset
    from labeller import label_trajectory, save_action_yaml
    from sim_labeller import build_meta_yaml, build_trajectory_csv
    from renderer import XodrParser

    row = _trial_row(run_dir, trial_id)
    cluster = row.get("cluster_label")
    text = "" if cluster is None else str(cluster).strip()
    if text.endswith(".0"):
        text = text[:-2]
    clab = "noise" if text in {"-1", "noise", ""} else f"c{text}"
    outcome = "collision" if row.get("passed") is False or row.get("passed") == 0 else "safe"
    batch_id = _batch_id_from_run(run_dir)
    mapping = _load_csv_index_sidecar(prefer_batch_id=batch_id)
    pair = mapping.get(str(trial_id))
    if pair is None:
        raise FileNotFoundError(f"trial {trial_id} has no esmini CSV index on this machine")
    csv_batch, trial_index = int(pair[0]), int(pair[1])
    if not csv_exists(csv_batch, trial_index):
        raise FileNotFoundError(f"esmini CSV for trial {trial_id} is not on this machine")
    df = get_csv_road_data(csv_batch, trial_index)
    if df is None or getattr(df, "empty", True):
        raise FileNotFoundError(f"esmini CSV for trial {trial_id} is empty")

    dataset = "dataset1"
    try:
        from dataset_config import dataset_for_batch_id

        if batch_id is not None and dataset_for_batch_id(int(batch_id)):
            dataset = dataset_for_batch_id(int(batch_id))
    except Exception:
        dataset = "dataset1"
    xodr_path = xodr_path_for_dataset(dataset)
    parser = XodrParser(str(xodr_path))
    ensure_layout(trial_dir)
    trajectory_path = write_path(trial_dir, "trajectory.csv")
    meta_path = write_path(trial_dir, "meta.yaml")
    action_path = write_path(trial_dir, "action.yaml")
    observations = _df_to_observations(df)
    registry = build_trajectory_csv(observations, parser, trajectory_path)
    location = Path(xodr_path).stem
    build_meta_yaml(
        registry,
        observations,
        meta_path,
        dataset="gpl-odd-simulated",
        location=location,
    )
    map_yaml = Path(xodr_path).parent.parent / "map" / f"{location}.yaml"
    if not map_yaml.is_file():
        map_yaml = Path(xodr_path).parent / f"{location}.yaml"
    action_data = label_trajectory(
        trajectory_path,
        meta_path,
        map_yaml if map_yaml.is_file() else None,
        esmini_df=df,
        collided=(outcome == "collision"),
    )
    save_action_yaml(action_data, action_path)
    import pandas as pd

    traj_df = pd.read_csv(trajectory_path)
    selection = select_action_frames(traj_df, action_data=action_data)
    map_tracks = map_tracks_path_for_dataset(dataset)
    timeline = format_conflict_timeline_sentences(
        selection,
        action_data=action_data,
        traj_df=traj_df,
        map_tracks_csv=str(map_tracks) if map_tracks.is_file() else None,
    )
    timeline = timeline.replace(
        "Chronological action and BEV stamps for this cluster medoid.",
        "Chronological action stamps for this trial, from action.yaml.",
    )
    duration = 0.0
    if observations:
        duration = float(observations[-1]["time"]) - float(observations[0]["time"])
    agents = ", ".join(
        f"{display_agent_name(agent.name)} ({agent.obj_class})" for agent in registry
    )
    lines = [
        f"# Trial — [{clab}]",
        "",
        f"- **Cluster**: [{clab}]",
        f"- **Outcome**: {outcome}",
        f"- **Map**: {location}, duration {duration:.3f}s, {len(observations)} frames",
    ]
    if agents:
        lines.append(f"- **Agents**: {agents}")
    lines.extend(["", timeline.rstrip(), ""])
    dest = trial_dir / "processed" / "context.md"
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text("\n".join(lines), encoding="utf-8")
    try:
        meta_path.unlink(missing_ok=True)
    except Exception:
        pass
    return dest


def ensure_trial_context(run_dir: Path, trial_id: str) -> Path:
    """Write a medoid-style ``context.md`` from this trial's ``action.yaml``.

    A noise trial (cluster -1) is written under ``noise/``. A file that already
    has a conflict timeline is left as it is. Does not render a jpg.
    """
    run_dir = Path(run_dir)
    trial_id = str(trial_id)
    row = _trial_row(run_dir, trial_id)
    cluster = row.get("cluster_label")
    trial_dir = _cluster_trial_dir(run_dir, trial_id, cluster)
    if trial_dir is None:
        trial_dir = _legacy_trial_dir(run_dir, trial_id)
    dest = trial_dir / "processed" / "context.md"
    if trial_dir == _legacy_trial_dir(run_dir, trial_id):
        dest = trial_dir / "context.md"
    if _context_is_timeline(dest):
        return dest
    try:
        return _build_action_context(run_dir, trial_id, trial_dir)
    except Exception as exc:
        _write_context(run_dir, trial_id, f"action context was not built: {exc}", 0)
        return dest


def describe_selection(run_dir: Path, trial_ids: List[str], source: str = "lasso") -> Dict[str, Any]:
    run_dir = Path(run_dir)
    sampled = sample_trial_ids(run_dir, trial_ids)
    for tid in sampled:
        ensure_trial_context(run_dir, tid)
    index = _trial_index(run_dir)
    all_ids = [str(item).strip() for item in trial_ids if str(item).strip().isdigit()]
    counts: Dict[str, int] = {}
    for tid in all_ids:
        key = _cluster_key(index.get(tid, {}))
        counts[key] = counts.get(key, 0) + 1
    rows = []
    for tid in sampled:
        located = locate_trial(run_dir, tid)
        cluster = located.get("cluster")
        if cluster is None or cluster == "":
            cluster = _cluster_key(index.get(tid, {}))
            located["cluster"] = cluster
        located["context"] = _context_excerpt(run_dir, tid, cluster)
        located["critical_frames"] = _critical_frames(
            _snapshot_dir_for_trial(run_dir, tid, cluster)
        )
        rows.append(located)
    total = len(all_ids)
    label = selection_label(run_dir, all_ids, source)
    share = ", ".join(
        f"cluster {name}: {counts[name]}"
        for name in sorted(counts, key=_cluster_sort_key)
    )
    by_cluster: Dict[str, List[Dict[str, Any]]] = {}
    for row in rows:
        by_cluster.setdefault(str(row.get("cluster")), []).append(row)
    outcome_lines = [
        "Sent outcomes. Name every cluster below, including a cluster whose sent trials all passed. "
        "One line per cluster: the trial ids and passed or collision. "
        "Do not answer with only the colliding clusters."
    ]
    for name in sorted(by_cluster, key=_cluster_sort_key):
        parts = [
            f"{item['trial_id']} {_sent_outcome(item.get('passed'))}"
            for item in by_cluster[name]
        ]
        outcome_lines.append(f"- cluster {name}: " + "; ".join(parts))
    lines = [
        f"SELECTION {label}.",
        f"Clusters in this selection: {share}.",
        "Each cluster that appears contributes 1 to 3 of the sent trials, from its share. "
        "Stored context is text. Jpg files are not attached. "
        "At most 3 critical-time frame rows are included, as the action label and one time. "
        "When the question asks which clusters are present or which sent trials collide, "
        "use the sent-outcome lines, cover every cluster, and stop. "
        "Do not add a behavior paragraph for each trial. "
        "A behavior summary is two or three sentences: what Ego did and how it ended. "
        "Keep at most one time and one distance. "
        "Do not copy an At t= line, lateral_speed, heading_vs_road, or azimuth. "
        "Which trials collide is answered from the sent rows only.",
        *outcome_lines,
    ]
    for row in rows:
        lines.append(
            f"- trial {row['trial_id']}: cluster {row.get('cluster')}, "
            f"passed {row.get('passed')}, stored {row['source']}"
        )
        lines.append(
            f"  context: {row['context']}" if row.get("context") else "  context: no stored context"
        )
        frames = row.get("critical_frames") or []
        if frames:
            bits = [
                f"t={frame.get('t')} {frame.get('label')}"
                for frame in frames
            ]
            lines.append("  critical frames: " + "; ".join(bits))
        else:
            lines.append("  critical frames: none")
    return {"label": label, "sampled": rows, "total": total, "prompt": "\n".join(lines)}


def _write_context(run_dir: Path, trial_id: str, note: str, frame_count: int) -> None:
    row = _trial_row(run_dir, trial_id)
    cluster_dir = _cluster_trial_dir(run_dir, trial_id, row.get("cluster_label"))
    if cluster_dir is not None:
        dest = cluster_dir / "processed"
    else:
        dest = _legacy_trial_dir(run_dir, trial_id)
    dest.mkdir(parents=True, exist_ok=True)
    params = row.get("parameters") or {}
    param_lines = "\n".join(f"- {key}: {value}" for key, value in params.items()) or "- (no parameter row)"
    text = (
        f"# trial {trial_id}\n\n"
        f"cluster: {row.get('cluster_label')}\n"
        f"passed: {row.get('passed')}\n\n"
        f"parameters:\n{param_lines}\n\n"
        f"frames: {frame_count}\n"
        f"{note}\n"
    )
    (dest / "context.md").write_text(text, encoding="utf-8")


def _batch_id_from_run(run_dir: Path) -> Optional[int]:
    for part in Path(run_dir).parts:
        if part.startswith("batch") and part[5:].isdigit():
            return int(part[5:])
    return None


def build_trial(run_dir: Path, trial_id: str, batch_id: Optional[int] = None) -> Dict[str, Any]:
    """Render jpg frames only when this trial does not already have one."""
    run_dir = Path(run_dir)
    trial_id = str(trial_id)
    located = locate_trial(run_dir, trial_id)
    if located["images"]:
        located["built"] = False
        located["ok"] = True
        return located

    batch_id = batch_id if batch_id is not None else _batch_id_from_run(run_dir)
    row = _trial_row(run_dir, trial_id)
    cluster_dir = _cluster_trial_dir(run_dir, trial_id, row.get("cluster_label"))
    if cluster_dir is not None:
        snap_dir = cluster_dir / "processed" / "snapshots"
    else:
        snap_dir = _legacy_trial_dir(run_dir, trial_id) / "snapshots"
    snap_dir.mkdir(parents=True, exist_ok=True)
    try:
        images = _render_frames(run_dir, trial_id, snap_dir, batch_id)
    except Exception as exc:
        _write_context(run_dir, trial_id, f"frames were not rendered: {exc}", 0)
        located = locate_trial(run_dir, trial_id)
        located["built"] = False
        located["ok"] = False
        located["error"] = str(exc)
        return located
    _write_context(run_dir, trial_id, "rendered for this conversation", len(images))
    located = locate_trial(run_dir, trial_id)
    located["built"] = True
    located["ok"] = True
    return located


def _render_frames(
    run_dir: Path,
    trial_id: str,
    snap_dir: Path,
    batch_id: Optional[int],
) -> List[Dict[str, Any]]:
    import sys

    analyzer = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer) not in sys.path:
        sys.path.insert(0, str(analyzer))
    from csv_roadid_loader import csv_exists
    from dataset_builder import _load_csv_index_sidecar
    from tier2_renderer import Tier2BevRenderer, resolve_tier2_paths

    mapping = _load_csv_index_sidecar(prefer_batch_id=batch_id)
    pair = mapping.get(str(trial_id))
    if pair is None:
        raise FileNotFoundError(
            f"trial {trial_id} has no esmini CSV index on this machine"
        )
    csv_batch, trial_index = pair
    if not csv_exists(int(csv_batch), int(trial_index)):
        raise FileNotFoundError(
            f"esmini CSV for trial {trial_id} is not on this machine"
        )
    dataset = "dataset1"
    try:
        from dataset_config import dataset_for_batch_id

        if batch_id is not None and dataset_for_batch_id(int(batch_id)):
            dataset = dataset_for_batch_id(int(batch_id))
    except Exception:
        dataset = "dataset1"
    xodr, tracks, location = resolve_tier2_paths(dataset)
    if not tracks.is_file():
        raise FileNotFoundError(f"map tracks are not on disk: {tracks}")
    renderer = Tier2BevRenderer(
        map_tracks_csv=str(tracks),
        xodr_path=str(xodr),
        location=location,
        dataset_name=dataset,
    )
    snaps = renderer.render_trial_from_esmini_csv(
        int(csv_batch),
        int(trial_index),
        str(snap_dir),
        n_snapshots=8,
        file_prefix=f"trial_{trial_id}",
    )
    rows = []
    for snap in snaps or []:
        path = Path(getattr(snap, "path", "") or "")
        if not path.is_file():
            continue
        rows.append(
            {
                "file": path.name,
                "t": getattr(snap, "timestep", None),
                "label": getattr(snap, "label", path.name),
            }
        )
    table = {"snapshots": rows}
    (snap_dir / "llm_snapshots.json").write_text(json.dumps(table, indent=2), encoding="utf-8")
    return rows


def build_trials(run_dir: Path, trial_ids: List[str], batch_id: Optional[int] = None) -> Dict[str, Any]:
    sampled = sample_trial_ids(run_dir, trial_ids)
    rows = [build_trial(run_dir, tid, batch_id=batch_id) for tid in sampled]
    total = len([str(x).strip() for x in trial_ids if str(x).strip().isdigit()])
    return {
        "total": total,
        "sampled": len(sampled),
        "trials": rows,
    }
