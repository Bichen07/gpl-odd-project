#include <shuinan_red_light_running_simulator.h>
#include <utils_json.h>

namespace shuinan {

// public func.

RedLightRunningSimulator::RedLightRunningSimulator()
    : Simulator()
    , mRedLightRunningModel{std::make_shared<unit::RedLightRunningModel>()}
    , mSignalizedIntersectionModel{std::make_shared<unit::SignalizedIntersectionModel>()}
{
}

void RedLightRunningSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mRedLightRunningModel,
        mSignalizedIntersectionModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void RedLightRunningSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
