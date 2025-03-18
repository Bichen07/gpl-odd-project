#include <adas_lcdas_lateral_moving_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <iso_specification.h>

namespace adas {
namespace lcdas {

// public func.

LateralMovingSimulator::LateralMovingSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mZigzagMovingModel{std::make_shared<unit::ZigzagMovingModel>()}
    , mIsoAgentManager{std::make_shared<iso::AgentManager>()}
    , mLcdasWarningEvaluator{}

{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &LateralMovingSimulator::NavigationPathReadinessCallback,
        this);

}

void LateralMovingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mZigzagMovingModel,
    };
    Simulator::Configure(
        config,
        unitModels);

    mZigzagMovingModel->ConfigureIsoPerformanceEvaluation(
        mIsoAgentManager);
    mLcdasWarningEvaluator.Configure(
        "lateral_moving",
        mEgoVehicleObserver);

}

void LateralMovingSimulator::Update()
{
    Simulator::Update();

    if (!mZigzagMovingModel->CanAccessAgentAttributes())
    {
        return;
    }
}

void LateralMovingSimulator::RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    actorUpdateDatas->clear();
    mZigzagMovingModel->RunCarlaUpdate(actorUpdateDatas);
    mLcdasWarningEvaluator.Evaluate();
}

void LateralMovingSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }
}

} // namespace lcdas {
} // namespace adas {
