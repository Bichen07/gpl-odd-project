#!/bin/bash
# One-command legacy simulation for a Payload batch.
# Usage: ./run_simulation.sh [--worker_count N] [--batch_id ID]
#
# Example:
#   ./run_simulation.sh --worker_count 3 --batch_id 2

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKERS=3
BATCH_ID=2
SAMPLING_URL="${SAMPLING_URL:-http://localhost:9009}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -w|--worker_count) WORKERS="${2:?}"; shift 2 ;;
    -b|--batch_id) BATCH_ID="${2:?}"; shift 2 ;;
    -h|--help)
      echo "Usage: $0 [--worker_count N] [--batch_id ID]"
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

echo "=== Simulation batch ${BATCH_ID}, ${WORKERS} workers ==="

echo "[1/3] Stop old workers..."
"${SCRIPT_DIR}/stop_workers.sh" || true

echo "[2/3] Initialize Sampling for batch ${BATCH_ID}..."
curl -sfS -X POST "${SAMPLING_URL}/initialize" \
  -H "Content-Type: application/json" \
  -d "{\"batch_id\":\"${BATCH_ID}\"}" >/dev/null
NEXT=$(curl -sfS "${SAMPLING_URL}/suggest/${BATCH_ID}" | python3 -c "import sys,json; print(json.load(sys.stdin)['trial_index'])")
echo "  Next trial_index from Sampling: ${NEXT} → expect esmini_${BATCH_ID}_${NEXT}.csv"

echo "[3/3] Start workers..."
"${SCRIPT_DIR}/start_workers.sh" --worker_count "${WORKERS}"

echo ""
echo "Monitor:"
echo "  docker exec sdc-bionic tail -F /home/user/scenario_search_logs/scenario_search_0.log"
echo "  watch -n 30 'ls ${SCRIPT_DIR}/../../../simulation/ros/.cache/scenario_search/records/esmini_${BATCH_ID}_*.csv | wc -l'"
echo "Stop: ${SCRIPT_DIR}/stop_workers.sh"
