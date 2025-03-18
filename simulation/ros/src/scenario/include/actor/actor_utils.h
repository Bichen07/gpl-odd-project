#ifndef _ACTOR_UTILS_H_
#define _ACTOR_UTILS_H_

#include <memory>
#include <math_type.h>
#include <math_frenet_coord.h>
#include <scenario/AgentAttribute.h>
#include <scenario_msgs/AgentData.h>
#include <scenario_msgs/AgentDataArray.h>
#include <motion_offset_2d.h>
#include <actor_agent.h>

namespace actor {

static constexpr const char *AgentSpeedKeyPrefix()
{return "agent_speed/";}

void UpdateAgentSpeed(const std::string &agentId, const math::real_t speed);
math::real_t QueryAgentSpeed(const std::string &agentId);

void ConfigureAgentInitStateTransform(
    const int32_t initWaypointIdx,
    const std::vector<math::Vector3d_t> &refWaypoints,
    std::shared_ptr<Agent> agent);
void ConfigureAgentInitStateTransform(
    const int32_t initWaypointIdx,
    const std::vector<math::Vector3d_t> &refWaypoints,
    const math::FrenetCoord &offset,
    std::shared_ptr<Agent> agent);
void ConfigureAgentInitStateTransform(
    const math::Vector3d_t &position,
    const math::real_t headingRadian,
    const math::real_t longitudinalOffset,
    const math::real_t lateralOffset,
    const math::real_t heightOffset,
    std::shared_ptr<Agent> agent);
void ConfigureAgentInitStateTransform(
    const math::Vector3d_t &position,
    const math::real_t headingRadian,
    const motion::Offset2d &offset2d,
    const math::real_t heightOffset,
    Agent::Ptr agent);
void ConfigureAgentInitStateTransform(
    const math::HomoXfm3d_t &xfm3d,
    const math::real_t longitudinalOffset,
    const math::real_t lateralOffset,
    const math::real_t heightOffset,
    std::shared_ptr<Agent> agent);
void ConfigureAgentInitStateTransform(
    const math::HomoXfm3d_t &xfm3d,
    const math::real_t longitudinalOffset,
    const math::real_t lateralOffset,
    const math::real_t heightOffset,
    const math::RotMat3d_t &localRotmat,
    std::shared_ptr<Agent> agent);

scenario::AgentAttribute ConvertToAgentAttributeMsg(const actor::Attribute &attribute);

} // namespace actor {

#endif // #ifndef _ACTOR_UTILS_H_
