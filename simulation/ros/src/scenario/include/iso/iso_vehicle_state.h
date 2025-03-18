#ifndef _ISO_VEHICLE_STATE_H_
#define _ISO_VEHICLE_STATE_H_

#include <math_type.h>

namespace iso {

struct VehicleState final
{
    math::HomoXfm3d_t pose;
    math::Vector3d_t linearVelocity;
    math::Vector3d_t angularVelocity;
    math::Vector3d_t linearAcceleration;
    math::Vector3d_t angularAcceleration;

    VehicleState()
        : pose{}
        , linearVelocity{}
        , angularVelocity{}
        , linearAcceleration{}
        , angularAcceleration{}
    {
    }

    explicit VehicleState(
        const math::HomoXfm3d_t &inputPose,
        const math::Vector3d_t &inputLinearVelocity,
        const math::Vector3d_t &inputAngularVelocity,
        const math::Vector3d_t &inputLinearAccleration,
        const math::Vector3d_t &inputAngularAcceleration)
        : pose{inputPose}
        , linearVelocity{inputLinearVelocity}
        , angularVelocity{inputAngularVelocity}
        , linearAcceleration{inputLinearAccleration}
        , angularAcceleration{inputAngularAcceleration}
    {
    }
    VehicleState(const VehicleState &other) = default;
    VehicleState &operator=(const VehicleState &other) = default;
    ~VehicleState() = default;
};

} // namespace iso {

#endif // #ifndef _ISO_VEHICLE_STATE_H_
