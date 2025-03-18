#include <carla_ego_vehicle_simulator.h>
#include <ros/console.h>
#include <utils_converter.h>


//#define _LOG_KINEMATIC_POSITION_

namespace carla {

// public func.

EgoVehicleSimulator::EgoVehicleSimulator()
    : mNodeHandle{}
    , mCarlaVehicleStatusSubscriber{}
    , mCarlaVehiclePoseSubscriber{}
    , mNavigationPathReadinessSubscriber{}

    , mVehiclePosePublisher{}

    , mEgoVehicleName{"ego_vehicle"}
    , mEgoVehicleController{}
    , mEgoVehicleObserver(nullptr)
    , mTopicManager{}

    , mIsNavigationPathReady{false}
{

    if (!ros::param::get("carla/actual_role_name", mEgoVehicleName))
    {
        mEgoVehicleName = "ego_vehicle";
    }
    mCarlaVehicleStatusSubscriber = mNodeHandle.subscribe(
        mTopicManager.Generate(TopicPrefix::Carla, mEgoVehicleName, Topic::VehicleStatus),
        DefaultQueueSize(),
        &EgoVehicleSimulator::EgoVehicleStatusCallback,
        this);
    mCarlaVehiclePoseSubscriber = mNodeHandle.subscribe(
        mTopicManager.Generate(TopicPrefix::Carla, mEgoVehicleName, Topic::VehiclePose),
        DefaultQueueSize(),
        &EgoVehicleSimulator::EgoVehiclePoseCallback,
        this);
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        DefaultQueueSize(),
        &EgoVehicleSimulator::NavigationPathReadinessCallback,
        this);

    mVehiclePosePublisher = mNodeHandle.advertise<geometry_msgs::Pose>(
        mTopicManager.Generate(TopicPrefix::Mmsl, mEgoVehicleName, Topic::VehiclePose),
        DefaultQueueSize());
}

void EgoVehicleSimulator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver)
{
    mEgoVehicleObserver = egoVehicleObserver;
}

void EgoVehicleSimulator::Update()
{
    if (!mIsNavigationPathReady)
    {
        return;
    }

    const auto carlaPose = utils::ConvertToGeometryMsgsPose(
        mEgoVehicleObserver->GetTransform3d());
    mVehiclePosePublisher.publish(carlaPose);

#ifdef _LOG_KINEMATIC_POSITION_
    mTxtWriter.Append(mEgoVehicleObserver->GetTransform3d().translation());
#endif // #ifdef _LOG_KINEMATIC_POSITION_

    //mEgoVehicleController.PublishEgoControlCommand();
    mEgoVehicleController.PublishAckermannDriveCommand();
}

// protected func.

// private func.

void EgoVehicleSimulator::EgoVehicleStatusCallback(const carla_msgs::CarlaEgoVehicleStatus &msg)
{
    //ROS_INFO_STREAM(msg);
}

void EgoVehicleSimulator::EgoVehiclePoseCallback(const geometry_msgs::Pose &msg)
{
    ROS_INFO_STREAM("position: " << msg.position);
}

void EgoVehicleSimulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    ROS_INFO_STREAM("NavigationPathReadinessCallback");
    mIsNavigationPathReady = true;
}

} // namespace carla {
