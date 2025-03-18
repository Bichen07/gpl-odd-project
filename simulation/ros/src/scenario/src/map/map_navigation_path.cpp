#include <map_navigation_path.h>
#include <stdexcept>
#include <limits>
#include <ros/ros.h>
#include <ros/console.h>
#include <std_msgs/Bool.h>
#include <GeographicLib/Geocentric.hpp>
#include <GeographicLib/LocalCartesian.hpp>
#include <route_mission_handler/common_utils/utils.h>
#include <path/RouteWaypointQuerying.h>
#include <path/WaypointQuerying.h>
#include <path/RequestEgoVehicleGlobalPath.h>
#include <path_msgs/EgoVehicleGlobalPath.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <utils_empty_container_exception.h>

namespace map {

// public func.

NavigationPath::NavigationPath()
    : mNodeHandle{}
    , mEgoVehicleGlobalPathSubscriber{}
    , mNavigationDataSubscriber{}
    , mBidirectionalRouteWaypointsArraySubscriber{}
    , mNavigationPathReadinessPublisher{}
    , mRouteWaypointQueryingService{}
    , mWaypointQueryingService{}
    , mRequestEgoVehicleGlobalPathService{}

    , mForwardWaypointKdTree{new pcl::KdTreeFLANN<pcl::PointXYZ>}
    , mOppositeWaypointKdTree{new pcl::KdTreeFLANN<pcl::PointXYZ>}

    , mNavigationPathConfig{}

    , mPath{}
    , mLaneMap{}
    , mLaneWaypointMap{}

    , mForwardRouteLanePointIdToWaypointIdxMap{}
    , mOppositeRouteLanePointIdToWaypointIdxMap{}

    , mEgoVehicleGlobalLaneIds{}
    , mForwardLaneIds{}
    , mOppositeLaneIds{}
    , mCandidateOppositeLaneIds{}
    , mForwardTravelMap{}
    , mOppositeTravelMap{}

    , mForwardRouteWaypoints{}
    , mOppositeRouteWaypoints{}
    , mForwardIntersectionWaypointIndices{}
    , mOppositeIntersectionWaypointIndices{}
    , mForwardIntersectionWaypoints{}
    , mOppositeIntersectionWaypoints{}
    , mForwardIntersectionWaypointDatas{}
    , mOppositeIntersectionWaypointDatas{}
    , mEgoVehicleGlobalPath{}
    , mForwardWaypoints{}
    , mOppositeWaypoints{}
    , mForwardWaypointSds{}
    , mOppositeWaypointSds{}
    , mIntersectionLanes{}
    , mIsReady{false}
    , mRetryBeforeRequestEgoVehicleGlobalPath{20}
{
    mEgoVehicleGlobalPathSubscriber = mNodeHandle.subscribe(
        "path/ego_vehicle_global_path",
        DefaultQueueSize(),
        &NavigationPath::EgoVehicleGlobalPathCallback,
        this);
    mNavigationDataSubscriber = mNodeHandle.subscribe(
        "path/navigation_data",
        DefaultQueueSize(),
        &NavigationPath::NavigationDataCallback,
        this);
    mBidirectionalRouteWaypointsArraySubscriber = mNodeHandle.subscribe(
        "path/bidirectional_route_waypoint_array",
        DefaultQueueSize(),
        &NavigationPath::BidirectionalRouteWaypointsArrayCallback,
        this);
    mNavigationPathReadinessPublisher = mNodeHandle.advertise<std_msgs::Bool>(
        "scenario/navigation_path_readiness",
        DefaultQueueSize());
    mRouteWaypointQueryingService = mNodeHandle.serviceClient<path::RouteWaypointQuerying>(
        "path/route_waypoint_querying");
    mWaypointQueryingService = mNodeHandle.serviceClient<path::WaypointQuerying>(
        "path/waypoint_querying");
    mRequestEgoVehicleGlobalPathService = mNodeHandle.serviceClient<path::RequestEgoVehicleGlobalPath>(
        "path/request_ego_vehicle_global_path");
}

const NavigationPathConfig &NavigationPath::GetNavigationPathConfig() const
{
    return mNavigationPathConfig;
}

const std::vector<int32_t> &NavigationPath::GetEgoVehicleGlobalLaneIds() const
{
    if (mEgoVehicleGlobalLaneIds.empty())
    {
        ROS_ERROR_STREAM("mEgoVehicleGlobalLaneIds is empty()");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return mEgoVehicleGlobalLaneIds;
}

const std::vector<int32_t> &NavigationPath::GetForwardLaneIds() const
{
    return mForwardLaneIds;
}

const std::vector<int32_t> &NavigationPath::GetOppositeLaneIds() const
{
    return mOppositeLaneIds;
}

const std::vector<math::Vector3d_t> &NavigationPath::GetEgoVehicleGlobalPath()
{
    for (uint i = 0 ; i < mRetryBeforeRequestEgoVehicleGlobalPath; i++)
    {
        if (!mEgoVehicleGlobalPath.empty())
        {
            return mEgoVehicleGlobalPath;
        }
        else
        {
            ros::Duration(0.05).sleep();
            ros::spinOnce();
        }
    }

    ROS_WARN_STREAM("mEgoVehicleGlobalPath is empty(), try to request.");

    path::RequestEgoVehicleGlobalPath requestEgoVehicleGlobalPath;
    mRequestEgoVehicleGlobalPathService.call(requestEgoVehicleGlobalPath);
    path_msgs::EgoVehicleGlobalPath egoVehicleGlobalPathMsg =
        requestEgoVehicleGlobalPath.response.ego_vehicle_global_path;
    const path_msgs::EgoVehicleGlobalPath::Ptr egoVehicleGlobalPathPtr =
        boost::make_shared<path_msgs::EgoVehicleGlobalPath>(egoVehicleGlobalPathMsg);
    EgoVehicleGlobalPathCallback(egoVehicleGlobalPathPtr);

    return mEgoVehicleGlobalPath;
}

const std::vector<math::Vector3d_t> &NavigationPath::GetForwardWaypoints() const
{
    return mForwardWaypoints;
}

const std::vector<math::Vector3d_t> &NavigationPath::GetOppositeWaypoints() const
{
    return mOppositeWaypoints;
}

const std::vector<path_msgs::RouteWaypoints> &NavigationPath::GetForwardRouteWaypointsArray() const
{
    return mForwardRouteWaypointsArray;
}
const std::vector<path_msgs::RouteWaypoints> &NavigationPath::GetOppositeRouteWaypointsArray() const
{
    return mOppositeRouteWaypointsArray;
}

const std::vector<route_mission_handler::Waypoint> &NavigationPath::GetForwardRouteWaypoints() const
{
    return mForwardRouteWaypoints;
}

const std::vector<route_mission_handler::Waypoint> &NavigationPath::GetOppositeRouteWaypoints() const
{
    return mOppositeRouteWaypoints;
}

const std::vector<std::pair<int32_t, int32_t>> &NavigationPath::GetForwardIntersectionWaypointIndices() const
{
    return mForwardIntersectionWaypointIndices;
}

const std::vector<std::pair<int32_t, int32_t>> &NavigationPath::GetOppositeIntersectionWaypointIndices() const
{
    return mOppositeIntersectionWaypointIndices;
}

const std::vector<Vector3dPair> &NavigationPath::GetForwardIntersectionWaypoints() const
{
    return mForwardIntersectionWaypoints;
}

const std::vector<Vector3dPair> &NavigationPath::GetOppositeIntersectionWaypoints() const
{
    return mOppositeIntersectionWaypoints;
}

const std::vector<IntersectionWaypointData> &NavigationPath::GetForwardIntersectionWaypointDatas() const
{
    return mForwardIntersectionWaypointDatas;
}

const std::vector<IntersectionWaypointData> &NavigationPath::GetOppositeIntersectionWaypointDatas() const
{
    return mOppositeIntersectionWaypointDatas;
}

const route_mission_handler::Waypoint &NavigationPath::GetForwardRouteWaypoint(
    const int32_t idx) const
{
    return mForwardRouteWaypoints.at(idx);
}

const route_mission_handler::Waypoint &NavigationPath::GetOppositeRouteWaypoint(
    const int32_t idx) const
{
    return mOppositeRouteWaypoints.at(idx);
}

const IntersectionWaypointData &NavigationPath::GetForwardIntersectionWaypointData(
    const int32_t intersectionId) const
{
    return mForwardIntersectionWaypointDatas.at(intersectionId);
}

const IntersectionWaypointData &NavigationPath::GetOppositeIntersectionWaypointData(
    const int32_t intersectionId) const
{
    return mOppositeIntersectionWaypointDatas.at(intersectionId);
}

void NavigationPath::Configure(const NavigationPathConfig &navigationPathConfig)
{
    mNavigationPathConfig = navigationPathConfig;
}

path_msgs::RouteWaypoint NavigationPath::QueryRouteWaypoint(
    const WaypointId &waypointId)
{
    path::RouteWaypointQuerying routeWaypointQuerying;
    routeWaypointQuerying.request.waypoint_id.lane = waypointId.lane;
    routeWaypointQuerying.request.waypoint_id.point = waypointId.point;
    if (!mRouteWaypointQueryingService.call(routeWaypointQuerying))
    {
        ROS_ERROR_STREAM(
            "fail to call path/route_waypoint_querying service" << '\n' <<
            "request" << '\n' <<
            routeWaypointQuerying.request << '\n' <<
            "response" << '\n' <<
            routeWaypointQuerying.response);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return routeWaypointQuerying.response.route_waypoint;
}

path_msgs::RouteWaypoint NavigationPath::QueryRouteWaypoint(
    const int32_t laneId,
    const int32_t pointId)
{
    return this->QueryRouteWaypoint(WaypointId(laneId, pointId));
}

math::Vector3d_t NavigationPath::QueryWaypoint(const WaypointId &waypointId)
{
    if (int32_t{0} >= waypointId.lane || int32_t{0} >= waypointId.point)
    {
        ROS_ERROR_STREAM("invalid waypointId: " << waypointId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    path::WaypointQuerying waypointQuerying;
    waypointQuerying.request.waypoint_id.lane = waypointId.lane;
    waypointQuerying.request.waypoint_id.point = waypointId.point;
    if (!mWaypointQueryingService.call(waypointQuerying))
    {
        ROS_ERROR_STREAM(
            "fail to call path/waypoint_querying service" << '\n' <<
            "request" << '\n' <<
            waypointQuerying.request << '\n' <<
            "response" << '\n' <<
            waypointQuerying.response);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return utils::ConvertToVector3d(waypointQuerying.response.waypoint);
}

math::Vector3d_t NavigationPath::QueryWaypoint(
    const int32_t laneId,
    const int32_t pointId)
{
    return this->QueryWaypoint(WaypointId(laneId, pointId));
}

int32_t NavigationPath::SearchNearestForwardWaypoint(
    const math::Vector3d_t &targetPoint) const
{
    return this->SearchNearestWaypoint(
        targetPoint,
        mForwardWaypoints,
        mForwardWaypointKdTree,
        nullptr);
}

int32_t NavigationPath::SearchNearestForwardWaypoint(
    const geometry_msgs::Pose2D &givenQueryPose2D) const
{
    return SearchNearestForwardWaypoint(
        Pose2DToVector3d(givenQueryPose2D));
}

int32_t NavigationPath::SearchNearestForwardWaypoint(
    const math::Vector3d_t &targetPoint,
    math::Vector3d_t *resultantPoint) const
{
    return this->SearchNearestWaypoint(
        targetPoint,
        mForwardWaypoints,
        mForwardWaypointKdTree,
        resultantPoint);
}

int32_t NavigationPath::SearchNearestOppositeWaypoint(
    const math::Vector3d_t &targetPoint) const
{
    return this->SearchNearestWaypoint(
        targetPoint,
        mOppositeWaypoints,
        mOppositeWaypointKdTree,
        nullptr);
}

int32_t NavigationPath::SearchNearestOppositeWaypoint(
    const geometry_msgs::Pose2D &givenQueryPose2D) const
{
    return this->SearchNearestOppositeWaypoint(
        this->Pose2DToVector3d(givenQueryPose2D));
}

int32_t NavigationPath::SearchNearestOppositeWaypoint(
    const math::Vector3d_t &targetPoint,
    math::Vector3d_t *resultantPoint) const
{
    return this->SearchNearestWaypoint(
        targetPoint,
        mOppositeWaypoints,
        mOppositeWaypointKdTree,
        resultantPoint);
}

std::vector<math::Vector3d_t> NavigationPath::QuerySequentialWaypoints(
    const WaypointId &beginId,
    const WaypointId &endId) const
{
    return this->QuerySequentialWaypoints(
        beginId.lane,
        beginId.point,
        endId.lane,
        endId.point);
}

std::vector<math::Vector3d_t> NavigationPath::QuerySequentialWaypoints(
    const int32_t beginLaneId,
    const int32_t beginPointId,
    const int32_t endLaneId,
    const int32_t endPointId) const
{
    const bool isValidForwardWaypointIdPair =
        this->IsValidSequentialForwardWaypointIdPair(
            beginLaneId,
            beginPointId,
            endLaneId,
            endPointId);

    if (isValidForwardWaypointIdPair)
    {
        return this->QuerySequentialForwardWaypoints(
            beginLaneId,
            beginPointId,
            endLaneId,
            endPointId);
    }

    const bool isValidOppositeWaypointIdPair =
        this->IsValidSequentialOppositeWaypointIdPair(
            beginLaneId,
            beginPointId,
            endLaneId,
            endPointId);

    if (isValidOppositeWaypointIdPair)
    {
        return this->QuerySequentialOppositeWaypoints(
            beginLaneId,
            beginPointId,
            endLaneId,
            endPointId);
    }

    ROS_ERROR_STREAM(
        "invalid sequential waypoint pair" << '\n' <<
        "beginLaneId: " << beginLaneId <<
        ", beginPointId: " << beginPointId << '\n' <<
        "endLaneId: " << endLaneId <<
        ", endPointId: " << endPointId);
    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
}

std::vector<math::Vector3d_t> NavigationPath::QuerySequentialForwardWaypoints(
    const int32_t beginLaneId,
    const int32_t beginPointId,
    const int32_t endLaneId,
    const int32_t endPointId) const
{
    const bool isValidSequentialWaypointPair =
        this->IsValidSequentialForwardWaypointIdPair(
            beginLaneId,
            beginPointId,
            endLaneId,
            endPointId);
    if (!isValidSequentialWaypointPair)
    {
        ROS_ERROR_STREAM(
            "invalid sequential waypont pair" << '\n' <<
            "beginLaneId: " << beginLaneId <<
            ", beginPointId: " << beginPointId << '\n' <<
            "endLaneId: " << endLaneId <<
            ", endPointId: " << endPointId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    std::vector<math::Vector3d_t> outputWaypoints;
    outputWaypoints.reserve(mForwardWaypoints.size());

    if (beginLaneId == endLaneId)
    {
        const auto laneWaypoints{this->QuerySequentialWaypoints(beginLaneId)};
        outputWaypoints.insert(
            outputWaypoints.end(),
            laneWaypoints.cbegin() + beginPointId - 1,
            laneWaypoints.cbegin() + endPointId);

        outputWaypoints.shrink_to_fit();
        return outputWaypoints;
    }

    auto currentLaneId = std::find(
        mForwardLaneIds.begin(),
        mForwardLaneIds.end(),
        beginLaneId);
    auto beginLaneWaypoints = this->QuerySequentialWaypoints(beginLaneId);

    outputWaypoints.insert(
        outputWaypoints.end(),
        beginLaneWaypoints.begin() + beginPointId - 1,
        beginLaneWaypoints.end());
    ++currentLaneId;
    while (endLaneId != *currentLaneId)
    {
        const auto currentLaneWaypoints = this->QuerySequentialWaypoints(*currentLaneId);
        outputWaypoints.insert(
            outputWaypoints.end(),
            currentLaneWaypoints.begin(),
            currentLaneWaypoints.end());
        ++currentLaneId;
    }

    if (endLaneId == *currentLaneId)
    {
        auto endLaneWaypoints = this->QuerySequentialWaypoints(endLaneId);
        outputWaypoints.insert(
            outputWaypoints.end(),
            endLaneWaypoints.begin(),
            endLaneWaypoints.begin() + endPointId);
    }

    outputWaypoints.shrink_to_fit();
    return outputWaypoints;
}

std::vector<math::Vector3d_t> NavigationPath::QuerySequentialOppositeWaypoints(
    const int32_t beginLaneId,
    const int32_t beginPointId,
    const int32_t endLaneId,
    const int32_t endPointId) const
{
    const bool isValidSequentialWaypointPair =
        this->IsValidSequentialOppositeWaypointIdPair(
            beginLaneId,
            beginPointId,
            endLaneId,
            endPointId);
    if (!isValidSequentialWaypointPair)
    {
        ROS_WARN_STREAM(
            "invalid sequential waypoint pair" << '\n' <<
            "beginLaneId: " << beginLaneId <<
            ", beginPointId: " << beginPointId << '\n' <<
            "endLaneId: " << endLaneId <<
            ", endPointId: " << endPointId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    std::vector<math::Vector3d_t> outputWaypoints;
    outputWaypoints.reserve(mOppositeWaypoints.size());

    if (beginLaneId == endLaneId)
    {
        const auto laneWaypoints{this->QuerySequentialWaypoints(beginLaneId)};
        outputWaypoints.insert(
            outputWaypoints.end(),
            laneWaypoints.cbegin() + beginPointId - 1,
            laneWaypoints.cbegin() + endPointId);

        outputWaypoints.shrink_to_fit();
        return outputWaypoints;
    }

    auto currentLaneId = std::find(
        mOppositeLaneIds.begin(),
        mOppositeLaneIds.end(),
        beginLaneId);
    auto beginLaneWaypoints = this->QuerySequentialWaypoints(beginLaneId);

    outputWaypoints.insert(
        outputWaypoints.end(),
        beginLaneWaypoints.begin() + beginPointId - 1,
        beginLaneWaypoints.end());
    ++currentLaneId;
    while (endLaneId != *currentLaneId)
    {
        const auto currentLaneWaypoints = this->QuerySequentialWaypoints(*currentLaneId);
        outputWaypoints.insert(
            outputWaypoints.end(),
            currentLaneWaypoints.begin(),
            currentLaneWaypoints.end());
        ++currentLaneId;
    }

    if (endLaneId == *currentLaneId)
    {
        auto endLaneWaypoints = this->QuerySequentialWaypoints(endLaneId);
        outputWaypoints.insert(
            outputWaypoints.end(),
            endLaneWaypoints.begin(),
            endLaneWaypoints.begin() + endPointId);
    }

    outputWaypoints.shrink_to_fit();
    return outputWaypoints;
}

int32_t NavigationPath::QueryForwardWaypointIdx(const int32_t laneId, const int32_t pointId) const
{
    const auto foundPair{
        mForwardRouteLanePointIdToWaypointIdxMap.find(std::make_pair(laneId, pointId))};

    if (mForwardRouteLanePointIdToWaypointIdxMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId << ", pointId: " << pointId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

int32_t NavigationPath::QueryOppositeWaypointIdx(const int32_t laneId, const int32_t pointId) const
{
    const auto foundPair{
        mOppositeRouteLanePointIdToWaypointIdxMap.find(std::make_pair(laneId, pointId))};

    if (mOppositeRouteLanePointIdToWaypointIdxMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId << ", pointId: " << pointId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

bool NavigationPath::IsReady()
{
    return mIsReady;
}

bool NavigationPath::IsIntersection(const math::Vector3d_t &givenQueryPoint)
{
    int32_t pointId = SearchNearestForwardWaypoint(givenQueryPoint);
    route_mission_handler::Waypoint waypoint = GetForwardRouteWaypoint(pointId);

    return std::find(
        mIntersectionLanes.begin(),
        mIntersectionLanes.end(),
        waypoint.lane_id) != mIntersectionLanes.end();
}

bool NavigationPath::IsIntersection(
    const geometry_msgs::Pose2D &givenQueryPose2D)
{
    return this->IsIntersection(
        this->Pose2DToVector3d(givenQueryPose2D));
}

// protected func.

// private func.

void NavigationPath::ConnectForwardLanes(const int32_t laneId)
{
    if (!mForwardTravelMap[laneId])
    {
        mForwardLaneIds.push_back(laneId);
        mForwardTravelMap[laneId] = true;

        for (const auto id: mLaneMap[laneId].left_lanes)
        //for (const auto id: mLaneMap[laneId].right_lanes)
        {
            if (this->IsSameDirectionLane(laneId, id))
            {
                mForwardTravelMap[id] = true;
            }

            mCandidateOppositeLaneIds.push_back(id);

            //ROS_INFO_STREAM(
            //    "left id: " << id <<
            //    ", waypoint size: " << mLaneWaypointMap[id].size());
        }

        for (const auto id: mLaneMap[laneId].right_lanes)
        //for (const auto id: mLaneMap[laneId].left_lanes)
        {
            if (this->IsSameDirectionLane(laneId, id))
            {
                mForwardTravelMap[id] = true;
            }
        }

        if (!mLaneMap[laneId].next_lanes.empty())
        {
            int32_t selectedId{mLaneMap[laneId].next_lanes.front()};
            for (const auto id: mLaneMap[laneId].next_lanes)
            {
                if (!mLaneWaypointMap[id].empty())
                {
                    selectedId = id;
                    break;
                }
            }

            this->ConnectForwardLanes(selectedId);
        }
    }
}

void NavigationPath::ConnectOppositeLanes(const int32_t laneId)
{
    if (!mOppositeTravelMap[laneId])
    {
        mOppositeLaneIds.push_back(laneId);
        mOppositeTravelMap[laneId] = true;

        if (!mLaneMap[laneId].next_lanes.empty())
        {
            int32_t selectedId{mLaneMap[laneId].next_lanes.front()};
            for (const auto id: mLaneMap[laneId].next_lanes)
            {
                const auto foundNextLaneId = std::find_if(
                    mCandidateOppositeLaneIds.begin(),
                    mCandidateOppositeLaneIds.end(),
                    [&id](const int32_t candidateId)
                    {return candidateId == id;});
                if (mCandidateOppositeLaneIds.end() != foundNextLaneId)
                {
                    //ROS_INFO_STREAM("found id:" << id);
                    selectedId = id;
                    if (mLaneWaypointMap[selectedId].empty())
                    {
                        break;
                    }
                }
                //else
                //{
                //    ROS_INFO_STREAM("not found id:" << id);
                //    break;
                //}
                //if (mLaneWaypointMap[id].empty())
                //{
                //    selectedId = id;
                //    break;
                //}
            }

            this->ConnectOppositeLanes(selectedId);
        }
    }
}

void NavigationPath::GenerateRouteWaypoints(
    const std::vector<int32_t> &laneIds,
    std::vector<route_mission_handler::Waypoint> *routeWaypoints,
    std::vector<std::pair<int32_t, int32_t>> *intersectionWaypointIndices)
{
    routeWaypoints->clear();
    intersectionWaypointIndices->clear();
    //static constexpr float minWaypointDistance{0.9};
    static constexpr float minWaypointDistance{0.0};
    for (const auto id: laneIds)
    {
        const std::size_t globalWaypointIdx{routeWaypoints->size()};
        for (const auto &waypoint: mLaneWaypointMap[id])
        {
            //bool canAddThisWaypoint{true};
            //if (!routeWaypoints->empty())
            //{
            //    const auto waypointDistance{
            //        std::hypot(
            //            routeWaypoints->back().point.x - waypoint.second.point.x,
            //            routeWaypoints->back().point.y - waypoint.second.point.y)};
            //    canAddThisWaypoint = waypointDistance > minWaypointDistance;

            //    //ROS_INFO_STREAM(
            //    //    "canAddThisWaypoint: " << canAddThisWaypoint << ", distance: " << waypointDistance
            //    //    );
            //}

            //if (canAddThisWaypoint)
            //{
            //    routeWaypoints->push_back(waypoint.second);
            //}

            routeWaypoints->push_back(waypoint.second);
        }

        if (mLaneMap[id].is_intersection)
        {
            intersectionWaypointIndices->push_back(
                std::make_pair(
                    static_cast<int32_t>(globalWaypointIdx),
                    static_cast<int32_t>(routeWaypoints->size() - 1u)));
        }
    }
}

void NavigationPath::ComputeWaypointSds(
    const std::vector<math::Vector3d_t> &waypoints,
    std::vector<math::FrenetCoord> *waypointSds)
{
    if (waypoints.empty())
    {
        ROS_ERROR_STREAM("waypoints is empty");
        throw utils::EmptyContainerException(__FILE__": " + std::to_string(__LINE__));
    }

    waypointSds->clear();
    waypointSds->resize(waypoints.size());
    auto xyz{waypoints.begin()};
    auto sd{waypointSds->begin()};

    *sd = math::FrenetCoord();
    ++xyz;
    ++sd;
    math::real_t accumulatedDistanceXy{0.0};

    for (; xyz != waypoints.end(); ++xyz, ++sd)
    {
        math::Vector3d_t forwardVector = *xyz - *(xyz - 1);
        accumulatedDistanceXy += math::Vector2d_t(forwardVector.x(), forwardVector.y()).norm();
        sd->set_s(accumulatedDistanceXy);
    }
}

void NavigationPath::ConstructKdTree(
    const std::vector<math::Vector3d_t> &points,
    pcl::KdTreeFLANN<pcl::PointXYZ>::Ptr &kdTree)
{
    if (points.empty())
    {
        ROS_ERROR_STREAM("points is empty");
        throw utils::EmptyContainerException("");
    }

    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);
    cloud->height = 1;
    cloud->points.resize(points.size());
    std::transform(
        points.begin(),
        points.end(),
        cloud->points.begin(),
        [](const math::Vector3d_t &point)
        {return pcl::PointXYZ(point.x(), point.y(), 0.0f);});
    cloud->width = cloud->points.size();

    kdTree->setInputCloud(cloud);
}

int32_t NavigationPath::SearchNearestWaypoint(
    const math::Vector3d_t &targetPoint,
    const std::vector<math::Vector3d_t> &waypoints,
    const pcl::KdTreeFLANN<pcl::PointXYZ>::Ptr &waypointKdTree,
    math::Vector3d_t *resultantPoint) const
{
    const pcl::PointXYZ givenQueryPoint(
        targetPoint.x(),
        targetPoint.y(),
        0.0f);
    std::vector<int32_t> resultantIndices;
    std::vector<float> resultantSquaredDistances;
    waypointKdTree->radiusSearch(
        givenQueryPoint,
        10.0,
        resultantIndices,
        resultantSquaredDistances);

    if (resultantIndices.empty())
    {
        resultantIndices.resize(1);
        resultantSquaredDistances.resize(1);
        waypointKdTree->nearestKSearch(
            givenQueryPoint,
            1,
            resultantIndices,
            resultantSquaredDistances);
    }

    const int32_t cloestIdx{resultantIndices.front()};

    if (nullptr != resultantPoint)
    {
        *resultantPoint = waypoints.at(cloestIdx);
    }

    return cloestIdx;
}

std::vector<math::Vector3d_t> NavigationPath::QuerySequentialWaypoints(
    const int32_t laneId) const
{
    const auto foundLaneWaypointPair{mLaneWaypointMap.find(laneId)};
    if (mLaneWaypointMap.end() == foundLaneWaypointPair)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    std::vector<math::Vector3d_t> outputWaypoints(foundLaneWaypointPair->second.size());
    std::transform(
        foundLaneWaypointPair->second.begin(),
        foundLaneWaypointPair->second.end(),
        outputWaypoints.begin(),
        [](const std::pair<int32_t, route_mission_handler::Waypoint> &routeWaypoint)
        {return utils::ConvertToVector3d(routeWaypoint.second.point);});

    return outputWaypoints;
}

bool NavigationPath::IsSameDirectionLane(
    const int32_t refLaneId,
    const int32_t testLaneId)
{
    static constexpr float headingThreshold{0.9f};
    const float headingDiff = mLaneWaypointMap[refLaneId].begin()->second.heading -
        mLaneWaypointMap[testLaneId].begin()->second.heading;

    return std::cos(headingDiff) > headingThreshold;
}

bool NavigationPath::IsValidSequentialForwardLaneIdPair(
    const int32_t beginLaneId,
    const int32_t endLaneId) const
{
    const auto foundBeginId = std::find(
        mForwardLaneIds.begin(),
        mForwardLaneIds.end(),
        beginLaneId);
    if (mForwardLaneIds.end() == foundBeginId)
    {
        ROS_WARN_STREAM("beginLaneId: " << beginLaneId << " is not in Forward Lanes");
        return false;
    }

    const auto foundEndId = std::find(
        mForwardLaneIds.begin(),
        mForwardLaneIds.end(),
        endLaneId);
    if (mForwardLaneIds.end() == foundEndId)
    {
        ROS_WARN_STREAM("endLaneId: " << endLaneId << " is not in Forward Lanes");
        return false;
    }

    const int32_t beginIdx = static_cast<int32_t>(
        std::distance(mForwardLaneIds.begin(), foundBeginId));

    if (beginIdx < 0 || beginIdx > static_cast<int32_t>(mForwardLaneIds.size() - 1ul))
    {
        ROS_ERROR_STREAM("invalid beginIdx: " << beginIdx);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const int32_t endIdx = static_cast<int32_t>(
        std::distance(mForwardLaneIds.begin(), foundEndId));

    if (endIdx < 0 || endIdx > static_cast<int32_t>(mForwardLaneIds.size() - 1ul))
    {
        ROS_ERROR_STREAM("invalid endIdx: " << endIdx);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return beginIdx <= endIdx;
}

bool NavigationPath::IsValidSequentialOppositeLaneIdPair(
    const int32_t beginLaneId,
    const int32_t endLaneId) const
{
    const auto foundBeginId = std::find(
        mOppositeLaneIds.begin(),
        mOppositeLaneIds.end(),
        beginLaneId);
    if (mOppositeLaneIds.end() == foundBeginId)
    {
        ROS_WARN_STREAM("beginLaneId: " << beginLaneId << " is not in Opposite Lanes");
        return false;
    }

    const auto foundEndId = std::find(
        mOppositeLaneIds.begin(),
        mOppositeLaneIds.end(),
        endLaneId);
    if (mOppositeLaneIds.end() == foundEndId)
    {
        ROS_WARN_STREAM("endLaneId: " << endLaneId << " is not in Opposite Lanes");
        return false;
    }

    const int32_t beginIdx = static_cast<int32_t>(
        std::distance(mOppositeLaneIds.begin(), foundBeginId));

    if (beginIdx < 0 || beginIdx > static_cast<int32_t>(mOppositeLaneIds.size() - 1ul))
    {
        ROS_ERROR_STREAM("invalid beginIdx: " << beginIdx);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const int32_t endIdx = static_cast<int32_t>(
        std::distance(mOppositeLaneIds.begin(), foundEndId));

    if (endIdx < 0 || endIdx > static_cast<int32_t>(mOppositeLaneIds.size() - 1ul))
    {
        ROS_ERROR_STREAM("invalid endIdx: " << endIdx);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return beginIdx <= endIdx;
}

bool NavigationPath::IsValidSequentialForwardWaypointIdPair(
    const int32_t beginLaneId,
    const int32_t beginPointId,
    const int32_t endLaneId,
    const int32_t endPointId) const
{
    if (beginLaneId == endLaneId && beginPointId >= endPointId)
    {
        return false;
    }

    if (!this->IsValidSequentialForwardLaneIdPair(beginLaneId, endLaneId))
    {
        return false;
    }

    const auto foundBeginLaneIdPair = mLaneWaypointMap.find(beginLaneId);
    const auto foundBeginWaypointPair = foundBeginLaneIdPair->second.find(beginPointId);
    if (foundBeginLaneIdPair->second.end() == foundBeginWaypointPair)
    {
        ROS_WARN_STREAM("invalid beginPointId: " << beginPointId << " in beginLaneId: " << beginLaneId);
        return false;
    }

    const auto foundEndLaneIdPair = mLaneWaypointMap.find(endLaneId);
    const auto foundEndWaypointPair = foundEndLaneIdPair->second.find(endPointId);
    if (foundEndLaneIdPair->second.end() == foundEndWaypointPair)
    {
        ROS_WARN_STREAM("invalid endPointId: " << endPointId << " in endLaneId: " << endLaneId);
        return false;
    }

    return true;
}

bool NavigationPath::IsValidSequentialOppositeWaypointIdPair(
    const int32_t beginLaneId,
    const int32_t beginPointId,
    const int32_t endLaneId,
    const int32_t endPointId) const
{
    if (beginLaneId == endLaneId && beginPointId >= endPointId)
    {
        return false;
    }

    if (!this->IsValidSequentialOppositeLaneIdPair(beginLaneId, endLaneId))
    {
        return false;
    }

    const auto foundBeginLaneIdPair = mLaneWaypointMap.find(beginLaneId);
    const auto foundBeginWaypointPair = foundBeginLaneIdPair->second.find(beginPointId);
    if (foundBeginLaneIdPair->second.end() == foundBeginWaypointPair)
    {
        ROS_WARN_STREAM("invalid beginPointId: " << beginPointId << " in beginLaneId: " << beginLaneId);
        return false;
    }

    const auto foundEndLaneIdPair = mLaneWaypointMap.find(endLaneId);
    const auto foundEndWaypointPair = foundEndLaneIdPair->second.find(endPointId);
    if (foundEndLaneIdPair->second.end() == foundEndWaypointPair)
    {
        ROS_WARN_STREAM("invalid endPointId: " << endPointId << " in endLaneId: " << endLaneId);
        return false;
    }

    return true;
}

void NavigationPath::ValidateNavigationPathConfig() const
{
    const std::string mapKey{"route_mission_handler/route"};
    std::string mapId;
    if (!ros::param::get(mapKey, mapId))
    {
        ROS_ERROR_STREAM("invalid mapKey: " << mapKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (mNavigationPathConfig.map != mapId)
    {
        ROS_ERROR_STREAM(
            "invalid map" << '\n' <<
            "route_mission_handler's map: " << mapId << '\n' <<
            "scenario config map: " << mNavigationPathConfig.map);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const std::string routeKey{"route_mission_handler/fileName"};
    std::string routeId;
    if (!ros::param::get(routeKey, routeId))
    {
        ROS_ERROR_STREAM("invalid routeKey: " << routeKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (mNavigationPathConfig.route != routeId)
    {
        ROS_ERROR_STREAM(
            "invalid route" << '\n' <<
            "route_mission_handler's route: " << routeId << '\n' <<
            "scenario config route: " << mNavigationPathConfig.route);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

math::Vector3d_t NavigationPath::Pose2DToVector3d(
    const geometry_msgs::Pose2D &pose2d) const
{
    return math::Vector3d_t(pose2d.x, pose2d.y, 0.);
}

void NavigationPath::EgoVehicleGlobalPathCallback(const path_msgs::EgoVehicleGlobalPath::Ptr &msg)
{
    mForwardWaypoints.clear();
    mForwardWaypoints.resize(msg->waypoints.size());
    std::transform(
        msg->waypoints.cbegin(),
        msg->waypoints.cend(),
        mForwardWaypoints.begin(),
        [](const geometry_msgs::Point &point)
        {return math::Vector3d_t(point.x, point.y, point.z);});

    mEgoVehicleGlobalPath.clear();
    mEgoVehicleGlobalPath.resize(msg->waypoints.size());
    std::transform(
        msg->waypoints.cbegin(),
        msg->waypoints.cend(),
        mEgoVehicleGlobalPath.begin(),
        [](const geometry_msgs::Point &point)
        {return math::Vector3d_t(point.x, point.y, point.z);});

    mEgoVehicleGlobalLaneIds.clear();
    mEgoVehicleGlobalLaneIds.resize(msg->lane_ids.size());
    std::copy(
        msg->lane_ids.cbegin(),
        msg->lane_ids.cend(),
        mEgoVehicleGlobalLaneIds.begin());

    mForwardLaneIds.clear();
    mForwardLaneIds.resize(msg->lane_ids.size());
    std::copy(
        msg->lane_ids.cbegin(),
        msg->lane_ids.cend(),
        mForwardLaneIds.begin());

    try
    {
        this->ComputeWaypointSds(
            mForwardWaypoints,
            &mForwardWaypointSds);
    }
    catch (const utils::EmptyContainerException &ex)
    {
        ROS_ERROR_STREAM(ex.what());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    try
    {
        this->ConstructKdTree(
            mForwardWaypoints,
            mForwardWaypointKdTree);
    }
    catch (const utils::EmptyContainerException &ex)
    {
        ROS_ERROR_STREAM(ex.what());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    //if (!mOppositeWaypoints.empty())
    //{
    //    this->ComputeWaypointSds(
    //        mOppositeWaypoints,
    //        &mOppositeWaypointSds);

    //    this->ConstructKdTree(
    //        mOppositeWaypoints,
    //        mOppositeWaypointKdTree);
    //}

    if (!mForwardWaypoints.empty())
    {
        std_msgs::Bool navigationPathReadinessMsg;
        navigationPathReadinessMsg.data = true;
        mNavigationPathReadinessPublisher.publish(navigationPathReadinessMsg);
    }

    mIsReady = true;
}

void NavigationPath::NavigationDataCallback(const path_msgs::NavigationData::Ptr &msg)
{
    auto longestOppositeWaypointsMsg{msg->opposite_waypoints_array.cbegin()};
    for (auto oppositeWaypointsMsg{msg->opposite_waypoints_array.cbegin()};
         oppositeWaypointsMsg != msg->opposite_waypoints_array.cend();
         ++oppositeWaypointsMsg)
    {
        if (oppositeWaypointsMsg->points.size() > longestOppositeWaypointsMsg->points.size())
        {
            longestOppositeWaypointsMsg = oppositeWaypointsMsg;
        }
    }

    mOppositeWaypoints.clear();
    mOppositeWaypoints.resize(longestOppositeWaypointsMsg->points.size());
    std::transform(
        longestOppositeWaypointsMsg->points.cbegin(),
        longestOppositeWaypointsMsg->points.cend(),
        mOppositeWaypoints.begin(),
        [](const geometry_msgs::Point &point)
        {return math::Vector3d_t(point.x, point.y, point.z);});

    try
    {
        this->ComputeWaypointSds(
            mOppositeWaypoints,
            &mOppositeWaypointSds);
    }
    catch (const utils::EmptyContainerException &ex)
    {
        ROS_ERROR_STREAM(ex.what());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    try
    {
        this->ConstructKdTree(
            mOppositeWaypoints,
            mOppositeWaypointKdTree);
    }
    catch (const utils::EmptyContainerException &ex)
    {
        ROS_ERROR_STREAM(ex.what());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto longestOppositeWaypointsIdx{
        std::distance(
            msg->opposite_waypoints_array.cbegin(),
            longestOppositeWaypointsMsg)};
    mOppositeLaneIds.resize(
        msg->opposite_lane_ids_array[longestOppositeWaypointsIdx].lane_ids.size());
    std::copy(
        msg->opposite_lane_ids_array[longestOppositeWaypointsIdx].lane_ids.cbegin(),
        msg->opposite_lane_ids_array[longestOppositeWaypointsIdx].lane_ids.cend(),
        mOppositeLaneIds.begin());
}

void NavigationPath::BidirectionalRouteWaypointsArrayCallback(
    const path_msgs::BidirectionalRouteWaypointsArray::Ptr &msg)
{
    mForwardRouteWaypointsArray = msg->forward_route_waypoints_array;
    mOppositeRouteWaypointsArray = msg->opposite_route_waypoints_array;
}

} // namespace map {
