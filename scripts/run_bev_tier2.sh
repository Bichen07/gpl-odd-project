#!/usr/bin/env bash
# run_bev_tier2.sh — Generate xosc_gen-style BEV snapshots (MapPlotter + esmini CSV)
#
# Output goes to:
#   llm_artifacts/bev_<dataset>_<N>cl/<dataset>/cluster_num<N>/cluster_<k>/
#
# Usage:
#   ./scripts/run_bev_tier2.sh                         # dataset1, 3 clusters
#   ./scripts/run_bev_tier2.sh dataset1 4              # dataset1, 4 clusters
#   ./scripts/run_bev_tier2.sh dataset2 3              # dataset2, 3 clusters
#   ./scripts/run_bev_tier2.sh dataset1 3 --trial 5951 # single trial
#
# Prerequisite (once per map variant):
#   python3 scripts/generate_map_tracks.py --dataset dataset1

set -e

DATASET="${1:-dataset1}"
N_CLUSTERS="${2:-3}"
EXTRA_ARGS="${@:3}"

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLUSTER="${REPO_ROOT}/alldatasets/${DATASET}/selectedClusteringResult_${N_CLUSTERS}Clusters.json"
TRAJ="${REPO_ROOT}/alldatasets/${DATASET}/trajectories.json"
OUT="${REPO_ROOT}/llm_artifacts/bev_${DATASET}_${N_CLUSTERS}cl"

if [[ ! -f "$CLUSTER" ]]; then
  echo "ERROR: clustering file not found: $CLUSTER"
  exit 1
fi

# Ensure odrplot tracks exist for this dataset's map variant
python3 "${REPO_ROOT}/scripts/generate_map_tracks.py" --dataset "$DATASET" 2>/dev/null || true

echo "=== BEV Tier2 (MapPlotter + esmini CSV) ==="
echo "Dataset:  $DATASET"
echo "Clusters: $N_CLUSTERS"
echo "Output:   ${OUT}/${DATASET}/cluster_num${N_CLUSTERS}/cluster_*/"
echo ""

conda run -n analyzer python3 "${REPO_ROOT}/app/analyzer/src/bev_renderer.py" \
  --cluster "$CLUSTER" \
  --traj "$TRAJ" \
  --out "$OUT" \
  --dataset "$DATASET" \
  --n-clusters "$N_CLUSTERS" \
  --n-snapshots 12 \
  $EXTRA_ARGS

echo ""
echo "Done. Images under ${OUT}:"
find "$OUT" -name "*.jpg" 2>/dev/null | sort | sed "s|^${REPO_ROOT}/||" || echo "  (none — check medoid CSV availability for $DATASET)"
