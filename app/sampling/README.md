# Sampling

## Purpose

Sample points in a parameter space of a logical scenario for simulation processes.

## Setup

1. Log in to the Admin UI of Payload CMS.
2. Navigate to the Samplings collection and create the sampling steps you want to use. Availlable sampling steps:
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
3. Navigate to the Sessions collection and create a new Session.
4. Navigate to the Batches collection and open the batch (or logical scenario) you want to do the sampling search.
5. In the selected batch:
   1. Choose the sampling you want to use.
   2. Enter the URL where you will deploy the sampling server for simulation processes.
6. Prepare the sampling server.
   1. Open the terminal on the machine you want to deploy the sampling server.
   2. Navigate to the /app directory in the project root.
   3. Create a .env file from .env.example if not done yet.
   4. Modify the EXPOSE_SAMPLING_PORT in the .env file if needed. Ensure that the sampling URL matches the URL set in the batch.
7. Deploy the sampling server. (Should take several minutes)

```
docker compose up --force-recreate --build sampling
```

8. Initialize the Sampling Server by passing the Batch ID you want to do the sampling for.

```
curl --request POST <your_sampling_server_url>/initialize \
     --header "Content-Type: application/json" \
     --data '{"batch_id": "<your_batch_id>"}'
```

## APIs for Simulation Processes

1. Each simulation process should be assigned a batch (logical scenario) to execute.
2. Upon retrieving the batch, it can obtain the sampling server URL you deployed before in the batch data.
3. To obtain a sample from the parameter space for testing, use the "/suggest/{batch_id}" API endpoint:
   ```python
   response = requests.get(url=<sampling_server_url> + "/suggest/{batch_id}")
   print(response.json())
   ```
   ```JSON
   // example of print output:
   {
     "trial_index": 10,
     "parameters": {
         "d": 50,
         "v": 30,
         "y": 0.5
     }
   }
   ```
4. After completing the simulation, we can obtain the test result. We have to register the sample with its outcome back to the sampling server to inform it that the sample is completed. Use the '/register' API endpoint, ensuring that the 'trial_index' matches the one from the '/suggest' API.
   ```python
   requests.post(
       url=<sampling_server_url> + "/register",
       json={
           "batch_id": <batch_id>,
           "trial_index": <same_as_suggest>,
           "outcome": {
               "collide": 1,
               "speed_at_collision": 10,
               "ttc_min": 2.3
           }
       },
       verify=False,
   )
   ```

## Develop Locally

### Install miniconda

- Find steps [here](https://docs.anaconda.com/miniconda/).
- Make sure you `~/miniconda3/bin/conda init bash`. After this, source `~/.bashrc` then you'll able to use conda.

### Create Environment

All dependencies are listed in environment.yml. Simply create conda with the following command:

```bash
conda env create -f environment.yml
```

### Activate Conda Environment

```bash
conda activate sampling
```

### Start The Server

```bash
litestar run
# Or you can run Uvicorn directly:
uvicorn app:app --reload
```
