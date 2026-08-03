"""Cluster pack path contract: raw / processed / output.

Writers always use the nested layout. Readers resolve nested first, then
legacy flat filenames under ``cluster_dir`` so older packs still open.
"""

from __future__ import annotations

from pathlib import Path
from typing import Literal, Optional, Union

Kind = Literal["raw", "processed", "output"]

# Logical artifact name → (kind, relative filename under that kind dir)
_ARTIFACTS: dict[str, tuple[Kind, str]] = {
    "trajectory.csv": ("raw", "trajectory.csv"),
    "cluster.json": ("raw", "cluster.json"),
    "action.yaml": ("processed", "action.yaml"),
    "description.txt": ("processed", "description.txt"),
    "context.md": ("processed", "context.md"),
    "cluster_aggregate.json": ("processed", "cluster_aggregate.json"),
    "map_overview.jpg": ("processed", "map_overview.jpg"),
    "meta.yaml": ("processed", "meta.yaml"),
    "medoid_trial.yaml": ("output", "medoid_trial.yaml"),
    "cluster_summary.yaml": ("output", "cluster_summary.yaml"),
}


def raw_dir(cluster_dir: Union[str, Path]) -> Path:
    return Path(cluster_dir) / "raw"


def processed_dir(cluster_dir: Union[str, Path]) -> Path:
    return Path(cluster_dir) / "processed"


def output_dir(cluster_dir: Union[str, Path]) -> Path:
    return Path(cluster_dir) / "output"


def highlight_trials_dir(cluster_dir: Union[str, Path]) -> Path:
    """Parent for outlier / emb-boundary / IC-boundary trial packs."""
    return Path(cluster_dir) / "highlight_trials"


def snapshots_dir(cluster_dir: Union[str, Path]) -> Path:
    """Write target for BEV snapshots (always nested)."""
    return processed_dir(cluster_dir) / "snapshots"


def ensure_layout(cluster_dir: Union[str, Path]) -> None:
    """Create raw / processed / output (and snapshots) directories."""
    root = Path(cluster_dir)
    for d in (raw_dir(root), processed_dir(root), output_dir(root), snapshots_dir(root)):
        d.mkdir(parents=True, exist_ok=True)


# Aux trial pack folder names under highlight_trials/
_HIGHLIGHT_KINDS = ("outlier_trials", "boundary_c", "param_boundary_c")


def highlight_subdir(
    cluster_dir: Union[str, Path],
    kind: str,
    *,
    target_cluster: Optional[Union[str, int]] = None,
) -> Path:
    """Write path for an aux highlight folder (always under highlight_trials/).

    Examples::

      highlight_subdir(c, "outlier_trials")
      → clusterN/highlight_trials/outlier_trials
      highlight_subdir(c, "boundary_c", target_cluster=1)
      → clusterN/highlight_trials/boundary_c1
      highlight_subdir(c, "param_boundary_c", target_cluster=2)
      → clusterN/highlight_trials/param_boundary_c2
    """
    root = Path(cluster_dir)
    if kind == "outlier_trials":
        name = "outlier_trials"
    elif kind in ("boundary_c", "param_boundary_c"):
        if target_cluster is None:
            raise ValueError(f"{kind} requires target_cluster")
        name = f"{kind}{target_cluster}"
    else:
        raise ValueError(f"Unknown highlight kind: {kind!r}")
    p = highlight_trials_dir(root) / name
    p.mkdir(parents=True, exist_ok=True)
    return p


def resolve_highlight_subdir(
    cluster_dir: Union[str, Path],
    folder_name: str,
    *,
    must_exist: bool = False,
) -> Optional[Path]:
    """Resolve ``outlier_trials`` / ``boundary_cM`` / ``param_boundary_cM``.

    Prefers ``highlight_trials/<name>``, then legacy ``cluster_dir/<name>``.
    """
    root = Path(cluster_dir)
    nested = highlight_trials_dir(root) / folder_name
    legacy = root / folder_name
    if nested.is_dir():
        return nested
    if legacy.is_dir():
        return legacy
    if must_exist:
        return None
    return nested


def migrate_highlight_trials(cluster_dir: Union[str, Path]) -> list[str]:
    """Move legacy flat aux folders into ``highlight_trials/``. Returns move notes."""
    import shutil
    import re

    root = Path(cluster_dir)
    ht = highlight_trials_dir(root)
    moved: list[str] = []
    pattern = re.compile(r"^(outlier_trials|boundary_c\d+|param_boundary_c\d+)$")
    for child in list(root.iterdir()) if root.is_dir() else []:
        if not child.is_dir() or not pattern.match(child.name):
            continue
        dest = ht / child.name
        if dest.resolve() == child.resolve():
            continue
        if dest.exists():
            continue  # already migrated / nested present
        ht.mkdir(parents=True, exist_ok=True)
        shutil.move(str(child), str(dest))
        moved.append(f"{child.name} -> highlight_trials/{child.name}")
    return moved


def write_path(cluster_dir: Union[str, Path], artifact: str) -> Path:
    """Return nested write path for a known artifact name (creates parent dirs)."""
    root = Path(cluster_dir)
    if artifact == "snapshots" or artifact == "snapshots/":
        p = snapshots_dir(root)
        p.mkdir(parents=True, exist_ok=True)
        return p
    if artifact not in _ARTIFACTS:
        raise KeyError(f"Unknown cluster artifact: {artifact!r}")
    kind, name = _ARTIFACTS[artifact]
    base = {"raw": raw_dir, "processed": processed_dir, "output": output_dir}[kind](root)
    base.mkdir(parents=True, exist_ok=True)
    return base / name


def resolve_path(
    cluster_dir: Union[str, Path],
    artifact: str,
    *,
    must_exist: bool = False,
) -> Optional[Path]:
    """Resolve artifact: nested layout first, then legacy flat ``cluster_dir/name``.

    Returns ``None`` if ``must_exist`` and neither path exists.
    If ``must_exist`` is False, returns the preferred nested write path even if
    missing (callers that only read should pass ``must_exist=True``).
    """
    root = Path(cluster_dir)
    if artifact in ("snapshots", "snapshots/"):
        nested = snapshots_dir(root)
        legacy = root / "snapshots"
        if nested.is_dir():
            return nested
        if legacy.is_dir():
            return legacy
        return nested if not must_exist else None

    if artifact not in _ARTIFACTS:
        # Allow arbitrary relative names: try processed/, then flat.
        nested = processed_dir(root) / artifact
        flat = root / artifact
        if nested.is_file() or nested.is_dir():
            return nested
        if flat.is_file() or flat.is_dir():
            return flat
        return nested if not must_exist else None

    kind, name = _ARTIFACTS[artifact]
    nested = {"raw": raw_dir, "processed": processed_dir, "output": output_dir}[kind](
        root
    ) / name
    flat = root / name
    if nested.is_file() or nested.is_dir():
        return nested
    if flat.is_file() or flat.is_dir():
        return flat
    if must_exist:
        return None
    return nested


def migrate_flat_to_nested(cluster_dir: Union[str, Path]) -> list[str]:
    """Move known flat artifacts into nested dirs. Returns list of moves ``src->dst``."""
    import shutil

    root = Path(cluster_dir)
    ensure_layout(root)
    moved: list[str] = []
    for artifact, (kind, name) in _ARTIFACTS.items():
        flat = root / name
        if not flat.is_file():
            continue
        dest = write_path(root, artifact)
        if flat.resolve() == dest.resolve():
            continue
        if dest.is_file():
            continue  # nested already present
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(flat), str(dest))
        moved.append(f"{flat.name} -> {kind}/{name}")

    flat_snaps = root / "snapshots"
    nested_snaps = snapshots_dir(root)
    if flat_snaps.is_dir() and flat_snaps.resolve() != nested_snaps.resolve():
        nested_snaps.mkdir(parents=True, exist_ok=True)
        for child in flat_snaps.iterdir():
            target = nested_snaps / child.name
            if not target.exists():
                shutil.move(str(child), str(target))
                moved.append(f"snapshots/{child.name} -> processed/snapshots/{child.name}")
        try:
            flat_snaps.rmdir()
        except OSError:
            pass
    return moved
