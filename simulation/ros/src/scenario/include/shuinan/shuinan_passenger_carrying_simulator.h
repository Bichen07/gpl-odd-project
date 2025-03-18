#ifndef _SHUINAN_PASSENGER_CARRYING_SIMULATOR_H_
#define _SHUINAN_PASSENGER_CARRYING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <map_bus_station_manager.h>

namespace shuinan {

class PassengerCarryingSimulator final : public scenario::Simulator
{

public:

    PassengerCarryingSimulator();
    PassengerCarryingSimulator(const PassengerCarryingSimulator &) = delete;
    PassengerCarryingSimulator &operator=(const PassengerCarryingSimulator &) = delete;
    virtual ~PassengerCarryingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    map::BusStationManager mBusStationManager;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_PASSENGER_CARRYING_SIMULATOR_H_
