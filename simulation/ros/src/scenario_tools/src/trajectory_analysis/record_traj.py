#!/usr/bin/env python

import json
from collections import OrderedDict
import time

import numpy as np
import rospy
import tf2_ros
from geometry_msgs.msg import Transform, TransformStamped, Point, Quaternion
from itri_msgs.msg import WaypointArray, VehicleState, speed_cmd
from geometry_msgs.msg import Quaternion

from simulation_utils.converter import QuaternionToVector3

np.set_printoptions(suppress=True, threshold=1e20, linewidth=150)
ORIENTATION_TYPE = "yaw"  # options: "yaw" (in rad) | "quaternion"
RECORD_SIMULATION_ONLY = True

def main():
    global ORIENTATION_TYPE
    assert ORIENTATION_TYPE in ["yaw", "quaternion"]
    tr = TrajRecorder()

class TrajRecorder:
    def __init__(self):
        rospy.init_node("traj_record_node")
        self.tf_buffer = tf2_ros.Buffer(rospy.Duration(1000.0))
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)
        self.frame_id = {
            "sim": "base_link",
            "real": "origin/base_link_with_imu"
        }

        if RECORD_SIMULATION_ONLY:
            self.ego_from_list = ["sim"]
        else:
            self.ego_from_list = ["real", "sim"]

        if ORIENTATION_TYPE == "quaternion":
            data_format = ["timestamp", "x", "y", "z", "q.x", "q.y", "q.z", "q.w"]
        else:
            data_format = ["timestamp", "x", "y", "z", "yaw"]

        self.data = OrderedDict([
            ("data_format", data_format),
            ("init_stamp", None),
            ("sim", []),
            ("real", [])
        ])
            
        self.callback_data = {
            "sim": {
                "speed_cmd": [],
                "vehicle_state": []
            },
            "real": {
                "speed_cmd": [],
                "vehicle_state": []
            },
        }


        rospy.Subscriber("/speed_cmd", speed_cmd, self.callback,
            callback_args = {"ego_from": "sim", "field": "speed_cmd"})
        rospy.Subscriber("/speed_cmd_old", speed_cmd, self.callback,
            callback_args = {"ego_from": "real", "field": "speed_cmd"})
        rospy.Subscriber("/vehicle_state", VehicleState, self.callback,
            callback_args = {"ego_from": "sim", "field": "vehicle_state"})
        rospy.Subscriber("/vehicle_state_old", VehicleState, self.callback,
            callback_args = {"ego_from": "real", "field": "vehicle_state"})

        if RECORD_SIMULATION_ONLY:
            del self.data["real"]
            del self.callback_data["real"]

        self.handle_save_dir()

        rospy.loginfo("[traj_record] wait for waypoints.")
        rospy.wait_for_message("/waypoints", WaypointArray)
        rospy.loginfo("[traj_record] Get waypoints. Start recording.")
        
        try:
            self.run()
            rospy.loginfo("[traj_record] TF lookup ends.")

        except (KeyboardInterrupt, rospy.exceptions.ROSInterruptException) as e:
            rospy.logwarn(e)

        finally:
            rospy.loginfo("[traj_record] record done. handling msg data.")
            self.handle_msg_data()
            rospy.loginfo("[traj_record] Writing traj to {}".format(self.file_name))
            with open(self.file_name, "w") as f:
                js_obj = json.dumps(self.data, indent=4)
                f.write(js_obj)
            rospy.loginfo("[traj_record] Terminated.")

    def handle_msg_data(self):
        rospy.loginfo("[traj_record] handle msg data.")
        self.data["sim"] = np.array(sorted(self.data["sim"], key=lambda x: x[0]))
        if not RECORD_SIMULATION_ONLY:
            self.data["real"] = np.array(sorted(self.data["real"], key=lambda x: x[0]))
        

        for ego_from, data_array in self.data.items():
            if ego_from not in self.ego_from_list: continue
            # data_array: np.array([[stamp, x, y, z, qx, qy, qz, qw], ])  shape (n, 8)
            timestamps = data_array[:, 0]
            for field in sorted(self.callback_data[ego_from].keys()):
                msgs = self.callback_data[ego_from][field]
                msg_array_with_stamp = np.array(msgs)

                value = np.interp(timestamps, msg_array_with_stamp[:, 0], msg_array_with_stamp[:, 1])
                value = value.reshape((data_array.shape[0], 1))
                self.data[ego_from] = np.concatenate((self.data[ego_from], value), axis=1)
                
                extract_from_field = {
                    "speed_cmd": "speed cmd",
                    "vehicle_state": "actual speed"
                }[field]
                if not extract_from_field in self.data["data_format"]:
                    self.data["data_format"].append(extract_from_field)

        rospy.loginfo(self)
        self.data["sim"] = self.data["sim"].tolist()
        if not RECORD_SIMULATION_ONLY:
            self.data["real"] = self.data["real"].tolist()
        self.data["data_format"] = str(self.data["data_format"])

    def callback(self, msg, args):
        stamp = rospy.Time.now().to_sec()
        ego_from = args["ego_from"]
        field = args["field"]
        if field == "speed_cmd":
            self.callback_data[ego_from][field].append([stamp, msg.kph])
        elif field == "vehicle_state":
            self.callback_data[ego_from][field].append([stamp, msg.speed])

    def handle_save_dir(self):
        if RECORD_SIMULATION_ONLY:
            self.file_name = "/tmp/sil.json"
        else:
            save_dir = rospy.get_param("/scenario_tools_dir", "/project/mmsl_simulation/src/scenario_tools")
            if not save_dir.endswith("/"):
                save_dir = save_dir + "/"
            save_dir = save_dir + "src/trajectory_analysis/"
            self.file_name = save_dir + "recorded-traj-"

            rospy.loginfo("[traj_record] Wait for rosparam /rosbag_replay_tool/replayed_bag.")
            while True:
                bag_file = rospy.get_param("/rosbag_replay_tool/replayed_bag", None)
                if bag_file:
                    self.file_name += bag_file.split("/")[-1].split(".")[0] + ".json"
                    rospy.loginfo("[traj_record] Get param.  Traj file will be saved to {}"\
                        "".format(self.file_name))
                    break
                rospy.sleep(0.1)


    def run(self):

        last_stamp = {"sim": None, "real": None}
        rate = rospy.Rate(1000)

        while not rospy.is_shutdown():

            for ego_from in self.ego_from_list:
                try:
                    transform = self.tf_buffer.lookup_transform(
                        "map", self.frame_id[ego_from], rospy.Time())
                    stamp = transform.header.stamp.to_sec()
                    if last_stamp[ego_from] != stamp:
                        if ego_from == "sim" and last_stamp["real"] is None and not RECORD_SIMULATION_ONLY:
                            break
                        if ORIENTATION_TYPE == "quaternion":
                            self.data[ego_from].append([
                                stamp,
                                transform.transform.translation.x, 
                                transform.transform.translation.y,
                                transform.transform.translation.z,
                                transform.transform.rotation.x,
                                transform.transform.rotation.y,
                                transform.transform.rotation.z,
                                transform.transform.rotation.w
                            ])
                        elif ORIENTATION_TYPE == "yaw":
                            yaw = QuaternionToVector3(transform.transform.rotation, two_d=True).z
                            self.data[ego_from].append([
                                stamp,
                                transform.transform.translation.x, 
                                transform.transform.translation.y,
                                transform.transform.translation.z,
                                yaw
                            ])
                        if self.data["init_stamp"] is None:
                            self.data["init_stamp"] = stamp
                        elif self.data["init_stamp"] > stamp:
                            self.data["init_stamp"] = stamp
                        last_stamp[ego_from] = stamp
                except (
                    tf2_ros.LookupException, 
                    tf2_ros.ConnectivityException, 
                    tf2_ros.ExtrapolationException
                ) as e:
                    rospy.logwarn(e)

            time.sleep(0.01)


    def __str__(self):
        init_stamp = self.data["init_stamp"]
        val = "[Trajectory Recorder Summary]\n"
        val += "\tInit stamp: {}\n".format(init_stamp)
        for ego_from in self.ego_from_list:
            data = self.data[ego_from]
            val += "\t{} data\n".format(ego_from)
            if type(data) is np.ndarray:
                val += "\t\tshape: {}\n".format(data.shape)
                val += "\t\trelative stamp from {:.3f} to {:.3f}\n"\
                    "".format(data[0, 0] - init_stamp, data[-1, 0] - init_stamp)
        return val


if __name__ == '__main__':
    main()