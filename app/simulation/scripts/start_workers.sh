#!/bin/bash
# Start legacy simulation workers (survives SSH disconnect).
#
# Usage:
#   ./start_workers.sh --worker_count 4 --sdc_arg 2
#   ./start_workers.sh -w 4 -s 2
#   ./start_workers.sh 4 2                    # positional (legacy)
#
# Uses `docker exec -d` (no TTY) so workers keep running after SSH/Cursor closes.
# tmux is only for optional log viewing — workers do NOT depend on tmux staying alive.
#
# Prerequisites:
#   1. docker container sdc-bionic running
#   2. sampling on :9009 initialized for your batch:
#        curl -X POST http://localhost:9009/initialize \
#          -H "Content-Type: application/json" -d '{"batch_id":"2"}'

set -euo pipefail

WORKERS=""
SDC_ARG=""
FORCE=false
CONTAINER_NAME="${CONTAINER_NAME:-sdc-bionic}"
SCRIPT_DIR="${SCRIPT_DIR:-/home/user/.bash_script}"
LOG_DIR="${LOG_DIR:-/tmp/scenario_search_workers}"
LOG_IN_CONTAINER="${LOG_IN_CONTAINER:-/home/user/scenario_search_logs}"
SESSION_NAME="${SESSION_NAME:-scenario_search}"

usage() {
  cat <<'EOF'
Usage: ./start_workers.sh [OPTIONS] [worker_count] [sdc_arg]

Start parallel scenario_search + SDC worker pairs inside Docker (detached).

Options:
  -w, --worker_count COUNT   Number of parallel workers (default: 3)
  -s, --sdc_arg ARG          SDC roslaunch arg passed to container_script (default: 2)
  -c, --container NAME       Docker container name (default: sdc-bionic)
      --session_name NAME    tmux log-viewer session name (default: scenario_search)
  -f, --force                Start even if workers already running (not recommended)
  -h, --help                 Show this help

Examples:
  ./start_workers.sh --worker_count 4 --sdc_arg 2
  ./start_workers.sh -w 4 -s 2
  ./start_workers.sh 4 2
EOF
}

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -w|--worker_count)
      WORKERS="${2:?--worker_count requires a value}"
      shift 2
      ;;
    -s|--sdc_arg|--sdc)
      SDC_ARG="${2:?--sdc_arg requires a value}"
      shift 2
      ;;
    -c|--container)
      CONTAINER_NAME="${2:?--container requires a value}"
      shift 2
      ;;
    --session_name)
      SESSION_NAME="${2:?--session_name requires a value}"
      shift 2
      ;;
    -f|--force)
      FORCE=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      POSITIONAL+=("$@")
      break
      ;;
    -*)
      echo "ERROR: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

if [[ ${#POSITIONAL[@]} -ge 1 && -z "$WORKERS" ]]; then
  WORKERS="${POSITIONAL[0]}"
fi
if [[ ${#POSITIONAL[@]} -ge 2 && -z "$SDC_ARG" ]]; then
  SDC_ARG="${POSITIONAL[1]}"
fi

WORKERS="${WORKERS:-3}"
SDC_ARG="${SDC_ARG:-2}"

if ! [[ "$WORKERS" =~ ^[0-9]+$ ]] || [[ "$WORKERS" -lt 1 ]]; then
  echo "ERROR: --worker_count must be a positive integer (got: $WORKERS)" >&2
  exit 1
fi

if ! docker ps --format '{{.Names}}' | grep -qx "$CONTAINER_NAME"; then
  echo "ERROR: container $CONTAINER_NAME is not running. Start it first (sdc-docker-start-container)."
  exit 1
fi

existing=$(docker exec -i "$CONTAINER_NAME" bash <<'EOS'
pgrep -f '/usr/bin/python /opt/ros/melodic/bin/roslaunch -p 1' 2>/dev/null | wc -l
EOS
)
existing="${existing//[[:space:]]/}"
existing="${existing:-0}"
if [[ "$existing" != "0" && "$FORCE" != true ]]; then
  echo "ERROR: $existing worker process(es) already running in $CONTAINER_NAME."
  echo "  Stop first:  ./stop_workers.sh"
  echo "  Or force:    $0 --worker_count $WORKERS --force"
  exit 1
fi

mkdir -p "$LOG_DIR"
docker exec "$CONTAINER_NAME" mkdir -p "$LOG_IN_CONTAINER"

echo "Starting $WORKERS worker pair(s) via docker exec -d (batch from launch file)..."
echo "  worker_count=$WORKERS  sdc_arg=$SDC_ARG  container=$CONTAINER_NAME"
for i in $(seq 0 $((WORKERS - 1))); do
  echo "  worker $i: scenario_search"
  docker exec -d "$CONTAINER_NAME" /bin/bash -c \
    "${SCRIPT_DIR} ${i} --scenario_search_headless >> ${LOG_IN_CONTAINER}/scenario_search_${i}.log 2>&1"
  sleep 10
  echo "  worker $i: sdc"
  docker exec -d "$CONTAINER_NAME" /bin/bash -c \
    "${SCRIPT_DIR} ${i} --sdc ${SDC_ARG} >> ${LOG_IN_CONTAINER}/sdc_${i}.log 2>&1"
done

# Optional tmux session for tailing logs (safe to close — workers already detached in Docker)
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  tmux new-session -d -s "$SESSION_NAME" -n logs \
    "docker exec -it ${CONTAINER_NAME} tail -F ${LOG_IN_CONTAINER}/*.log"
fi

echo ""
echo "Workers started (detached inside Docker)."
echo "Monitor:"
echo "  docker exec ${CONTAINER_NAME} tail -F ${LOG_IN_CONTAINER}/*.log"
echo "  tmux attach -t $SESSION_NAME   # optional log viewer"
echo "  ls ../../../simulation/ros/.cache/scenario_search/records/esmini_2_*.csv | wc -l"
echo ""
echo "Stop:"
echo "  ./stop_workers.sh"

# Verify:
# docker exec sdc-bionic bash -c 'pgrep -af "/opt/ros/melodic/bin/roslaunch -p 1"'
