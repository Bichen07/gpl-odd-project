#include <adas_fvcws_longitudinal_discrimination_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_test_scenario_agent_id.h>

namespace adas {
namespace fvcws {

// public func.

LongitudinalDiscriminationSimulator::LongitudinalDiscriminationSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mBeginEndWaypointFollowingModel{std::make_shared<unit::BeginEndWaypointFollowingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mLongitudinalDiscriminationEvaluator{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &LongitudinalDiscriminationSimulator::NavigationPathReadinessCallback,
        this);

    static constexpr const char *runAdasFvcwsLongitudinalDiscriminationKey{
        "run_adas_fvcws_longitudinal_discrimination"};
    ros::param::set(runAdasFvcwsLongitudinalDiscriminationKey, true);
}

void LongitudinalDiscriminationSimulator::Configure(const scenario::SimulatorConfig &config)
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

void LongitudinalDiscriminationSimulator::Update()
{
    Simulator::Update();

    if (!mBeginEndWaypointFollowingModel->CanAccessAgentAttributes())
    {
        return;
    }

    const auto targetVehicleAttribute{
        mIsoAgentManager->QueryVehicleAttribute(
            iso::fvcws::LongitudinalDiscriminationAgent::NearTargetVehicle())};
    const auto targetVehicleState{
        mIsoAgentManager->QueryVehicleState(
            iso::fvcws::LongitudinalDiscriminationAgent::NearTargetVehicle())};
    const auto longitudinalDiscriminationStateId{
        mLongitudinalDiscriminationEvaluator.Evaluate(
            targetVehicleAttribute,
            targetVehicleState)};
    ROS_INFO_STREAM(longitudinalDiscriminationStateId);
}

// protected func.

// private func.

void LongitudinalDiscriminationSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    mLongitudinalDiscriminationEvaluator.Configure(
        mEgoVehicleObserver,
        mIsoAgentManager,
        mNavigationPath->GetForwardWaypoints());
}

} // namespace fvcws {
} // namespace adas {
