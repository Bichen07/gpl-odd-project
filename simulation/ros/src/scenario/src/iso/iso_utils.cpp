#include <iso_utils.h>
#include <utils_converter.h>
#include <iso_test_scenario_agent_id.h>

namespace iso {

VehicleAttribute ConvertToVehicleAttribute(const scenario::IsoVehicleAttribute &msg)
{
    VehicleAttribute output;
    output.size = utils::ConvertToVector3d(msg.size);

    return output;
}

VehicleState ConvertToVehicleState(const scenario::IsoVehicleState &msg)
{
    VehicleState output;
    output.pose = utils::ConvertToHomoXfm3d(msg.pose);
    output.linearVelocity = utils::ConvertToVector3d(msg.twist.linear);
    output.angularVelocity = utils::ConvertToVector3d(msg.twist.angular);
    output.linearAcceleration = utils::ConvertToVector3d(msg.accel.linear);
    output.angularAcceleration = utils::ConvertToVector3d(msg.accel.angular);

    return output;
}

VehicleState ExtractVehicleState(const actor::Vehicle &vehicle)
{
    return VehicleState{
        .pose = vehicle.GetTransform3d(),
        .linearVelocity = vehicle.GetState().linearVelocity,
        .angularVelocity = vehicle.GetState().angularVelocity,
        .linearAcceleration = math::Vector3d_t::Zero(),
        .angularAcceleration = math::Vector3d_t::Zero()};
}

VehicleState ExtractVehicleState(
    const std::string &carlaActorId,
    const std::vector<scenario::IsoVehicleState> &msgs)
{
    VehicleState outputState;
    for (const auto &msg: msgs)
    {
        if (carlaActorId == msg.id)
        {
            outputState = iso::ConvertToVehicleState(msg);
            break;
        }
    }

    return outputState;
}

VehicleAttribute ExtractVehicleAttribute(const actor::Vehicle &vehicle)
{
    return VehicleAttribute{
        .size = vehicle.GetAttribute().size};
}

VehicleAttribute ExtractVehicleAttribute(
    const std::string &actorId,
    const std::vector<scenario::IsoVehicleAttribute> &msgs)
{
    VehicleAttribute outputAttribute;
    for (const auto &msg: msgs)
    {
        if (actorId == msg.id)
        {
            outputAttribute = iso::ConvertToVehicleAttribute(msg);
            break;
        }
    }

    return outputAttribute;
}

bool IsValidAgentId(const std::string &id)
{
    static const std::vector<std::string> validAgnetIds
    {
        acc::CurveCapabilityAgent::TargetVehicle(),
        acc::TargetDiscriminationAgent::TargetVehicle(),
        acc::TargetDiscriminationAgent::ForwardVehicle(),
        lcdas::OvertakingAgent::TargetVehicle(),
        lcdas::OvertookAgent::TargetVehicle(),
        lcdas::LatralMovingAgent::TargetVehicle(),
        lsf::TargetStationaryAgent::TargetVehicle(),
        lsf::FollowingAgent::FirstTargetVehicle(),
        lsf::FollowingAgent::SecondTargetVehicle(),
        fvcws::LongitudinalDiscriminationAgent::NearTargetVehicle(),
        fvcws::LongitudinalDiscriminationAgent::FarTargetVehicle(),
        fvcws::LateralDiscriminationAgent::TargetVehicle(),
        fvcws::LateralDiscriminationAgent::ForwardVehicle(),
    };

    return std::any_of(
        validAgnetIds.cbegin(),
        validAgnetIds.cend(),
        [&id](const std::string &validAgentId)
        {return validAgentId == id;});
}

}
