#ifndef _SCENARIO_DETECTED_OBJECT_MSG_GENERATOR_H_
#define _SCENARIO_DETECTED_OBJECT_MSG_GENERATOR_H_

#include <vector>
#include <functional>
#include <tf/tf.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <utils_transform_listener.h>
#include <math_type.h>
#include <geometry_vector_3d.h>
#include <geometry_quaternion.h>
#include <actor_vehicle.h>
#include <scenario_type.h>
#include <sensor_lidar_detected_object.h>
#include <scenario_detected_object_coord.h>
#include <scenario_detected_agent_data.h>
#include <scenario_detected_object_id_manager.h>

namespace scenario {

class DetectedObjectMsgGenerator final
{
    static constexpr const char *MapId()
    {return "map";}

public:

    DetectedObjectMsgGenerator();
    DetectedObjectMsgGenerator(const DetectedObjectMsgGenerator &) = delete;
    DetectedObjectMsgGenerator &operator=(const DetectedObjectMsgGenerator &) = delete;
    virtual ~DetectedObjectMsgGenerator() = default;

    void Configure(
        const DetectedObjectIdManager::Ptr &detectedObjectIdManager,
        const math::HomoXfm3d_t &initBaseLinkToMapXfm);

    void ComputeMsg(
        const std::vector<actor::Agent::Ptr> &agents,
        const std::vector<sensor::LidarDetectedObject::Ptr> &lidarDetectedObjects,
        const ros::Time &stamp,
        const DetectedObjectCoord &coord,
        itri_msgs::DetectedObjectArray &outputMsg);
    void Compute(
        const std::vector<std::shared_ptr<actor::Agent>> &agents,
        const std::vector<std::shared_ptr<sensor::LidarDetectedObject>> &lidarDetectedObjects,
        const Coord &coord,
        itri_msgs::DetectedObjectArray &detectedObjectArray);
    void ComputeMsg(
        const std::vector<DetectedAgentData> &detectedAgentDatas,
        const ros::Time &stamp,
        const Coord &coord,
        const int32_t detectedObjectIdOffset,
        itri_msgs::DetectedObjectArray *msg);

protected:

private:

    using RosTimeFunc = std::function<ros::Time ()>;

    std::string EvaluateFrameId(const DetectedObjectCoord &coord) const;
    std::string EvaluateFrameId(const Coord &coord) const;
    void ComputeDetectedObjectMsg(
        const actor::Attribute &attribute,
        const motion::State &state,
        const ros::Time &stamp,
        const DetectedObjectCoord &coord,
        const tf::StampedTransform &baselinkToMapTransform,
        const int32_t detectedObjectId,
        itri_msgs::DetectedObject &outputMsg) const;
    void ComputeWorldCoordCubePolygon(
        const geometry::Vector3d &position,
        const geometry::Quaternion &orientation,
        const geometry::Vector3d &size,
        geometry_msgs::Polygon &outputPolygon) const;

    void ComputeLocalCoordDetectedAgent(
        const actor::Attribute &attribute,
        const motion::State &state,
        const ros::Time &stamp,
        const tf::StampedTransform &baselinkToMapTransform,
        const int32_t detectedObjectId,
        itri_msgs::DetectedObject *msg);
    void ComputeWorldCoordDetectedAgent(
        const actor::Attribute &attribute,
        const motion::State &state,
        const ros::Time &stamp,
        const int32_t detectedObjectId,
        itri_msgs::DetectedObject *msg);
    void ComputeLocalCoordLidarObject(
        const sensor::LidarDetectedObject &object,
        const ros::Time &stamp,
        const tf::StampedTransform &baselinkToMapTransform,
        const int32_t objectId,
        itri_msgs::DetectedObject *msg);
    void ComputeWorldCoordLidarObject(
        const sensor::LidarDetectedObject &object,
        const ros::Time &stamp,
        const int32_t objectId,
        itri_msgs::DetectedObject *msg);

    uint32_t EvaluateBehaviorState(const math::Vector3d_t &linearVelocity) const;

    ros::Time GetRosTime() const;
    ros::Time GetRosTimeNow() const;

    std::string mBaseLinkId;
    utils::TransformListener mTransformListener;
    std::shared_ptr<DetectedObjectIdManager> mDetectedObjectIdManager;
    RosTimeFunc mRosTimeFunc;
    bool mUseSimTime;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_DETECTED_OBJECT_MSG_GENERATOR_H_
