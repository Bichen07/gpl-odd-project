#include <ctrl_collision_avoidance_waypoint_follower.h>
#include <ros/console.h>
#include <limits>
#include <math_utils.h>
#include <geometry_utils.h>
#include <actor_utils.h>
#include <utils_converter.h>

namespace ctrl {

// public func.

CollisionAvoidanceWaypointFollower::CollisionAvoidanceWaypointFollower()
    : mTimeStep{0.0}
    , mVehicle{nullptr}
    , mRefWaypoint3ds{}
    , mRefWaypoint2ds{}
    , mFrenetTransformer{}
    , mFrenetVelocityTransformer{}
    , mAgentManager{nullptr}
    , mEgoVehicleObserver{nullptr}

    , mWarningRegionCorners{}

    , mWaypointFollower{}
    , mPolygonEvaluator{}
{
}

CollisionAvoidanceWaypointFollower::~CollisionAvoidanceWaypointFollower()
{
}

const std::vector<math::Vector3d_t> &CollisionAvoidanceWaypointFollower::GetRefWaypoints() const
{
    return mRefWaypoint3ds;
}

const std::vector<math::Vector3d_t> &CollisionAvoidanceWaypointFollower::GetWarningRegionCorners() const
{
    return mWarningRegionCorners;
}

void CollisionAvoidanceWaypointFollower::Configure(
    const CollisionAvoidanceWaypointFollowerConfig &config)
{
    if (config.timeStep < math::real_t{1.0e-6})
    {
        ROS_ERROR_STREAM("invalid config.timeStep: " << config.timeStep);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (nullptr == config.vehicle)
    {
        ROS_ERROR_STREAM("config.vehicle is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (config.waypoint3ds.empty())
    {
        ROS_ERROR_STREAM("config.waypoint3ds is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mTimeStep = config.timeStep;
    mVehicle = config.vehicle;
    mRefWaypoint3ds = config.waypoint3ds;
    mRefWaypoint2ds.resize(mRefWaypoint3ds.size());
    std::transform(
        mRefWaypoint3ds.begin(),
        mRefWaypoint3ds.end(),
        mRefWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    mFrenetTransformer.Configure(
        mRefWaypoint2ds,
        utils::FileLineNumPairInstance());
    mAgentManager = config.agentManager;
    mEgoVehicleObserver = config.egoVehicleObserver;

    if (!geometry::IsValidSize(mVehicle->GetFrontWarningRegionSize(), 1.0e-5))
    {
        ROS_ERROR_STREAM(
            "invalid FrontWarningRegionSize: " <<
            mVehicle->GetFrontWarningRegionSize().transpose());
    }

    mMinRelativeDistance = config.minRelativeDistance;
    if (mMinRelativeDistance < 1.0e-5)
    {
        ROS_ERROR_STREAM("invalid mMinRelativeDistance: " << mMinRelativeDistance);
    }

    mWaypointFollower.Configure(
        mTimeStep,
        mVehicle,
        mRefWaypoint3ds);

    mPolygonEvaluator.Configure(mRefWaypoint3ds);
}

void CollisionAvoidanceWaypointFollower::Update(const math::real_t desiredLongitudinalSpeed)
{
    const auto testPoints = this->ExtractTestPoints();
    if (testPoints.empty())
    {
        mWaypointFollower.Update(desiredLongitudinalSpeed);
    }
    else
    {
        const auto mostLikelyCollisionFrenetCoord =
            this->ExtractMostLikelyCollisionFrenetCoord(testPoints);
        const auto relativeDistance =
            mostLikelyCollisionFrenetCoord.s() -
            mVehicle->GetFrenetState().position.s() -
            0.5 * mVehicle->GetAttribute().size.x();
        //ROS_INFO_STREAM(
        //    "mostLikelyCollisionFrenetCoord: " << mostLikelyCollisionFrenetCoord << '\n' <<
        //    "relativeDistance: " << relativeDistance);
        if (relativeDistance < mMinRelativeDistance)
        {
            mWaypointFollower.Update(0.0);
        }
        else
        {
            const math::real_t speed = this->ComputeLongitudinalSpeed(
                mostLikelyCollisionFrenetCoord,
                mEgoVehicleObserver->GetState().linearVelocity,
                mVehicle->GetFrenetState().position,
                mVehicle->GetState().linearVelocity);
            mWaypointFollower.Update(speed);
        }
    }
}

// protected func.

// private func.

std::vector<math::Vector3d_t> CollisionAvoidanceWaypointFollower::ExtractTestPoints()
{
    const math::real_t beginLongitudinalDistance =
        mVehicle->GetFrenetState().position.s() +
        0.5 * mVehicle->GetAttribute().size.x();

    const auto vehicleWarningPolygon = mPolygonEvaluator.Compute(
        beginLongitudinalDistance,
        mVehicle->GetFrontWarningRegionSize().y(),
        mVehicle->GetFrontWarningRegionSize().x());

    mWarningRegionCorners.resize(vehicleWarningPolygon.outer().size());
    const auto cornerZ{mVehicle->GetTransform3d().translation().z()};
    std::transform(
        vehicleWarningPolygon.outer().begin(),
        vehicleWarningPolygon.outer().end(),
        mWarningRegionCorners.begin(),
        [&cornerZ](const math::Vector2d_t &corner2d)
        {return math::Vector3d_t(corner2d.x(), corner2d.y(), cornerZ);});

    std::vector<math::Vector3d_t> outputTestPoints;

    const std::vector<math::Vector3d_t> egoVehicleTestPoint3ds =
    {
        mEgoVehicleObserver->GetWorldBoundingRect3d().topLeft,
        mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
        mEgoVehicleObserver->GetWorldBoundingRect3d().bottomRight,
        mEgoVehicleObserver->GetWorldBoundingRect3d().bottomLeft,
    };

    const auto egoVehicleTestPoint2ds = utils::ConvertToVector2ds(egoVehicleTestPoint3ds);
    std::vector<math::Vector2d_t> egoVehiclePolygonCorners;

    egoVehiclePolygonCorners.reserve(egoVehicleTestPoint2ds.size() + 1ul);
    egoVehiclePolygonCorners.insert(
        egoVehiclePolygonCorners.end(),
        egoVehicleTestPoint2ds.begin(),
        egoVehicleTestPoint2ds.end());
    egoVehiclePolygonCorners.push_back(egoVehicleTestPoint2ds.front());
    const auto egoVehiclePolygon = geometry::ComputePolygon(egoVehiclePolygonCorners);

    const math::real_t egoVehicleIntersectionArea = geometry::ComputeIntersectionArea(
        vehicleWarningPolygon,
        egoVehiclePolygon);
    const auto vehicleWarningPolygonArea = geometry::ComputeArea(vehicleWarningPolygon);

    const auto egoVehiclePolygonArea = geometry::ComputeArea(egoVehiclePolygon);
    if (math::IsApproxZero(egoVehiclePolygonArea, 1.0e-6))
    {
        ROS_ERROR_STREAM("egoVehiclePolygonArea is zero: " << egoVehiclePolygonArea);
    }

    if (egoVehicleIntersectionArea > 0.0)
    {
        outputTestPoints.insert(
            outputTestPoints.end(),
            egoVehicleTestPoint3ds.begin(),
            egoVehicleTestPoint3ds.end());
    }

    for (auto agent{mAgentManager->GetAgents().begin()};
         agent != mAgentManager->GetAgents().end();
         ++agent)
    {
        if ((*agent)->GetAttribute().id != mVehicle->GetAttribute().id)
        {
            const std::vector<math::Vector3d_t> agentTestPoints =
            {
                (*agent)->GetWorldBoundingRect3d().topLeft,
                (*agent)->GetWorldBoundingRect3d().topRight,
                (*agent)->GetWorldBoundingRect3d().bottomRight,
                (*agent)->GetWorldBoundingRect3d().bottomLeft,
            };

            std::vector<math::Vector3d_t> agentPolygonCorners =
            {
                (*agent)->GetWorldBoundingRect3d().topLeft,
                (*agent)->GetWorldBoundingRect3d().topRight,
                (*agent)->GetWorldBoundingRect3d().bottomRight,
                (*agent)->GetWorldBoundingRect3d().bottomLeft,
                (*agent)->GetWorldBoundingRect3d().topLeft,
            };
            const auto agentPolygon = geometry::ComputePolygon(
                utils::ConvertToVector2ds(agentPolygonCorners));
            const math::real_t agentIntersectionArea = geometry::ComputeIntersectionArea(
                vehicleWarningPolygon,
                agentPolygon);
            if (agentIntersectionArea > 0.0)
            {
                outputTestPoints.insert(
                    outputTestPoints.end(),
                    agentTestPoints.begin(),
                    agentTestPoints.end());
            }
        }
    }

    return outputTestPoints;
}

math::FrenetCoord CollisionAvoidanceWaypointFollower::ExtractMostLikelyCollisionFrenetCoord(
    const std::vector<math::Vector3d_t> &point3ds)
{
    math::real_t minLongitudinalDistance{mVehicle->GetFrontWarningRegionSize().x()};
    math::FrenetCoord outputFrenetCoord;
    for (const auto &point3d: point3ds)
    {
        const math::Vector2d_t testPoint2d(point3d.x(), point3d.y());
        const auto testFrenetCoord = mFrenetTransformer.ConvertToFrenetCoord(testPoint2d);
        const auto longitudinalDistance =
            testFrenetCoord.s() -
            mVehicle->GetFrenetState().position.s() -
            0.5 * mVehicle->GetAttribute().size.x();
        //ROS_INFO_STREAM('\n' <<
        //    "longitudinalDistance: " << longitudinalDistance << '\n' <<
        //    "minLongitudinalDistance: " << minLongitudinalDistance);
        if (longitudinalDistance < minLongitudinalDistance)
        {
            minLongitudinalDistance = longitudinalDistance;
            outputFrenetCoord = testFrenetCoord;
        }
    }

    return outputFrenetCoord;
}

math::real_t CollisionAvoidanceWaypointFollower::ComputeLongitudinalSpeed(
    const math::FrenetCoord &testFrenetCoord,
    const math::Vector3d_t &testVelocity,
    const math::FrenetCoord &vehicleFrenetCoord,
    const math::Vector3d_t &vehicleVelocity) const
{
    const math::Vector2d_t testVelocity2d(testVelocity.x(), testVelocity.y());
    const math::Vector2d_t vehicleVelocity2d(vehicleVelocity.x(), vehicleVelocity.y());

    const math::real_t vehicleHeading =
        std::atan2(vehicleVelocity2d.y(), vehicleVelocity2d.x());

    const auto vehicleFrenetVelocity = mFrenetVelocityTransformer.ConvertToFrenetCoord(
        vehicleVelocity2d,
        vehicleHeading);

    const math::real_t distanceDifference = testFrenetCoord.s() - vehicleFrenetCoord.s();
    const math::real_t acceleration =
        -math::Square(vehicleFrenetVelocity.s()) /
        (2.0 * distanceDifference);

    const math::real_t outputSpeed =
        mVehicle->GetFrenetState().velocity.s() +
        acceleration * mTimeStep;

    return outputSpeed;
}

} // namespace ctrl {
