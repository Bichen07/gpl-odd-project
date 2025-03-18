#ifndef _PATH_EGO_VEHICLE_WAYPOINT_MANAGER_NODE_H_
#define _PATH_EGO_VEHICLE_WAYPOINT_MANAGER_NODE_H_

#include <vector>
#include <ros/ros.h>
#include <itri_msgs/Path.h>
#include <route_mission_handler/Path.h>
#include <geometry_vector_3d.h>
#include <path_msgs/EgoVehicleGlobalPath.h>
#include <path_msgs/BidirectionalRouteWaypointsArray.h>
#include <path/Republishing.h>
#include <path/RequestEgoVehicleGlobalPath.h>
#include <path_type.h>
#include <path_lane_manager.h>
#include <path_waypoint_manager.h>

namespace path {

class EgoVehicleWaypointManagerNode final
{

public:

    EgoVehicleWaypointManagerNode();
    EgoVehicleWaypointManagerNode(const EgoVehicleWaypointManagerNode &) = delete;
    EgoVehicleWaypointManagerNode &operator=(const EgoVehicleWaypointManagerNode &) = delete;
    virtual ~EgoVehicleWaypointManagerNode() = default;

    void Configure();
    bool ExecuteRepublishing(
        Republishing::Request &request,
        Republishing::Response &response);
    bool ExecuteRequestEgoVehicleGlobalPath(
        RequestEgoVehicleGlobalPath::Request &request,
        RequestEgoVehicleGlobalPath::Response &response);

protected:

private:

    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

    void ConnectLaneIdsArray(
        const LaneIds &unorderedLaneIds,
        LaneIdsArray &outputLaneIdsArray);
    bool QueryNextLane(
        const int32_t currentLaneId,
        const LaneIds &candidateLaneIds,
        int32_t &outputNextLaneId) const;
    void ConvertLanesToWaypoints(
        const LaneIdsArray &laneIdsArray,
        WaypointsArray &outputWaypointsArray) const;
    void ConvertLanesToRouteWaypoints(
        const LaneIdsArray &laneIdsArray,
        RouteWaypointsArray &outputRouteWaypointsArray) const;

    void GlobalPathCallback(const itri_msgs::Path &msg);
    void NavigationPathCallback(const route_mission_handler::Path &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mGlobalPathSubscriber;
    ros::Subscriber mNavigationPathSubscriber;
    ros::Publisher mEgoVehicleGlobalPathPublisher;
    ros::Publisher mNavigationDataPublisher;
    ros::Publisher mBidirectionalRouteWaypointsArrayPublisher;
    ros::ServiceServer mRepublishingService;
    ros::ServiceServer mRequestEgoVehicleGlobalPathService;
    LaneManager mLaneManager;
    WaypointManager mWaypointManager;
    std::string mMapId;
    path_msgs::EgoVehicleGlobalPath mEgoVehicleGlobalPathMsg;
    path_msgs::BidirectionalRouteWaypointsArray mBidirectionalRouteWaypointsArrayMsg;
    LaneIdsArray mForwardLaneIdsArray;
    LaneIdsArray mOppositeLaneIdsArray;
    LaneIds mIntersectionLaneIds;
    WaypointsArray mForwardWaypointsArray;
    WaypointsArray mOppositeWaypointsArray;
    RouteWaypointsArray mForwardRouteWaypointsArray;
    RouteWaypointsArray mOppositeRouteWaypointsArray;
};

} // namespace path {

#endif // #ifndef _PATH_EGO_VEHICLE_WAYPOINT_MANAGER_NODE_H_
