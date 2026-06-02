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
RUN_ID="${3:-}"
shift 3 2>/dev/null || true  # Shift past required args

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

# Build Python command with all args
CMD=("python3" "app/analyzer/src/llm_dataset_builder.py" "--dataset" "$DATASET" "--n-clusters" "$N_CLUSTERS")

if [[ -n "$RUN_ID" ]]; then
    CMD+=("--run-id" "$RUN_ID")
fi

# Pass through any remaining args (like --trials)
CMD+=("$@")

"${CMD[@]}"

echo ""
echo "🎉 Done! You can now use the output with xosc_gen:"
echo "   1. For each cluster, feed trajectory.csv + meta.yaml to xosc_gen's Labeller"
echo "   2. Use BEV images for visual context in LLM prompts"
