#ifndef _RSS_EGO_VEHICLE_DATA_GENERATOR_H_
#define _RSS_EGO_VEHICLE_DATA_GENERATOR_H_

#include <mutex>
#include <ros/ros.h>
#include <string>
#include <itri_msgs/CarState.h>
#include <itri_msgs/VehicleState.h>
#include <itri_msgs/Path.h>
#include <itri_msgs/speed_cmd.h>
#include <itri_msgs/steer_cmd.h>
#include <rss_msgs/EgoVehicleData.h>
#include <math_type.h>
#include <motion_waypoint_evaluator.h>
#include <actor_ego_vehicle_state_estimator.h>

namespace rss {

class EgoVehicleDataGenerator final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}
    static constexpr double DefaultForwardLookingDistance()
    {return double{50.0};}

public:

    EgoVehicleDataGenerator(
        const double forwardLookingDistance = DefaultForwardLookingDistance());
    EgoVehicleDataGenerator(const EgoVehicleDataGenerator &) = delete;
    EgoVehicleDataGenerator &operator=(const EgoVehicleDataGenerator &) = delete;
    virtual ~EgoVehicleDataGenerator() = default;

    void SetForwardLookingDistance(const double forwardLookingDistance);
    void Configure(
        const std::string &egoVehicleId,
        const geometry_msgs::Vector3 &eogeVehicleSize);
    rss_msgs::EgoVehicleData &ComputeRssEgoVehicleData();
    bool IsReady() const;

protected:

private:

    void CarStateCallback(const itri_msgs::CarState &msg);
    void VehicleStateCallback(const itri_msgs::VehicleState &msg);
    void GlobalPathCallback(const itri_msgs::Path &msg);
    void SpeedCmdCallback(const itri_msgs::speed_cmd &msg);
    void SteerCmdCallback(const itri_msgs::steer_cmd &msg);
    void ComputeRssEgoVehicleData(
        const itri_msgs::CarState &carState,
        const itri_msgs::VehicleState &vehicleState,
        const geometry_msgs::Point &forwardLookingTarget,
        rss_msgs::EgoVehicleData &outputEgoVehicleData);
    void ToWorldCoord(
        const geometry_msgs::Pose &worldPose,
        const double longitudinalValue,
        geometry_msgs::Vector3 &outputWorldVector);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mCarStateSubscriber;
    ros::Subscriber mVehicleStateSubscriber;
    ros::Subscriber mGlobalPathSubscriber;
    ros::Subscriber mSpeedCmdSubscriber;
    ros::Subscriber mSteerCmdSubscriber;
    std::mutex mCarStateMutex;
    std::mutex mVehicleStateMutex;
    std::mutex mGlobalPathMutex;
    std::mutex mSpeedCmdMutex;
    std::mutex mSteerCmdMutex;
    std::string mEgoVehicleId;
    geometry_msgs::Vector3 mEgoVehicleSize;
    itri_msgs::CarState mCarState;
    itri_msgs::VehicleState mVehicleState;
    itri_msgs::speed_cmd mSpeedCmd;
    itri_msgs::steer_cmd mSteerCmd;
    double mAccelerationCmd;
    ros::Time mPreviousSpeedCmdStamp;
    math::real_t mForwardLookingDistance;
    rss_msgs::EgoVehicleData mCurrentEgoVehicleData;
    motion::WaypointEvaluator mWaypointEvaluator;
    actor::EgoVehicleStateEstimator mEgoVehicleStateEstimator;
    bool mIsCarStateReady;
    bool mIsVehicleStateReady;
    bool mIsGlobalPathReady;
};

} // namespace rss {

#endif // #ifndef _RSS_EGO_VEHICLE_DATA_GENERATOR_H_
