#!/usr/bin/env python3
"""map_preprocess.py — V1-0/1/2: build map metadata for a gpl-odd dataset.

Adapted from xosc_gen/scripts/map_preprocess.py, but **map-agnostic**.

WHY NOT REUSE xosc_gen DIRECTLY
-------------------------------
xosc_gen's map_preprocess assumes a single, isolated 4-way intersection:
`collect_arterial_roads()` raises unless **exactly 4** arterial roads connect
to the target junction, and CCW ordering / turn classification all assume that
4-way layout. The gpl-odd `hct_6.xodr` map is a full real-world road network
(554 roads, 66 junctions, 437 junction-roads), so that approach does not apply.

Instead this script extracts the junction information that the downstream
rule-based labeller actually needs:
  * Roads         — arterial roads (road @junction == -1)
  * JunctionRoads — roads that belong to a junction (road @junction != -1)
  * Junctions     — {junction_id: [connecting road ids]}
  * RoadLanes     — per-road driving lane ids (for description context)

Outputs (into results/map/):
  * <map_id>.yaml              — the structured map metadata above
  * <map_id>_description.txt   — human-readable lane/junction summary
  * <map_id>.jpg               — top-down map image (MapPlotter, no agents)

Usage:
  python3 scripts/map_preprocess.py --batch-id 1
  python3 scripts/map_preprocess.py --map-id hct_6   # explicit map id
"""
from __future__ import annotations

import argparse
import sys
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Dict, List

import yaml

SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parent
ANALYZER_SRC = REPO_ROOT / "app" / "analyzer" / "src"
if str(ANALYZER_SRC) not in sys.path:
    sys.path.insert(0, str(ANALYZER_SRC))

# Shared map assets (xodr input + generated yaml/jpg/description) live in results/map.
XODR_DIR = REPO_ROOT / "results" / "map"
MAP_DIR = REPO_ROOT / "results" / "map"


def parse_map(xodr_path: Path) -> Dict:
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

        # collect driving lane ids for this road (first lane section is enough)
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


def build_description(map_data: Dict) -> str:
    """Human-readable summary used as map context in the LLM prompt (Step 5)."""
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


def main() -> int:
    ap = argparse.ArgumentParser(description="Map-agnostic XODR preprocessor")
    ap.add_argument("--batch-id", type=int, default=None, help="Payload batch id (resolves the map via dataset_config). Preferred.")
    ap.add_argument("--dataset", default=None, help="Internal alias: dataset1/2/3 (prefer --batch-id)")
    ap.add_argument("--map-id", default=None, help="Map id (e.g. hct_6); overrides --batch-id/--dataset")
    ap.add_argument("--no-image", action="store_true", help="Skip .jpg map render")
    ap.add_argument(
        "--image-size",
        type=int,
        default=1024,
        help="Square map JPG output size in pixels (default: 1024)",
    )
    ap.add_argument(
        "--road-label-size",
        type=float,
        default=5,
        help="Font size (pt) for road IDs on hct_6.jpg (default: 1.4)",
    )
    ap.add_argument(
        "--lane-label-size",
        type=float,
        default=5,
        help="Font size (pt) for lane IDs on hct_6.jpg (default: 1.4)",
    )
    ap.add_argument(
        "--road-label-plain-size",
        type=float,
        default=5,
        help="Font size (pt) for unhighlighted road IDs on hct_6.jpg (default: 1.2)",
    )
    args = ap.parse_args()

    if args.map_id:
        map_id = args.map_id
        tracks_name = f"{map_id}_tracks.csv"
    elif args.batch_id is not None or args.dataset:
        from dataset_config import get_dataset_config, dataset_for_batch_id

        dataset = args.dataset
        if args.batch_id is not None:
            dataset = dataset_for_batch_id(args.batch_id)
            if dataset is None:
                ap.error(f"no map config maps to batch id {args.batch_id}")
                return 2
        cfg = get_dataset_config(dataset)
        map_id = Path(cfg["xodr"]).stem
        tracks_name = cfg["tracks"]
    else:
        ap.error("provide --batch-id, --dataset, or --map-id")
        return 2

    xodr_path = XODR_DIR / f"{map_id}.xodr"
    if not xodr_path.is_file():
        print(f"❌ ERROR: XODR not found: {xodr_path}")
        return 1

    MAP_DIR.mkdir(parents=True, exist_ok=True)
    yaml_out = MAP_DIR / f"{map_id}.yaml"
    txt_out = MAP_DIR / f"{map_id}_description.txt"
    jpg_out = MAP_DIR / f"{map_id}.jpg"

    print(f"🔹 Parsing {xodr_path.name} ...")
    map_data = parse_map(xodr_path)
    print(
        f"  roads={map_data['n_roads']} "
        f"(arterial={map_data['n_arterial_roads']}, "
        f"junction-roads={map_data['n_junction_roads']}), "
        f"junctions={map_data['n_junctions']}"
    )

    with yaml_out.open("w") as f:
        yaml.safe_dump(map_data, f, sort_keys=False)
    print(f"  ✓ {yaml_out}")

    txt_out.write_text(build_description(map_data))
    print(f"  ✓ {txt_out}")

    if not args.no_image:
        tracks_path = XODR_DIR / tracks_name
        if not tracks_path.is_file():
            print(
                f"  ⚠️  map image skipped — odrplot tracks missing: {tracks_path}\n"
                f"     Run: python3 scripts/generate_map_tracks.py --dataset {args.dataset or map_id}"
            )
        else:
            try:
                from map_plotter import BevTypography, MapPlotter

                typography = BevTypography(
                    road_label_size=args.road_label_size,
                    lane_label_size=args.lane_label_size,
                    road_label_plain_size=args.road_label_plain_size,
                )
                plotter = MapPlotter()
                plotter.plot_empty_map(
                    str(tracks_path),
                    str(jpg_out),
                    map_data["Roads"],
                    typography=typography,
                    output_px=args.image_size,
                )
                print(f"  ✓ {jpg_out} ({args.image_size}×{args.image_size} px)")
            except Exception as e:  # noqa: BLE001
                print(f"  ⚠️  map image render failed: {e}")

    print("✅ map preprocessing complete")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
