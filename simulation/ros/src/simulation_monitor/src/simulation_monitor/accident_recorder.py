#!/usr/bin/env python
import os, json, copy, yaml
from collections import deque, OrderedDict
from threading import Thread, Lock
from enum import Enum

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import rospy, rosbag
import tf2_ros
from std_msgs.msg import String
from itri_msgs.msg import CarState
from simulation_msgs.msg import CollisionProfile
from simulation_monitor.srv import IdentifyAccident
from sumo_cosimulation.msg import AccidentOverview
from sumo_cosimulation.srv import RequestAccidentOverview
from sumo_cosimulation.srv import RequestAccidentOverviewResponse

import recorder_utils

class CollisionState(Enum):
    """CollisionState Meaning

    0: NOTHING
        No collision detected.

    1: FIRST_COLLIDE
        First time detecting collision.
        > Will move to state 2 immediately.

    2: STILL_COLLIDE
        Keep detecing collision.
        > Move to state 3 if not detecting collision for 1 sec.

    3: AFTER_COLLIDE
        Collision was ended. This state will last for 4 sec.
        > Will go back to state 2 if new collision detected.

    4. SAVING_RECORDS
        Writer thread starts to copy required variable.
        > Will temporary disable collision_profile overwriting
        and new collision detection.

    5. KEEP_EYE_ON_NEW_COLLIDE
        In this state, there are still writer thread(s) running.
        records older than interested time horizon will not
        be removed duting this stage.  New collision will be
        detected.
        > Move to State 0 if all writer threads end.
    """
    NOTHING = 0
    FIRST_COLLIDE = 1
    STILL_COLLIDE = 2
    AFTER_COLLIDE = 3
    SAVING_RECORDS = 4
    KEEP_EYE_ON_NEW_COLLIDE = 5

class AccidentRecorder:
    AGENT_TRAJ_MAX_LENGTH = 30
    def __init__(self):

        self.save_path = rospy.get_param(
            "accident_recorder/save_path", "/tmp/")
        self.save_path_overwrite = None
        self.dt = float(rospy.get_param("timeStep", 0.01))
        self.collision_handler = {
            "seq": 0,
            "first": rospy.Time(), # Timestep of first collision
            "hold": rospy.Time(), # Last timestep of a collision
            "lock": Lock(), # Thread lock to prevent overwrite
            "msg": CollisionProfile()}

        # For state machine
        self.collision_state = CollisionState.NOTHING
        self.records = deque()
        self.enable_records = rospy.get_param(
            "accident_recorder/enable", {})
        self.topics = recorder_utils.get_record_topics()
        self._generate_subscribers()

        self.save_path_overwrite_subscriber = rospy.Subscriber(
            "simulation_monitor/accident_recorder/save_path_overwrite",
            String,
            self._save_path_overwrite_callback)
        self.simulation_reset_subscriber = rospy.Subscriber(
            "simulation/reset_car_state",
            CarState,
            self._simulation_reset_callback)
        self.collision_subscriber = rospy.Subscriber(
            "simulation/collision_profile",
            CollisionProfile, self._collision_callback)

        self.accident_overview_server = rospy.Service(
            "simulation/request_accident_overview",
            RequestAccidentOverview,
            self._accident_overview_server_handler)

        self.identify_accident = rospy.ServiceProxy(
            "simulation_monitor/identify_accident", IdentifyAccident)

        # Use thread to record rosbag and images
        # Since both take long time to complete.
        self.record_writer_thread = lambda: Thread(target=self.record_writer)
        self.writer_workers = []

        # For SimulationOverview
        self.accident_overview = AccidentOverview()
        self.tf_buffer = tf2_ros.Buffer(rospy.Duration(3600.))
        self.listener = tf2_ros.TransformListener(self.tf_buffer)

        # Thread lock for plotting
        # Only 1 worker plot at a time
        self.plt_lock = Lock()
        plt.figure(figsize=(12, 8))

    def _accident_overview_server_handler(self, req):
        if req.is_new_round:
            self.accident_overview.past_rounds_accident_numbers.append(
                self.accident_overview.current_round_accident_numbers)
        self.accident_overview.total_accident_numbers = \
            self.collision_handler["seq"]
        self.accident_overview.current_round_accident_numbers = \
            self.accident_overview.total_accident_numbers \
            - np.sum(self.accident_overview.past_rounds_accident_numbers)
        self.accident_overview.collision_state = self.collision_state.value
        self.accident_overview.collision_state_str = self.collision_state.name
        return RequestAccidentOverviewResponse(self.accident_overview)

    def _last_collision_ends(self, timestamp=None):
        timestamp = timestamp or rospy.Time.now()
        rospy.logdebug("[Accident Recorder] {} > {} ? "\
            "".format(timestamp.to_sec(),
                self.collision_handler["hold"].to_sec()))

        return (timestamp > self.collision_handler["hold"])

    def _reset_accident_recorder(self):
        for w in self.writer_workers:
            w.join()
        self.writer_workers = []
        self.collision_handler["first"] = rospy.Time()
        self.collision_handler["hold"] = rospy.Time()
        self.collision_state = CollisionState.NOTHING
        self.records = deque()

    def _simulation_reset_callback(self, msg):
        self._reset_accident_recorder()

    def _save_path_overwrite_callback(self, msg):
        if self.save_path_overwrite != msg.data:
            self.save_path_overwrite = msg.data
            rospy.logwarn("[Accident Recorder] Overwrite save path from {} to {}"\
                "".format(self.save_path, self.save_path_overwrite))
            self.save_path = self.save_path_overwrite

    def _collision_callback(self, msg):

        with self.collision_handler["lock"]:
            self.collision_handler["hold"] = rospy.Time.now() \
                + rospy.Duration(5.0)

        self.collision_handler["msg"] = msg
        agnet_id = msg.opponent_id
        if self.collision_state == CollisionState.NOTHING \
            or self.collision_state == CollisionState.KEEP_EYE_ON_NEW_COLLIDE:
            # new collision
            self.collision_state = CollisionState.FIRST_COLLIDE
            rospy.loginfo("[Accident Recorder]"\
                " Get new collision with agent: {}.".format(agnet_id))
            with self.collision_handler["lock"]:
                self.collision_handler["seq"] += 1
                self.collision_handler["first"] = rospy.Time.now()
                self.collision_handler["saved"] = False
        elif self.collision_state == CollisionState.FIRST_COLLIDE:
            self.collision_state = CollisionState.STILL_COLLIDE
        elif self.collision_state == CollisionState.AFTER_COLLIDE:
            self.collision_state = CollisionState.STILL_COLLIDE

    def _generate_subscribers(self):
        self.subscribers = []
        for topics in self.topics:
            name, value = topics["name"], topics["value"]
            self.subscribers.append(rospy.Subscriber(
                name, value, self._default_callback, name))

    def _remove_10sec_before(self, records=None, timestamp=None):
        records = records or self.records
        timestamp = timestamp or rospy.Time.now()
        while len(records) > 0:
            if records[0]["t"] + rospy.Duration(10.) <= timestamp:
                records.popleft()
                continue
            break

    def run_finite_state_machine(self):
        rospy.sleep(1.)
        rate = rospy.Rate(1.0)
        last_state = self.collision_state

        while not rospy.is_shutdown():

            if last_state != self.collision_state:

                rospy.loginfo("[Accident Recorder] Current State: {}"\
                    "".format(self.collision_state.name))
                last_state = self.collision_state

            if self.collision_state == CollisionState.NOTHING:
                self._remove_10sec_before(self.records)

            if self.collision_state == CollisionState.FIRST_COLLIDE:
                self.collision_state = CollisionState.STILL_COLLIDE

            if self.collision_state == CollisionState.STILL_COLLIDE:
                if self._last_collision_ends(rospy.Time.now()
                                             + rospy.Duration(4.0)):
                    # not recieving for 1 sec.
                    self.collision_state = CollisionState.AFTER_COLLIDE

            if self.collision_state == CollisionState.AFTER_COLLIDE:
                if self._last_collision_ends():
                    self.collision_state = CollisionState.SAVING_RECORDS
                    writer_worker = self.record_writer_thread()
                    self.writer_workers.append(writer_worker)
                    self.writer_workers[-1].start()

            if self.collision_state == CollisionState.SAVING_RECORDS:
                pass

            if self.collision_state == CollisionState.KEEP_EYE_ON_NEW_COLLIDE:
                remove_indices = []

                for i, w in enumerate(self.writer_workers):
                    if not w.is_alive():
                        remove_indices.append(i)

                self.writer_workers = list(
                    np.delete(self.writer_workers, remove_indices))

                if len(self.writer_workers) == 0:
                    self.collision_state = CollisionState.NOTHING

            rate.sleep()

    def _default_callback(self, msg, topic_name):
        self.records.append({
            "t": rospy.Time.now(),
            "topic": topic_name,
            "msg": msg
        })

    def record_writer(self):

        rospy.loginfo("Start recording last accident.")

        profile = self.collision_handler["msg"]
        start = self.collision_handler["first"]
        hold = self.collision_handler["hold"]
        # seq = self.collision_handler["seq"]
        seq = profile.header.seq
        self.collision_state = CollisionState.KEEP_EYE_ON_NEW_COLLIDE

        # Identify Accident
        result_key = "accident #{:05d}".format(seq)
        try:
            rospy.wait_for_service(
                "simulation_monitor/identify_accident",
                timeout=0.01)
            response = self.identify_accident(profile)
            accident_brief = response.brief
            identified_result = {
                result_key: recorder_utils.identify_response_to_dict(
                    response)}
        except rospy.exceptions.ROSException as e:
            rospy.logwarn_throttle(600, "Accident identify service "\
                "not available.")
            response = None
            accident_brief = "identifier_unavailable"
            identified_result = {
                result_key: "Accident identifier not implemented."}

        if not all(self.enable_records.items()):
            rospy.loginfo("[Accident Recorder] Record disabled.")

        else:
            if self.save_path_overwrite:
                save_path = self.save_path_overwrite + "accident_record/"
                run_id = "accident_overview"
            else:
                save_path = self.save_path + "{}".format(run_id)
                run_id = rospy.get_param("/run_id", "-").split("-")[0]
            common_name = "collision_seq-{}_{}"\
                "".format(seq, accident_brief)
            common_path = "{}{}".format(save_path, common_name)
            run_path = "{}{}.json".format(self.save_path, run_id)
            json_path = "{}.json".format(common_path)
            img_path = "{}.jpg".format(common_path)
            bag_path = "{}.bag".format(common_path)

            rospy.loginfo("[Accident Recorder] #{} | "\
                "record_writer start.| Saving to {}/{}"\
                "".format(seq, save_path, common_name))

            if not os.path.isdir(save_path):
                os.makedirs(save_path)

            trajs = None
            if self.enable_records.get("image"):
                # Deal with images
                with self.plt_lock:
                    trajs = recorder_utils.draw_image(
                        self.records,
                        profile,
                        img_path,
                        start - rospy.Duration(5.),
                        start)

            if trajs:
                # {"opponent": [pose2d,],  "ego": [pose2d, ]]
                profile.ego.trajs_source = 2
                profile.ego.trajs = trajs["ego"]
                while len(profile.ego.trajs) \
                        > self.AGENT_TRAJ_MAX_LENGTH:
                    profile.ego.trajs.pop(0)

                profile.agent.trajs_source = 2
                profile.agent.trajs = trajs["opponent"]
                while len(profile.agent.trajs) \
                        > self.AGENT_TRAJ_MAX_LENGTH:
                    profile.agent.trajs.pop(0)

            if self.enable_records.get("info"):
                # Deal with json file
                recorder_utils.record_json(
                    profile,
                    json_path,
                    run_path,
                    identified_result)


            if self.enable_records.get("bag"):
                # Deal with rosbag
                recorder_utils.record_bag(self.records, bag_path)


            rospy.loginfo("[Accident Recorder] #{} "\
                "| record_writer ends | accident brief: {}"\
                "".format(seq, accident_brief))


if __name__ == "__main__":
    rospy.init_node("accident_recorder_node")
    AR = AccidentRecorder()
    rospy.loginfo("[Accident Recorder] Enabled item: {}"\
        "".format( json.dumps(AR.enable_records, indent=4) ))
    AR.run_finite_state_machine()


