#!/bin/bash

export CONTAINER_NAME="sdc-bionic"
export SCRIPT_DIR="/home/user/.bash_script"

for i in $(seq 0 $((${1}-1)));
do
				gnome-terminal -- bash -c "docker exec -it ${CONTAINER_NAME} /bin/bash -c '${SCRIPT_DIR} ${i} --scenario_search_headless'; exec bash"
				gnome-terminal -- bash -c "docker exec -it ${CONTAINER_NAME} /bin/bash -c '${SCRIPT_DIR} ${i} --sdc'; exec bash"
				sleep 2s
done
