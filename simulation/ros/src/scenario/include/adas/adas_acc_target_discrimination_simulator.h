#ifndef _ADAS_ACC_TARGET_DISCRIMINATION_SIMULATOR_H_
#define _ADAS_ACC_TARGET_DISCRIMINATION_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_acc_target_discrimination_evaluator.h>
#include <unit_begin_end_waypoint_following_model.h>
#include <unit_lane_waypoint_following_model.h>

namespace adas {
namespace acc {

class TargetDiscriminationSimulator final : public scenario::Simulator
{

public:

    TargetDiscriminationSimulator();
    TargetDiscriminationSimulator(const TargetDiscriminationSimulator &) = delete;
    TargetDiscriminationSimulator &operator=(const TargetDiscriminationSimulator &) = delete;
    virtual ~TargetDiscriminationSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    unit::BeginEndWaypointFollowingModel::Ptr mBeginEndWaypointFollowingModel;
    unit::LaneWaypointFollowingModel::Ptr mLaneWaypointFollowingModel;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    iso::acc::TargetDiscriminationEvaluator mTargetDiscriminationEvaluator;
};

} // namespace acc {
} // namespace adas {

#endif // #ifndef _ADAS_ACC_TARGET_DISCRIMINATION_SIMULATOR_H_
