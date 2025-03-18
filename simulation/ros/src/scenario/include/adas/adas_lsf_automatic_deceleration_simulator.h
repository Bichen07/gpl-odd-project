#ifndef _ADAS_LSF_AUTOMATIC_DECELERATION_SIMULATOR_H_
#define _ADAS_LSF_AUTOMATIC_DECELERATION_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_lsf_retargeting_capability_evaluator.h>
#include <unit_lane_waypoint_following_model.h>

namespace adas {
namespace lsf {

class AutomaticDecelerationSimulator final : public scenario::Simulator
{

public:

    AutomaticDecelerationSimulator();
    AutomaticDecelerationSimulator(const AutomaticDecelerationSimulator &) = delete;
    AutomaticDecelerationSimulator &operator=(const AutomaticDecelerationSimulator &) = delete;
    virtual ~AutomaticDecelerationSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    unit::LaneWaypointFollowingModel::Ptr mLaneWaypointFollowingModel;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    iso::lsf::RetargetingCapabilityEvaluator mRetargetingCapabilityEvaluator;
};

} // namespace lsf {
} // namespace adas {

#endif // #ifndef _ADAS_LSF_AUTOMATIC_DECELERATION_SIMULATOR_H_
