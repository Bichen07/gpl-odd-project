#include <ctrl_waypoint_follower.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>
#include <math_frenet_coord.h>
#include <motion_utils.h>
#include <motion_frenet_state.h>

namespace ctrl {

// public func.

WaypointFollower::WaypointFollower()
    : mTimeStep{0.0}
    , mAgent{nullptr}
    , mRefWaypoint3ds{}
    , mRefWaypoint2ds{}
    , mFrenetTransformer{}
    , mYawRateFilter{std::size_t{20ul}}
    , mIsReachingTheEnd{false}
{
}

const std::vector<math::Vector3d_t> &WaypointFollower::GetRefWaypoints() const
{
    return mRefWaypoint3ds;
}

bool WaypointFollower::IsReachingTheEnd() const
{
    return mIsReachingTheEnd;
}

void WaypointFollower::Configure(
    const math::real_t timeStep,
    const std::shared_ptr<actor::Agent> &agent,
    const std::vector<math::Vector3d_t> &waypoint3ds)
{
    if (timeStep < math::real_t{1.0e-6})
    {
        ROS_ERROR_STREAM("invalid timeStep: " << timeStep);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (nullptr == agent)
    {
        ROS_ERROR_STREAM("agent is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (waypoint3ds.empty())
    {
        ROS_ERROR_STREAM("waypoint3ds is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mTimeStep = timeStep;
    mAgent = agent;
    mRefWaypoint3ds = waypoint3ds;
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
}

void WaypointFollower::Update(const math::real_t longitudinalSpeed)
{
    this->Update(longitudinalSpeed, math::real_t{0.0});
}

void WaypointFollower::Update(
    const math::real_t longitudinalSpeed,
    const math::real_t lateralSpeed)
{
    if (!mIsReachingTheEnd)
    {
        const math::FrenetCoord updatedFrenetCoord(
            mAgent->GetFrenetState().position.s() + longitudinalSpeed * mTimeStep,
            mAgent->GetFrenetState().position.d() + lateralSpeed * mTimeStep);
        const int32_t updatedFrenetIdx = mFrenetTransformer.ComputeWaypointIdx(updatedFrenetCoord);

        if (mFrenetTransformer.IsLastWaypointIdx(updatedFrenetIdx))
        {
            mIsReachingTheEnd = true;
        }

        const math::Vector2d_t updatedPosition2d = mFrenetTransformer.ConvertToCartesianCoord(
            updatedFrenetIdx,
            updatedFrenetCoord);
        const math::Vector3d_t updatedPosition3d(
            updatedPosition2d.x(),
            updatedPosition2d.y(),
            mRefWaypoint3ds.at(updatedFrenetIdx).z() + 0.5 * mAgent->GetAttribute().size.z());

        auto updatedState = motion::ComputeUpdatedState(
            mTimeStep,
            mAgent->GetState(),
            updatedPosition3d);
        mYawRateFilter.Push(updatedState.angularVelocity.z());
        const math::Vector3d_t movingAverageAngularVelocity(
            math::real_t{0.0},
            math::real_t{0.0},
            mYawRateFilter.ComputeAverage());
        updatedState.angularVelocity = movingAverageAngularVelocity;

        //ROS_INFO_STREAM('\n' <<
        //    "original: " << mAgent->GetState().linearVelocity.norm() << '\n' <<
        //    "updated:  " << updatedState.linearVelocity.norm() << '\n' <<
        //    "positionZ: " << mAgent->GetState().position.z());

        mAgent->UpdateState(updatedState);
        mAgent->UpdateTransform(updatedState);

        const auto updatedFrenetVelocity = motion::ComputeFrenetVelocity(
            mAgent->GetState().linearVelocity,
            mAgent->GetTransform2d());
        const auto updatedFrenetState = motion::FrenetState(
            updatedFrenetIdx,
            updatedFrenetCoord,
            updatedFrenetVelocity);
        mAgent->UpdateFrenetState(updatedFrenetState);
    }
    else
    {
        const auto updatedState = motion::State(
            mAgent->GetState().position,
            mAgent->GetState().orientation,
            math::Vector3d_t::Zero(),
            math::Vector3d_t::Zero());
        mAgent->UpdateState(updatedState);
        mAgent->UpdateTransform(updatedState);
        const auto updatedFrenetVelocity = motion::ComputeFrenetVelocity(
            mAgent->GetState().linearVelocity,
            mAgent->GetTransform2d());
        const auto updatedFrenetState = motion::FrenetState(
            mAgent->GetFrenetState().idx,
            mAgent->GetFrenetState().position,
            updatedFrenetVelocity);
        mAgent->UpdateFrenetState(updatedFrenetState);
    }
}

// protected func.

// private func.

} // namespace ctrl {
