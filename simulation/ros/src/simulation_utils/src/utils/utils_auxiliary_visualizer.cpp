#include <utils_auxiliary_visualizer.h>
#include <ros/console.h>
#include <visualization_msgs/MarkerArray.h>
#include <scenario_msgs/PointMarkerArray.h>
#include <utils_converter.h>

namespace utils {

// public func.

AuxiliaryVisualizer::AuxiliaryVisualizer()
    : mNodeHandle{}
    , mLineStripMarkerArrayPublisher{}
    , mPointMarkerArrayPublisher{}
    , mTextMarkerArrayPublisher{}
    , mLineStripMarkers{}
    , mPointMarkers{}
    , mTextMarkers{}
{
    mLineStripMarkerArrayPublisher =
        mNodeHandle.advertise<scenario_msgs::LineStripMarkerArray>(
            "scenario/line_strip_marker_array",
            DefaultQueueSize());
    mPointMarkerArrayPublisher =
        mNodeHandle.advertise<scenario_msgs::PointMarkerArray>(
            "scenario/point_marker_array",
            DefaultQueueSize());
    mTextMarkerArrayPublisher =
        mNodeHandle.advertise<scenario_msgs::TextMarkerArray>(
            "scenario/text_marker_array",
            DefaultQueueSize());
}

void AuxiliaryVisualizer::AppendLineStripMarker(const LineStripMarker &marker)
{
    mLineStripMarkers.push_back(marker);
}

void AuxiliaryVisualizer::AppendPointMarker(const PointMarker &marker)
{
    mPointMarkers.push_back(marker);
}

void AuxiliaryVisualizer::AppendTextMarker(const TextMarker &marker)
{
    mTextMarkers.push_back(marker);
}

void AuxiliaryVisualizer::Publish()
{
    this->PublishLineStripMarkers();
    this->PublishPointMarkers();
    this->PublishTextMarkers();
}

// protected func.

// private func.

void AuxiliaryVisualizer::PublishLineStripMarkers()
{
    if (mLineStripMarkers.empty())
    {
        return;
    }

    scenario_msgs::LineStripMarkerArray lineStripMarkerArray;
    utils::GenerateLineStripMarkerArrayMsg(
        mLineStripMarkers,
        lineStripMarkerArray);
    mLineStripMarkerArrayPublisher.publish(lineStripMarkerArray);
    mLineStripMarkers.clear();
}

void AuxiliaryVisualizer::PublishPointMarkers()
{
    if (mPointMarkers.empty())
    {
        return;
    }

    scenario_msgs::PointMarkerArray pointMarkerArray;
    utils::GeneratePointMarkerArrayMsg(
        mPointMarkers,
        pointMarkerArray);
    mPointMarkerArrayPublisher.publish(pointMarkerArray);
    mPointMarkers.clear();
}

void AuxiliaryVisualizer::PublishTextMarkers()
{
    if (mTextMarkers.empty())
    {
        return;
    }

    scenario_msgs::TextMarkerArray textMarkerArray;
    utils::GenerateTextMarkerArrayMsg(
        mTextMarkers,
        textMarkerArray);
    mTextMarkerArrayPublisher.publish(textMarkerArray);
    mTextMarkers.clear();
}

} // namespace utils {
