#ifndef _PATH_UTILS_H_
#define _PATH_UTILS_H_

#include <path_msgs/LaneIds.h>
#include <path_msgs/Waypoints.h>
#include <path_msgs/WaypointsArray.h>
#include <path_msgs/RouteWaypointsArray.h>
#include <path_type.h>

namespace path {

void ToWaypointsArrayMsg(
    const WaypointsArray &waypointsArray,
    path_msgs::WaypointsArray &outputMsg);
void ToLaneIdsMsgArray(
    const LaneIdsArray &laneIdsArray,
    std::vector<path_msgs::LaneIds> &outputMsg);
void ToWaypointsMsgArray(
    const WaypointsArray &waypointsArray,
    std::vector<path_msgs::Waypoints> &outputMsg);
void ToRouteWaypointsMsgArray(
    const RouteWaypointsArray &routeWaypointsArray,
    std::vector<path_msgs::RouteWaypoints> &outputMsg);

} // namespace path {

#endif // #ifndef _PATH_UTILS_H_
