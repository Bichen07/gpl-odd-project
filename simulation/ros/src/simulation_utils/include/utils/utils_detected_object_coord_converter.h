#ifndef _UTILS_DETECTED_OBJECT_COORD_CONVERTER_H_
#define _UTILS_DETECTED_OBJECT_COORD_CONVERTER_H_

#include <tf/transform_listener.h>
#include <std_msgs/Header.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Polygon.h>
#include <itri_msgs/DetectedObjectArray.h>

namespace utils {

class DetectedObjectCoordConverter final
{
    static constexpr const char *MapId()
    {return "map";}

public:

    DetectedObjectCoordConverter();
    DetectedObjectCoordConverter(const DetectedObjectCoordConverter &) = delete;
    DetectedObjectCoordConverter &operator=(const DetectedObjectCoordConverter &) = delete;
    virtual ~DetectedObjectCoordConverter() = default;

    void ToWorldCoord(
        const itri_msgs::DetectedObjectArray &localObjectArray,
        itri_msgs::DetectedObjectArray &worldObjectArray);
    void ToLocalCoord(
        const itri_msgs::DetectedObjectArray &worldObjectArray,
        itri_msgs::DetectedObjectArray &localObjectArray);

    void ToWorldCoord(
        const ros::Time &stamp,
        const geometry_msgs::Pose &localPose,
        geometry_msgs::Pose &outputWorldPose) const;
    void ToLocalCoord(
        const ros::Time &stamp,
        const geometry_msgs::Pose &worldPose,
        geometry_msgs::Pose &outputLocalPose) const;
    void ToLocalCoord(
        const ros::Time &stamp,
        const geometry_msgs::Vector3 &worldVector,
        geometry_msgs::Vector3 &outputLocalVector) const;
    void ToLocalCoord(
        const ros::Time &stamp,
        const geometry_msgs::Point &worldPoint,
        geometry_msgs::Point &outputLocalPoint) const;
    void ToLocalCoord(
        const ros::Time &stamp,
        const geometry_msgs::Point32 &worldPoint32,
        geometry_msgs::Point32 &outputLocalPoint32) const;

protected:

private:

    bool IsValidFramePair(
        const std::string &localFrameId,
        const std::string &worldFrameId) const;

    tf::TransformListener mTransformListener;
    std::string mBaseLinkId;
};

} // namespace utils {

#endif // #ifndef _UTILS_DETECTED_OBJECT_COORD_CONVERTER_H_
