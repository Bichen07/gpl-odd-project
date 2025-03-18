#include <metric_longest_common_subsequence.h>
#include <limits>
#include <iterator>
#include <stdexcept>
#include <ros/console.h>

namespace metric {

// public func.

LongestCommonSubsequence::LongestCommonSubsequence()
    : mDistance{std::numeric_limits<math::real_t>::max()}
    , mSimilarity{std::numeric_limits<math::real_t>::max()}
    , mMatchedTrajectoryIndexes{}
{
}

math::real_t LongestCommonSubsequence::GetSimilarity() const
{
    if (mSimilarity < math::real_t{0.0} || mSimilarity > math::real_t{1.0})
    {
        ROS_ERROR_STREAM(
            "invalid similarity: " << mSimilarity << '\n' <<
            "the valid value is between 0.0 and 1.0");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return mSimilarity;
}

math::real_t LongestCommonSubsequence::GetDistance() const
{
    if (mDistance < math::real_t{0.0} || mDistance > math::real_t{1.0})
    {
        ROS_ERROR_STREAM(
            "invalid distance: " << mDistance << '\n' <<
            "the valid value is between 0.0 and 1.0");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return mDistance;
}

const std::pair<Indexes, Indexes>
    &LongestCommonSubsequence::GetMatchedTrajectoryIndexes() const
{
    return mMatchedTrajectoryIndexes;
}

math::real_t LongestCommonSubsequence::ComputeDistance(
    const std::vector<math::Vector3d_t> &traj1st,
    const std::vector<math::Vector3d_t> &traj2nd,
    const math::real_t epsilon)
{
    const std::size_t rowSize{traj1st.size() + 1ul};
    const std::size_t colSize{traj2nd.size() + 1ul};
    std::vector<int32_t> initRowVector(colSize + 1, 0);
    SimilarityMatrix simMat(rowSize, initRowVector);
    mMatchedTrajectoryIndexes.first.reserve(traj1st.size());
    mMatchedTrajectoryIndexes.second.reserve(traj2nd.size());

    for (std::size_t idx1st{1ul}; idx1st < rowSize; ++idx1st)
    {
        for (std::size_t idx2nd{1ul}; idx2nd < colSize; ++idx2nd)
        {
            const math::real_t dist{
                this->ComputeDistance2d(
                    traj1st.at(idx1st - 1),
                    traj2nd.at(idx2nd - 1))};
            if (dist < epsilon)
            {
                simMat[idx1st][idx2nd] = simMat[idx1st - 1][idx2nd - 1] + 1;
                this->AppendMatchedIndexes(
                    idx1st - 1,
                    idx2nd - 1,
                    mMatchedTrajectoryIndexes);
            }
            else
            {
                simMat[idx1st][idx2nd] = std::max(
                    simMat[idx1st][idx2nd - 1],
                    simMat[idx1st - 1][idx2nd]);
            }
        }
    }

    mSimilarity =
        static_cast<math::real_t>(simMat[traj1st.size()][traj2nd.size()]) /
        static_cast<math::real_t>(std::min(traj1st.size(), traj2nd.size()));
    mDistance = 1.0 - mSimilarity;

    mMatchedTrajectoryIndexes.first.shrink_to_fit();
    mMatchedTrajectoryIndexes.second.shrink_to_fit();

    std::sort(
        mMatchedTrajectoryIndexes.first.begin(),
        mMatchedTrajectoryIndexes.first.end());
    std::sort(
        mMatchedTrajectoryIndexes.second.begin(),
        mMatchedTrajectoryIndexes.second.end());

    ROS_DEBUG_STREAM_COND(
        false,
        "matched index size: " << mMatchedTrajectoryIndexes.first.size() <<
        ", " << mMatchedTrajectoryIndexes.second.size() << '\n' <<
        "trajectory size: " << traj1st.size() << ", " << traj2nd.size());

    return mDistance;
}

// protected func.

// private func.

void LongestCommonSubsequence::AppendMatchedIndexes(
    const int32_t idx1st,
    const int32_t idx2nd,
    std::pair<Indexes, Indexes> &outputIndexes)
{
    const auto found1st{
        std::find(
            outputIndexes.first.cbegin(),
            outputIndexes.first.cend(),
            idx1st)};
    if (outputIndexes.first.cend() == found1st)
    {
        outputIndexes.first.push_back(idx1st);
    }

    const auto found2nd{
        std::find(
            outputIndexes.second.cbegin(),
            outputIndexes.second.cend(),
            idx2nd)};
    if (outputIndexes.second.cend() == found2nd)
    {
        outputIndexes.second.push_back(idx2nd);
    }
}

math::real_t LongestCommonSubsequence::ComputeDistance2d(
    const math::Vector3d_t &point1st,
    const math::Vector3d_t &point2nd) const
{
    return math::Vector2d_t(
        point1st.x() - point2nd.x(),
        point1st.y() - point2nd.y()).norm();
}

} // namespace metric {
