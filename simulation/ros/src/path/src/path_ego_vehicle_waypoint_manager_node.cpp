#include <path_ego_vehicle_waypoint_manager_node.h>
#include <limits>
#include <ros/console.h>
#include <utils_ros_param.h>
#include <path_msgs/EgoVehicleGlobalPath.h>
#include <path_msgs/NavigationData.h>
#include <path_msgs/RouteWaypoint.h>
#include <path_utils.h>

namespace path {

// public func.

EgoVehicleWaypointManagerNode::EgoVehicleWaypointManagerNode()
    : mNodeHandle{}
    , mGlobalPathSubscriber{}
    , mNavigationPathSubscriber{}
    , mEgoVehicleGlobalPathPublisher{}
    , mNavigationDataPublisher{}
    , mRepublishingService{}
    , mRequestEgoVehicleGlobalPathService{}
    , mLaneManager{}
    , mWaypointManager{}
    , mMapId{}
    , mEgoVehicleGlobalPathMsg{}
    , mBidirectionalRouteWaypointsArrayMsg{}
    , mForwardLaneIdsArray{}
    , mOppositeLaneIdsArray{}
    , mIntersectionLaneIds{}
    , mForwardWaypointsArray{}
    , mOppositeWaypointsArray{}
{
    mGlobalPathSubscriber = mNodeHandle.subscribe(
        "global_path",
        DefaultQueueSize(),
        &EgoVehicleWaypointManagerNode::GlobalPathCallback,
        this);
    mNavigationPathSubscriber = mNodeHandle.subscribe(
        "navigation_path",
        DefaultQueueSize(),
        &EgoVehicleWaypointManagerNode::NavigationPathCallback,
        this);
    mEgoVehicleGlobalPathPublisher = mNodeHandle.advertise<path_msgs::EgoVehicleGlobalPath>(
        "path/ego_vehicle_global_path",
        DefaultQueueSize());
    mNavigationDataPublisher = mNodeHandle.advertise<path_msgs::NavigationData>(
        "path/navigation_data",
        DefaultQueueSize());
    mBidirectionalRouteWaypointsArrayPublisher = mNodeHandle.advertise<
        path_msgs::BidirectionalRouteWaypointsArray>(
        "path/bidirectional_route_waypoint_array",
        DefaultQueueSize());
    mRepublishingService = mNodeHandle.advertiseService(
        "path/republishing",
        &EgoVehicleWaypointManagerNode::ExecuteRepublishing,
        this);
    mRequestEgoVehicleGlobalPathService = mNodeHandle.advertiseService(
        "path/request_ego_vehicle_global_path",
        &EgoVehicleWaypointManagerNode::ExecuteRequestEgoVehicleGlobalPath,
        this);
}

void EgoVehicleWaypointManagerNode::Configure()
{
    mMapId = utils::GetRosParam<std::string>("route_mission_handler/route");
    if (mMapId.empty())
    {
        ROS_ERROR_STREAM("mMapId is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const std::string lanesInfoFileName =
        std::string(MAP_DATA_DIR) +
        mMapId +
        std::string("/lanes_info.json");
    const std::string lanesNavgRoadFileName =
        std::string(MAP_DATA_DIR) +
        mMapId +
        std::string("/lanes_navgroads.json");
    mLaneManager.Configure(
        lanesInfoFileName,
        lanesNavgRoadFileName);

    const std::string waypointFileName =
        std::string(MAP_DATA_DIR) +
        mMapId +
        std::string("/waypoints.json");
    mWaypointManager.Configure(
        waypointFileName,
        lanesInfoFileName);
}

bool EgoVehicleWaypointManagerNode::ExecuteRepublishing(
    Republishing::Request &request,
    Republishing::Response &response)
{
    if (request.can_republish_ego_vehicle_global_path)
    {
        mEgoVehicleGlobalPathPublisher.publish(mEgoVehicleGlobalPathMsg);
    }

    return true;
}

bool EgoVehicleWaypointManagerNode::ExecuteRequestEgoVehicleGlobalPath(
    RequestEgoVehicleGlobalPath::Request &request,
    RequestEgoVehicleGlobalPath::Response &response)
{
    if (mEgoVehicleGlobalPathMsg.lane_ids.size())
    {
        response.ego_vehicle_global_path = mEgoVehicleGlobalPathMsg;
    }

    return true;
}

// protected func.

// private func.

void EgoVehicleWaypointManagerNode::ConnectLaneIdsArray(
    const LaneIds &unorderedLaneIds,
    std::vector<LaneIds> &outputLaneIdsArray)
{
    static constexpr bool canShowUnorderedLaneIds{false};
    if (canShowUnorderedLaneIds)
    {
        ROS_DEBUG_STREAM_COND(
            true,
            "unorderedLaneIds");
        std::copy(
            unorderedLaneIds.cbegin(),
            unorderedLaneIds.cend(),
            std::ostream_iterator<int32_t>(std::cout, ", "));
        std::cout << std::endl;
    }

    static constexpr std::size_t setSizeHint{10ul};
    outputLaneIdsArray.clear();
    outputLaneIdsArray.reserve(setSizeHint);
    auto unorderedLaneId{unorderedLaneIds.cbegin()};
    outputLaneIdsArray.push_back(std::vector<int32_t>(1ul, *unorderedLaneId));
    ++unorderedLaneId;
    for (; unorderedLaneId != unorderedLaneIds.cend(); ++unorderedLaneId)
    {
        auto foundConnectedLaneIds{
            std::find_if(
                outputLaneIdsArray.begin(),
                outputLaneIdsArray.end(),
                [&unorderedLaneId, this](const LaneIds &laneIds)
                {
                    return mLaneManager.IsConnectedLaneIdPair(
                        laneIds.back(),
                        *unorderedLaneId);
                })};
        if (outputLaneIdsArray.end() == foundConnectedLaneIds)
        {
            outputLaneIdsArray.push_back(LaneIds(1ul, *unorderedLaneId));
        }
        else
        {
            foundConnectedLaneIds->push_back(*unorderedLaneId);
        }
    }

    outputLaneIdsArray.shrink_to_fit();
}

bool EgoVehicleWaypointManagerNode::QueryNextLane(
    const int32_t currentLaneId,
    const LaneIds &candidateLaneIds,
    int32_t &outputNextLaneId) const
{
    const LaneIds nextLaneIds{
        mWaypointManager.QueryNextLaneIds(currentLaneId)};
    bool hasNextLaneId{false};

    for (const auto &nextLaneId: nextLaneIds)
    {
        const auto foundLaneId{
            std::find(
                candidateLaneIds.cbegin(),
                candidateLaneIds.cend(),
                nextLaneId)};

        if (candidateLaneIds.cend() != foundLaneId)
        {
            outputNextLaneId = nextLaneId;
            hasNextLaneId = true;
            break;
        }
    }

    return hasNextLaneId;
}

void EgoVehicleWaypointManagerNode::ConvertLanesToRouteWaypoints(
    const std::vector<LaneIds> &laneIdsArray,
    RouteWaypointsArray &outputRouteWaypoints) const
{
    outputRouteWaypoints.clear();
    outputRouteWaypoints.resize(laneIdsArray.size());
    auto laneIds{laneIdsArray.cbegin()};
    auto routeWaypoints{outputRouteWaypoints.begin()};
    for (; laneIds != laneIdsArray.cend(); ++laneIds, ++routeWaypoints)
    {
        *routeWaypoints = mWaypointManager.QueryRouteWaypoints(*laneIds);
    }
}


void EgoVehicleWaypointManagerNode::ConvertLanesToWaypoints(
    const std::vector<LaneIds> &laneIdsArray,
    std::vector<Waypoints> &outputWaypointsArray) const
{
    outputWaypointsArray.clear();
    outputWaypointsArray.resize(laneIdsArray.size());
    auto laneIds{laneIdsArray.cbegin()};
    auto waypoints{outputWaypointsArray.begin()};
    for (; laneIds != laneIdsArray.cend(); ++laneIds, ++waypoints)
    {
        *waypoints = mWaypointManager.QueryWaypoints(*laneIds);
    }
}

void EgoVehicleWaypointManagerNode::GlobalPathCallback(const itri_msgs::Path &msg)
{
    ROS_DEBUG_STREAM_COND(
        false,
        "EgoVehicleWaypointManagerNode::GlobalPathCallback");
    if (msg.waypoints.empty())
    {
        ROS_WARN_STREAM("ego-vehicle's global path is empty");
    }

    mEgoVehicleGlobalPathMsg.lane_ids.clear();
    mEgoVehicleGlobalPathMsg.waypoints.clear();
    mEgoVehicleGlobalPathMsg.lane_ids.reserve(std::size_t{100});
    mEgoVehicleGlobalPathMsg.waypoints.resize(msg.waypoints.size());

    auto inputWaypoint{msg.waypoints.cbegin()};
    auto outputWaypoint{mEgoVehicleGlobalPathMsg.waypoints.begin()};
    mEgoVehicleGlobalPathMsg.lane_ids.push_back(inputWaypoint->lane_id);
    for (; inputWaypoint != msg.waypoints.cend();
         ++inputWaypoint, ++outputWaypoint)
    {
        *outputWaypoint = inputWaypoint->pose.pose.position;
        if (mEgoVehicleGlobalPathMsg.lane_ids.back() != inputWaypoint->lane_id)
        {
            mEgoVehicleGlobalPathMsg.lane_ids.push_back(inputWaypoint->lane_id);
        }

        path_msgs::RouteWaypoint waypoint;
        waypoint.point = inputWaypoint->pose.pose.position;
        waypoint.angle = inputWaypoint->heading;
    }

    mEgoVehicleGlobalPathMsg.lane_ids.shrink_to_fit();

    ROS_DEBUG_STREAM_COND(
        false,
        "ego-vehicle global path lane id size: " <<
        mEgoVehicleGlobalPathMsg.lane_ids.size() << '\n' <<
        "ego-vehicle global path waypoint size: " <<
        mEgoVehicleGlobalPathMsg.waypoints.size());

    mEgoVehicleGlobalPathPublisher.publish(mEgoVehicleGlobalPathMsg);

}

void EgoVehicleWaypointManagerNode::NavigationPathCallback(const route_mission_handler::Path &msg)
{
    LaneIds unorderedForwardLaneIds;
    unorderedForwardLaneIds.reserve(msg.lanes.size());
    for (const auto &forwardLane: msg.lanes)
    {
        unorderedForwardLaneIds.push_back(forwardLane.lane_id);
        if (forwardLane.is_intersection)
        {
            mIntersectionLaneIds.push_back(forwardLane.lane_id);
        }
    }

    ROS_DEBUG_STREAM_COND(
        false,
        "mIntersectionLaneIds size: " << mIntersectionLaneIds.size());

    this->ConnectLaneIdsArray(
        unorderedForwardLaneIds,
        mForwardLaneIdsArray);

    static constexpr bool canShowForwardLaneIds{false};
    if (canShowForwardLaneIds)
    {
        ROS_DEBUG_STREAM_COND(
            true,
            "forward lane ids");
        for (auto forwardLaneIds{mForwardLaneIdsArray.cbegin()};
             forwardLaneIds != mForwardLaneIdsArray.cend();
             ++forwardLaneIds)
        {
            const auto setIdx{
                std::distance(
                    mForwardLaneIdsArray.cbegin(),
                    forwardLaneIds)};
            std::cout << "setIdx: " << setIdx << std::endl;
            std::copy(
                forwardLaneIds->cbegin(),
                forwardLaneIds->cend(),
                std::ostream_iterator<int32_t>(std::cout, ", "));
            std::cout << std::endl;
        }
    }

    LaneIds unorderedOppositeLaneIds;
    unorderedOppositeLaneIds.reserve(msg.opposite_lanes.size());
    for (const auto &oppositeLane: msg.opposite_lanes)
    {
        unorderedOppositeLaneIds.push_back(oppositeLane.lane_id);
        if (oppositeLane.is_intersection)
        {
            mIntersectionLaneIds.push_back(oppositeLane.lane_id);
        }
    }

    ROS_DEBUG_STREAM_COND(
        false,
        "mIntersectionLaneIds size: " << mIntersectionLaneIds.size());

    std::reverse(
        unorderedOppositeLaneIds.begin(),
        unorderedOppositeLaneIds.end());
    this->ConnectLaneIdsArray(
        unorderedOppositeLaneIds,
        mOppositeLaneIdsArray);

    static constexpr bool canShowOppositeLaneIds{false};
    if (canShowOppositeLaneIds)
    {
        ROS_DEBUG_STREAM_COND(
            true,
            "opposite lane ids");
        for (auto oppositeLaneIds{mOppositeLaneIdsArray.cbegin()};
             oppositeLaneIds != mOppositeLaneIdsArray.cend();
             ++oppositeLaneIds)
        {
            const auto setIdx{
                std::distance(
                    mOppositeLaneIdsArray.cbegin(),
                    oppositeLaneIds)};
            std::cout << "setIdx: " << setIdx << std::endl;
            std::copy(
                oppositeLaneIds->cbegin(),
                oppositeLaneIds->cend(),
                std::ostream_iterator<int32_t>(std::cout, ", "));
            std::cout << std::endl;
        }
    }

    this->ConvertLanesToWaypoints(
        mForwardLaneIdsArray,
        mForwardWaypointsArray);
    this->ConvertLanesToWaypoints(
        mOppositeLaneIdsArray,
        mOppositeWaypointsArray);

    path_msgs::NavigationData navigationDataMsg;
    path::ToLaneIdsMsgArray(
        mForwardLaneIdsArray,
        navigationDataMsg.forward_lane_ids_array);
    path::ToWaypointsMsgArray(
        mForwardWaypointsArray,
        navigationDataMsg.forward_waypoints_array);
    path::ToLaneIdsMsgArray(
        mOppositeLaneIdsArray,
        navigationDataMsg.opposite_lane_ids_array);
    path::ToWaypointsMsgArray(
        mOppositeWaypointsArray,
        navigationDataMsg.opposite_waypoints_array);
    mNavigationDataPublisher.publish(navigationDataMsg);


    this->ConvertLanesToRouteWaypoints(
        mForwardLaneIdsArray,
        mForwardRouteWaypointsArray);
    this->ConvertLanesToRouteWaypoints(
        mOppositeLaneIdsArray,
        mOppositeRouteWaypointsArray);
    path_msgs::BidirectionalRouteWaypointsArray bidirectionalRouteWaypointsArray;
    path::ToRouteWaypointsMsgArray(
        mForwardRouteWaypointsArray,
        bidirectionalRouteWaypointsArray.forward_route_waypoints_array);
    path::ToRouteWaypointsMsgArray(
        mOppositeRouteWaypointsArray,
        bidirectionalRouteWaypointsArray.opposite_route_waypoints_array);
    mBidirectionalRouteWaypointsArrayPublisher.publish(bidirectionalRouteWaypointsArray);
}

} // namespace path {
