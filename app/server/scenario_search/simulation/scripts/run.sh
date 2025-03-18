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
