#ifndef _MOTION_LATERAL_SUBMOVEMENT_H_
#define _MOTION_LATERAL_SUBMOVEMENT_H_

#include <iostream>
#include <jsoncpp/json/json.h>

namespace motion {

struct LateralSubmovement final
{
    double distance;
    double speedMps;

    LateralSubmovement()
        : distance{0.0}
        , speedMps{0.0}
    {
    }
    explicit LateralSubmovement(
        const double inputDistance,
        const double inputSpeedMps)
        : distance{inputDistance}
        , speedMps{inputSpeedMps}
    {
    }
    LateralSubmovement(const LateralSubmovement &) = default;
    LateralSubmovement &operator=(const LateralSubmovement &) = default;
    ~LateralSubmovement() = default;
};

void ParseLateralSubmovement(
    const Json::Value &configJsonValue,
    LateralSubmovement &outputLateralSubmovement);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const LateralSubmovement &submovement)
{
    ostream << "[motion::LateralSubmovement]" << '\n' <<
        "distance: " << submovement.distance << '\n' <<
        "speedMps: " << submovement.speedMps;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_LATERAL_SUBMOVEMENT_H_
