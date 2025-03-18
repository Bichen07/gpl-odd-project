#include <visualization_auxiliary_processor.h>
#include <visualization_line_strip_marker_config.h>
#include <visualization_point_marker_config.h>
#include <visualization_text_marker_config.h>
#include <visualization_utils.h>

namespace visualization {

// public func.

AuxiliaryProcessor::AuxiliaryProcessor()
    : Processor()
{
}

void AuxiliaryProcessor::Update(
    const ros::Time &stamp,
    const scenario_msgs::LineStripMarkerArray &lineStripMarkerArray,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    for (auto marker{lineStripMarkerArray.markers.cbegin()};
         marker != lineStripMarkerArray.markers.cend();
         ++marker)
    {
        const auto markerId{
            Processor::QueryMarkerId(marker->id)};
        auto foundVisMsg{
            std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&markerId](const visualization_msgs::Marker &visMarker)
                {return visMarker.id == markerId;})};
        if (outputVisualizationMsg.markers.end() == foundVisMsg)
        {
            const auto markerConfig = LineStripMarkerConfig
            {
                .markerMsg = *marker,
                .markerId = markerId,
                .stamp = stamp,
                .ns = std::string("line_strip_marker"),
            };

            visualization_msgs::Marker lineStripMarker;
            visualization::GenerateLineStripMarker(
                markerConfig,
                lineStripMarker);
            outputVisualizationMsg.markers.push_back(lineStripMarker);
        }
        else
        {
            visualization::UpdateLineStripMarker(
                stamp,
                *marker,
                *foundVisMsg);
        }
    }
}

void AuxiliaryProcessor::Update(
    const ros::Time &stamp,
    const scenario_msgs::PointMarkerArray &pointMarkerArray,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    for (auto marker{pointMarkerArray.markers.cbegin()};
         marker != pointMarkerArray.markers.cend();
         ++marker)
    {
        const auto markerId{
            Processor::QueryMarkerId(marker->id)};
        auto foundVisMsg{
            std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&markerId](const visualization_msgs::Marker &visMarker)
                {return visMarker.id == markerId;})};
        if (outputVisualizationMsg.markers.end() == foundVisMsg)
        {
            const auto config = PointMarkerConfig
            {
                .type = marker->type,
                .markerId = markerId,
                .stamp = stamp,
                .ns= std::string("point_marker"),
                .lifetime = marker->lifetime,
                .pose = marker->pose,
                .size = marker->scale,
                .color = marker->color,
            };
            
            visualization_msgs::Marker pointMarker;
            visualization::GeneratePointMarker(
                config,
                pointMarker);
            outputVisualizationMsg.markers.push_back(pointMarker);
        }
        else
        {
            visualization::UpdatePointMarker(
                stamp,
                marker->pose,
                marker->scale,
                marker->lifetime,
                marker->color,
                *foundVisMsg);
        }
    }
}

void AuxiliaryProcessor::Update(
    const ros::Time &stamp,
    const scenario_msgs::TextMarkerArray &textMarkerArray,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    for (auto marker{textMarkerArray.markers.cbegin()};
         marker != textMarkerArray.markers.cend();
         ++marker)
    {
        const auto markerId{Processor::QueryMarkerId(marker->id)};
        auto foundVisMsg{
            std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&markerId](const visualization_msgs::Marker &visMarker)
                {return visMarker.id == markerId;})};
        if (outputVisualizationMsg.markers.end() == foundVisMsg)
        {
            const auto config = TextMarkerConfig
            {
                .text = marker->text,
                .markerId = markerId,
                .stamp = stamp,
                .ns = std::string("text_marker"),
                .lifetime = marker->lifetime,
                .pose = marker->pose,
                .size = marker->scale,
                .color = marker->color,
            };

            visualization_msgs::Marker textMarker;
            visualization::GenerateTextMarker(
                config,
                textMarker);
            outputVisualizationMsg.markers.push_back(textMarker);
        }
        else
        {
            visualization::UpdateTextMarker(
                stamp,
                marker->text,
                marker->pose,
                marker->scale,
                marker->lifetime,
                marker->color,
                *foundVisMsg);
        }
    }
}

// protected func.

// private func.

} // namespace visualization {
