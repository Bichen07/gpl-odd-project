#ifndef _METRIC_LCSS_MATCHED_SUB_TRAJECTORY_EVALUATOR_H_
#define _METRIC_LCSS_MATCHED_SUB_TRAJECTORY_EVALUATOR_H_

#include <utility>
#include <metric_type.h>

namespace metric {

class LcssMatchedSubTrajectoryEvaluator final
{

public:

    LcssMatchedSubTrajectoryEvaluator();
    LcssMatchedSubTrajectoryEvaluator(const LcssMatchedSubTrajectoryEvaluator &) = delete;
    LcssMatchedSubTrajectoryEvaluator &operator=(const LcssMatchedSubTrajectoryEvaluator &) = delete;
    virtual ~LcssMatchedSubTrajectoryEvaluator() = default;

    const std::pair<Trajectories, Trajectories> &GetMatchedSubTrajectories() const;
    void Compute(
        const std::vector<math::Vector3d_t> &traj1st,
        const std::vector<math::Vector3d_t> &traj2nd,
        const std::pair<Indexes, Indexes> &matchedTrajectoryIndexes);

protected:

private:

    void PartitionIntoContinuousIndexes(
        const Indexes &inputIndexes,
        std::vector<Indexes> &outputIndexesSet);

    std::pair<std::vector<Indexes>, std::vector<Indexes>> mMatchedSubTrajectoryIndexesSet;
    std::pair<Trajectories, Trajectories> mMatchedSubTrajectories;
};

} // namespace metric {

#endif // #ifndef _METRIC_LCSS_MATCHED_SUB_TRAJECTORY_EVALUATOR_H_
