#include <sensor_lidar_detected_object_velocity_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>

namespace sensor {

// public func.

LidarDetectedObjectVelocityEvaluator::LidarDetectedObjectVelocityEvaluator()
    : mSeparateCount{0}
{
}

LidarDetectedObjectVelocityEvaluator::~LidarDetectedObjectVelocityEvaluator()
{
}

math::Vector3d_t LidarDetectedObjectVelocityEvaluator::Compute(
    const std::vector<geometry::ConvexHull2d> &clusteredConvexHulls,
    const math::Vector3d_t &separateAgentVelocity)
{
    const auto clusterSize = this->CountClusterSize(clusteredConvexHulls);
    if (1 == clusterSize)
    {
        mSeparateCount = 0;
    }
    else
    {
        if (mSeparateCount < CompensatedCount())
        {
            ++mSeparateCount;
        }
    }

    const math::real_t scale =
        static_cast<math::real_t>(mSeparateCount) /
        static_cast<math::real_t>(CompensatedCount());

    static constexpr bool canShowVelocityScaleComputationVariable{false};
    if (canShowVelocityScaleComputationVariable)
    {
        ROS_INFO_STREAM(std::setprecision(5) <<
            "cluster size: " << clusterSize << '\n' <<
            "mSeparateCount: " << mSeparateCount << '\n' <<
            "scale: " << scale);
    }

    return scale * separateAgentVelocity;
}

// protected func.

// private func.

int32_t LidarDetectedObjectVelocityEvaluator::CountClusterSize(
    const std::vector<geometry::ConvexHull2d> &clusteredConvexHulls) const
{
    int32_t outputSize{0};
    for (auto convexHull{clusteredConvexHulls.cbegin()};
         convexHull != clusteredConvexHulls.cend();
         ++convexHull)
    {
        if (!convexHull->GetCorners().empty())
        {
            ++outputSize;
        }
    }

    return outputSize;
}

} // namespace sensor {
