#!/bin/bash
# Stop all scenario_search + sdc workers in Docker and optional tmux log session.
set -euo pipefail

CONTAINER_NAME="${CONTAINER_NAME:-sdc-bionic}"
SESSION_NAME="${SESSION_NAME:-scenario_search}"

echo "Stopping ROS workers in $CONTAINER_NAME..."

# Heredoc avoids pkill/pgrep matching this docker exec bash -c line (classic self-kill bug).
docker exec -i "$CONTAINER_NAME" bash <<'EOS' || true
MY=$$
kill_matching() {
  local sig=$1
  shift
  local pat
  for pat in "$@"; do
    while IFS= read -r pid; do
      [[ -z "$pid" || "$pid" == "$MY" ]] && continue
      if [[ -n "$sig" ]]; then
        kill -"$sig" "$pid" 2>/dev/null || true
      else
        kill "$pid" 2>/dev/null || true
      fi
    done < <(pgrep -f "$pat" 2>/dev/null || true)
  done
}

PATS=(
  '/project/mmsl_simulation.*single_parameterized_scenario_search.py'
  '/opt/ros/melodic/bin/roslaunch -p 1.*scenario_search'
  '/opt/ros/melodic/bin/roslaunch -p 1.*sdc run.launch'
)

kill_matching '' "${PATS[@]}"
sleep 2
kill_matching 9 "${PATS[@]}"
EOS

tmux kill-session -t "$SESSION_NAME" 2>/dev/null && echo "Killed tmux session $SESSION_NAME" || true

remaining=$(docker exec -i "$CONTAINER_NAME" bash <<'EOS'
pgrep -f '/usr/bin/python /opt/ros/melodic/bin/roslaunch -p 1' 2>/dev/null | wc -l
EOS
)
remaining="${remaining//[[:space:]]/}"
remaining="${remaining:-0}"
echo "Remaining worker processes: $remaining"
if [[ "$remaining" != "0" ]]; then
  echo "WARNING: some processes may still be running. Re-run ./stop_workers.sh or restart container."
  exit 1
fi
echo "All workers stopped."
