#include <carla_ego_vehicle_controller.h>
#include <math_utils.h>
#include <motion_utils.h>

namespace carla {

// public func.

EgoVehicleController::EgoVehicleController()
    : mNodeHandle{}
    , mSpeedCmdSubscriber{}
    , mSteerCmdSubscriber{}

    , mEgoControlCmdPublisher{}
    , mAckermannDrivePublisher{}

    , mMutex{}
    , mEgoVehicleName{"ego_vehicle"}
    , mAckermannDrive{}
    , mCarlaEgoVehicleControl{}
    , mTopicManager{}
    , mPreviousSpeed{0.0}
    , mPreviousAcceleration{0.0}
    , mPreviousTimeSec{0.0}
{
    mSpeedCmdSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        DefaultQueueSize(),
        &EgoVehicleController::SpeedCmdCallback,
        this);
    mSteerCmdSubscriber = mNodeHandle.subscribe(
        "steer_cmd",
        DefaultQueueSize(),
        &EgoVehicleController::SteerCmdCallback,
        this);

    mAckermannDrivePublisher = mNodeHandle.advertise<ackermann_msgs::AckermannDrive>(
        mTopicManager.Generate(TopicPrefix::Carla, mEgoVehicleName, Topic::AckermannCmd),
        DefaultQueueSize());

    std::string roleName;
    if (!ros::param::get("carla/actual_role_name", roleName))
    {
        roleName = "ego_vehicle";
    }

    mEgoControlCmdPublisher = mNodeHandle.advertise<carla_msgs::CarlaEgoVehicleControl>(
        "carla/" + roleName + "/vehicle_control_cmd",
        DefaultQueueSize());

}

void EgoVehicleController::PublishEgoControlCommand()
{
    carla_msgs::CarlaEgoVehicleControl control_msgs;
    control_msgs.header.stamp = ros::Time::now();

    control_msgs.throttle = 0.5f;
    control_msgs.steer = 0.5f;
    control_msgs.brake = 0.0f;
    control_msgs.hand_brake = false;
    control_msgs.reverse = false;
    control_msgs.gear = 0;
    control_msgs.manual_gear_shift = false;

    mEgoControlCmdPublisher.publish(control_msgs);
    //ROS_INFO_STREAM(control_msgs);
}

void EgoVehicleController::PublishAckermannDriveCommand()
{
    std::lock_guard<std::mutex> lockGuard(mMutex);
    mAckermannDrivePublisher.publish(mAckermannDrive);
    //ROS_INFO_STREAM("PublishCommand");
    //ROS_INFO_STREAM(mAckermannDrive);
}

// protected func.

// private func.

void EgoVehicleController::SpeedCmdCallback(const itri_msgs::speed_cmd &msg)
{
    std::lock_guard<std::mutex> lockGuard(mMutex);

    static constexpr bool canShowTimeStep{false};
    const math::real_t timeNow = ros::Time::now().toSec();
    const math::real_t timeStep = timeNow - mPreviousTimeSec;
    mPreviousTimeSec = timeNow;
    if (canShowTimeStep)
    {
        ROS_ERROR_STREAM("[scenario] invalid timeStep: " << timeStep);
    }

    mAckermannDrive.speed = static_cast<float>(motion::ConvertToMps(msg.kph));
    const math::real_t speedDifference =
        static_cast<math::real_t>(mAckermannDrive.speed) -
        mPreviousSpeed;
    mAckermannDrive.acceleration = speedDifference / timeStep;
    mPreviousSpeed = static_cast<math::real_t>(mAckermannDrive.speed);

    const math::real_t accelerationDifference =
        static_cast<math::real_t>(mAckermannDrive.acceleration) -
        mPreviousAcceleration;
    mAckermannDrive.jerk = accelerationDifference / timeStep;
    mPreviousAcceleration = static_cast<math::real_t>(mAckermannDrive.acceleration);
//
//    ROS_INFO_STREAM('\n' <<
//        "speed: " << mAckermannDrive.speed << '\n' <<
//        "accleration: " << mAckermannDrive.acceleration << '\n' <<
//        "jerk: " << mAckermannDrive.jerk);
}

void EgoVehicleController::SteerCmdCallback(const itri_msgs::steer_cmd &msg)
{
    std::lock_guard<std::mutex> lockGuard(mMutex);
    mAckermannDrive.steering_angle = -math::ToRadian(msg.angle / 19.6);
    //ROS_INFO_STREAM("steer cmd: " << mAckermannDrive.steering_angle);
}

} // namespace carla {
