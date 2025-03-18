#include <path_utils.h>

namespace path {

void ToWaypointsArrayMsg(
    const WaypointsArray &waypointsArray,
    path_msgs::WaypointsArray &outputMsg)
{
    outputMsg.waypoints_array.resize(waypointsArray.size());
    auto inputWaypoints{waypointsArray.cbegin()};
    auto outputWaypoints{outputMsg.waypoints_array.begin()};
    for (; inputWaypoints != waypointsArray.cend();
         ++inputWaypoints, ++outputWaypoints)
    {
        geometry::ToGeometryMsgsArray(
            *inputWaypoints,
            outputWaypoints->points);
    }
}

void ToLaneIdsMsgArray(
    const LaneIdsArray &laneIdsArray,
    std::vector<path_msgs::LaneIds> &outputMsg)
{
    outputMsg.resize(laneIdsArray.size());
    auto laneIds{laneIdsArray.cbegin()};
    auto outputLaneIdsMsg{outputMsg.begin()};
    for (; laneIds != laneIdsArray.cend();
         ++laneIds, ++outputLaneIdsMsg)
    {
        outputLaneIdsMsg->lane_ids.resize(laneIds->size());
        std::copy(
            laneIds->cbegin(),
            laneIds->cend(),
            outputLaneIdsMsg->lane_ids.begin());
    }
}

void ToWaypointsMsgArray(
    const WaypointsArray &waypointsArray,
    std::vector<path_msgs::Waypoints> &outputMsg)
{
    outputMsg.resize(waypointsArray.size());
    auto waypoints{waypointsArray.cbegin()};
    auto outputWaypointsMsg{outputMsg.begin()};
    for (; waypoints != waypointsArray.cend();
         ++waypoints, ++outputWaypointsMsg)
    {
        geometry::ToGeometryMsgsArray(
            *waypoints,
            outputWaypointsMsg->points);
    }
}

void ToRouteWaypointsMsgArray(
    const RouteWaypointsArray &routeWaypointsArray,
    std::vector<path_msgs::RouteWaypoints> &outputMsg)
{
    outputMsg.resize(routeWaypointsArray.size());
    for (int i = 0; i < routeWaypointsArray.size(); i++)
    {
        path_msgs::RouteWaypoints routeWaypoints;
        for (int j = 0; j < routeWaypointsArray[i].size(); j++)
        {
            path_msgs::RouteWaypoint routeWaypoint;
            auto routeWaypointSource = routeWaypointsArray[i][j];
            routeWaypoint.point.x = routeWaypointSource.point.x();
            routeWaypoint.point.y = routeWaypointSource.point.y();
            routeWaypoint.point.z = routeWaypointSource.point.z();
            routeWaypoint.angle = routeWaypointSource.angle;
            routeWaypoint.left_boundary = routeWaypointSource.leftBoundary;
            routeWaypoint.right_boundary = routeWaypointSource.rightBoundary;
            routeWaypoint.curvature = routeWaypointSource.curvature;
            routeWaypoint.slope = routeWaypointSource.slope;
            routeWaypoints.waypoints.push_back(routeWaypoint);
        }
        if (routeWaypoints.waypoints.size())
        {
            outputMsg.push_back(routeWaypoints);
        }
    }
}

} // namespace path {
