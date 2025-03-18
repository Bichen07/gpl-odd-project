#ifndef _VISUALIZATION_LINE_STRIP_MARKER_CONFIG_H_
#define _VISUALIZATION_LINE_STRIP_MARKER_CONFIG_H_

#include <ros/time.h>
#include <ros/duration.h>
#include <scenario_msgs/LineStripMarker.h>

namespace visualization {

struct LineStripMarkerConfig final
{
    scenario_msgs::LineStripMarker markerMsg;
    int32_t markerId;
    ros::Time stamp;
    std::string ns;

    LineStripMarkerConfig()
        : markerMsg{}
        , markerId{0}
        , stamp{}
        , ns{}
    {
    }
    LineStripMarkerConfig(
        const scenario_msgs::LineStripMarker &inputMarkerMsg,
        const int32_t inputMarkerId,
        const ros::Time &inputStamp,
        const std::string &inputNs)
        : markerMsg{inputMarkerMsg}
        , markerId{inputMarkerId}
        , stamp{inputStamp}
        , ns{inputNs}
    {
    }
    LineStripMarkerConfig(const LineStripMarkerConfig &other) = default;
    LineStripMarkerConfig &operator=(const LineStripMarkerConfig &other) = default;
    ~LineStripMarkerConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_LINE_STRIP_MARKER_CONFIG_H_
