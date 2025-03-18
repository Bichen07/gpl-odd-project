#ifndef _VISUALIZATION_DETECTED_OBJECT_ID_MARKER_CONFIG_H_
#define _VISUALIZATION_DETECTED_OBJECT_ID_MARKER_CONFIG_H_

#include <ros/time.h>
#include <ros/duration.h>
#include <std_msgs/ColorRGBA.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Vector3.h>
#include <utils_geometry_msgs.h>

namespace visualization {

struct DetectedObjectIdMarkerConfig final
{
    std::string detectedObjectId;
    int32_t markerId;
    ros::Time stamp;
    std::string ns;
    geometry_msgs::Pose pose;
    geometry_msgs::Vector3 scale;
    std_msgs::ColorRGBA color;
    ros::Duration lifetime;

    DetectedObjectIdMarkerConfig()
        : detectedObjectId{}
        , markerId{0}
        , stamp{}
        , ns{}
        , pose{utils::GetIdentityGeometryMsgsPose()}
        , scale{utils::GetZeroGeometryMsgsVector3()}
        , color{}
        , lifetime{}
    {
    }
    DetectedObjectIdMarkerConfig(
        const std::string &inputDetectedObjectId,
        const int32_t inputMarkerId,
        const ros::Time &inputStamp,
        const std::string &inputNs,
        const geometry_msgs::Pose &inputPose,
        const geometry_msgs::Vector3 &inputScale,
        const std_msgs::ColorRGBA &inputColor,
        const ros::Duration &inputLifetime)
        : detectedObjectId{inputDetectedObjectId}
        , markerId{inputMarkerId}
        , stamp{inputStamp}
        , ns{inputNs}
        , pose{inputPose}
        , scale{inputScale}
        , color{inputColor}
        , lifetime{inputLifetime}
    {
    }
    DetectedObjectIdMarkerConfig(const DetectedObjectIdMarkerConfig &other) = default;
    DetectedObjectIdMarkerConfig &operator=(const DetectedObjectIdMarkerConfig &other) = default;
    ~DetectedObjectIdMarkerConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_DETECTED_OBJECT_ID_MARKER_CONFIG_H_
