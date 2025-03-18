#include <map_traffic_light_manager.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <utils_json.h>

namespace map {

// public func.

TrafficLightManager::TrafficLightManager()
    : mTrafficLightMap{}
{
}

const std::map<int32_t, TrafficLight> &TrafficLightManager::GetTrafficLightMap() const
{
    return mTrafficLightMap;
}

const TrafficLight &TrafficLightManager::QueryTrafficLight(const int32_t id) const
{
    const auto foundTrafficLight{mTrafficLightMap.find(id)};
    if (mTrafficLightMap.end() == foundTrafficLight)
    {
        ROS_ERROR_STREAM("invalid id: " << id);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundTrafficLight->second;
}

const bool TrafficLightManager::QueryTrafficLight(
    const int32_t id,
    TrafficLight &outputTrafficLight) const
{
    const auto foundTrafficLight{mTrafficLightMap.find(id)};
    if (mTrafficLightMap.end() == foundTrafficLight)
    {
        return false;
    }

    outputTrafficLight = foundTrafficLight->second;

    return true;
}

void TrafficLightManager::Configure(const std::string &trafficLightFileName)
{
    std::ifstream trafficLightFileStream;
    trafficLightFileStream.open(trafficLightFileName, std::ifstream::in);
    if (!trafficLightFileStream.good())
    {
        ROS_ERROR_STREAM("fail to oepn " << trafficLightFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value trafficLightJsonValue;
    jsonReader.parse(trafficLightFileStream, trafficLightJsonValue);
    trafficLightFileStream.close();

    for (const auto &trafficLightValue: trafficLightJsonValue["traffic_light"])
    {
        std::vector<math::Vector3d_t> corners(trafficLightValue["points"].size());
        auto corner{corners.begin()};
        for (const auto &cornerValue: trafficLightValue["points"])
        {
            *corner = math::Vector3d_t(
                utils::GetDoubleJsonValue(cornerValue["x"]),
                utils::GetDoubleJsonValue(cornerValue["y"]),
                utils::GetDoubleJsonValue(cornerValue["z"]));
            ++corner;
        }

        const int32_t id{utils::GetIntJsonValue(trafficLightValue["id"])};
        TrafficLight trafficLight(id, corners);
        if (!mTrafficLightMap.emplace(id, trafficLight).second)
        {
            ROS_ERROR_STREAM("duplicated id: " << id);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }
}

// protected func.

// private func.

} // namespace map {
