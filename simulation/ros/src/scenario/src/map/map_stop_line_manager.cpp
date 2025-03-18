#include <map_stop_line_manager.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <route_mission_handler/common_utils/utils.h>
#include <utils_json.h>

namespace map {

// public func.

StopLineManager::StopLineManager()
    : mStopLineMap{}
{
}

StopLineManager::~StopLineManager()
{
}

const std::map<int32_t, StopLine> &StopLineManager::GetStopLineMap() const
{
    return mStopLineMap;
}

const StopLine StopLineManager::QueryStopLine(const int32_t id) const
{
    const auto foundStopLine{mStopLineMap.find(id)};
    if (mStopLineMap.end() == foundStopLine)
    {
        ROS_ERROR_STREAM("invalid id: " << id);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundStopLine->second;
}

const bool StopLineManager::QueryStopLine(const int32_t id, StopLine *outputStopLine) const
{
    const auto foundStopLine{mStopLineMap.find(id)};
    if (mStopLineMap.end() == foundStopLine)
    {
        return false;
    }

    if (nullptr == outputStopLine)
    {
        ROS_ERROR_STREAM("outputStopLine is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    *outputStopLine = foundStopLine->second;

    return true;
}

const bool StopLineManager::QueryStopLines(
    const int32_t id,
    std::vector<StopLine> *outputStopLines) const
{
    if (nullptr == outputStopLines)
    {
        ROS_ERROR_STREAM("outputStopLines is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputStopLines->clear();
    for (auto stopLinePair{mStopLineMap.cbegin()};
         stopLinePair != mStopLineMap.cend();
         ++stopLinePair)
    {
        const auto lanePointIdMap{stopLinePair->second.GetLanePointIdMap()};
        for (auto lanePointIdPair{lanePointIdMap.cbegin()};
             lanePointIdPair != lanePointIdMap.cend();
             ++lanePointIdPair)
        {
            if (id == lanePointIdPair->first)
            {
                outputStopLines->push_back(stopLinePair->second);
            }
        }
    }

    return outputStopLines->empty() ? false : true;
}

void StopLineManager::Configure(const std::string &roadMarkerFileName)
{
    std::ifstream roadMarkerFileStream;
    roadMarkerFileStream.open(roadMarkerFileName, std::ifstream::in);
    if (!roadMarkerFileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << roadMarkerFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value roadMarkerJsonValue;
    jsonReader.parse(roadMarkerFileStream, roadMarkerJsonValue);
    roadMarkerFileStream.close();

    for (const auto &roadMarkerValue: roadMarkerJsonValue["roadmarkers"])
    {
        if (static_cast<int32_t>(LaneType::STOP_LINE) != roadMarkerValue["type"].asInt())
        {
            continue;
        }

        std::vector<math::Vector3d_t> corners(roadMarkerValue["points"].size());
        auto corner{corners.begin()};
        for (const auto &cornerValue: roadMarkerValue["points"])
        {
            *corner = math::Vector3d_t(
                utils::GetDoubleJsonValue(cornerValue["x"]),
                utils::GetDoubleJsonValue(cornerValue["y"]),
                utils::GetDoubleJsonValue(cornerValue["z"]));
            ++corner;
        }

        std::map<int32_t, std::vector<int32_t>> lanePointIdMap;
        for (const auto &laneValue: roadMarkerValue["lanes"])
        {
            const int32_t laneId{utils::GetIntJsonValue(laneValue["lane_id"])};
            std::vector<int32_t> pointIds(laneValue["pointIds"].size());
            auto pointId{pointIds.begin()};
            for (const auto &pointIdValue: laneValue["pointIds"])
            {
                *pointId = utils::GetIntJsonValue(pointIdValue);
                ++pointId;
            }

            lanePointIdMap.insert(std::make_pair(laneId, pointIds));
        }

        mStopLineMap.insert(
            std::make_pair(
                roadMarkerValue["id"].asInt(),
                StopLine(corners, lanePointIdMap)));
    }
}

// protected func.

// private func.

} // namespace map {
