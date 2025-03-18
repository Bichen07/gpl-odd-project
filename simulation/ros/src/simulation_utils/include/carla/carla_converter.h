#ifndef _CARLA_CONVERTER_H_
#define _CARLA_CONVERTER_H_

#include <math_type.h>

namespace carla {

math::Vector3d_t ConvertToRightHandedLocation(const math::Vector3d_t &leftHandedLocation);
math::Vector3d_t ConvertToRightHandedEulerAngleXyz(const math::Vector3d_t &leftHandedEulerAngleXyz);
math::Vector3d_t ConvertToRightHandedEulerAngleXyz(const math::Quaternion_t &leftHandedQuaternion);
math::Quaternion_t ConvertToRightHandedQuaternion(const math::Quaternion_t &leftHandedQuaternion);
math::Vector3d_t ConvertToRightHandedAngularVelocity(const math::Vector3d_t &leftHandedAngularVelocity);
math::Vector3d_t ConvertToRightHandedLinearVelocity(const math::Vector3d_t &leftHandedLinearVelocity);

} // namespace carla {

#endif // #ifndef _CARLA_CONVERTER_H_
