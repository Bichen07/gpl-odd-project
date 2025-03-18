#include "math_segment_vector_evaluator.h"

namespace math {

// public func.

template<typename VectorType>
SegmentVectorEvaluator<VectorType>::SegmentVectorEvaluator()
{
}

template<typename VectorType>
SegmentVectorEvaluator<VectorType>::~SegmentVectorEvaluator()
{
}

template<typename VectorType>
std::vector<VectorType> SegmentVectorEvaluator<VectorType>::Compute(
    const std::vector<VectorType> &inputs,
    const bool is_normalized
    ) const
{
    std::vector<VectorType> outputs(inputs.size());

    auto input{inputs.begin()};
    auto output{outputs.begin()};
    ++input;

    while (input != inputs.end())
    {
        if (is_normalized)
        {
            *output = (*input - *(input - 1)).normalized();
        }
        else
        {
            *output = *input - *(input - 1);
        }

        ++input;
        ++output;
    }

    outputs.back() = outputs.at(inputs.size() - 2u);

    return outputs;
}

// protected func.

// private func.

// explicit instantiation

template class SegmentVectorEvaluator<Vector2d_t>;
template class SegmentVectorEvaluator<Vector3d_t>;

} // namespace math {
