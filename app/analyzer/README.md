# Analyzer

## Purpose

Service for the Dashboard to analyze trajectories in a batch for
clustering and visualization.

## Setup

### Install Miniconda

- Follow the steps here: https://docs.anaconda.com/miniconda/

### Create Environment

All dependencies are listed in `environment.yml`. Create the Conda
environment with:

```bash
conda env create -f environment.yml
```

## Run the Server

### Activate Conda Environment

```bash
conda activate analyzer
```

### Start the Server

```bash
litestar run --port 9010 --debug --host 0.0.0.0 --reload
# Adjust the command arguments if needed
```

## Start Analyzing from Dashboard

From the dashboard, navigate to a batch and open the **Save** tab.\
Click **Create New**, then press the **Analyze** button.\
The analyzer will begin processing and may take several minutes.
