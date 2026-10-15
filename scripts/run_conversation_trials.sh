#!/usr/bin/env bash
# Look up or render a sampled set of trial frames.
# Arguments are forwarded to `llm_pipeline.cli conversation-trials`.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

CONDA_BASE=$(conda info --base 2>/dev/null || echo "$HOME/miniconda3")
# shellcheck disable=SC1091
source "$CONDA_BASE/etc/profile.d/conda.sh"
conda activate analyzer 2>/dev/null || {
    echo "ERROR: Failed to activate analyzer conda environment"
    exit 1
}

export PYTHONPATH="${PROJECT_ROOT}/app/llm_pipeline/python:${PROJECT_ROOT}/app/analyzer/src:${PYTHONPATH:-}"

exec python3 -m llm_pipeline.cli conversation-trials "$@"
