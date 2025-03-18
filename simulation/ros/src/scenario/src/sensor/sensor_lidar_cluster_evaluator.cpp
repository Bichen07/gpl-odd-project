#include <sensor_lidar_cluster_evaluator.h>
#include <ros/console.h>
#include <limits>
#include <math_utils.h>

namespace sensor {

// public func.

LidarClusterEvaluator::LidarClusterEvaluator()
{
}

LidarClusterEvaluator::~LidarClusterEvaluator()
{
}

std::vector<geometry::ConvexHull2d> LidarClusterEvaluator::Compute(
    const std::vector<math::Vector2d_t> &firstPolygonCorners,
    const std::vector<math::Vector2d_t> &secondPolygonCorners,
    const math::real_t distanceThreshold) const
{
    if (firstPolygonCorners.empty() && secondPolygonCorners.empty())
    {
        return std::vector<geometry::ConvexHull2d>(2ul);
    }

    if (firstPolygonCorners.empty())
    {
        return std::vector<geometry::ConvexHull2d>(
            {geometry::ConvexHull2d(), this->ComputeConvexHull(secondPolygonCorners)});
    }

    if (secondPolygonCorners.empty())
    {
        return std::vector<geometry::ConvexHull2d>(
            {this->ComputeConvexHull(firstPolygonCorners), geometry::ConvexHull2d()});
    }

    const auto closestDistance = this->ComputeClosestCornerPairDistance(
        firstPolygonCorners,
        secondPolygonCorners);

    if (closestDistance < distanceThreshold)
    {
        std::vector<math::Vector2d_t> clusteredCorners;
        clusteredCorners.reserve(
            firstPolygonCorners.size() + secondPolygonCorners.size());
        clusteredCorners.insert(
            clusteredCorners.end(),
            firstPolygonCorners.begin(),
            firstPolygonCorners.end());
        clusteredCorners.insert(
            clusteredCorners.end(),
            secondPolygonCorners.begin(),
            secondPolygonCorners.end());

        return std::vector<geometry::ConvexHull2d>(
            {geometry::ConvexHull2d(clusteredCorners)});
    }

    static constexpr bool canShowPolygonCorners{false};
    if (canShowPolygonCorners)
    {
        ROS_WARN_STREAM("firstPolygonCorners");
        std::copy(
            firstPolygonCorners.cbegin(),
            firstPolygonCorners.cend(),
            std::ostream_iterator<math::Vector2d_t>(std::cout, "\n"));
        ROS_WARN_STREAM("secondPolygonCorners");
        std::copy(
            secondPolygonCorners.cbegin(),
            secondPolygonCorners.cend(),
            std::ostream_iterator<math::Vector2d_t>(std::cout, "\n"));
    }

    const auto firstConvexHull{this->ComputeConvexHull(firstPolygonCorners)};
    const auto secondConvexHull{this->ComputeConvexHull(secondPolygonCorners)};
    const auto outputConvexHulls{std::vector<geometry::ConvexHull2d>(
        {firstConvexHull, secondConvexHull})};

    static constexpr bool canShowConvexHullCorners{false};
    if (canShowConvexHullCorners)
    {
        ROS_WARN_STREAM("first convex hull corners");
        std::copy(
            outputConvexHulls.front().GetCorners().cbegin(),
            outputConvexHulls.front().GetCorners().cend(),
            std::ostream_iterator<math::Vector2d_t>(std::cout, "\n"));
        ROS_WARN_STREAM("second convex hull corners");
        std::copy(
            outputConvexHulls.back().GetCorners().cbegin(),
            outputConvexHulls.back().GetCorners().cend(),
            std::ostream_iterator<math::Vector2d_t>(std::cout, "\n"));
    }

    return outputConvexHulls;
}

// protected func.

// private func.

math::real_t LidarClusterEvaluator::ComputeClosestCornerPairDistance(
    const std::vector<math::Vector2d_t> &firstPolygonCorners,
    const std::vector<math::Vector2d_t> &secondPolygonCorners) const
{
    math::real_t minDistance{std::numeric_limits<math::real_t>::max()};
    for (auto firstCorner{firstPolygonCorners.cbegin()};
         firstCorner != firstPolygonCorners.cend();
         ++firstCorner)
    {
        for (auto secondCorner{secondPolygonCorners.cbegin()};
             secondCorner != secondPolygonCorners.cend();
             ++secondCorner)
        {
            const math::real_t distance = (*firstCorner - *secondCorner).norm();
            if (distance < minDistance)
            {
                minDistance = distance;
            }
        }
    }

    return minDistance;
}

geometry::ConvexHull2d LidarClusterEvaluator::ComputeConvexHull(
    const std::vector<math::Vector2d_t> &corners) const
{
    if (corners.size() > 2ul)
    {
        return geometry::ConvexHull2d(corners);
    }

    static const math::real_t rotationalRadian{math::ToRadian(5.0)};

    const auto edgeVector = corners.back() - corners.front();
    const auto rotmat = Eigen::Rotation2D<math::real_t>(rotationalRadian).toRotationMatrix();
    const auto rotatedVector = rotmat * edgeVector;
    const auto insertedPoint = corners.front() + rotatedVector;
    const auto augmentedCorners = std::vector<math::Vector2d_t>(
        {corners.front(), insertedPoint, corners.back()});

    return geometry::ConvexHull2d(augmentedCorners);
}

} // namespace sensor {
