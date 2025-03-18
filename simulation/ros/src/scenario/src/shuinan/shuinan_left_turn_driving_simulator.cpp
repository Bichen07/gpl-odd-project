#include <shuinan_left_turn_driving_simulator.h>

namespace shuinan {

// public func.

LeftTurnDrivingSimulator::LeftTurnDrivingSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &LeftTurnDrivingSimulator::NavigationPathReadinessCallback,
        this);
}

void LeftTurnDrivingSimulator::Configure(const scenario::SimulatorConfig &config)
{
}

void LeftTurnDrivingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

void LeftTurnDrivingSimulator::NavigationPathReadinessCallback(
    const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }
}

} // namespace shuinan {
