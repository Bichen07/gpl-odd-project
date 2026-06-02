#!/usr/bin/env python3
"""Build structured LLM dataset from medoid trials.

This script orchestrates Phase 4: for each cluster's medoid trial, it generates:
- trajectory.csv (xosc_gen format with roadId/laneId)
- meta.yaml (scenario metadata)
- BEV images (key timesteps)
- observations.json (raw Payload data)
- stats.json (cluster statistics)

Output structure: llm_artifacts/<run_id>/clusters/cluster_<label>/
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

# Add analyzer src to path for package imports (bev/, data/, llm/)
from repo_paths import ANALYZER_SRC, REPO_ROOT, CLUSTERS_DIR

if str(ANALYZER_SRC) not in sys.path:
    sys.path.insert(0, str(ANALYZER_SRC))

from renderer import XodrParser
from csv_roadid_loader import csv_exists, get_csv_road_data
from sim_labeller import assign_agent_road_id, build_meta_yaml, build_trajectory_csv

# Project root
PROJECT_ROOT = REPO_ROOT
LLM_ARTIFACTS_DIR = CLUSTERS_DIR  # results/clusters/

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
    
    for label in unique_labels:
        mask = labels_arr == label
        X_cluster = X[mask]
        ids_cluster = np.array(trial_ids)[mask]
        
        centroid = X_cluster.mean(axis=0, keepdims=True)
        idx = pairwise_distances_argmin(centroid, X_cluster, metric="euclidean")[0]
        medoid_trial_id = str(ids_cluster[idx])
        
        batch_id, trial_index = None, None
        if dataset:
            try:
                from dataset_config import trial_id_to_csv_indices
                batch_id, trial_index = trial_id_to_csv_indices(dataset, medoid_trial_id)
            except Exception:
                pass
        if batch_id is None:
            batch_id, trial_index = _get_trial_metadata(medoid_trial_id, csv_mapping)
        
        if batch_id is None or trial_index is None:
            print(f"⚠️  WARNING: Could not fetch metadata for trial {medoid_trial_id}")
            continue
        
        # Verify CSV exists
        if not csv_exists(batch_id, trial_index):
            print(f"⚠️  WARNING: CSV not found for batch {batch_id} trial {trial_index}")
            continue
        
        cluster_size = int(mask.sum())
        medoids.append({
            "cluster_label": str(label),
            "trial_id": medoid_trial_id,
            "batch_id": batch_id,
            "trial_index": trial_index,
            "size": cluster_size,
        })
    
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


def process_medoid(
    medoid: Dict[str, Any],
    run_dir: Path,
    xodr_path: Path,
    parser: XodrParser,
    dataset_name: str = "dataset1",
) -> bool:
    """Process a single medoid trial: generate all required files.
    
    Returns True on success, False on failure.
    """
    label = medoid["cluster_label"]
    batch_id = medoid["batch_id"]
    trial_index = medoid["trial_index"]
    
    print(f"\n🔹 Processing cluster {label} (batch {batch_id}, trial {trial_index})")
    
    cluster_dir = run_dir / "clusters" / f"cluster_{label}"
    cluster_dir.mkdir(parents=True, exist_ok=True)
    
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
    
    # 6. Generate BEV images (Phase 3b — MapPlotter + odrplot tracks)
    bev_dir = cluster_dir / "bev"
    bev_dir.mkdir(exist_ok=True)
    try:
        from tier2_renderer import Tier2BevRenderer, resolve_tier2_paths

        _xodr, map_tracks, location = resolve_tier2_paths(dataset_name)
        if map_tracks.is_file():
            tier2 = Tier2BevRenderer(
                str(map_tracks),
                str(xodr_path if xodr_path.is_file() else _xodr),
                location=location,
                dataset_name=dataset_name,
            )
            snaps = tier2.render_trial_from_esmini_csv(
                batch_id,
                trial_index,
                str(bev_dir),
                n_snapshots=12,
                file_prefix=f"trial_{trial_index}",
            )
            print(f"  ✓ Generated {len(snaps)} Tier2 BEV images")
        else:
            print(f"  ⚠️  BEV skipped — run: python3 scripts/generate_map_tracks.py")
    except Exception as e:
        print(f"  ⚠️  BEV generation failed: {e}")
    
    # 7. Save raw observations (for reference/debugging)
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
        
        stats = {
            "cluster_label": label,
            "cluster_size": medoid["size"],
            "medoid_trial_id": medoid.get("trial_id"),
            "batch_id": batch_id,
            "trial_index": trial_index,
            "frame_count": len(observations),
            "duration_seconds": duration,
            "agent_count": len(agent_names),
            "agents": agent_names,
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
    
    args = parser.parse_args()
    
    # Generate run ID if not provided
    run_id = args.run_id or datetime.utcnow().strftime("%Y%m%d_%H%M%S")
    
    print(f"🚀 Building LLM dataset for {args.dataset} (k={args.n_clusters})")
    print(f"   Run ID: {run_id}")
    
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
    
    # 3. Create output directory structure
    run_dir = LLM_ARTIFACTS_DIR / run_id
    run_dir.mkdir(parents=True, exist_ok=True)
    
    # Copy map file (dataset-specific: hct_6 vs hct_6_no_930)
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
    print(f"✓ Copied map to {map_dest}")
    
    # 4. Initialize map parser (XodrParser for road-ID assignment)
    xodr_path = map_dest
    try:
        parser = XodrParser(str(xodr_path))
        print("✓ Initialized XODR map parser")
    except Exception as e:
        print(f"❌ ERROR: Failed to initialize map parser: {e}")
        sys.exit(1)
    
    # 5. Copy clustering files
    clustering_dir = run_dir / "clustering"
    clustering_dir.mkdir(exist_ok=True)
    
    # Copy embeddings
    embeddings_src = PROJECT_ROOT / "alldatasets" / args.dataset / "clustering.json"
    shutil.copy(embeddings_src, clustering_dir / "embeddings.json")
    
    # Copy selected result
    result_src = (
        PROJECT_ROOT
        / "alldatasets"
        / args.dataset
        / f"selectedClusteringResult_{args.n_clusters}Clusters.json"
    )
    shutil.copy(result_src, clustering_dir / "selectedClusteringResult.json")
    print(f"✓ Copied clustering data")
    
    # 6. Process each medoid
    success_count = 0
    for medoid in medoids:
        if process_medoid(
            medoid, run_dir, xodr_path, parser, dataset_name=args.dataset
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
