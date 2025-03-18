#include <map_bus_station_manager.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <utils_json.h>

namespace map {

// public func.

BusStationManager::BusStationManager()
    : mBusStationMap{}
{
}

BusStationManager::~BusStationManager()
{
}

const std::map<int32_t, BusStation> &BusStationManager::GetBusStationMap() const
{
    return mBusStationMap;
}

const bool BusStationManager::QueryBusStation(
    const int32_t id,
    BusStation *outputBusStation) const
{
    if (nullptr == outputBusStation)
    {
        ROS_ERROR_STREAM("outputBusStation is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto foundBusStation{mBusStationMap.find(id)};
    if (mBusStationMap.end() == foundBusStation)
    {
        return false;
    }

    *outputBusStation = foundBusStation->second;

    return true;
}

void BusStationManager::Configure(const std::string &busStationFileName)
{
    Json::Value busStationJsonValue;
    utils::ParseJsonValue(busStationFileName, &busStationJsonValue);
    static constexpr const char *stationsKey{"stations"};
    if (!utils::IsMemberKey(busStationJsonValue, stationsKey))
    {
        ROS_ERROR_STREAM("invalid key: " << stationsKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    for (const auto &busStationValue: busStationJsonValue[stationsKey])
    {
        const math::Vector3d_t center(
            utils::GetDoubleJsonValue(busStationValue["center_point"]["x"]),
            utils::GetDoubleJsonValue(busStationValue["center_point"]["y"]),
            utils::GetDoubleJsonValue(busStationValue["center_point"]["z"]));
        const int32_t id{utils::GetIntJsonValue(busStationValue["id"])};

        std::map<int32_t, std::vector<int32_t>> lanePointIdMap;
        std::vector<int32_t> laneIds(busStationValue["lanes"].size());
        auto laneId{laneIds.begin()};
        for (const auto &laneValue: busStationValue["lanes"])
        {
            *laneId = utils::GetIntJsonValue(laneValue["lane_id"]);
            std::vector<int32_t> pointIds(laneValue["pointIds"].size());
            auto pointId{pointIds.begin()};
            for (const auto &pointIdValue: laneValue["pointIds"])
            {
                *pointId = utils::GetIntJsonValue(pointIdValue);
                ++pointId;
            }

            lanePointIdMap.insert(std::make_pair(*laneId, pointIds));
            ++laneId;
        }

        std::vector<math::Vector3d_t> points(busStationValue["points"].size());
        auto point{points.begin()};
        for (const auto &pointValue: busStationValue["points"])
        {
            *point = math::Vector3d_t(
                utils::GetDoubleJsonValue(pointValue["x"]),
                utils::GetDoubleJsonValue(pointValue["y"]),
                utils::GetDoubleJsonValue(pointValue["z"]));
            ++point;
        }

        const BusStation busStation(
            center,
            id,
            laneIds,
            lanePointIdMap,
            points);
        mBusStationMap.insert(std::make_pair(id, busStation));
    }
}

// protected func.

// private func.

} // namespace map {
