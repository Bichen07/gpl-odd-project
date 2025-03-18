#include <path_connected_lane_evaluator.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <utils_json.h>

namespace path {

// public func.

ConnectedLaneEvaluator::ConnectedLaneEvaluator()
    : mNextLaneIdMap{}
{
}

void ConnectedLaneEvaluator::Configure(const std::string &lanesInfoFileName)
{
    this->ParseLanesInfo(lanesInfoFileName);
}

bool ConnectedLaneEvaluator::IsConnectedLanePair(
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

// protected func.

// private func.

void ConnectedLaneEvaluator::ParseLanesInfo(const std::string &lanesInfoFileName)
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
            *nextLaneId = utils::GetIntJsonValue(connectedLaneId);
            ++nextLaneId;
        }

        const int32_t currentLaneId{utils::GetIntJsonValue(laneInfoValue["id"])};
        const bool isSuccessfulEmplace{
            mNextLaneIdMap.emplace(
                currentLaneId,
                nextLaneIds).second};
        if (!isSuccessfulEmplace)
        {
            ROS_ERROR_STREAM(
                "duplicated currentLaneId: " << currentLaneId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }
}

} // namespace path {
