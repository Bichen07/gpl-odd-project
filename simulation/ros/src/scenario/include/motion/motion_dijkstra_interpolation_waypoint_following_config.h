#ifndef _MOTION_DIJKSTRA_INTERPOLATION_WAYPOINT_FOLLOWING_CONFIG_H_
#define _MOTION_DIJKSTRA_INTERPOLATION_WAYPOINT_FOLLOWING_CONFIG_H_

#include <iostream>
#include <math_type.h>
#include <path_interpolator_id.h>
#include <map_waypoint_id.h>
#include <motion_move_trigger_condition.h>
#include <motion_waypoint_speed_config.h>

namespace motion {

struct DijkstraInterpolationWaypointFollowingConfig final
{
    int32_t beginLaneId;
    int32_t endLaneId;
    path::InterpolatorId interpolatorId;
    std::vector<math::Vector3d_t> controlPoints;
    double initMoveSpeedMps;
    MoveTriggerCondition moveTriggerCondition;
    std::vector<WaypointSpeedConfig> speedConfigs;

    DijkstraInterpolationWaypointFollowingConfig()
        : beginLaneId{0}
        , endLaneId{0}
        , interpolatorId{path::Interpolator::Null}
        , controlPoints{}
        , initMoveSpeedMps{0.0}
        , moveTriggerCondition{}
    {
    }
    DijkstraInterpolationWaypointFollowingConfig(
        const int32_t inputBeginLaneId,
        const int32_t inputEndLaneId,
        const path::InterpolatorId &inputInterpolatorId,
        const std::vector<math::Vector3d_t> &inputControlPoints,
        const double inputInitMoveSpeedMps,
        const MoveTriggerCondition &inputMoveTriggerCondition)
        : beginLaneId{inputBeginLaneId}
        , endLaneId{inputEndLaneId}
        , interpolatorId{inputInterpolatorId}
        , controlPoints{inputControlPoints}
        , initMoveSpeedMps{inputInitMoveSpeedMps}
        , moveTriggerCondition{inputMoveTriggerCondition}
    {
    }
    DijkstraInterpolationWaypointFollowingConfig(
        const DijkstraInterpolationWaypointFollowingConfig &other) = default;
    DijkstraInterpolationWaypointFollowingConfig &operator=(
        const DijkstraInterpolationWaypointFollowingConfig &other) = default;
    virtual ~DijkstraInterpolationWaypointFollowingConfig() = default;
};

void ParseDijkstraInterpolationWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    DijkstraInterpolationWaypointFollowingConfig &outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const DijkstraInterpolationWaypointFollowingConfig &config)
{
    ostream << "[motion::DijkstraInterpolationWaypointFollowingConfig]" << '\n' <<
        "beginLaneId: " << config.beginLaneId << '\n' <<
        "endLaneId: " << config.endLaneId << '\n' <<
        "inerpolatorId: " << config.interpolatorId << '\n';
    if (!config.controlPoints.empty())
    {
        ostream << "controlPoints:" << '\n';
        std::copy(
            config.controlPoints.cbegin(),
            config.controlPoints.cend(),
            std::ostream_iterator<math::Vector3d_t>(ostream, "\n"));
    }
    ostream <<
        "initMoveSpeedMps: " << config.initMoveSpeedMps << '\n' <<
        "moveTriggerCondition: " << config.moveTriggerCondition;

    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_DIJKSTRA_INTERPOLATION_WAYPOINT_FOLLOWING_CONFIG_H_
