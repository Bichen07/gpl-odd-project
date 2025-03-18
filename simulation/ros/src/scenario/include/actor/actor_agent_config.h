#ifndef _ACTOR_AGENT_CONFIG_H_
#define _ACTOR_AGENT_CONFIG_H_

#include <std_msgs/ColorRGBA.h>
#include <math_type.h>
#include <actor_object_class_id.h>
#include <actor_safety_margin.h>

namespace actor
{

    struct AgentConfig final
    {
        math::Vector3d_t    size;
        std_msgs::ColorRGBA color;
        math::Vector2d_t    frontWarningRegionSize;
        SafetyMargin        safetyMargin;
        ObjectClassId       objectClassId;

        AgentConfig() : size{}, color{}, frontWarningRegionSize{}, safetyMargin{}, objectClassId{ObjectClass::Null}
        {
        }
        explicit AgentConfig(const math::Vector3d_t    &inputSize,
                             const std_msgs::ColorRGBA &inputColor,
                             const math::Vector2d_t    &inputFrontWarningRegionSize,
                             const SafetyMargin        &inputSafetyMargin,
                             const ObjectClassId       &inputObjectClassId)
            : size{inputSize},
              color{inputColor},
              frontWarningRegionSize{inputFrontWarningRegionSize},
              safetyMargin{inputSafetyMargin},
              objectClassId{inputObjectClassId}
        {
        }

        AgentConfig(const AgentConfig &other)            = default;
        AgentConfig &operator=(const AgentConfig &other) = default;
        ~AgentConfig()                                   = default;
    };

}  // namespace actor

#endif  // #ifndef _ACTOR_AGENT_CONFIG_H_
