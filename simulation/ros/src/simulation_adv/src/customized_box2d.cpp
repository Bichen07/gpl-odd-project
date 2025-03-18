#include <Box2D.h>
#include <customized_box2d.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Pose2D.h>
#include <iostream>
#include <map>
#include <math.h>
#include <ros/console.h>
#include <ros/param.h>
#include <ros/ros.h>
#include <sim_vehicle.h>
#include <std_msgs/Header.h>
#include <std_msgs/String.h>
#include <string>

#define PI 3.1415926535897932384626

MyB2ContactFilter::MyB2ContactFilter()
  : b2ContactFilter()
{
    ros::param::param<bool>(
      "simulation/disable_collision", mDisableCollision, false);

    if (mDisableCollision)
        ROS_WARN("[MyBox2D] Collision disabled. ");
}

/// Return true if contact calculations should be
/// performed between these two shapes.
/// @warning for performance reasons this is
/// only called when the AABBs begin to overlap.
bool
MyB2ContactFilter::ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB)
{
    if (mDisableCollision) {
        return false;
    } else {
        const b2Filter& filterA = fixtureA->GetFilterData();
        const b2Filter& filterB = fixtureB->GetFilterData();
        // ros::param::param<bool>("sim_with_ego", mContext->simWithEgo, true);
        if (filterA.groupIndex == filterB.groupIndex &&
            filterA.groupIndex != 0) {
            return false;
        }
        return true;
    }
}

MyB2ContactListener::MyB2ContactListener(ros::NodeHandle& nodeHandle)
  : mContactPublisher{}
  , mNodeHandle{ nodeHandle }
  , mCollisionSeq{ 0 }
  , mNavigationClient{}
  , mLastCollisionWith{ "" }
  , mLastCollisionTime{ ros::Time(0.) }
  , mForwardFrenetTransformer{}
  , mOppositeFrenetTransformer{}
  , mFrenetVelocityTransformer{}
{
    mContactPublisher =
      mNodeHandle.advertise<simulation_msgs::CollisionProfile>(
        "simulation/collision_profile", 1);

    mNavigationClient =
      mNodeHandle.serviceClient<simulation_srvs::RequestNavigationPath>(
        "request_navigation_path");
}

void
MyB2ContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
{
    contact->SetEnabled(false);

    auto currentTime = ros::Time::now();
    b2Fixture* fixtureA = contact->GetFixtureA();
    b2Fixture* fixtureB = contact->GetFixtureB();
    b2Body* b2BodyA = fixtureA->GetBody();
    b2Body* b2BodyB = fixtureB->GetBody();
    const b2Filter& filterA = fixtureA->GetFilterData();
    const b2Filter& filterB = fixtureB->GetFilterData();

    CarBodyUserData* dataPtrA = (CarBodyUserData*)b2BodyA->GetUserData();
    CarBodyUserData* dataPtrB = (CarBodyUserData*)b2BodyB->GetUserData();

    std::string mIdA = dataPtrA->id;
    std::string mIdB = dataPtrB->id;

    if (mIdA.compare("ego") != 0) // A: ego, B: agent
    {
        auto idTemp = mIdA;
        mIdA = mIdB;
        mIdB = idTemp;
        auto bodyTemp = b2BodyA;
        b2BodyA = b2BodyB;
        b2BodyB = bodyTemp;
    }

    auto dt = currentTime - mLastCollisionTime;
    bool isNewCollision =
      (mLastCollisionWith != mIdB && dt > ros::Duration(5.)) ||
      dt > ros::Duration(10.);

    mLastCollisionWith = mIdB;
    mLastCollisionTime = currentTime;

    if (isNewCollision)
        mCollisionSeq += 1;
    else
        return;

    std_msgs::Header header;
    header.seq = mCollisionSeq;
    header.stamp = currentTime;

    simulation_msgs::CollisionProfile collisionProfile;
    collisionProfile.header = header;
    collisionProfile.opponent_id = mIdB;
    collisionProfile.collision_engine = 0;

    auto points = contact->GetManifold()->points;
    for (int i = 0; i < 2; i++) {
        geometry_msgs::Point contactPoint;
        contactPoint.x = points[i].localPoint.x;
        contactPoint.y = points[i].localPoint.y;
        collisionProfile.contact_points.push_back(contactPoint);
    }

    collisionProfile.ego.collision_side = 0;
    collisionProfile.ego.trajs_source = 0;
    collisionProfile.agent.collision_side = 0;
    collisionProfile.agent.trajs_source = 0;

    CalculateVehicleInformation(b2BodyA, collisionProfile.ego);
    CalculateVehicleInformation(b2BodyB, collisionProfile.agent);

    simulation_srvs::RequestNavigationPath srv;
    srv.request.ego_pose = collisionProfile.ego.pose;
    if (!mNavigationClient.call(srv)) {
        ROS_FATAL(
          "Failed to call service simulation_srvs/RequestNavigationPath.");
    }
    auto res = srv.response;

    ConfigureRoutes(res.nearby_forward_route, res.nearby_opposite_route);

    // Information from NavigationPathRunner
    collisionProfile.road_type = res.road_type;
    collisionProfile.nearby_forward_route = res.nearby_forward_route;
    collisionProfile.nearby_opposite_route = res.nearby_opposite_route;
    collisionProfile.current_waypoints = res.current_waypoints;

    // Information on required route
    CalculateNearbyWaypoints(collisionProfile.ego, res);
    CalculateNearbyWaypoints(collisionProfile.agent, res);
    collisionProfile.ego.nearest_waypoint_idx_on_current_waypoints =
      res.nearest_waypoint_idx_on_current_waypoints;
    collisionProfile.agent.nearest_waypoint_idx_on_current_waypoints = -1;

    // Calculate pose and vel about Frenet Coord
    CheckFrenetCoordAndSpeed(collisionProfile.ego,
                             res.nearby_forward_route,
                             res.nearby_opposite_route);
    CheckFrenetCoordAndSpeed(collisionProfile.agent,
                             res.nearby_forward_route,
                             res.nearby_opposite_route);

    // Check lateral position.  left: d+
    CheckLateral(collisionProfile.ego, res.nearby_forward_route);
    CheckLateral(collisionProfile.agent, res.nearby_forward_route);

    mContactPublisher.publish(collisionProfile);
}

void
MyB2ContactListener::ConfigureRoutes(
  const std::vector<path_msgs::RouteWaypoint>& forwardRoute,
  const std::vector<path_msgs::RouteWaypoint>& oppositeRoute)
{
    // std::vector<math::Vector3d_t> refForwardWaypoint3ds;
    // std::vector<math::Vector3d_t> refOppositeWaypoint3ds;
    // for (int i = 0; i < forwardRoute.size(); i++)
    // {
    //     math::Vector3d_t point(
    //         forwardRoute[i].point.x,
    //         forwardRoute[i].point.y,
    //         forwardRoute[i].point.z);
    //     refForwardWaypoint3ds.push_back(point);
    // }
    // for (int i = 0; i < oppositeRoute.size(); i++)
    // {
    //     math::Vector3d_t point(
    //         oppositeRoute[i].point.x,
    //         oppositeRoute[i].point.y,
    //         oppositeRoute[i].point.z);
    //     refOppositeWaypoint3ds.push_back(point);
    // }
    //
    // mForwardRefWaypoint3ds = refForwardWaypoint3ds;
    // mForwardRefWaypoint2ds.resize(mForwardRefWaypoint3ds.size());
    // std::transform(
    //     mForwardRefWaypoint3ds.begin(),
    //     mForwardRefWaypoint3ds.end(),
    //     mForwardRefWaypoint2ds.begin(),
    //     [](const math::Vector3d_t &waypoint3d)
    //     {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    // mForwardFrenetTransformer.Configure(
    //     mForwardRefWaypoint2ds,
    //     utils::FileLineNumPairInstance());
    //
    // mOppositeRefWaypoint3ds = refOppositeWaypoint3ds;
    // mOppositeRefWaypoint2ds.resize(mOppositeRefWaypoint3ds.size());
    // std::transform(
    //     mOppositeRefWaypoint3ds.begin(),
    //     mOppositeRefWaypoint3ds.end(),
    //     mOppositeRefWaypoint2ds.begin(),
    //     [](const math::Vector3d_t &waypoint3d)
    //     {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    // mOppositeFrenetTransformer.Configure(
    //     mOppositeRefWaypoint2ds,
    //     utils::FileLineNumPairInstance());
}

void
MyB2ContactListener::CalculateVehicleInformation(
  const b2Body* body,
  simulation_msgs::CollisionState& vehicle)
{
    CarBodyUserData* dataPtr = (CarBodyUserData*)body->GetUserData();
    vehicle.size.x = dataPtr->size.x;
    vehicle.size.y = dataPtr->size.y;
    vehicle.size.z = dataPtr->size.z;

    for (int i = 0; i < dataPtr->trajs.size(); i++) {
        auto status = dataPtr->trajs.front();
        dataPtr->trajs.pop();
        geometry_msgs::Pose2D historyPose;
        historyPose.x = status.position.x;
        historyPose.y = status.position.y;
        historyPose.theta = status.orientation;
        vehicle.trajs.push_back(historyPose);
    }

    b2Vec2 velocity = body->GetLinearVelocity();
    b2Vec2 position = body->GetPosition();

    vehicle.pose.x = position.x;
    vehicle.pose.y = position.y;
    vehicle.pose.theta = body->GetAngle();

    vehicle.twist.x = velocity.x;
    vehicle.twist.y = velocity.y;
    vehicle.twist.theta = body->GetAngularVelocity();
}

void
MyB2ContactListener::CalculateNearbyWaypoints(
  simulation_msgs::CollisionState& vehicle,
  const simulation_srvs::RequestNavigationPath::Response& res)
{
    // auto forwardWpIdx =
    //   GetNearestWaypointIdx(vehicle.pose, res.nearby_forward_route);
    // auto oppositeWpIdx =
    //   GetNearestWaypointIdx(vehicle.pose, res.nearby_opposite_route);
    // auto forwardWp = res.nearby_forward_route[forwardWpIdx];
    // auto oppositeWp = res.nearby_opposite_route[oppositeWpIdx];
    // auto angleForward = GetIncludedAngle(vehicle.twist, forwardWp);
    // auto angleOpposite = GetIncludedAngle(vehicle.twist, oppositeWp);
    //
    // vehicle.forward_included_angle = angleForward;
    // vehicle.opposite_included_angle = angleOpposite;
    // vehicle.heading_reversing = angleForward > angleOpposite;
    //
    // vehicle.nearest_waypoint_idx_on_nearby_forward_route = forwardWpIdx;
    // vehicle.nearest_waypoint_idx_on_nearby_opposite_route = oppositeWpIdx;
}

void
MyB2ContactListener::CheckFrenetCoordAndSpeed(
  simulation_msgs::CollisionState& vehicle,
  const std::vector<path_msgs::RouteWaypoint>& forwardWps,
  const std::vector<path_msgs::RouteWaypoint>& oppositeWps)
{

    // auto forwardWaypoint =
    //   forwardWps[vehicle.nearest_waypoint_idx_on_nearby_forward_route];
    // auto oppositeWaypoint =
    //   oppositeWps[vehicle.nearest_waypoint_idx_on_nearby_opposite_route];
    // auto coord = mForwardFrenetTransformer.ConvertToFrenetCoord(
    //   math::Vector2d_t(vehicle.pose.x, vehicle.pose.y));
    //
    // auto velocityForward = mFrenetVelocityTransformer.ConvertToFrenetCoord(
    //   math::Vector2d_t(vehicle.twist.x, vehicle.twist.y),
    //   forwardWaypoint.angle);
    // auto velocityOpposite = mFrenetVelocityTransformer.ConvertToFrenetCoord(
    //   math::Vector2d_t(vehicle.twist.x, vehicle.twist.y),
    //   oppositeWaypoint.angle);
    //
    // vehicle.s = coord.s();
    // vehicle.d = coord.d();
    // vehicle.s_vel = velocityForward.s();
    // vehicle.d_vel = velocityForward.d();
    //
    // vehicle.vel_reversing = velocityForward.s() < velocityOpposite.s();
    // vehicle.lat_dist_to_opposite_lane =
    //   mOppositeFrenetTransformer
    //     .ConvertToFrenetCoord(math::Vector2d_t(vehicle.pose.x,
    //     vehicle.pose.y)) .d();
    //
    // vehicle.no_longitudinal_speed_on_frenet =
    //   abs(velocityForward.s()) < vehicle.LONGITUDINAL_SPEED_THRESHOLD;
    // vehicle.no_lateral_speed_on_frenet =
    //   abs(velocityForward.d()) < vehicle.LATERAL_SPEED_THRESHOLD;
    // vehicle.is_stop = vehicle.no_longitudinal_speed_on_frenet &&
    //                   vehicle.no_lateral_speed_on_frenet;
}

void
MyB2ContactListener::CheckLateral(
  simulation_msgs::CollisionState& vehicle,
  const std::vector<path_msgs::RouteWaypoint>& wps)
{
    // auto waypoint =
    // wps[vehicle.nearest_waypoint_idx_on_nearby_forward_route]; auto l =
    // vehicle.size.x; auto w = vehicle.size.y;
    //
    // float theta = vehicle.forward_included_angle;
    // float phi = std::acos(pow(w * w + l * l, 0.5) / l);
    // float gamma = PI / 2 - theta - phi;
    // float lateralLength = pow(w * w + l * l, 0.5) / 2. * std::cos(gamma);
    //
    // auto d = vehicle.d;
    // auto threshOutRoad = waypoint.right_boundary + lateralLength / 2;
    // auto threshCrossBound = waypoint.right_boundary - lateralLength / 2;
    // auto threshCrossMidLine = waypoint.left_boundary - lateralLength / 2;
    // auto threshInOpposite = waypoint.left_boundary + lateralLength / 2;
    // if (d < 0) // Relatively right leaned
    // {
    //     if (-d > threshOutRoad)
    //         vehicle.is_outside_the_road = true;
    //     if (-d > threshCrossBound)
    //         vehicle.is_crossing_road_bound = true;
    // } else {
    //     if (d > threshCrossMidLine)
    //         vehicle.is_crossing_lane = true;
    //     if (d > threshInOpposite)
    //         vehicle.in_opposite_lane = true;
    // }
}

path_msgs::RouteWaypoint
MyB2ContactListener::GetNearestWaypoint(
  const geometry_msgs::Pose2D pose2d,
  const std::vector<path_msgs::RouteWaypoint>& waypoints)
{
    auto nearestIdx = GetNearestWaypointIdx(pose2d, waypoints);
    return waypoints[nearestIdx];
}

int
MyB2ContactListener::GetNearestWaypointIdx(
  const geometry_msgs::Pose2D pose2d,
  const std::vector<path_msgs::RouteWaypoint>& waypoints)
{
    int nearestIdx = -1;
    float nearestDist = 0.0;
    for (int i = 0; i < waypoints.size(); i++) {
        auto wp = waypoints[i].point;
        auto dist = pow(pow(pose2d.x - wp.x, 2) + pow(pose2d.y - wp.y, 2), 0.5);
        if (nearestIdx == -1 || dist < nearestDist) {
            nearestIdx = i;
            nearestDist = dist;
        }
    }
    return nearestIdx;
}

float
MyB2ContactListener::GetIncludedAngle( // 0 ~ PI, unsigned
  const geometry_msgs::Pose2D pose2d,
  const path_msgs::RouteWaypoint nearestWaypoint)
{
    auto wpAngle = nearestWaypoint.angle;
    float theta = pose2d.theta;

    auto result = abs(theta - wpAngle);

    while (result > PI * 2) {
        result -= PI * 2;
    }

    if (result > PI) {
        result = PI * 2 - result;
    }

    return result;
}

float
MyB2ContactListener::GetIncludedAngle( // 0 ~ PI, unsigned
  const geometry_msgs::Twist twist,
  const path_msgs::RouteWaypoint nearestWaypoint)
{
    auto heading = atan2(twist.linear.y, twist.linear.x);
    geometry_msgs::Pose2D dummyPose;
    dummyPose.theta = heading;
    return GetIncludedAngle(dummyPose, nearestWaypoint);
}
