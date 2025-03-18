#ifndef _UTILS_LINE_STRIP_MARKER_H_
#define _UTILS_LINE_STRIP_MARKER_H_

#include <string>
#include <std_msgs/ColorRGBA.h>
#include <ros/duration.h>
#include <scenario_msgs/LineStripMarker.h>
#include <scenario_msgs/LineStripMarkerArray.h>
#include <math_type.h>

namespace utils {

struct LineStripMarker final
{
    std::string id;
    std::vector<math::Vector3d_t> points;
    math::real_t scale;
    ros::Duration lifeTime;
    std_msgs::ColorRGBA color;

    LineStripMarker()
        : id{}
        , points{}
        , scale{0.0}
        , lifeTime{}
        , color{}
    {
    }
    explicit LineStripMarker(
        const std::string &inputId,
        const std::vector<math::Vector3d_t> &inputPoints,
        const math::real_t inputScale,
        const ros::Duration &inputLifeTime,
        const std_msgs::ColorRGBA &inputColor)
        : id{inputId}
        , points{inputPoints}
        , scale{inputScale}
        , lifeTime{inputLifeTime}
        , color{inputColor}
    {
    }
    LineStripMarker(const LineStripMarker &) = default;
    LineStripMarker &operator=(const LineStripMarker &) = default;
    ~LineStripMarker() = default;
};

void GenerateLineStripMarkerMsg(
    const LineStripMarker &marker,
    scenario_msgs::LineStripMarker &msg);
void GenerateLineStripMarkerArrayMsg(
    const std::vector<LineStripMarker> &markers,
    scenario_msgs::LineStripMarkerArray &msg);

} // namespace utils {

#endif // #ifndef _UTILS_LINE_STRIP_MARKER_H_
