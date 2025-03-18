#ifndef _ACTOR_AGENT_SPEED_MANAGER_H_
#define _ACTOR_AGENT_SPEED_MANAGER_H_

#include <map>
#include <ros/ros.h>
#include <math_frenet_coord.h>
#include <utils_const_object_manager.h>
#include <motion_distance_speed_config.h>
#include <actor_agent.h>
#include <actor_speed_config_registration_data.h>

namespace actor {

class AgentSpeedManager final
{

public:

    AgentSpeedManager();
    AgentSpeedManager(const AgentSpeedManager &) = delete;
    AgentSpeedManager &operator=(const AgentSpeedManager &) = delete;
    virtual ~AgentSpeedManager() = default;

    void Register(const SpeedConfigRegistrationData &registrationData);
    math::real_t QuerySpeed(const Agent &agent) const;

protected:

private:

    ros::NodeHandle mNodeHandle;
    ros::ServiceClient mWaypointQueryingService;
    utils::ConstObjectManager<std::vector<motion::DistanceSpeedConfig>> mDistanceSpeedConfigManager;
    std::map<std::string, math::real_t> mAgentSpeedMap;
    std::vector<std::string> mEmptySpeedConfigAgentIds;
};

} // namespace actor {

#endif // #ifndef _ACTOR_AGENT_SPEED_MANAGER_H_
