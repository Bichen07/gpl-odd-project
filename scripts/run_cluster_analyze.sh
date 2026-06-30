#!/usr/bin/env bash
# Phase 6 — run cluster interpretation on a builder results dir
#   (results/batch<id>/<k>_cluster_s=.../) with optional UI overrides.
#
# This is the backend invoked by the dashboard "Select and analyze" page
# (POST /api/cluster-analyze/run). All arguments are forwarded verbatim to the
# llm_pipeline CLI `cluster-interpret` subcommand, e.g.:
#
#   ./scripts/run_cluster_analyze.sh \
#       --results-dir results/batch2/4_cluster_s=0.6945 \
#       --model gemini-2.5-flash --temperature 0.1 \
#       --prompts-json /tmp/x/prompts.json --images-json /tmp/x/images.json \
#       --clusters 0,2 [--no-review] [--dry-run]
#
# The API key is supplied via the GOOGLE_API_KEY / OPENAI_API_KEY env vars by
# the caller (ephemeral; never written to disk by this script).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

CONDA_BASE=$(conda info --base 2>/dev/null || echo "$HOME/miniconda3")
# shellcheck disable=SC1091
source "$CONDA_BASE/etc/profile.d/conda.sh"
conda activate analyzer 2>/dev/null || {
    echo "❌ ERROR: Failed to activate 'analyzer' conda environment"
    exit 1
}

export PYTHONPATH="${PROJECT_ROOT}/app/llm_pipeline/python:${PROJECT_ROOT}/app/analyzer/src:${PYTHONPATH:-}"

exec python3 -m llm_pipeline.cli cluster-interpret "$@"
