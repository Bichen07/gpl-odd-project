#include <adas_lcdas_overtaking_subject_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_specification.h>

namespace adas {
namespace lcdas {

// public func.

OvertakingSubjectWarningSimulator::OvertakingSubjectWarningSimulator()
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
        &OvertakingSubjectWarningSimulator::NavigationPathReadinessCallback,
        this);
}

void OvertakingSubjectWarningSimulator::Configure(const scenario::SimulatorConfig &config)
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
        "overtaking_subject",
        mEgoVehicleObserver);
}

void OvertakingSubjectWarningSimulator::Update()
{
    Simulator::Update();

    if (!mLaneWaypointFollowingModel->CanAccessAgentAttributes())
    {
        return;
    }
}

void OvertakingSubjectWarningSimulator::RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    actorUpdateDatas->clear();
    mLaneWaypointFollowingModel->RunCarlaUpdate(actorUpdateDatas);
    mLcdasWarningEvaluator.Evaluate();
}


void OvertakingSubjectWarningSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }
}

} // namespace lcdas {
} // namespace adas {
