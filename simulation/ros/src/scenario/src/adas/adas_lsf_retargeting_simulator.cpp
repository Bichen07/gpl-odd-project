#include <adas_lsf_retargeting_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_specification.h>
#include <iso_test_scenario_agent_id.h>

namespace adas {
namespace lsf {

// public func.

RetargetingSimulator::RetargetingSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mBeginEndWaypointFollowingModel{std::make_shared<unit::BeginEndWaypointFollowingModel>()}
    , mLaneRoadsideMovingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mRetargetingCapabilityEvaluator{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &RetargetingSimulator::NavigationPathReadinessCallback,
        this);
}

void RetargetingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mBeginEndWaypointFollowingModel,
        mLaneRoadsideMovingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
    mBeginEndWaypointFollowingModel->ConfigureIsoPerformanceEvaluation(mIsoAgentManager); 
    mLaneRoadsideMovingModel->ConfigureIsoPerformanceEvaluation(mIsoAgentManager);
}

void RetargetingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

void RetargetingSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
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
