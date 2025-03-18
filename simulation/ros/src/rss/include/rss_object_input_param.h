#ifndef _RSS_OBJECT_INPUT_PARAM_H_
#define _RSS_OBJECT_INPUT_PARAM_H_

#include <string>
#include <math_type.h>
#include <actor_object_class_id.h>
#include <geometry_vector_3d.h>
#include <geometry_transform_3d.h>

namespace rss {

struct ObjectInputParam final
{
    uint32_t detectedObjectId;
    geometry::Transform3d transform;
    geometry::Vector3d linearVelocity;
    geometry::Vector3d angularVelocity;
    geometry::Vector3d linearAcceleration;
    geometry::Vector3d angularAcceleration;
    geometry::Vector3d size;
    math::real_t speed;
    math::real_t yawRate;
    math::real_t steeringAngle;
    actor::ObjectClassId objectClassId;

    ObjectInputParam()
        : detectedObjectId{0ul}
        , transform{}
        , linearVelocity{}
        , angularVelocity{}
        , linearAcceleration{}
        , angularAcceleration{}
        , size{}
        , speed{0.0}
        , yawRate{0.0}
        , steeringAngle{0.0}
        , objectClassId{actor::ObjectClass::Null}
    {
    }
    ObjectInputParam(
        const uint32_t inputDetectedObjectId,
        const geometry::Transform3d &inputTransform,
        const geometry::Vector3d &inputLinearVelocity,
        const geometry::Vector3d &inputAngularVelocity,
        const geometry::Vector3d &inputLinearAcceleration,
        const geometry::Vector3d &inputAngularAcceleartion,
        const geometry::Vector3d &inputSize,
        const math::real_t &inputSpeed,
        const math::real_t &inputYawRate,
        const math::real_t &inputSteeringAngle,
        const actor::ObjectClassId &inputObjectClassId)
        : detectedObjectId{inputDetectedObjectId}
        , transform{inputTransform}
        , linearVelocity{inputLinearVelocity}
        , angularVelocity{inputAngularVelocity}
        , linearAcceleration{inputLinearAcceleration}
        , angularAcceleration{inputAngularAcceleartion}
        , size{inputSize}
        , speed{inputSpeed}
        , yawRate{inputYawRate}
        , steeringAngle{inputSteeringAngle}
        , objectClassId{inputObjectClassId}
    {
    }
    ObjectInputParam(const ObjectInputParam &) = default;
    ObjectInputParam &operator=(const ObjectInputParam &) = default;
    ~ObjectInputParam() = default;
};

} // namespace rss {

#endif // #ifndef _RSS_OBJECT_INPUT_PARAM_H_
