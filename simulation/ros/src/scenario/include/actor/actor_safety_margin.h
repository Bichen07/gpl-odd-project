#ifndef _ACTOR_SAFETY_MARGIN_H_
#define _ACTOR_SAFETY_MARGIN_H_

#include <math_type.h>

namespace actor {

struct SafetyMargin final
{
    math::real_t left;
    math::real_t right;
    math::real_t front;
    math::real_t rear;

    SafetyMargin()
        : left{0.0}
        , right{0.0}
        , front{0.0}
        , rear{0.0}
    {
    }
    explicit SafetyMargin(
        const math::real_t inputLeft,
        const math::real_t inputRight,
        const math::real_t inputFront,
        const math::real_t inputRear)
        : left{inputLeft}
        , right{inputRight}
        , front{inputFront}
        , rear{inputRear}
    {
    }
    SafetyMargin(const SafetyMargin &other) = default;
    SafetyMargin &operator=(const SafetyMargin &other) = default;
    ~SafetyMargin() = default;
};

} // namespace actor {

#endif // #ifndef _ACTOR_SAFETY_MARGIN_H_
