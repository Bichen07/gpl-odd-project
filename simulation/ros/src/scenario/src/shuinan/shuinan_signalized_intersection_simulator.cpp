#include <shuinan_signalized_intersection_simulator.h>
#include <utils_json.h>

namespace shuinan {

// public func.

SignalizedIntersectionSimulator::SignalizedIntersectionSimulator()
    : Simulator()
    , mSignalizedIntersectionModel{std::make_shared<unit::SignalizedIntersectionModel>()}
{
}

void SignalizedIntersectionSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mSignalizedIntersectionModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void SignalizedIntersectionSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
