#include <actor_vehicle.h>
#include <ros/console.h>
#include <math_utils.h>

namespace actor {

// public func.

Vehicle::Vehicle()
    : Agent()
    , mFrontWarningRegionSize{}
{
}

Vehicle::Vehicle(
    const std::string &id,
    const math::Vector3d_t &size,
    const std_msgs::ColorRGBA &color,
    const SafetyMargin &safetyMargin,
    const ObjectClassId &objectClassId)
    : Agent(id, size, color, safetyMargin, objectClassId)
    , mFrontWarningRegionSize{}
{
}

Vehicle::Vehicle(
    const std::string &id,
    const VehicleConfig &config)
    : Agent(id, config.size, config.color, config.safetyMargin, config.objectClassId)
    , mFrontWarningRegionSize{config.frontWarningRegionSize}
{
}

Vehicle::Vehicle(const Vehicle &other)
    : Agent(other)
    , mFrontWarningRegionSize{other.GetFrontWarningRegionSize()}
{
}

Vehicle &Vehicle::operator=(const Vehicle &other)
{
    if (&other == this)
    {
        return *this;
    }

    Agent::SetAttribute(other.GetAttribute());
    this->UpdateState(other.GetState());
    this->UpdateFrenetState(other.GetFrenetState());
    this->UpdateTransform(other.GetState());

    mFrontWarningRegionSize = other.GetFrontWarningRegionSize();

    return *this;
}

Vehicle::~Vehicle()
{
}

const math::Vector2d_t &Vehicle::GetFrontWarningRegionSize() const
{
    return mFrontWarningRegionSize;
}

void Vehicle::SetFrontWarningRegionSize(const math::Vector2d_t &size)
{
    mFrontWarningRegionSize = size;
}

void Vehicle::Configure(
    const std::string &id,
    const math::Vector3d_t &size,
    const std_msgs::ColorRGBA &color,
    const SafetyMargin &safetyMargin,
    const ObjectClassId &objectClassId)
{
    Agent::SetAttribute(
        Attribute(id, size, color, safetyMargin, objectClassId));
}

void Vehicle::Configure(
    const std::string &id,
    const VehicleConfig &config)
{
    Agent::SetAttribute(
        Attribute(
            id, config.size, config.color, 
            config.safetyMargin, config.objectClassId));

    mFrontWarningRegionSize = config.frontWarningRegionSize;
}

// protected func.

// private func.

} // namespace actor {
