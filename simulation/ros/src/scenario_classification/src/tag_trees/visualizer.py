#!/usr/bin/env python
from copy import deepcopy
import rospy
from std_msgs.msg import ColorRGBA
from geometry_msgs.msg import PoseStamped, Vector3, Point, Pose
from scenario_classification.msg import ClassificationObject
from scenario_classification.msg import ClassificationObjectArray
from scenario_classification.msg import TagTrees
from scenario_classification.msg import TagCarriagewayUserType
from scenario_classification.msg import TagInitialState
from scenario_classification.msg import TagLateralActivity
from scenario_classification.msg import TagLongitudinalActivity
from scenario_classification.msg import TagLeadVehicle
from scenario_classification.msg import TagRoadLayout
from visualization_msgs.msg import Marker, MarkerArray
from matcher import Matcher


EGO_SHOW_ITEM = {
    "lateral_activity": True,
    "longitudinal_activity": True,
}
AGENT_SHOW_ITEM = {
    "road_layout": False,
    "carriage_way_user_type": False,
    "initial_state": True,
    "lateral_activity": True,
    "longitudinal_activity": True,
    "lead_vehicle": True
}

MSG_CLS_NOT_RELEVENT_STARTERS = [
    # "deserialize", "deserialize_numpy",
    # "serialize", "serialize_numpy"
]


class Visualizer:
    def __init__(self):
        self.tag_trees_marker_array_pub = rospy.Publisher(
            "tag_trees", MarkerArray, queue_size=1)
        self.matches_marker_array_pub = rospy.Publisher(
            "tag_trees_matches", MarkerArray, queue_size=1)
        self.agent_show_item = AGENT_SHOW_ITEM
        self.ego_show_item = EGO_SHOW_ITEM
        self.seq = 0

    def visuzalize_matches(
            self,       # type: Visualizer
            tracked,    # type: dict[str, ClassificationObject]
            matcher     # type: Matcher
            ):
        marker_array = MarkerArray()
        for c_id, indices in matcher.matched_category_indices.items():
            if not c_id in tracked or len(indices) == 0:
                continue
            pose = deepcopy(tracked[c_id].relative_poses[-1].pose)
            text = "[id: {}, In Scenario Category]:\n".format(c_id)
            for index in indices:
                scenario_category = matcher.scenario_categories[index]
                text += "{}\n".format(scenario_category['name'])
            text_marker, point_marker = self._make_markers(
                int(c_id), 'tag_trees_match', text, pose,
                ColorRGBA(0.6, 0.6, 1, 1), ColorRGBA(0, 0, 1, 0.5))
            marker_array.markers.append(text_marker)
            marker_array.markers.append(point_marker)
        self.matches_marker_array_pub.publish(marker_array)

    def visualize_tag_trees(
            self,       # type: Visualizer
            tracked,    # type: dict[str, ClassificationObject]
            ego_obj     # type: ClassificationObject
            ):
        marker_array = MarkerArray()
        for c_id, c_obj in tracked.items():
            pose = deepcopy(c_obj.relative_poses[-1].pose)
            viz_string = self.get_tag_trees_viz_string(c_obj)
            viz_string = "({})".format(c_id) + viz_string
            text_marker, point_marker = self._make_markers(
                int(c_id), 'tag_trees', viz_string, pose,
                ColorRGBA(1, 1, 1, 0.5), ColorRGBA(1, 1, 1, 0.3))
            marker_array.markers.append(text_marker)
            marker_array.markers.append(point_marker)
        if ego_obj and len(ego_obj.relative_poses):
            pose = Pose()
            pose.position = Point(0, 0, 0)
            viz_string = self.get_tag_trees_viz_string(ego_obj)
            text_marker, point_marker = self._make_markers(
                int(ego_obj.id), 'tag_trees', viz_string, pose,
                ColorRGBA(1, 1, 1, 0.5), ColorRGBA(1, 1, 1, 0.3))
            marker_array.markers.append(text_marker)
            marker_array.markers.append(point_marker)
        self.tag_trees_marker_array_pub.publish(marker_array)

    def get_tag_trees_viz_string(self, obj):
        # type: (Visualizer, ClassificationObject) -> str
        is_ego = obj.label == "ego"
        msg_tag_trees = obj.tag_trees
        viz_string = ""
        show_item = self.ego_show_item if is_ego else self.agent_show_item
        for key, value in show_item.items():
            if not value: continue
            if key in msg_tag_trees.__slots__:
                viz_string += "[ {} ]\n".format(key)
                tag_tree = msg_tag_trees.__getattribute__(key)
                default_map = self._make_default_reverse_mapping(tag_tree)
                for tag_leaf_name in tag_tree.__slots__:
                    leaf = tag_tree.__getattribute__(tag_leaf_name)
                    leaf_type = type(leaf)
                    if leaf_type is bool:
                        viz_string += "{}: {}\n".format(tag_leaf_name, leaf)
                    else:
                        tag_leaf_name_starter = tag_leaf_name.split("_")[0]
                        mapped_value = default_map[tag_leaf_name_starter][leaf]
                        if mapped_value != "UNKNOWN":
                            if tag_leaf_name_starter in ["primary", "secondary"]:
                                viz_string += "{} ".format(default_map[tag_leaf_name_starter][leaf].lower())
                            else:
                                viz_string += "{}: {}\n".format(
                                    tag_leaf_name_starter,
                                    default_map[tag_leaf_name_starter][leaf].lower())
                viz_string += "\n\n"
            else:
                raise ValueError("[scen_cls_viz] Unknown key: {}".format(key))
        return viz_string

    def _make_default_reverse_mapping(self, tree):
        reverse_map = {}
        for member in dir(tree):
            if member.startswith("_"): continue
            if member in MSG_CLS_NOT_RELEVENT_STARTERS: continue
            if member[0].islower(): continue

            tag_starter = member.split("_")[0].lower()
            if tag_starter not in reverse_map.keys():
                reverse_map[tag_starter] = {}
            val = tree.__getattribute__(member)
            name = member.replace("{}_".format(tag_starter.upper()), "")
            # print(reverse_map, reverse_map[tag_starter])
            # print(reverse_map)
            reverse_map[tag_starter][val] = name
        return reverse_map

    def _make_markers(
            self,               # type: Visualizer
            id,                 # type: int
            ns,                 # type: str
            text,               # type: str
            pose,               # type: Pose
            text_color,         # type: ColorRGBA
            point_color,        # type: ColorRGBA
            lifetime=0.5        # type: float
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
        point_marker.points = [ Point() ]
        return text_marker, point_marker
