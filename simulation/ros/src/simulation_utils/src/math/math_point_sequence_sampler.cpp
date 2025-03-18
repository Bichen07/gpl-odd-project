#include "math_point_sequence_sampler.h"
#include <ros/console.h>
#include "math_utils.h"

namespace math {

// public func.

PointSequenceSampler::PointSequenceSampler()
{
}

PointSequenceSampler::~PointSequenceSampler()
{
}

Vector3dColl_t PointSequenceSampler::Compute(
    const Vector3dColl_t &inputs,
    const real_t output_step_distance,
    const DistanceEvaluationId_t &distance_evaluation_id
    ) const
{
    if (inputs.empty())
    {
        ROS_WARN_STREAM("inputs is empty");
        return Vector3dColl_t();
    }

    std::vector<real_t> accumulated_distances;
    if (DistanceEvaluation::Dim2d == distance_evaluation_id)
    {
        accumulated_distances =
            this->ComputeAccumulatedDistance(inputs, distance_evaluation_id);
    }
    else
    {
        accumulated_distances =
            this->ComputeAccumulatedDistance(inputs, distance_evaluation_id);
    }

    const int32_t output_size_hint = static_cast<int32_t>(
        ceil(accumulated_distances.back() / output_step_distance));
    Vector3dColl_t outputs;
    outputs.reserve(output_size_hint);
    outputs.push_back(inputs.front());
    math::real_t forward_distance{output_step_distance};

    while (forward_distance < accumulated_distances.back())
    {
        const auto next_point_iterator = std::upper_bound(
            accumulated_distances.begin(),
            accumulated_distances.end(),
            forward_distance,
            [](const real_t first, const real_t second)
            {return first < second;}
            );
        const int32_t next_point_idx = std::distance(
            accumulated_distances.begin(),
            next_point_iterator
            );
        const int32_t sampling_idx = next_point_idx - 1;
        const real_t remaining_distance =
            forward_distance - accumulated_distances.at(sampling_idx);
        const real_t inputStep =
            accumulated_distances.at(next_point_idx) -
            accumulated_distances.at(next_point_idx - 1);
        const real_t lerpStepRatio = remaining_distance / inputStep;
        const math::Vector3d_t sampling_point = math::Lerp(
            inputs.at(sampling_idx),
            inputs.at(sampling_idx + 1),
            lerpStepRatio
            );
        outputs.push_back(sampling_point);
        forward_distance += output_step_distance;
    }

    return outputs;
}

// protected func.

// private func.

std::vector<real_t> PointSequenceSampler::ComputeAccumulatedDistance(
    const std::vector<Vector3d_t> &inputs,
    const DistanceEvaluationId_t &distance_evaluation_id
    ) const
{
    std::vector<real_t> outputs(inputs.size());

    auto input{inputs.begin()};
    auto output{outputs.begin()};
    *output = 0.0;

    ComputeNormFunc_t compute_norm_func;
    if (DistanceEvaluation::Dim2d == distance_evaluation_id)
    {
        compute_norm_func = std::bind(
            &PointSequenceSampler::ComputeNormXy,
            this,
            std::placeholders::_1,
            std::placeholders::_2
            );
    }
    else
    {
        compute_norm_func = std::bind(
            &PointSequenceSampler::ComputeNormXyz,
            this,
            std::placeholders::_1,
            std::placeholders::_2
            );
    }

    ++input;
    ++output;
    real_t accumulated_distance{0.0};
    for (; input != inputs.end(); ++input, ++output)
    {
        accumulated_distance += compute_norm_func(*input, *(input - 1));
        *output = accumulated_distance;
    }

    return outputs;
}

real_t PointSequenceSampler::ComputeNormXyz(
    const Vector3d_t &first,
    const Vector3d_t &second) const
{
    return (first - second).norm();
}

real_t PointSequenceSampler::ComputeNormXy(
    const Vector3d_t &first,
    const Vector3d_t &second) const
{
    const Vector2d_t first_xy(first.x(), first.y());
    const Vector2d_t second_xy(second.x(), second.y());

    return (first_xy - second_xy).norm();
}

} // namespace math {
