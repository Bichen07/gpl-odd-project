#!/usr/bin/env bash
# Phase 6 — run cluster interpretation (stage2b) on an existing llm_artifacts run.
#
# Usage:
#   ./scripts/run_cluster_interpretation.sh <run_id> [dataset] [--dry-run]
#
# Example:
#   bash scripts/build_llm_dataset.sh dataset1 3 my_run_001
#   ./scripts/run_cluster_interpretation.sh my_run_001 dataset1
#   ./scripts/run_cluster_interpretation.sh my_run_001 dataset1 --dry-run

set -euo pipefail

RUN_ID="${1:-}"
DATASET="${2:-}"
DRY_RUN=""

# Check for --dry-run anywhere in args
for arg in "$@"; do
  if [[ "$arg" == "--dry-run" ]]; then
    DRY_RUN="--dry-run"
  fi
done

if [[ -z "$RUN_ID" ]]; then
  echo "Usage: $0 <run_id> [dataset] [--dry-run]"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# Activate conda environment
CONDA_BASE=$(conda info --base 2>/dev/null || echo "$HOME/miniconda3")
# shellcheck disable=SC1091
source "$CONDA_BASE/etc/profile.d/conda.sh"
conda activate analyzer 2>/dev/null || {
    echo "❌ ERROR: Failed to activate 'analyzer' conda environment"
    exit 1
}

export PYTHONPATH="${PROJECT_ROOT}/app/llm_pipeline/python:${PROJECT_ROOT}/app/analyzer/src:${PYTHONPATH:-}"

CMD=(python3 -m llm_pipeline.cli cluster-interpret --run-id "$RUN_ID")
if [[ -n "$DATASET" && "$DATASET" != --* ]]; then
  CMD+=(--dataset "$DATASET")
fi
if [[ -n "$DRY_RUN" ]]; then
  CMD+=("$DRY_RUN")
fi

echo "Running: ${CMD[*]}"
"${CMD[@]}"
