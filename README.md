# GPL ODD Project

## Table of Contents

1. [Setup](#Setup)
2. [Execute Simulation for Logical Scenario Search](#Running)

## Setup <a name="Setup"></a>

### Prerequisites

- Git
- Docker
- Python and pip, version 3.8 or later
- Miniconda
- node.js, bun.js

### Cloning this repository

1. Cloning this repository under `${HOME}/source_code/`. If you would like to clone it under another location, please modify [deploy/container_settings.sh](../deploy/container_settings.sh) accordingly.

### 2022 ITRI + GPL Simulation Environment

Simulator to execute scenarios for ITRI AV system using Esmini.

[see documentation](simulation/README.md)

### Payload CMS

Data management server for scenario configuration and simulation testing result.

[see documentation](app/payload/README.md)

### Sampling

A server to sample test cases in logical scenarios.

[see documentation](app/sampling/README.md)

### Dashboard

View and explore simulation result.

[see documentation](app/dashboard/README.md)

### Analyzer

Clustering trajectories patterns for a logical scenario.

[see documentation](app/analyzer/README.md)

## Execute Simulation for Logical Scenario Search <a name="Running"></a>

### Spin up Payload CMS

[see documentation](app/payload/README.md)

### Scenario Search Configuration

#### Payload CMS

You can duplicate an existing configuration to simplify setup.

- Log in to the Admin UI of Payload CMS.
- Navigate to the Scenarios collection to create a new Scenario.
- Navigate to the Sessions collection to create a new Session.
- Navigate to the Batches collection to create a new Batch you want to do the sampling search.
  - In the selected batch:
    1. Choose the scenario you want to use.
    2. Choose the session you want your batch located in.
    3. Choose the sampling you want to use.

### Additional Configuration in Simulator

- Modify Launch File:

  - Open:

  ```
  simulation/ros/scenario_search/launch/single_parameterized_scenario_search.launch
  ```

- Update the following parameters:

  - batch_id: Set it to the desired batch ID for testing
  - sampling_suggestion_api: Replace it with your sampling server's IP

- Configure Map name and Route name for ITRI AV (if needed):

  - Maps are at "semantic-maps/data" (Our project only focus on map "hct_logistic")
  - Routes are at "semantic-maps/route"
  - If you need to change route, copy route you need from other file and replace content in "semantic-maps/route/hct_logistic/operation.json"

- Set Ego Vehicle Initial Position (if needed):
  - Modify ego_position_seq to change the ego vehicle's starting position.
  - Add new positions in:
  ```
  simulation/ros/src/simulation_utils/data/vehicle_parameters.json
  ```
  - ego_position_seq corresponds to the index of the map and route list in the file
  - Use odrplot from esmini to visualize the desired position on the OpenDrive map.

### Headless Or Not?

- Open deploy/parallel/container_script and locate the last line
- Change headless:=true to headless:=false or vice versa
- If set to false, the simulation windows will be displayed

### Spin up sampling server (On Simulation Host)

- Activate the Conda environment:

```bash
conda activate sampling

```

- Navigate to app/sampling/src

- Start the sampling server

```bash
litestar run --port 9009 --host 0.0.0.0 --debug --reload
```

#### Pass Batch ID you want to test to sampling server

- Access the Sampling Server:

  - Open your browser and go to:

  ```
  <your sampling server ip>:9009/schema
  ```

- Initialize Your Batch:

  - Locate the "initialize" API
  - Click "Test it Out"
  - Replace "string" with your Batch ID
  - Click "Execute" to initialize the sampling plan for your batch

- The sampling server is now prepared to suggest new sample points for the simulator.

### Execute Scenario Search

- Go to directory "app/simulation/scripts"

```bash
cd app/simulation/scripts
```

- Open tmux

```bash
tmux
```

- Start the simulation in tmux by running:

```bash
./run.sh <parallel number>
```

(Replace <parallel number> with the desired number of parallel executions.)

- To view the simulation windows, press Ctrl-B S to switch to the next session.

#### Closing the Simulation

- Stop the ./run.sh script by pressing Ctrl-C.

- Navigate between simulation windows using:

  - Open the session list with Ctrl-B S.
  - Ctrl-B N → Next window
  - Ctrl-B P → Previous window

- Kill the simulation session:

  - Select the simulation session and press Ctrl-C to stop the simulation.
  - Press Ctrl-B X to terminate the simulation window.
  - Open the session list with Ctrl-B S.

- Clean Logs and Cache Files (if taking too much space)

  - Remove simulation/deploy/home/.ros
  - Remove simulation/ros/.cache/scneario_search

### View and Explore Simulation Result

#### Spin up The Dashboard

- Go to directory "app/dashboard"
- Start the web interface by:

```bash
bun run start
```

- Open the displaying url to see the visualization of the simulation result.

#### Spin up The Analyzer for Clustering and Visualization Data

- Activate the Conda environment:

```bash
conda activate analyzer

```

- Navigate to app/analyzer/src
- Start the analyzer server

```bash
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

#### Create and Save Trajectory Analysis

From the dashboard, navigate to a batch and open the **Save** tab.
Click **Create New**, then press the **Analyze** button.
The analyzer will begin processing and may take several minutes.
The analysis results will be saved automatically.
You can manage these saves (add or delete) from the Payload Admin UI.

#### Explore the analyzing result

- Use the following views and tools:
  - Scenario Parameter Space
  - Trajectory Projection Space
  - Replayer
  - Trajectory Heatmap
  - Apply filtering and selection tools
