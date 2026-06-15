#!/usr/bin/env bash
# Build LLM dataset from medoid trials
#
# Usage:
#   ./scripts/build_llm_dataset.sh <dataset> <n_clusters> [run_id] [--trials 'batch:index,...']
#
# Example:
#   ./scripts/build_llm_dataset.sh dataset1 8
#   ./scripts/build_llm_dataset.sh dataset1 3 "" --trials "1:100,1:200,1:300"

set -euo pipefail

DATASET="${1:-}"
N_CLUSTERS="${2:-}"
shift 2  # consume <dataset> <n_clusters>

# Optional run_id only when the next token is not a flag (e.g. --trials)
RUN_ID=""
if [[ $# -gt 0 && "${1:-}" != --* ]]; then
    RUN_ID="$1"
    shift
fi

if [[ -z "$DATASET" ]] || [[ -z "$N_CLUSTERS" ]]; then
    echo "Usage: $0 <dataset> <n_clusters> [run_id] [--trials 'batch:index,...']"
    echo ""
    echo "Example:"
    echo "  $0 dataset1 8"
    echo "  $0 dataset1 3 \"\" --trials \"1:100,1:200,1:300\""
    exit 1
fi

# Activate conda environment
CONDA_BASE=$(conda info --base 2>/dev/null || echo "$HOME/miniconda3")
# shellcheck disable=SC1091
source "$CONDA_BASE/etc/profile.d/conda.sh"
conda activate analyzer 2>/dev/null || {
    echo "❌ ERROR: Failed to activate 'analyzer' conda environment"
    echo "   Please run: conda env create -f app/analyzer/environment.yml"
    exit 1
}

# Run the Python script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

export PYTHONPATH="${PROJECT_ROOT}/app/llm_pipeline/python:${PROJECT_ROOT}/app/analyzer/src:${PYTHONPATH:-}"

# Build Python command with all args
CMD=("python3" "app/analyzer/src/dataset_builder.py" "--dataset" "$DATASET" "--n-clusters" "$N_CLUSTERS")

if [[ -n "$RUN_ID" ]]; then
    CMD+=("--run-id" "$RUN_ID")
fi

# Pass through any remaining args (like --trials)
CMD+=("$@")

"${CMD[@]}"

echo ""
echo "🎉 Done! Output: results/${DATASET}/${N_CLUSTERS}/cluster<i>/"
echo "   Each cluster dir has: trajectory.csv, meta.yaml, action.yaml,"
echo "   description.txt, snapshots/, stats.json, medoid.json, observations.json"
echo ""
echo "Next steps:"
echo "  • Map metadata (one-time):  python3 scripts/map_preprocess.py --dataset ${DATASET}"
echo "  • Step 5 (LLM interpret):   python3 -m llm_pipeline.cluster_interpretation_pipeline \\"
echo "                                  --dataset ${DATASET} --n-clusters ${N_CLUSTERS} [--dry-run]"
