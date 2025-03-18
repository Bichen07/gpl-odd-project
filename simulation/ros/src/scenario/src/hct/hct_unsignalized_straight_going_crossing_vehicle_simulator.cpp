#include <hct_unsignalized_straight_going_crossing_vehicle_simulator.h>

namespace hct {

// public func.

UnsignalizedStraightGoingCrossingVehicleSimulator::UnsignalizedStraightGoingCrossingVehicleSimulator()
    : Simulator()
    , mCrossingVehicleModel{std::make_shared<unit::DrivingIntoLaneModel>()}
{
}

void UnsignalizedStraightGoingCrossingVehicleSimulator::Configure(
    const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mCrossingVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void UnsignalizedStraightGoingCrossingVehicleSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
