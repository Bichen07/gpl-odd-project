#ifndef _UTILS_POINT_CLUSTER_MARKER_H_
#define _UTILS_POINT_CLUSTER_MARKER_H_

#include <vector>
#include <string>
#include <std_msgs/ColorRGBA.h>
#include <math_type.h>

namespace utils {

struct PointClusterMarker final
{
    std::string id;
    std::vector<math::Vector3d_t> points;
    std_msgs::ColorRGBA color;
};

} // namespace utils {

#endif // #ifndef _UTILS_POINT_CLUSTER_MARKER_H_
