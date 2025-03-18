#ifndef _CUSTOMIZED_BOX2D_H_
#define _CUSTOMIZED_BOX2D_H_

#include <ros/ros.h>
#include "Box2D/Dynamics/b2WorldCallbacks.h"
#include "Box2D/Dynamics/b2Fixture.h"
#include <itri_msgs/Path.h>
#include <itri_msgs/CarState.h>
#include <itri_msgs/Waypoint.h>
#include <itri_msgs/WaypointArray.h>
#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/Twist.h>
#include <route_mission_handler/Waypoint.h>
#include <math_frenet_transformer.h>
#include <math_frenet_velocity_transformer.h>
#include <simulation_msgs/CollisionState.h>
#include <simulation_msgs/CollisionProfile.h>
#include <simulation_srvs/RequestNavigationPath.h>


class MyB2ContactFilter: public b2ContactFilter
{
public:
    MyB2ContactFilter();
    virtual ~MyB2ContactFilter(){}

    /// Return true if contact calculations should be performed between these two shapes.
    /// @warning for performance reasons this is only called when the AABBs begin to overlap.
    virtual bool ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB);

private:
    bool mDisableCollision;
};


/// Implement this class to get contact information. You can use these results for
/// things like sounds and game logic. You can also get contact results by
/// traversing the contact lists after the time step. However, you might miss
/// some contacts because continuous physics leads to sub-stepping.
/// Additionally you may receive multiple callbacks for the same contact in a
/// single time step.
/// You should strive to make your callbacks efficient because there may be
/// many callbacks per time step.
/// @warning You cannot create/destroy Box2D entities inside these callbacks.
class MyB2ContactListener: public b2ContactListener
{
public:
    virtual ~MyB2ContactListener() {}
    MyB2ContactListener(ros::NodeHandle &);


    /// This lets you inspect a contact after the solver is finished. This is useful
    /// for inspecting impulses.
    /// Note: the contact manifold does not include time of impact impulses, which can be
    /// arbitrarily large if the sub-step is small. Hence the impulse is provided explicitly
    /// in a separate data structure.
    /// Note: this is only called for contacts that are touching, solid, and awake.
    virtual void PreSolve(b2Contact* contact, const b2Manifold * oldManifold);


private:
    void ConfigureRoutes(
        const std::vector<path_msgs::RouteWaypoint> &forwardRoute,
        const std::vector<path_msgs::RouteWaypoint> &oppositeRoute);

    path_msgs::RouteWaypoint GetNearestWaypoint(
        const geometry_msgs::Pose2D pose2d,
        const std::vector<path_msgs::RouteWaypoint> &waypoints);

    int GetNearestWaypointIdx(
        const geometry_msgs::Pose2D pose2d,
        const std::vector<path_msgs::RouteWaypoint> &waypoints);

    float GetIncludedAngle(
        const geometry_msgs::Pose2D pose2d,
        const path_msgs::RouteWaypoint nearestWaypoint);

    float GetIncludedAngle(
        const geometry_msgs::Twist twist,
        const path_msgs::RouteWaypoint nearestWaypoint);

    void CalculateVehicleInformation(
        const b2Body* body, simulation_msgs::CollisionState & vehicle);

    void CalculateNearbyWaypoints(
        simulation_msgs::CollisionState &vehicle,
        const simulation_srvs::RequestNavigationPath::Response & res);

    void CheckFrenetCoordAndSpeed(
        simulation_msgs::CollisionState &vehicle,
        const std::vector<path_msgs::RouteWaypoint> & forwardWps,
        const std::vector<path_msgs::RouteWaypoint> & oppositeWps);

    void CheckLateral(
        simulation_msgs::CollisionState &vehicle,
        const std::vector<path_msgs::RouteWaypoint> & wps);


    ros::NodeHandle mNodeHandle;
    ros::Publisher mContactPublisher;
    ros::ServiceClient mNavigationClient;

    int mCollisionSeq;

    std::string mLastCollisionWith;
    ros::Time mLastCollisionTime;

    std::vector<math::Vector3d_t> mForwardRefWaypoint3ds;
    std::vector<math::Vector2d_t> mForwardRefWaypoint2ds;
    std::vector<math::Vector3d_t> mOppositeRefWaypoint3ds;
    std::vector<math::Vector2d_t> mOppositeRefWaypoint2ds;
    math::FrenetTransformer mForwardFrenetTransformer;
    math::FrenetTransformer mOppositeFrenetTransformer;
    math::FrenetVelocityTransformer mFrenetVelocityTransformer;

};


#endif
