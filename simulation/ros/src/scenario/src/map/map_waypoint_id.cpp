#include <map_waypoint_id.h>
#include <utils_json.h>

namespace map {

void ParseWaypointId(
    const Json::Value &configJsonValue,
    map::WaypointId &outputWaypointId)
{
    outputWaypointId.lane = utils::GetIntJsonValue(
        configJsonValue["lane"]);
    outputWaypointId.point = utils::GetIntJsonValue(
        configJsonValue["point"]);
}

} // namespace map {
