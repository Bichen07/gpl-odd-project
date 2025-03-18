#ifndef _MATH_SEGMENT_VECTOR_EVALUATOR_H_
#define _MATH_SEGMENT_VECTOR_EVALUATOR_H_

#include "math_type.h"

namespace math {

template<typename VectorType>
class SegmentVectorEvaluator final
{

public:

    SegmentVectorEvaluator();
    SegmentVectorEvaluator(const SegmentVectorEvaluator &) = delete;
    SegmentVectorEvaluator &operator=(const SegmentVectorEvaluator &) = delete;
    virtual ~SegmentVectorEvaluator();

    std::vector<VectorType> Compute(
        const std::vector<VectorType> &inputs,
        const bool is_normalized
        ) const;

protected:

private:

};

} // namespace math {

#endif // #ifndef _MATH_SEGMENT_VECTOR_EVALUATOR_H_
