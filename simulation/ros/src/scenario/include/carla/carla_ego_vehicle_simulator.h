#ifndef _CARLA_MANUAL_CONTROL_SIMULATOR_H_
#define _CARLA_MANUAL_CONTROL_SIMULATOR_H_

#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Pose.h>
#include <logger_txt_writer.h>
#include <actor_ego_vehicle_observer.h>
#include <carla_msgs/CarlaEgoVehicleStatus.h>
#include <carla_ego_vehicle_controller.h>
#include <carla_topic_manager.h>

namespace carla {

class EgoVehicleSimulator final
{

    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    EgoVehicleSimulator();
    EgoVehicleSimulator(const EgoVehicleSimulator &) = delete;
    EgoVehicleSimulator &operator=(const EgoVehicleSimulator &) = delete;
    virtual ~EgoVehicleSimulator() = default;

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver);
    void Update();

protected:

private:

    void EgoVehicleStatusCallback(const carla_msgs::CarlaEgoVehicleStatus &msg);
    void EgoVehiclePoseCallback(const geometry_msgs::Pose &msg);
    void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mCarlaVehicleStatusSubscriber;
    ros::Subscriber mCarlaVehiclePoseSubscriber;
    ros::Subscriber mNavigationPathReadinessSubscriber;

    ros::Publisher mVehiclePosePublisher;

    std::string mEgoVehicleName;
    EgoVehicleController mEgoVehicleController;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    TopicManager mTopicManager;

    bool mIsNavigationPathReady;
};

} // namespace carla {

#endif // #ifndef _CARLA_MANUAL_CONTROL_SIMULATOR_H_
