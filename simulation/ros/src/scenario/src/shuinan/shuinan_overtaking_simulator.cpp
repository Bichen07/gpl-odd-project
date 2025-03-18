#include <shuinan_overtaking_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace shuinan {

// public func.

OvertakingSimulator::OvertakingSimulator()
    : Simulator()
    , mOvertakingModel{std::make_shared<unit::OvertakingModel>()}
{
}

void OvertakingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mOvertakingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void OvertakingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
