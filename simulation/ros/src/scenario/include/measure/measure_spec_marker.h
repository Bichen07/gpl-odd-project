#ifndef _MEASURE_SPEC_MARKER_H_
#define _MEASURE_SPEC_MARKER_H_

#include <string>
#include <std_msgs/ColorRGBA.h>
#include <ros/duration.h>
#include <math_type.h>

namespace measure {

struct SpecMarker final
{
    std::string id;
    std::string text;
    math::HomoXfm3d_t transform3d;
    math::FrenetCoord textOffset;
    math::Vector3d_t scale;
    ros::Duration lifeTime;
    std_msgs::ColorRGBA color;

    SpecMarker()
        : id{}
        , text{}
        , transform3d{}
        , textOffset{}
        , scale{}
        , lifeTime{}
        , color{}
    {
    }
    explicit SpecMarker(
        const std::string &inputId,
        const std::string &inputText,
        const math::HomoXfm3d_t &inputTransform3d,
        const math::FrenetCoord &inputTextOffset,
        const math::Vector3d_t &inputScale,
        const ros::Duration &inputLifeTime,
        const std_msgs::ColorRGBA &inputColor)
        : id{inputId}
        , text{inputText}
        , transform3d{inputTransform3d}
        , textOffset{inputTextOffset}
        , scale{inputScale}
        , lifeTime{inputLifeTime}
        , color{inputColor}
    {
    }
    SpecMarker(const SpecMarker &) = default;
    SpecMarker &operator=(const SpecMarker &) = default;
    ~SpecMarker() = default;
};

} // namespace measure {

#endif // #ifndef _MEASURE_SPEC_MARKER_H_
