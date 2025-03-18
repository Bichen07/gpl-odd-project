#ifndef _SENSOR_LIDAR_CLUSTER_EVALUATOR_H_
#define _SENSOR_LIDAR_CLUSTER_EVALUATOR_H_

#include <utility>
#include <math_type.h>
#include <geometry_convex_hull_2d.h>

namespace sensor {

class LidarClusterEvaluator final
{

public:

    LidarClusterEvaluator();
    LidarClusterEvaluator(const LidarClusterEvaluator &) = delete;
    LidarClusterEvaluator &operator=(const LidarClusterEvaluator &) = delete;
    virtual ~LidarClusterEvaluator();

    std::vector<geometry::ConvexHull2d> Compute(
        const std::vector<math::Vector2d_t> &firstPolygonCorners,
        const std::vector<math::Vector2d_t> &secondPolygonCorners,
        const math::real_t distanceThreshold) const;

protected:

private:

    math::real_t ComputeClosestCornerPairDistance(
        const std::vector<math::Vector2d_t> &firstPolygonCorners,
        const std::vector<math::Vector2d_t> &secondPolygonCorners) const;
    geometry::ConvexHull2d ComputeConvexHull(
        const std::vector<math::Vector2d_t> &corners) const;
};

} // namespace sensor {

#endif // #ifndef _SENSOR_LIDAR_CLUSTER_EVALUATOR_H_
