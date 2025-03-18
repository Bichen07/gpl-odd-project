#ifndef _ADAS_LSF_RETARGETING_SIMULATOR_H_
#define _ADAS_LSF_RETARGETING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_lsf_retargeting_capability_evaluator.h>
#include <unit_begin_end_waypoint_following_model.h>
#include <unit_lane_roadside_moving_model.h>

namespace adas {
namespace lsf {

class RetargetingSimulator final : public scenario::Simulator
{

public:

    RetargetingSimulator();
    RetargetingSimulator(const RetargetingSimulator &) = delete;
    RetargetingSimulator &operator=(const RetargetingSimulator &) = delete;
    virtual ~RetargetingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    unit::BeginEndWaypointFollowingModel::Ptr mBeginEndWaypointFollowingModel;
    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideMovingModel;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    iso::lsf::RetargetingCapabilityEvaluator mRetargetingCapabilityEvaluator;
};

} // namespace lsf {
} // namespace adas {

#endif // #ifndef _ADAS_LSF_RETARGETING_SIMULATOR_H_
