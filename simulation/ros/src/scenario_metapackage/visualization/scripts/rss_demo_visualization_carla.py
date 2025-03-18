#!/usr/bin/env python
import numpy as np
import rospy
from std_msgs.msg import ColorRGBA
from geometry_msgs.msg import Pose, Point, Quaternion, Vector3
from rss_msgs.msg import CheckResult, CheckResultObjectState
from scenario_msgs.msg import AgentData, AgentDataArray
from itri_msgs.msg import CarState
from visualization_msgs.msg import Marker, MarkerArray
import os, sys

if 'CARLA_DIST' in os.environ:
    sys.path.append(os.environ["CARLA_DIST"])
    import carla
else:
    try:
        import carla
    except:
        sys.exit("please add an environment variable "\
            "'CARLA_DIST' for CARLA .egg file.")

from simulation_utils.converter import QuaternionToVector3
from simulation_utils.vector_utils import unify
from simulation_utils.vector_utils import vector3_add, vector3_sub, vector3_mul, to_point, get_dist

EGO_LENGTH = 7.17

class RssDemoVisualization:
	def __init__(self):
		self.rss_check_result_msg = None
		self.rss_check_result_subscriber = rospy.Subscriber(
			"rss/check_result", CheckResult, self.cb_rss_check_result)
		self.agent_data_array_msg = None
		self.agent_center = {}  # id: Point
		self.rss_safety_states = {}
		self.agent_id_to_marker_id = {}
		self.agent_data_array_subscriber = rospy.Subscriber(
			"/simulation/agent_data_array", AgentDataArray, self.cb_agent_data_array)
		self.car_state_msg = None
		self.ego_front = Point()
		self.ego_center = Point()
		self.car_state_subscriber = rospy.Subscriber(
			"car_state", CarState, self.cb_car_state)
		self.marker_publisher = rospy.Publisher(
			"rss/demo_visualization", MarkerArray, queue_size=1)
		self.begin = False
		self.client = carla.Client("localhost", 2000)
		self.world = self.client.get_world()
		self.debug = self.world.debug

	def run(self):
		rate = rospy.Rate(100)
		while not rospy.is_shutdown():
			is_done = self.run_once()
			if is_done:
				break
			rate.sleep()

	def get_short_line(self, point1, point2, length=1.0):
		line1 = [Point(), Point()]
		line2 = [Point(), Point()]
		vec = unify(Vector3(
			point1.x - point2.x,
			point1.y - point2.y,
			0))
		vert_line1 = Vector3(vec.y, -vec.x, 0)
		vert_line2 = Vector3(-vec.y, vec.x, 0)
		line1[0] = to_point(vector3_add(point1, vector3_mul(vert_line1, length)))
		line1[1] = to_point(vector3_add(point1, vector3_mul(vert_line2, length)))
		line2[0] = to_point(vector3_add(point2, vector3_mul(vert_line1, length)))
		line2[1] = to_point(vector3_add(point2, vector3_mul(vert_line2, length)))
		return line1, line2

	def run_once(self):
		if self.agent_center:
			print("detected_objects: {}".format(self.agent_center.keys()))
			print("rss: {}".format(self.rss_safety_states.keys()))
			print()
			for key, val in self.agent_center.items():
				if key in self.rss_safety_states.keys():
					if self.rss_safety_states[key] == 2:
						self.debug.draw_point(carla.Location(val.x, -val.y, 2.5), 0.05, carla.Color(255, 0, 0, 255), life_time=0.01)
					elif self.rss_safety_states[key] == 1:
						self.debug.draw_point(carla.Location(val.x, -val.y, 2.5), 0.05, carla.Color(255, 128, 0, 255), life_time=0.01)
					else:
						self.debug.draw_point(carla.Location(val.x, -val.y, 2.5), 0.05, carla.Color(0, 255, 0, 255), life_time=0.01)
		return False

	def cb_rss_check_result(self, msg):
		self.rss_check_result_msg = msg
		for obj in msg.object_states:
			doid = obj.detected_object_id
			# safety = max(obj.structured_safety.status, obj.unstructured_safety.status)
			safety = obj.structured_safety.status
			self.rss_safety_states[str(doid)] = safety

	def cb_agent_data_array(self, msg):
		if len(msg.id_list) > 1:
			self.agent_center = {}
			for m in msg.data:
				if "ego" not in m.agent_id:
					m.pose.orientation.z = QuaternionToVector3(m.pose.orientation, two_d=True).z
					m.pose.orientation.w = 0

					center = Point()
					center.x = m.pose.position.x
					center.y = m.pose.position.y

					self.agent_center[str(m.agent_id.split("/")[-1])] = center
					if m.agent_id not in self.agent_id_to_marker_id.keys():
						self.agent_id_to_marker_id[m.agent_id] = len(self.agent_id_to_marker_id)
			self.agent_data_array_msg = msg

	def cb_car_state(self, msg):
		self.car_state_msg = msg
		self.ego_center.x = msg.pose.pose.position.x + (EGO_LENGTH / 2.0 + 1.0) * np.cos(msg.pose.pose.orientation.z)
		self.ego_center.y = msg.pose.pose.position.y + (EGO_LENGTH / 2.0 + 1.0) * np.sin(msg.pose.pose.orientation.z)

if __name__ == '__main__':
	rospy.init_node("rss_demo_visualization")
	rdv = RssDemoVisualization()
	rdv.run()