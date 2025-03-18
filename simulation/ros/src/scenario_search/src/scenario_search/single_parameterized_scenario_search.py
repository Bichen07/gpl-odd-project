#!/usr/bin/env python
from __future__ import print_function

import threading
import time
import subprocess
import traceback
import json
import os
import shutil
from collections import deque
from copy import deepcopy
from datetime import datetime
from pathlib import Path
from pprint import pprint
from typing import Optional
import numpy as np
from bs4 import BeautifulSoup

from shapely.geometry import Polygon
import actionlib
import pandas as pd
import requests
import roslaunch
import rospy
import rostopic
import yaml
from scenario.msg import ScenarioReconfigureAction, ScenarioReconfigureGoal
from scenario_condition_checker import ScenarioConditionChecker
from scenario_sampler import ScenarioSampler
from simulation_utils.exception_handler import TryToCallAfterFailed
import math
from std_msgs.msg import Bool, Float32, Header, Int32, String
from itri_msgs.msg import CarState, steer_cmd
from std_srvs.srv import Empty

from scenario_search.scoring.scoring import Scoring

rospy.set_param(
    "accident_recorder/enable", {"bag": False, "info": False, "image": False}
)


def unique_list(sequence):
    seen = set()
    return [x for x in sequence if not (x in seen or seen.add(x))]


def main():
    SPSS = SingleParameterizedScenarioSearch()
    SPSS.run()


class SingleParameterizedScenarioSearch:
    def __init__(self, ros_master_uri=None):
        if ros_master_uri is not None:
            os.environ["ROS_MASTER_URI"] = ros_master_uri
            print("ROS_MASTER_URI: {}".format(os.environ["ROS_MASTER_URI"]))

        rospy.init_node("scenario_monitor", log_level=rospy.INFO)

        self.PAYLOAD_API = os.environ.get("PAYLOAD_API")
        self.SHARE_FOLDER_PATH = Path("/project/mmsl_simulation/.cache/scenario_search")
        if not self.SHARE_FOLDER_PATH.exists():
            os.makedirs(str(self.SHARE_FOLDER_PATH))

        self.USER_API_KEY = os.environ.get("USER_API_KEY")
        self.headers = {
            "Authorization": "users API-Key {}".format(self.USER_API_KEY),
        }

        self._EGO_STABLE_QUEUE_SIZE = 100
        self._MIN_STEER_CMD_STABLE_RATE = 15
        self._STEER_CMD_HZ_WINDOW_SIZE = 100
        self._ego_stable_queue = deque(maxlen=self._EGO_STABLE_QUEUE_SIZE)
        self._steer_cmd_hz = rostopic.ROSTopicHz(self._STEER_CMD_HZ_WINDOW_SIZE)
        self._scenario_stable_publisher = rospy.Publisher(
            "scenario_monitor/scenario_stable", Bool, queue_size=1
        )

        self.parameter_search_service_url = str(
            rospy.get_param(
                "/single_parameterized_scenario_search/sampling_suggestion_api"
            )
        )
        # self.batch_id = str(
        #     rospy.get_param("/single_parameterized_scenario_search/search_id")
        # )
        self.batch_id = str(
            rospy.get_param("/single_parameterized_scenario_search/batch_id")
        )
        self.map_name = str(
            rospy.get_param("/single_parameterized_scenario_search/map_name")
        )
        self.route_name = str(
            rospy.get_param("/single_parameterized_scenario_search/route_name")
        )
        self.enable_reference_preventable_judgement = rospy.get_param(
            "/single_parameterized_scenario_search/enable_reference_preventable_judgement"
        )
        self.sim_with_external_ego = rospy.get_param(
            "/single_parameterized_scenario_search/sim_with_external"
        )

        with open(
            "/repository/vehicle-configuration/pacifica-1/parameters.yaml", "r"
        ) as file:
            data = yaml.safe_load(file)
        data["route_mission_handler"]["route"] = self.map_name
        with open(
            "/repository/vehicle-configuration/pacifica-1/parameters.yaml", "w"
        ) as file:
            yaml.dump(data, file)

        self.search_attempt_folderpath = self.SHARE_FOLDER_PATH

        self.record_root_dir = self.search_attempt_folderpath / "records"
        if not self.record_root_dir.exists():
            self.record_root_dir.mkdir()

        response = requests.get(
            url=self.PAYLOAD_API + "/batches/{}?depth=1".format(self.batch_id),
            headers=self.headers,
            verify=False,
        )
        response.raise_for_status()
        self.search_data = response.json()

        response = requests.get(
            url=self.PAYLOAD_API
            + "/scenarios/{}?depth=1".format(self.search_data["scenario"]["id"]),
            headers=self.headers,
            verify=False,
        )
        response.raise_for_status()
        self.scenario_data = response.json()

        self.parameter_id_mapping = {
            value["id"]: value for value in self.scenario_data["parameters"]
        }

        url = self.scenario_data["openScenarioField"]["openScenario"]["url"]
        print(
            "/".join(self.PAYLOAD_API.split("/")[:3])
            + "/"
            + "/".join(url.split("/")[3:])
        )
        response = requests.get(
            "/".join(self.PAYLOAD_API.split("/")[:3])
            + "/"
            + "/".join(url.split("/")[3:]),
            verify=False,
        )
        response.raise_for_status()
        self.openscenario_filepath = self.SHARE_FOLDER_PATH / url.split("/")[-1]
        self.openscenario_xml = response.content

        url = self.scenario_data["openDrive"]["url"]
        response = requests.get(
            "/".join(self.PAYLOAD_API.split("/")[:3])
            + "/"
            + "/".join(url.split("/")[3:]),
            verify=False,
        )
        response.raise_for_status()
        self.opendrive_xml = response.content
        self.opendrive_filepath = self.SHARE_FOLDER_PATH / url.split("/")[-1]
        with open(str(self.opendrive_filepath), "wb") as f:
            f.write(self.opendrive_xml)

        # Change opendrive path to download opendrive filepath
        soup = BeautifulSoup(self.openscenario_xml, "xml")
        print(self.openscenario_xml)
        logic_file_element = soup.find("LogicFile")
        logic_file_element["filepath"] = str(self.opendrive_filepath)

        # Save Modified Openscenario
        with open(str(self.opendrive_filepath), "wb") as f:
            f.write(self.opendrive_xml)

        self.scenario_search_config = {
            "openscenario_template": str(self.openscenario_filepath),
            "end_condition_or": {"after_frenet_s": 3000},
            "scenario_valid_conditions": [
                v["condition"] for v in self.scenario_data["validConditions"]
            ],
            "start_sampling_conditions": [
                v["condition"]
                for v in self.scenario_data["startObservationSamplingConditions"]
            ],
            "state_recording_agents": [
                v["name"] for v in self.scenario_data["observationRecordingAgents"]
            ],
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
        self.outcome_names = sorted(
            list(self.scenario_search_config["safety_requirement"]["metrics"].keys())
        )

        self.default_config = self._generate_default_config()
        pprint(self.default_config)

        self.simulator_name = ""
        for n in list(self.default_config.keys()):
            if "simulator" not in n:
                continue
            self.simulator_name = n
        for n in list(self.default_config[self.simulator_name].keys()):
            if "model" not in n:
                continue
            self.simulator_model_name = n
        self.motion_configs = self.default_config[self.simulator_name][
            self.simulator_model_name
        ]["motion_configs"]

        with open(
            str(self.SHARE_FOLDER_PATH / "scenario_search_config.json"), "w"
        ) as f:
            json.dump(self.scenario_search_config, f, indent=2)

        default_config_filepath = (
            self.SHARE_FOLDER_PATH / "scenario_default_config.json"
        )
        with open(str(default_config_filepath), "w") as f:
            json.dump(self.default_config, f, indent=2)

        rospy.set_param("scenario/config/file", str(default_config_filepath))

        self.scoring = Scoring()
        # self.sampler = ScenarioSampler(0.075, self.PAYLOAD_API, self.scoring)
        self.sampler = ScenarioSampler(0.075, self.PAYLOAD_API, self.scoring)
        self.current_trial_index = -1

        self.scenario_checker = ScenarioConditionChecker(self.scenario_search_config)
        self.check_rate = rospy.get_param("scenario_monitor/check_rate", 10.0)
        self.reset_service = rospy.ServiceProxy("ego_handler/reset_ego", Empty)

        self.esmini_simulation_time = 0.0
        self.esmini_simulation_time_subscriber = rospy.Subscriber(
            "/esmini_simulation_time", Float32, self._esmini_simulation_time_callback
        )

        self._car_state_subscriber = rospy.Subscriber(
            "car_state", CarState, self._car_state_callback
        )
        self._steer_cmd_subscriber = rospy.Subscriber(
            "steer_cmd", steer_cmd, self._steer_cmd_hz.callback_hz
        )

        self.scenario_ends_publisher = rospy.Publisher(
            "scenario_monitor/scenario_ends", Header, queue_size=1
        )
        self.scenario_stable_publisher = rospy.Publisher(
            "scenario_monitor/scenario_stable", Bool, queue_size=1
        )
        self.record_root_dir_publisher = rospy.Publisher(
            "/record_root_dir", String, queue_size=1
        )
        self.is_reference_model_turn_publisher = rospy.Publisher(
            "/is_reference_model_turn", Bool, queue_size=1
        )
        self._esmini_record_filepath_publisher = rospy.Publisher(
            "/esmini_record_filepath", String, queue_size=1
        )
        self.current_esmini_record_filepath = None  # type: Optional[Path]
        self.current_xosc_filepath = None  # type: Optional[Path]

        self.states = None  # type: Optional[pd.DataFrame]

        self.scenario_reconfigure_client = actionlib.SimpleActionClient(
            "scenario_reconfigure_action", ScenarioReconfigureAction
        )
        self.scenario_reconfigure_client.wait_for_server()

        rospy.loginfo("Wait for service /route_mission_handler/load_route_by_file_name")
        rospy.wait_for_service("/route_mission_handler/load_route_by_file_name")
        rospy.loginfo("[SingleParameterizedScenarioSearch] Constructed.")

    def _esmini_simulation_time_callback(self, msg):
        self.esmini_simulation_time = msg.data

    @TryToCallAfterFailed(tag="SPSS", max_attempt=50, sleep=2)
    def call_reset_service(self):
        self.reset_service()

    def run(self):
        rate = rospy.Rate(self.check_rate)
        is_init = True
        scenario_stable = False
        self.record_root_dir_publisher.publish(String(self.record_root_dir))

        current_config_filepath = None
        is_reference_model_turn = False
        current_register_data = None

        try:
            while True:
                if self.scenario_checker.check_end_condition() or is_init:
                    rospy.loginfo(
                        "[SingleParameterizedScenarioSearch] "
                        "Send scenario reconfigure request for scenario #{}."
                        "".format(self.current_trial_index)
                    )

                    # Publish message that show one config set was end
                    msg = Header()
                    msg.stamp = rospy.Time.now()
                    self.scenario_ends_publisher.publish(msg)

                    # self.sampler.stop()
                    rospy.sleep(3)

                    scenario_stable = False
                    msg = Bool()
                    msg.data = scenario_stable
                    self.scenario_stable_publisher.publish(msg)
                    rospy.logwarn("publish scenario not stable")

                    # Record score for result report generating at the end.
                    # [TBI] The score system is yet to be implemented
                    if not is_init:
                        end_by_scenario_control = (
                            self.scenario_checker.end_scenario_message
                        )
                        is_esmini_record_exist = (
                            self.current_esmini_record_filepath is not None
                            and os.path.exists(str(self.current_esmini_record_filepath))
                        )

                        attempt_count = 0
                        while True:
                            attempt_count += 1
                            is_esmini_record_exist = (
                                self.current_esmini_record_filepath is not None
                                and os.path.exists(
                                    str(self.current_esmini_record_filepath)
                                )
                            )
                            if is_esmini_record_exist or attempt_count > 5:
                                break
                            print(
                                "cannot find esmini record from filepath wait..., attempt: {}".format(
                                    attempt_count
                                )
                            )
                            rospy.sleep(3.0)

                        score = None
                        if (
                            is_esmini_record_exist
                            and (
                                end_by_scenario_control is None
                                or end_by_scenario_control.data == True
                            )
                            and self.esmini_simulation_time > 3.0
                        ):

                            subprocess.call(
                                [
                                    "/project/mmsl_simulation/src/esmini/bin/dat2csv",
                                    str(self.current_esmini_record_filepath),
                                ],
                                cwd=str(
                                    self.current_esmini_record_filepath.parent
                                ),
                            )

                            newfilepath = (
                                self.current_esmini_record_filepath.with_suffix(
                                    ".csv"
                                )
                            )
                            df = pd.read_csv(newfilepath, skiprows=1)
                            df.rename(columns=str.strip, inplace=True)
                            df["name"] = df["name"].str.strip()
                            
                            print("SAMPLER CREATE OBSERVATIONS" * 20)
                            self.sampler.create_observations(df, [agent["name"] for agent in self.scenario_data["observationRecordingAgents"]])
                            self.sampler.preprocess_saved_data()

                            score = self.scoring.get_score()
                            for key, value in self.sampler.score.items():
                                score[key] = value
                            # if score["collision"]:
                            #     score["ttc_min"] = 0.0
                            pprint("SCORE" * 100)
                            pprint(score)
                            pprint("SCORE" * 100)

                            set_preventable = False
                            if (
                                not self.enable_reference_preventable_judgement
                                or not is_reference_model_turn
                            ):
                                current_register_data = {
                                    "batch_id": self.search_data["id"],
                                    "outcome": deepcopy(score),
                                    "trial_index": self.current_trial_index,
                                }
                                rospy.loginfo(
                                    "[single_parameterized_scenario_search] ego test completed, score: {}".format(
                                        score
                                    )
                                )
                                if not self.enable_reference_preventable_judgement:
                                    current_register_data["outcome"]["preventable"] = 1
                            elif (
                                is_reference_model_turn
                                and current_register_data is not None
                            ):
                                preventable = 1 if score["collision"] == 0 else 0
                                current_register_data["outcome"][
                                    "preventable"
                                ] = preventable
                                set_preventable = True
                                rospy.loginfo(
                                    "[single_parameterized_scenario_search] set preventable to score, preventable: {}".format(
                                        preventable
                                    )
                                )

                            is_reference_preventable_valid = (
                                not self.enable_reference_preventable_judgement
                                or (
                                    self.enable_reference_preventable_judgement
                                    and is_reference_model_turn
                                    and set_preventable
                                    and current_register_data is not None
                                )
                            )
                            for key, value in current_register_data["outcome"].items():
                                if (
                                    isinstance(value, int) or isinstance(value, float)
                                ) and math.isnan(value):
                                    rospy.loginfo(
                                        "[spss]: register outcome {} is nan. Set it to None".format(
                                            key
                                        )
                                    )
                                    current_register_data["outcome"][key] = None

                            if is_reference_preventable_valid:
                                try:
                                    files = {
                                        "file": (
                                            self.current_esmini_record_filepath.name,
                                            open(
                                                str(
                                                    self.current_esmini_record_filepath
                                                ),
                                                "rb",
                                            ),
                                            "application/octet-stream",
                                        )
                                    }
                                    # Make the POST request
                                    pprint(self.headers)
                                    response = requests.post(
                                        self.PAYLOAD_API + "/esminiDats",
                                        headers=self.headers,
                                        files=files,
                                        # files={},
                                        verify=False,
                                    )
                                    # Check the response
                                    if (
                                        response.status_code == 200
                                        or response.status_code == 201
                                    ):
                                        print("Esmini Dat file uploaded successfully!")
                                    else:
                                        print(
                                            "Error uploading file. Status code:",
                                            response.status_code,
                                        )
                                        response.raise_for_status()
                                    esminiDat = response.json()


                                    # df.to_csv(newfilepath, index=False)

                                    # files = {
                                    #     "file": (
                                    #         newfilepath.name,
                                    #         open(
                                    #             str(newfilepath),
                                    #             "rb",
                                    #         ),
                                    #         "text/csv",
                                    #     )
                                    # }
                                    # # Make the POST request
                                    # response = requests.post(
                                    #     self.PAYLOAD_API + "/esminiCsvs",
                                    #     headers=self.headers,
                                    #     files=files,
                                    #     verify=False,
                                    # )
                                    # esminiCsv = response.json()
                                    # pprint(esminiCsv)
                                    #
                                    # print("SCORE COLLISION")
                                    # print(score["collision"])
                                    # collisionTrajectory = None
                                    # if score["collision"] == 1:
                                    #     newfilepath = self.current_esmini_record_filepath.with_suffix(
                                    #         ".json"
                                    #     )
                                    #     tenSecondsIndexStep = int(
                                    #         10 / self.sampler.period
                                    #     )
                                    #     tenSecondsBeforeIndex = (
                                    #         len(self.sampler.data) - tenSecondsIndexStep
                                    #     )
                                    #     recordedData = self.sampler.data[
                                    #         tenSecondsBeforeIndex:
                                    #     ]
                                    #     with open(str(newfilepath), "w") as json_file:
                                    #         json.dump(recordedData, json_file, indent=4)
                                    #     print(newfilepath)
                                    #     files = {
                                    #         "file": (
                                    #             newfilepath.name,
                                    #             open(
                                    #                 str(newfilepath),
                                    #                 "rb",
                                    #             ),
                                    #             "application/json",
                                    #         )
                                    #     }
                                    #     # Make the POST request
                                    #     response = requests.post(
                                    #         self.PAYLOAD_API + "/documents",
                                    #         headers=self.headers,
                                    #         files=files,
                                    #         verify=False,
                                    #     )
                                    #     collisionTrajectory = response.json()
                                    #     pprint(collisionTrajectory)

                                    print(
                                        "remove esmini dat file: {}".format(
                                            self.current_esmini_record_filepath.as_posix()
                                        )
                                    )
                                    os.remove(
                                        self.current_esmini_record_filepath.as_posix()
                                    )

                                    print("file esmini dat response json")
                                    print(response.json())
                                    esmini_dat_id = esminiDat["doc"]["id"]
                                    current_register_data["esmini_dat_id"] = (
                                        esmini_dat_id
                                    )

                                    rospy.loginfo(
                                        "[ssps] current_register_data: {}".format(
                                            current_register_data
                                        )
                                    )

                                    response = requests.post(
                                        url=self.parameter_search_service_url
                                        + "/register",
                                        json=current_register_data,
                                    )
                                    response.raise_for_status()
                                    rospy.loginfo(
                                        "[single_parameterized_scenario_search] register complete time in seconds: {}".format(
                                            response.elapsed.total_seconds()
                                        )
                                    )

                                    def compare(lhs, rule, rhs):
                                        if rule == "greaterThan":
                                            return lhs > rhs
                                        elif rule == "lessThan":
                                            return lhs < rhs

                                    pprint(current_register_data)
                                    passed = {}
                                    for outcome_name in self.outcome_names:
                                        passed[outcome_name] = (
                                            1
                                            if compare(
                                                current_register_data["outcome"][
                                                    outcome_name
                                                ],
                                                self.scenario_search_config[
                                                    "safety_requirement"
                                                ]["metrics"][outcome_name]["rule"],
                                                self.scenario_search_config[
                                                    "safety_requirement"
                                                ]["metrics"][outcome_name]["threshold"],
                                            )
                                            else 0
                                        )
                                    pprint("PASSED: {}".format(passed))

                                    trial_db_data = {
                                        "batch": self.search_data["id"],
                                        # "samplingMethod": current_generation_step["method"],
                                        "parameters": [
                                            {
                                                "parameterId": parameter["id"],
                                                "value": self.current_parameters[
                                                    self.parameter_id_mapping[
                                                        parameter["id"]
                                                    ]["name"]
                                                ],
                                            }
                                            for parameter in self.scenario_data[
                                                "parameters"
                                            ]
                                        ],
                                        "testObjectives": {
                                            "criticalityMetrics": [
                                                {
                                                    "keyPerformanceIndicator": threshold[
                                                        "keyPerformanceIndicator"
                                                    ][
                                                        "id"
                                                    ],
                                                    "value": current_register_data[
                                                        "outcome"
                                                    ][
                                                        threshold[
                                                            "keyPerformanceIndicator"
                                                        ]["name"]
                                                    ],
                                                    "passed": bool(
                                                        passed[
                                                            threshold[
                                                                "keyPerformanceIndicator"
                                                            ]["name"]
                                                        ]
                                                    ),
                                                }
                                                for threshold in self.scenario_data[
                                                    "testObjectives"
                                                ]["criticalityMetrics"]
                                            ]
                                        },
                                        "esminiDat": current_register_data[
                                            "esmini_dat_id"
                                        ],
                                    }
                                    new_trial_id = None
                                    new_trial = None

                                    try:
                                        response = requests.post(
                                            url=self.PAYLOAD_API + "/trials",
                                            json=trial_db_data,
                                            verify=False,
                                            headers=self.headers,
                                        )
                                        response.raise_for_status()
                                        new_trial_id = response.json()["doc"]["id"]
                                        new_trial = response.json()["doc"]
                                    except Exception as e:
                                        print("Error:", str(e))

                                    if new_trial_id and new_trial:
                                        self.sampler.store_to_db(new_trial_id)

                                        # try:
                                        #     response = requests.get(
                                        #         url=self.PAYLOAD_API
                                        #         + "/trials?depth=0&limit={}&where[batch][equals]={}".format(
                                        #             self.search_data[
                                        #                 "requiredNumberOfTrials"
                                        #             ],
                                        #             self.batch_id,
                                        #         ),
                                        #         verify=False,
                                        #         headers=self.headers,
                                        #     )
                                        #     response.raise_for_status()
                                        #     print(
                                        #         "successfully get latest trials of batch"
                                        #     )
                                        #     latest_batch_trials = response.json()[
                                        #         "docs"
                                        #     ]
                                        #     prev_trials = unique_list(
                                        #         [
                                        #             trial["id"]
                                        #             for trial in latest_batch_trials
                                        #         ]
                                        #     )
                                        #     def patch_batches(url, data):
                                        #         response = requests.patch(
                                        #             url=self.PAYLOAD_API
                                        #             + "/batches/{}?depth=0".format(
                                        #                 self.batch_id
                                        #             ),
                                        #             json={
                                        #                 "trials": prev_trials
                                        #                 + [new_trial_id]
                                        #             },
                                        #             verify=False,
                                        #             headers=self.headers,
                                        #         )
                                        #         response.raise_for_status()
                                        #         print(
                                        #             "successfully patch trials to batches"
                                        #         )
                                        #
                                        #     print("PATCH TRIALS TO BATCHES")
                                        #     patchData = {"trials": prev_trials + [new_trial_id] }
                                        #     thread = threading.Thread(target=patch_batches, args=(self.PAYLOAD_API + "/trials/{}".format(trial["id"]), patchData))
                                        #     thread.start()
                                        #     time.sleep(10)
                                        #     print("SLEEP 10 SECS")
                                        #
                                        #     # response = requests.patch(
                                        #     #     url=self.PAYLOAD_API
                                        #     #     + "/batches/{}?depth=0".format(
                                        #     #         self.batch_id
                                        #     #     ),
                                        #     #     json={
                                        #     #         "trials": prev_trials
                                        #     #         + [new_trial_id]
                                        #     #     },
                                        #     #     verify=False,
                                        #     #     headers=self.headers,
                                        #     # )
                                        #     # response.raise_for_status()
                                        #     # print(
                                        #     #     "successfully patch trials to batches"
                                        #     # )
                                        # except Exception as e:
                                        #     print(
                                        #         "Patch trials to batches, Error:",
                                        #         str(e),
                                        #     )

                                except Exception:
                                    print(traceback.format_exc())
                                    rospy.logerr(
                                        "[single_parameterized_scenario_search] register service failed for data {}, continue...".format(
                                            current_register_data
                                        )
                                    )

                        else:
                            current_register_data = {
                                "outcome": None,
                                "trial_index": self.current_trial_index,
                                "states_filepath": "",
                                "esmini_dat_id": "",
                            }
                            response = requests.post(
                                url=self.parameter_search_service_url + "/register",
                                json=current_register_data,
                            )
                            rospy.logerr(
                                "[single_parameterized_scenario_search] something went wrong... end by signal from scenario or esmini record not exists or esmini simulation time too short"
                            )
                        if self.enable_reference_preventable_judgement:
                            is_reference_model_turn = not is_reference_model_turn

                    # Get the next config file's path.
                    # Return value "None" means all done.
                    if (
                        not self.enable_reference_preventable_judgement
                        or current_config_filepath is None
                        or not is_reference_model_turn
                    ):
                        if current_config_filepath is not None:
                            print(
                                "remove prev config: {}".format(
                                    current_config_filepath.as_posix()
                                )
                            )
                            os.remove(current_config_filepath.as_posix())
                            print(
                                "remove xosc: {}".format(
                                    self.current_xosc_filepath.as_posix()
                                )
                            )
                            os.remove(self.current_xosc_filepath.as_posix())
                        current_config_filepath = self.generate_new_config()
                        print(
                            "new config filepath: {}".format(
                                current_config_filepath.as_posix()
                            )
                        )

                    if current_config_filepath is None:
                        break

                    # Calling scenario reconfigure action and reset ego
                    goal = ScenarioReconfigureGoal(
                        motion_config_file_path=str(current_config_filepath)
                    )
                    self.scenario_reconfigure_client.send_goal(goal)
                    rospy.loginfo("[SingleParameterizedScenarioSearch] Reset ego.")
                    self.scenario_reconfigure_client.wait_for_result()
                    self.call_reset_service()

                    result = self.scenario_reconfigure_client.get_result()
                    rospy.loginfo(
                        "[SingleParameterizedScenarioSearch] "
                        "Get scenario reconfigure result {}.".format(result)
                    )
                    rospy.loginfo(
                        "[SingleParameterizedScenarioSearch] "
                        "Current Trial {}".format(self.current_trial_index)
                    )

                    if self.enable_reference_preventable_judgement:
                        msg = Bool()
                        msg.data = is_reference_model_turn
                        self.is_reference_model_turn_publisher.publish(msg)

                    msg = String()
                    msg.data = str(
                        self.record_root_dir
                        / (
                            "esmini_"
                            + (
                                "rss_reference_model_"
                                if is_reference_model_turn
                                else ""
                            )
                            + str(self.batch_id)
                            + "_"
                            + str(self.current_trial_index)
                            + ".dat"
                        )
                    )
                    rospy.loginfo(
                        "[single_parameterized_scenario_search] publish esmini record filepath: {}".format(
                            msg.data
                        )
                    )
                    self._esmini_record_filepath_publisher.publish(msg)
                    self.current_esmini_record_filepath = Path(msg.data)

                    self.esmini_simulation_time = 0.0
                    self.scenario_checker.reset()
                    self.scoring.reset()
                    self.sampler._reset()

                    if not self.sim_with_external_ego:
                        avg_rate = None
                        while (
                            avg_rate == None
                            or avg_rate < self._MIN_STEER_CMD_STABLE_RATE
                        ):
                            is_ego_reset = False
                            hz_statistics = self._steer_cmd_hz.get_hz()
                            avg_rate = (
                                None if hz_statistics == None else hz_statistics[0]
                            )
                            while not self._is_ego_stable():
                                rospy.sleep(rospy.Duration(secs=1.0))
                                rospy.logwarn(
                                    "[ScenarioSampler] Wait for ego stable..."
                                )
                                if self._is_ego_stable():
                                    is_ego_reset = True
                            if is_ego_reset:
                                rospy.logwarn("[ScenarioSampler] Ego has been reset.")
                                rospy.loginfo(
                                    "[ScenarioSampler] Time start! Trial: {}".format(
                                        self.current_trial_index
                                    )
                                )
                                self._start_time = rospy.Time.now()
                            rospy.sleep(rospy.Duration(secs=1.0))
                            rospy.logwarn(
                                "[ScenarioSampler] Wait steer cmd stable... {}".format(
                                    avg_rate
                                )
                            )
                    else:
                        rospy.sleep(rospy.Duration(secs=3))

                    scenario_stable = True
                    msg = Bool()
                    msg.data = scenario_stable
                    self._scenario_stable_publisher.publish(msg)
                    rospy.logerr("PUBLISH SCENARIO STABLE")

                    # self.sampler.run(self.current_trial_index)

                    if is_init:
                        is_init = False

                    rospy.sleep(self.scenario_checker.ignore_first_n_seconds)

                rate.sleep()

        except KeyboardInterrupt:
            rospy.loginfo(
                "[SingleParameterizedScenarioSearch] Terminated by KeyboardInterrupt."
            )

        finally:
            rospy.loginfo("[SingleParameterizedScenarioSearch] Done.")
            rospy.signal_shutdown("[SingleParameterizedScenarioSearch] Done")

    def generate_new_config(self):
        while True:
            response = requests.get(
                url=self.parameter_search_service_url
                + "/suggest/{}".format(self.search_data["id"]),
                verify=False,
            )
            if response.status_code == 200:
                rospy.loginfo(
                    "[single_parameterized_scenario_search] successfully generate new config, response time: {}".format(
                        response.elapsed.total_seconds()
                    )
                )
                break
            sleep_seconds = 10
            print(
                "[single_parameterized_scenario_search] generate new config response failed: sleep {} seconds and try again...".format(
                    sleep_seconds
                )
            )
            rospy.sleep(sleep_seconds)

        self.current_trial_index = response.json()["trial_index"]
        self.current_parameters = response.json()["parameters"]
        if self.current_trial_index == -1:
            return None  # Done
        new_config_filepath = self.suggest_new_config_file(
            self.current_parameters, self.current_trial_index
        )

        with open(str(new_config_filepath), "r") as file:
            new_config = json.load(file)

        return new_config_filepath

    def _car_state_callback(self, msg):
        self._ego_stable_queue.append(msg.is_stable)

    def _is_ego_stable(self):
        stable_num = self._ego_stable_queue.count(True)
        return stable_num == self._EGO_STABLE_QUEUE_SIZE

    def _generate_default_config(self):
        soup = BeautifulSoup(self.openscenario_xml, "xml")

        units = {}
        parameters = {}
        parameter_declarations = soup.find_all("ParameterDeclaration")
        for parameter_declaration in parameter_declarations:
            name = parameter_declaration["name"]
            parameter_type = parameter_declaration["parameterType"]
            value = parameter_declaration["value"]
            if parameter_type == "double":
                value = float(value)
            parameters[name] = value
            if "unit" in parameter_declaration.attrs:
                units[name] = parameter_declaration["unit"]

        motion_configs = []
        objects = soup.find_all("ScenarioObject")
        for object in objects:
            name = object["name"]
            if "Ego" in name or "Sumo" in name:
                continue

            entry_name = object.find("CatalogReference")["entryName"]

            if "$" in entry_name:
                parameter_name = entry_name[1:]
                entry_name = parameters[parameter_name]

            object_class_id = "car"
            if "pedestrian" in entry_name:
                object_class_id = "person"
            if "motorbike" in entry_name:
                object_class_id = "motorbike"

            motion_configs.append(
                {
                    "name": name,
                    "entry_name": entry_name,
                    "object_class_id": object_class_id,
                }
            )

        default_config = {
            "esmini": "esmini_simulator",
            "ego_vehicle": {
                "size": {
                    "x": 5.17,
                    "y": 2.2,
                    "z": 1.777,
                    "x_": 9.4,
                    "y_": 3.3,
                    "z_": 3.7,
                },
                "compensated_second_": 0.1,
                "compensated_second": 0,
                "static_longitudinal_compensated_distance": 0,
            },
            "esmini_simulator": {
                "vehicle": "pacifica",
                "default_pose_seq": 0,
                "time_step": 0.1,
                "visualization_time_step": 0.01,
                "esmini_model": {
                    "time_step": 0.1,
                    "visualization_time_step": 0.01,
                    "motion_configs": motion_configs,
                    "start_sampling_conditions": (
                        self.scenario_search_config["start_sampling_conditions"]
                        if "start_sampling_conditions" in self.scenario_search_config
                        else []
                    ),
                    "state_recording_agents": (
                        self.scenario_search_config["state_recording_agents"]
                        if "state_recording_agents" in self.scenario_search_config
                        else []
                    ),
                    "parameters": parameters,
                    "units": units,
                    "openscenario": self.scenario_search_config[
                        "openscenario_template"
                    ],
                },
            },
        }

        if "reference_model" in self.scenario_search_config:
            default_config["esmini_simulator"]["esmini_model"]["reference_model"] = (
                self.scenario_search_config["reference_model"]
            )

        if "ego_initial_speed_required" in self.scenario_search_config:
            default_config["esmini_simulator"]["esmini_model"][
                "ego_initial_speed_required"
            ] = self.scenario_search_config["ego_initial_speed_required"]

        if "scenario_valid_conditions" in self.scenario_search_config:
            default_config["esmini_simulator"]["esmini_model"][
                "scenario_valid_conditions"
            ] = self.scenario_search_config["scenario_valid_conditions"]

        rootpath = "/project/mmsl_simulation/src/scenario/data/resources/xosc/Catalogs"
        pedestrian_catalog_filepath = rootpath + "/Pedestrians/PedestrianCatalog.xosc"
        with open(pedestrian_catalog_filepath, "r") as file:
            pedestrian_catalog = file.read()
        vehicle_catalog_filepath = rootpath + "/Vehicles/VehicleCatalog.xosc"
        with open(vehicle_catalog_filepath, "r") as file:
            vehicle_catalog = file.read()
        misc_object_catalog_filepath = rootpath + "/MiscObjects/MiscObjectCatalog.xosc"
        with open(misc_object_catalog_filepath, "r") as file:
            misc_object_catalog = file.read()

        moving_agent_configs = []
        default_config_agents = default_config["esmini_simulator"]["esmini_model"][
            "motion_configs"
        ]
        for agent in default_config_agents:
            moving_agent_config = {
                "name": agent["name"],
                "object_class_id": agent["object_class_id"],
                "front_warning_region_size": {"x": 0, "y": 0},
                "color": {"r": 1, "g": 0.5, "b": 0, "a": 1},
                "safety_margin": {"left": 0, "right": 0, "front": 0, "rear": 0},
            }

            soup = BeautifulSoup(self.openscenario_xml, "xml")

            object = soup.find("ScenarioObject", attrs={"name": agent["name"]})
            widthElement = object.find("ParameterAssigment", parameterRef="width")
            lengthElement = object.find("ParameterAssigment", parameterRef="length")

            width = None
            length = None

            if widthElement is not None and lengthElement is not None:
                widthValue = widthElement["value"]
                lengthValue = lengthElement["value"]

                try:
                    width = float(widthValue)
                except ValueError:
                    try:
                        width = float(parameters[widthValue[1:]])
                    except ValueError:
                        print(
                            "cannot get {} width use default values".format(
                                agent["entry_name"]
                            )
                        )

                try:
                    length = float(lengthValue)
                except ValueError:
                    try:
                        length = float(parameters[lengthValue[1:]])
                    except ValueError:
                        print(
                            "cannot get {} length use default values".format(
                                agent["entry_name"]
                            )
                        )

            catalog_xml = (
                pedestrian_catalog
                if agent["object_class_id"] == "person"
                else vehicle_catalog
            )
            entry_name = agent["entry_name"]
            catalog = (
                "Pedestrian" if agent["object_class_id"] == "person" else "Vehicle"
            )

            # HACK
            if entry_name == "obstacle":
                catalog_xml = misc_object_catalog
                catalog = "MiscObject"

            soup = BeautifulSoup(catalog_xml, "xml")

            agent_model = soup.find(catalog, {"name": entry_name})
            assert agent_model is not None

            bounding_box = agent_model.find("BoundingBox")
            assert bounding_box is not None

            dimensions = agent_model.find("Dimensions")
            assert dimensions is not None

            if width is None or length is None:
                widthElement = agent_model.find(
                    "ParameterDeclaration", {"name": "width"}
                )
                lengthElement = agent_model.find(
                    "ParameterDeclaration", {"name": "length"}
                )
                if widthElement and lengthElement:
                    width = float(widthElement["value"])
                    length = float(lengthElement["value"])
                else:
                    width = float(dimensions["width"])
                    length = float(dimensions["length"])

            size_overwrite = {
                "x": length,
                "y": width,
                "z": float(dimensions["height"]),
            }
            moving_agent_config["size_overwrite"] = size_overwrite
            moving_agent_configs.append(moving_agent_config)

        default_config["esmini_simulator"]["esmini_model"][
            "moving_agent_configs"
        ] = moving_agent_configs

        return default_config

    def suggest_new_config_file(self, parameters, trial_index):
        if trial_index == -1:
            return NewConfigFileData(filepath="", trial_index=-1)
        assert (
            parameters is not None
        ), "[ParameterSearchingServer:Handler] parameters is None"

        new_config = deepcopy(self.default_config)

        for parameter_name, v in parameters.items():
            new_config["esmini_simulator"]["esmini_model"]["parameters"][
                parameter_name
            ] = v

        soup = BeautifulSoup(self.openscenario_xml, "xml")

        parameter_declarations = soup.find_all("ParameterDeclaration")
        xosc_parameters = {}

        for parameter_declaration in parameter_declarations:
            param_name = parameter_declaration["name"]
            xosc_parameters[param_name] = parameter_declaration["value"]
            if param_name in parameters:
                parameter_declaration["value"] = parameters[param_name]
                xosc_parameters[param_name] = parameters[param_name]

        logic_file_element = soup.find("LogicFile")
        logic_file_element["filepath"] = str(self.opendrive_filepath)

        def can_convert_to_float(value):
            try:
                float(value)
                return True
            except (ValueError, TypeError):
                return False

        trajectory_elements = soup.find_all("Trajectory")
        for trajectory_element in trajectory_elements:
            if trajectory_element["model"] == "kinematic":
                input = {
                    "L": 2,
                    "seconds": trajectory_element["seconds"],
                    "x0": trajectory_element["x0"],
                    "y0": trajectory_element["y0"],
                    "v0": trajectory_element["v0"],
                    "theta0": trajectory_element["theta0"],
                    "phi0": trajectory_element["phi0"],
                    "xf": trajectory_element["xf"],
                    "yf": trajectory_element["yf"],
                    "vf": trajectory_element["vf"],
                    "thetaf": trajectory_element["thetaf"],
                    "phif": trajectory_element["phif"],
                }
                pprint(input)

                for key in input:
                    print(key)
                    print(str(key))
                    # if str(key) == "yf":
                    #     continue
                    value = input[key]
                    if can_convert_to_float(value):
                        input[key] = float(value)
                    else:
                        input[key] = float(xosc_parameters[value.replace("$", "")])

                # input["yf"] = -0.398 * input["xf"] - 143.528  # PRI 13 and 14
                # input["y0"] = 0.651 * input["x0"] - 113.588  # PRI 14
                # input["y0"] = 0.602 * input["x0"] - 119.132  # PRI 14
                # y = 0.602x - 119.132
                # y = 0.651x - 113.588
                # 16.4x - 25.2y - 2862.68 = 0

                pprint(input)
                response = requests.post(
                    "http://localhost:9011/path_planning",
                    json=input,
                    verify=False,
                )
                # Check the response
                if response.status_code == 200 or response.status_code == 201:
                    print("successfully get trajectory data")
                else:
                    print(
                        "Error getting trajectory. Status code:",
                        response.status_code,
                    )
                    response.raise_for_status()
                trajectory_data = response.json()

                polyline_tag = soup.new_tag("Polyline")
                for i in range(len(trajectory_data["t"])):
                    vertex_tag = soup.new_tag("Vertex")
                    vertex_tag["time"] = trajectory_data["t"][i]
                    position_tag = soup.new_tag("Position")
                    world_position_tag = soup.new_tag("WorldPosition")
                    world_position_tag["x"] = str(trajectory_data["x"][i])
                    world_position_tag["y"] = str(trajectory_data["y"][i])
                    world_position_tag["z"] = "0.0"
                    world_position_tag["h"] = str(trajectory_data["theta"][i])
                    position_tag.append(world_position_tag)
                    vertex_tag.append(position_tag)
                    polyline_tag.append(vertex_tag)
                shape_tag = soup.new_tag("Shape")
                shape_tag.append(polyline_tag)
                trajectory_element.append(shape_tag)

        osc_config_filepath = self.record_root_dir / "scenario_{}.xosc".format(
            trial_index
        )
        print(osc_config_filepath)
        with open(str(osc_config_filepath), "w") as file:
            file.write(str(soup.prettify()))

        self.current_xosc_filepath = Path(osc_config_filepath)
        new_config["esmini_simulator"]["esmini_model"]["openscenario"] = str(
            osc_config_filepath
        )

        pprint(new_config)

        new_config_filepath = (
            self.record_root_dir / "single_scenario_config_{}.json"
            "".format(trial_index)
        )
        with open(str(new_config_filepath), "w") as f:
            json.dump(new_config, f, indent=4)

        return new_config_filepath


if __name__ == "__main__":
    main()
