#ifndef _MATH_EPSILON_PRECISION_H_
#define _MATH_EPSILON_PRECISION_H_

#include "math_def.h"

namespace math {

template<typename Scalar>
class EpsilonPrecision
{

public:

    typedef Scalar Scalar_t;

    explicit EpsilonPrecision(const Scalar &target_epsilon);
    EpsilonPrecision(const EpsilonPrecision &other);
    EpsilonPrecision &operator=(const EpsilonPrecision &other);
    virtual ~EpsilonPrecision();

    Scalar epsilon() const;
    int32_t precision_digits() const;

    void reset_epsilon(const Scalar &epsilon);

protected:

private:

    int32_t ComputePrecisionDigits(const Scalar &epsilon) const;

    Scalar epsilon_;
    int32_t precision_digits_;
};

} // namespace math {

#endif // #ifndef _MATH_EPSILON_PRECISION_H_
