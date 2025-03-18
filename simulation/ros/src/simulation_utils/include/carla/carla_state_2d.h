#ifndef _CARLA_STATE_2D_H_
#define _CARLA_STATE_2D_H_

#include <math_type.h>

namespace carla {

struct State2d
{
    math::Vector2d_t position;
    math::real_t orientation;
    math::Vector2d_t velocity;
    math::real_t yawRate;

    State2d()
        : position{}
        , orientation{0.0}
        , velocity{}
        , yawRate{0.0}
    {
    }
    explicit State2d(
        const math::Vector2d_t &inputPosition,
        const math::real_t inputOrientation,
        const math::Vector2d_t &inputVelocity,
        const math::real_t inputYawRate)
        : position{inputPosition}
        , orientation{inputOrientation}
        , velocity{inputVelocity}
        , yawRate{inputYawRate}
    {
    }
    State2d(const State2d &) = default;
    State2d &operator=(const State2d &) = default;
    ~State2d() = default;
};

} // namespace carla {

#endif // #ifndef _CARLA_STATE_2D_H_
