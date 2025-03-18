#!/usr/bin/env python
import rospy

from simulation_monitor.srv import IdentifyAccident
from simulation_monitor.srv import IdentifyAccidentRequest
from simulation_monitor.srv import IdentifyAccidentResponse
from simulation_monitor.msg import AccidentTypeMatchingResult
from simulation_msgs.msg import CollisionProfile
from __init__ import implemented_accidents

def get_accident_match(req, print_result):
    collision_profile = req.collision_profile

    response = IdentifyAccidentResponse()

    results = []
    
    for accident in implemented_accidents:
        results.append(
            accident.get_matching_result(collision_profile))

    results.sort(
        key=lambda mdict: mdict["responsibility"], reverse=True)

    for res in results:
        matching_result = AccidentTypeMatchingResult(
            res["matched"], res["category"],
            res["type"], res["case"], 
            res["responsibility"], res["notes"])
        response.results.append(matching_result)
    responsibility = results[0]["responsibility"]
    if response.results[0].matched == False:
        response.brief = "no-matching-type"
    else:
        response.brief = "{}-{}-{}"\
            "".format(results[0]["type"], 
                      results[0]["case"], 
                      responsibility>0)

    if print_result: 
        rospy.loginfo("\n{}\n\n".format(response))

    return response


def collision_information_callback(msg, print_result):
    request = IdentifyAccidentRequest()
    request.collision_profile = msg
    response = get_accident_match(request, print_result)

if __name__ == "__main__":
    rospy.init_node("accident_identify_node")
    
    print_result = rospy.get_param("~print_result", True)
    callback = lambda msg: collision_information_callback(
        msg, print_result)
    service_handler = lambda req: get_accident_match(
        req, print_result)

    service = rospy.Service(
        "simulation_monitor/identify_accident", 
        IdentifyAccident, service_handler)
    subscriber = rospy.Subscriber(
        "simulation/collision_profile", CollisionProfile, callback)
    rospy.loginfo("[Accident Identify Node] Start running. "\
        "(Print: {})".format(print_result))
    rospy.spin()
