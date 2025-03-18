#ifndef _SCENARIO_VISUALIZATION_MSGS_MANAGER_H_
#define _SCENARIO_VISUALIZATION_MSGS_MANAGER_H_

#include <string>
#include <ros/ros.h>
#include <visualization_msgs/MarkerArray.h>
#include <utils_marker_id_manager.h>

namespace scenario {

class VisualizationMsgsManager final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{10};}

public:

    VisualizationMsgsManager();
    VisualizationMsgsManager(const VisualizationMsgsManager &) = delete;
    VisualizationMsgsManager &operator=(const VisualizationMsgsManager &) = delete;
    virtual ~VisualizationMsgsManager() = default;

    void Reset();
    void Publish(const visualization_msgs::Marker &marker);
    void Publish(const visualization_msgs::MarkerArray &markerArray);
    int32_t QueryMarkerId(const std::string &objectId);

protected:

private:

    ros::NodeHandle mNodeHandle;
    ros::Publisher mMarkerArrayPublisher;
    utils::MarkerIdManager mMarkerIdManager;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_VISUALIZATION_MSGS_MANAGER_H_
