#include <map_waypoint_manager.h>
#include <fstream>
#include <iterator>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <math_utils.h>
#include <math_quadratic_bezier_curve.h>

namespace map {

// public func.

WaypointManager::WaypointManager()
    : mWaypointMap{}
    , mConnectedLaneIdMap{}
    , mCubicSplineControlPoints{}
{
}

WaypointManager::~WaypointManager()
{
}

const std::vector<math::Vector3d_t> &WaypointManager::GetCubicSplineControlPoints() const
{
    return mCubicSplineControlPoints;
}

std::vector<math::Vector3d_t> WaypointManager::QueryWaypoints(const int32_t laneId) const
{
    const auto foundWaypoints{mWaypointMap.find(laneId)};
    if (mWaypointMap.end() == foundWaypoints)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundWaypoints->second;
}

std::vector<math::Vector3d_t> WaypointManager::QueryWaypoints(
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

    const auto outputWaypoints = std::vector<math::Vector3d_t>(
        foundWaypoints->second.cbegin() + beginPointId - 1,
        foundWaypoints->second.cbegin() + endPointId);

    return outputWaypoints;
}

std::vector<math::Vector3d_t> WaypointManager::QueryWaypoints(
    const std::vector<int32_t> &connectedLaneIds) const
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
    std::vector<math::Vector3d_t> outputWaypoints;
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

std::vector<math::Vector3d_t> WaypointManager::QueryWaypoints(
    const std::vector<int32_t> &connectedLaneIds,
    const int32_t beginPointId,
    const int32_t endPointId) const
{
    if (connectedLaneIds.empty())
    {
        ROS_WARN_STREAM("connectedLaneIds is empty");
        return std::vector<math::Vector3d_t>();
    }

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

    this->ValidatePointId(connectedLaneIds.front(), beginPointId);

    static constexpr std::size_t waypointSizeHint{30};
    std::vector<math::Vector3d_t> outputWaypoints;
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

std::vector<math::Vector3d_t> WaypointManager::QueryWaypoints(
    const std::vector<int32_t> &precedingLaneIds,
    const std::vector<int32_t> &succeedingLaneIds,
    const int32_t beginPointId,
    const int32_t endPointId)
{
    if (precedingLaneIds.empty() && succeedingLaneIds.empty())
    {
        ROS_WARN_STREAM(
            "precedingLaneIds and succeedingLaneIds are empty");
        return std::vector<math::Vector3d_t>();
    }

    if (succeedingLaneIds.empty())
    {
        ROS_WARN_STREAM("succeedingLaneIds is empty");
        return this->QueryWaypoints(
            precedingLaneIds,
            beginPointId,
            endPointId);
    }

    if (precedingLaneIds.empty())
    {
        ROS_WARN_STREAM("precedingLaneIds is empty");
        return this->QueryWaypoints(
            succeedingLaneIds,
            beginPointId,
            endPointId);
    }

    const bool isConnectedPrecedingSucceedingLaneIds =
        this->IsConnectedLaneIds(
            precedingLaneIds.back(),
            succeedingLaneIds.front());

    if (isConnectedPrecedingSucceedingLaneIds)
    {
        std::vector<int32_t> connectedLaneIds;
        connectedLaneIds.reserve(
            precedingLaneIds.size() +
            succeedingLaneIds.size());
        connectedLaneIds.insert(
            connectedLaneIds.cend(),
            precedingLaneIds.cbegin(),
            precedingLaneIds.cend());
        connectedLaneIds.insert(
            connectedLaneIds.cend(),
            succeedingLaneIds.cbegin(),
            succeedingLaneIds.cend());
        return this->QueryWaypoints(
            connectedLaneIds,
            beginPointId,
            endPointId);
    }

    return this->GenerateConnectedWaypoints(
        precedingLaneIds,
        beginPointId,
        succeedingLaneIds,
        endPointId);
}

std::vector<int32_t> WaypointManager::QueryNextConnectedLaneIds(const int32_t laneId) const
{
    if (mConnectedLaneIdMap.empty())
    {
        ROS_ERROR_STREAM("mConnectedLaneIdMap is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto foundConnectedLaneIdPair{mConnectedLaneIdMap.find(laneId)};
    if (mConnectedLaneIdMap.end() == foundConnectedLaneIdPair)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundConnectedLaneIdPair->second;
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

bool WaypointManager::IsConnectedLaneIds(const std::vector<int32_t> &laneIdSequence) const
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
        std::vector<math::Vector3d_t> waypoints;
        waypoints.reserve(waypointValue["points"].size());
        for (const auto &pointValue: waypointValue["points"])
        {
            waypoints.push_back(
                math::Vector3d_t(
                    pointValue["x"].asDouble(),
                    pointValue["y"].asDouble(),
                    pointValue["z"].asDouble()));
        }

        const auto foundWaypoints{mWaypointMap.find(waypointValue["lane_id"].asInt())};
        if (mWaypointMap.end() == foundWaypoints)
        {
            mWaypointMap.insert(std::make_pair(waypointValue["lane_id"].asInt(), waypoints));
        }
        else
        {
            ROS_ERROR_STREAM("duplicated laneId: " << foundWaypoints->first);
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

std::vector<math::Vector3d_t> WaypointManager::GenerateConnectedWaypoints(
    const std::vector<int32_t> &precedingLaneIds,
    const int32_t precedingBeginPointId,
    const std::vector<int32_t> &succeedingLaneIds,
    const int32_t succeedingEndPointId)
{
    const int32_t precedingEndPointId{this->QueryEndPointId(precedingLaneIds.back())};
    const auto precedingWaypoints{
        this->QueryWaypoints(
            precedingLaneIds,
            precedingBeginPointId,
            precedingEndPointId)};
    const auto succeedingWaypoints{
        this->QueryWaypoints(
            succeedingLaneIds,
            int32_t{1},
            succeedingEndPointId)};

    const auto beginWaypoint{precedingWaypoints.back()};
    const auto endWaypoint{succeedingWaypoints.front()};
    const auto beginVector =
        precedingWaypoints.back() -
        precedingWaypoints.at(precedingWaypoints.size() - 2ul);
    const auto endVector =
        succeedingWaypoints.at(1ul) -
        succeedingWaypoints.front();
    const auto pathLength{(endWaypoint - beginWaypoint).norm()};
    const int32_t waypointSize{static_cast<int32_t>(std::round(pathLength))};

    const math::Vector3d_t beginSplineControlPoint =
        beginWaypoint + math::real_t{10.0} * beginVector.normalized();
    const math::Vector3d_t middleSplineControlPoint =
        math::real_t{0.5} * (beginWaypoint + endWaypoint);
    const math::Vector3d_t endSplineControlPoint =
        endWaypoint - math::real_t{10.0} * endVector.normalized();

    mCubicSplineControlPoints.clear();
    mCubicSplineControlPoints.resize(5);
    mCubicSplineControlPoints[0] = beginWaypoint;
    mCubicSplineControlPoints[1] = beginSplineControlPoint;
    mCubicSplineControlPoints[2] = middleSplineControlPoint;
    mCubicSplineControlPoints[3] = endSplineControlPoint;
    mCubicSplineControlPoints[4] = endWaypoint;
    math::QuadraticBezierCurve bezierCurve;
    const auto firstWaypoints = bezierCurve.Compute(
        beginWaypoint,
        beginSplineControlPoint,
        middleSplineControlPoint,
        waypointSize >> 1);
    const auto secondWaypoints = bezierCurve.Compute(
        middleSplineControlPoint,
        endSplineControlPoint,
        endWaypoint,
        waypointSize >> 1);
    std::vector<math::Vector3d_t> interpolatedWaypoints;
    interpolatedWaypoints.reserve(
        firstWaypoints.size() + secondWaypoints.size());
    interpolatedWaypoints.insert(
        interpolatedWaypoints.cend(),
        firstWaypoints.cbegin(),
        firstWaypoints.cend());
    interpolatedWaypoints.insert(
        interpolatedWaypoints.cend(),
        secondWaypoints.cbegin(),
        secondWaypoints.cend());

    std::vector<math::Vector3d_t> outputWaypoints;
    outputWaypoints.reserve(
        precedingWaypoints.size() +
        interpolatedWaypoints.size() +
        succeedingWaypoints.size());
    outputWaypoints.insert(
        outputWaypoints.cend(),
        precedingWaypoints.cbegin(),
        precedingWaypoints.cend());
    outputWaypoints.insert(
        outputWaypoints.cend(),
        interpolatedWaypoints.cbegin(),
        interpolatedWaypoints.cend());
    outputWaypoints.insert(
        outputWaypoints.cend(),
        succeedingWaypoints.cbegin(),
        succeedingWaypoints.cend());

    return outputWaypoints;
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

} // namespace map {
