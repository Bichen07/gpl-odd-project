#ifndef _VISUALIZATION_RSS_PROCESSOR_H_
#define _VISUALIZATION_RSS_PROCESSOR_H_

#include <map>
#include <visualization_processor.h>
#include <std_msgs/ColorRGBA.h>
#include <rss_msgs/CheckResult.h>
#include <rss_msgs/CheckResultEgoVehicleState.h>
#include <rss_msgs/CheckResultObjectState.h>
#include <rss_msgs/LandmarkArray.h>
#include <scenario_msgs/AgentDataArray.h>

namespace visualization {

class RssProcessor final : public Processor
{

public:

    using Ptr = std::shared_ptr<RssProcessor>;

    RssProcessor();
    RssProcessor(const RssProcessor &) = delete;
    RssProcessor &operator=(const RssProcessor &) = delete;
    virtual ~RssProcessor() = default;

    void UpdateEgoVehicleUnstructuredData(
        const ros::Time &stamp,
        visualization_msgs::MarkerArray &outputVisualizationMsg);
    void UpdateAgentSafetyIndicator(
        const ros::Time &stamp,
        const scenario_msgs::AgentDataArray &agentDataArray,
        visualization_msgs::MarkerArray &outputVisualizationMsg);
    void UpdateDetectedObjectSafetyIndicator(
        const ros::Time &stamp,
        const std::map<uint32_t, geometry_msgs::Pose> &detectedObjectPoseMap,
        const scenario_msgs::AgentDataArray &agentDataArray,
        visualization_msgs::MarkerArray &outputVisualizationMsg);
    void UpdateCheckResult(const rss_msgs::CheckResult::ConstPtr &msg);
    void UpdateLandmarks(
        const rss_msgs::LandmarkArray::ConstPtr &msg,
        visualization_msgs::MarkerArray &outputVisualizationMsg);

protected:

private:

    void UpdateSituationType(
        const ros::Time &stamp,
        const rss_msgs::CheckResultObjectState &checkResultObjectState,
        const geometry_msgs::Pose &refMarkerPose,
        visualization_msgs::MarkerArray &outputVisualizationMsg);
    void UpdateEgoVehicleUnstructuredTrajectorySet(
        const ros::Time &stamp,
        const rss_msgs::CheckResultEgoVehicleState &egoVehicleState,
        visualization_msgs::MarkerArray &outputVisMsg);
    void UpdateObjectUnstructuredTrajectorySet(
        const ros::Time &stamp,
        const rss_msgs::CheckResultObjectState &checkResultObjectState,
        visualization_msgs::MarkerArray &outputVisMsg);
    void UpdateBrakeTrajectorySet(
        const ros::Time &stamp,
        const std::string &id,
        const std::vector<geometry_msgs::Point> &brakeTrajectorySet,
        visualization_msgs::MarkerArray &outputVisMarkerArray);
    void UpdateContinueForwardTrajectorySet(
        const ros::Time &stamp,
        const std::string &id,
        const std::vector<geometry_msgs::Point> &continueForwardTrajectorSet,
        visualization_msgs::MarkerArray &outputVisMarkerArray);
    std::vector<rss_msgs::CheckResultObjectState>::const_iterator
        QueryCheckResultObjectState(
            const rss_msgs::CheckResult &checkResultMsg,
            const uint32_t detectedObjectId) const;
    std::vector<scenario_msgs::AgentData>::const_iterator QueryAgentData(
        const scenario_msgs::AgentDataArray &agentDataArray,
        const uint32_t detectedObjectId) const;
    const std_msgs::ColorRGBA &EvaluateSafetyIndicatorColor(
        const rss_msgs::CheckResultObjectState &objectState) const;
    const std_msgs::ColorRGBA &EvaluateStructuredSafetyIndicatorColor(
        const rss_msgs::StructuredSafety &structuredSafety) const;
    const std_msgs::ColorRGBA &EvaluateUnstructuredSafetyIndicatorColor(
        const rss_msgs::UnstructuredSafety &unstructuredSafety) const;
    bool IsValidCheckResult() const;

    rss_msgs::CheckResult::ConstPtr mCheckResultMsg;
    bool mCanShowEgoVehicleBrakeTrajectorySet;
    bool mCanShowEgoVehicleContinueForwardTrajectorySet;
    bool mCanShowObjectBrakeTrajectorySet;
    bool mCanShowObjectContinueForwardTrajectorySet;
    bool mCanShowSituationType;
    bool mCanShowLandmark;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_RSS_PROCESSOR_H_
