#ifndef _MOTION_ADAPTIVE_OVERTAKING_CONFIG_H_
#define _MOTION_ADAPTIVE_OVERTAKING_CONFIG_H_

#include <map_waypoint_id.h>
#include <motion_longitudinal_submovement.h>
#include <motion_lateral_submovement.h>
#include <jsoncpp/json/json.h>

namespace motion {

struct AdaptiveOvertakingConfig final
{
    map::WaypointId beginWaypointId;
    LongitudinalSubmovement beginRelativeLongitudinalMovement;
    LateralSubmovement beginLateralMovement;
    LongitudinalSubmovement surpassingRelativeLongitudinalMovement;
    LateralSubmovement surpassingLateralMovement;
    LongitudinalSubmovement returningRelativeLongitudinalMovement;
    LateralSubmovement returningLateralMovement;
    double leadingSpeedMps; // relative to the ground
    LongitudinalSubmovement movingToRoadsideLongitudinalMovement;
    LateralSubmovement movingToRoadsideLateralMovement;
    map::WaypointId endWaypointId;

    AdaptiveOvertakingConfig()
        : beginWaypointId{}
        , beginRelativeLongitudinalMovement{}
        , beginLateralMovement{}
        , surpassingRelativeLongitudinalMovement{}
        , surpassingLateralMovement{}
        , returningRelativeLongitudinalMovement{}
        , returningLateralMovement{}
        , leadingSpeedMps{0.0}
        , movingToRoadsideLongitudinalMovement{}
        , movingToRoadsideLateralMovement{}
        , endWaypointId{}
    {
    }
    AdaptiveOvertakingConfig(const AdaptiveOvertakingConfig &) = default;
    AdaptiveOvertakingConfig &operator=(const AdaptiveOvertakingConfig &) = default;
    ~AdaptiveOvertakingConfig() = default;
};

void ParseAdaptiveOvertakingConfig(
    const Json::Value &configJsonValue,
    AdaptiveOvertakingConfig &outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const AdaptiveOvertakingConfig &config)
{
    ostream << "[motion::AdaptiveOvertakingConfig]" << '\n' <<
        "beginWaypointId" << '\n' <<
        config.beginWaypointId << '\n' <<
        "beginRelativeLongitudinalMovement" << '\n' <<
        config.beginRelativeLongitudinalMovement << '\n' <<
        "beginLateralMovement" << '\n' <<
        config.beginLateralMovement << '\n' <<
        "surpassingRelativeLongitudinalMovement" << '\n' <<
        config.surpassingRelativeLongitudinalMovement << '\n' <<
        "surpassingLateralMovement" << '\n' <<
        config.surpassingLateralMovement << '\n' <<
        "returningRelativeLongitudinalMovement" << '\n' <<
        config.returningRelativeLongitudinalMovement << '\n' <<
        "returningLateralMovement" << '\n' <<
        config.returningLateralMovement << '\n' <<
        "leadingSpeedMps: " <<
        config.leadingSpeedMps << '\n' <<
        "movingToRoadsideLongitudinalMovement" << '\n' <<
        config.movingToRoadsideLongitudinalMovement << '\n' <<
        "movingToRoadsideLateralMovement" << '\n' <<
        config.movingToRoadsideLateralMovement << '\n' <<
        "endWaypointId" << '\n' <<
        config.endWaypointId;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_ADAPTIVE_OVERTAKING_CONFIG_H_
