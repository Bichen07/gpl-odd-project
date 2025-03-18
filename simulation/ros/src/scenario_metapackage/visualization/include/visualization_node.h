#ifndef _VISUALIZATION_NODE_H_
#define _VISUALIZATION_NODE_H_

#include <mutex>
#include <ros/ros.h>
#include <visualization_msgs/MarkerArray.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <rss_msgs/CheckResult.h>
#include <rss_msgs/LandmarkArray.h>
#include <scenario_msgs/AgentDataArray.h>
#include <scenario_msgs/LineStripMarkerArray.h>
#include <scenario_msgs/PointMarkerArray.h>
#include <visualization_auxiliary_processor.h>
#include <visualization_detected_object_processor.h>
#include <visualization_rss_processor.h>

namespace visualization {

class Node final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    static constexpr double DefaultFrequency()
    {return double{100.0};}

    Node();
    Node(const Node &) = delete;
    Node &operator=(const Node &) = delete;
    virtual ~Node() = default;

    static void ShuttingDownClearMarkers(int sig);

    void Configure(const double frequency = DefaultFrequency());
    void RunMainLoop();

protected:

private:

    void Publish();
    void AgentDataArrayCallback(const scenario_msgs::AgentDataArray &msg);
    void RssCheckResultCallback(const rss_msgs::CheckResult::ConstPtr &msg);
    void RssLandmarkArrayCallback(const rss_msgs::LandmarkArray::ConstPtr &msg);
    void LineStripMarkerArrayCallback(const scenario_msgs::LineStripMarkerArray &msg);
    void PointMarkerArrayCallback(const scenario_msgs::PointMarkerArray &msg);
    void TextMarkerArrayCallback(const scenario_msgs::TextMarkerArray &msg);
    void DetectedObjectArrayCallback(const itri_msgs::DetectedObjectArray &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mAgentDataArraySubscriber;
    ros::Subscriber mAgentDataArraySubscriberFromEgo;
    ros::Subscriber mAgentDataArraySubscriberFromSimulationAdv;
    ros::Subscriber mRssCheckResultSubscriber;
    ros::Subscriber mRssLandmarkArraySubscriber;
    ros::Subscriber mLineStripMarkerArraySubscriber;
    ros::Subscriber mPointMarkerArraySubscriber;
    ros::Subscriber mTextMarkerArraySubscriber;
    ros::Subscriber mDetectedObjectArraySubscriber;
    ros::Publisher mMarkerArrayPublisher;
    double mFrequency;
    visualization_msgs::MarkerArray mOutputVisualizationMsg;
    AuxiliaryProcessor mAuxiliaryProcessor;
    DetectedObjectProcessor mDetectedObjectProcessor;
    RssProcessor mRssProcessor;
    std::mutex mAgentDataMutex;
    std::mutex mLineStripMarkerMutex;
    std::mutex mPointMarkerMutex;
    std::mutex mTextMarkerMutex;
    std::mutex mDetectedObjectMutex;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_NODE_H_
