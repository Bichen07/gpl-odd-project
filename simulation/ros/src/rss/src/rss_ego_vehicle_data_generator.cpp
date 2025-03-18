#include <rss_ego_vehicle_data_generator.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <utils_geometry_msgs.h>

namespace rss {

// public func.

EgoVehicleDataGenerator::EgoVehicleDataGenerator(
    const double forwardLookingDistance)
    : mNodeHandle{}
    , mCarStateSubscriber{}
    , mVehicleStateSubscriber{}
    , mGlobalPathSubscriber{}
    , mSpeedCmdSubscriber{}
    , mSteerCmdSubscriber{}
    , mCarStateMutex{}
    , mVehicleStateMutex{}
    , mGlobalPathMutex{}
    , mSpeedCmdMutex{}
    , mSteerCmdMutex{}
    , mAccelerationCmd{0.0}
    , mPreviousSpeedCmdStamp{}
    , mEgoVehicleId{}
    , mEgoVehicleSize{utils::GetZeroGeometryMsgsVector3()}
    , mCarState{}
    , mVehicleState{}
    , mSpeedCmd{}
    , mSteerCmd{}
    , mForwardLookingDistance{forwardLookingDistance}
    , mCurrentEgoVehicleData{}
    , mWaypointEvaluator{}
    , mEgoVehicleStateEstimator{}
    , mIsCarStateReady{false}
    , mIsVehicleStateReady{false}
    , mIsGlobalPathReady{false}
{
    mCarStateSubscriber = mNodeHandle.subscribe(
        "car_state",
        DefaultQueueSize(),
        &EgoVehicleDataGenerator::CarStateCallback,
        this);
    mVehicleStateSubscriber = mNodeHandle.subscribe(
        "vehicle_state",
        DefaultQueueSize(),
        &EgoVehicleDataGenerator::VehicleStateCallback,
        this);
    mGlobalPathSubscriber = mNodeHandle.subscribe(
        "global_path",
        DefaultQueueSize(),
        &EgoVehicleDataGenerator::GlobalPathCallback,
        this);
    mSpeedCmdSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        DefaultQueueSize(),
        &EgoVehicleDataGenerator::SpeedCmdCallback,
        this);
    mSteerCmdSubscriber = mNodeHandle.subscribe(
        "steer_cmd",
        DefaultQueueSize(),
        &EgoVehicleDataGenerator::SteerCmdCallback,
        this);
}

void EgoVehicleDataGenerator::SetForwardLookingDistance(const double forwardLookingDistance)
{
    mForwardLookingDistance = forwardLookingDistance;
}

void EgoVehicleDataGenerator::Configure(
    const std::string &egoVehicleId,
    const geometry_msgs::Vector3 &egoVehicleSize)
{
    mEgoVehicleId = egoVehicleId;
    mEgoVehicleSize = egoVehicleSize;
}

rss_msgs::EgoVehicleData &EgoVehicleDataGenerator::ComputeRssEgoVehicleData()
{
    std::lock_guard<std::mutex> carStateGuard(mCarStateMutex);
    std::lock_guard<std::mutex> vehicleStateGuard(mVehicleStateMutex);
    std::lock_guard<std::mutex> globalPathGuard(mGlobalPathMutex);
    std::lock_guard<std::mutex> speedCmdGuard(mSpeedCmdMutex);
    std::lock_guard<std::mutex> steerCmdGuard(mSteerCmdMutex);

    if (mEgoVehicleId.empty())
    {
        ROS_ERROR_STREAM("mEgoVehicleId is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (utils::IsApproxZero(mEgoVehicleSize))
    {
        ROS_ERROR_STREAM("mEogVehicleSize is zero: " << mEgoVehicleSize);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const math::Vector3d_t forwardLookingTarget{
        mWaypointEvaluator.ComputeForwardLookingTarget(
            utils::ConvertToVector3d(mCarState.pose.pose.position),
            mForwardLookingDistance)};
    this->ComputeRssEgoVehicleData(
        mCarState,
        mVehicleState,
        utils::ConvertToGeometryMsgsPoint(forwardLookingTarget),
        mCurrentEgoVehicleData);
    return mCurrentEgoVehicleData;
}

bool EgoVehicleDataGenerator::IsReady() const
{
    return mIsCarStateReady && mIsVehicleStateReady && mIsGlobalPathReady;
}

// protected func.

// private func.

void EgoVehicleDataGenerator::CarStateCallback(const itri_msgs::CarState &msg)
{
    std::lock_guard<std::mutex> guard(mCarStateMutex);
    mCarState = msg;
    mIsCarStateReady = true;
}

void EgoVehicleDataGenerator::VehicleStateCallback(const itri_msgs::VehicleState &msg)
{
    std::lock_guard<std::mutex> guard(mVehicleStateMutex);
    mVehicleState = msg;
    mIsVehicleStateReady = true;
}

void EgoVehicleDataGenerator::GlobalPathCallback(const itri_msgs::Path &msg)
{
    std::lock_guard<std::mutex> guard(mGlobalPathMutex);
    std::vector<math::Vector3d_t> waypoints(msg.waypoints.size());
    auto waypoint{waypoints.begin()};
    auto routeWaypoint{msg.waypoints.cbegin()};
    for (; routeWaypoint != msg.waypoints.cend();
         ++routeWaypoint, ++waypoint)
    {
        *waypoint = utils::ConvertToVector3d(routeWaypoint->point);
    }
    mWaypointEvaluator.Configure(waypoints);
    mIsGlobalPathReady = true;
}

void EgoVehicleDataGenerator::SpeedCmdCallback(const itri_msgs::speed_cmd &msg)
{
    std::lock_guard<std::mutex> guard(mSpeedCmdMutex);

    double period =
        msg.header.stamp.toSec() -
        mPreviousSpeedCmdStamp.toSec();
    if (math::IsLessThanOrApprox(period, double{0.0}, double{1.0e-6}))
    {
        const auto currentStamp = ros::Time::now();
        period = currentStamp.toSec() - mPreviousSpeedCmdStamp.toSec();
        ROS_DEBUG_STREAM_COND(
            false,
            "small time period: " << period << '\n' <<
            "current sec: " << msg.header.stamp.toSec() << '\n' <<
            "previous sec: " << mPreviousSpeedCmdStamp.toSec() << '\n' <<
            "modified period: " << period);
        mAccelerationCmd = static_cast<double>(msg.kph - mSpeedCmd.kph) / period;
        mSpeedCmd = msg;
        mSpeedCmd.header.stamp = currentStamp;
        mPreviousSpeedCmdStamp = currentStamp;
    }
    else
    {
        mAccelerationCmd = static_cast<double>(msg.kph - mSpeedCmd.kph) / period;

        mSpeedCmd = msg;
        mPreviousSpeedCmdStamp = msg.header.stamp;
    }

    ROS_DEBUG_STREAM_COND(
        false,
        "acceleartion cmd: " << mAccelerationCmd);
}

void EgoVehicleDataGenerator::SteerCmdCallback(const itri_msgs::steer_cmd &msg)
{
    std::lock_guard<std::mutex> guard(mSteerCmdMutex);
    mSteerCmd = msg;
}

void EgoVehicleDataGenerator::ComputeRssEgoVehicleData(
    const itri_msgs::CarState &carState,
    const itri_msgs::VehicleState &vehicleState,
    const geometry_msgs::Point &forwardLookingTarget,
    rss_msgs::EgoVehicleData &outputEgoVehicleData)
{
    outputEgoVehicleData.id = mEgoVehicleId;
    outputEgoVehicleData.pose.position = carState.pose.pose.position;
    outputEgoVehicleData.pose.orientation = utils::ConvertToGeometryMsgsQuaternion(
        math::Quaternion_t(
            math::AngleAxis_t(
                carState.pose.pose.orientation.z,
                math::Vector3d_t::UnitZ())));

    this->ToWorldCoord(
        outputEgoVehicleData.pose,
        carState.twist.twist.linear.x,
        outputEgoVehicleData.twist.linear);
    outputEgoVehicleData.twist.angular.x = double{0.0};
    outputEgoVehicleData.twist.angular.y = double{0.0};
    outputEgoVehicleData.twist.angular.z = carState.twist.twist.angular.z;
    outputEgoVehicleData.accel.linear = utils::ConvertToGeometryMsgsVector3(
        mEgoVehicleStateEstimator.GetLinearAcceleration());
    outputEgoVehicleData.accel.angular = utils::ConvertToGeometryMsgsVector3(
        mEgoVehicleStateEstimator.GetAngularAcceleration());
    // TODO Add linear acceleartion
    outputEgoVehicleData.size = mEgoVehicleSize;
    outputEgoVehicleData.target = forwardLookingTarget;
    outputEgoVehicleData.speed = utils::ComputeNorm(
        outputEgoVehicleData.twist.linear);
    outputEgoVehicleData.yaw_rate = outputEgoVehicleData.twist.angular.z;
    outputEgoVehicleData.steering_angle =
        math::Clamp(
            vehicleState.steering_angle / 19.6,
            math::real_t{-6.28},
            math::real_t{6.28});
    outputEgoVehicleData.speed_cmd_kph = mSpeedCmd.kph;
    outputEgoVehicleData.steer_cmd_angle = mSteerCmd.angle;
    outputEgoVehicleData.acceleration_cmd = static_cast<float>(mAccelerationCmd);
}

void EgoVehicleDataGenerator::ToWorldCoord(
    const geometry_msgs::Pose &worldPose,
    const double longitudinalValue,
    geometry_msgs::Vector3 &outputWorldVector)
{
    const math::RotMat3d_t worldRotmat =
        utils::ConvertToQuaternion(worldPose.orientation).toRotationMatrix();
    const math::Vector3d_t localVector{
        math::Vector3d_t(longitudinalValue, math::real_t{0.0}, math::real_t{0.0})};
    const math::Vector3d_t worldVector = worldRotmat * localVector;
    outputWorldVector = utils::ConvertToGeometryMsgsVector3(worldVector);
}
 
} // namespace rss {
