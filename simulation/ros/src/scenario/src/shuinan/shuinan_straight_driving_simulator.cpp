#include <shuinan_straight_driving_simulator.h>

namespace shuinan {

// public func.

StraightDrivingSimulator::StraightDrivingSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &StraightDrivingSimulator::NavigationPathReadinessCallback,
        this);
}

void StraightDrivingSimulator::Configure(const scenario::SimulatorConfig &config)
{
}

void StraightDrivingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

void StraightDrivingSimulator::NavigationPathReadinessCallback(
    const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }
}

} // namespace shuinan {
