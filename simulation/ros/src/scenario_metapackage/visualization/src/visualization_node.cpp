#include <visualization_node.h>
#include <stdexcept>
#include <ros/console.h>
#include <visualization_msgs/MarkerArray.h>

namespace visualization {

// public func.

Node::Node()
    : mNodeHandle{}
    , mAgentDataArraySubscriber{}
    , mRssCheckResultSubscriber{}
    , mRssLandmarkArraySubscriber{}
    , mLineStripMarkerArraySubscriber{}
    , mPointMarkerArraySubscriber{}
    , mTextMarkerArraySubscriber{}
    , mDetectedObjectArraySubscriber{}
    , mMarkerArrayPublisher{}
    , mFrequency{DefaultFrequency()}
    , mOutputVisualizationMsg{}
    , mAuxiliaryProcessor{}
    , mDetectedObjectProcessor{}
    , mRssProcessor{}
    , mAgentDataMutex{}
    , mLineStripMarkerMutex{}
    , mPointMarkerMutex{}
    , mTextMarkerMutex{}
    , mDetectedObjectMutex{}
{
    mAgentDataArraySubscriber = mNodeHandle.subscribe(
        "scenario/agent_data_array",
        DefaultQueueSize(),
        &Node::AgentDataArrayCallback,
        this);
    mAgentDataArraySubscriberFromSimulationAdv = mNodeHandle.subscribe(
        "/simulation/agent_data_array",
        DefaultQueueSize(),
        &Node::AgentDataArrayCallback,
        this);
    // mAgentDataArraySubscriberFromEgo = mNodeHandle.subscribe(
    //     "agent_data_array/global",
    //     DefaultQueueSize(),
    //     &Node::AgentDataArrayCallback,
    //     this);
    mRssCheckResultSubscriber = mNodeHandle.subscribe(
        "rss/check_result",
        DefaultQueueSize(),
        &Node::RssCheckResultCallback,
        this);
    mRssLandmarkArraySubscriber = mNodeHandle.subscribe(
        "rss/landmark_array",
        DefaultQueueSize(),
        &Node::RssLandmarkArrayCallback,
        this);
    mLineStripMarkerArraySubscriber = mNodeHandle.subscribe(
        "scenario/line_strip_marker_array",
        DefaultQueueSize(),
        &Node::LineStripMarkerArrayCallback,
        this);
    mPointMarkerArraySubscriber = mNodeHandle.subscribe(
        "scenario/point_marker_array",
        DefaultQueueSize(),
        &Node::PointMarkerArrayCallback,
        this);
    mTextMarkerArraySubscriber = mNodeHandle.subscribe(
        "scenario/text_marker_array",
        DefaultQueueSize(),
        &Node::TextMarkerArrayCallback,
        this);
    mDetectedObjectArraySubscriber = mNodeHandle.subscribe(
        "detected_objects",
        DefaultQueueSize(),
        &Node::DetectedObjectArrayCallback,
        this);
    mMarkerArrayPublisher = mNodeHandle.advertise<visualization_msgs::MarkerArray>(
        "scenario_visualization",
        DefaultQueueSize());
}

void Node::ShuttingDownClearMarkers(int sig)
{
    ros::NodeHandle nodeHandle;
    ros::Publisher publisher = nodeHandle.advertise<visualization_msgs::MarkerArray>(
        "scenario_visualization",
        DefaultQueueSize());
    visualization_msgs::Marker deletingMarker;
    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(1);
    markerArray.markers[0].header.frame_id = "/map";
    markerArray.markers[0].action = visualization_msgs::Marker::DELETEALL;
    publisher.publish(markerArray);
    ros::shutdown();
}

void Node::Configure(const double frequency)
{
    if (frequency < double{10.0})
    {
        ROS_ERROR_STREAM("invalid frequency: " << frequency);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mFrequency = frequency;
}

void Node::RunMainLoop()
{
    ros::Rate nodeRate(mFrequency);

    while (ros::ok())
    {
        this->Publish();
        ros::spinOnce();
        nodeRate.sleep();
    }
}

// protedted func.

// private func.

void Node::Publish()
{
    std::lock_guard<std::mutex> agentDataGuard(mAgentDataMutex);
    std::lock_guard<std::mutex> lineStripMarkerGuard(mLineStripMarkerMutex);
    std::lock_guard<std::mutex> pointMarkerGuard(mPointMarkerMutex);
    std::lock_guard<std::mutex> textMarkerGuard(mTextMarkerMutex);
    std::lock_guard<std::mutex> detectedObjectGuard(mDetectedObjectMutex);
    mMarkerArrayPublisher.publish(mOutputVisualizationMsg);
}

void Node::AgentDataArrayCallback(
    const scenario_msgs::AgentDataArray &msg)
{
    std::lock_guard<std::mutex> agentDataGuard(mAgentDataMutex);
    const ros::Time stamp{ros::Time::now()};
    mDetectedObjectProcessor.Update(
        stamp,
        msg,
        mOutputVisualizationMsg);

    mRssProcessor.UpdateAgentSafetyIndicator(
        stamp,
        msg,
        mOutputVisualizationMsg);
}

void Node::RssCheckResultCallback(const rss_msgs::CheckResult::ConstPtr &msg)
{
    mRssProcessor.UpdateCheckResult(msg);
    const ros::Time stamp{ros::Time::now()};
    mRssProcessor.UpdateEgoVehicleUnstructuredData(
        stamp,
        mOutputVisualizationMsg);
}

void Node::RssLandmarkArrayCallback(const rss_msgs::LandmarkArray::ConstPtr &msg)
{
    mRssProcessor.UpdateLandmarks(
        msg,
        mOutputVisualizationMsg);
}

void Node::LineStripMarkerArrayCallback(
    const scenario_msgs::LineStripMarkerArray &msg)
{
    std::lock_guard<std::mutex> guard(mLineStripMarkerMutex);
    const ros::Time stamp{ros::Time::now()};
    mAuxiliaryProcessor.Update(
        stamp,
        msg,
        mOutputVisualizationMsg);
}

void Node::PointMarkerArrayCallback(
    const scenario_msgs::PointMarkerArray &msg)
{
    std::lock_guard<std::mutex> guard(mPointMarkerMutex);
    const ros::Time stamp{ros::Time::now()};
    mAuxiliaryProcessor.Update(
        stamp,
        msg,
        mOutputVisualizationMsg);
}

void Node::TextMarkerArrayCallback(
    const scenario_msgs::TextMarkerArray &msg)
{
    std::lock_guard<std::mutex> guard(mTextMarkerMutex);
    const ros::Time stamp{ros::Time::now()};
    mAuxiliaryProcessor.Update(
        stamp,
        msg,
        mOutputVisualizationMsg);
}

void Node::DetectedObjectArrayCallback(
    const itri_msgs::DetectedObjectArray &msg)
{
    std::lock_guard<std::mutex> guard(mDetectedObjectMutex);
    mDetectedObjectProcessor.UpdateDetectedObjectArray(msg);

    const ros::Time stamp{ros::Time::now()};
    mRssProcessor.UpdateDetectedObjectSafetyIndicator(
        stamp,
        mDetectedObjectProcessor.GetDetectedObjectPoseMap(),
        mDetectedObjectProcessor.GetAgentDataArray(),
        mOutputVisualizationMsg);
}

} // namespace visualization {
