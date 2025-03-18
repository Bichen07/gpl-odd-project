#include <adas_lkas_straight_lane_keeping_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_specification.h>

namespace adas {
namespace lkas {

// public func.

StraightLaneKeepingSimulator::StraightLaneKeepingSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mLaneKeepingEvaluator{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &StraightLaneKeepingSimulator::NavigationPathReadinessCallback,
        this);
}

void StraightLaneKeepingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    Simulator::Configure(config);
}

void StraightLaneKeepingSimulator::Update()
{
    mLaneKeepingEvaluator.Evaluate();
}

void StraightLaneKeepingSimulator::RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
}

void StraightLaneKeepingSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    mLaneKeepingEvaluator.Configure(
        mEgoVehicleObserver,
        mNavigationPath,
        mTimeStep);
}

} // namespace lkas {
} // namespace adas {
