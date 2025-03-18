#ifndef _SENSOR_LIDAR_OBJECT_FILTER_H_
#define _SENSOR_LIDAR_OBJECT_FILTER_H_

#include <math_type.h>

namespace sensor {

class LidarObjectFilter final
{

public:

    LidarObjectFilter();
    LidarObjectFilter(const LidarObjectFilter &other) = delete;
    LidarObjectFilter &operator=(const LidarObjectFilter &other) = delete;
    virtual ~LidarObjectFilter();

    void Configure(
        const int32_t pulsesPerTurn,
        const int32_t minPulseThreshold);

    bool IsFilteredOut(
        const math::Vector2d_t &lidarPosition,
        const std::vector<math::Vector2d_t> &unclosedPolygonCorners) const;

protected:

private:

    math::real_t ComputeMinSpanAngleThreshold(
        const int32_t pulsesPerTurn,
        const int32_t minPulseThreshold) const;

    int32_t mPulsesPerTurn;
    int32_t mMinPulseThreshold;
    math::real_t mMinSpanAngleThreshold;
};

} // namespace sensor {

#endif // #ifndef _SENSOR_LIDAR_OBJECT_FILTER_H_
