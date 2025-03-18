#include <map_parking_space_manager.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <utils_json.h>

namespace map {

// public func.

ParkingSpaceManager::ParkingSpaceManager()
    : mParkingLotMap{}
{
}

ParkingSpaceManager::~ParkingSpaceManager()
{
}

const std::map<int32_t, ParkingLot> &ParkingSpaceManager::GetParkingLotMap() const
{
    return mParkingLotMap;
}

const ParkingLot ParkingSpaceManager::QueryParkingLot(const int32_t parkingLotId) const 
{
    const auto foundParkingLot{mParkingLotMap.find(parkingLotId)};
    if (mParkingLotMap.end() == foundParkingLot)
    {
        ROS_ERROR_STREAM("invalid parkingLotId: " << parkingLotId);
        std::cout << "valid parkingLotId: ";
        for (const auto &parkingLotPair: mParkingLotMap)
        {
            std::cout << parkingLotPair.first << ", ";
        }
        std::cout << std::endl;

        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundParkingLot->second;
}

void ParkingSpaceManager::Configure(
    const std::string &parkingSpaceFileName,
    const std::string &parsingTag)
{
    Json::Value parkingSpaceJsonValue;
    utils::ParseJsonValue(parkingSpaceFileName, &parkingSpaceJsonValue);
    if (!parkingSpaceJsonValue.isMember(parsingTag))
    {
        ROS_ERROR_STREAM(parsingTag << " is an invalid tag");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    for (const auto &parkingSpaceValue: parkingSpaceJsonValue[parsingTag])
    {
        const int32_t parkingLotId{utils::GetIntJsonValue(parkingSpaceValue["parkinglot_id"])};
        const int32_t spaceId{utils::GetIntJsonValue(parkingSpaceValue["space_id"])};
        const int32_t laneId{utils::GetIntJsonValue(parkingSpaceValue["lane_id"])};
        const int32_t pointId{utils::GetIntJsonValue(parkingSpaceValue["point_id"])};
        const auto orientationType{
            static_cast<ParkingSpace::OrientationType>(
                utils::GetIntJsonValue(parkingSpaceValue["type"]))};
        std::vector<math::Vector3d_t> corners(parkingSpaceValue["points"].size());
        auto corner{corners.begin()};
        for (const auto &pointValue: parkingSpaceValue["points"])
        {
            *corner = math::Vector3d_t(
                pointValue["x"].asDouble(),
                pointValue["y"].asDouble(),
                pointValue["z"].asDouble());
            ++corner;
        }

        const ParkingSpace parkingSpace(
            parkingLotId,
            spaceId,
            laneId,
            pointId,
            orientationType,
            corners);
        auto foundParkingLot{mParkingLotMap.find(parkingLotId)};
        if (mParkingLotMap.end() == foundParkingLot)
        {
            mParkingLotMap.insert(
                std::make_pair(
                    parkingLotId,
                    ParkingLot(parkingLotId, std::vector<ParkingSpace>{parkingSpace}))
                );
        }
        else
        {
            foundParkingLot->second.parkingSpaces.push_back(parkingSpace);
        }
    }
}

// protected func.

// private func.

} // namespace map {
