#include <utils_point_marker.h>
#include <utils_converter.h>

namespace utils {

void GeneratePointMarkerMsg(
    const PointMarker &marker,
    scenario_msgs::PointMarker &msg)
{
    msg.id = marker.id;
    msg.type = static_cast<typename std::underlying_type<PointMarkerTypeId>::type>(marker.type);
    msg.pose = utils::ConvertToGeometryMsgsPose(marker.pose);
    msg.scale = utils::ConvertToGeometryMsgsVector3(marker.scale);
    msg.lifetime = marker.lifeTime;
    msg.color = marker.color;
}

void GeneratePointMarkerArrayMsg(
    const std::vector<PointMarker> &markers,
    scenario_msgs::PointMarkerArray &msg)
{
    msg.markers.resize(markers.size());
    auto markerMsg{msg.markers.begin()};
    auto marker{markers.cbegin()};
    for (; marker != markers.cend(); ++marker, ++markerMsg)
    {
        utils::GeneratePointMarkerMsg(
            *marker,
            *markerMsg);
    }
}

} // namespace utils {
