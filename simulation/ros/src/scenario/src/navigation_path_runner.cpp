#include <iostream>
#include <mutex>
#include <ros/node_handle.h>
#include <ros/ros.h>
#include <ros/param.h>
#include <ros/rate.h>
#include <ros/console.h>
#include <map_navigation_path.h>
#include <map_navigation_path_config.h>
#include <simulation_srvs/RequestNavigationPath.h>
#include <route_mission_handler/Waypoint.h>
#include <itri_msgs/Waypoint.h>
#include <itri_msgs/WaypointArray.h>
#include <geometry_msgs/Pose2D.h>
#include <math_type.h>
#include <backward.hpp>

namespace nav_runner
{

    std::shared_ptr<map::NavigationPath> navigationPath;
    itri_msgs::WaypointArray             wpArray;
    std::mutex                           wpArrayMutex;

    int GetNearestWaypointIdx(const geometry_msgs::Pose2D pose2d, const path_msgs::RouteWaypoints& waypoints)
    {
        int   nearestIdx  = -1;
        float nearestDist = 0.0;
        for (int i = 0; i < waypoints.waypoints.size(); i++)
        {
            auto wp   = waypoints.waypoints[i].point;
            auto dist = pow(pow(pose2d.x - wp.x, 2) + pow(pose2d.y - wp.y, 2), 0.5);
            if (nearestIdx == -1 || dist < nearestDist)
            {
                nearestIdx  = i;
                nearestDist = dist;
            }
        }
        return nearestIdx;
    }

    bool RequestNavigationPathServiceCallback(simulation_srvs::RequestNavigationPath::Request&  request,
                                              simulation_srvs::RequestNavigationPath::Response& response)
    {
        if (!navigationPath->IsReady())
        {
            ROS_WARN("[NavigationPathRunnerNode] Not ready yet.");
            return false;
        }

        ROS_INFO("[NavigationPathRunnerNode] Get request.");

        geometry_msgs::Pose2D egoPose2D = request.ego_pose;

        // NOTE: It is not sure whether multiple RouteWaypoints will be returned.
        // It should be considered later.
        path_msgs::RouteWaypoints forwardRoute  = navigationPath->GetForwardRouteWaypointsArray()[1];
        path_msgs::RouteWaypoints oppositeRoute = navigationPath->GetOppositeRouteWaypointsArray()[1];

        // int32_t nearestForwardIdx = navigationPath->
        //     SearchNearestForwardWaypoint(egoPose2D);  // Somehow gave wrong result.
        int32_t nearestForwardIdx  = GetNearestWaypointIdx(egoPose2D, forwardRoute);
        int32_t nearestOppositeIdx = navigationPath->SearchNearestOppositeWaypoint(egoPose2D);

        std::cout << "nearestForwardIdx = " << nearestForwardIdx << std::endl;
        std::cout << "nearestOppositeIdx = " << nearestOppositeIdx << std::endl;
        // if (navigationPath->IsIntersection(egoPose2D))
        // {
        //     response.road_type = 3;
        // }
        // else
        // {
        //     float curve = forwardRoute.waypoints[nearestForwardIdx].curvature;
        //     if (abs(curve) < 0.025)
        //     {
        //         response.road_type = 1;
        //     }
        //     else
        //     {
        //         response.road_type = 2;
        //     }
        // }

        int32_t lowerBound                                    = std::max(0, nearestForwardIdx - 50);
        int32_t upperBound                                    = std::min(nearestForwardIdx + 51, int32_t(forwardRoute.waypoints.size()));
        response.nearest_waypoint_idx_on_nearby_forward_route = nearestForwardIdx - lowerBound;
        for (int32_t i = lowerBound; i < upperBound; i++)
        {
            response.nearby_forward_route.push_back(forwardRoute.waypoints[i]);
        }

        lowerBound                                             = std::max(0, nearestOppositeIdx - 50);
        upperBound                                             = std::min(nearestOppositeIdx + 51, int32_t(oppositeRoute.waypoints.size()));
        response.nearest_waypoint_idx_on_nearby_opposite_route = nearestOppositeIdx - lowerBound;
        for (int32_t i = lowerBound; i < upperBound; i++)
        {
            response.nearby_opposite_route.push_back(oppositeRoute.waypoints[i]);
        }

        if (int32_t(wpArray.waypoints.size()))
        {
            std::vector<itri_msgs::Waypoint> wps;

            wpArrayMutex.lock();

            int32_t nearestIdx = 0;
            float   nearestValue =
                pow(egoPose2D.x - wpArray.waypoints[0].pose.pose.position.x, 2) + pow(egoPose2D.y - wpArray.waypoints[0].pose.pose.position.y, 2);

            for (int32_t i = 1; i < int32_t(wpArray.waypoints.size()); i++)
            {
                auto  pos      = wpArray.waypoints[i].pose.pose.position;
                float distance = pow(egoPose2D.x - pos.x, 2) + pow(egoPose2D.y - pos.y, 2);
                if (distance < nearestValue)
                {
                    nearestIdx   = i;
                    nearestValue = distance;
                }
            }

            wpArrayMutex.unlock();

            lowerBound                                         = std::max(0, nearestIdx - 50);
            upperBound                                         = std::min(nearestIdx + 51, int32_t(wpArray.waypoints.size()));
            response.nearest_waypoint_idx_on_current_waypoints = nearestIdx - lowerBound;

            for (int32_t i = lowerBound; i < upperBound; i++)
            {
                wps.push_back(wpArray.waypoints[i]);
            }

            response.current_waypoints.waypoints = wps;
        }

        return true;
    }

    void WaypointCallback(const itri_msgs::WaypointArray& msg)
    {
        wpArrayMutex.lock();

        wpArray.waypoints.clear();
        for (auto i = 0; i < msg.waypoints.size(); i++)
            wpArray.waypoints.push_back(msg.waypoints[i]);

        wpArrayMutex.unlock();
    }

}  // namespace nav_runner

int main(int argc, char** argv)
{
    backward::SignalHandling signalHandling;
    ros::init(argc, argv, "navigation_path_runner_node");
    ros::NodeHandle nodeHandle;

    nav_runner::navigationPath = std::make_shared<map::NavigationPath>();

    std::string map, route;
    ros::param::param<std::string>("route_mission_handler/route", map, "");
    ros::param::param<std::string>("route_mission_handler/fileName", route, "");
    map::NavigationPathConfig navigationPathConfig(map, route);
    nav_runner::navigationPath->Configure(navigationPathConfig);

    ROS_ERROR_STREAM("[navigation_path_runner_node] map: " << map << ", route: " << route);
    ROS_INFO("[navigation_path_runner_node] Done configuration.");

    ros::ServiceServer requestRouteServiceHandler =
        nodeHandle.advertiseService("request_navigation_path", &nav_runner::RequestNavigationPathServiceCallback);

    ros::Subscriber sub = nodeHandle.subscribe("waypoints", 1, nav_runner::WaypointCallback);

    ros::spin();

    return 0;
}
