#include <actor_agent_speed_manager.h>
#include <algorithm>
#include <stdexcept>
#include <path/WaypointQuerying.h>
#include <geometry_vector_3d.h>
#include <motion_waypoint_evaluator.h>
#include <actor_utils.h>

namespace actor {

// public func.

AgentSpeedManager::AgentSpeedManager()
    : mNodeHandle{}
    , mWaypointQueryingService{}
    , mDistanceSpeedConfigManager{}
    , mAgentSpeedMap{}
    , mEmptySpeedConfigAgentIds{}
{
    mWaypointQueryingService = mNodeHandle.serviceClient<path::WaypointQuerying>(
        "path/waypoint_querying");
}

void AgentSpeedManager::Register(const SpeedConfigRegistrationData &registrationData)
{
    actor::UpdateAgentSpeed(
        registrationData.agentId,
        registrationData.initAgentSpeedMps);

    if (registrationData.waypointSpeedConfigs.empty())
    {
        mEmptySpeedConfigAgentIds.push_back(registrationData.agentId);
        ROS_INFO_STREAM("agentId: " << registrationData.agentId);
        return;
    }

    motion::WaypointEvaluator waypointEvaluator(
        registrationData.agentWaypoints);
    std::vector<motion::DistanceSpeedConfig> distanceSpeedConfigs(
        registrationData.waypointSpeedConfigs.size() + 1ul);
    auto distanceSpeedConfig{distanceSpeedConfigs.begin()};
    distanceSpeedConfig->distance = registrationData.initAgentFrenetCoord.s();
    distanceSpeedConfig->speedMps = registrationData.initAgentSpeedMps;
    ++distanceSpeedConfig;

    auto waypointSpeedConfig{registrationData.waypointSpeedConfigs.cbegin()};
    for (; waypointSpeedConfig != registrationData.waypointSpeedConfigs.cend();
         ++waypointSpeedConfig, ++distanceSpeedConfig)
    {
        path::WaypointQuerying waypointQuerying;
        waypointQuerying.request.waypoint_id.lane;
        waypointQuerying.request.waypoint_id.point;
        if (!mWaypointQueryingService.call(waypointQuerying))
        {
            ROS_ERROR_STREAM(
                "fail to call waypoint querying service" << '\n' <<
                "requese" << '\n' <<
                waypointQuerying.request << '\n' <<
                "response" << '\n' <<
                waypointQuerying.response);
        }
        const geometry::Vector3d speedChangeWaypoint{
            waypointQuerying.response.waypoint};
        const auto speedChangeFrenetCoord = waypointEvaluator.ConvertToFrenetCoord(
            speedChangeWaypoint);
        distanceSpeedConfig->distance = speedChangeFrenetCoord.s();
        distanceSpeedConfig->speedMps = waypointSpeedConfig->speedMps;
    }

    std::sort(
        distanceSpeedConfigs.begin(),
        distanceSpeedConfigs.end());
    mDistanceSpeedConfigManager.Register(
        registrationData.agentId,
        distanceSpeedConfigs);
}

math::real_t AgentSpeedManager::QuerySpeed(const Agent &agent) const
{
    const bool isEmptySpeedConfigAgent{
        std::any_of(
            mEmptySpeedConfigAgentIds.cbegin(),
            mEmptySpeedConfigAgentIds.cend(),
            [&agent](const std::string &id)
            {return agent.GetAttribute().id == id;})};
    if (isEmptySpeedConfigAgent)
    {
        return actor::QueryAgentSpeed(agent.GetAttribute().id);
    }

    const auto speedConfigs{
        mDistanceSpeedConfigManager.QueryObject(agent.GetAttribute().id)};
    const auto speedConfig = std::upper_bound(
        speedConfigs.cbegin(),
        speedConfigs.cend(),
        motion::DistanceSpeedConfig{
        .distance = agent.GetFrenetState().position.s(),
        .speedMps = agent.GetState().linearVelocity.norm()}) - 1ul;

    if (speedConfigs.end() == speedConfig)
    {
        ROS_ERROR_STREAM("invalid speedConfig");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    actor::UpdateAgentSpeed(
        agent.GetAttribute().id,
        speedConfig->speedMps);

    return speedConfig->speedMps;
}

// protected func.

// private func.

} // namespace actor {
