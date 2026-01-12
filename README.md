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

- Log in to the Admin UI of Payload CMS.
- Navigate to the Key Perofrmance Indicators collection to create a new KPI.
- Navigate to the Sampling collection to create a new sampling plan.
  - **Uniform** (Random)
    - **Sample Size**: Specify the number of samples to generate using this method. Use -1 for an infinite number of samples.
  - **Sobol** (Semi-Random)
    - **Sample Size**: Specify the number of samples to generate using this method. Use -1 for an infinite number of samples.
  - **Straddle** (Adaptive sampling on the boundary)
    - **Sample Size**: Specify the number of samples to generate using this method. Use -1 for an infinite number of samples.
    - **Max Surrogate Training Sample Size**: Define the maximum number of samples used to train the surrogate model. If the samples (or trials) in a batch exceed this size, the training data will be downsampled to this size. This is crucial as training the surrogate model (Gaussian Process) becomes time-consuming with large sample sizes (serveral minutes on thousands of samples). Typically, a value around 1000 is sufficient based on experience.
    - **Acquisition Sample Size**: After training the surrogate model, we will do the random sampling in the parameter space, and let the surrogate model to predict the outcome of these samples. We will use these samples to find where are the next best spot to samples close to the boundary. This value is the sample size of this step. To understand more detail behind this, you can refer to the article [here](https://community.arm.com/arm-research/b/articles/posts/scalable-hyperparameter-tuning-for-automl).
    - **Parallel Counts**: Specify how many next samples are needed to suggest at a time for parallel simulation processes to consume. This parameter determines the number of samples recommended concurrently for parallel execution in simulation processes.
    - **Acquisition Exploration Factor**: This factor influences the exploration in the straddle acquisition function. A value of 0.1 is generally effective based on experience. Adjusting this value can impact the balance between exploration and exploitation during sampling.
- Navigate to the Scenarios collection to create a new Scenario.
  - Upload OpenSCENARIO and OpenDrive files
  - Specify parameters and define their search range
  - Speicfy KPIs and their critical thresholds
  - Specify the conditions used for simulation
  - Fill in all other necessary information
- Navigate to the Sessions collection to create a new Session. (please select a tag that no any scenario use and make sure there is no scenarios in filter for now)
- Navigate to the Batches collection to create a new Batch you want to do the sampling search.
  - In the selected batch:
    1. Choose the scenario you want to use.
    2. Choose the session you want your batch located in.
    3. Choose the sampling you want to use.

### Spin up sampling server

- Activate the Conda environment:

```bash
conda activate sampling

```

- Navigate to app/sampling/src

- Start the sampling server

```bash
litestar run --port 9009 --host 0.0.0.0 --debug --reload
```

(Modify the litestar parameters as needed.)

#### Pass Batch ID you want to test to sampling server

- Access the Sampling Server:

  - Open your browser and go to:

  ```
  <your sampling server ip>:<port>/schema
  ```

- Initialize Your Batch:

  - Locate the "initialize" API
  - Click "Test it Out"
  - Replace "string" with your Batch ID
  - Click "Execute" to initialize the sampling plan for your batch

- The sampling server is now prepared to suggest new sample points for the simulator.

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

- Close each simulation window by pressing Ctrl-X.

- Kill the simulation session:

  - Open the session list with Ctrl-B S.
  - Select the simulation session and press Ctrl-B X to terminate it.

- Clean Logs and Cache Files

  - Remove simulation/deploy/home/.ros
  - Remove simulation/ros/.cache/scneario_search

#### Patch Trials to Batch

- Open scripts/patch_trials_to_batch.py
- Modify the following variables as needed:
  - PAYLOAD_API: Set to your Payload CMS API endpoint.
  - batch_id: Specify the target batch ID.
- Run the script:
  ```bash
  python3 patch_trials_to_batch.py
  ```

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
litestar run --port 9009 --host 0.0.0.0 --debug --reload
# Or adjust the command arguments if needed
```

(Modify the litestar parameters as needed.)

#### Create and Save Trajectory Analysis

From the dashboard, navigate to a batch and open the **Save** tab.\
Click **Create New**, then press the **Analyze** button.\
The analyzer will begin processing and may take several minutes.\
The analysis results will be saved automatically.\
You can manage these saves (add or delete) from the Payload Admin UI.

#### Explore the analyzing result

- Use the following views and tools:
  - Scenario Parameter Space\
  - Trajectory Projection Space\
  - Replayer\
  - Trajectory Heatmap\
  - Apply filtering and selection tools
