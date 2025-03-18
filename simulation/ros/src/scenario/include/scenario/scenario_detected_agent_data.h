#ifndef _SCENARIO_DETECTED_AGENT_DATA_H_
#define _SCENARIO_DETECTED_AGENT_DATA_H_

#include <actor_attribute.h>
#include <motion_state.h>

namespace scenario {

struct DetectedAgentData
{
    actor::Attribute attribute;
    motion::State state;

    DetectedAgentData()
        : attribute{}
        , state{}
    {
    }
    DetectedAgentData(
        const actor::Attribute &inputAttribute,
        const motion::State &inputState)
        : attribute{inputAttribute}
        , state{inputState}
    {
    }
    DetectedAgentData(const DetectedAgentData &other) = default;
    DetectedAgentData &operator=(const DetectedAgentData &other) = default;
    ~DetectedAgentData() = default;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_DETECTED_AGENT_DATA_H_
