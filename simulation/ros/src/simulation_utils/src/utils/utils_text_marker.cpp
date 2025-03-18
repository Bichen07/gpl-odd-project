#include <utils_text_marker.h>
#include <ros/console.h>

namespace utils {

void GenerateTextMarkerMsg(
    const TextMarker &marker,
    scenario_msgs::TextMarker &msg)
{
    msg.id = marker.id;
    msg.text = marker.text;
    msg.pose = marker.pose.ToPose();
    msg.scale = marker.scale.ToVector3();
    msg.lifetime = marker.lifetime;
    msg.color = marker.color;
}

void GenerateTextMarkerArrayMsg(
    const std::vector<TextMarker> &markers,
    scenario_msgs::TextMarkerArray &msg)
{
    msg.markers.resize(markers.size());
    auto markerMsg{msg.markers.begin()};
    auto marker{markers.cbegin()};
    for (; marker != markers.cend(); ++marker, ++markerMsg)
    {
        utils::GenerateTextMarkerMsg(
            *marker,
            *markerMsg);
    }
}

} // namespace utils {
