#include <map_crosswalk_manager.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>

namespace map {

// public func.

CrosswalkManager::CrosswalkManager()
    : mCrosswalkMap{}
{
}

CrosswalkManager::~CrosswalkManager()
{
}

const std::map<int32_t, Crosswalk> &CrosswalkManager::GetCrosswalkMap() const
{
    return mCrosswalkMap;
}

const Crosswalk CrosswalkManager::QueryCrosswalk(const int32_t id) const
{
    const auto foundCrosswalk{mCrosswalkMap.find(id)};
    if (mCrosswalkMap.end() == foundCrosswalk)
    {
        ROS_ERROR_STREAM("invalid id: " << id);
        std::cout << "crosswalk size: " << mCrosswalkMap.size() << std::endl;
        std::cout << "valid crosswalk id: ";
        for (const auto &crosswalkPair: mCrosswalkMap)
        {
            std::cout << crosswalkPair.first << ", ";
        }
        std::cout << std::endl;

        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundCrosswalk->second;
}

void CrosswalkManager::Configure(const std::string &crosswalkFileName)
{
    std::ifstream crosswalkFileStream;
    crosswalkFileStream.open(crosswalkFileName, std::ifstream::in);
    if (!crosswalkFileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << crosswalkFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        return;
    }

    Json::Reader jsonReader;
    Json::Value crosswalkJsonValue;
    jsonReader.parse(crosswalkFileStream, crosswalkJsonValue);
    crosswalkFileStream.close();

    const std::string parsingTag{"pedestrian_crossing"};
    if (crosswalkJsonValue[parsingTag].empty())
    {
        ROS_ERROR_STREAM(parsingTag << "have no contents");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    for (const auto &crosswalkValue: crosswalkJsonValue[parsingTag])
    {
        std::vector<math::Vector3d_t> corners(crosswalkValue["points"].size());
        auto corner{corners.begin()};
        for (const auto &cornerValue: crosswalkValue["points"])
        {
            *corner = math::Vector3d_t(
                cornerValue["x"].asDouble(),
                cornerValue["y"].asDouble(),
                cornerValue["z"].asDouble());
            ++corner;
        }

        mCrosswalkMap.insert(
            std::make_pair(
                crosswalkValue["id"].asInt(),
                Crosswalk(corners)));
    }
}

// protected func.

// private func.

} // namespace map {
