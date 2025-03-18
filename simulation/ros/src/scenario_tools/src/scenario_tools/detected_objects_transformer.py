#!/usr/bin/env python
import copy

import rospy
import numpy as np
import json
from itri_msgs.msg import DetectedObject, DetectedObjectArray
from geometry_msgs.msg import Transform, TransformStamped
from geometry_msgs.msg import Pose, PoseStamped, Quaternion
from geometry_msgs.msg import Vector3, Vector3Stamped
from geometry_msgs.msg import Point32, Point, PointStamped
from geometry_msgs.msg import PolygonStamped
from jsk_recognition_msgs.msg import PolygonArray
import tf2_geometry_msgs
import tf2_ros

class DetectedObjectsTransformer:

    def __init__(self):
        self.replay_rate = rospy.get_param("~replay_rate")
        self.transform_predicted_poses = rospy.get_param("~transform_predicted_poses")
        self.transform_linear_velocity = rospy.get_param("~transform_linear_velocity")
        self.max_sensor_range = rospy.get_param("~max_sensor_range")
        self.mappings = self.GetMappings()
        self.filtered_cluster_hulls_publisher = rospy.Publisher(
            "/filtered_cluster_hulls", PolygonArray, queue_size=1)
        self.publisher = rospy.Publisher(  # This will be sent to sim_adv
            "/detected_objects", DetectedObjectArray, queue_size=1)
        self.subscriber = rospy.Subscriber(
            "/detected_objects_old", DetectedObjectArray, self.Callback, self.publisher)
        self.publisher_prediction = rospy.Publisher(  # This will be sent to sim_adv
            "/detected_objects_prediction", DetectedObjectArray, queue_size=1)
        self.subscriber_prediction = rospy.Subscriber(
            "/detected_objects_prediction_old", DetectedObjectArray, self.Callback, self.publisher_prediction)
        self.tfBuffer = tf2_ros.Buffer(rospy.Duration(10.0))
        self.tfListener = tf2_ros.TransformListener(self.tfBuffer)
        self.startTime = None

        rospy.loginfo("\033[1;36m[DetectedObjectsTransformer] Configs:\n" +
            "\tGeneral:\n" +
            "\t\tReplay Rate: {}\n".format(self.replay_rate) +
            "\t\ttransform_predicted_poses: {}\n".format(self.transform_predicted_poses) +
            "\t\ttransform_linear_velocity: {}\n".format(self.transform_linear_velocity) +
            "\t\tMax Sensor Range: {}\n".format(self.max_sensor_range) +
            "\tFrame Mappings: (new: origin)\n" +
            "\t{}\n".format(json.dumps(self.mappings, indent=4).replace("\n", "\n\t")) +
            "\033[0m"
        )


    def GetMappings(self):
        mappings = rospy.get_param("/tf_remapper/mappings")
        newMappings = {}
        """
        Convert original format of
        [{"old": OLD_NAME1, "new": NEW_NAME1},
         {"old": OLD_NAME2, "new": NEW_NAME2},
         {"old": OLD_NAME3, "new": NEW_NAME3}]
        to
        {"OLD_NAME1": "NEW_NAME1",
         "OLD_NAME2": "NEW_NAME2",
         "OLD_NAME3": "NEW_NAME3"}
        """
        for item in mappings:
            newMappings[item["old"]] = item["new"]
        return newMappings

    def TransformDetectedObjectsArray(self, objs):
        frame = objs.header.frame_id or "base_link"
        origin_frame = self.mappings[frame]
        if frame[0] == '/':
            frame = frame[1:]
        if origin_frame[0] == '/':
            origin_frame = origin_frame[1:]

        polygonArray = PolygonArray()
        polygonArray.header = objs.header

        idx_to_remove = []
        try:
            transform = self.tfBuffer.lookup_transform(
                frame, origin_frame, rospy.Time())

            for i, obj in enumerate(objs.objects):
                objPoseStamped = PoseStamped(obj.header, obj.pose)

                # Transform Pose
                poseTransformed = tf2_geometry_msgs.do_transform_pose(objPoseStamped, transform)
                if poseTransformed.pose.position.x ** 2 + poseTransformed.pose.position.y ** 2 > self.max_sensor_range ** 2:
                    idx_to_remove.append(i)
                    continue

                # Transform Convex Hull
                points = []
                for j, pt in enumerate(obj.convex_hull.polygon.points):
                    objPointStamped = PointStamped(obj.header, pt)
                    pointTransformed = tf2_geometry_msgs.do_transform_point(objPointStamped, transform)
                    p = pointTransformed.point
                    points.append(Point32(p.x, p.y, p.z))


                # Transform Predicted Poses and paths by shifting
                # This will be very slow to process, use rate < 0.5 to play the rosbag will be better.
                if self.transform_predicted_poses:
                    predicted_poses = []
                    for j, pt in enumerate(obj.predicted_poses):
                        objPointStamped = PointStamped(obj.header, pt)
                        pointTransformed = tf2_geometry_msgs.do_transform_point(objPointStamped, transform)
                        p = pointTransformed.point
                        predicted_poses.append(Point(p.x, p.y, p.z))

                    # Transform Linear Velocity
                    if self.transform_linear_velocity:
                        vectorEnd = Vector3Stamped(obj.header, obj.velocity.linear)
                        vectorStart = Vector3Stamped(obj.header, Vector3(0., 0., 0.))
                        vectorEndTransformed = tf2_geometry_msgs.do_transform_vector3(vectorEnd, transform)
                        vectorStartTransformed = tf2_geometry_msgs.do_transform_vector3(vectorStart, transform)
                        objs.objects[i].velocity.linear = Vector3(
                            vectorEndTransformed.vector.x - vectorStartTransformed.vector.x,
                            vectorEndTransformed.vector.y - vectorStartTransformed.vector.y,
                            vectorEndTransformed.vector.z - vectorStartTransformed.vector.z)

                objs.objects[i].pose = poseTransformed.pose
                objs.objects[i].convex_hull.polygon.points = points
                objs.objects[i].predicted_poses = predicted_poses
                polygonArray.polygons.append(PolygonStamped(obj.header, objs.objects[i].convex_hull.polygon))

        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException) as e:
            rospy.logwarn_throttle(5, e)

        for idx in sorted(idx_to_remove, reverse=True):
            del objs.objects[idx]

        return objs, polygonArray


    def Callback(self, objs, publisher):
        newDetectedObjectsArray, polygonArray = self.TransformDetectedObjectsArray(objs)
        try:
            if self.startTime:
                if newDetectedObjectsArray.header.stamp.to_sec() > self.startTime:
                    publisher.publish(newDetectedObjectsArray)
                    if publisher == self.publisher:
                        self.filtered_cluster_hulls_publisher.publish(polygonArray)
            else:
                self.startTime = rospy.get_param("/rosbag_replay_tool/startTime", None)
        except rospy.ROSException as e:
            rospy.logerr("[detected_objects_transformer] {}".format(e))



    def run(self):
        rospy.spin()

if __name__ == '__main__':
    rospy.init_node("detected_objects_transformer_node")
    remapper = DetectedObjectsTransformer()
    remapper.run()