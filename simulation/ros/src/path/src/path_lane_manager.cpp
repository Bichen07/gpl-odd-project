#include <path_lane_manager.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <utils_json.h>

namespace path {

// public func.

LaneManager::LaneManager()
    : mNextLaneIdMap{}
    , mLaneNavgroadMap{}
{
}

void LaneManager::Configure(
    const std::string &lanesInfoFileName,
    const std::string &lanesNavgroadFileName)
{
    this->ParseLanesInfo(lanesInfoFileName);
    this->ParseLaneNavgroads(lanesNavgroadFileName);
}

const LaneManager::NavgroadPair &LaneManager::QueryNavgroad(const int32_t laneId) const
{
    const auto &foundNavgroad{
        mLaneNavgroadMap.find(laneId)};
    if (mLaneNavgroadMap.end() == foundNavgroad)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundNavgroad->second;
}

bool LaneManager::IsConnectedLaneIdPair(
    const int32_t precedingLaneId,
    const int32_t succeedingLaneId) const
{
    if (mNextLaneIdMap.empty())
    {
        ROS_ERROR_STREAM("mNextLaneIdMap is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto foundNextLaneIdPair{
        mNextLaneIdMap.find(precedingLaneId)};
    if (mNextLaneIdMap.end() == foundNextLaneIdPair)
    {
        ROS_ERROR_STREAM(
            "invalid precedingLaneId: " << precedingLaneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto foundSucceedingLaneId{
        std::find(
            foundNextLaneIdPair->second.cbegin(),
            foundNextLaneIdPair->second.cend(),
            succeedingLaneId)};

    return foundNextLaneIdPair->second.cend() != foundSucceedingLaneId;
}

bool LaneManager::IsAdjacentLanePair(
    const int32_t firstLaneId,
    const int32_t secondLaneId) const
{
    if (this->IsConnectedLaneIdPair(firstLaneId, secondLaneId) || 
        this->IsConnectedLaneIdPair(secondLaneId, firstLaneId))
    {
        return false;
    }

    const auto &firstLaneNavgroad{
        this->QueryNavgroad(firstLaneId)};
    const auto &secondLaneNavgroad{
        this->QueryNavgroad(secondLaneId)};

    const bool isAdjacentLanePair =
        firstLaneNavgroad.first == secondLaneNavgroad.first &&
        firstLaneNavgroad.second == secondLaneNavgroad.second;

    return isAdjacentLanePair;
}

bool LaneManager::IsOppositeLanePair(
    const int32_t forwardLaneId,
    const int32_t oppositeLaneId) const
{
    const auto &forwardLaneNavgroad{
        this->QueryNavgroad(forwardLaneId)};
    const auto &oppositeLaneNavgroad{
        this->QueryNavgroad(oppositeLaneId)};

    const bool isOppositeLanePair =
        forwardLaneNavgroad.first.navgroadId == oppositeLaneNavgroad.second.navgroadId &&
        forwardLaneNavgroad.first.direction != oppositeLaneNavgroad.second.direction &&
        forwardLaneNavgroad.second.navgroadId == oppositeLaneNavgroad.first.navgroadId &&
        forwardLaneNavgroad.second.direction != oppositeLaneNavgroad.first.direction;

    return isOppositeLanePair;
}

// protected func.

// private func.

void LaneManager::ParseLanesInfo(const std::string &lanesInfoFileName)
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
        LaneIds nextLaneIds(laneInfoValue["next_clane"].size());
        auto nextLaneId{nextLaneIds.begin()};
        for (const auto &connectedLaneId: laneInfoValue["next_clane"])
        {
            *nextLaneId = connectedLaneId.asInt();
            ++nextLaneId;
        }
        mNextLaneIdMap.insert(
            std::make_pair(
                utils::GetIntJsonValue(laneInfoValue["id"]),
                nextLaneIds));
    }
}

void LaneManager::ParseLaneNavgroads(const std::string &lanesNavgroadFileName)
{
    std::ifstream navgroadFileStream;
    navgroadFileStream.open(lanesNavgroadFileName, std::ifstream::in);
    if (!navgroadFileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << lanesNavgroadFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value navgroadJsonValue;
    jsonReader.parse(navgroadFileStream, navgroadJsonValue);
    navgroadFileStream.close();

    for (const auto &navgroadValue: navgroadJsonValue["lanes_navgroads"])
    {
        const int32_t laneId = utils::GetIntJsonValue(
            navgroadValue["lane_id"]);
        const NavgroadEndpoint begin = NavgroadEndpoint
        {
            .navgroadId =
                utils::GetIntJsonValue(navgroadValue["navgroad1"]),
            .direction = path::EvaluateDirection(
                utils::GetIntJsonValue(navgroadValue["isPositive1"])),
        };
        const NavgroadEndpoint end = NavgroadEndpoint
        {
            .navgroadId =
                utils::GetIntJsonValue(navgroadValue["navgroad2"]),
            .direction = path::EvaluateDirection(
                utils::GetIntJsonValue(navgroadValue["isPositive2"])),
        };

        mLaneNavgroadMap.insert(
            std::make_pair(
                laneId,
                std::make_pair(begin, end)));
    }
}

} // namespace path {
