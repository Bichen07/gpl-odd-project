#include <itri_campus_unsignalized_turning_coming_vehicle_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace itri_campus {

// public func.

UnsignalizedTurningComingVehicleSimulator::UnsignalizedTurningComingVehicleSimulator()
    : Simulator()
    , mLaneRoadsideComingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
{
}

void UnsignalizedTurningComingVehicleSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneRoadsideComingModel
    };
    Simulator::Configure(
        config,
        unitModels);
}

void UnsignalizedTurningComingVehicleSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace itri_campus {
