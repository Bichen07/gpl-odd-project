#ifndef _VISUALIZATION_VELOCITY_MARKER_CONFIG_H_
#define _VISUALIZATION_VELOCITY_MARKER_CONFIG_H_

#include <ros/time.h>
#include <ros/duration.h>
#include <std_msgs/ColorRGBA.h>
#include <geometry_msgs/Vector3.h>
#include <utils_geometry_msgs.h>
#include <utils_default_color.h>

namespace visualization {

struct VelocityMarkerConfig final
{
    geometry_msgs::Vector3 velocity;
    geometry_msgs::Vector3 size;
    geometry_msgs::Pose pose;
    std_msgs::ColorRGBA color;
    int32_t markerId;
    ros::Time stamp;
    std::string ns;
    ros::Duration lifetime;

    VelocityMarkerConfig()
        : velocity{utils::GetZeroGeometryMsgsVector3()}
        , size{utils::GetZeroGeometryMsgsVector3()}
        , pose{}
        , color{utils::White()}
        , markerId{0}
        , stamp{}
        , ns{}
        , lifetime{}
    {
    }
    VelocityMarkerConfig(
        const geometry_msgs::Vector3 &inputVelocity,
        const geometry_msgs::Vector3 &inputSize,
        const geometry_msgs::Pose &inputPose,
        const std_msgs::ColorRGBA &inputColor,
        const int32_t inputMarkerId,
        const ros::Time &inputStamp,
        const std::string &inputNs,
        const ros::Duration &inputLifetime)
        : velocity{inputVelocity}
        , size{inputSize}
        , pose{inputPose}
        , color{inputColor}
        , markerId{inputMarkerId}
        , stamp{inputStamp}
        , ns{inputNs}
        , lifetime{inputLifetime}
    {
    }
    VelocityMarkerConfig(const VelocityMarkerConfig &other) = default;
    VelocityMarkerConfig &operator=(const VelocityMarkerConfig &other) = default;
    ~VelocityMarkerConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_VELOCITY_MARKER_CONFIG_H_
