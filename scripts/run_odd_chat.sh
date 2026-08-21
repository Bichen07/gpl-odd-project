#!/usr/bin/env bash
# S5 (part 2) — one grounded Q&A turn over odd_chat_briefing.json.
#
# This is the backend invoked by the dashboard Run Report "ODD Q&A" panel
# (POST /api/odd-chat). All arguments are forwarded verbatim to the
# llm_pipeline CLI `odd-chat` subcommand, e.g.:
#
#   ./scripts/run_odd_chat.sh \
#       --run-dir results/batch8/6_cluster_s=0.6113 \
#       --question "What is the weakness of this AV system?" \
#       --model gemini-2.5-flash --history-json /tmp/x/history.json
#
# The API key is supplied via the GOOGLE_API_KEY / OPENAI_API_KEY env vars by
# the caller (ephemeral; never written to disk by this script) — same
# convention as scripts/run_cluster_analyze.sh.

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

exec python3 -m llm_pipeline.cli odd-chat "$@"
