#ifndef _PATH_PLANNER_NODE_H_
#define _PATH_PLANNER_NODE_H_

#include <ros/ros.h>
#include <path/DijkstraPlanning.h>
#include <path/DijkstraInterpolationPlanning.h>
#include <path/RouteWaypointQuerying.h>
#include <path/WaypointQuerying.h>
#include <path_dijkstra_planner.h>
#include <path_dijkstra_interpolation_planner.h>
#include <path_waypoint_manager.h>

namespace path {

class PlannerNode final
{

public:

    PlannerNode();
    PlannerNode(const PlannerNode &) = delete;
    PlannerNode &operator=(const PlannerNode &) = delete;
    virtual ~PlannerNode() = default;

    void Configure();
    bool ExecuteDijkstraPlanning(
        DijkstraPlanning::Request &request,
        DijkstraPlanning::Response &response);
    bool ExecuteDijkstraInterpolationPlanning(
        DijkstraInterpolationPlanning::Request &request,
        DijkstraInterpolationPlanning::Response &response);
    bool ExecuteRouteWaypointQuerying(
        RouteWaypointQuerying::Request &request,
        RouteWaypointQuerying::Response &response);
    bool ExecuteWaypointQuerying(
        WaypointQuerying::Request &request,
        WaypointQuerying::Response &response);

protected:

private:

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mDijkstraPlanningService;
    ros::ServiceServer mDijkstraInterpolationPlanningService;
    ros::ServiceServer mRouteWaypointQueryingService;
    ros::ServiceServer mWaypointQueryingService;
    DijkstraPlanner mDijkstraPlanner;
    DijkstraInterpolationPlanner mDijkstraInterpolationPlanner;
    WaypointManager mWaypointManager;
    std::string mMapId;
};

} // namespace path {

#endif // #ifndef _PATH_GENERATION_NODE_H_
