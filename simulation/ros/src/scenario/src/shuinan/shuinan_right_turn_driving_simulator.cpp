#include <shuinan_right_turn_driving_simulator.h>

namespace shuinan {

// public func.

RightTurnDrivingSimulator::RightTurnDrivingSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &RightTurnDrivingSimulator::NavigationPathReadinessCallback,
        this);
}

void RightTurnDrivingSimulator::Configure(const scenario::SimulatorConfig &config)
{
}

void RightTurnDrivingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

void RightTurnDrivingSimulator::NavigationPathReadinessCallback(
    const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }
}

} // namespace shuinan {
