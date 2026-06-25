#!/bin/bash

export CONTAINER_NAME="sdc-bionic"
export SCRIPT_DIR="/home/user/.bash_script"

# timer_duration=900
timer_duration=720
# timer_duration=600
# timer_duration=360
# timer_duration=150
start_time=$(date +%s)

initial_time=$start_time
max_execution_time=180000

while true; do
    session_name="scenario_search"
    current_time=$(date +%s)
    remaining_time=$((start_time + timer_duration - current_time))
    session_exisited=$(tmux list-session | grep $session_name | wc -l)
    execution_time=$((current_time - initial_time))

    if [ $session_exisited -eq "0" ]; then
        tmux new-session -d -s $session_name
        for i in $(seq 0 $((${1}-1)));
        do
            tmux new-window -n scenario_search_${i} -t $session_name: -- bash -c "docker exec -it ${CONTAINER_NAME} /bin/bash -c '${SCRIPT_DIR} ${i} --scenario_search_headless'; exec bash"
            sleep 10s
            tmux new-window -n sdc_${i} -t $session_name: -- bash -c "docker exec -it ${CONTAINER_NAME} /bin/bash -c '${SCRIPT_DIR} ${i} --sdc ${2}'; exec bash"
        done
    fi

    if [ $remaining_time -le 0 ]; then
        start_time=$(date +%s)
        for i in $(seq 0 $((${1}-1)));
        do
            tmux send-keys -t $session_name:sdc_${i} C-c
            tmux send-keys -t $session_name:scenario_search_${i} C-c
        done
        sleep 60s
        tmux kill-session -t $session_name
    fi

    if [ $execution_time -ge $max_execution_time ]; then
        start_time=$(date +%s)
        for i in $(seq 0 $((${1}-1)));
        do
            tmux send-keys -t $session_name:sdc_${i} C-c
            tmux send-keys -t $session_name:scenario_search_${i} C-c
        done
        sleep 60s
        tmux kill-session -t $session_name
        break
    fi
done

tmux kill-server

# #!/bin/bash
# # Long-running monitor: restart workers if they die (survives SSH disconnect).
# # Usage: ./run.sh <worker_count>
# #
# # For a one-shot start, use: ./run_simulation.sh or ./start_workers.sh

# export CONTAINER_NAME="sdc-bionic"
# export SCRIPT_DIR="/home/user/.bash_script"
# export LOG_IN_CONTAINER="${LOG_IN_CONTAINER:-/home/user/scenario_search_logs}"

# timer_duration=720
# start_time=$(date +%s)
# initial_time=$start_time
# max_execution_time=180000

# worker_count="${1:-}"
# if [[ -z "${worker_count}" ]]; then
#   echo "Usage: $0 <worker_count>"
#   echo "  Monitors workers and restarts if they exit. Uses docker exec -d (SSH-safe)."
#   echo "  One-shot: ./run_simulation.sh --worker_count 3 --batch_id 2"
#   exit 1
# fi

# docker exec "$CONTAINER_NAME" mkdir -p "$LOG_IN_CONTAINER" 2>/dev/null || true

# workers_running() {
#   docker exec "$CONTAINER_NAME" bash -c \
#     'pgrep -f "/project/mmsl_simulation.*single_parameterized_scenario_search.py" >/dev/null 2>&1'
# }

# start_workers() {
#   echo "[run.sh] Starting ${worker_count} worker pair(s) in Docker..."
#   for i in $(seq 0 $((worker_count - 1))); do
#     docker exec -d "$CONTAINER_NAME" /bin/bash -c \
#       "${SCRIPT_DIR} ${i} --scenario_search_headless >> ${LOG_IN_CONTAINER}/scenario_search_${i}.log 2>&1"
#     sleep 10
#     docker exec -d "$CONTAINER_NAME" /bin/bash -c \
#       "${SCRIPT_DIR} ${i} --sdc 2 >> ${LOG_IN_CONTAINER}/sdc_${i}.log 2>&1"
#   done
# }

# echo "run.sh: monitoring ${worker_count} workers. Ctrl+C stops this script only."
# if workers_running; then
#   echo "[run.sh] Workers already running — monitoring only."
# else
#   start_workers
# fi

# while true; do
#   current_time=$(date +%s)
#   remaining_time=$((start_time + timer_duration - current_time))
#   execution_time=$((current_time - initial_time))

#   if ! workers_running; then
#     echo "[run.sh] Workers not running — restarting..."
#     start_workers
#     start_time=$(date +%s)
#   fi

#   if [[ $remaining_time -le 0 ]]; then
#     echo "[run.sh] Timer elapsed — restarting workers..."
#     "${BASH_SOURCE%/*}/stop_workers.sh" || true
#     sleep 5
#     start_workers
#     start_time=$(date +%s)
#   fi

#   if [[ $execution_time -ge $max_execution_time ]]; then
#     echo "[run.sh] Max monitor time reached — exiting (workers keep running)."
#     break
#   fi
#   sleep 30
# done
