#ifndef _METRIC_LONGEST_COMMON_SUBSEQUENCE_H_
#define _METRIC_LONGEST_COMMON_SUBSEQUENCE_H_

#include <utility>
#include <metric_type.h>

namespace metric {

class LongestCommonSubsequence final
{

public:

    LongestCommonSubsequence();
    LongestCommonSubsequence(const LongestCommonSubsequence &) = delete;
    LongestCommonSubsequence &operator=(const LongestCommonSubsequence &) = delete;
    virtual ~LongestCommonSubsequence() = default;

    math::real_t GetSimilarity() const;
    math::real_t GetDistance() const;
    const std::pair<Indexes, Indexes> &GetMatchedTrajectoryIndexes() const;
    math::real_t ComputeDistance(
        const std::vector<math::Vector3d_t> &traj1st,
        const std::vector<math::Vector3d_t> &traj2nd,
        const math::real_t epsilon);

protected:

private:

    using SimilarityMatrix = std::vector<std::vector<int32_t>>;

    void AppendMatchedIndexes(
        const int32_t idx1st,
        const int32_t idx2nd,
        std::pair<Indexes, Indexes> &outputIndexes);
    math::real_t ComputeDistance2d(
        const math::Vector3d_t &point1st,
        const math::Vector3d_t &point2nd) const;

    math::real_t mDistance;
    math::real_t mSimilarity;
    std::pair<Indexes, Indexes> mMatchedTrajectoryIndexes;
};

} // namespace metric {

#endif // #ifndef _METRIC_LONGEST_COMMON_SUBSEQUENCE_H_
