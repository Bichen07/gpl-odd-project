#ifndef _SHUINAN_LEFT_TURN_DRIVING_SIMULATOR_H_
#define _SHUINAN_LEFT_TURN_DRIVING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <ros/ros.h>
#include <std_msgs/Bool.h>

namespace shuinan {

class LeftTurnDrivingSimulator final : public scenario::Simulator
{

public:

    LeftTurnDrivingSimulator();
    LeftTurnDrivingSimulator(const LeftTurnDrivingSimulator &) = delete;
    LeftTurnDrivingSimulator &operator=(const LeftTurnDrivingSimulator &) = delete;
    virtual ~LeftTurnDrivingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    virtual void NavigationPathReadinessCallback(const std_msgs::Bool &msg) override;

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_LEFT_TURN_DRIVING_SIMULATOR_H_
