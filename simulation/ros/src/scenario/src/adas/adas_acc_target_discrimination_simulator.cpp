#include <adas_acc_target_discrimination_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_specification.h>
#include <iso_test_scenario_agent_id.h>

namespace adas {
namespace acc {

// public func.

TargetDiscriminationSimulator::TargetDiscriminationSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mBeginEndWaypointFollowingModel{std::make_shared<unit::BeginEndWaypointFollowingModel>()}
    , mLaneWaypointFollowingModel{std::make_shared<unit::LaneWaypointFollowingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mTargetDiscriminationEvaluator{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &TargetDiscriminationSimulator::NavigationPathReadinessCallback,
        this);
}

void TargetDiscriminationSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mBeginEndWaypointFollowingModel,
        mLaneWaypointFollowingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
    mBeginEndWaypointFollowingModel->ConfigureIsoPerformanceEvaluation(
        mIsoAgentManager);
    mLaneWaypointFollowingModel->ConfigureIsoPerformanceEvaluation(
        mIsoAgentManager);
}

void TargetDiscriminationSimulator::Update()
{
    Simulator::Update();

    if (!mBeginEndWaypointFollowingModel->CanAccessAgentAttributes() ||
        !mLaneWaypointFollowingModel->CanAccessAgentAttributes())
    {
        return;
    }

    const auto targetVehicleAttribute{
        mIsoAgentManager->QueryVehicleAttribute(
            iso::acc::TargetDiscriminationAgent::TargetVehicle())};
    const auto targetVehicleState{
        mIsoAgentManager->QueryVehicleState(
            iso::acc::TargetDiscriminationAgent::TargetVehicle())};
    const auto forwardVehicleAttribute{
        mIsoAgentManager->QueryVehicleAttribute(
            iso::acc::TargetDiscriminationAgent::ForwardVehicle())};
    const auto forwardVehicleState{
        mIsoAgentManager->QueryVehicleState(
            iso::acc::TargetDiscriminationAgent::ForwardVehicle())};

    const auto targetDiscriminationStateId{
        mTargetDiscriminationEvaluator.Evaluate(
            targetVehicleAttribute,
            targetVehicleState,
            forwardVehicleAttribute,
            forwardVehicleState)};
    //ROS_INFO_STREAM(targetDiscriminationStateId);
}

// protected func.

// private func.

void TargetDiscriminationSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    mTargetDiscriminationEvaluator.Configure(
        mEgoVehicleObserver,
        mIsoAgentManager,
        iso::PerformanceClass::Two,
        mNavigationPath->GetForwardWaypoints(),
        iso::acc::TargetDiscrimination::DefaultDesiredVehicleEndMps());
}

} // namespace acc {
} // namespace adas {
