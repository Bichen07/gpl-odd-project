#include <itri_campus_hybrid_scenario_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace itri_campus {

// public func.

HybridScenarioSimulator::HybridScenarioSimulator()
    : Simulator()
    , mPedestrianCrossingModel{std::make_shared<unit::PedestrianCrossingModel>()}
    , mLaneRoadsideParkingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
    , mOvertakingModel{std::make_shared<unit::OvertakingModel>()}
{
}

void HybridScenarioSimulator::Configure(const scenario::SimulatorConfig &config)
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

void HybridScenarioSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace itri_campus {
