#include <actor_ego_vehicle_state_estimator.h>
#include <math_utils.h>

namespace actor
{

    // public func.

    EgoVehicleStateEstimator::EgoVehicleStateEstimator()
        : mNodeHandle{},
          mCarStateSubscriber{},
          mCarStateMutex{},
          mLinearAccelerationFilter{10ul},
          mAngularAccelerationFilter{10ul},
          mPreviousCarStateStamp{},
          mPreviousLinearVelocity{},
          mPreviousAngularVelocity{},
          mLinearAcceleration{},
          mAngularAcceleration{},
          mState{}
    {
        mCarStateSubscriber = mNodeHandle.subscribe("car_state", DefaultQueueSize(), &EgoVehicleStateEstimator::CarStateCallback, this);
    }

    const math::Vector3d_t &EgoVehicleStateEstimator::GetLinearAcceleration()
    {
        std::lock_guard<std::mutex> guard(mCarStateMutex);
        return mLinearAcceleration;
    }

    const math::Vector3d_t &EgoVehicleStateEstimator::GetAngularAcceleration()
    {
        std::lock_guard<std::mutex> guard(mCarStateMutex);
        return mAngularAcceleration;
    }

    // protected func.

    // private func.

    void EgoVehicleStateEstimator::CarStateCallback(const itri_msgs::CarState &msg)
    {
        std::lock_guard<std::mutex> guard(mCarStateMutex);
        const math::Vector3d_t      position(msg.pose.pose.position.x, msg.pose.pose.position.y, msg.pose.pose.position.z);
        const math::Quaternion_t    orientation{math::Quaternion_t(math::AngleAxis_t(msg.pose.pose.orientation.z, math::Vector3d_t::UnitZ()))};
        const math::Vector3d_t      localLinearVelocity(msg.twist.twist.linear.x, math::real_t{0.0}, math::real_t{0.0});
        const math::Vector3d_t      angularVelocity(math::real_t{0.0}, math::real_t{0.0}, msg.twist.twist.angular.z);
        mState.position        = position;
        mState.orientation     = orientation;
        mState.linearVelocity  = orientation.toRotationMatrix() * localLinearVelocity;
        mState.angularVelocity = angularVelocity;

        const double period = msg.header.stamp.toSec() - mPreviousCarStateStamp.toSec();
        if (math::IsLessThanOrApprox(period, double{0.0}, double{1.0e-6}))
        {
            ROS_WARN_STREAM("small time period: " << period);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        const math::Vector3d_t currentLinearAcceleartion  = (mState.linearVelocity - mPreviousLinearVelocity) / period;
        const math::Vector3d_t currentAngularAcceleration = (mState.angularVelocity - mPreviousAngularVelocity) / period;

        mLinearAccelerationFilter.Push(currentLinearAcceleartion);
        mAngularAccelerationFilter.Push(currentAngularAcceleration);
        mLinearAcceleration  = mLinearAccelerationFilter.ComputeAverage();
        mAngularAcceleration = mAngularAccelerationFilter.ComputeAverage();

        mPreviousCarStateStamp   = msg.header.stamp;
        mPreviousLinearVelocity  = mState.linearVelocity;
        mPreviousAngularVelocity = mState.angularVelocity;
    }

}  // namespace actor
