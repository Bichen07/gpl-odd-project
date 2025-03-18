#include <adas_lcdas_overtaking_target_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_specification.h>

namespace adas {
namespace lcdas {

// public func.

OvertakingTargetWarningSimulator::OvertakingTargetWarningSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mLaneWaypointFollowingModel{std::make_shared<unit::LaneWaypointFollowingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mLcdasWarningEvaluator{}

{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &OvertakingTargetWarningSimulator::NavigationPathReadinessCallback,
        this);
}

void OvertakingTargetWarningSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneWaypointFollowingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
    mLaneWaypointFollowingModel->ConfigureIsoPerformanceEvaluation(mIsoAgentManager);
    mLcdasWarningEvaluator.Configure(
        "overtaking_target", mEgoVehicleObserver);
}

void OvertakingTargetWarningSimulator::Update()
{
    Simulator::Update();
    if (!mLaneWaypointFollowingModel->CanAccessAgentAttributes())
    {
        return;
    }
}

void OvertakingTargetWarningSimulator::RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    actorUpdateDatas->clear();
    mLaneWaypointFollowingModel->RunCarlaUpdate(actorUpdateDatas);
    mLcdasWarningEvaluator.Evaluate();
}


void OvertakingTargetWarningSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }
}

} // namespace lcdas {
} // namespace adas {
