#include <adas_fvcws_curved_road_lateral_discrimination_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_ros_param_key.h>
#include <iso_test_scenario_agent_id.h>

namespace adas {
namespace fvcws {

// public func.

CurvedRoadLateralDiscriminationSimulator::CurvedRoadLateralDiscriminationSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mTargetVehicleModel{std::make_shared<unit::BeginEndWaypointFollowingModel>()}
    , mForwardVehicleModel{std::make_shared<unit::LaneWaypointFollowingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mLateralDiscriminationEvaluator{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &CurvedRoadLateralDiscriminationSimulator::NavigationPathReadinessCallback,
        this);

    ros::param::set(Activation(), true);
}

void CurvedRoadLateralDiscriminationSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mTargetVehicleModel,
        mForwardVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
    mTargetVehicleModel->ConfigureIsoPerformanceEvaluation(mIsoAgentManager);
    mForwardVehicleModel->ConfigureIsoPerformanceEvaluation(mIsoAgentManager);
}

void CurvedRoadLateralDiscriminationSimulator::Update()
{
    Simulator::Update();

    if (!mTargetVehicleModel->CanAccessAgentAttributes() ||
        !mForwardVehicleModel->CanAccessAgentAttributes())
    {
        return;
    }

    const auto targetVehicleAttribute{
        mIsoAgentManager->QueryVehicleAttribute(
            iso::fvcws::LateralDiscriminationAgent::TargetVehicle())};
    const auto targetVehicleState{
        mIsoAgentManager->QueryVehicleState(
            iso::fvcws::LateralDiscriminationAgent::TargetVehicle())};
    const auto forwardVehicleAttribute{
        mIsoAgentManager->QueryVehicleAttribute(
            iso::fvcws::LateralDiscriminationAgent::ForwardVehicle())};
    const auto forwardVehicleState{
        mIsoAgentManager->QueryVehicleState(
            iso::fvcws::LateralDiscriminationAgent::ForwardVehicle())};

    const auto stateId{
        mLateralDiscriminationEvaluator.Evaluate(
            targetVehicleAttribute,
            targetVehicleState,
            forwardVehicleAttribute,
            forwardVehicleState)};
}

// protected func.

// private func.

void CurvedRoadLateralDiscriminationSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    mLateralDiscriminationEvaluator.Configure(
        mEgoVehicleObserver,
        mIsoAgentManager,
        mNavigationPath->GetForwardWaypoints());
}

} // namespace fvcws {
} // namespace adas {
