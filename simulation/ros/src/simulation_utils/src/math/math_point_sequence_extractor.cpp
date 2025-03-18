#include <math_point_sequence_extractor.h>

namespace math {

// public func.

PointSequenceExtractor::PointSequenceExtractor()
{
}

PointSequenceExtractor::~PointSequenceExtractor()
{
}

std::vector<math::Vector3d_t> PointSequenceExtractor::Compute(
    const std::vector<math::Vector3d_t> &input_point_sequence,
    const int32_t begin_idx,
    const real_t extracted_distance
    ) const
{
    std::vector<math::Vector3d_t> output_point_sequence;
    output_point_sequence.reserve(input_point_sequence.size());
    real_t remaining_distance{extracted_distance};
    output_point_sequence.push_back(input_point_sequence.at(begin_idx));
    for (int32_t idx{begin_idx + 1}; idx < input_point_sequence.size(); ++idx)
    {
        if (remaining_distance < 0.0)
        {
            break;
        }

        output_point_sequence.push_back(input_point_sequence.at(idx));
        const real_t segment_distance =
            (output_point_sequence.back() - output_point_sequence.at(output_point_sequence.size() - 2ul)).norm();
        remaining_distance -= segment_distance;
    }

    output_point_sequence.shrink_to_fit();
    return output_point_sequence;
}

// protected func.

// private func.

} // namespace math {
