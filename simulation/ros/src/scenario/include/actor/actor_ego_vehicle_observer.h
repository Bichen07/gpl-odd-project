#ifndef _ACTOR_EGO_VEHICLE_OBSERVER_H_
#define _ACTOR_EGO_VEHICLE_OBSERVER_H_

#include <mutex>
#include <vector>
#include <ros/ros.h>
#include <tf/tf.h>
#include <itri_msgs/CarState.h>
#include <itri_msgs/steer_cmd.h>
#include <sensor_msgs/Imu.h>
#include <geometry_type.h>
#include <geometry_box_3d.h>
#include <math_type.h>
#include <motion_state.h>
#include <geometry_msgs/Twist.h>

namespace actor {

class EgoVehicleObserver final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    EgoVehicleObserver();
    EgoVehicleObserver(const EgoVehicleObserver &) = delete;
    EgoVehicleObserver &operator=(const EgoVehicleObserver &) = delete;
    virtual ~EgoVehicleObserver();

    const math::Vector3d_t &GetSize() const;
    const motion::State &GetState() const;
    const math::HomoXfm3d_t &GetTransform3d() const;
    const math::HomoXfm2d_t &GetTransform2d() const;

    const geometry::Rect3d &GetWorldBoundingRect3d() const;
    const geometry::Rect2d &GetWorldBoundingRect2d() const;
    const geometry::Box3d &GetWorldBoundingBox3d() const;

    math::real_t GetSteeringAngle() const;

    void Configure(
        const math::Vector3d_t &egoVehicleSize,
        const math::real_t compensatedSecond,
        const math::real_t staticLongitudinalCompensatedDistance);

    geometry::Rect2d CompouteWorldBoundingRect3dWithSpareSpaceForAgent(
        const math::Vector3d_t &agentSize);

protected:

private:

    geometry::Rect3d ComputeWorldBoundingRect3d(
        const math::HomoXfm3d_t &localToWorldTransform,
        const math::Vector3d_t &size,
        const math::real_t longitudinalCompensatedDistance) const;
    geometry::Box3d ComputeWorldBoundingBox3d(
        const math::HomoXfm3d_t &localToWorldTransform,
        const math::Vector3d_t &size) const;

    bool IsValidSize(const math::Vector3d_t &size) const;
    void CarStateCallback(const itri_msgs::CarState &msg);
    void SteerCmdCallback(const itri_msgs::steer_cmd &msg);
    void ImuCallback(const sensor_msgs::Imu &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mCarStateSubscriber;
    ros::Subscriber mSteerCmdSubscriber;
    ros::Subscriber mImuSubscriber;
    math::Vector3d_t mEgoVehicleSize;
    math::real_t mCompensatedSecond;
    math::real_t mStaticLongitudinalCompensatedDistance;
    motion::State mState;
    math::HomoXfm3d_t mTransform3d;
    math::HomoXfm2d_t mTransform2d;
    math::real_t mSteeringAngle;
    geometry::Rect3d mWorldBoundingRect3d;
    geometry::Rect2d mWorldBoundingRect2d;
    geometry::Box3d mWorldBoundingBox3d;
    geometry_msgs::Twist mLastTwist;
    bool mUseCarla;
    bool mRunVil;
};

} // namespace actor {

#endif // #ifndef _ACTOR_EGO_VEHICLE_OBSERVER_H_
