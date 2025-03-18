#include <carla_feedback_estimator.h>
#include <math_utils.h>
#include <utils_converter.h>

namespace carla {

// public func.

FeedbackEstimator::FeedbackEstimator()
    : mNodeHandle{}
    , mCarlaCarStateSubscriber{}

    , mMutex{}
    , mEgoVehicleName{"ego_vehicle"}
    , mState2d{}

    , mTopicManager{}
{

    if(!ros::param::get("carla/actual_role_name", mEgoVehicleName))
    {
        ROS_WARN_STREAM(
            "[carla_feedback_estimator] Can\'t find rosparam carla/actual_role_name, " 
            << "use ego_vehicle instead.");
    }
    else
    {
        ROS_INFO_STREAM("[carla_feedback_estimator] role_name: " 
            << mEgoVehicleName);
    }
    mCarlaCarStateSubscriber = mNodeHandle.subscribe(
        mTopicManager.Generate(TopicPrefix::Carla, mEgoVehicleName, Topic::CarState),
        DefaultQueueSize(),
        &FeedbackEstimator::CarlaCarStateCallback,
        this);
}

FeedbackEstimator::~FeedbackEstimator()
{
}

const State2d &FeedbackEstimator::GetState2d() const
{
    return mState2d;
}

// protected func.

// private func.

void FeedbackEstimator::CarlaCarStateCallback(const itri_msgs::CarState &msg)
{
    std::lock_guard<std::mutex> lockGuard(mMutex);

    const math::Vector3d_t position3d = utils::ConvertToVector3d(msg.pose.pose.position);
    const math::Vector3d_t eulerAngleXyz = math::ToEulerAngleXyz(
        utils::ConvertToQuaternion(msg.pose.pose.orientation).toRotationMatrix());
    const math::Vector3d_t linearVelocity = utils::ConvertToVector3d(msg.twist.twist.linear);
    const math::Vector3d_t angularVelocity = utils::ConvertToVector3d(msg.twist.twist.angular);

    mState2d.position = math::Vector2d_t(position3d.x(), position3d.y());
    mState2d.orientation = math::ComputePrincipalAngle(eulerAngleXyz.z());
    mState2d.velocity = math::Vector2d_t(linearVelocity.x(), linearVelocity.y());
    mState2d.yawRate = angularVelocity.z();
}

} // namespace carla {
