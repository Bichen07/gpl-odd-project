#include <path_waypoint_id.h>

namespace path {

WaypointId ToWaypointId(const path_msgs::WaypointId &msg)
{
    return WaypointId(msg.lane, msg.point);
}

} // namespace path {
