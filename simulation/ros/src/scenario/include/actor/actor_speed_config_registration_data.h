#ifndef _ACTOR_SPEED_CONFIG_REGISTRATION_DATA_H_
#define _ACTOR_SPEED_CONFIG_REGISTRATION_DATA_H_

#include <string>
#include <math_type.h>
#include <math_frenet_coord.h>
#include <motion_waypoint_speed_config.h>

namespace actor {

struct SpeedConfigRegistrationData final
{
    std::string agentId;
    std::vector<math::Vector3d_t> agentWaypoints;
    math::FrenetCoord initAgentFrenetCoord;
    math::real_t initAgentSpeedMps;
    std::vector<motion::WaypointSpeedConfig> waypointSpeedConfigs;

    SpeedConfigRegistrationData()
        : agentId{}
        , agentWaypoints{}
        , initAgentFrenetCoord{}
        , initAgentSpeedMps{0.0}
        , waypointSpeedConfigs{}
    {
    }
    SpeedConfigRegistrationData(
        const std::string &inputAgentId,
        const std::vector<math::Vector3d_t> &inputAgentWaypoints,
        const math::FrenetCoord &inputInitAgentFrenetCoord,
        const math::real_t inputInitAgentSpeedMps,
        const std::vector<motion::WaypointSpeedConfig> &inputWaypointSpeedConfigs)
        : agentId{inputAgentId}
        , agentWaypoints{inputAgentWaypoints}
        , initAgentFrenetCoord{inputInitAgentFrenetCoord}
        , initAgentSpeedMps{inputInitAgentSpeedMps}
        , waypointSpeedConfigs{inputWaypointSpeedConfigs}
    {
    }
    SpeedConfigRegistrationData(const SpeedConfigRegistrationData &other) = default;
    SpeedConfigRegistrationData &operator=(const SpeedConfigRegistrationData &other) = default;
    ~SpeedConfigRegistrationData() = default;
};

} // namespace actor {

#endif // #ifndef _ACTOR_SPEED_CONFIG_REGISTRATION_DATA_H_
