#include <metric_lcss_matched_sub_trajectory_evaluator.h>
#include <ros/console.h>
#include <metric_utils.h>

namespace metric {

// public func.

LcssMatchedSubTrajectoryEvaluator::LcssMatchedSubTrajectoryEvaluator()
    : mMatchedSubTrajectoryIndexesSet{}
    , mMatchedSubTrajectories{}
{
}

const std::pair<Trajectories, Trajectories>
    &LcssMatchedSubTrajectoryEvaluator::GetMatchedSubTrajectories() const
{
    return mMatchedSubTrajectories;
}

void LcssMatchedSubTrajectoryEvaluator::Compute(
    const std::vector<math::Vector3d_t> &traj1st,
    const std::vector<math::Vector3d_t> &traj2nd,
    const std::pair<Indexes, Indexes> &matchedTrajectoryIndexes) 
{
    this->PartitionIntoContinuousIndexes(
        matchedTrajectoryIndexes.first,
        mMatchedSubTrajectoryIndexesSet.first);
    this->PartitionIntoContinuousIndexes(
        matchedTrajectoryIndexes.second,
        mMatchedSubTrajectoryIndexesSet.second);
    ROS_DEBUG_STREAM_COND(
        false,
        "matched sub-trajectory indexes size: " <<
        mMatchedSubTrajectoryIndexesSet.first.size() << ", " <<
        mMatchedSubTrajectoryIndexesSet.second.size());

    metric::ExtractTrajectories(
        traj1st,
        mMatchedSubTrajectoryIndexesSet.first,
        mMatchedSubTrajectories.first);
    metric::ExtractTrajectories(
        traj2nd,
        mMatchedSubTrajectoryIndexesSet.second,
        mMatchedSubTrajectories.second);
}

// protected func.

// private func.

void LcssMatchedSubTrajectoryEvaluator::PartitionIntoContinuousIndexes(
    const Indexes &inputIndexes,
    std::vector<Indexes> &outputIndexesSet)
{
    auto sortedIndexes{inputIndexes};
    std::sort(
        sortedIndexes.begin(),
        sortedIndexes.end());
    auto beginIdx{sortedIndexes.cbegin()};
    for (auto idx{sortedIndexes.cbegin() + 1};
         idx != sortedIndexes.cend();
         ++idx)
    {
        if (*idx != *(idx - 1) + 1)
        {
            if (beginIdx == (idx - 1))
            {
                continue;
            }

            Indexes subIndexes(
                beginIdx,
                idx - 1);
            outputIndexesSet.push_back(subIndexes);
            beginIdx = idx;
        }
    }

    outputIndexesSet.push_back(
        Indexes(beginIdx, sortedIndexes.cend()));
}

} // namespace metric {
