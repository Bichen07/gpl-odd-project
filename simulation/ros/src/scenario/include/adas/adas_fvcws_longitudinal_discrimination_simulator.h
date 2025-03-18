#ifndef _ADAS_FVCWS_LONGITUDINAL_DISCRIMINATION_SIMULATOR_H_
#define _ADAS_FVCWS_LONGITUDINAL_DISCRIMINATION_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_fvcws_longitudinal_discrimination_evaluator.h>
#include <unit_begin_end_waypoint_following_model.h>

namespace adas {
namespace fvcws {

class LongitudinalDiscriminationSimulator final : public scenario::Simulator
{

public:

    LongitudinalDiscriminationSimulator();
    LongitudinalDiscriminationSimulator(
        const LongitudinalDiscriminationSimulator &) = delete;
    LongitudinalDiscriminationSimulator &operator=(
        const LongitudinalDiscriminationSimulator &) = delete;
    virtual ~LongitudinalDiscriminationSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    unit::BeginEndWaypointFollowingModel::Ptr mBeginEndWaypointFollowingModel;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    iso::fvcws::LongitudinalDiscriminationEvaluator mLongitudinalDiscriminationEvaluator;
};

} // namespace fvcws {
} // namespace adas {

#endif // #ifndef _ADAS_FVCWS_LONGITUDINAL_DISCRIMINATION_SIMULATOR_H_
