#!/usr/bin/env python3
"""Shared map assets under ``results/map/`` (tracks + yaml + overview jpg).

Used by ``dataset_builder`` (auto-ensure on every build / ``--map-only``).

Required per map (e.g. ``hct_6`` / ``hct_6_no_930``):
  * ``<map>.xodr``            — OpenDRIVE (copied from sim cache if needed)
  * ``<map>_tracks.csv``      — odrplot lane geometry for BEV
  * ``<map>.yaml``            — junction/road metadata for the labeller
Optional:
  * ``<map>.jpg``             — full-network overview render
  * ``<map>_description.txt`` — prose map glossary
"""
from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence

import yaml

from dataset_config import (
    DATASETS,
    XODR_DIR,
    dataset_for_batch_id,
    get_dataset_config,
    map_tracks_path_for_dataset,
    xodr_path_for_dataset,
)
from repo_paths import MAP_DIR, REPO_ROOT

MAP_DIR.mkdir(parents=True, exist_ok=True)


# ---------------------------------------------------------------------------
# odrplot tracks
# ---------------------------------------------------------------------------

def find_odrplot(repo_root: Optional[Path] = None) -> Optional[Path]:
    root = repo_root or REPO_ROOT
    candidates = [
        root / "simulation/ros/src/esmini/bin/odrplot",
        root
        / "simulation/ros/src/esmini/build/EnvironmentSimulator/Applications/odrplot/odrplot",
        Path(os.environ.get("ESMINI_ODRPLOT", "")),
        root.parent / "xosc_gen/esmini/bin/odrplot",
        root.parent / "esmini/bin/odrplot",
    ]
    for c in candidates:
        if c and c.is_file() and os.access(c, os.X_OK):
            return c
    return None


def _ensure_xodr_in_map_dir(cfg: Dict[str, Any], repo: Path = REPO_ROOT) -> Path:
    """Return ``results/map/<xodr>``, copying from sim cache if needed."""
    xodr = XODR_DIR / cfg["xodr"]
    if xodr.is_file():
        return xodr
    src = repo / "simulation/ros/.cache/scenario_search" / cfg["xodr"]
    if src.is_file():
        XODR_DIR.mkdir(parents=True, exist_ok=True)
        shutil.copy(src, xodr)
        print(f"  ✓ Copied source map → {xodr}")
        return xodr
    raise FileNotFoundError(
        f"OpenDRIVE not found: {xodr} (also missing cache copy {src})"
    )


def generate_tracks_for_dataset(
    dataset: str,
    *,
    step: float = 2.0,
    odrplot: Optional[Path] = None,
    force: bool = False,
) -> Path:
    """Write ``results/map/<map>_tracks.csv``. Returns the tracks path."""
    cfg = get_dataset_config(dataset)
    out = XODR_DIR / cfg["tracks"]
    if out.is_file() and not force:
        return out

    plot = odrplot or find_odrplot()
    if plot is None:
        raise RuntimeError(
            "odrplot binary not found. Set ESMINI_ODRPLOT or build esmini."
        )
    xodr = _ensure_xodr_in_map_dir(cfg)
    out.parent.mkdir(parents=True, exist_ok=True)
    cmd = [str(plot), str(xodr), str(out), str(step)]
    print("  Running:", " ".join(cmd))
    subprocess.run(cmd, check=True)
    print(f"  ✓ Wrote {out} ({out.stat().st_size // 1024} KB)")
    return out


# ---------------------------------------------------------------------------
# XODR → yaml / description / jpg
# ---------------------------------------------------------------------------

def parse_map(xodr_path: Path) -> Dict[str, Any]:
    """Parse roads + junctions from an OpenDRIVE file (map-agnostic)."""
    tree = ET.parse(str(xodr_path))
    root = tree.getroot()

    arterial_roads: List[int] = []
    junction_roads: List[int] = []
    road_lanes: Dict[int, Dict[str, List[int]]] = {}

    for road in root.findall("road"):
        try:
            rid = int(road.get("id"))
        except (TypeError, ValueError):
            continue
        junction_attr = road.get("junction", "-1")
        if junction_attr in (None, "-1"):
            arterial_roads.append(rid)
        else:
            junction_roads.append(rid)

        driving: List[int] = []
        ls = road.find(".//lanes/laneSection")
        if ls is not None:
            for side in ("left", "right"):
                side_elem = ls.find(side)
                if side_elem is None:
                    continue
                for lane in side_elem.findall("lane"):
                    if lane.get("type") == "driving":
                        try:
                            driving.append(int(lane.get("id")))
                        except (TypeError, ValueError):
                            pass
        if driving:
            road_lanes[rid] = {"driving": sorted(driving)}

    junctions: Dict[str, List[int]] = {}
    for junction in root.findall("junction"):
        jid = junction.get("id")
        conn_roads = set()
        for conn in junction.findall("connection"):
            cr = conn.get("connectingRoad")
            if cr is not None:
                try:
                    conn_roads.add(int(cr))
                except ValueError:
                    pass
        junctions[str(jid)] = sorted(conn_roads)

    return {
        "map_id": xodr_path.stem,
        "n_roads": len(arterial_roads) + len(junction_roads),
        "n_arterial_roads": len(arterial_roads),
        "n_junctions": len(junctions),
        "n_junction_roads": len(junction_roads),
        "Roads": sorted(arterial_roads),
        "JunctionRoads": sorted(junction_roads),
        "Junctions": junctions,
        "RoadLanes": road_lanes,
    }


def build_map_description(map_data: Dict[str, Any]) -> str:
    """Human-readable summary used as map context in the LLM prompt."""
    lines = [
        f"Map: {map_data['map_id']}",
        "",
        "Interpretation rules for the BEV map images:",
        "- Colored zones are drivable lanes. Red boxed numbers are Road IDs; "
        "black boxed numbers are lane IDs.",
        "- Lane IDs closest to zero are the innermost lanes; positive vs "
        "negative IDs are opposite sides of the reference line.",
        "- A road may belong to a junction (intersection / merge / ramp) or be "
        "an arterial road between junctions.",
        "",
        f"This map has {map_data['n_roads']} roads "
        f"({map_data['n_arterial_roads']} arterial, "
        f"{map_data['n_junction_roads']} junction-roads) and "
        f"{map_data['n_junctions']} junctions.",
        "",
        "A vehicle is 'inside a junction' whenever its road_id is one of the "
        "JunctionRoads listed in the map YAML; otherwise it is travelling along "
        "an arterial road.",
    ]
    return "\n".join(lines)


def preprocess_map_for_dataset(
    dataset: str,
    *,
    force: bool = False,
    no_image: bool = False,
    image_size: int = 1024,
    road_label_size: float = 5.0,
    lane_label_size: float = 5.0,
    road_label_plain_size: float = 5.0,
) -> Dict[str, Path]:
    """Write yaml / description / jpg for *dataset*. Returns output paths."""
    cfg = get_dataset_config(dataset)
    map_id = Path(cfg["xodr"]).stem
    xodr_path = _ensure_xodr_in_map_dir(cfg)
    tracks_path = XODR_DIR / cfg["tracks"]

    yaml_out = MAP_DIR / f"{map_id}.yaml"
    txt_out = MAP_DIR / f"{map_id}_description.txt"
    jpg_out = MAP_DIR / f"{map_id}.jpg"

    need_yaml = force or not yaml_out.is_file()
    need_txt = force or not txt_out.is_file()
    need_jpg = (not no_image) and (force or not jpg_out.is_file())

    if not (need_yaml or need_txt or need_jpg):
        return {"xodr": xodr_path, "tracks": tracks_path, "yaml": yaml_out,
                "description": txt_out, "jpg": jpg_out}

    print(f"  🔹 Parsing {xodr_path.name} …")
    map_data = parse_map(xodr_path)
    print(
        f"    roads={map_data['n_roads']} "
        f"(arterial={map_data['n_arterial_roads']}, "
        f"junction-roads={map_data['n_junction_roads']}), "
        f"junctions={map_data['n_junctions']}"
    )

    if need_yaml:
        with yaml_out.open("w") as f:
            yaml.safe_dump(map_data, f, sort_keys=False)
        print(f"  ✓ {yaml_out}")

    if need_txt:
        txt_out.write_text(build_map_description(map_data), encoding="utf-8")
        print(f"  ✓ {txt_out}")

    if need_jpg:
        if not tracks_path.is_file():
            print(f"  ⚠️  map image skipped — tracks missing: {tracks_path}")
        else:
            try:
                from map_plotter import BevTypography, MapPlotter

                typography = BevTypography(
                    road_label_size=road_label_size,
                    lane_label_size=lane_label_size,
                    road_label_plain_size=road_label_plain_size,
                )
                MapPlotter().plot_empty_map(
                    str(tracks_path),
                    str(jpg_out),
                    map_data["Roads"],
                    typography=typography,
                    output_px=image_size,
                )
                print(f"  ✓ {jpg_out} ({image_size}×{image_size} px)")
            except Exception as exc:  # noqa: BLE001
                print(f"  ⚠️  map image render failed: {exc}")

    return {"xodr": xodr_path, "tracks": tracks_path, "yaml": yaml_out,
            "description": txt_out, "jpg": jpg_out}


# ---------------------------------------------------------------------------
# Auto ensure (called by dataset_builder)
# ---------------------------------------------------------------------------

def map_assets_ready(dataset: str) -> bool:
    """True when xodr + tracks + yaml exist for *dataset*."""
    try:
        cfg = get_dataset_config(dataset)
    except KeyError:
        return False
    map_id = Path(cfg["xodr"]).stem
    return (
        (XODR_DIR / cfg["xodr"]).is_file()
        and (XODR_DIR / cfg["tracks"]).is_file()
        and (MAP_DIR / f"{map_id}.yaml").is_file()
    )


def ensure_map_assets(
    *,
    batch_id: Optional[int] = None,
    dataset: Optional[str] = None,
    force: bool = False,
    step: float = 2.0,
    no_image: bool = False,
    skip: bool = False,
) -> Optional[str]:
    """Ensure ``results/map/`` assets for the resolved dataset.

    Returns the canonical dataset name, or None if it cannot be resolved.
    Missing pieces are generated; existing files are left alone unless *force*.
    """
    if skip:
        return dataset

    ds = dataset
    if ds is None and batch_id is not None:
        ds = dataset_for_batch_id(batch_id)
    if ds is None:
        return None
    if ds not in DATASETS:
        print(f"  ⚠️  Unknown dataset {ds!r} — skip map asset ensure")
        return ds

    cfg = get_dataset_config(ds)
    map_id = Path(cfg["xodr"]).stem
    print(f"🗺️  Map assets for {ds} ({cfg.get('description', map_id)}) → {MAP_DIR}")

    if map_assets_ready(ds) and not force:
        print(f"  ✓ Already complete ({map_id}.xodr / _tracks.csv / .yaml)")
        return ds

    try:
        generate_tracks_for_dataset(ds, step=step, force=force)
        preprocess_map_for_dataset(ds, force=force, no_image=no_image)
    except Exception as exc:  # noqa: BLE001
        print(f"  ⚠️  Map asset generation failed: {exc}")
        print("     BEV / junction labelling may be incomplete.")
        return ds

    if map_assets_ready(ds):
        print(f"  ✅ Map assets ready under {MAP_DIR}")
    else:
        print(f"  ⚠️  Map assets still incomplete under {MAP_DIR}")
    return ds


def resolve_datasets(
    *,
    batch_id: Optional[int] = None,
    dataset: Optional[str] = None,
    all_datasets: bool = False,
) -> List[str]:
    if all_datasets:
        return list(DATASETS)
    if batch_id is not None:
        ds = dataset_for_batch_id(batch_id)
        if ds is None:
            raise ValueError(
                f"no map config for batch id {batch_id}; "
                f"known: {[c['batch_id'] for c in DATASETS.values()]}"
            )
        return [ds]
    if dataset:
        return [dataset]
    raise ValueError("provide --batch-id, --dataset, or --all")


# ---------------------------------------------------------------------------
# Standalone CLI (also used via app/analyzer/src/dataset_builder.py --map-only)
# ---------------------------------------------------------------------------

def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = argparse.ArgumentParser(
        description="Ensure / regenerate shared map assets in results/map/"
    )
    parser.add_argument("--batch-id", type=int, default=None)
    parser.add_argument("--dataset", default=None)
    parser.add_argument("--all", action="store_true", help="Every map variant")
    parser.add_argument("--force", action="store_true", help="Regenerate even if present")
    parser.add_argument("--step", type=float, default=2.0, help="odrplot step (m)")
    parser.add_argument("--no-image", action="store_true", help="Skip .jpg overview")
    args = parser.parse_args(list(argv) if argv is not None else None)

    try:
        datasets = resolve_datasets(
            batch_id=args.batch_id, dataset=args.dataset, all_datasets=args.all
        )
    except ValueError as exc:
        parser.error(str(exc))
        return 2

    for ds in datasets:
        ensure_map_assets(
            dataset=ds,
            force=args.force,
            step=args.step,
            no_image=args.no_image,
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
