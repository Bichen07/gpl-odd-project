#ifndef _ADAS_LCDAS_OVERTAKING_TARGET_WARNING_SIMULATOR_H_
#define _ADAS_LCDAS_OVERTAKING_TARGET_WARNING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_lcdas_warning_evaluator.h>
#include <unit_lane_waypoint_following_model.h>
#include <carla_actor_update_data.h>
#include <std_msgs/Bool.h>

namespace adas {
namespace lcdas {

class OvertakingTargetWarningSimulator final : public scenario::Simulator
{

public:

    OvertakingTargetWarningSimulator();
    OvertakingTargetWarningSimulator(const OvertakingTargetWarningSimulator &) = delete;
    OvertakingTargetWarningSimulator &operator=(const OvertakingTargetWarningSimulator &) = delete;
    virtual ~OvertakingTargetWarningSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;
    virtual void RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas) override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    unit::LaneWaypointFollowingModel::Ptr mLaneWaypointFollowingModel;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    iso::lcdas::LcdasWarningEvaluator mLcdasWarningEvaluator;
};

} // namespace lcdas {
} // namespace adas {

#endif // #define _ADAS_LCDAS_OVERTAKING_TARGET_WARNING_SIMULATOR_H_
