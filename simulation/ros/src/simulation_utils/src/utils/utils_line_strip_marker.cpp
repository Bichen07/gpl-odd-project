#include <utils_line_strip_marker.h>
#include <algorithm>
#include <utils_converter.h>

namespace utils {

void GenerateLineStripMarkerMsg(
    const LineStripMarker &marker,
    scenario_msgs::LineStripMarker &msg)
{
    msg.id = marker.id;
    msg.points.resize(marker.points.size());
    std::transform(
        marker.points.cbegin(),
        marker.points.cend(),
        msg.points.begin(),
        [](const math::Vector3d_t &input)
        {return utils::ConvertToGeometryMsgsPoint(input);});
    msg.scale = marker.scale;
    msg.lifetime = marker.lifeTime;
    msg.color = marker.color;
}

void GenerateLineStripMarkerArrayMsg(
    const std::vector<LineStripMarker> &markers,
    scenario_msgs::LineStripMarkerArray &msg)
{
    msg.markers.resize(markers.size());
    auto markerMsg{msg.markers.begin()};
    auto marker{markers.cbegin()};
    for (; marker != markers.cend(); ++marker, ++markerMsg)
    {
        utils::GenerateLineStripMarkerMsg(
            *marker,
            *markerMsg);
    }
}

} // namespace utils {
