#!/usr/bin/env bash
# Stop processes started by start_dev_stack.sh (by PID files in logs/dev_stack/).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LOG_DIR="${REPO_ROOT}/logs/dev_stack"

for name in dashboard mission_control analyzer sampling; do
  f="$LOG_DIR/${name}.pid"
  if [[ -f "$f" ]]; then
    pid="$(cat "$f")"
    if kill -0 "$pid" 2>/dev/null; then
      echo "Stopping $name (pid $pid)"
      kill "$pid" 2>/dev/null || true
    else
      echo "$name: pid $pid not running"
    fi
    rm -f "$f"
  else
    echo "$name: no pid file"
  fi
done

echo "Done. Payload (Docker) was not stopped — use: cd app/payload && docker compose down"
