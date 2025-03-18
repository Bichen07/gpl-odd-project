#ifndef _MOTION_PEDESTRIAN_CROSSING_MOVING_CONFIG_H_
#define _MOTION_PEDESTRIAN_CROSSING_MOVING_CONFIG_H_

#include <iostream>
#include <jsoncpp/json/json.h>
#include <map_type.h>

namespace motion {

struct PedestrianCrossingMovingConfig final
{
    int32_t crosswalkId;
    int32_t crosswalkEdgeId;
    map::DirectionId forwardDirection;
    double lateralOffsetToEdge;
    double longitudinalExtendedDistance;
    double speedMps;
    double pedestrianMoveTriggerDistance;

    PedestrianCrossingMovingConfig()
        : crosswalkId{0}
        , crosswalkEdgeId{0}
        , forwardDirection{map::Direction::Null}
        , lateralOffsetToEdge{0.0}
        , longitudinalExtendedDistance{0.0}
        , speedMps{0.0}
        , pedestrianMoveTriggerDistance{0.0}
    {
    }
    explicit PedestrianCrossingMovingConfig(
        const int32_t inputCrosswalkId,
        const int32_t inputCrosswalkEdgeId,
        const map::DirectionId &inputForwardDirection,
        const double inputLateralOffsetToEdge,
        const double inputLongitudinalExtendedDistance,
        const double inputSpeedMps,
        const double inputPedestrianMoveTriggerDistance)
        : crosswalkId{inputCrosswalkId}
        , crosswalkEdgeId{inputCrosswalkEdgeId}
        , forwardDirection{inputForwardDirection}
        , lateralOffsetToEdge{inputLateralOffsetToEdge}
        , longitudinalExtendedDistance{inputLongitudinalExtendedDistance}
        , speedMps{inputSpeedMps}
        , pedestrianMoveTriggerDistance{inputPedestrianMoveTriggerDistance}
    {
    }
    PedestrianCrossingMovingConfig(const PedestrianCrossingMovingConfig &) = default;
    PedestrianCrossingMovingConfig &operator=(const PedestrianCrossingMovingConfig &) = default;;
    ~PedestrianCrossingMovingConfig() = default;
};

void ParsePedestrianCrossingMovingConfig(
    const Json::Value &configJsonValue,
    PedestrianCrossingMovingConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const PedestrianCrossingMovingConfig &config)
{
    ostream << "[motion::PedestrianCrossingMovingConfig]" << '\n' <<
        "crosswalkId: " << config.crosswalkId << '\n' <<
        "crosswalkEdgeId: " << config.crosswalkEdgeId << '\n' <<
        "forwardDirection: " << config.forwardDirection << '\n' <<
        "lateralOffsetToEdge: " << config.lateralOffsetToEdge << '\n' <<
        "longitudinalExtendedDistance: " << config.longitudinalExtendedDistance << '\n' <<
        "speedMps: " << config.speedMps << '\n' <<
        "pedestrianMoveTriggerDistance: " << config.pedestrianMoveTriggerDistance;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_PEDESTRIAN_CROSSING_MOVING_CONFIG_H_
