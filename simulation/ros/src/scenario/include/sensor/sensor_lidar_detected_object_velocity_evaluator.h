#ifndef _SENSOR_LIDAR_DETECTED_OBJECT_VELOCITY_EVALUATOR_H_
#define _SENSOR_LIDAR_DETECTED_OBJECT_VELOCITY_EVALUATOR_H_

#include <math_type.h>
#include <geometry_convex_hull_2d.h>

namespace sensor {

class LidarDetectedObjectVelocityEvaluator final
{
    static constexpr int32_t CompensatedCount()
    {return 3;}

public:

    LidarDetectedObjectVelocityEvaluator();
    LidarDetectedObjectVelocityEvaluator(
        const LidarDetectedObjectVelocityEvaluator &) = delete;
    LidarDetectedObjectVelocityEvaluator &operator=(
        const LidarDetectedObjectVelocityEvaluator &) = delete;
    virtual ~LidarDetectedObjectVelocityEvaluator();

    math::Vector3d_t Compute(
        const std::vector<geometry::ConvexHull2d> &clusteredConvexHulls,
        const math::Vector3d_t &separateAgentVelocity);

protected:

private:

    int32_t CountClusterSize(
        const std::vector<geometry::ConvexHull2d> &clusteredConvexHulls) const;

    int32_t mSeparateCount;
};

} // namespace sensor {

#endif // #ifndef _SENSOR_LIDAR_DETECTED_OBJECT_VELOCITY_EVALUATOR_H_
