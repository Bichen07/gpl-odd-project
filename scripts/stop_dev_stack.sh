#!/usr/bin/env bash
# Stop processes started by start_dev_stack.sh (by PID files in logs/dev_stack/).
#
# Also frees stack listen ports if something is still bound (e.g. Litestar child
# survived after the saved PID exited). Ports: 9009 Sampling, 9010 Analyzer,
# 8282 Mission Control, 3000 Dashboard.
#
# Payload (Docker) is NOT stopped here — use: cd app/payload && docker compose down
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LOG_DIR="${REPO_ROOT}/logs/dev_stack"

# Kill whatever is listening on *port* (best-effort; dev machine only).
free_port() {
  local port="$1"
  local label="$2"
  local pids=""

  if command -v lsof >/dev/null 2>&1; then
    pids="$(lsof -t -i ":${port}" -sTCP:LISTEN 2>/dev/null || true)"
  elif command -v ss >/dev/null 2>&1; then
    # ss -tlnp → parse pid=1234 when lsof is missing
    pids="$(ss -tlnp 2>/dev/null | grep -E ":${port} " | sed -n 's/.*pid=\([0-9]*\).*/\1/p' | sort -u | tr '\n' ' ')"
  fi

  if [[ -n "${pids// /}" ]]; then
    echo "Freeing port ${port} (${label}): ${pids}"
    # shellcheck disable=SC2086
    kill -TERM ${pids} 2>/dev/null || true
    sleep 0.5
    # shellcheck disable=SC2086
    kill -KILL ${pids} 2>/dev/null || true
  fi

  if command -v fuser >/dev/null 2>&1; then
    fuser -k "${port}/tcp" 2>/dev/null || true
  fi
}

for name in dashboard mission_control analyzer sampling; do
  f="$LOG_DIR/${name}.pid"
  if [[ -f "$f" ]]; then
    pid="$(tr -d '[:space:]' < "$f")"
    if kill -0 "$pid" 2>/dev/null; then
      echo "Stopping $name (pid $pid)"
      # If this PID is a session leader (see start_dev_stack setsid), -PID kills the whole group.
      kill -TERM -- "-${pid}" 2>/dev/null || kill -TERM "$pid" 2>/dev/null || true
    else
      echo "$name: pid $pid not running"
    fi
    rm -f "$f"
  else
    echo "$name: no pid file"
  fi
done

sleep 0.5

free_port 3000 "dashboard"
free_port 8282 "mission_control"
free_port 9010 "analyzer"
free_port 9009 "sampling"

echo "Done. Payload (Docker) was not stopped — use: cd app/payload && docker compose down"
