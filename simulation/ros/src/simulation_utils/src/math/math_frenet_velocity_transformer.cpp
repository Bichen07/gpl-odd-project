#include "math_frenet_velocity_transformer.h"
#include <ros/console.h>
#include "math_utils.h"
#include "math_frenet_coord.h"

namespace math {

// public func.

FrenetVelocityTransformer::FrenetVelocityTransformer()
{
}

FrenetVelocityTransformer::~FrenetVelocityTransformer()
{
}

Vector2d_t FrenetVelocityTransformer::ConvertToCartesianCoord(
    const FrenetCoord &frenet_velocity,
    const real_t heading_radian
    ) const
{
    const auto local_to_world_rotmat{math::ComputeRotMat2d(heading_radian)};
    const Vector2d_t cartesian_velocity =
    //const auto cartesian_velocity =
        local_to_world_rotmat * Vector2d_t(frenet_velocity.s(), frenet_velocity.d());

    //ROS_INFO_STREAM(
    //    "heaing_radian: " << heading_radian << '\n' <<
    //    "local_to_world_rotmat" << '\n'
    //    << local_to_world_rotmat
    //    );
    //ROS_INFO_STREAM(
    //    "frenet_velocity: " << frenet_velocity <<
    //    ", cartesian_velocity: " << cartesian_velocity.transpose()
    //    );

    { // validation
        const auto test_frenet_velocity = this->ConvertToFrenetCoord(
            cartesian_velocity,
            heading_radian
            );
        if (!math::IsApprox(frenet_velocity.s(), test_frenet_velocity.s(), default_epsilon()))
        {
            ROS_ERROR_STREAM(
                "invalid frenet velocity transform, ref_s: " << frenet_velocity.s() <<
                ", test_s: " << test_frenet_velocity.s());
        }

        if (!math::IsApprox(frenet_velocity.d(), test_frenet_velocity.d(), default_epsilon()))
        {
            ROS_ERROR_STREAM(
                "invalid frenet velocity transform, ref_d: " << frenet_velocity.d() <<
                ", test_d: " << test_frenet_velocity.d());
        }
    }

    return cartesian_velocity;
}

FrenetCoord FrenetVelocityTransformer::ConvertToFrenetCoord(
    const Vector2d_t &cartesian_velocity,
    const real_t heading_radian
    ) const
{
    const auto world_to_local_rotmat{math::ComputeRotMat2d(-heading_radian)};
    const auto frenet_velocity{world_to_local_rotmat * cartesian_velocity};
    //ROS_INFO_STREAM(
    //    "cartesian_velocity: " << cartesian_velocity.transpose() <<
    //    ", frenet_veloctiy: " << frenet_velocity
    //    );

    { // validation
        const auto ref_speed_s{
            cartesian_velocity.x() * std::cos(heading_radian) +
            cartesian_velocity.y() * std::sin(heading_radian)};

        if (!math::IsApprox(ref_speed_s, frenet_velocity.x(), default_epsilon()))
        {
            ROS_ERROR_STREAM(
                "invalid frenet velocity transform, ref_s: " << ref_speed_s << 
                ", test_s: " << frenet_velocity.x());
        }

        const auto speed_d_radian{math::ComputePrincipalAngle(heading_radian + math::HalfPi<real_t>())};
        const auto ref_speed_d{
            cartesian_velocity.x() * std::cos(speed_d_radian) +
            cartesian_velocity.y() * std::sin(speed_d_radian)};
        if (!math::IsApprox(ref_speed_d, frenet_velocity.y(), default_epsilon()))
        {
            ROS_ERROR_STREAM(
                "invalid frenet velocity transform, ref_d: " << ref_speed_d <<
                ", test_d: " << frenet_velocity.y());
        }
    }

    return FrenetCoord(frenet_velocity.x(), frenet_velocity.y());
}

// protected func.

// private func.

} // namespace math {
