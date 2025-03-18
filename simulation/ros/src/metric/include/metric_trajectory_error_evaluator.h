#ifndef _METRIC_TRAJECTORY_ERROR_EVALUATOR_H_
#define _METRIC_TRAJECTORY_ERROR_EVALUATOR_H_

#include <metric_type.h>

namespace metric {

class TrajectoryErrorEvaluator final
{

public:

    TrajectoryErrorEvaluator();
    TrajectoryErrorEvaluator(const TrajectoryErrorEvaluator &) = delete;
    TrajectoryErrorEvaluator &operator=(const TrajectoryErrorEvaluator &) = delete;
    virtual ~TrajectoryErrorEvaluator() = default;

    math::real_t Compute(
        const Trajectory &traj1st,
        const Trajectory &traj2nd) const;

protected:

private:

    math::real_t ComputeMinError(const math::MatrixNd_t &errorMatrix) const;
};

} // namespace metric {

#endif // #ifndef _METRIC_TRAJECTORY_ERROR_EVALUATOR_H_
