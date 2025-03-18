#ifndef _UTILS_POINT_MARKER_H_
#define _UTILS_POINT_MARKER_H_

#include <string>
#include <ros/duration.h>
#include <std_msgs/ColorRGBA.h>
#include <scenario_msgs/PointMarker.h>
#include <scenario_msgs/PointMarkerArray.h>
#include <math_type.h>
#include <utils_point_marker_type_id.h>

namespace utils {

struct PointMarker final
{
    std::string id;
    PointMarkerTypeId type;
    math::HomoXfm3d_t pose;
    math::Vector3d_t scale;
    ros::Duration lifeTime;
    std_msgs::ColorRGBA color;

    PointMarker()
        : id{}
        , type{PointMarkerType::Null}
        , pose{}
        , scale{}
        , lifeTime{}
        , color{}
    {
    }
    explicit PointMarker(
        const std::string &inputId,
        const PointMarkerTypeId &inputType,
        const math::HomoXfm3d_t &inputPose,
        const math::Vector3d_t &inputScale,
        const ros::Duration &inputLifeTime,
        const std_msgs::ColorRGBA &inputColor)
        : id{inputId}
        , type{inputType}
        , pose{inputPose}
        , scale{inputScale}
        , lifeTime{inputLifeTime}
        , color{inputColor}
    {
    }
    PointMarker(const PointMarker &) = default;
    PointMarker &operator=(const PointMarker &) = default;
    ~PointMarker() = default;
};

void GeneratePointMarkerMsg(
    const PointMarker &marker,
    scenario_msgs::PointMarker &msg);
void GeneratePointMarkerArrayMsg(
    const std::vector<PointMarker> &markers,
    scenario_msgs::PointMarkerArray &msg);

} // namespace utils {

#endif // #ifndef _UTILS_POINT_MARKER_H_
