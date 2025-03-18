#ifndef _MATH_VECTOR_MATCHER_H_
#define _MATH_VECTOR_MATCHER_H_

#include <math_type.h>

namespace math {

class VectorMatcher final
{

public:

    VectorMatcher();
    VectorMatcher(const VectorMatcher &other) = default;
    VectorMatcher &operator=(const VectorMatcher &other) = default;
    virtual ~VectorMatcher();

    std::vector<Vector3d_t> Compute(
        const std::vector<Vector2d_t> &ref_vector_2d,
        const std::vector<Vector3d_t> &target_vector_3d);

protected:

private:

};

} // namespace math {

#endif // #ifndef _MATH_VECTOR_MATCHER_H_
