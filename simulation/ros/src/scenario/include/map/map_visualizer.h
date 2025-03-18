#ifndef _MAP_VISUALIZER_H_
#define _MAP_VISUALIZER_H_

#include <memory>
#include <ros/ros.h>
#include <visualization_msgs/MarkerArray.h>
#include <math_type.h>
#include <scenario_visualization_msgs_manager.h>
#include <utils_marker_id_manager.h>
#include <map_type.h>
#include <map_crosswalk.h>
#include <map_intersection_waypoint_data.h>
#include <map_stop_line.h>
#include <map_traffic_light_controller.h>
#include <map_traffic_light_marker.h>

namespace map {

class Visualizer final
{

public:

    Visualizer();
    Visualizer(const Visualizer &) = delete;
    Visualizer &operator=(const Visualizer &) = delete;
    virtual ~Visualizer() = default;

    void Configure(
        const std::shared_ptr<scenario::VisualizationMsgsManager> &visualizationMsgsManager);
    void SetForwardWaypoints(const std::vector<math::Vector3d_t> &forwardWaypoints);
    void SetOppositeWaypoints(const std::vector<math::Vector3d_t> &oppositeWaypoints);
    void SetForwardIntersectionWaypointDatas(
        const std::vector<IntersectionWaypointData> &forwardInersectionWaypointDatas);
    void SetOppositeIntersectionWaypointDatas(
        const std::vector<IntersectionWaypointData> &oppositeIntersectionWaypointDatas);
    void SetCrosswalkMap(const std::map<int32_t, Crosswalk> &crosswalkMap);
    void SetStopLineMap(const std::map<int32_t, StopLine> &stopLineMap);
    void AppendTrafficLightMarker(const TrafficLightMarker &trafficLightMarker);

    void Publish();

protected:

private:

    void PublishForwardWaypoints();
    void PublishOppositeWaypoints();
    void PublishCrosswalks();
    void PublishStopLines();
    void PublishTrafficLightMarkers();

    void PublishForwardIntersectionWaypoints();
    void PublishOppositeIntersectionWaypoints();

    void GenerateWaypointMsgs(
        const int32_t id,
        const std::vector<math::Vector3d_t> &waypoints,
        const std_msgs::ColorRGBA &colorMsgs,
        visualization_msgs::Marker *markerMsgs) const;
    void GeneratePolygonMsgs(
        const int32_t id,
        const std::string &ns,
        const std::vector<math::Vector3d_t> &vertices,
        const std_msgs::ColorRGBA &colorMsgs,
        visualization_msgs::Marker *markerMsgs) const;

    std::shared_ptr<scenario::VisualizationMsgsManager> mVisualizationMsgsManager;

    std::vector<math::Vector3d_t> mForwardWaypoints;
    std::vector<math::Vector3d_t> mOppositeWaypoints;
    std::map<int32_t, Crosswalk> mCrosswalkMap;
    std::map<int32_t, StopLine> mStopLineMap;
    TrafficLightController mTrafficLightController;
    std::vector<TrafficLightMarker> mTrafficLightMarkers;

    std::vector<IntersectionWaypointData> mForwardIntersectionWaypointDatas;
    std::vector<IntersectionWaypointData> mOppositeIntersectionWaypointDatas;
};

} // namespace map {

#endif // #ifndef _MAP_VISUALIZER_H_
