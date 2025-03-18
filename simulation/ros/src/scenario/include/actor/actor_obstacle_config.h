#ifndef _ACTOR_OBSTACLE_CONFIG_H_
#define _ACTOR_OBSTACLE_CONFIG_H_

#include <std_msgs/ColorRGBA.h>
#include <math_type.h>
#include <actor_object_class_id.h>
#include <actor_safety_margin.h>

namespace actor {

struct ObstacleConfig final
{
    math::Vector3d_t size;
    std_msgs::ColorRGBA color;
    SafetyMargin safetyMargin;
    ObjectClassId objectClassId;

    ObstacleConfig()
        : size{}
        , color{}
        , safetyMargin{}
        , objectClassId{ObjectClass::Null}
    {
    }
    explicit ObstacleConfig(
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

    ObstacleConfig(const ObstacleConfig &other) = default;
    ObstacleConfig &operator=(const ObstacleConfig &other) = default;
    ~ObstacleConfig() = default;
};

} // namespace actor {

#endif // #ifndef _ACTOR_OBSTACLE_CONFIG_H_
