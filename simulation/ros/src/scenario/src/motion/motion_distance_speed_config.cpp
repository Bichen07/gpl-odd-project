#include <motion_distance_speed_config.h>

namespace motion {

bool operator<(const DistanceSpeedConfig &lhs, const DistanceSpeedConfig &rhs)
{
    return lhs.distance < rhs.distance;
}

} // namespace motion {
