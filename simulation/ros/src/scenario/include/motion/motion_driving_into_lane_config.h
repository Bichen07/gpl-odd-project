#ifndef _MOTION_DRIVING_INTO_LANE_CONFIG_H_
#define _MOTION_DRIVING_INTO_LANE_CONFIG_H_

#include <iterator>
#include <iostream>
#include <jsoncpp/json/json.h>
#include <math_frenet_coord.h>

namespace motion {

struct DrivingIntoLaneConfig final
{
    std::vector<int32_t> laneIds;
    int32_t beginPointId;
    int32_t endPointId;
    math::FrenetCoord beginOffset;
    double initMovingSpeedMps;
    double moveTriggerDistance;
    double beginExtendedDistance;
    double beginExtendedRadian;

    DrivingIntoLaneConfig()
        : laneIds{}
        , beginPointId{0}
        , endPointId{0}
        , beginOffset{}
        , initMovingSpeedMps{0.0}
        , moveTriggerDistance{0.0}
        , beginExtendedDistance{0.0}
        , beginExtendedRadian{0.0}
    {
    }
    explicit DrivingIntoLaneConfig(
        const std::vector<int32_t> inputLaneIds,
        const int32_t inputBeginPointId,
        const int32_t inputEndPointId,
        const math::FrenetCoord &inputBeginOffset,
        const double inputInitMovingSpeedMps,
        const double inputMoveTriggerDistance,
        const double inputBeginExtendedDistance,
        const double inputBeginExtendedRadian)
        : laneIds{inputLaneIds}
        , beginPointId{inputBeginPointId}
        , endPointId{inputEndPointId}
        , beginOffset{inputBeginOffset}
        , initMovingSpeedMps{inputInitMovingSpeedMps}
        , moveTriggerDistance{inputMoveTriggerDistance}
        , beginExtendedDistance{inputBeginExtendedDistance}
        , beginExtendedRadian{inputBeginExtendedRadian}
    {
    }
    DrivingIntoLaneConfig(const DrivingIntoLaneConfig &other) = default;
    DrivingIntoLaneConfig &operator=(const DrivingIntoLaneConfig &) = default;
    ~DrivingIntoLaneConfig() = default;
};

void ParseDrivingIntoLaneConfig(
    const Json::Value &configJsonValue,
    DrivingIntoLaneConfig &outputconfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const DrivingIntoLaneConfig &config)
{
    ostream << "[motion::DrivingIntoLaneConfig]" << '\n' <<
        "laneIds: ";
    std::copy(
        config.laneIds.cbegin(),
        config.laneIds.cend(),
        std::ostream_iterator<int32_t>(ostream, ", "));
    ostream << '\n' <<
        "beginPointId: " << config.beginPointId << '\n' <<
        "endPointId: " << config.endPointId << '\n' <<
        "beginOffset: " << config.beginOffset << '\n' <<
        "initMovingSpeedMps: " << config.initMovingSpeedMps << '\n' <<
        "moveTriggerDistance: " << config.moveTriggerDistance << '\n' <<
        "beginExtendedDistance: " << config.beginExtendedDistance << '\n' <<
        "beginExtendedRadian: " << config.beginExtendedRadian;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_DRIVING_INTO_LANE_CONFIG_H_
