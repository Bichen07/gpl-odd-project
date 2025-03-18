#ifndef _MOTION_LONGITUDINAL_SUBMOVEMENT_H_
#define _MOTION_LONGITUDINAL_SUBMOVEMENT_H_

#include <iostream>
#include <jsoncpp/json/json.h>

namespace motion {

struct LongitudinalSubmovement final
{
    double triggerDistance;
    double speedMps;

    LongitudinalSubmovement()
        : triggerDistance{0.0}
        , speedMps{0.0}
    {
    }
    explicit LongitudinalSubmovement(
        const double inputTriggerDistance,
        const double inputSpeedMps)
        : triggerDistance{inputTriggerDistance}
        , speedMps{inputSpeedMps}
    {
    }
    LongitudinalSubmovement(const LongitudinalSubmovement &) = default;
    LongitudinalSubmovement &operator=(const LongitudinalSubmovement &) = default;
    ~LongitudinalSubmovement() = default;
};

void ParseLongitudinalSubmovement(
    const Json::Value &configJsonValue,
    LongitudinalSubmovement &outputLongitudinalSubmovement);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const LongitudinalSubmovement &submovement)
{
    ostream << "[motion::LongitudinalSubmovement]" << '\n' <<
        "triggerDistance: " << submovement.triggerDistance << '\n' <<
        "speedMps: " << submovement.speedMps;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_LONGITUDINAL_SUBMOVEMENT_H_
