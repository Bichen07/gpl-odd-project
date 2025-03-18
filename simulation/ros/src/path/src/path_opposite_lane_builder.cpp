#include <path_opposite_lane_builder.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <utils_json.h>

namespace path {

// public func.

OppositeLaneBuilder::OppositeLaneBuilder()
    : mLanesNavgroadMap{}
    , mBeginNavgroadMap{}
    , mConnectedLaneEvaluator{nullptr}
{
}

void OppositeLaneBuilder::Configure(
    const std::string &lanesNavgroadsFileName,
    ConnectedLaneEvaluator::Ptr &connectedLaneEvaluator)
{
    std::ifstream lanesNavgroadsFileStream;
    lanesNavgroadsFileStream.open(lanesNavgroadsFileName, std::ifstream::in);
    if (!lanesNavgroadsFileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << lanesNavgroadsFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value lanesNavgroadsJsonValue;
    jsonReader.parse(lanesNavgroadsFileStream, lanesNavgroadsJsonValue);
    lanesNavgroadsFileStream.close();
    for (const auto &lanesNavgroadValue: lanesNavgroadsJsonValue["lanes_navgroads"])
    {
        const int32_t laneId{
            utils::GetIntJsonValue(lanesNavgroadValue["lane_id"])};
        const NavgroadEndpoint begin = NavgroadEndpoint
        {
            .navgroadId = utils::GetIntJsonValue(lanesNavgroadValue["navgroad1"]),
            .direction = path::EvaluateDirection(
                utils::GetIntJsonValue(lanesNavgroadValue["isPositive1"])),
        };
        const NavgroadEndpoint end = NavgroadEndpoint
        {
            .navgroadId = utils::GetIntJsonValue(lanesNavgroadValue["navgroad2"]),
            .direction = path::EvaluateDirection(
                utils::GetIntJsonValue(lanesNavgroadValue["isPositive2"])),
        };

        const LanesNavgroad lanesNavgroad(laneId, begin, end);
        const bool isSuccessfulEmplace{
            mLanesNavgroadMap.emplace(
                laneId,
                lanesNavgroad).second};
        if (!isSuccessfulEmplace)
        {
            ROS_ERROR_STREAM("fail to emplace LanesNavgroad, laneId: " << laneId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        mBeginNavgroadMap.emplace(
            begin.navgroadId,
            lanesNavgroad);
    }

    mConnectedLaneEvaluator = connectedLaneEvaluator;
}

void OppositeLaneBuilder::ComputeOppositeLaneIdsArray(
    const LaneIds &forwardLaneIds,
    LaneIdsArray &oppositeLaneIdsArray)
{
    for (auto forwardLaneId{forwardLaneIds.cbegin()};
         forwardLaneId != forwardLaneIds.cend();
         ++forwardLaneId)
    {
        const auto foundForwardLanesNavgroadPair{
            mLanesNavgroadMap.find(*forwardLaneId)};
        if (mLanesNavgroadMap.end() == foundForwardLanesNavgroadPair)
        {
            ROS_ERROR_STREAM("invalid forwardLaneId: " << *forwardLaneId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        const auto queriesOppositeLaneIds{
            this->QueryOppositeLanes(foundForwardLanesNavgroadPair->second)};
    }
}

// protected func.

// private func.

LaneIds OppositeLaneBuilder::QueryOppositeLanes(
    const LanesNavgroad &forwardLanesNavgroad) const
{
    LaneIds outputLaneIds;
    outputLaneIds.reserve(std::size_t{10});
    const auto foundRange{
        mBeginNavgroadMap.equal_range(forwardLanesNavgroad.begin.navgroadId)};
    for (auto foundPair{foundRange.first}; foundPair != foundRange.second; ++foundPair)
    {
        const bool isOppositeLanesNavgroad =
            foundPair->second.begin.navgroadId == forwardLanesNavgroad.end.navgroadId &&
            foundPair->second.begin.direction != forwardLanesNavgroad.end.direction &&
            foundPair->second.end.navgroadId == forwardLanesNavgroad.begin.navgroadId &&
            foundPair->second.end.direction != forwardLanesNavgroad.begin.direction;
        if (isOppositeLanesNavgroad)
        {
            outputLaneIds.push_back(foundPair->second.laneId);
        }
    }

    outputLaneIds.shrink_to_fit();
    return outputLaneIds;
}

void OppositeLaneBuilder::AppendOppositeLanes(
    const LaneIds &newLaneIds,
    LaneIdsArray &outputLaneIdsArray)
{
    std::map<int32_t, bool> newLaneIdAppendingRecord;
    for (auto newLaneId{newLaneIds.cbegin()};
         newLaneId != newLaneIds.cend();
         ++newLaneId)
    {
        const bool isSuccessfulEmplace{
            newLaneIdAppendingRecord.emplace(
                *newLaneId,
                false).second};
        if (!isSuccessfulEmplace)
        {
            ROS_ERROR_STREAM(
                "duplicated newLaneId: " << *newLaneId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }

    for (auto outputLaneIds{outputLaneIdsArray.begin()};
         outputLaneIds != outputLaneIdsArray.end();
         ++outputLaneIds)
    {
        for (auto newLaneId{newLaneIds.cbegin()};
             newLaneId != newLaneIds.cend();
             ++newLaneId)
        {
            const bool isConnectedLanePair{
                mConnectedLaneEvaluator->IsConnectedLanePair(
                    outputLaneIds->back(),
                    *newLaneId)};
            if (isConnectedLanePair)
            {
                outputLaneIds->push_back(*newLaneId);
                auto foundNewLaneIdPair{newLaneIdAppendingRecord.find(*newLaneId)};
                if (newLaneIdAppendingRecord.end() == foundNewLaneIdPair)
                {
                    ROS_ERROR_STREAM(
                        "invalid newLaneId: " << *newLaneId);
                    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
                }
            }
        }
    }

    for (auto appendingRecord{newLaneIdAppendingRecord.cbegin()};
         appendingRecord != newLaneIdAppendingRecord.cend();
         ++appendingRecord)
    {
        if (!appendingRecord->second)
        {
            LaneIds adjacentLaneIds(std::size_t{1}, appendingRecord->first);
            outputLaneIdsArray.push_back(adjacentLaneIds);
        }
    }
}

} // namespace path {
