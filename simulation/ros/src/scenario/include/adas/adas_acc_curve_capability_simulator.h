#ifndef _ADAS_ACC_CURVE_CAPABILITY_SIMULATOR_H_
#define _ADAS_ACC_CURVE_CAPABILITY_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_acc_curve_capability_evaluator.h>
#include <unit_begin_end_waypoint_following_model.h>

namespace adas {
namespace acc {

class CurveCapabilitySimulator final: public scenario::Simulator
{

public:

    CurveCapabilitySimulator();
    CurveCapabilitySimulator(const CurveCapabilitySimulator &) = delete;
    CurveCapabilitySimulator &operator=(const CurveCapabilitySimulator &) = delete;
    virtual ~CurveCapabilitySimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    unit::BeginEndWaypointFollowingModel::Ptr mBeginEndWaypointFollowingModel;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    iso::acc::CurveCapabilityEvaluator mCurveCapabilityEvaluator;
};

} // namespace acc {
} // namespace adas {

#endif // #ifndef _ADAS_ACC_CURVE_CAPABILITY_SIMULATOR_H_
