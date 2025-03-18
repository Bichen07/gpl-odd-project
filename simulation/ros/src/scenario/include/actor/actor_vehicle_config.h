#ifndef _ACTOR_VEHICLE_CONFIG_H_
#define _ACTOR_VEHICLE_CONFIG_H_

#include <std_msgs/ColorRGBA.h>
#include <math_type.h>
#include <actor_object_class_id.h>
#include <actor_safety_margin.h>

namespace actor {

struct VehicleConfig final
{
    math::Vector3d_t size;
    std_msgs::ColorRGBA color;
    math::Vector2d_t frontWarningRegionSize;
    SafetyMargin safetyMargin;
    ObjectClassId objectClassId;

    VehicleConfig()
        : size{}
        , color{}
        , frontWarningRegionSize{}
        , safetyMargin{}
        , objectClassId{ObjectClass::Null}
    {
    }
    explicit VehicleConfig(
        const math::Vector3d_t &inputSize,
        const std_msgs::ColorRGBA &inputColor,
        const math::Vector2d_t &inputFrontWarningRegionSize,
        const SafetyMargin &inputSafetyMargin,
        const ObjectClassId &inputObjectClassId)
        : size{inputSize}
        , color{inputColor}
        , frontWarningRegionSize{inputFrontWarningRegionSize}
        , safetyMargin{inputSafetyMargin}
        , objectClassId{inputObjectClassId}
    {
    }

    VehicleConfig(const VehicleConfig &other) = default;
    VehicleConfig &operator=(const VehicleConfig &other) = default;
    ~VehicleConfig() = default;
};

} // namespace actor {

#endif // #ifndef _ACTOR_VEHICLE_CONFIG_H_
