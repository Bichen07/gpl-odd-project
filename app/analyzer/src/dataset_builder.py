#!/usr/bin/env python3
"""Build structured LLM dataset from medoid trials.

This script orchestrates Phase 4: for each cluster's medoid trial, it generates:
- trajectory.csv (xosc_gen format with roadId/laneId)
- meta.yaml (scenario metadata)
- BEV images (key timesteps)
- observations.json (raw Payload data)
- stats.json (cluster statistics)

Output structure: results/<dataset>/<n_clusters>/cluster<label>/
"""

import argparse
import json
import math
import os
import shutil
import sys
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple
import numpy as np

import yaml
import requests

# Add analyzer src to path for flat-module imports
from repo_paths import ANALYZER_SRC, REPO_ROOT, RESULTS_DIR

if str(ANALYZER_SRC) not in sys.path:
    sys.path.insert(0, str(ANALYZER_SRC))

from renderer import XodrParser
from csv_roadid_loader import csv_exists, get_csv_road_data
from sim_labeller import assign_agent_road_id, build_meta_yaml, build_trajectory_csv

# Project root
PROJECT_ROOT = REPO_ROOT

# Payload API endpoint (Note: docker-compose maps container port 3000 to host port 3020)
PAYLOAD_API = os.getenv("PAYLOAD_API_URL", "http://localhost:3020")


def _build_csv_trial_mapping() -> Dict[str, Tuple[int, int]]:
    """Build a mapping from trial IDs to (batch_id, trial_index) by scanning CSVs.
    
    Since the clustering result contains Payload trial IDs that may not exist in
    the local database, we infer the mapping from available CSV files.
    
    Returns:
        Dict mapping trial_id (str) -> (batch_id, trial_index)
    """
    import re
    from pathlib import Path
    
    cache_dir = PROJECT_ROOT / "simulation/ros/.cache/scenario_search/records"
    pattern = re.compile(r"esmini_(\d+)_(\d+)\.csv")
    
    # First, get all available CSVs
    csv_map = {}
    if not cache_dir.exists():
        return csv_map
    
    for fname in cache_dir.iterdir():
        m = pattern.match(fname.name)
        if m:
            batch_id = int(m.group(1))
            trial_index = int(m.group(2))
            csv_map[(batch_id, trial_index)] = True
    
    print(f"  Found {len(csv_map)} CSV files across batches")
    
    # The trial IDs in clustering.json are Payload IDs
    # But we need to map them to CSV indices
    # Strategy: since we don't have the authoritative mapping, we'll use a heuristic:
    # Load the trial IDs from clustering.json in order and assign them sequentially
    # to available CSV files (sorted by batch then index)
    
    # This is a fallback - ideally we'd have the actual mapping from Payload
    # For now, return empty dict and let caller handle it
    return {}


def _get_trial_metadata(trial_id: str, csv_mapping: Dict[str, Tuple[int, int]]) -> Tuple[Optional[int], Optional[int]]:
    """Get batch_id and trial_index for a trial.
    
    Tries Payload API first, falls back to CSV-based mapping.
    
    Returns:
        Tuple of (batch_id, trial_index) or (None, None) on error
    """
    # Try Payload first
    try:
        response = requests.get(
            f"{PAYLOAD_API}/api/trials/{trial_id}",
            timeout=2,
        )
        if response.status_code == 200:
            trial_data = response.json()
            batch_id = trial_data.get("batch")
            if isinstance(batch_id, dict):
                batch_id = batch_id.get("id")
            trial_index = trial_data.get("trialIndex")
            return (int(batch_id) if batch_id else None, 
                    int(trial_index) if trial_index else None)
    except:
        pass
    
    # Fall back to CSV mapping
    if trial_id in csv_mapping:
        return csv_mapping[trial_id]
    
    return None, None


def load_clustering_data(dataset: str, n_clusters: int) -> Optional[Tuple[Dict, Dict]]:
    """Load clustering embeddings and selected result.
    
    Returns:
        Tuple of (embeddings_dict, clustering_result_dict) or None on error
    """
    dataset_dir = PROJECT_ROOT / "alldatasets" / dataset
    
    # Load main clustering.json (contains embeddings)
    embeddings_path = dataset_dir / "clustering.json"
    if not embeddings_path.exists():
        print(f"❌ ERROR: Embeddings file not found: {embeddings_path}")
        return None
    
    with embeddings_path.open() as f:
        embeddings_data = json.load(f)
    
    # Load selectedClusteringResult_*Clusters.json (contains assignments)
    result_path = dataset_dir / f"selectedClusteringResult_{n_clusters}Clusters.json"
    if not result_path.exists():
        print(f"❌ ERROR: Clustering result not found: {result_path}")
        print(f"   Available files in {dataset_dir}:")
        for p in sorted(dataset_dir.glob("selectedClusteringResult_*.json")):
            print(f"   - {p.name}")
        return None
    
    with result_path.open() as f:
        result_data = json.load(f)
    
    return embeddings_data, result_data


def compute_medoids(
    embeddings_data: Dict[str, Any],
    result_data: Dict[str, Any],
    dataset: Optional[str] = None,
) -> List[Dict[str, Any]]:
    """Compute medoid trials for each cluster.
    
    Uses the same logic as controller.py get_cluster_medoids():
    For each cluster, find the trial whose embedding is closest to the centroid.
    
    Returns list of dicts with keys: cluster_label, trial_id, batch_id, trial_index, size
    """
    import numpy as np
    from sklearn.metrics import pairwise_distances_argmin
    
    embeddings_dict = embeddings_data.get("embeddings", {})
    cluster_assignments = result_data.get("data", {})
    
    if not embeddings_dict or not cluster_assignments:
        print("❌ ERROR: Missing embeddings or cluster assignments")
        return []
    
    trial_ids = []
    embeddings = []
    labels = []
    
    for trial_id, cluster_label in cluster_assignments.items():
        if trial_id not in embeddings_dict:
            continue
        trial_ids.append(trial_id)
        embeddings.append(embeddings_dict[trial_id])
        labels.append(int(cluster_label))
    
    X = np.array(embeddings, dtype=np.float64)
    labels_arr = np.array(labels, dtype=int)
    
    unique_labels = sorted(set(labels) - {-1})
    medoids = []

    csv_mapping = _build_csv_trial_mapping()
    
    def _resolve_indices(tid: str):
        b, ti = None, None
        if dataset:
            try:
                from dataset_config import trial_id_to_csv_indices
                b, ti = trial_id_to_csv_indices(dataset, tid)
            except Exception:
                pass
        if b is None:
            b, ti = _get_trial_metadata(tid, csv_mapping)
        return b, ti

    for label in unique_labels:
        mask = labels_arr == label
        X_cluster = X[mask]
        ids_cluster = np.array(trial_ids)[mask]
        cluster_size = int(mask.sum())

        # Rank cluster trials by distance to the centroid. The true medoid is
        # the closest, but its esmini CSV may not be cached locally, so we fall
        # back to the nearest trial that DOES have a CSV (keeps dataset1 fully
        # analysable with local data).
        centroid = X_cluster.mean(axis=0)
        dists = np.linalg.norm(X_cluster - centroid, axis=1)
        order = np.argsort(dists)

        chosen = None
        for rank, idx in enumerate(order):
            cand_id = str(ids_cluster[idx])
            b, ti = _resolve_indices(cand_id)
            if b is None or ti is None:
                continue
            if not csv_exists(b, ti):
                continue
            chosen = {
                "cluster_label": str(label),
                "trial_id": cand_id,
                "batch_id": b,
                "trial_index": ti,
                "size": cluster_size,
                "medoid_rank": int(rank),  # 0 = exact medoid
                "is_exact_medoid": rank == 0,
            }
            break

        if chosen is None:
            print(f"⚠️  WARNING: cluster {label}: no trial with a local CSV "
                  f"(checked {len(order)} candidates) — skipped")
            continue
        if chosen["medoid_rank"] > 0:
            print(f"  ↪ cluster {label}: exact medoid CSV missing, using "
                  f"nearest available (rank {chosen['medoid_rank']}, "
                  f"trial {chosen['trial_id']})")
        medoids.append(chosen)

    return medoids


def build_run_manifest(
    dataset: str,
    n_clusters: int,
    medoids: List[Dict[str, Any]],
    run_id: str,
) -> Dict[str, Any]:
    """Create the top-level manifest.json for this run."""
    return {
        "run_id": run_id,
        "timestamp": datetime.utcnow().isoformat() + "Z",
        "dataset": dataset,
        "n_clusters": n_clusters,
        "medoid_count": len(medoids),
        "clusters": [
            {
                "label": m["cluster_label"],
                "trial_id": m["trial_id"],
                "batch_id": m["batch_id"],
                "trial_index": m["trial_index"],
                "size": m["size"],
            }
            for m in medoids
        ],
    }


def _df_to_observations(df: "pd.DataFrame") -> List[Dict[str, Any]]:
    """Convert esmini CSV DataFrame to Payload-style observations.
    
    Each observation is a dict with ego fields + agents list.
    """
    observations = []
    
    # Get unique timestamps
    times = sorted(df["time"].unique())
    
    for t in times:
        frame = df[df["time"] == t]
        
        # Find ego row
        ego_row = frame[frame["name"] == "Ego"]
        if ego_row.empty:
            continue  # Skip frames without ego
        
        ego = ego_row.iloc[0]
        
        # Build observation dict
        obs = {
            "time": float(t),
            "egoX": float(ego["x"]),
            "egoY": float(ego["y"]),
            "egoYaw": float(ego["h"]),
            "egoSpeed": float(ego["speed"]),
            "egoRoadId": int(ego["roadId"]),
            "egoLaneId": int(ego["laneId"]),
            "egoS": float(ego["s"]),
            "egoLaneOffset": float(ego["offset"]),
            "agents": [],
        }
        
        # Add agent rows
        agent_rows = frame[frame["name"] != "Ego"]
        for _, ag in agent_rows.iterrows():
            obs["agents"].append({
                "name": str(ag["name"]),
                "x": float(ag["x"]),
                "y": float(ag["y"]),
                "yaw": float(ag["h"]),
                "speed": float(ag["speed"]),
                "roadId": int(ag["roadId"]),
                "laneId": int(ag["laneId"]),
                "s": float(ag["s"]),
                "laneOffset": float(ag["offset"]),
            })
        
        observations.append(obs)
    
    return observations


def build_bev_typography(args: argparse.Namespace):
    """Build ``BevTypography`` from dataset_builder CLI args."""
    from map_plotter import BevTypography

    return BevTypography(
        road_label_size=args.road_label_size,
        lane_label_size=args.lane_label_size,
        road_label_plain_size=args.road_label_plain_size,
        agent_id_fontsize=args.agent_id_size,
        info_fontsize=args.info_font_size,
        scope_fontsize=args.scope_font_size,
        title_fontsize=args.title_font_size,
    )


def process_medoid(
    medoid: Dict[str, Any],
    run_dir: Path,
    xodr_path: Path,
    parser: XodrParser,
    dataset_name: str = "dataset1",
    snapshot_output_px: int = 1024,
    snapshot_border_frac: float = 0.10,
    typography=None,
    key_frame_mode: str = "hybrid",
    max_snapshots: Optional[int] = None,
    semantic_only: bool = False,
    collision_flags: Optional[Dict[str, bool]] = None,
    cluster_collision_stats: Optional[Dict[str, Any]] = None,
    n_clusters: Optional[int] = None,
) -> bool:
    """Process a single medoid trial: generate all required files.
    
    Returns True on success, False on failure.
    """
    from map_plotter import DEFAULT_BEV_TYPOGRAPHY

    if typography is None:
        typography = DEFAULT_BEV_TYPOGRAPHY

    label = medoid["cluster_label"]
    batch_id = medoid["batch_id"]
    trial_index = medoid["trial_index"]
    
    print(f"\n🔹 Processing cluster {label} (batch {batch_id}, trial {trial_index})")
    
    cluster_dir = run_dir / f"cluster{label}"
    cluster_dir.mkdir(parents=True, exist_ok=True)

    # medoid.json — provenance for this cluster representative
    try:
        with (cluster_dir / "medoid.json").open("w") as f:
            json.dump({
                "cluster_label": label,
                "trial_id": medoid.get("trial_id"),
                "batch_id": batch_id,
                "trial_index": trial_index,
                "size": medoid.get("size"),
                "medoid_rank": medoid.get("medoid_rank", 0),
                "is_exact_medoid": medoid.get("is_exact_medoid", True),
            }, f, indent=2)
    except Exception as e:
        print(f"  ⚠️  Failed to write medoid.json: {e}")
    
    # 1. Check if CSV exists
    if not csv_exists(batch_id, trial_index):
        print(f"  ❌ CSV not found for batch {batch_id} trial {trial_index}")
        return False
    
    # 2. Load ground truth from CSV
    df = get_csv_road_data(batch_id, trial_index)
    if df is None or df.empty:
        print(f"  ❌ Failed to load CSV data")
        return False
    
    print(f"  ✓ Loaded {len(df)} frames from CSV")
    
    # 3. Convert DataFrame to Payload-style observations
    try:
        observations = _df_to_observations(df)
        print(f"  ✓ Converted {len(observations)} timesteps to observation format")
    except Exception as e:
        print(f"  ❌ Failed to convert DataFrame: {e}")
        del df
        return False
    
    # 4. Build trajectory.csv in xosc_gen format
    trajectory_path = cluster_dir / "trajectory.csv"
    try:
        registry = build_trajectory_csv(observations, parser, trajectory_path)
        print(f"  ✓ Generated trajectory.csv")
    except Exception as e:
        print(f"  ❌ Failed to build trajectory.csv: {e}")
        del df
        return False
    
    # 5. Build meta.yaml
    meta_path = cluster_dir / "meta.yaml"
    try:
        build_meta_yaml(
            registry,
            observations,
            meta_path,
            dataset="gpl-odd-simulated",
            location="hct_6",
        )
        print(f"  ✓ Generated meta.yaml")
    except Exception as e:
        print(f"  ❌ Failed to build meta.yaml: {e}")
        del df
        return False
    
    # 6. Action labelling (Step 2) + scenario description (Step 3)
    #    Rule-based, map-agnostic (taxonomy.py / labeller.py / description.py).
    try:
        from labeller import label_trajectory, save_action_yaml
        from description import build_description, save_description_txt

        map_yaml = REPO_ROOT / "alldatasets" / "map" / f"{Path(xodr_path).stem}.yaml"
        action_data = label_trajectory(
            trajectory_path, meta_path,
            map_yaml if map_yaml.is_file() else None,
        )
        save_action_yaml(action_data, cluster_dir / "action.yaml")
        save_description_txt(build_description(action_data),
                            cluster_dir / "description.txt")
        if not map_yaml.is_file():
            print("  ⚠️  action/description built WITHOUT junction info — run "
                  "scripts/map_preprocess.py first")
        print(f"  ✓ Generated action.yaml + description.txt")
    except Exception as e:
        print(f"  ⚠️  Action/description generation failed: {e}")

    from pipeline_imports import ensure_llm_pipeline

    ensure_llm_pipeline()
    from llm_pipeline.cluster_stats import trial_collision_flag

    trial_id = str(medoid.get("trial_id") or "")
    medoid_collided = trial_collision_flag(collision_flags or {}, trial_id)

    # 7. Generate BEV snapshots (Step 4 — MapPlotter + odrplot tracks)
    snapshots_dir = cluster_dir / "snapshots"
    snapshots_dir.mkdir(exist_ok=True)
    for stale in list(snapshots_dir.glob("*.jpg")) + list(snapshots_dir.glob("*.png")):
        stale.unlink(missing_ok=True)
    try:
        from tier2_renderer import (
            Tier2BevRenderer,
            infer_collision_timestep,
            resolve_tier2_paths,
        )

        _xodr, map_tracks, location = resolve_tier2_paths(dataset_name)
        if map_tracks.is_file():
            action_yaml = cluster_dir / "action.yaml"
            collision_ts = None
            if medoid_collided:
                collision_ts = infer_collision_timestep(df)
                if collision_ts is not None:
                    print(f"  ✓ Inferred collision timestep {collision_ts:.2f}s")

            tier2 = Tier2BevRenderer(
                str(map_tracks),
                str(xodr_path if xodr_path.is_file() else _xodr),
                location=location,
                dataset_name=dataset_name,
                snapshot_output_px=snapshot_output_px,
                snapshot_border_frac=snapshot_border_frac,
                typography=typography,
            )
            snaps = tier2.render_trial_from_esmini_csv(
                batch_id,
                trial_index,
                str(snapshots_dir),
                n_snapshots=max_snapshots,
                file_prefix=f"trial_{trial_index}",
                overview_dir=str(cluster_dir),
                action_yaml_path=str(action_yaml) if action_yaml.is_file() else None,
                key_frame_mode=key_frame_mode,
                semantic_only=semantic_only,
                collision_timestep=collision_ts,
                collision_trial=medoid_collided,
            )
            print(f"  ✓ Generated {len(snaps)} BEV snapshots + map_overview.jpg")
        else:
            print(f"  ⚠️  BEV skipped — run: python3 scripts/generate_map_tracks.py")
    except Exception as e:
        print(f"  ⚠️  BEV generation failed: {e}")
    
    # 8. Save raw observations (for reference/debugging)
    obs_path = cluster_dir / "observations.json"
    try:
        with obs_path.open("w") as f:
            json.dump(observations, f, indent=2)
        print(f"  ✓ Saved observations.json")
    except Exception as e:
        print(f"  ⚠️  Failed to save observations.json: {e}")
    
    # 8. Save cluster statistics
    stats_path = cluster_dir / "stats.json"
    try:
        duration = observations[-1]["time"] - observations[0]["time"] if observations else 0
        agent_names = [ag.name for ag in registry if ag.name != "Ego"]
        
        cc = cluster_collision_stats or {}
        stats = {
            "cluster_label": label,
            "cluster_size": medoid["size"],
            "n_trials": cc.get("n_trials", medoid["size"]),
            "collision_count": cc.get("collision_count"),
            "collision_rate": cc.get("collision_rate"),
            "medoid_trial_id": medoid.get("trial_id"),
            "medoid_collided": medoid_collided if collision_flags else None,
            "batch_id": batch_id,
            "trial_index": trial_index,
            "frame_count": len(observations),
            "duration_seconds": duration,
            "agent_count": len(agent_names),
            "agents": agent_names,
            "n_clusters": n_clusters,
        }
        with stats_path.open("w") as f:
            json.dump(stats, f, indent=2)
        print(f"  ✓ Saved stats.json")
    except Exception as e:
        print(f"  ⚠️  Failed to save stats.json: {e}")
    
    # Clean up dataframe
    del df
    
    print(f"  ✅ Cluster {label} processing complete")
    return True


def main():
    parser = argparse.ArgumentParser(
        description="Build LLM dataset from medoid trials"
    )
    parser.add_argument(
        "--dataset",
        required=True,
        help="Dataset name (e.g., dataset1)",
    )
    parser.add_argument(
        "--n-clusters",
        type=int,
        required=True,
        help="Number of clusters",
    )
    parser.add_argument(
        "--run-id",
        help="Optional run ID (default: auto-generated timestamp)",
    )
    parser.add_argument(
        "--xodr",
        default="simulation/ros/.cache/scenario_search/hct_6.xodr",
        help="Path to OpenDRIVE map (relative to project root)",
    )
    parser.add_argument(
        "--trials",
        help="Manual trial list: batch:index,batch:index,... (e.g., '1:100,1:200,1:300')",
    )
    parser.add_argument(
        "--snapshot-size",
        type=int,
        default=1024,
        help="Square BEV snapshot output size in pixels (default: 1024)",
    )
    parser.add_argument(
        "--snapshot-border-frac",
        type=float,
        default=0.10,
        help="White border as fraction of map content per side (default: 0.10 → 100 m → 120 m frame)",
    )
    parser.add_argument(
        "--road-label-size",
        type=float,
        default=10,
        help="Font size (pt) for red road ID boxes on map_overview.jpg (default: 5.6)",
    )
    parser.add_argument(
        "--lane-label-size",
        type=float,
        default=12,
        help="Font size (pt) for black lane ID boxes on map_overview.jpg (default: 5.6)",
    )
    parser.add_argument(
        "--road-label-plain-size",
        type=float,
        default=10,
        help="Font size (pt) for unhighlighted road IDs on full-network hct_6.jpg (default: 4.8)",
    )
    parser.add_argument(
        "--agent-id-size",
        type=float,
        default=10,
        help="Font size (pt) for on-car agent ID circles in snapshots (default: 4.0)",
    )
    parser.add_argument(
        "--info-font-size",
        type=float,
        default=15.0,
        help="Font size (pt) for top-left agent list and top-right time label (default: 8.0)",
    )
    parser.add_argument(
        "--scope-font-size",
        type=float,
        default=15.0,
        help="Font size (pt) for bottom-left scope text in snapshots (default: 7.0)",
    )
    parser.add_argument(
        "--title-font-size",
        type=float,
        default=15.0,
        help="Font size (pt) for map_overview title (default: 7.0)",
    )
    parser.add_argument(
        "--key-frame-mode",
        choices=("action", "hybrid", "heuristic"),
        default="hybrid",
        help="BEV key frames: action.yaml events, hybrid (+ heuristics), or heuristic only",
    )
    parser.add_argument(
        "--max-snapshots",
        type=int,
        default=None,
        metavar="N",
        help="Optional cap on BEV frames rendered (default: uncapped, all key times)",
    )
    parser.add_argument(
        "--semantic-only",
        action="store_true",
        help="Only use semantic maneuver events from action.yaml (skip speed segments)",
    )

    args = parser.parse_args()
    bev_typography = build_bev_typography(args)
    
    # Generate run ID if not provided
    run_id = args.run_id or datetime.utcnow().strftime("%Y%m%d_%H%M%S")
    
    print(f"🚀 Building LLM dataset for {args.dataset} (k={args.n_clusters})")
    print(f"   Run ID: {run_id}")
    
    result_data: Optional[Dict[str, Any]] = None

    # Check if manual trials specified
    if args.trials:
        print(f"\n📝 Using manually specified trials: {args.trials}")
        medoids = []
        for i, trial_spec in enumerate(args.trials.split(",")):
            batch_id, trial_index = map(int, trial_spec.strip().split(":"))
            if not csv_exists(batch_id, trial_index):
                print(f"  ⚠️  WARNING: CSV not found for batch {batch_id} trial {trial_index}")
                continue
            medoids.append({
                "cluster_label": str(i),
                "trial_id": f"{batch_id}_{trial_index}",
                "batch_id": batch_id,
                "trial_index": trial_index,
                "size": 1,  # Unknown size for manual trials
            })
        if not medoids:
            print("❌ ERROR: None of the specified trials have available CSVs")
            sys.exit(1)
    else:
        # 1. Load clustering data (embeddings + assignments)
        clustering_data = load_clustering_data(args.dataset, args.n_clusters)
        if not clustering_data:
            sys.exit(1)
        
        embeddings_data, result_data = clustering_data
        
        # 2. Compute medoids
        print("\n📊 Computing cluster medoids...")
        medoids = compute_medoids(embeddings_data, result_data, dataset=args.dataset)
        if not medoids:
            print("❌ ERROR: No medoids computed")
            print("\n💡 TIP: The clustering result contains Payload trial IDs that don't")
            print("   exist in your local database. You can specify trials manually:")
            print(f"   bash scripts/build_llm_dataset.sh {args.dataset} {args.n_clusters} --trials '1:100,1:200,1:300'")
            sys.exit(1)
    
    print(f"\n📊 Found {len(medoids)} medoid clusters")
    
    # 3. Create output directory structure: results/<dataset>/<n_clusters>/
    run_dir = RESULTS_DIR / args.dataset / str(args.n_clusters)
    run_dir.mkdir(parents=True, exist_ok=True)
    
    # Copy map assets used for this run (dataset-specific: hct_6 vs hct_6_no_930)
    from dataset_config import xodr_path_for_dataset

    map_dir = run_dir / "map"
    map_dir.mkdir(exist_ok=True)
    xodr_src = xodr_path_for_dataset(args.dataset)
    if args.xodr:
        alt = PROJECT_ROOT / args.xodr
        if alt.is_file():
            xodr_src = alt
    if not xodr_src.is_file():
        print(f"❌ ERROR: Map file not found: {xodr_src}")
        sys.exit(1)
    map_dest = map_dir / xodr_src.name
    shutil.copy(xodr_src, map_dest)
    # Also copy preprocessed map metadata (yaml / jpg / description) if present.
    preproc_dir = PROJECT_ROOT / "alldatasets" / "map"
    for suffix in (".yaml", ".jpg", "_description.txt"):
        asset = preproc_dir / f"{xodr_src.stem}{suffix}"
        if asset.is_file():
            shutil.copy(asset, map_dir / asset.name)
    print(f"✓ Copied map assets to {map_dir}")
    
    # 4. Initialize map parser (XodrParser for road-ID assignment)
    xodr_path = map_dest
    try:
        parser = XodrParser(str(xodr_path))
        print("✓ Initialized XODR map parser")
    except Exception as e:
        print(f"❌ ERROR: Failed to initialize map parser: {e}")
        sys.exit(1)
    
    # 5. Copy clustering result (the small selected-result file only; the full
    #    57MB embeddings.json is left in alldatasets/ to avoid duplicating it
    #    per run — reference it there if needed).
    clustering_dir = run_dir / "clustering"
    clustering_dir.mkdir(exist_ok=True)
    
    # Copy selected result
    result_src = (
        PROJECT_ROOT
        / "alldatasets"
        / args.dataset
        / f"selectedClusteringResult_{args.n_clusters}Clusters.json"
    )
    shutil.copy(result_src, clustering_dir / "selectedClusteringResult.json")
    print(f"✓ Copied clustering data")

    collision_flags: Optional[Dict[str, bool]] = None
    collision_path = PROJECT_ROOT / "alldatasets" / args.dataset / "collision.json"
    if collision_path.is_file():
        try:
            collision_flags = json.loads(collision_path.read_text(encoding="utf-8"))
            print(f"✓ Loaded collision flags from {collision_path.name}")
        except Exception as e:
            print(f"⚠️  Could not load collision.json: {e}")

    from pipeline_imports import ensure_llm_pipeline

    ensure_llm_pipeline()
    from llm_pipeline.cluster_stats import build_collision_cluster_stats

    if result_data is None:
        clustering_data = load_clustering_data(args.dataset, args.n_clusters)
        if clustering_data:
            _, result_data = clustering_data

    per_cluster_collision: Dict[str, Dict[str, Any]] = {}
    if collision_flags and result_data:
        for medoid in medoids:
            lb = medoid["cluster_label"]
            per_cluster_collision[lb] = build_collision_cluster_stats(
                int(lb), result_data, collision_flags
            )
            cs = per_cluster_collision[lb]
            print(
                f"  ℹ cluster {lb}: collision_rate={cs['collision_rate']}% "
                f"({cs['collision_count']}/{cs['n_trials']} trials)"
            )
    
    # 6. Process each medoid
    success_count = 0
    for medoid in medoids:
        if process_medoid(
            medoid,
            run_dir,
            xodr_path,
            parser,
            dataset_name=args.dataset,
            snapshot_output_px=args.snapshot_size,
            snapshot_border_frac=args.snapshot_border_frac,
            typography=bev_typography,
            key_frame_mode=args.key_frame_mode,
            max_snapshots=args.max_snapshots,
            semantic_only=args.semantic_only,
            collision_flags=collision_flags,
            cluster_collision_stats=per_cluster_collision.get(medoid["cluster_label"]),
            n_clusters=args.n_clusters,
        ):
            success_count += 1
    
    # 7. Create manifest
    manifest = build_run_manifest(args.dataset, args.n_clusters, medoids, run_id)
    manifest_path = run_dir / "manifest.json"
    with manifest_path.open("w") as f:
        json.dump(manifest, f, indent=2)
    
    print(f"\n{'='*60}")
    print(f"✅ LLM dataset build complete!")
    print(f"   Processed: {success_count}/{len(medoids)} clusters")
    print(f"   Output: {run_dir}")
    print(f"{'='*60}")
    
    if success_count < len(medoids):
        print("\n⚠️  Some clusters failed to process. Check logs above.")
        sys.exit(1)


if __name__ == "__main__":
    main()
