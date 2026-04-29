#!/usr/bin/env bash
# run_bev.sh — Generate BEV snapshots for a dataset/cluster combination
#
# Usage:
#   bash scripts/run_bev.sh <dataset> <n_clusters>
#
# Examples:
#   bash scripts/run_bev.sh dataset1 3
#   bash scripts/run_bev.sh dataset2 4
#   bash scripts/run_bev.sh dataset3 5
#   bash scripts/run_bev.sh dataset1 3 --trial 5951   # single trial
#
# Output is saved under:
#   bev_output/<dataset>/<n_clusters>clusters/cluster_<N>/trial_<ID>_frame_<NNN>.jpg

set -e

DATASET="${1:-dataset1}"
N_CLUSTERS="${2:-3}"
EXTRA_ARGS="${@:3}"

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
XODR="${REPO_ROOT}/alldatasets/resources/xodr/hct_6.xodr"
TRAJ="${REPO_ROOT}/alldatasets/${DATASET}/trajectories.json"
CLUSTER="${REPO_ROOT}/alldatasets/${DATASET}/selectedClusteringResult_${N_CLUSTERS}Clusters.json"
OUT="${REPO_ROOT}/bev_output/${DATASET}/${N_CLUSTERS}clusters"

# Validate inputs
if [ ! -f "$XODR" ]; then
    echo "ERROR: xodr not found at $XODR"
    exit 1
fi
if [ ! -f "$TRAJ" ]; then
    echo "ERROR: trajectories.json not found at $TRAJ"
    exit 1
fi
if [ ! -f "$CLUSTER" ]; then
    echo "ERROR: clustering file not found at $CLUSTER"
    exit 1
fi

echo "=== BEV Renderer ==="
echo "Dataset  : $DATASET"
echo "Clusters : $N_CLUSTERS"
echo "Output   : $OUT"
echo ""

conda run -n analyzer python3 "${REPO_ROOT}/app/analyzer/src/bev_renderer.py" \
    --xodr    "$XODR" \
    --traj    "$TRAJ" \
    --cluster "$CLUSTER" \
    --out     "$OUT" \
    $EXTRA_ARGS

echo ""
echo "Done. Images saved to: $OUT"
echo "Structure:"
find "$OUT" -name "*.jpg" | sort | sed 's|'"$REPO_ROOT/"'||'
