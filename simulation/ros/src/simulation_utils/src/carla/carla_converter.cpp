#include <carla_converter.h>
#include <math_utils.h>

namespace carla {

math::Vector3d_t ConvertToRightHandedLocation(const math::Vector3d_t &leftHandedLocation)
{
    return math::Vector3d_t(
        leftHandedLocation.x(),
        -leftHandedLocation.y(),
        leftHandedLocation.z());
}

math::Vector3d_t ConvertToRightHandedEulerAngleXyz(const math::Vector3d_t &leftHandedEulerAngleXyz)
{
    return math::Vector3d_t(
        leftHandedEulerAngleXyz.x(),
        -leftHandedEulerAngleXyz.y(),
        -leftHandedEulerAngleXyz.z());
}

math::Vector3d_t ConvertToRightHandedEulerAngleXyz(const math::Quaternion_t &leftHandedQuaternion)
{
    const math::Vector3d_t leftHandedEulerAngleXyz =
        math::ToEulerAngleXyz(leftHandedQuaternion.toRotationMatrix());
  
    return carla::ConvertToRightHandedEulerAngleXyz(leftHandedEulerAngleXyz);
}

math::Quaternion_t ConvertToRightHandedQuaternion(const math::Quaternion_t &leftHandedQuaternion)
{
    const math::Vector3d_t rightHandedEulerAngleXyz =
        carla::ConvertToRightHandedEulerAngleXyz(leftHandedQuaternion);

    return math::ToQuaternionXyz(rightHandedEulerAngleXyz);
}

math::Vector3d_t ConvertToRightHandedAngularVelocity(const math::Vector3d_t &leftHandedAngularVelocity)
{
    return math::Vector3d_t(
        leftHandedAngularVelocity.x(),
        -leftHandedAngularVelocity.y(),
        -leftHandedAngularVelocity.z());
}

math::Vector3d_t ConvertToRightHandedLinearVelocity(const math::Vector3d_t &leftHandedLinearVelocity)
{
    return math::Vector3d_t(
        leftHandedLinearVelocity.x(),
        -leftHandedLinearVelocity.y(),
        leftHandedLinearVelocity.z());
}

} // namespace carla {
