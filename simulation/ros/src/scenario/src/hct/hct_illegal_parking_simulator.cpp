#include <hct_illegal_parking_simulator.h>

namespace hct {

// public func.

IllegalParkingSimulator::IllegalParkingSimulator()
    : Simulator()
    , mIllegalParkingVehicleModel{std::make_shared<unit::StationaryObjectModel>()}
{
}

void IllegalParkingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mIllegalParkingVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void IllegalParkingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
