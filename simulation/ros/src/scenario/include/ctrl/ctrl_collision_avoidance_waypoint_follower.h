#ifndef _CTRL_COLLISION_AVOIDANCE_WAYPOINT_FOLLOWER_H_
#define _CTRL_COLLISION_AVOIDANCE_WAYPOINT_FOLLOWER_H_

#include <memory>
#include <math_frenet_coord.h>
#include <math_frenet_transformer.h>
#include <math_frenet_velocity_transformer.h>
#include <geometry_polygon_evaluator.h>
#include <actor_agent_manager.h>
#include <actor_ego_vehicle_observer.h>
#include <actor_vehicle.h>
#include <ctrl_waypoint_follower.h>
#include <ctrl_collision_avoidance_waypoint_follower_config.h>

namespace ctrl {

class CollisionAvoidanceWaypointFollower final
{

public:

    CollisionAvoidanceWaypointFollower();
    CollisionAvoidanceWaypointFollower(const CollisionAvoidanceWaypointFollower &) = delete;
    CollisionAvoidanceWaypointFollower &operator=(const CollisionAvoidanceWaypointFollower &) = delete;
    virtual ~CollisionAvoidanceWaypointFollower();

    const std::vector<math::Vector3d_t> &GetRefWaypoints() const;
    const std::vector<math::Vector3d_t> &GetWarningRegionCorners() const;

    void Configure(const CollisionAvoidanceWaypointFollowerConfig &config);

    void Update(const math::real_t desiredLongitudinalSpeed);

protected:

private:

    std::vector<math::Vector3d_t> ExtractTestPoints();
    math::FrenetCoord ExtractMostLikelyCollisionFrenetCoord(
        const std::vector<math::Vector3d_t> &point3ds);
    math::real_t ComputeLongitudinalSpeed(
        const math::FrenetCoord &testFrenetCoord,
        const math::Vector3d_t &testVelocity,
        const math::FrenetCoord &vehicleFrenetCoord,
        const math::Vector3d_t &vehicleVelocity) const;

    math::real_t mTimeStep;
    std::shared_ptr<actor::Vehicle> mVehicle;
    std::vector<math::Vector3d_t> mRefWaypoint3ds;
    std::vector<math::Vector2d_t> mRefWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
    math::FrenetVelocityTransformer mFrenetVelocityTransformer;
    std::shared_ptr<actor::AgentManager> mAgentManager;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    math::real_t mMinRelativeDistance;

    std::vector<math::Vector3d_t> mWarningRegionCorners;

    WaypointFollower mWaypointFollower;
    geometry::PolygonEvaluator mPolygonEvaluator;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_COLLISION_AVOIDANCE_WAYPOINT_FOLLOWER_H_
