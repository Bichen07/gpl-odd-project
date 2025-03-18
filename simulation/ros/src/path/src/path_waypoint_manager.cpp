#include <path_waypoint_manager.h>
#include <fstream>
#include <iterator>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <math_utils.h>
#include <math_quadratic_bezier_curve.h>

namespace path {

// public func.

WaypointManager::WaypointManager()
    : mWaypointMap{}
    , mConnectedLaneIdMap{}
    , mIndexedRouteWaypointMap{}
{
}

int32_t WaypointManager::QueryEndPointId(const int32_t laneId) const
{
    const auto foundWaypoints{mWaypointMap.find(laneId)};
    if (mWaypointMap.end() == foundWaypoints)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return static_cast<int32_t>(foundWaypoints->second.size());
}

const LaneIds &WaypointManager::QueryNextLaneIds(const int32_t givenLaneId) const
{
    const auto foundLaneIdPair{
        mConnectedLaneIdMap.find(givenLaneId)};
    if (mConnectedLaneIdMap.end() == foundLaneIdPair)
    {
        ROS_ERROR_STREAM("invalid givenLaneId: " << givenLaneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundLaneIdPair->second;
}

RouteWaypoint WaypointManager::QueryRouteWaypoint(const WaypointId &waypointId) const
{
    const auto foundIndexedRouteWaypoints{
        mIndexedRouteWaypointMap.find(waypointId.lane)};
    if (mIndexedRouteWaypointMap.end() == foundIndexedRouteWaypoints)
    {
        ROS_WARN_STREAM("invalid lane id: " << waypointId.lane);
        return RouteWaypoint();
    }

    const auto foundRouteWaypoint{
        std::find_if(
            foundIndexedRouteWaypoints->second.cbegin(),
            foundIndexedRouteWaypoints->second.cend(),
            [&waypointId](const IndexedRouteWaypoint &input)
            {return input.first == waypointId.point;})};
    if (foundRouteWaypoint == foundIndexedRouteWaypoints->second.end())
    {
        ROS_WARN_STREAM(
            "invalid point id: " << waypointId.point <<
            " with lane id: " << waypointId.lane);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundRouteWaypoint->second;
}

RouteWaypoints WaypointManager::QueryRouteWaypoints(
    const int32_t laneId) const
{
    const auto foundRouteWaypoints{mRouteWaypointMap.find(laneId)};
    if (mRouteWaypointMap.end() == foundRouteWaypoints)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundRouteWaypoints->second;
}

RouteWaypoints WaypointManager::QueryRouteWaypoints(
    const std::vector<int32_t> &connectedLaneIds) const
{
    if (connectedLaneIds.size() == std::size_t{1})
    {
        return this->QueryRouteWaypoints(connectedLaneIds.front());
    }

    if (!this->IsConnectedLaneIds(connectedLaneIds))
    {
        ROS_ERROR_STREAM("connectedLaneIds are not connected");
        std::cout << "input connectedLaneIds: ";
        std::copy(
            connectedLaneIds.cbegin(),
            connectedLaneIds.cend(),
            std::ostream_iterator<int32_t>(std::cout, ", "));
        std::cout << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    static constexpr std::size_t waypointSizeHint{30};
    RouteWaypoints outputRouteWaypoints;
    outputRouteWaypoints.reserve(connectedLaneIds.size() * waypointSizeHint);
    for (auto laneId{connectedLaneIds.cbegin()};
         laneId != connectedLaneIds.cend();
         ++laneId)
    {
        const auto foundRouteWaypoints{mRouteWaypointMap.find(*laneId)};
        if (mRouteWaypointMap.end() == foundRouteWaypoints)
        {
            ROS_ERROR_STREAM("invalid laneId: " << *laneId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        outputRouteWaypoints.insert(
            outputRouteWaypoints.cend(),
            foundRouteWaypoints->second.cbegin(),
            foundRouteWaypoints->second.cend());
    }

    return outputRouteWaypoints;
}

geometry::Vector3d WaypointManager::QueryWaypoint(const WaypointId &waypointId) const
{
    return this->QueryRouteWaypoint(waypointId).point;
}

Waypoints WaypointManager::QueryWaypoints(const int32_t laneId) const
{
    const auto foundWaypoints{mWaypointMap.find(laneId)};
    if (mWaypointMap.end() == foundWaypoints)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundWaypoints->second;
}

Waypoints WaypointManager::QueryWaypoints(
    const int32_t laneId,
    const int32_t beginPointId,
    const int32_t endPointId) const
{
    const auto foundWaypoints{mWaypointMap.find(laneId)};
    if (mWaypointMap.end() == foundWaypoints)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (beginPointId > endPointId)
    {
        ROS_ERROR_STREAM(
            "invalid beginPointId and endPointId pair" << '\n' <<
            "beginPointId: " << beginPointId << '\n' <<
            "endPointId: " << endPointId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    this->ValidatePointId(laneId, beginPointId);
    this->ValidatePointId(laneId, endPointId);

    const auto outputWaypoints = std::vector<geometry::Vector3d>(
        foundWaypoints->second.cbegin() + beginPointId - 1,
        foundWaypoints->second.cbegin() + endPointId);

    return outputWaypoints;
}

Waypoints WaypointManager::QueryWaypoints(
    const LaneIds &connectedLaneIds) const
{
    if (connectedLaneIds.size() == std::size_t{1})
    {
        return this->QueryWaypoints(connectedLaneIds.front());
    }

    if (!this->IsConnectedLaneIds(connectedLaneIds))
    {
        ROS_ERROR_STREAM("connectedLaneIds are not connected");
        std::cout << "input connectedLaneIds: ";
        std::copy(
            connectedLaneIds.cbegin(),
            connectedLaneIds.cend(),
            std::ostream_iterator<int32_t>(std::cout, ", "));
        std::cout << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    static constexpr std::size_t waypointSizeHint{30};
    std::vector<geometry::Vector3d> outputWaypoints;
    outputWaypoints.reserve(connectedLaneIds.size() * waypointSizeHint);
    for (auto laneId{connectedLaneIds.cbegin()};
         laneId != connectedLaneIds.cend();
         ++laneId)
    {
        const auto foundWaypoints{mWaypointMap.find(*laneId)};
        if (mWaypointMap.end() == foundWaypoints)
        {
            ROS_ERROR_STREAM("invalid laneId: " << *laneId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        outputWaypoints.insert(
            outputWaypoints.cend(),
            foundWaypoints->second.cbegin(),
            foundWaypoints->second.cend());
    }

    return outputWaypoints;
}

Waypoints WaypointManager::QueryWaypoints(
    const LaneIds &connectedLaneIds,
    const int32_t beginPointId,
    const int32_t endPointId) const
{
    if (connectedLaneIds.empty())
    {
        ROS_WARN_STREAM("connectedLaneIds is empty");
        return Waypoints();
    }

    this->ValidatePointId(connectedLaneIds.front(), beginPointId);
    this->ValidatePointId(connectedLaneIds.back(), endPointId);

    if (std::size_t{1} == connectedLaneIds.size())
    {
        return this->QueryWaypoints(
            connectedLaneIds.front(),
            beginPointId,
            endPointId);
    }

    if (!this->IsConnectedLaneIds(connectedLaneIds))
    {
        ROS_ERROR_STREAM("connectedLaneIds are not connected");
        std::cout << "input connectedLaneIds: ";
        std::copy(
            connectedLaneIds.cbegin(),
            connectedLaneIds.cend(),
            std::ostream_iterator<int32_t>(std::cout, ", "));
        std::cout << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    static constexpr std::size_t waypointSizeHint{30};
    std::vector<geometry::Vector3d> outputWaypoints;
    outputWaypoints.reserve(connectedLaneIds.size() * waypointSizeHint);

    const auto beginLaneWaypoints{
        this->QueryWaypoints(
            connectedLaneIds.front(),
            beginPointId,
            this->QueryEndPointId(connectedLaneIds.front()))};

    outputWaypoints.insert(
        outputWaypoints.end(),
        beginLaneWaypoints.cbegin(),
        beginLaneWaypoints.cend());

    if (connectedLaneIds.size() > std::size_t{2})
    {
        for (auto laneId{connectedLaneIds.cbegin() + 1};
             laneId != connectedLaneIds.cend() - 1;
             ++laneId)
        {
            const auto foundWaypoints{mWaypointMap.find(*laneId)};
            if (mWaypointMap.end() == foundWaypoints)
            {
                ROS_ERROR_STREAM("invalid laneId: " << *laneId);
                throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
            }

            outputWaypoints.insert(
                outputWaypoints.end(),
                foundWaypoints->second.cbegin(),
                foundWaypoints->second.cend());
        }
    }

    const auto endLaneWaypoints{
        this->QueryWaypoints(
            connectedLaneIds.back(),
            int32_t{1},
            endPointId)};
    outputWaypoints.insert(
        outputWaypoints.end(),
        endLaneWaypoints.cbegin(),
        endLaneWaypoints.cend());

    return outputWaypoints;
}

bool WaypointManager::IsConnectedLaneIds(
    const int32_t precedingLaneId,
    const int32_t succeedingLaneId) const
{
    const auto foundConnectedLaneIdPair{
        mConnectedLaneIdMap.find(precedingLaneId)};
    if (mConnectedLaneIdMap.end() == foundConnectedLaneIdPair)
    {
        ROS_ERROR_STREAM("invalid precedingLaneId: " << precedingLaneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return std::any_of(
        foundConnectedLaneIdPair->second.cbegin(),
        foundConnectedLaneIdPair->second.cend(),
        [&succeedingLaneId](const int32_t nextLaneId)
        {return nextLaneId == succeedingLaneId;});
}

bool WaypointManager::IsConnectedLaneIds(const LaneIds &laneIdSequence) const
{
    if (mConnectedLaneIdMap.empty())
    {
        ROS_ERROR_STREAM("mConnectedLaneIdMap is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    auto laneId{laneIdSequence.cbegin() + 1};
    for (; laneId != laneIdSequence.cend(); ++laneId)
    {
        const auto foundConnectedLaneId{mConnectedLaneIdMap.find(*(laneId - 1))};
        if (mConnectedLaneIdMap.end() == foundConnectedLaneId)
        {
            ROS_ERROR_STREAM("invalid laneId: " << *(laneId - 1));
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        const bool isConnectedLaneId = std::any_of(
            foundConnectedLaneId->second.begin(),
            foundConnectedLaneId->second.end(),
            [&laneId](const int32_t nextLaneId)
            {return nextLaneId == *laneId;});

        if (!isConnectedLaneId)
        {
            return isConnectedLaneId;
        }
    }

    return true;
}

void WaypointManager::Configure(const std::string &waypointFileName)
{
    this->ParseWaypoints(waypointFileName);
}

void WaypointManager::Configure(
    const std::string &waypointFileName,
    const std::string &lanesInfoFileName)
{
    this->ParseWaypoints(waypointFileName);
    this->ParseLanesInfo(lanesInfoFileName);
}

// protected func.

// private func.

void WaypointManager::ParseWaypoints(const std::string &waypointFileName)
{
    std::ifstream waypointFileStream;
    waypointFileStream.open(waypointFileName, std::ifstream::in);
    if (!waypointFileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << waypointFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value waypointJsonValue;
    jsonReader.parse(waypointFileStream, waypointJsonValue);
    waypointFileStream.close();

    for (const auto &waypointValue: waypointJsonValue["waypoints"])
    {
        std::vector<geometry::Vector3d> waypoints;
        RouteWaypoints routeWaypoints;
        std::vector<IndexedRouteWaypoint> indexedRouteWaypoints;
        waypoints.reserve(waypointValue["points"].size());
        routeWaypoints.reserve(waypointValue["points"].size());
        indexedRouteWaypoints.reserve(waypointValue["points"].size());
        for (const auto &pointValue: waypointValue["points"])
        {
            const geometry::Vector3d parsedWaypoint(
                pointValue["x"].asDouble(),
                pointValue["y"].asDouble(),
                pointValue["z"].asDouble());
            waypoints.push_back(parsedWaypoint);
            RouteWaypoint routeWaypoint(
                parsedWaypoint,
                pointValue["angle"].asDouble(),
                pointValue["left_boundary"].asDouble(),
                pointValue["right_boundary"].asDouble(),
                pointValue["curvature"].asDouble(),
                pointValue["slope"].asDouble());
            routeWaypoints.push_back(routeWaypoint);
            indexedRouteWaypoints.push_back(
                std::make_pair(
                    pointValue["point_id"].asInt(),
                    routeWaypoint));
        }

        const auto foundWaypoints{mWaypointMap.find(waypointValue["lane_id"].asInt())};
        if (mWaypointMap.end() == foundWaypoints)
        {
            mWaypointMap.insert(std::make_pair(waypointValue["lane_id"].asInt(), waypoints));
        }
        else
        {
            ROS_ERROR_STREAM(
                "duplicated laneId: " << foundWaypoints->first <<
                " in mWaypointMap");
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        const auto foundRouteWaypoints{mRouteWaypointMap.find(waypointValue["lane_id"].asInt())};
        if (mRouteWaypointMap.end() == foundRouteWaypoints)
        {
            mRouteWaypointMap.insert(std::make_pair(waypointValue["lane_id"].asInt(), routeWaypoints));
        }
        else
        {
            ROS_ERROR_STREAM(
                "duplicated laneId: " << foundRouteWaypoints->first <<
                " in mRouteWaypointMap");
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        const auto foundIndexedRouteWaypoints{
            mIndexedRouteWaypointMap.find(waypointValue["lane_id"].asInt())};
        if (mIndexedRouteWaypointMap.end() == foundIndexedRouteWaypoints)
        {
            mIndexedRouteWaypointMap.insert(
                std::make_pair(waypointValue["lane_id"].asInt(), indexedRouteWaypoints));
        }
        else
        {
            ROS_ERROR_STREAM(
                "duplicated laneId: " << foundIndexedRouteWaypoints->first <<
                " in mIndexedRouteWaypointMap");
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }
}

void WaypointManager::ParseLanesInfo(const std::string &lanesInfoFileName)
{
    std::ifstream lanesInfoFileStream;
    lanesInfoFileStream.open(lanesInfoFileName, std::ifstream::in);
    if (!lanesInfoFileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << lanesInfoFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value lanesInfoJsonValue;
    jsonReader.parse(lanesInfoFileStream, lanesInfoJsonValue);
    lanesInfoFileStream.close();

    for (const auto &laneInfoValue: lanesInfoJsonValue["lanes"])
    {
        std::vector<int32_t> connectedLaneIds(laneInfoValue["next_clane"].size());
        auto connectedLaneId{connectedLaneIds.begin()};
        for (const auto &nextLaneId: laneInfoValue["next_clane"])
        {
            *connectedLaneId = nextLaneId.asInt();
            ++connectedLaneId;
        }

        mConnectedLaneIdMap.insert(
            std::make_pair(laneInfoValue["id"].asInt(), connectedLaneIds));
    }
}

void WaypointManager::ValidatePointId(const int32_t laneId, const int32_t pointId) const
{
    const auto foundWaypoints{mWaypointMap.find(laneId)};
    if (mWaypointMap.end() == foundWaypoints)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (pointId < int32_t{1} || pointId > static_cast<int32_t>(foundWaypoints->second.size()))
    {
        ROS_ERROR_STREAM("invalid pointId: " << pointId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

} // namespace path {
