#include <path_planner_node.h>
#include <ros/console.h>

namespace path {

// public func.

PlannerNode::PlannerNode()
    : mNodeHandle{}
    , mDijkstraPlanningService{}
    , mDijkstraInterpolationPlanningService{}
    , mRouteWaypointQueryingService{}
    , mWaypointQueryingService{}
    , mDijkstraPlanner{}
    , mDijkstraInterpolationPlanner{}
    , mWaypointManager{}
    , mMapId{}
{
    mDijkstraPlanningService = mNodeHandle.advertiseService(
        "path/dijkstra_planning",
        &PlannerNode::ExecuteDijkstraPlanning,
        this);
    mDijkstraInterpolationPlanningService = mNodeHandle.advertiseService(
        "path/dijkstra_interpolation_planning",
        &PlannerNode::ExecuteDijkstraInterpolationPlanning,
        this);
    mRouteWaypointQueryingService = mNodeHandle.advertiseService(
        "path/route_waypoint_querying",
        &PlannerNode::ExecuteRouteWaypointQuerying,
        this);
    mWaypointQueryingService = mNodeHandle.advertiseService(
        "path/waypoint_querying",
        &PlannerNode::ExecuteWaypointQuerying,
        this);
}

void PlannerNode::Configure()
{
    ros::param::get(
        "route_mission_handler/route",
        mMapId);
    if (mMapId.empty())
    {
        ROS_ERROR_STREAM("mMapId is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    const std::string lanesInfoFileName =
        std::string(MAP_DATA_DIR) +
        mMapId +
        std::string("/lanes_info.json");
    const std::string waypointFileName =
        std::string(MAP_DATA_DIR) +
        mMapId +
        std::string("/waypoints.json");
    mDijkstraPlanner.Configure(lanesInfoFileName);
    mWaypointManager.Configure(
        waypointFileName,
        lanesInfoFileName);
}

bool PlannerNode::ExecuteDijkstraPlanning(
    DijkstraPlanning::Request &request,
    DijkstraPlanning::Response &response)
{
    std::vector<int32_t> plannedLaneIds;
    mDijkstraPlanner.Compute(
        request.begin_waypoint_id.lane,
        std::vector<int32_t>(request.via_lane_ids),
        request.end_waypoint_id.lane,
        plannedLaneIds);
    const auto plannedWaypoints{
        mWaypointManager.QueryWaypoints(
            plannedLaneIds,
            request.begin_waypoint_id.point,
            request.end_waypoint_id.point)};
    response.planned_lane_ids.resize(plannedLaneIds.size());
    std::copy(
        plannedLaneIds.cbegin(),
        plannedLaneIds.cend(),
        response.planned_lane_ids.begin());
    response.planned_waypoints.resize(plannedWaypoints.size());
    std::transform(
        plannedWaypoints.cbegin(),
        plannedWaypoints.cend(),
        response.planned_waypoints.begin(),
        [](const geometry::Vector3d &input)
        {return input.ToPoint();});

    return true;
}

bool PlannerNode::ExecuteDijkstraInterpolationPlanning(
    DijkstraInterpolationPlanning::Request &request,
    DijkstraInterpolationPlanning::Response &response)
{
    std::vector<LanePair> inputLanePairs;
    path::ToLanePairs(
        request.lane_pairs,
        inputLanePairs);
    std::vector<LanePairPlannedOutput> plannedOutputs;
    mDijkstraInterpolationPlanner.Compute(
        path::ToWaypointId(request.begin_waypoint_id),
        inputLanePairs,
        path::ToWaypointId(request.end_waypoint_id),
        plannedOutputs);
    path::ToLanePairPlannedOutputMsgs(
        plannedOutputs,
        response.planned_outputs);
}

bool PlannerNode::ExecuteRouteWaypointQuerying(
    RouteWaypointQuerying::Request &request,
    RouteWaypointQuerying::Response &response)
{
    const auto queriedRouteWaypoint{
        mWaypointManager.QueryRouteWaypoint(
            WaypointId(
                request.waypoint_id.lane,
                request.waypoint_id.point))};
    response.route_waypoint.point = queriedRouteWaypoint.point.ToPoint();
    response.route_waypoint.angle = queriedRouteWaypoint.angle;

    return true;
}

bool PlannerNode::ExecuteWaypointQuerying(
    WaypointQuerying::Request &request,
    WaypointQuerying::Response &response)
{
    const auto queriedWaypoint{
        mWaypointManager.QueryWaypoint(
            WaypointId(
                request.waypoint_id.lane,
                request.waypoint_id.point))};
    response.waypoint = queriedWaypoint.ToPoint();

    return true;
}

// protected func.

// private func.

} // namespace path {
