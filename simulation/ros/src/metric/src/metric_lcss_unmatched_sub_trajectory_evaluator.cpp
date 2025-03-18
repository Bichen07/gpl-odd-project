#include <metric_lcss_unmatched_sub_trajectory_evaluator.h>
#include <iterator>
#include <stdexcept>
#include <ros/console.h>
#include <metric_utils.h>

namespace metric {

// public func.

LcssUnmatchedSubTrajectoryEvaluator::LcssUnmatchedSubTrajectoryEvaluator()
    : mUnmatchedSubTrajectoryIndexes{}
    , mUnmatchedSubTrajectories{}
{
}

const std::pair<Trajectories, Trajectories>
    &LcssUnmatchedSubTrajectoryEvaluator::GetUnmatchedSubTrajectories() const
{
    return mUnmatchedSubTrajectories;
}

void LcssUnmatchedSubTrajectoryEvaluator::Compute(
    const std::vector<math::Vector3d_t> &traj1st,
    const std::vector<math::Vector3d_t> &traj2nd,
    const std::pair<Indexes, Indexes> &matchedTrajectoryIndexes)
{
    this->ExtractUncontinuousIndexes(
        matchedTrajectoryIndexes.first,
        mUnmatchedSubTrajectoryIndexes.first);
    this->ExtractUncontinuousIndexes(
        matchedTrajectoryIndexes.second,
        mUnmatchedSubTrajectoryIndexes.second);
    mUnmatchedSubTrajectoryIndexes.second.erase(mUnmatchedSubTrajectoryIndexes.second.begin());

    static const bool canShowIndexes{false};
    if (canShowIndexes)
    {
        ROS_DEBUG_STREAM_COND(
            true,
            "unmatched sub trajectories indexes 1st size: " <<
            mUnmatchedSubTrajectoryIndexes.first.size());
        for (auto indexes1st{mUnmatchedSubTrajectoryIndexes.first.cbegin()};
             indexes1st != mUnmatchedSubTrajectoryIndexes.first.cend();
             ++indexes1st)
        {
            std::copy(
                indexes1st->cbegin(),
                indexes1st->cend(),
                std::ostream_iterator<int32_t>(std::cout, ", "));
            std::cout << std::endl;
        }

        ROS_DEBUG_STREAM_COND(
            true,
            "unmatched sub trajectories indexes 2nd size: " <<
            mUnmatchedSubTrajectoryIndexes.second.size());
        for (auto indexes2nd{mUnmatchedSubTrajectoryIndexes.second.cbegin()};
             indexes2nd != mUnmatchedSubTrajectoryIndexes.second.cend();
             ++indexes2nd)
        {
            std::copy(
                indexes2nd->cbegin(),
                indexes2nd->cend(),
                std::ostream_iterator<int32_t>(std::cout, ", "));
            std::cout << std::endl;
        }
    }

    const bool isValidUnmatchedIndexesSet1st{
        this->CheckResult(
            matchedTrajectoryIndexes.first,
            mUnmatchedSubTrajectoryIndexes.first)};
    const bool isValidUnmatchedIndexesSet2nd{
        this->CheckResult(
            matchedTrajectoryIndexes.second,
            mUnmatchedSubTrajectoryIndexes.second)};
    if (!isValidUnmatchedIndexesSet1st || !isValidUnmatchedIndexesSet2nd)
    {
        ROS_ERROR_STREAM("invald unmatched indexes");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    metric::ExtractTrajectories(
        traj1st,
        mUnmatchedSubTrajectoryIndexes.first,
        mUnmatchedSubTrajectories.first);
    metric::ExtractTrajectories(
        traj2nd,
        mUnmatchedSubTrajectoryIndexes.second,
        mUnmatchedSubTrajectories.second);
}

// protected func.

// private func.

void LcssUnmatchedSubTrajectoryEvaluator::ExtractUncontinuousIndexes(
    const Indexes &inputIndexes,
    std::vector<Indexes> &outputIndexesSet)
{
    auto sortedIndexes{inputIndexes};
    std::sort(
        sortedIndexes.begin(),
        sortedIndexes.end());
    //std::copy(
    //    sortedIndexes.cbegin(),
    //    sortedIndexes.cend(),
    //    std::ostream_iterator<int32_t>(std::cout, ", "));
    //std::cout << '\n' << std::endl;
    auto beginIdx{sortedIndexes.cbegin()};
    for (auto idx{sortedIndexes.cbegin() + 1};
         idx != sortedIndexes.cend() - 1;
         ++idx)
    {
        if (*idx != *(idx - 1) + 1)
        {
            outputIndexesSet.push_back(
                this->GenerateContinuousIndexes(
                    *(idx - 1) + 1,
                    *idx));
            ROS_DEBUG_STREAM_COND(
                false,
                "beginIdx: " << *(idx - 1) + 1 << ", endIdx: " << *idx);
        }
    }
}

std::vector<int32_t> LcssUnmatchedSubTrajectoryEvaluator::GenerateContinuousIndexes(
    const int32_t beginIdx,
    const int32_t endIdx) const
{
    std::vector<int32_t> outputIndexes;
    outputIndexes.reserve(endIdx - beginIdx);
    for (int32_t idx{beginIdx}; idx < endIdx; ++idx)
    {
        outputIndexes.push_back(idx);
    }

    return outputIndexes;
}

bool LcssUnmatchedSubTrajectoryEvaluator::CheckResult(
    const Indexes &matchedIndexes,
    const std::vector<Indexes> &unmatchedIndexesSet) const
{
    bool isValid{true};
    for (auto unmatchedIndexes{unmatchedIndexesSet.cbegin()};
         unmatchedIndexes != unmatchedIndexesSet.cend();
         ++unmatchedIndexes)
    {
        for (auto unmatchedIdx{unmatchedIndexes->cbegin()};
             unmatchedIdx != unmatchedIndexes->cend();
             ++unmatchedIdx)
        {
            const auto found{
                std::find(
                    matchedIndexes.cbegin(),
                    matchedIndexes.cend(),
                    *unmatchedIdx)};
            if (matchedIndexes.cend() != found)
            {
                isValid = false;
                ROS_ERROR_STREAM("incorrect idx: " << *found);
            }
        }
    }

    return isValid;
}

} // namespace metric {
