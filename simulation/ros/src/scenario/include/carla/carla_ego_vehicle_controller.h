#ifndef _CARLA_EGO_VEHICLE_CONTROLLER_H_
#define _CARLA_EGO_VEHICLE_CONTROLLER_H_

#include <mutex>
#include <ros/ros.h>
#include <itri_msgs/speed_cmd.h>
#include <itri_msgs/steer_cmd.h>
#include <ackermann_msgs/AckermannDrive.h>
#include <math_type.h>
#include <carla_msgs/CarlaEgoVehicleControl.h>
#include <carla_topic_manager.h>

namespace carla {

class EgoVehicleController final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    EgoVehicleController();
    EgoVehicleController(const EgoVehicleController &) = delete;
    EgoVehicleController &operator=(const EgoVehicleController &) = delete;
    virtual ~EgoVehicleController() = default;

    void PublishEgoControlCommand();
    void PublishAckermannDriveCommand();

protected:

private:

    void SpeedCmdCallback(const itri_msgs::speed_cmd &msg);
    void SteerCmdCallback(const itri_msgs::steer_cmd &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mSpeedCmdSubscriber;
    ros::Subscriber mSteerCmdSubscriber;

    ros::Publisher mEgoControlCmdPublisher;
    ros::Publisher mAckermannDrivePublisher;

    std::mutex mMutex;
    std::string mEgoVehicleName;
    ackermann_msgs::AckermannDrive mAckermannDrive;
    carla_msgs::CarlaEgoVehicleControl mCarlaEgoVehicleControl;
    TopicManager mTopicManager;
    math::real_t mPreviousSpeed;
    math::real_t mPreviousAcceleration;
    math::real_t mPreviousTimeSec;
};

} // namespace carla {

#endif // #ifndef _CARLA_EGO_VEHICLE_CONTROLLER_H_
