import json
import rospy


def get_odd_search_config():
    odd_search_config_dir = rospy.get_param(
        "~odd_search_config_dir",
        "/project/mmsl_simulation/src/scenario_search/data/odd_search_config.json",
    )
    assert rospy.has_param("scenario/id")
    scenario_id = rospy.get_param("scenario/id")
    vehicle = rospy.get_param("behavior/vehicle")
    route = rospy.get_param("route_mission_handler/route")
    file_name = rospy.get_param("route_mission_handler/fileName")
    with open(odd_search_config_dir, "r") as f:
        data = json.load(f)
    if scenario_id in data.keys():
        data = data[scenario_id]
        assert vehicle == data["vehicle"]
        assert route == data["route"], "{} / {}".format(route, data["route"])
        assert file_name == data["fileName"]
    else:
        raise ValueError("Scenario ID {} not found." "".format(scenario_id))
    return data


def get_scenario_config():
    scenario_id = rospy.get_param("scenario/id")
    scenario_dir = rospy.get_param("scenario/config/dir")
    scenario_file = rospy.get_param("scenario/config/file")
    scenario_file = scenario_dir + scenario_file
    with open(scenario_file, "r") as f:
        config = json.load(f)
    full_name = config[scenario_id]
    keys = config.keys()
    for k in keys:
        if k not in [full_name, scenario_id, "ego_vehicle"]:
            del config[k]
    return full_name, config
