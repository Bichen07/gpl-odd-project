#ifndef _METRIC_LCSS_UNMATCHED_SUB_TRAJECTORY_EVALUATOR_H_
#define _METRIC_LCSS_UNMATCHED_SUB_TRAJECTORY_EVALUATOR_H_

#include <utility>
#include <metric_type.h>

namespace metric {

class LcssUnmatchedSubTrajectoryEvaluator final
{

public:

    LcssUnmatchedSubTrajectoryEvaluator();
    LcssUnmatchedSubTrajectoryEvaluator(const LcssUnmatchedSubTrajectoryEvaluator &) = delete;
    LcssUnmatchedSubTrajectoryEvaluator &operator=(const LcssUnmatchedSubTrajectoryEvaluator &) = delete;
    virtual ~LcssUnmatchedSubTrajectoryEvaluator() = default;

    const std::pair<Trajectories, Trajectories> &GetUnmatchedSubTrajectories() const;

    void Compute(
        const std::vector<math::Vector3d_t> &traj1st,
        const std::vector<math::Vector3d_t> &traj2nd,
        const std::pair<Indexes, Indexes> &matchedTrajectoryIndexes);

protected:

private:

    void ExtractUncontinuousIndexes(
        const Indexes &inputIndexes,
        std::vector<Indexes> &outputIndexesSet);
    std::vector<int32_t> GenerateContinuousIndexes(
        const int32_t beginIdx,
        const int32_t endIdx) const;
    bool CheckResult(
        const Indexes &matchedIndexes,
        const std::vector<Indexes> &unmatchedIndexesSet) const;

    std::pair<std::vector<Indexes>, std::vector<Indexes>> mUnmatchedSubTrajectoryIndexes;
    std::pair<Trajectories, Trajectories> mUnmatchedSubTrajectories;
};

} // namespace metric {

#endif // #ifndef _METRIC_LCSS_UNMATCHED_SUB_TRAJECTORY_EVALUATOR_H_
