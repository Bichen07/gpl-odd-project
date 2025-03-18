#ifndef _ADAS_FVCWS_STRAIGHT_ROAD_LATERAL_DISCRIMINATION_SIMULATOR_H_
#define _ADAS_FVCWS_STRAIGHT_ROAD_LATERAL_DISCRIMINATION_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_agent_manager.h>
#include <iso_fvcws_lateral_discrimination_evaluator.h>
#include <unit_begin_end_waypoint_following_model.h>
#include <unit_lane_waypoint_following_model.h>

namespace adas {
namespace fvcws {

class StraightRoadLateralDiscriminationSimulator final : public scenario::Simulator
{

public:

    static constexpr const char *Activation()
    {return "run_adas_fvcws_lateral_discrimination";}

    StraightRoadLateralDiscriminationSimulator();
    StraightRoadLateralDiscriminationSimulator(
        const StraightRoadLateralDiscriminationSimulator &) = delete;
    StraightRoadLateralDiscriminationSimulator &operator=(
        const StraightRoadLateralDiscriminationSimulator &) = delete;
    virtual ~StraightRoadLateralDiscriminationSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    unit::BeginEndWaypointFollowingModel::Ptr mTargetVehicleModel;
    unit::LaneWaypointFollowingModel::Ptr mForwardVehicleModel;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    iso::fvcws::LateralDiscriminationEvaluator mLateralDiscriminationEvaluator;
};

} // namespace fvcws {
} // namespace adas {

#endif // #ifndef _ADAS_FVCWS_STRAIGHT_ROAD_LATERAL_DISCRIMINATION_SIMULATOR_H_
