#include <itri_campus_overtaking_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace itri_campus {

// public func.

AdaptiveOvertakingScenarioSimulator::AdaptiveOvertakingScenarioSimulator()
    : Simulator()
    , mAdaptiveOvertakingModel{
        std::make_shared<unit::AdaptiveOvertakingModel>()}
{
}

void AdaptiveOvertakingScenarioSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mAdaptiveOvertakingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void AdaptiveOvertakingScenarioSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace itri_campus {
