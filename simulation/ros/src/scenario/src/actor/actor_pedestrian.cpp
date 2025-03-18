#include <actor_pedestrian.h>

namespace actor {

// public func.

Pedestrian::Pedestrian()
    : Agent()
{
}

Pedestrian::Pedestrian(
    const std::string &id,
    const math::Vector3d_t &size,
    const std_msgs::ColorRGBA &color,
    const SafetyMargin &safetyMargin,
    const ObjectClassId &objectClassId)
    :Agent(id, size, color, safetyMargin, objectClassId)
{
}

Pedestrian::Pedestrian(
    const std::string &id,
    const PedestrianConfig &config)
    : Agent(id, config.size, config.color, config.safetyMargin, config.objectClassId)
{
}

Pedestrian::Pedestrian(const Pedestrian &other)
    : Agent(other)
{
}

Pedestrian &Pedestrian::operator=(const Pedestrian &other)
{
    if (&other == this)
    {
        return *this;
    }

    Agent::SetAttribute(other.GetAttribute());
    Agent::UpdateState(other.GetState());
    Agent::UpdateFrenetState(other.GetFrenetState());
    Agent::UpdateTransform(other.GetState());

    return *this;
}

Pedestrian::~Pedestrian()
{
}

void Pedestrian::Configure(
    const std::string &id,
    const math::Vector3d_t &size,
    const std_msgs::ColorRGBA &color,
    const SafetyMargin &safetyMargin,
    const ObjectClassId &objectClassId)
{
    Agent::SetAttribute(
        Attribute(id, size, color, safetyMargin, objectClassId));
}

void Pedestrian::Configure(
    const std::string &id,
    const PedestrianConfig &config)
{
    Agent::SetAttribute(
        Attribute(
            id, config.size, config.color, 
            config.safetyMargin, config.objectClassId));
}

// protected func.

// private func.

} // namespace actor {
