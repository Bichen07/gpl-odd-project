# 2022 GPL + ITRI Simulation Environment

## Installation

### Prerequisites

- Git
- Python and pip, version 3.8 or later
- Docker

#### Install Python

```bash
# On Ubuntu 18.04
$ sudo apt update
$ sudo apt install python3.8 python-pip
$ python3.8 -m pip install --user pip==21.2.4
$ sudo reboot now
```

## Setup Instruction

### cloning this repository

1. Cloning this repository under `${HOME}/source_code/`. If you would like to clone it under another location, please modify [deploy/container_settings.sh](../deploy/container_settings.sh) accordingly.

### sdc-docker setup

1. Go to `sdc-docker` and install wheel file with pip

```bash
[nycu-odd-project] $ cd sdc-docker
[nycu-odd-project/sdc-docker] $ pip install sdc_docker-1.0.0+e85339c9-py2.py3-none-any.whl
```

2. Obtain the pre-built docker image (This may take a long time to execute)

```bash
$ sdc-docker-update-image
```

### container settings

```bash
# Add container-settings to source list under .bashrc for automatically source
$ echo "source ${HOME}/source_code/gpl-odd-project/deploy/container_settings" >> ${HOME}/.bashrc
```

### build simulation package

```bash
[container] $ source /repository/ros/install/setup.bash
[container] $ cd /project/mmsl_simulation
[container] $ time catkin_make
```

### install custom python package

```bash
[container] $ pip2 install pandas beautifulsoup4 lxml python-dotenv
```

## Usage

### container operations

```bash
# To Start a container
$ sdc-docker-start-container

# To enter a bash session inside the running container
$ sdc-docker-enter-container-shell

# To destroy the running container
$ sdc-docker-stop-container
```

### run sdc in simulation

```bash
[terminal 1| host] $ sdc-docker-start-container
[terminal 1| host] $ sdc-docker-enter-container-shell
[terminal 1| container] $ source /project/mmsl_simulation/devel/setup.bash
[terminal 1| container] $ roslaunch simulation_adv run.launch

[terminal 2| host] $ sdc-docker-enter-container-shell
[terminal 2| container] $ source /repository/ros/install/setup.bash
[terminal 2| container] $ roslaunch sdc run.launch
```

## Devlopement (TBI)

TBI
