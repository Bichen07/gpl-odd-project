#include <map_utils.h>
#include <map_waypoint_id.h>
#include <math_stream_utils.h>
#include <motion_adaptive_overtaking_config.h>
#include <motion_alks_cut_in_config.h>
#include <motion_begin_end_waypoint_following_config.h>
#include <motion_config_reader.h>
#include <motion_constant_velocity_config.h>
#include <motion_dijkstra_interpolation_waypoint_following_config.h>
#include <motion_dijkstra_waypoint_following_config.h>
#include <motion_driving_into_lane_config.h>
#include <motion_lane_roadside_moving_config.h>
#include <motion_lane_waypoint_following_config.h>
#include <motion_move_trigger_condition.h>
#include <motion_overtaking_config.h>
#include <motion_pedestrian_crossing_moving_config.h>
#include <motion_red_light_running_config.h>
#include <motion_route_moving_config.h>
#include <motion_signalized_intersection_config.h>
#include <motion_stationary_object_config.h>
#include <motion_utils.h>
#include <motion_waypoint_speed_config.h>
#include <motion_zigzag_moving_config.h>
#include <ros/console.h>
#include <utils_json.h>

namespace motion {

template <typename MotionConfigType>
void ParseMotionConfigs(
    const Json::Value &configJsonValue,
    std::function<void(const Json::Value &, MotionConfigType *)> &parseFunc,
    std::vector<MotionConfigType> *outputConfigs) {
  if (nullptr == outputConfigs) {
    ROS_ERROR_STREAM("outputConfigs is nullptr");
    throw std::invalid_argument(std::string(__FILE__ ":") +
                                std::to_string(__LINE__));
  }

  if (configJsonValue.empty()) {
    ROS_ERROR_STREAM("configJsonValue is empty");
    throw std::invalid_argument(std::string(__FILE__ ":") +
                                std::to_string(__LINE__));
  }

  outputConfigs->resize(configJsonValue.size());
  auto outputConfig{outputConfigs->begin()};
  for (const auto &value : configJsonValue) {
    parseFunc(value, &(*outputConfig));
    ++outputConfig;
  }
}
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseLaneRoadsideMovingConfig)> &parseFunc,
    std::vector<LaneRoadsideMovingConfig> *);
template void
ParseMotionConfigs(const Json::Value &,
                   std::function<decltype(ParseOvertakingConfig)> &parseFunc,
                   std::vector<OvertakingConfig> *);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseBeginEndWaypointFollowingConfig)> &parseFunc,
    std::vector<BeginEndWaypointFollowingConfig> *);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseLaneWaypointFollowingConfig)> &parseFunc,
    std::vector<LaneWaypointFollowingConfig> *);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParsePedestrianCrossingMovingConfig)> &parseFunc,
    std::vector<PedestrianCrossingMovingConfig> *);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseRedLightRunningConfig)> &parseFunc,
    std::vector<RedLightRunningConfig> *);
template void
ParseMotionConfigs(const Json::Value &,
                   std::function<decltype(ParseWaypointSpeedConfig)> &parseFunc,
                   std::vector<WaypointSpeedConfig> *);
template void
ParseMotionConfigs(const Json::Value &,
                   std::function<decltype(ParseZigzagMovingConfig)> &parseFunc,
                   std::vector<ZigzagMovingConfig> *);

template <typename MotionConfigType>
void ParseMotionConfigs(
    const Json::Value &configJsonValue,
    std::function<void(const Json::Value &, MotionConfigType &)> &parseFunc,
    std::vector<MotionConfigType> &outputConfigs) {
  if (configJsonValue.empty()) {
    ROS_ERROR_STREAM("configJsonValue is empty");
    throw std::invalid_argument(std::string(__FILE__ ":") +
                                std::to_string(__LINE__));
  }

  outputConfigs.resize(configJsonValue.size());
  auto outputConfig{outputConfigs.begin()};
  for (const auto &value : configJsonValue) {
    parseFunc(value, *outputConfig);
    ++outputConfig;
  }
}
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseAdaptiveOvertakingConfig)> &parseFunc,
    std::vector<AdaptiveOvertakingConfig> &);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseDijkstraWaypointFollowingConfig)> &parseFunc,
    std::vector<DijkstraWaypointFollowingConfig> &);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseDijkstraInterpolationWaypointFollowingConfig)>
        &parseFunc,
    std::vector<DijkstraInterpolationWaypointFollowingConfig> &);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseDrivingIntoLaneConfig)> &parseFunc,
    std::vector<DrivingIntoLaneConfig> &);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseSignalizedIntersectionConfig)> &parseFunc,
    std::vector<SignalizedIntersectionConfig> &);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseStationaryObjectConfig)> &parseFunc,
    std::vector<StationaryObjectConfig> &);
template void ParseMotionConfigs(
    const Json::Value &,
    std::function<decltype(ParseConstantVelocityConfig)> &parseFunc,
    std::vector<ConstantVelocityConfig> &);
template void
ParseMotionConfigs(const Json::Value &,
                   std::function<decltype(ParseAlksCutInConfig)> &parseFunc,
                   std::vector<AlksCutInConfig> &);
template void
ParseMotionConfigs(const Json::Value &,
                   std::function<decltype(ParseRouteMovingConfig)> &parseFunc,
                   std::vector<RouteMovingConfig> &);

} // namespace motion
