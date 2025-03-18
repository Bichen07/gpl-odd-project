#ifndef _ACTOR_PEDESTRIAN_CONFIG_H_
#define _ACTOR_PEDESTRIAN_CONFIG_H_

#include <std_msgs/ColorRGBA.h>
#include <math_type.h>
#include <actor_object_class_id.h>
#include <actor_safety_margin.h>

namespace actor {

struct PedestrianConfig final
{
    math::Vector3d_t size;
    std_msgs::ColorRGBA color;
    SafetyMargin safetyMargin;
    ObjectClassId objectClassId;

    PedestrianConfig()
        : size{}
        , color{}
        , safetyMargin{}
        , objectClassId{ObjectClass::Person}
    {
    }
    explicit PedestrianConfig(
        const math::Vector3d_t &inputSize,
        const std_msgs::ColorRGBA &inputColor,
        const SafetyMargin &inputSafetyMargin,
        const ObjectClassId &inputObjectClassId)
        : size{inputSize}
        , color{inputColor}
        , safetyMargin{inputSafetyMargin}
        , objectClassId{inputObjectClassId}
    {
    }

    PedestrianConfig(const PedestrianConfig &other) = default;
    PedestrianConfig &operator=(const PedestrianConfig &other) = default;
    ~PedestrianConfig() = default;
};

} // namespace actor {

#endif // #ifndef _ACTOR_PEDESTRIAN_CONFIG_H_
