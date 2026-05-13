#!/usr/bin/env bash
# Start Payload + Sampling + Analyzer + Mission Control + Dashboard in the background.
# One terminal on the lab PC — logs under logs/dev_stack/
#
# Prerequisites:
#   - Docker (Payload)
#   - conda envs: sampling, analyzer (litestar in each)
#   - bun (Dashboard)
#   - sdc-bionic container for "Run Simulation" (separate: sdc-docker-start-container)
#
# Usage:
#   ./scripts/start_dev_stack.sh
#   ./scripts/start_dev_stack.sh --skip-payload   # if Payload already running
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LOG_DIR="${REPO_ROOT}/logs/dev_stack"
SKIP_PAYLOAD=0

for arg in "$@"; do
  case "$arg" in
    --skip-payload) SKIP_PAYLOAD=1 ;;
    -h|--help)
      echo "Usage: $0 [--skip-payload]"
      exit 0
      ;;
  esac
done

mkdir -p "$LOG_DIR"

die() { echo "ERROR: $*" >&2; exit 1; }

command -v docker >/dev/null 2>&1 || die "docker not found"
command -v conda >/dev/null 2>&1 || die "conda not found — install Miniconda or add conda to PATH"
command -v bun >/dev/null 2>&1 || die "bun not found — install from https://bun.sh"

port_free() {
  local p="$1"
  if command -v ss >/dev/null 2>&1; then
    ! ss -tlnp 2>/dev/null | grep -q ":${p} "
  elif command -v lsof >/dev/null 2>&1; then
    ! lsof -i ":${p}" >/dev/null 2>&1
  else
    return 0
  fi
}

start_bg() {
  local name="$1" pidfile="$2" logfile="$3"
  shift 3
  if [[ -f "$pidfile" ]] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
    echo "[$name] already running (pid $(cat "$pidfile")) — skip"
    return 0
  fi
  echo "[$name] starting → $logfile"
  nohup "$@" >>"$logfile" 2>&1 &
  echo $! >"$pidfile"
  sleep 1
  if ! kill -0 "$(cat "$pidfile")" 2>/dev/null; then
    die "[$name] exited immediately — see $logfile"
  fi
}

echo "=== GPL-ODD dev stack (repo: $REPO_ROOT) ==="

if [[ "$SKIP_PAYLOAD" -eq 0 ]]; then
  echo "[Payload] docker compose up -d"
  (cd "$REPO_ROOT/app/payload" && docker compose up -d)
else
  echo "[Payload] skipped (--skip-payload)"
fi

port_free 9009 || die "port 9009 in use — stop Sampling or: kill \$(lsof -ti :9009)"
port_free 9010 || die "port 9010 in use — stop Analyzer or: kill \$(lsof -ti :9010)"
port_free 8282 || die "port 8282 in use — stop Mission Control or: kill \$(lsof -ti :8282)"
port_free 3000 || die "port 3000 in use — stop Dashboard or: kill \$(lsof -ti :3000)"

start_bg "sampling" "$LOG_DIR/sampling.pid" "$LOG_DIR/sampling.log" \
  bash -lc "cd '$REPO_ROOT/app/sampling/src' && exec conda run -n sampling --no-capture-output litestar run --port 9009 --host 0.0.0.0"

start_bg "analyzer" "$LOG_DIR/analyzer.pid" "$LOG_DIR/analyzer.log" \
  bash -lc "cd '$REPO_ROOT/app/analyzer/src' && exec conda run -n analyzer --no-capture-output litestar run --port 9010 --host 0.0.0.0"

start_bg "mission_control" "$LOG_DIR/mission_control.pid" "$LOG_DIR/mission_control.log" \
  bash -lc "cd '$REPO_ROOT/app/simulation/src' && exec conda run -n sampling --no-capture-output litestar run --port 8282 --host 0.0.0.0"

start_bg "dashboard" "$LOG_DIR/dashboard.pid" "$LOG_DIR/dashboard.log" \
  bash -lc "cd '$REPO_ROOT/app/dashboard' && exec bun run dev"

echo ""
echo "Started. Tail logs:"
echo "  tail -f $LOG_DIR/sampling.log"
echo "  tail -f $LOG_DIR/dashboard.log"
echo ""
echo "URLs (on this machine):"
echo "  Dashboard       http://localhost:3000"
echo "  Payload API     http://localhost:3020/api"
echo "  Mission Control http://localhost:8282/simulation/health"
echo ""
echo "Stop:  ./scripts/stop_dev_stack.sh"
echo "ROS/esmini (lab): ensure sdc-bionic is running, then use Mission Control ▶ Run Simulation"
