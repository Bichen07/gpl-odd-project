#include <adas_acc_curve_capability_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_test_scenario_agent_id.h>

namespace adas {
namespace acc {

// public func.

CurveCapabilitySimulator::CurveCapabilitySimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mBeginEndWaypointFollowingModel{std::make_shared<unit::BeginEndWaypointFollowingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mCurveCapabilityEvaluator{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &CurveCapabilitySimulator::NavigationPathReadinessCallback,
        this);
}

void CurveCapabilitySimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mBeginEndWaypointFollowingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
    mBeginEndWaypointFollowingModel->ConfigureIsoPerformanceEvaluation(
        mIsoAgentManager);
}

void CurveCapabilitySimulator::Update()
{
    Simulator::Update();

    if (!mBeginEndWaypointFollowingModel->CanAccessAgentAttributes())
    {
        return;
    }

    const auto targetVehicleAttribute{
        mIsoAgentManager->QueryVehicleAttribute(
            iso::acc::CurveCapabilityAgent::TargetVehicle())};
    const auto targetVehicleState{
        mIsoAgentManager->QueryVehicleState(
            iso::acc::CurveCapabilityAgent::TargetVehicle())};

    const auto timeGapPerformance{
        mCurveCapabilityEvaluator.Evaluate(
            targetVehicleAttribute,
            targetVehicleState)};
    ROS_INFO_STREAM(timeGapPerformance);
}

// protected func.

// private func.

void CurveCapabilitySimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    mCurveCapabilityEvaluator.Configure(
        mEgoVehicleObserver,
        mIsoAgentManager,
        iso::PerformanceClass::Two,
        mNavigationPath->GetForwardWaypoints());
}

} // namespace acc {
} // namespace adas {
