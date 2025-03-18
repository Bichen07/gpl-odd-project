#ifndef _CTRL_COLLISION_AVOIDANCE_WAYPOINT_FOLLOWER_CONFIG_H_
#define _CTRL_COLLISION_AVOIDANCE_WAYPOINT_FOLLOWER_CONFIG_H_

#include <math_type.h>
#include <actor_agent_manager.h>
#include <actor_ego_vehicle_observer.h>

namespace ctrl {

struct CollisionAvoidanceWaypointFollowerConfig final
{
    math::real_t timeStep;
    std::shared_ptr<actor::Vehicle> vehicle;
    std::vector<math::Vector3d_t> waypoint3ds;
    std::shared_ptr<actor::AgentManager> agentManager;
    std::shared_ptr<actor::EgoVehicleObserver> egoVehicleObserver;
    math::real_t minRelativeDistance;

    CollisionAvoidanceWaypointFollowerConfig()
        : timeStep{0.0}
        , vehicle{nullptr}
        , waypoint3ds{}
        , agentManager{nullptr}
        , egoVehicleObserver{nullptr}
        , minRelativeDistance{0.0}
    {
    }
    explicit CollisionAvoidanceWaypointFollowerConfig(
        const math::real_t inputTimeStep,
        const std::shared_ptr<actor::Vehicle> &inputVehicle,
        const std::vector<math::Vector3d_t> &inputWaypoint3ds,
        const std::shared_ptr<actor::AgentManager> &inputAgentManager,
        const std::shared_ptr<actor::EgoVehicleObserver> &inputEgoVehicleObserver,
        const math::real_t inputMinRelativeDistance)
        : timeStep{inputTimeStep}
        , vehicle{inputVehicle}
        , waypoint3ds{inputWaypoint3ds}
        , agentManager{inputAgentManager}
        , egoVehicleObserver{inputEgoVehicleObserver}
        , minRelativeDistance{inputMinRelativeDistance}
    {
    }
    CollisionAvoidanceWaypointFollowerConfig(
        const CollisionAvoidanceWaypointFollowerConfig &) = default;
    CollisionAvoidanceWaypointFollowerConfig &operator=(
        const CollisionAvoidanceWaypointFollowerConfig &) = default;
    ~CollisionAvoidanceWaypointFollowerConfig() = default;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_COLLISION_AVOIDANCE_WAYPOINT_FOLLOWER_CONFIG_H_
