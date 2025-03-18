# Release of Integration with Payload CMS, Sampling, and Esmini

### Payload CMS

1.  Create app/.env from copying .env.example and modify it as needed.

2. Start Payload CMS server at app folder

```bash
docker compose up -d
```

3. Checkout Payload CMS admin UI. Default is at http://localhost:3000/admin.

4. Add a Client in admin UI.

   - Example:
     1. Enter name. e.g. itri
     2. Save

5. Create a Criticality Metric in admin UI. Implementation are in simulation/ros/src/scneario_search/src/scenario_search/scoring/safety_metrics/<metric implementation>. Names have to be the same as the key of the return dict at get_score function in the implementation.

   - Example:
     1. Enter name. e.g. collision
     2. Enter unit. e.g. boolean
     3. Select rule to pass compare to a threshold. e.g. Less Than
     4. Save

6. Create Scenario in admin UI.

   - Example:
     1. Enter name. e.g. Overtake Parking with Opposite Oncoming
     2. Select a client. e.g. itri
     3. NO EFFECT YET! Select a semantic map. e.g. hct_logistic
     4. NO EFFECT YET! Enter a route. e.g. operation
     5. NO EFFECT YET! Enter ego initial pose. e.g. x: 0, y:0, yaw: 0
     6. Upload OpenSCENARIO. e.g. upload the file from app/resources/xosc/opposite_overtake.xosc
     7. Upload OpenDRIVE. e.g. upload the file from app/resources/xodr/hct_4.xodr
     8. Add parameters. e.g.
        - Parameter 1
          - Name: x0
          - Unit: m
        - Parameter 2
          - Name: v0
          - Unit: kph
        - Parameter 3
          - Name: y0
          - Unit: m
    9. Add safety requirements. e.g.
      - Safety Requirement 1
        - Criticality Metric: select collision
        - Threshold: 0.5
    10. Add valid condition. e.g.
       - Valid Condition 1
         - Condition: StartValidCondition
    11. Add start observation sampling condition. e.g.
       - Start Observation Sampling Condition 1
         - Condition: StartValidCondition
    12. Add Observation Recording Agents. e.g.
       - Observation Recording Agent 1
         - Name: Ego
       - Observation Recording Agent 2
         - Name: Opposite
       - Observation Recording Agent 3
         - Name: Parking

7. Create Search in admin UI.
   - Example;
     1. Select a scenario. e.g. Overtake Parking with Opposite Oncoming
     2. Select a client. e.g. itri
     3. NO EFFECT YET! Enter software version. e.g. None
     4. NO EFFECT YET EXCEPT "Parallel" has effect on surrogate boundary sampling! Add machine allocations. e.g.
        - Machine Allocation 1
          - Role: Simulation
          - Connection URL: None
          - Parallel: 3
        - Machine Allocation 1
          - Role: Sampling
          - Connection URL: None
     5. Add parameter ranges. e.g. Go to Scenarios -> Overtake Parking with Opposite Oncoming -> API and check the IDs of the parameters.
        - Parameter Range 1
          - Parameter ID: <parameter ID of x0>
          - Range Min: 5
          - Range Max: 120
        - Parameter Range 2
          - Parameter ID: <parameter ID of v0>
          - Range Min: 10
          - Range Max: 100
        - Parameter Range 3
          - Parameter ID: <parameter ID of y0>
          - Range Min: -1.5
          - Range Max: 1
     6. Parameter Constraints. Implement from https://ax.dev/tutorials/gpei_hartmann_service.html#2.-Set-up-experiment:~:text=parameter_constraints%20should%20be%20a%20list%20of%20strings%20of%20form%20%22p1%20%3E%3D%20p2%22%20or%20%22p1%20%2B%20p2%20%3C%3D%20some_bound%22.
        e.g. empty
     7. Sampling Steps. Implementations are in app/server/scenario_serach/sampling/src/handler.py
        - Sampling Step 1
          - Method: Sobol
          - Sample Size: 100
        - Sampling Step 2
          - Method: Straddle (surrogate boundary sampling)
          - Sample Size: -1 (-1 means infinite implement from ax-platform)
          - Max Surrogate Training Size: 1000
          - Acquisition Sample Size: 1000
          - Acquisition Exploration Factor: 0.1

### Sampling

1. Same .env file at app root, modify as you need.

2. Start sampling server. In default, the sampling service exposed at host is http://localhost:9009.

```bash
docker compose --profile sampling up sampling
```

3. Initialize the sampling service using API /initialize by passing the ID of the search created in payload.

```bash
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"search_id": "<your Search ID from payload>"}' \
  http://localhost:9009/initialize
```

### Simulation

1.  Create deploy/.env from copying .env.example and modify it as needed.

2.  Please refer to README.md at project root to deploy and build the simulation environment.

3.  Install additional required python packages inside container
```
pip2 install pandas beautifulsoup4 lxml python-dotenv
```

4.  Modify simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch

    - change search_id to your ID.
    - change sampling_suggestion_api to your sampling API if needed.
    - change map_name and route_name if needed. For the scenario "Overtake Parking with Opposite Oncoming", the map_name is "hct_logistic", and the route_name is "operation".
    - change ego_position_seq you want ego start on map, which is speicify in simulation/ros/src/simulation_utils/data/vehicle_parameters.json. For the scenario "Overtake Parking with Opposite Oncoming", the ego_position_seq is 4.

5.  Change directory to app/server/scenario_search/simulation/scripts.

6.  Open tmux.

```bash
tmux
```

7. Run the script run.sh. The number 3 means to run 3 simulation in parallel. You can check the simulation processes by changing tmux sessions.

```bash
./run.sh 3
```

8. Go to sampling server terminal to see if sampling server is connected with simulation. And go to Trials and Observation collections in payload admin UI to see if simulation results are saved.
