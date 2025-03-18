#ifndef _ACTOR_EGO_VEHICLE_STATE_ESTIMATOR_H_
#define _ACTOR_EGO_VEHICLE_STATE_ESTIMATOR_H_

#include <mutex>
#include <ros/ros.h>
#include <itri_msgs/CarState.h>
#include <math_moving_average_filter.h>
#include <motion_state.h>

namespace actor
{

    class EgoVehicleStateEstimator final
    {
    public:
        EgoVehicleStateEstimator();
        EgoVehicleStateEstimator(const EgoVehicleStateEstimator &)            = delete;
        EgoVehicleStateEstimator &operator=(const EgoVehicleStateEstimator &) = delete;
        virtual ~EgoVehicleStateEstimator()                                   = default;

        const math::Vector3d_t &GetLinearAcceleration();
        const math::Vector3d_t &GetAngularAcceleration();

    protected:
    private:
        using AccelerationFilter = math::MovingAverageFilter<math::Vector3d_t>;
        static constexpr int32_t DefaultQueueSize()
        {
            return int32_t{1};
        }

        void CarStateCallback(const itri_msgs::CarState &msg);

        ros::NodeHandle    mNodeHandle;
        ros::Subscriber    mCarStateSubscriber;
        std::mutex         mCarStateMutex;
        AccelerationFilter mLinearAccelerationFilter;
        AccelerationFilter mAngularAccelerationFilter;
        ros::Time          mPreviousCarStateStamp;
        math::Vector3d_t   mPreviousLinearVelocity;
        math::Vector3d_t   mPreviousAngularVelocity;
        math::Vector3d_t   mLinearAcceleration;
        math::Vector3d_t   mAngularAcceleration;
        motion::State      mState;
    };

}  // namespace actor

#endif  // #ifndef _ACTOR_EGO_VEHICLE_STATE_ESTIMATOR_H_
