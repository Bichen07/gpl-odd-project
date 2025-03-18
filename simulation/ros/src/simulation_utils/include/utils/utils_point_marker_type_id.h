#ifndef _UTILS_POINT_MARKER_TYPE_ID_H_
#define _UTILS_POINT_MARKER_TYPE_ID_H_

#include <map>
#include <iostream>
#include <visualization_msgs/Marker.h>

namespace utils {

typedef enum class PointMarkerType: uint8_t
{
    //Cube = visualization_msgs::Marker::CUBE,
    //Sphere = visualization_msgs::Marker::SPHERE,
    Cube = 0,
    Sphere,
    Num,
    Null = Num,
} PointMarkerTypeId;

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const PointMarkerTypeId &pointMarkerTypeId)
{
    static const std::map<PointMarkerTypeId, const char *> typeIdMap =
    {
        {PointMarkerType::Cube,   "PointMarkerType::Cube"},
        {PointMarkerType::Sphere, "PointMarkerType::Sphere"},
    };

    ostream << typeIdMap.find(pointMarkerTypeId)->second;
    return ostream;
}

} // namespace utils {

#endif // #ifndef _UTILS_POINT_MARKER_TYPE_ID_H_
