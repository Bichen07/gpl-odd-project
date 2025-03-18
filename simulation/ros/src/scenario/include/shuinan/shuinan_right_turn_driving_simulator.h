#ifndef _SHUINAN_RIGHT_TURN_DRIVING_SIMULATOR_H_
#define _SHUINAN_RIGHT_TURN_DRIVING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <ros/ros.h>
#include <std_msgs/Bool.h>

namespace shuinan {

class RightTurnDrivingSimulator final : public scenario::Simulator
{

public:

    RightTurnDrivingSimulator();
    RightTurnDrivingSimulator(const RightTurnDrivingSimulator &) = delete;
    RightTurnDrivingSimulator &operator=(const RightTurnDrivingSimulator &) = delete;
    virtual ~RightTurnDrivingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    virtual void NavigationPathReadinessCallback(const std_msgs::Bool &msg) override;

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_RIGHT_TURN_DRIVING_SIMULATOR_H_
