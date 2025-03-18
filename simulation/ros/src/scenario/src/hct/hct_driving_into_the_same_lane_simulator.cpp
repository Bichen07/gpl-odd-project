#include <hct_driving_into_the_same_lane_simulator.h>

namespace hct {

// public func.

DrivingIntoTheSameLaneSimulator::DrivingIntoTheSameLaneSimulator()
    : Simulator()
    , mOtherVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
{
}

void DrivingIntoTheSameLaneSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mOtherVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void DrivingIntoTheSameLaneSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
