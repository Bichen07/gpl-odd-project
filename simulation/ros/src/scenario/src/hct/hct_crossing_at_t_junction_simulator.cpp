#include <hct_crossing_at_t_junction_simulator.h>

namespace hct {

// public func.

CrossingAtTJunctionSimulator::CrossingAtTJunctionSimulator()
    : Simulator()
    , mCrossingVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
    , mParkingVehicleModel{std::make_shared<unit::StationaryObjectModel>()}
{
}

void CrossingAtTJunctionSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mCrossingVehicleModel,
        mParkingVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void CrossingAtTJunctionSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
