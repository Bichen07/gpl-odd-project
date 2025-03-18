#include <adas_lsf_automatic_deceleration_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_specification.h>
#include <iso_test_scenario_agent_id.h>

namespace adas {
namespace lsf {

// public func.

AutomaticDecelerationSimulator::AutomaticDecelerationSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mLaneWaypointFollowingModel{std::make_shared<unit::LaneWaypointFollowingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mRetargetingCapabilityEvaluator{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &AutomaticDecelerationSimulator::NavigationPathReadinessCallback,
        this);
}

void AutomaticDecelerationSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneWaypointFollowingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
    
    mLaneWaypointFollowingModel->ConfigureIsoPerformanceEvaluation(
        mIsoAgentManager); 
}

void AutomaticDecelerationSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

void AutomaticDecelerationSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    mRetargetingCapabilityEvaluator.Configure(
        mEgoVehicleObserver,
        mIsoAgentManager,
        iso::PerformanceClass::Two,
        mNavigationPath->GetForwardWaypoints());
}

} // namespace acc {
} // namespace adas {
