#include <actor_agent.h>
#include <ros/console.h>
#include <math_utils.h>
#include <geometry_utils.h>
#include <motion_utils.h>

namespace actor {

// public func.

Agent::~Agent()
{
}

const Attribute &Agent::GetAttribute() const
{
    return mAttribute;
}

const motion::State &Agent::GetState() const
{
    return mState;
}

const motion::FrenetState &Agent::GetFrenetState() const
{
    return mFrenetState;
}

const math::HomoXfm3d_t &Agent::GetTransform3d() const
{
    return mTransform3d;
}

const math::HomoXfm2d_t &Agent::GetTransform2d() const
{
    return mTransform2d;
}

const geometry::Rect3d &Agent::GetWorldBoundingRect3d() const
{
    return mWorldBoundingRect3d;
}

const geometry::Rect2d &Agent::GetWorldBoundingRect2d() const
{
    return mWorldBoundingRect2d;
}

void Agent::UpdateState(const motion::State &state)
{
    mState = state;
}

void Agent::UpdateFrenetState(const motion::FrenetState &frenetState)
{
    mFrenetState = frenetState;
}

void Agent::UpdateTransform(const motion::State &state)
{
    mTransform3d = math::HomoXfm3d_t(
        state.orientation.toRotationMatrix(),
        state.position);
    mTransform2d = motion::ComputeTransform2d(mState);

    mWorldBoundingRect3d.topLeft =
        mTransform3d *
        math::Vector3d_t(0.5 * mAttribute.size.x(), 0.5 * mAttribute.size.y(), 0.0);
    mWorldBoundingRect3d.topRight =
        mTransform3d *
        math::Vector3d_t(0.5 * mAttribute.size.x(), -0.5 * mAttribute.size.y(), 0.0);
    mWorldBoundingRect3d.bottomLeft =
        mTransform3d *
        math::Vector3d_t(-0.5 * mAttribute.size.x(), 0.5 * mAttribute.size.y(), 0.0);
    mWorldBoundingRect3d.bottomRight =
        mTransform3d *
        math::Vector3d_t(-0.5 * mAttribute.size.x(), -0.5 * mAttribute.size.y(), 0.0);

    mWorldBoundingRect2d = geometry::ConvertToRect2d(mWorldBoundingRect3d);
}

// protected func.

Agent::Agent()
    : mAttribute{}
    , mState{}
    , mFrenetState{}
    , mTransform3d{}
    , mTransform2d{}

    , mWorldBoundingRect3d{}
    , mWorldBoundingRect2d{}
{
}

Agent::Agent(
    const std::string &id,
    const math::Vector3d_t &size,
    const std_msgs::ColorRGBA &color,
    const SafetyMargin &safetyMargin,
    const ObjectClassId &objectClassId)
    : mAttribute(id, size, color, safetyMargin, objectClassId)
    , mState{}
    , mFrenetState{}
    , mTransform3d{}
    , mTransform2d{}

    , mWorldBoundingRect3d{}
    , mWorldBoundingRect2d{}
{
}

Agent::Agent(const Agent &other)
    : mAttribute{other.GetAttribute()}
    , mState{other.GetState()}
    , mFrenetState{other.GetFrenetState()}
    , mTransform3d{other.GetTransform3d()}
    , mTransform2d{other.GetTransform2d()}

    , mWorldBoundingRect3d{other.GetWorldBoundingRect3d()}
    , mWorldBoundingRect2d{other.GetWorldBoundingRect2d()}
{
}

Agent &Agent::operator=(const Agent &other)
{
    if (&other == this)
    {
        return *this;
    }

    mAttribute = other.GetAttribute();
    mState = other.GetState();
    mFrenetState = other.GetFrenetState();
    mTransform3d = other.GetTransform3d();
    mTransform2d = other.GetTransform2d();

    mWorldBoundingRect3d = other.GetWorldBoundingRect3d();
    mWorldBoundingRect2d = other.GetWorldBoundingRect2d();

    return *this;
}

void Agent::SetAttribute(const Attribute &attribute)
{
    mAttribute = attribute;
}

// private func.

} // namespace actor {
