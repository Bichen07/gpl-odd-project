#include <actor_ego_vehicle_observer.h>
#include <ros/console.h>
#include <math_utils.h>
#include <geometry_utils.h>
#include <motion_utils.h>
#include <utils_converter.h>
#include <ros/param.h>

namespace actor {

// public func.

EgoVehicleObserver::EgoVehicleObserver()
    : mNodeHandle{}
    , mCarStateSubscriber{}
    , mSteerCmdSubscriber{}
    , mImuSubscriber{}
    , mEgoVehicleSize{}
    , mCompensatedSecond{0.0}
    , mStaticLongitudinalCompensatedDistance{0.0}
    , mState{}
    , mTransform3d{}
    , mTransform2d{}
    , mLastTwist{}
    , mSteeringAngle{0.0}
    , mWorldBoundingRect3d{}
    , mWorldBoundingRect2d{}
    , mWorldBoundingBox3d{}
    , mUseCarla{false}
    , mRunVil{false}
{
    std::string roleName;
    if(!ros::param::get("carla/actual_role_name", roleName))
    {
        ROS_WARN_STREAM(
            "[EgoVehicleObserver] Can\'t find rosparam carla/actual_role_name, " <<
            "use ego_vehicle instead.");
        roleName = "ego_vehicle";
    }
    else
    {
        ROS_INFO_STREAM("[EgoVehicleObserver] role_name: " << roleName);
    }
    ros::param::param<bool>("simulation/using_carla", mUseCarla, false);
    ros::param::param<bool>("simulation/running_vil", mRunVil, false);
    mCarStateSubscriber = mNodeHandle.subscribe(
        "car_state",
        DefaultQueueSize(),
        &EgoVehicleObserver::CarStateCallback,
        this);
    mSteerCmdSubscriber = mNodeHandle.subscribe(
        "steer_cmd",
        DefaultQueueSize(),
        &EgoVehicleObserver::SteerCmdCallback,
        this);

    if (!mUseCarla && mRunVil)
    {
        mImuSubscriber = mNodeHandle.subscribe(
            "imu/data",
            DefaultQueueSize(),
            &EgoVehicleObserver::ImuCallback,
            this);    
    }
    else
    {
        mImuSubscriber = mNodeHandle.subscribe(
            "carla/" + roleName + "/imu",
            DefaultQueueSize(),
            &EgoVehicleObserver::ImuCallback,
            this);
    }

    // Default ego size
    const math::Vector3d_t egoVehicleSize(5.172, 2.297, 1.777);
    mEgoVehicleSize = egoVehicleSize;

}

EgoVehicleObserver::~EgoVehicleObserver()
{
}

const math::Vector3d_t &EgoVehicleObserver::GetSize() const
{
    return mEgoVehicleSize;
}

const motion::State &EgoVehicleObserver::GetState() const
{
    return mState;
}

const math::HomoXfm3d_t &EgoVehicleObserver::GetTransform3d() const
{
    return mTransform3d;
}

const math::HomoXfm2d_t &EgoVehicleObserver::GetTransform2d() const
{
    return mTransform2d;
}

const geometry::Rect3d &EgoVehicleObserver::GetWorldBoundingRect3d() const
{
    return mWorldBoundingRect3d;
}

const geometry::Rect2d &EgoVehicleObserver::GetWorldBoundingRect2d() const
{
    return mWorldBoundingRect2d;
}

const geometry::Box3d &EgoVehicleObserver::GetWorldBoundingBox3d() const
{
    return mWorldBoundingBox3d;
}

math::real_t EgoVehicleObserver::GetSteeringAngle() const
{
    return mSteeringAngle;
}

void EgoVehicleObserver::Configure(
    const math::Vector3d_t &egoVehicleSize,
    const math::real_t compensatedSecond,
    const math::real_t staticLongitudinalCompensatedDistance)
{
    if (!this->IsValidSize(egoVehicleSize))
    {
        return;
    }

    mEgoVehicleSize = egoVehicleSize;
    mCompensatedSecond = compensatedSecond;
    mStaticLongitudinalCompensatedDistance = staticLongitudinalCompensatedDistance;
}

geometry::Rect2d EgoVehicleObserver::CompouteWorldBoundingRect3dWithSpareSpaceForAgent(
    const math::Vector3d_t &agentSize)
{
    const math::real_t longitudinalCompensatedDistance =
        mCompensatedSecond * mLastTwist.linear.x +
        mStaticLongitudinalCompensatedDistance;
    auto worldBoundRect3d = ComputeWorldBoundingRect3d(
        mTransform3d,
        mEgoVehicleSize + agentSize,
        longitudinalCompensatedDistance);
    return geometry::ConvertToRect2d(worldBoundRect3d);
}

// protected func.

// private func.

geometry::Rect3d EgoVehicleObserver::ComputeWorldBoundingRect3d(
    const math::HomoXfm3d_t &localToWorldTransform,
    const math::Vector3d_t &size,
    const math::real_t longitudinalCompensatedDistance) const
{
    geometry::Rect3d worldBoundingRect3d;
    const math::Vector3d_t topLeftLocalOffset(
        0.5 * size.x() + longitudinalCompensatedDistance,
        0.5 * size.y(),
        0.0);
    worldBoundingRect3d.topLeft = localToWorldTransform * topLeftLocalOffset;

    const math::Vector3d_t topRightLocalOffset(
        0.5 * size.x() + longitudinalCompensatedDistance,
        -0.5 * size.y(),
        0.0);
    worldBoundingRect3d.topRight = localToWorldTransform * topRightLocalOffset;

    const math::Vector3d_t bottomLeftOffset(
        -0.5 * size.x() + longitudinalCompensatedDistance,
        0.5 * size.y(),
        0.0);
    worldBoundingRect3d.bottomLeft = localToWorldTransform * bottomLeftOffset;

    const math::Vector3d_t bottomRightOffset(
        -0.5 * size.x() + longitudinalCompensatedDistance,
        -0.5 * size.y(),
        0.0);
    worldBoundingRect3d.bottomRight = localToWorldTransform * bottomRightOffset;

    return worldBoundingRect3d;
}

geometry::Box3d EgoVehicleObserver::ComputeWorldBoundingBox3d(
    const math::HomoXfm3d_t &localToWorldTransform,
    const math::Vector3d_t &size) const
{
    // this->GetTransform3d() returns the bottom of the ego-vehicle's position
    const math::Vector3d_t minCornerOffset(-0.5 * size.x(), -0.5 * size.y(), 0.0);
    const auto minCorner = localToWorldTransform * minCornerOffset;
    const math::Vector3d_t maxCornerOffset(0.5 * size.x(), 0.5 * size.y(), size.z());
    const auto maxCorner = localToWorldTransform * maxCornerOffset;

    return geometry::Box3d(minCorner, maxCorner);
}

bool EgoVehicleObserver::IsValidSize(const math::Vector3d_t &size) const
{
    if (size.x() < 1.0e-2)
    {
        ROS_ERROR_STREAM("invalid size x: " << size.x());
        return false;
    }

    if (size.y() < 1.0e-2)
    {
        ROS_ERROR_STREAM("invalid size y: " << size.y());
        return false;
    }

    if (size.z() < 1.0e-2)
    {
        ROS_ERROR_STREAM("invalid size z: " << size.z());
        return false;
    }

    return true;
}

void EgoVehicleObserver::CarStateCallback(const itri_msgs::CarState &msg)
{
    const math::Vector3d_t position(
        msg.pose.pose.position.x,
        msg.pose.pose.position.y,
        msg.pose.pose.position.z);
    const math::Quaternion_t orientation{
        math::Quaternion_t(
            math::AngleAxis_t(msg.pose.pose.orientation.z, math::Vector3d_t::UnitZ()))};

    const math::Vector3d_t linearVelocity(
        msg.twist.twist.linear.x,
        math::real_t{0.0},
        math::real_t{0.0});
    const math::Vector3d_t angularVelocity(
        math::real_t{0.0},
        math::real_t{0.0},
        msg.twist.twist.angular.z);

    mState.position = position;
    mState.orientation = orientation;
    mState.linearVelocity =
        orientation.toRotationMatrix() *
        linearVelocity;
    mState.angularVelocity = angularVelocity;

    const math::real_t longitudinalCompensatedDistance =
        mCompensatedSecond * msg.twist.twist.linear.x +
        mStaticLongitudinalCompensatedDistance;
    mTransform3d = math::HomoXfm3d_t(
        orientation.toRotationMatrix(),
        position);
    mTransform2d = motion::ComputeTransform2d(mState);
    mWorldBoundingRect3d = this->ComputeWorldBoundingRect3d(
        mTransform3d,
        mEgoVehicleSize,
        longitudinalCompensatedDistance);

    mWorldBoundingRect2d = geometry::ConvertToRect2d(mWorldBoundingRect3d);

    mWorldBoundingBox3d = this->ComputeWorldBoundingBox3d(
        mTransform3d,
        mEgoVehicleSize);

    mLastTwist = msg.twist.twist;
}

void EgoVehicleObserver::SteerCmdCallback(const itri_msgs::steer_cmd &msg)
{
    mSteeringAngle = msg.angle / double{19.6};
}

void EgoVehicleObserver::ImuCallback(const sensor_msgs::Imu &msg)
{
    mState.longitudinalAcceleration = msg.linear_acceleration.x;
    mState.lateralAcceleration = msg.linear_acceleration.y;
}

} // namespace actor {
