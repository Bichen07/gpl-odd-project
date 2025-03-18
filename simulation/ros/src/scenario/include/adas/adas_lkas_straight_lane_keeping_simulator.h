#ifndef _ADAS_LKAS_LANE_KEEPING_SIMULATOR_H_
#define _ADAS_LKAS_LANE_KEEPING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <iso_lkas_lane_keeping_evaluator.h>
#include <carla_actor_update_data.h>
#include <std_msgs/Bool.h>

namespace adas {
namespace lkas {

class StraightLaneKeepingSimulator final : public scenario::Simulator
{

public:

    StraightLaneKeepingSimulator();
    StraightLaneKeepingSimulator(const StraightLaneKeepingSimulator &) = delete;
    StraightLaneKeepingSimulator &operator=(const StraightLaneKeepingSimulator &) = delete;
    virtual ~StraightLaneKeepingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;
    virtual void RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas) override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);
    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    iso::lkas::LaneKeepingEvaluator mLaneKeepingEvaluator;
};

} // namespace lkas {
} // namespace adas {

#endif // #ifndef _ADAS_LKAS_LANE_KEEPING_SIMULATOR_H_
