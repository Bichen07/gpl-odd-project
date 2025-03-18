#ifndef _MEASURE_FRENET_DISTANCE_DATA_H_
#define _MEASURE_FRENET_DISTANCE_DATA_H_

#include <vector>
#include <math_type.h>
#include <math_frenet_coord.h>

namespace measure {

struct FrenetDistanceData final
{
    math::Vector3d_t observerPoint;
    math::Vector3d_t targetPoint;
    math::FrenetCoord observerFrenetPoint;
    math::FrenetCoord targetFrenetPoint;
    math::FrenetCoord distance;
    std::vector<math::Vector3d_t> sequentialPoints;
    bool isObserverBehindTarget;

    FrenetDistanceData()
        : observerPoint{}
        , targetPoint{}
        , observerFrenetPoint{}
        , targetFrenetPoint{}
        , distance{}
        , sequentialPoints{}
        , isObserverBehindTarget{false}
    {
    }
    explicit FrenetDistanceData(
        const math::Vector3d_t &inputRefPoint,
        const math::Vector3d_t &inputTargetPoint,
        const math::FrenetCoord &inputRefFrenetCoord,
        const math::FrenetCoord &inputTargetFrenetCoord,
        const math::FrenetCoord &inputDistance,
        const std::vector<math::Vector3d_t> &inputSequentialPoints,
        const bool inputIsObserverBehindTarget)
        : observerPoint{inputRefPoint}
        , targetPoint{inputTargetPoint}
        , observerFrenetPoint{inputRefFrenetCoord}
        , targetFrenetPoint{inputTargetFrenetCoord}
        , distance{inputDistance}
        , sequentialPoints{inputSequentialPoints}
        , isObserverBehindTarget{inputIsObserverBehindTarget}
    {
    }
    FrenetDistanceData(const FrenetDistanceData &) = default;
    FrenetDistanceData &operator=(const FrenetDistanceData &) = default;
    ~FrenetDistanceData() = default;
};

} // namespace measure {

#endif // #ifndef _MEASURE_FRENET_DISTANCE_DATA_H_
