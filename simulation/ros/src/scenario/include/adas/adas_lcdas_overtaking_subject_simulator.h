#ifndef _ADAS_LCDAS_OVERTAKING_SUBJECT_SIMULATOR_H_
#define _ADAS_LCDAS_OVERTAKING_SUBJECT_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_lcdas_warning_evaluator.h>
#include <unit_lane_waypoint_following_model.h>
#include <carla_actor_update_data.h>
#include <std_msgs/Bool.h>

namespace adas {
namespace lcdas {

class OvertakingSubjectWarningSimulator final : public scenario::Simulator
{

public:

    OvertakingSubjectWarningSimulator();
    OvertakingSubjectWarningSimulator(const OvertakingSubjectWarningSimulator &) = delete;
    OvertakingSubjectWarningSimulator &operator=(const OvertakingSubjectWarningSimulator &) = delete;
    virtual ~OvertakingSubjectWarningSimulator() = default;

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

#endif //ifndef _ADAS_LCDAS_OVERTAKING_SUBJECT_SIMULATOR_H_
