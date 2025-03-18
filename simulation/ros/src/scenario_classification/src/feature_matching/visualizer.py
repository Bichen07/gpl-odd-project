#!/usr/bin/env python
from copy import deepcopy
import rospy
import random
from std_msgs.msg import ColorRGBA
from geometry_msgs.msg import Vector3, Point, Pose
from visualization_msgs.msg import Marker, MarkerArray


class FeatureVisualizer:
    def __init__(self):
        self.feature_matches_marker_array_pub = \
            rospy.Publisher("features_matches", MarkerArray, queue_size=1)
        self.seq = 0

    def visualize_feature_matches(
            self,
            tracked,
            value,
            safety_metrics
    ):
        marker_array = MarkerArray()
        for c_id, c_value in value.items():
            if not c_id in tracked:
                continue
            text = ""
            metrics = safety_metrics[c_id]
            for metric, value in metrics.items():
                text += "[{}] {}\n".format(metric, value)
            pose = deepcopy(tracked[c_id].relative_poses[-1].pose)
            text = "({})\n".format(c_id) + text
            red_color = abs(c_value)**(1.0/5)
            green_color = 1 - red_color
            text_marker, point_marker = self._make_markers(
                int(c_id), 'feature_match', text, pose,
                ColorRGBA(red_color, green_color, 0, 1), ColorRGBA(red_color, green_color, 0, 0.5))
            marker_array.markers.append(text_marker)
            marker_array.markers.append(point_marker)
        self.feature_matches_marker_array_pub.publish(marker_array)

    def _make_markers(
            self,               # type: Visualizer
            id,                 # type: int
            ns,                 # type: str
            text,               # type: str
            pose,               # type: Pose
            text_color,         # type: ColorRGBA
            point_color,        # type: ColorRGBA
            lifetime=0.2        # type: float
    ):
        text_marker = Marker()
        text_marker.id = id
        text_marker.header.stamp = rospy.Time.now()
        text_marker.header.frame_id = "base_link"
        text_marker.header.seq = self.seq
        text_marker.type = Marker.TEXT_VIEW_FACING
        text_marker.ns = ns + "_text"
        text_marker.pose = deepcopy(pose)
        text_marker.pose.position.z = 30
        text_marker.scale = Vector3(2, 2, 2)
        text_marker.color = text_color
        text_marker.lifetime = rospy.Duration(lifetime)
        text_marker.text = text
        point_marker = Marker()
        point_marker.id = id
        point_marker.header.stamp = rospy.Time.now()
        point_marker.header.frame_id = "base_link"
        point_marker.header.seq = self.seq
        point_marker.type = Marker.POINTS
        point_marker.ns = ns + "_point"
        point_marker.pose = pose
        point_marker.scale.x = 3
        point_marker.scale.y = 3
        point_marker.color = point_color
        point_marker.lifetime = rospy.Duration(lifetime)
        point_marker.points = [Point()]
        return text_marker, point_marker
