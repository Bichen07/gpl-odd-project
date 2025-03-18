#ifndef _MEASURE_VELOCITY_MARKER_H_
#define _MEASURE_VELOCITY_MARKER_H_

#include <string>
#include <std_msgs/ColorRGBA.h>
#include <ros/duration.h>
#include <math_type.h>

namespace measure {

struct VelocityMarker final
{
    std::string id;
    math::Vector3d_t velocity;
    math::Vector3d_t beginPosition;
    ros::Duration lifeTime;
    std_msgs::ColorRGBA color;
    math::real_t speedTextScale;

    VelocityMarker()
        : id{}
        , velocity{}
        , beginPosition{}
        , lifeTime{}
        , color{}
        , speedTextScale{0.0}
    {
    }
    explicit VelocityMarker(
        const std::string &inputId,
        const math::Vector3d_t &inputVelocity,
        const math::Vector3d_t &inputBeginPosition,
        const ros::Duration &inputLifeTime,
        const std_msgs::ColorRGBA &inputColor,
        const math::real_t inputSpeedTextScale = 0.0)
        : id{inputId}
        , velocity{inputVelocity}
        , beginPosition{inputBeginPosition}
        , lifeTime{inputLifeTime}
        , color{inputColor}
        , speedTextScale{inputSpeedTextScale}
    {
    }
    VelocityMarker(const VelocityMarker &) = default;
    VelocityMarker &operator=(const VelocityMarker &) = default;
    ~VelocityMarker() = default;
};

} // namespace measure {

#endif // #ifndef _MEASURE_VELOCITY_MARKER_H_
