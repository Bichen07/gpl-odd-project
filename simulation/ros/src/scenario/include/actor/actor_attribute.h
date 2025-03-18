#ifndef _ACTOR_ATTRIBUTE_H_
#define _ACTOR_ATTRIBUTE_H_

#include <string>
#include <std_msgs/ColorRGBA.h>
#include <math_type.h>
#include <actor_object_class_id.h>
#include <actor_safety_margin.h>

namespace actor {

struct Attribute final
{
    std::string id;
    math::Vector3d_t size;
    std_msgs::ColorRGBA color;
    SafetyMargin safetyMargin;
    ObjectClassId objectClassId;

    Attribute()
        : id{}
        , size{}
        , color{}
        , safetyMargin{}
        , objectClassId{ObjectClass::Null}
    {
    }
    explicit Attribute(
        const std::string &inputId,
        const math::Vector3d_t &inputSize,
        const std_msgs::ColorRGBA &inputColor,
        const SafetyMargin &inputSafetyMargin,
        const ObjectClassId &inputObjectClassId)
        : id(inputId)
        , size(inputSize)
        , color(inputColor)
        , safetyMargin(inputSafetyMargin)
        , objectClassId{inputObjectClassId}
    {
    }
    Attribute(const Attribute &other) = default;
    Attribute &operator=(const Attribute &other) = default;
    ~Attribute() = default;
};

} // namespace actor {

#endif // #ifndef _ACTOR_ATTRIBUTE_H_
