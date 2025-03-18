#ifndef _MOTION_UTILS_H_
#define _MOTION_UTILS_H_

#include <string>
#include <math_type.h>
#include <math_frenet_coord.h>
#include <motion_type.h>
#include <motion_state.h>
#include <motion_frenet_state.h>

namespace motion {

math::real_t ConvertToMps(const math::real_t kph);
math::real_t ConvertToKph(const math::real_t mps);

math::real_t ComputeLongitudinalSpeed(
    const math::real_t resultantSpeed,
    const math::real_t lateralSpeed);

ComingDirectionId QueryComingDirectionId(const std::string &key);
math::HomoXfm2d_t ComputeTransform2d(const motion::State &state);
math::FrenetCoord ComputeFrenetVelocity(
    const math::Vector3d_t &worldLinearVelocity3d,
    const math::HomoXfm2d_t &localToWorldTransform2d);
State ComputeUpdatedState(
    const math::real_t timeStep,
    const State &lastState,
    const math::Vector3d_t &updatedPosition);

std::vector<math::Vector3d_t> ExtendWaypoints(
    const std::vector<math::Vector3d_t> &inputWaypoints,
    const math::real_t beginExtendedDistance,
    const math::real_t endExtendedDistance);
std::vector<math::Vector3d_t> ExtendWaypoints(
    const std::vector<math::Vector3d_t> &inputWaypoints,
    const math::real_t beginExtendedDistance,
    const math::real_t beginExtendedRadian,
    const math::real_t endExtendedDistance,
    const math::real_t endExtededRadian);
math::Vector3d_t ComputeLinearAcceleration(const State &state);

} // namespace motion {

#endif // #ifndef _MOTION_UTILS_H_
