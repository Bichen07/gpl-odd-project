#include <actor_obstacle.h>

namespace actor {

// public func.

Obstacle::Obstacle()
    : Agent()
{
}

Obstacle::Obstacle(
    const std::string &id,
    const math::Vector3d_t &size,
    const std_msgs::ColorRGBA &color,
    const SafetyMargin &safetyMargin,
    const ObjectClassId &objectClassId)
    :Agent(id, size, color, safetyMargin, objectClassId)
{
}

Obstacle::Obstacle(
    const std::string &id,
    const ObstacleConfig &config)
    : Agent(id, config.size, config.color, config.safetyMargin, config.objectClassId)
{
}

Obstacle::Obstacle(const Obstacle &other)
    : Agent(other)
{
}

Obstacle &Obstacle::operator=(const Obstacle &other)
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

Obstacle::~Obstacle()
{
}

void Obstacle::Configure(
    const std::string &id,
    const math::Vector3d_t &size,
    const std_msgs::ColorRGBA &color,
    const SafetyMargin &safetyMargin,
    const ObjectClassId &objectClassId)
{
    Agent::SetAttribute(
        Attribute(id, size, color, safetyMargin, objectClassId));
}

// protected func.

// private func.

} // namespace actor {
