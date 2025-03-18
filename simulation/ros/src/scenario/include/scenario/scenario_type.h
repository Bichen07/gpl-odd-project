#ifndef _SCENARIO_TYPE_H_
#define _SCENARIO_TYPE_H_

#include <memory>
#include <utility>
#include <string>
#include <map>
#include <math_type.h>

namespace scenario {

typedef enum class DetectedObjectState: uint32_t
{
    ForwardState = 0,
    StoppingState = 1,
    BranchLeftState = 2,
    BranchRightState = 3,
    YieldingState = 4,
    AcceleratingState = 5,
    SlowdownState = 6,
    Num,
    Null = Num
} DetectedObjectStateId;

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const DetectedObjectStateId &detectedObjectStateId)
{
    static const std::map<DetectedObjectStateId, const char *> objStateMap =
    {
        {DetectedObjectState::ForwardState,      "DetectedObjectState::ForwardState"},
        {DetectedObjectState::StoppingState,     "DetectedObjectState::StoppingState"},
        {DetectedObjectState::BranchLeftState,   "DetectedObjectState::BranchLeftState"},
        {DetectedObjectState::BranchRightState,  "DetectedObjectState::BranchRightState"},
        {DetectedObjectState::YieldingState,     "DetectedObjectState::YieldingState"},
        {DetectedObjectState::AcceleratingState, "DetectedObjectState::AcceleratingState"},
        {DetectedObjectState::SlowdownState,     "DetectedObjectState::SlowdownState"},
        {DetectedObjectState::Null,              "DetectedObjectState::Null"},
    };

    ostream << objStateMap.find(detectedObjectStateId)->second;
    return ostream;
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_TYPE_H_
