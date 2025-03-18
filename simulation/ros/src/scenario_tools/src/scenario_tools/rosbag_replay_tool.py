#!/usr/bin/env python
import time
from datetime import datetime
import rospy, rosbag
import numpy as np
from geometry_msgs.msg import Pose, Vector3, Vector3Stamped
from geometry_msgs.msg import Twist, Quaternion, TransformStamped, Transform
from std_msgs.msg import Header
from itri_msgs.msg import DetectedObjectArray, speed_cmd, CarState, WaypointArray
from tf2_msgs.msg import TFMessage
from rosgraph_msgs.msg import Clock
from simulation_msgs.msg import SimulationAgentStateControl
from tf2_geometry_msgs import do_transform_vector3
from tf.transformations import quaternion_from_euler
import yaml
import copy

class RosBagReplayTool:

    prefix = "[RosBagReplayTool]"
    def __init__(self):
        self.bag_name = rospy.get_param("~replayed_bag")
        self.rate = rospy.get_param("~replay_rate")

        rospy.loginfo("{} Loading rosbag. "\
            "This may take a while.".format(self.prefix))
        self.bag = rosbag.Bag(self.bag_name, "r")
        rospy.loginfo("{} Rosbag loaded.{}".format(self.prefix, " "*10))

        self.offset = {
            # offset x of simulated ego
            "x": float(rospy.get_param("~offset_x_local")),
            # starts from time of bag
            "t": rospy.Duration(float(rospy.get_param("~offset_time_secs"))),
            # pre-run clock starts from time before bag time starts
            "pre-run": rospy.Duration(abs(float(rospy.get_param("~pre_run_secs"))))
        }

        self.infoDict = yaml.load(self.bag._get_yaml_info())

        # Publishing a topic to simulation to reset simulated ego initial position
        ###  For old simulation
        # self.carStateCmdPublisher = rospy.Publisher(
        #     "/simulation/reset_car_state", CarState, queue_size=1)
        ### For simulation_adv
        self.carStateCmdPublisher = rospy.Publisher(
            "/simulation/agent_control/state_control",
            SimulationAgentStateControl, queue_size=1)

        # Publish TFMessage befor rosbag starts
        self.tfPublisher = rospy.Publisher(
            "/tf", TFMessage, queue_size=1)

        """
        Publish clock under 2 situation:
            * before rosbag starts playing (Pre-run clock)
            * after rosbag starts playing (which should be remapped to /clock_old)
        """
        self.clockPublisher = rospy.Publisher(
            "/clock", Clock, queue_size=1)

        self.clockRemapper = rospy.Subscriber(
            "/clock_old", Clock, self.CallBackClock)

        # Stop pre-run clock after local path was generated.
        self.waypointsSubscriber = rospy.Subscriber(
            "/waypoints", WaypointArray, self.CallBackWaypoints)

        self.bagClockStarted = False
        self.allowPublishPrevTime = False

        self.startTime = rospy.Time(self.infoDict['start']) + \
                         self.offset["t"] + rospy.Duration(0.4)
        rospy.set_param("/rosbag_replay_tool/startTime", self.startTime.to_sec())

        self.preRunTime = copy.deepcopy(rospy.Time(self.infoDict['start']))
        self.preRunTime -= self.offset["pre-run"]

        self.firstCarState = self.GetFirstCarState()
        self.firstBaseLinkOriginTF = self.CarStateToTFMessage(self.firstCarState)

        rospy.loginfo("\033[1;36m[RosbagReplayTool] Configs:\n" +
            "\tGeneral:\n" +
            "\t\tRosbag: {}\n".format(self.bag_name) +
            "\t\tReplay Rate: {}\n".format(self.rate) +
            "\t\tOffset X: {}\n".format(self.offset["x"]) +
            "\tTiming:\n" +
            "\t\tSimulation Starts at   {} (for loading route)\n".format(datetime.utcfromtimestamp(self.preRunTime.to_sec())) +
            "\t\tStart Time of the Bag: {}\n".format(datetime.utcfromtimestamp(self.infoDict['start']))+
            "\t\tRunning Ego at         {}\n".format(datetime.utcfromtimestamp(self.startTime.to_sec())) +
            "\tSetting Ego with state \n" +
            "\t\tpose:\n\t\t\t{}\n".format(str(self.firstCarState.pose.pose).replace("\n", "\n\t\t\t")) +
            "\t\ttwist:\n\t\t\t{}\n".format(str(self.firstCarState.twist.twist).replace("\n", "\n\t\t\t")) +
            "\033[0m"
            )

        # Wait for ego spawned then set to proper position
        rospy.loginfo("Wait for simulation create agent service.")
        rospy.wait_for_service("/simulation/agent_srv/create_by_default_pose")
        rospy.loginfo("Simulation create agent service is now running.")

        time.sleep(3.0)
        self.SetState(zeroTwist=True)
        rospy.loginfo("\n\n{}\n\tPlease launch sdc/run.launch now.\n{}\n".format(
            "="*50, "="*50))

    def GetFirstCarState(self):

        assert self.startTime

        firstState = CarState()
        for topic, msg, t in self.bag.read_messages(topics=['/car_state']):
            if t >= self.startTime:
                firstState = msg
                break

        firstState.pose.pose.position.x += self.offset['x'] * np.cos(firstState.pose.pose.orientation.z)
        firstState.pose.pose.position.y += self.offset['x'] * np.sin(firstState.pose.pose.orientation.z)

        """
            Quaternion in /car_state is on base_link
            Converted twist/linear to map frame here.
            pose/orientation remains the same
        """

        vector = Vector3Stamped(Header(), firstState.twist.twist.linear)
        q = quaternion_from_euler(0, 0, firstState.pose.pose.orientation.z)

        transform = TransformStamped()
        transform.transform.rotation = Quaternion(*q)
        firstState.twist.twist.linear = do_transform_vector3(
            vector, transform).vector

        return firstState

    def SetState(self, zeroTwist=True):  # Read bag to fetch initial pose
        assert self.firstCarState and self.firstBaseLinkOriginTF
        stamp = copy.deepcopy(self.preRunTime) if zeroTwist else copy.deepcopy(self.startTime)
        carState = copy.deepcopy(self.firstCarState)
        carState.header.stamp = stamp

        for i in range(5):
            if zeroTwist:
                carState.twist.twist = Twist()

            self.firstBaseLinkOriginTF.transforms[0].header.stamp = stamp
            self.tfPublisher.publish(self.firstBaseLinkOriginTF)
            cmd = SimulationAgentStateControl(["ego"], [carState], False, False, 0.01)
            self.carStateCmdPublisher.publish(cmd)

            # time.sleep(0.1)

        if not zeroTwist:
            msg = self.CarStateToTFMessage(carState)
            self.tfPublisher.publish(msg)

        # time.sleep(0.2)

        # Start publishing pre-run clock after initial position was set.
        self.allowPublishPrevTime = True
        rospy.loginfo_once("Ego State Set.")


    def CarStateToTFMessage(self, carState):
        tfMessage = TFMessage()
        transform = TransformStamped()
        transform.header = carState.header
        transform.header.frame_id = "map"
        transform.child_frame_id = "base_link"
        transform.transform.translation.x = carState.pose.pose.position.x
        transform.transform.translation.y = carState.pose.pose.position.y
        transform.transform.translation.z = carState.pose.pose.position.z
        q = quaternion_from_euler(0, 0, carState.pose.pose.orientation.z)
        transform.transform.rotation = Quaternion(*q)
        # transform.transform.rotation = carState.pose.pose.orientation
        tfMessage.transforms.append(transform)
        return tfMessage


    def run(self):

        assert self.startTime

        while self.preRunTime < self.startTime and \
              self.allowPublishPrevTime and \
              not self.bagClockStarted and \
              not rospy.is_shutdown():

            self.clockPublisher.publish(Clock(self.preRunTime))
            time.sleep(0.01)
            self.preRunTime += rospy.Duration(0.01)

        self.SetState(zeroTwist=False)

        rospy.loginfo("\n\n{}\n\tPress space to run rosbag.\n{}\n".format(
            "="*50, "="*50))

        while (self.startTime - self.preRunTime).to_sec() > 0.0 \
                and not self.bagClockStarted:
            self.preRunTime += rospy.Duration(0.01)
            self.SetState(zeroTwist=False)


        rospy.spin()

    def CallBackWaypoints(self, msg):
        # Pre-run clock will stop after getting local path
        self.allowPublishPrevTime = False
        self.waypointsSubscriber.unregister()

    def CallBackClock(self, msg):
        self.lastTime = msg
        if hasattr(self, "startTime"):
            if msg.clock > self.startTime:
                self.bagClockStarted = True
                try:
                    self.clockPublisher.publish(msg)
                except rospy.ROSException as e:
                    rospy.logerr("{} {}".format(self.prefix, e))

if __name__ == "__main__":
    rospy.init_node("rosbag_replay_tool")
    tool = RosBagReplayTool()
    tool.run()
