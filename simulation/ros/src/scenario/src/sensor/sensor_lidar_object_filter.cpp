#include <sensor_lidar_object_filter.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>

namespace sensor {

// public func.

LidarObjectFilter::LidarObjectFilter()
    : mPulsesPerTurn{0}
    , mMinPulseThreshold{0}
    , mMinSpanAngleThreshold{0.0}
{
}

LidarObjectFilter::~LidarObjectFilter()
{
}

void LidarObjectFilter::Configure(
    const int32_t pulsesPerTurn,
    const int32_t minPulseThreshold)
{
    if (pulsesPerTurn < 1)
    {
        ROS_ERROR_STREAM("invalid pulsesPerTurn: " << pulsesPerTurn);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (minPulseThreshold < 1)
    {
        ROS_ERROR_STREAM("invalid minPulseThreshold: " << minPulseThreshold);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mPulsesPerTurn = pulsesPerTurn;
    mMinPulseThreshold = minPulseThreshold;
    mMinSpanAngleThreshold = this->ComputeMinSpanAngleThreshold(
        mPulsesPerTurn,
        mMinPulseThreshold);
}

bool LidarObjectFilter::IsFilteredOut(
    const math::Vector2d_t &lidarPosition,
    const std::vector<math::Vector2d_t> &unclosedPolygonCorners) const
{
    if (unclosedPolygonCorners.size() < 2ul)
    {
        return true;
    }
    const auto sourceVector = unclosedPolygonCorners.front() - lidarPosition;
    math::real_t maxSpanAngle{0.0};
    math::Vector2d_t maxSpanAngleEndVector{sourceVector};
    for (auto corner{unclosedPolygonCorners.cbegin() + 1};
         corner != unclosedPolygonCorners.end();
         ++corner)
    {
        const auto endVector = *corner - lidarPosition;
        const auto spanAngle = std::fabs(
            math::ComputeRotationalAngle(
                sourceVector,
                endVector));
        if (spanAngle > maxSpanAngle)
        {
            maxSpanAngle = spanAngle;
            maxSpanAngleEndVector = endVector;
        }
    }
    const auto isFilteredOut = maxSpanAngle < mMinSpanAngleThreshold ? true : false;

    static constexpr bool canShowFilteringVariable{false};
    if (canShowFilteringVariable)
    {
        ROS_WARN_STREAM(
            "mMinSpanAngleThreshold: " << mMinSpanAngleThreshold << '\n' <<
            "maxSpanAngle: " << maxSpanAngle << '\n' <<
            "isFilteredOut: " << std::boolalpha << isFilteredOut);
    }

    return isFilteredOut;
}

// protected func.

// private func.

math::real_t LidarObjectFilter::ComputeMinSpanAngleThreshold(
    const int32_t pulsesPerTurn,
    const int32_t minPulseThreshold) const
{
    const math::real_t angleRatio =
        static_cast<math::real_t>(minPulseThreshold) /
        static_cast<math::real_t>(pulsesPerTurn);
    const math::real_t spanRadianThreshold = angleRatio * math::TwoPi<math::real_t>();

    return spanRadianThreshold;
}

} // namespace sensor {
