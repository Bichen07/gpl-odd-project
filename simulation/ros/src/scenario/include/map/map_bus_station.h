#ifndef _MAP_BUS_STATION_H_
#define _MAP_BUS_STATION_H_

#include <map>
#include <math_type.h>

namespace map {

class BusStation final
{

public:

    BusStation();
    explicit BusStation(
        const math::Vector3d_t &center,
        const int32_t id,
        const std::vector<int32_t> &laneIds,
        const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap,
        const std::vector<math::Vector3d_t> &points);
    BusStation(const BusStation &other);
    BusStation &operator=(const BusStation &other);
    virtual ~BusStation();

    math::Vector3d_t GetCenter() const;
    int32_t GetId() const;
    const std::vector<int32_t> &GetLaneIds() const;
    const std::map<int32_t, std::vector<int32_t>> &GetLanePointIdMap() const;
    const std::vector<int32_t> &GetPointIds(const int32_t laneId) const;
    const std::vector<math::Vector3d_t> &GetPoints() const;

    void Configure(
        const math::Vector3d_t &center,
        const int32_t id,
        const std::vector<int32_t> &laneIds,
        const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap,
        const std::vector<math::Vector3d_t> &points);

protected:

private:

    math::Vector3d_t mCenter;
    int32_t mId;
    std::vector<int32_t> mLaneIds;
    std::map<int32_t, std::vector<int32_t>> mLanePointIdMap;
    std::vector<math::Vector3d_t> mPoints;
};

} // namespace map {

#endif // #ifndef _MAP_BUS_STATION_H_
