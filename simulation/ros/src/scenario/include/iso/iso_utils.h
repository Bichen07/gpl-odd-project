#ifndef _ISO_UTILS_H_
#define _ISO_UTILS_H_

#include <scenario/IsoVehicleAttribute.h>
#include <scenario/IsoVehicleState.h>
#include <actor_vehicle.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>

namespace iso {

VehicleAttribute ConvertToVehicleAttribute(const scenario::IsoVehicleAttribute &msg);
VehicleState ConvertToVehicleState(const scenario::IsoVehicleState &msg);
VehicleState ExtractVehicleState(const actor::Vehicle &vehicle);
VehicleState ExtractVehicleState(
    const std::string &actorId,
    const std::vector<scenario::IsoVehicleState> &msgs);
VehicleAttribute ExtractVehicleAttribute(const actor::Vehicle &vehicle);
VehicleAttribute ExtractVehicleAttribute(
    const std::string &carlaActorId,
    const std::vector<scenario::IsoVehicleAttribute> &msgs);
bool IsValidAgentId(const std::string &id);

namespace fvcws {

static constexpr math::real_t ComputeMinWarningDistance(
    const math::real_t relativeSpeed,
    const math::real_t targetVehicleAcceleration)
{
    return 0.8 * relativeSpeed +
           (relativeSpeed * relativeSpeed) /
           (2.0 * (6.67 - targetVehicleAcceleration));
}

} // namespace fvcws {

} // namespace iso {

#endif // #ifndef _ISO_UTILS_H_
