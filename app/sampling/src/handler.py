import os
import random
import threading
import time
from collections import OrderedDict
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from pprint import pprint
from typing import Any, Optional

from botorch.models import SingleTaskGP
import numpy as np
import pandas as pd
import requests
import torch
from acquisition_function.straddle import Straddle
from ax import Runner as AxRunner
from ax.core.experiment import Metric, Trial
from ax.core.search_space import Arm
from ax.modelbridge.generation_node import Logger, get_logger, not_none
from ax.modelbridge.modelbridge_utils import (
    SupervisedDataset,
    checked_cast,
    extract_search_space_digest,
)
from ax.modelbridge.registry import Models
from ax.models.torch.botorch_modular.surrogate import Surrogate
from ax.service.ax_client import (
    AxClient,
    GeneratorRun,
    ObjectiveProperties,
    TEvaluationOutcome,
    TParameterization,
    exp_to_df,
)
from botorch.models.transforms.input import Normalize
from botorch.models.transforms.outcome import Standardize
from common import ConfigData, RegisterData, SuggestData, compare
from dotenv import load_dotenv
from optimizer import Optimizer

# Load the .env file from the parent directory
dotenv_path = "../.env"

# Load the .env file
load_dotenv(dotenv_path)

ax_logger: Logger = get_logger(__name__)


# Custom encoder function to handle datetime objects
def datetime_encoder(obj):
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError("Type not serializable")


class Runner(AxRunner):
    def run(self, trial):
        trial_metadata = {"name": str(trial.index)}
        return trial_metadata


class SurrogateHandler:
    def __init__(self, data: ConfigData):
        self.PAYLOAD_API = os.getenv("PAYLOAD_API")

        response = requests.get(
            url=self.PAYLOAD_API + f"/batches/{data.batch_id}?depth=1",
            verify=False,
        )
        response.raise_for_status()
        self.search_data = response.json()

        response = requests.get(
            url=self.PAYLOAD_API
            + f"/scenarios/{self.search_data["scenario"]["id"]}?depth=1",
            verify=False,
        )
        response.raise_for_status()
        self.scenario_data = response.json()

        self.parameter_id_mapping = {
            value["id"]: value for value in self.scenario_data["parameters"]
        }

        self.scenario_search_config = {
            "safety_requirement": {
                "metrics": {
                    value["keyPerformanceIndicator"]["name"]: {
                        "threshold": value["threshold"],
                        "unit": value["keyPerformanceIndicator"]["unit"],
                        "rule": value["keyPerformanceIndicator"]["rule"],
                    }
                    for value in self.scenario_data["testObjectives"][
                        "criticalityMetrics"
                    ]
                }
            },
            "sampling_plan": {
                "search_space": {
                    "parameters": {
                        item["name"]: {
                            "type": "range",
                            "value_type": "float",
                            "bounds": [item["min"], item["max"]],
                        }
                        for item in self.scenario_data["parameters"]
                    },
                    "parameter_constraints": self.scenario_data["parameterConstraints"],
                },
                "generation_steps": self.search_data["sampling"]["steps"],
            },
        }

        pprint(self.scenario_search_config)

        self.data_lock = threading.Lock()
        self.start_time = datetime.now()
        self.device = "cuda:0" if torch.cuda.is_available() else "cpu"

        self.parameter_settings = []
        for name, info in self.scenario_search_config["sampling_plan"]["search_space"][
            "parameters"
        ].items():
            parameter_setting = info
            parameter_setting["name"] = name
            self.parameter_settings.append(parameter_setting)

        self.parameter_constraints: list[str] = []
        if (
            "parameter_constraints"
            in self.scenario_search_config["sampling_plan"]["search_space"]
        ):
            self.parameter_constraints = self.scenario_search_config["sampling_plan"][
                "search_space"
            ]["parameter_constraints"]

        self.parameter_names = [str(p["name"]) for p in self.parameter_settings]
        self.parameter_names = sorted(self.parameter_names)

        self.outcome_names = sorted(
            list(self.scenario_search_config["safety_requirement"]["metrics"].keys())
        )

        runned_trials = {}
        self.parameter_index_mapping = {
            parameter["id"]: index
            for index, parameter in enumerate(self.scenario_data["parameters"])
        }
        self.metric_mapping = {
            item["keyPerformanceIndicator"]["id"]: item
            for item in self.scenario_data["testObjectives"]["criticalityMetrics"]
        }
        self.metric_index_mapping = {
            item["keyPerformanceIndicator"]["id"]: index
            for index, item in enumerate(
                self.scenario_data["testObjectives"]["criticalityMetrics"]
            )
        }

        if "trials" in self.search_data:
            for trial in self.search_data["trials"]:
                for parameter_id in self.parameter_index_mapping:
                    index = self.parameter_index_mapping[parameter_id]
                    parameter = self.parameter_id_mapping[parameter_id]
                    parameter_name = parameter["name"]
                    runned_trials.setdefault(parameter_name, [])
                    runned_trials[parameter_name].append(
                        trial["parameters"][index]["value"]
                    )

                for id, item in self.metric_mapping.items():
                    name = item["keyPerformanceIndicator"]["name"]
                    index = self.metric_index_mapping[id]
                    runned_trials.setdefault(name, [])
                    runned_trials[name].append(
                        trial["testObjectives"]["criticalityMetrics"][index]["value"]
                    )

        self.runned_trials = pd.DataFrame(runned_trials)
        print(self.runned_trials.tail())

        self.surrogate_for_straddle = Surrogate(
            # botorch_model_class=SingleTaskGP,
            # model_options={"nu": 5 / 2},
            input_transform_classes=[Normalize],
            input_transform_options={"Normalize": {"d": len(self.parameter_names)}},
            outcome_transform_classes=[Standardize],
            outcome_transform_options={"Standardize": {"m": 1}},
        )

        ax_client = AxClient()
        ax_client.create_experiment(
            name="scenario search experiment",
            parameters=self.parameter_settings,
            objectives={
                name: ObjectiveProperties(minimize=False) for name in self.outcome_names
            },
            parameter_constraints=self.parameter_constraints,
        )
        self.experiment = ax_client.experiment
        self.experiment.reset_runners(Runner())
        self.search_space_digest = extract_search_space_digest(
            self.experiment.search_space, self.parameter_names
        )

        print("experiment.search_space")
        pprint(self.experiment.search_space)
        print("parameter_names")
        pprint(self.parameter_names)
        print("search_space_digest")
        pprint(self.search_space_digest)
        print("parameter_constraints")
        pprint(self.experiment.search_space.parameter_constraints)

        self.sobol = Models.SOBOL(search_space=self.experiment.search_space)
        # self.sobol = Models.UNIFORM(search_space=self.experiment.search_space)
        self.uniform = Models.UNIFORM(search_space=self.experiment.search_space)
        self.generation_steps = self.scenario_search_config["sampling_plan"][
            "generation_steps"
        ]
        self.current_generation_step_index = 0
        self.current_generation_step_sampling_count = 0

        self.optimizer: Optional[Optimizer] = None
        self.arm_queue = []

        self.passed_failed_record = {}

        self.states: Optional[pd.DataFrame] = None

    def get_trial(self, trial_index: int) -> Trial:
        """Return a trial on experiment cast as Trial"""
        return checked_cast(Trial, self.experiment.trials[trial_index])

    def get_completed_trials_df(self) -> pd.DataFrame | None:
        trials = exp_to_df(self.experiment)
        completed_trials = None
        if trials.shape[0] > 0:
            completed_trials = trials[trials["trial_status"] == "COMPLETED"]
            assert isinstance(completed_trials, pd.DataFrame)
        return completed_trials

    def register(self, data: RegisterData) -> str | None:
        print("REGISTER DATA")
        print(data)
        trial_id = None
        try:
            print("Wait data lock")
            self.data_lock.acquire()
            print("data lock acquire")

            if data.outcome is None:
                trial = self.get_trial(data.trial_index)
                trial.mark_failed()
                return None

            new_tracking_metrics = [
                k
                for k in data.outcome
                if k not in [metric.name for metric in self.experiment.metrics.values()]
            ]
            self.experiment.add_tracking_metrics(
                metrics=[
                    Metric(name=metric_name) for metric_name in new_tracking_metrics
                ]
            )

            outcome: TEvaluationOutcome = {
                k: v
                for k, v in data.outcome.items()
                if isinstance(v, int) or isinstance(v, float)
            }

            trial = self.get_trial(data.trial_index)
            update_info = trial.update_trial_data(raw_data=outcome)
            trial.mark_completed()
            ax_logger.info(
                f"Completed trial {trial.index} with data: " f"{update_info}."
            )

            self.passed_failed_record.setdefault(trial.index, {})
            for outcome_name in self.outcome_names:
                metric_condition = compare(
                    outcome[outcome_name][0],
                    self.scenario_search_config["safety_requirement"]["metrics"][
                        outcome_name
                    ]["rule"],
                    self.scenario_search_config["safety_requirement"]["metrics"][
                        outcome_name
                    ]["threshold"],
                )
                self.passed_failed_record[trial.index][outcome_name] = metric_condition

            trials = exp_to_df(self.experiment)
            print(trials.tail())

            # if self.states is None:
            #     self.states = pd.read_csv(data.states_filepath)
            # else:
            #     new_trial_states = pd.read_csv(data.states_filepath)
            #     self.states = pd.concat(
            #         [self.states, new_trial_states], ignore_index=True
            #     )
            #     os.remove(data.states_filepath)

            print("get_completed_trials_df")
            completed_trials = self.get_completed_trials_df()
            print(completed_trials.tail())

            current_generation_step = self.generation_steps[
                self.current_generation_step_index
            ]
            if (
                completed_trials is not None
                and (
                    completed_trials[
                        completed_trials["trial_index"] == data.trial_index
                    ]["generation_method"]
                    == current_generation_step["method"]
                ).iloc[0]
            ):
                self.current_generation_step_sampling_count += 1

        except Exception as e:
            print("Error:", str(e))
        finally:
            self.data_lock.release()
            print("TRIALID: {}".format(trial_id))

        return trial_id

    def _get_next_trial(
        self, ttl_seconds: Optional[int] = None
    ) -> tuple[TParameterization | None, int]:
        completed_trials = self.get_completed_trials_df()
        current_generation_step = self.generation_steps[
            self.current_generation_step_index
        ]

        is_new_generation_step = False
        while (
            not current_generation_step["sampleSize"] < 0
            and completed_trials is not None
            and completed_trials.shape[0] + self.runned_trials.shape[0]
            > current_generation_step["sampleSize"]
        ):
            self.current_generation_step_index += 1
            current_generation_step = self.generation_steps[
                self.current_generation_step_index
            ]
            is_new_generation_step = True

        print(current_generation_step)

        if current_generation_step["method"] == "sobol":
            generator_run = self.sobol.gen(n=1)
        elif current_generation_step["method"] == "uniform":
            generator_run = self.uniform.gen(n=1)
        elif current_generation_step["method"] == "straddle":
            if completed_trials is None or completed_trials.shape[0] == 0:
                generator_run = self.uniform.gen(n=1)
            else:
                if len(self.arm_queue) == 0:
                    current = completed_trials[
                        self.parameter_names + self.outcome_names
                    ]
                    if self.runned_trials.shape[0] > 0:
                        runned = self.runned_trials[
                            self.parameter_names + self.outcome_names
                        ]
                        combined = pd.concat([current, runned])
                    else:
                        combined = current

                    if (
                        "maxSurrogateTrainingSampleSize" in current_generation_step
                        and combined.shape[0]
                        > current_generation_step["maxSurrogateTrainingSampleSize"]
                    ):
                        combined = combined.sample(
                            current_generation_step["maxSurrogateTrainingSampleSize"]
                        )

                    combined = combined.dropna()
                    print("training surrogate samples shape")
                    print(combined.shape)

                    # selected_outcome_name = random.choice(self.outcome_names)
                    selected_outcome_name = "waymo_collision"
                    # selected_outcome_name = "collision"
                    outcome_names = [selected_outcome_name]
                    X = combined[self.parameter_names].to_numpy()
                    Y = combined[outcome_names].to_numpy()
                    if selected_outcome_name == "waymo_collision":
                        # Y[Y == 0.5] = 0.0
                        Y[Y == 0.5] = 1.0

                    self.optimizer = Optimizer(
                        search_space=self.experiment.search_space,
                        acquisition_function=Straddle(
                            surrogate=self.surrogate_for_straddle,
                            exploration_factor=current_generation_step[
                                "acquisitionExplorationFactor"
                            ],
                            safety_metrics_config={
                                metric_name: metric
                                for metric_name, metric in self.scenario_search_config[
                                    "safety_requirement"
                                ]["metrics"].items()
                                if metric_name == selected_outcome_name
                            },
                        ),
                        domain_size=current_generation_step["acquisitionSampleSize"],
                    )

                    time_start = time.perf_counter()
                    self._fit_surrogate(
                        self._to_tensor(X),
                        self._to_tensor(Y),
                        self.surrogate_for_straddle,
                        selected_outcome_name,
                    )
                    time_end = time.perf_counter()
                    time_duration = time_end - time_start
                    print(
                        f"[handler] Surrogate for straddle took {time_duration:.3f} seconds to fit"
                    )

                    time_start = time.perf_counter()
                    next_batch = self.optimizer.get_next_batch_clustering(
                        torch.Tensor(X).to(self.device, dtype=torch.float64),
                        current_generation_step["parallelCounts"],
                    )
                    time_end = time.perf_counter()
                    time_duration = time_end - time_start
                    print(
                        f"[handler] Next batch took {time_duration:.3f} seconds to get"
                    )

                    self.arm_queue = [
                        Arm(
                            {
                                self.parameter_names[index]: value
                                for index, value in enumerate(parray)
                            }
                        )
                        for parray in next_batch.tolist()
                    ]
                generator_run = GeneratorRun(
                    arms=[self.arm_queue.pop(0)],
                    model_key=type(self.optimizer.acquisition_function).__name__,
                )
        else:
            generator_run = self.uniform.gen(n=1)

        trial = self.experiment.new_trial(
            generator_run=generator_run, ttl_seconds=ttl_seconds
        )
        trial.run()
        return not_none(trial.arm).parameters, trial.index

    def suggest(self) -> SuggestData:
        trial_index: int
        parameters: TParameterization | None
        parameters, trial_index = self._get_next_trial(ttl_seconds=180)
        pprint(parameters)
        return SuggestData(trial_index, parameters)

    def _fit_surrogate(
        self,
        X_train: torch.Tensor,
        Y_train: torch.Tensor,
        surrogate: Surrogate,
        selected_outcome_name: Optional[str] = None,
        state_dict: Optional[dict[str, Any]] = None,
    ) -> None:
        supervised_datasets: list[SupervisedDataset] = []
        outcome_names = (
            self.outcome_names
            if selected_outcome_name is None
            else [selected_outcome_name]
        )
        for index, outcome_name in enumerate(outcome_names):
            y_train = Y_train[:, index].reshape(-1, 1)
            dataset = SupervisedDataset(
                X=X_train,
                Y=y_train,
                feature_names=self.parameter_names,
                outcome_names=[outcome_name],
            )
            supervised_datasets.append(dataset)
        if state_dict is not None:
            surrogate.fit(
                supervised_datasets,
                outcome_names,
                self.search_space_digest,
                state_dict=state_dict,
                refit=True,
            )
        else:
            surrogate.fit(
                supervised_datasets,
                outcome_names,
                self.search_space_digest,
            )

    def _to_tensor(self, array: np.ndarray):
        return torch.Tensor(array).to(device=self.device, dtype=torch.float64)

    def _sort_dict(self, dict: dict[str, Any]) -> OrderedDict[str, Any]:
        keys = sorted(dict)
        updated = OrderedDict()
        for key in keys:
            updated[key] = dict[key]
        return updated
