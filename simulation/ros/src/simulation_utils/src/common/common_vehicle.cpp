#include <common_vehicle.h>
#include <ros/console.h>

namespace common {

// public func.

CommonVehicle::CommonVehicle(
    const std::string & id, b2Vec2 & position, float orientation, 
    b2Vec3 & size, b2World & world, bool isEgo)
    : Vehicle(id, position, orientation, 0.0f, size, world, isEgo, 0)
{
}

CommonVehicle::CommonVehicle(
    const std::string & id, b2Vec2 & position, float orientation, 
    b2Vec3 & size, b2World & world, bool isEgo, uint64_t uniqueId)
    : Vehicle(id, position, orientation, 0.0f, size, world, isEgo, uniqueId)
{
}

// protected func.

// private func.

} // namespace common {
