#include "hct_signalized_left_turning_simulator.h"

namespace hct {

// public func.

SignalizedLeftTurningSimulator::SignalizedLeftTurningSimulator()
    : Simulator()
    , mRightTurningVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
    , mSignalizedIntersectionModel{std::make_shared<unit::SignalizedIntersectionModel>()}
{
}

void SignalizedLeftTurningSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mRightTurningVehicleModel,
        mSignalizedIntersectionModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void SignalizedLeftTurningSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
