#ifndef _MEASURE_FRENET_DISTANCE_MARKER_H_
#define _MEASURE_FRENET_DISTANCE_MARKER_H_

#include <std_msgs/ColorRGBA.h>
#include <ros/duration.h>
#include <measure_frenet_distance_data.h>

namespace measure {

struct FrenetDistanceMarker final
{
    std::string id;
    FrenetDistanceData data;
    math::HomoXfm3d_t textTransform3d;
    math::FrenetCoord textOffset;
    std_msgs::ColorRGBA textColor;
    ros::Duration lifeTime;
    bool canShowSequentialPoints;

    FrenetDistanceMarker()
        : id{}
        , data{}
        , textTransform3d{}
        , textOffset{}
        , textColor{}
        , lifeTime{}
        , canShowSequentialPoints{false}
    {
    }
    explicit FrenetDistanceMarker(
        const std::string &inputId,
        const FrenetDistanceData &inputData,
        const math::HomoXfm3d_t &inputTextTransform3d,
        const math::FrenetCoord &inputTextOffset,
        const std_msgs::ColorRGBA &inputTextColor,
        const ros::Duration &inputLifeTime,
        const bool inputCanShowSequentialPoints)
        : id{inputId}
        , data{inputData}
        , textTransform3d{inputTextTransform3d}
        , textOffset{inputTextOffset}
        , textColor{inputTextColor}
        , lifeTime{inputLifeTime}
        , canShowSequentialPoints{inputCanShowSequentialPoints}
    {
    }
    FrenetDistanceMarker(const FrenetDistanceMarker &) = default;
    FrenetDistanceMarker&operator=(const FrenetDistanceMarker &) = default;
    ~FrenetDistanceMarker() = default;
};

} // namespace measure {

#endif // #ifndef _MEASURE_FRENET_DISTANCE_MARKER_H_
