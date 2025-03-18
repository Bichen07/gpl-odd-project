#include <math_vector_matcher.h>
#include <limits>
#include <ros/console.h>

namespace math {

// public func.

VectorMatcher::VectorMatcher()
{
}

VectorMatcher::~VectorMatcher()
{
}

std::vector<Vector3d_t> VectorMatcher::Compute(
    const std::vector<Vector2d_t> &ref_vector_2ds,
    const std::vector<Vector3d_t> &target_vector_3ds)
{
    //if (ref_vector_2ds.size() != target_vector_3ds.size())
    //{
    //    ROS_WARN_STREAM(
    //        "diff. size between ref_vector_2ds and target_vector_3ds" << '\n' <<
    //        "ref_vector_2ds: " << ref_vector_2ds.size() << '\n' <<
    //        "target_vector_3ds: " << target_vector_3ds.size());
    //    return std::vector<Vector3d_t>();
    //}

    std::vector<Vector3d_t> outputs(ref_vector_2ds.size());
    auto ref{ref_vector_2ds.begin()};
    auto output{outputs.begin()};
    //for (const auto &ref: ref_vector_2ds)
    for (; ref != ref_vector_2ds.end(); ++ref, ++output)
    {
        real_t min_norm{std::numeric_limits<real_t>::max()};
        std::size_t min_idx{std::numeric_limits<int32_t>::max()};
        for (std::size_t idx{0u}; idx < target_vector_3ds.size(); ++idx)
        {
            const Vector2d_t target_xy(target_vector_3ds[idx].x(), target_vector_3ds[idx].y());
            const real_t difference_norm = (*ref - target_xy).norm();
            if (difference_norm < min_norm)
            {
                min_norm = difference_norm;
                min_idx = idx;
            }
        }

        *output = target_vector_3ds[min_idx];
    }

    return outputs;
}

// protected func.

// private func.

} // namespace math {
