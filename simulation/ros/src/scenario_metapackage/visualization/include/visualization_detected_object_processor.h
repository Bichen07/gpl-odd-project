#ifndef _VISUALIZATION_DETECTED_OBJECT_PROCESSOR_H_
#define _VISUALIZATION_DETECTED_OBJECT_PROCESSOR_H_

#include <visualization_processor.h>
#include <map>
#include <ros/ros.h>
#include <std_msgs/ColorRGBA.h>
#include <geometry_msgs/Pose.h>
#include <visualization_msgs/MarkerArray.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <utils_detected_object_coord_converter.h>
#include <utils_object_id_manager.h>
#include <scenario_msgs/AgentData.h>
#include <scenario_msgs/AgentDataArray.h>
#include <scenario_msgs/LineStripMarkerArray.h>
#include <scenario_msgs/PointMarkerArray.h>

namespace visualization {

class DetectedObjectProcessor final : public Processor
{
    static const double DefaultLifeTime()
    {return double{0.1};}

public:

    using DetectedObjectPoseMap = std::map<uint32_t, geometry_msgs::Pose>;

    DetectedObjectProcessor();
    DetectedObjectProcessor(const DetectedObjectProcessor &) = delete;
    DetectedObjectProcessor &operator=(const DetectedObjectProcessor &) = delete;
    virtual ~DetectedObjectProcessor() = default;

    const scenario_msgs::AgentDataArray &GetAgentDataArray() const;
    const DetectedObjectPoseMap &GetDetectedObjectPoseMap() const;

    void Update(
        const ros::Time &stamp,
        const scenario_msgs::AgentDataArray &agentDataArray,
        visualization_msgs::MarkerArray &outputVisualizationMsg);
    void UpdateDetectedObjectArray(
        const itri_msgs::DetectedObjectArray &msg);

protected:

private:

    const std::string &QueryAgentNs(const std::string &objectClassId);
    void UpdateVelocityMarker(
        const ros::Time &stamp,
        const scenario_msgs::AgentData &agentDataMsg,
        visualization_msgs::MarkerArray &outputVisualizationMarker);
    void UpdateDetectedObjectIdMarker(
        const ros::Time &stamp,
        const scenario_msgs::AgentDataArray &agentDataArrayMsg,
        const DetectedObjectPoseMap &detectedObjectPoseMap,
        visualization_msgs::MarkerArray &outputVisualizationMarker);

    scenario_msgs::AgentDataArray mAgentDataArray;
    std::map<std::string, std::string> mAgentNsMap;
    utils::DetectedObjectCoordConverter mDetectedObjectCoordConverter;
    DetectedObjectPoseMap mDetectedObjectPoseMap;
    bool mCanShowDetectedObjectId;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_DETECTED_OBJECT_PROCESSOR_H_
