#ifndef _MOTION_STATE_H_
#define _MOTION_STATE_H_

#include <math_type.h>

namespace motion {

struct State final
{
    math::Vector3d_t position;
    math::Quaternion_t orientation;
    math::Vector3d_t linearVelocity;
    math::Vector3d_t angularVelocity;
    math::real_t longitudinalAcceleration;
    math::real_t lateralAcceleration;

    State()
        : position{}
        , orientation{math::Quaternion_t::Identity()}
        , linearVelocity{}
        , angularVelocity{}
        , longitudinalAcceleration{}
        , lateralAcceleration{}
    {
    }
    explicit State(
        const math::Vector3d_t &inputPosition,
        const math::Quaternion_t &inputOrientation,
        const math::Vector3d_t &inputLinearVelocity,
        const math::Vector3d_t &inputAngularVelocity,
        const math::real_t inputLongitudinalAcceleration,
        const math::real_t inputLateralAcceleration)
        : position{inputPosition}
        , orientation{inputOrientation}
        , linearVelocity{inputLinearVelocity}
        , angularVelocity{inputAngularVelocity}
        , longitudinalAcceleration{inputLongitudinalAcceleration}
        , lateralAcceleration{inputLateralAcceleration}
    {
    }
    explicit State(
        const math::Vector3d_t &inputPosition,
        const math::Quaternion_t &inputOrientation,
        const math::Vector3d_t &inputLinearVelocity,
        const math::Vector3d_t &inputAngularVelocity)
        : position{inputPosition}
        , orientation{inputOrientation}
        , linearVelocity{inputLinearVelocity}
        , angularVelocity{inputAngularVelocity}
        , longitudinalAcceleration{0.0}
        , lateralAcceleration{0.0}
    {
    }
    State(const State &other) = default;
    State &operator=(const State &other) = default;
    ~State() = default;
};

} // namespace actor {

#endif // #ifndef _MOTION_STATE_H_
