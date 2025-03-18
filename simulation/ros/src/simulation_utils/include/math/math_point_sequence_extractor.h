#ifndef _MATH_POINT_SEQUENCE_EXTRACTOR_H_
#define _MATH_POINT_SEQUENCE_EXTRACTOR_H_

#include <math_type.h>

namespace math {

class PointSequenceExtractor final
{

public:

    PointSequenceExtractor();
    PointSequenceExtractor(const PointSequenceExtractor &) = delete;
    PointSequenceExtractor &operator=(const PointSequenceExtractor &) = delete;
    virtual ~PointSequenceExtractor();

    std::vector<math::Vector3d_t> Compute(
        const std::vector<math::Vector3d_t> &input_point_sequence,
        const int32_t begin_idx,
        const real_t extracted_distance
        ) const;

protected:

private:

};

} // namespace math {

#endif // #ifndef _MATH_POINT_SEQUENCE_EXTRACTOR_H_
