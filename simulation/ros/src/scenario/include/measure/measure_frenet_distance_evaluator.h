#ifndef _MEASURE_FRENET_DISTANCE_EVALUATOR_H_
#define _MEASURE_FRENET_DISTANCE_EVALUATOR_H_

#include <ros/macros.h>
#include <math_type.h>
#include <math_frenet_transformer.h>
#include <utils_file_line_num_pair.h>
#include <measure_frenet_distance_data.h>

namespace measure {

class FrenetDistanceEvaluator final
{

public:

    FrenetDistanceEvaluator();
    FrenetDistanceEvaluator(const FrenetDistanceEvaluator &) = delete;
    FrenetDistanceEvaluator &operator=(const FrenetDistanceEvaluator &) = delete;
    virtual ~FrenetDistanceEvaluator() = default;

    ROS_DEPRECATED
    void Compute(
        const math::Vector3d_t &observerPoint,
        const math::Vector3d_t &targetPoint,
        const bool isMovingInRefWaypointDirection,
        FrenetDistanceData *frenetDistanceData) const;
    void Compute(
        const math::Vector3d_t &observerPoint,
        const math::Vector3d_t &targetPoint,
        const bool isMovingInRefWaypointDirection,
        FrenetDistanceData &frenetDistanceData,
        const utils::FileLineNumPair &fileLineNumPair = utils::FileLineNumPair()) const;

    void Configure(const std::vector<math::Vector3d_t> &refWaypoints);

protected:

private:

    void Compute(
        const math::Vector3d_t &observerPoint,
        const math::Vector3d_t &targetPoint,
        const math::FrenetCoord &refFrenetPoint,
        const math::FrenetCoord &targetFrenetPoint,
        FrenetDistanceData *frenetDistanceData) const;

    std::vector<math::Vector3d_t> mRefWaypoint3ds;
    std::vector<math::Vector2d_t> mRefWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
};

} // namespace measure {

#endif // #ifndef _MEASURE_FRENET_DISTANCE_EVALUATOR_H_
