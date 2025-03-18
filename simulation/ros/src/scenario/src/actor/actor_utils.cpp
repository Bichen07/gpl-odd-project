#include <actor_utils.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>
#include <motion_utils.h>
#include <motion_waypoint_evaluator.h>
#include <utils_converter.h>
#include <actor_agent.h>
#include <actor_vehicle.h>
#include <actor_obstacle.h>
#include <actor_pedestrian.h>
#include <actor_ego_vehicle_observer.h>
#include <actor_object_class_id.h>

namespace actor {

void UpdateAgentSpeed(const std::string &agentId, const math::real_t speed)
{
    const std::string agentSpeedKey{AgentSpeedKeyPrefix() + agentId};
    ros::param::set(agentSpeedKey, speed);
}

math::real_t QueryAgentSpeed(const std::string &agentId)
{
    const std::string agentSpeedKey{AgentSpeedKeyPrefix() + agentId};
    math::real_t outputSpeed{0.0};
    if (!ros::param::get(agentSpeedKey, outputSpeed))
    {
        ROS_WARN_STREAM("no speed of agent " << agentId);
    }

    return outputSpeed;
}

void ConfigureAgentInitStateTransform(
    const int32_t initWaypointIdx,
    const std::vector<math::Vector3d_t> &refWaypoints,
    std::shared_ptr<Agent> agent)
{
    if (refWaypoints.empty())
    {
        ROS_ERROR_STREAM("refWaypoints is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (initWaypointIdx < 0 ||
        initWaypointIdx > static_cast<int32_t>(refWaypoints.size() - 1ul))
    {
        ROS_ERROR_STREAM(
            "invalid initWaypointIdx: " << initWaypointIdx << '\n' <<
            "refWaypoints size: " << refWaypoints.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto initForwardVector =
        refWaypoints.at(initWaypointIdx + 1) -
        refWaypoints.at(initWaypointIdx);
    const auto initHeadingRadian{
        std::atan2(initForwardVector.y(), initForwardVector.x())};
    const auto initOrientation = math::Quaternion_t(
        math::AngleAxis_t(initHeadingRadian, math::Vector3d_t::UnitZ()));
    const auto agentHalfHeightVector{
        math::Vector3d_t(0.0, 0.0, 0.5 * agent->GetAttribute().size.z())};
    const motion::State initState(
        refWaypoints.at(initWaypointIdx) + agentHalfHeightVector,
        initOrientation,
        math::Vector3d_t::Zero(),
        math::Vector3d_t::Zero());
    agent->UpdateState(initState);
    agent->UpdateTransform(initState);

    const math::FrenetCoord initFrenetVelocity = motion::ComputeFrenetVelocity(
        agent->GetState().linearVelocity,
        agent->GetTransform2d());

    const auto accumulatedDistance = math::ComputeAccumulatedDistance(
        0,
        initWaypointIdx,
        refWaypoints);
    const motion::FrenetState initFrenetState(
        initWaypointIdx,
        math::FrenetCoord(accumulatedDistance, 0.0),
        initFrenetVelocity);

    agent->UpdateFrenetState(initFrenetState);
}

void ConfigureAgentInitStateTransform(
    const int32_t initWaypointIdx,
    const std::vector<math::Vector3d_t> &refWaypoints,
    const math::FrenetCoord &offset,
    std::shared_ptr<Agent> agent)
{
    if (refWaypoints.empty())
    {
        ROS_ERROR_STREAM("refWaypoints is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (initWaypointIdx < 0 ||
        initWaypointIdx > static_cast<int32_t>(refWaypoints.size() - 1ul))
    {
        ROS_ERROR_STREAM(
            "invalid initWaypointIdx: " << initWaypointIdx << '\n' <<
            "refWaypoints size: " << refWaypoints.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    motion::WaypointEvaluator waypointEvaluator(refWaypoints);
    const auto refBeginFrenetCoord = waypointEvaluator.ConvertToFrenetCoord(
        refWaypoints.at(initWaypointIdx));
    const auto beginFrenetCoord{refBeginFrenetCoord + offset};
    const math::Vector3d_t beginPosition =
        waypointEvaluator.ConvertToCartesianCoord(beginFrenetCoord) +
        math::Vector3d_t(0.5 * agent->GetAttribute().size.z() * math::Vector3d_t::UnitZ());

    const auto initForwardVector{
        refWaypoints.at(initWaypointIdx + 1) - refWaypoints.at(initWaypointIdx)};
    const auto initHeadingRadian{std::atan2(initForwardVector.y(), initForwardVector.x())};
    const auto initOrientation = math::Quaternion_t(
        math::AngleAxis_t(initHeadingRadian, math::Vector3d_t::UnitZ()));
    const motion::State initAgentState(
        beginPosition,
        initOrientation,
        math::Vector3d_t::Zero(),
        math::Vector3d_t::Zero());
    agent->UpdateState(initAgentState);
    agent->UpdateTransform(initAgentState);

    const math::FrenetCoord initFrenetVelocity = motion::ComputeFrenetVelocity(
        agent->GetState().linearVelocity,
        agent->GetTransform2d());
    const motion::FrenetState initFrenetState(
        initWaypointIdx,
        beginFrenetCoord,
        initFrenetVelocity);
    agent->UpdateFrenetState(initFrenetState);
}

void ConfigureAgentInitStateTransform(
    const math::Vector3d_t &position,
    const math::real_t headingRadian,
    const math::real_t longitudinalOffset,
    const math::real_t lateralOffset,
    const math::real_t heightOffset,
    std::shared_ptr<Agent> agent)
{
    const math::Quaternion_t orientation(
        math::AngleAxis_t(headingRadian, math::Vector3d_t::UnitZ()));
    const math::Vector3d_t longitudinalVector = orientation * math::Vector3d_t::UnitX();
    const math::Vector3d_t lateralVector = orientation * math::Vector3d_t::UnitY();

    const math::Vector3d_t initPosition =
        position +
        longitudinalOffset * longitudinalVector +
        lateralOffset * lateralVector +
        heightOffset * math::Vector3d_t::UnitZ();

    const motion::State initState(
        initPosition,
        orientation,
        math::Vector3d_t::Zero(),
        math::Vector3d_t::Zero());

    agent->UpdateState(initState);
    agent->UpdateTransform(initState);
    agent->UpdateFrenetState(motion::FrenetState());
}

void ConfigureAgentInitStateTransform(
    const math::Vector3d_t &position,
    const math::real_t headingRadian,
    const motion::Offset2d &offset2d,
    const math::real_t heightOffset,
    Agent::Ptr agent)
{
    const math::Quaternion_t orientation(
        math::AngleAxis_t(headingRadian, math::Vector3d_t::UnitZ()));
    const math::Vector3d_t longitudinalVector = orientation * math::Vector3d_t::UnitX();
    const math::Vector3d_t lateralVector = orientation * math::Vector3d_t::UnitY();

    const math::Vector3d_t initPosition =
        position +
        offset2d.position.s() * longitudinalVector +
        offset2d.position.d() * lateralVector +
        heightOffset * math::Vector3d_t::UnitZ();

    const math::Quaternion_t offsetOrientation(
        math::AngleAxis_t(headingRadian + offset2d.orientation, math::Vector3d_t::UnitZ()));
    const motion::State initState(
        initPosition,
        offsetOrientation,
        math::Vector3d_t::Zero(),
        math::Vector3d_t::Zero());

    agent->UpdateState(initState);
    agent->UpdateTransform(initState);
    agent->UpdateFrenetState(motion::FrenetState());
}

void ConfigureAgentInitStateTransform(
    const math::HomoXfm3d_t &xfm3d,
    const math::real_t longitudinalOffset,
    const math::real_t lateralOffset,
    const math::real_t heightOffset,
    std::shared_ptr<Agent> agent)
{
    const math::Vector3d_t initPosition =
        xfm3d.translation() +
        longitudinalOffset * xfm3d.linear().col(0) +
        lateralOffset * xfm3d.linear().col(1) +
        heightOffset * math::Vector3d_t::UnitZ();

    const motion::State initState(
        initPosition,
        math::Quaternion_t(xfm3d.linear()),
        math::Vector3d_t::Zero(),
        math::Vector3d_t::Zero());

    agent->UpdateState(initState);
    agent->UpdateTransform(initState);
    agent->UpdateFrenetState(motion::FrenetState());
}

void ConfigureAgentInitStateTransform(
    const math::HomoXfm3d_t &xfm3d,
    const math::real_t longitudinalOffset,
    const math::real_t lateralOffset,
    const math::real_t heightOffset,
    const math::RotMat3d_t &localRotmat,
    std::shared_ptr<Agent> agent)
{
    const math::Vector3d_t initPosition =
        xfm3d.translation() +
        longitudinalOffset * xfm3d.linear().col(0) +
        lateralOffset * xfm3d.linear().col(1) +
        heightOffset * math::Vector3d_t::UnitZ();

    const motion::State initState(
        initPosition,
        math::Quaternion_t(xfm3d.linear() * localRotmat),
        math::Vector3d_t::Zero(),
        math::Vector3d_t::Zero());

    agent->UpdateState(initState);
    agent->UpdateTransform(initState);
    agent->UpdateFrenetState(motion::FrenetState());
}

scenario::AgentAttribute ConvertToAgentAttributeMsg(const actor::Attribute &attribute)
{
    scenario::AgentAttribute output;
    output.id = attribute.id;
    output.objectClassId = actor::ToObjectClassLabel(attribute.objectClassId);

    return output;
}

//void GenerateAgentDataMsg(
//    const Agent &agent,
//    scenario_msgs::AgentData &outputMsg)
//{
//    outputMsg.id = agent.GetAttribute().id;
//    outputMsg.pose = utils::ConvertToGeometryMsgsPose(
//        agent.GetTransform3d());
//    outputMsg.linear_velocity = utils::ConvertToGeometryMsgsVector3(
//        agent.GetState().linearVelocity);
//    outputMsg.size = utils::ConvertToGeometryMsgsVector3(
//        agent.GetAttribute().size);
//    outputMsg.color = agent.GetAttribute().color;
//    outputMsg.objectClassId = actor::ToObjectClassLabel(agent.GetAttribute().objectClassId);
//}
//
//template<typename AgentPtr>
//void GenerateAgentDataArrayMsg(
//    const std::vector<AgentPtr> &agents,
//    scenario_msgs::AgentDataArray &outputMsg)
//{
//    outputMsg.markers.resize(agents.size());
//    auto agent{agents.cbegin()};
//    auto marker{outputMsg.markers.begin()};
//    for (; agent != agents.cend();
//         ++agent, ++marker)
//    {
//        actor::GenerateAgentDataMsg(
//            *(*agent),
//            *marker);
//    }
//}
//template void GenerateAgentDataArrayMsg(
//    const std::vector<Vehicle::Ptr> &,
//    scenario_msgs::AgentDataArray &);
//template void GenerateAgentDataArrayMsg(
//    const std::vector<Pedestrian::Ptr> &,
//    scenario_msgs::AgentDataArray &);
//template void GenerateAgentDataArrayMsg(
//    const std::vector<Obstacle::Ptr> &,
//    scenario_msgs::AgentDataArray &);

} // namespace actor {
