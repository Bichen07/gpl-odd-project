#include <itri_campus_canter_vil_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace itri_campus {

// public func.

CanterVilSimulator::CanterVilSimulator()
    : Simulator()
    , mPedestrianCrossingModel{std::make_shared<unit::PedestrianCrossingModel>()}
    , mLaneRoadsideParkingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
    , mOvertakingModel{std::make_shared<unit::OvertakingModel>()}
{
}

void CanterVilSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mPedestrianCrossingModel,
        mLaneRoadsideParkingModel,
        mOvertakingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void CanterVilSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace itri_campus {
