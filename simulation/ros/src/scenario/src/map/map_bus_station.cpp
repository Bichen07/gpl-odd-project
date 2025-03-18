#include <map_bus_station.h>
#include <stdexcept>
#include <ros/console.h>

namespace map {

// public func.

BusStation::BusStation()
    : mCenter{}
    , mId{0}
    , mLaneIds{}
    , mLanePointIdMap{}
    , mPoints{}
{
}

BusStation::BusStation(
    const math::Vector3d_t &center,
    const int32_t id,
    const std::vector<int32_t> &laneIds,
    const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap,
    const std::vector<math::Vector3d_t> &points)
    : mCenter{center}
    , mId{id}
    , mLaneIds{laneIds}
    , mLanePointIdMap{lanePointIdMap}
    , mPoints{points}
{
}

BusStation::BusStation(const BusStation &other)
    : mCenter{other.GetCenter()}
    , mId{other.GetId()}
    , mLaneIds{other.GetLaneIds()}
    , mLanePointIdMap{other.GetLanePointIdMap()}
    , mPoints{other.GetPoints()}
{
}

BusStation &BusStation::operator=(const BusStation &other)
{
    if (&other == this)
    {
        return *this;
    }

    mCenter = other.GetCenter();
    mId = other.GetId();
    mLaneIds = other.GetLaneIds();
    mLanePointIdMap = other.GetLanePointIdMap();
    mPoints = other.GetPoints();

    return *this;
}

BusStation::~BusStation()
{
}

math::Vector3d_t BusStation::GetCenter() const
{
    return mCenter;
}

int32_t BusStation::GetId() const
{
    return mId;
}

const std::vector<int32_t> &BusStation::GetLaneIds() const
{
    return mLaneIds;
}

const std::map<int32_t, std::vector<int32_t>> &BusStation::GetLanePointIdMap() const
{
    return mLanePointIdMap;
}

const std::vector<int32_t> &BusStation::GetPointIds(const int32_t laneId) const
{
    const auto foundLanePointIdPair{mLanePointIdMap.find(laneId)};
    if (mLanePointIdMap.end() == foundLanePointIdPair)
    {
        ROS_ERROR_STREAM("invalid laneId: " << laneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundLanePointIdPair->second;
}

const std::vector<math::Vector3d_t> &BusStation::GetPoints() const
{
    return mPoints;
}

void BusStation::Configure(
    const math::Vector3d_t &center,
    const int32_t id,
    const std::vector<int32_t> &laneIds,
    const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap,
    const std::vector<math::Vector3d_t> &points)
{
    mCenter = center;
    mId = id;
    mLaneIds = laneIds;
    mLanePointIdMap = lanePointIdMap;
    mPoints = points;
}

// protected func.

// private func.

} // namespace map {
