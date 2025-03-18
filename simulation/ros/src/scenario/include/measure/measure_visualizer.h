#ifndef _MEASURE_VISUALIZER_H_
#define _MEASURE_VISUALIZER_H_

#include <memory>
#include <vector>
#include <map>
#include <ros/ros.h>
#include <scenario_visualization_msgs_manager.h>
#include <measure_frenet_distance_marker.h>
#include <measure_safety_region_data.h>
#include <measure_spec_marker.h>
#include <measure_velocity_marker.h>

namespace measure {

class Visualizer final
{

public:

    Visualizer();
    Visualizer(const Visualizer &) = delete;
    Visualizer &operator=(const Visualizer &) = delete;
    virtual ~Visualizer();

    void Configure(
        const std::shared_ptr<scenario::VisualizationMsgsManager> &visualizationMsgsManager);
    void SetAgentSafetyRegionDatas(const std::vector<SafetyRegionData> &datas);

    void AppendFrenetDistanceMarker(const FrenetDistanceMarker &marker);
    void AppendSpecMarker(const SpecMarker &marker);
    void AppendVelocityMarker(const VelocityMarker &marker);

    void Publish();

protected:

private:

    void PublishAgentSafetyRegions();
    void PublishFrenetDistanceDatas();
    void PublishSpecMarkers();
    void PublishVelocityMarkers();

    std::shared_ptr<scenario::VisualizationMsgsManager> mVisualizationMsgsManager;

    std::vector<SafetyRegionData> mAgentSafetyRegionDatas;
    std::vector<FrenetDistanceMarker> mFrenetDistanceMarkers;
    std::vector<SpecMarker> mSpecMarkers;
    std::vector<VelocityMarker> mVelocityMarkers;
};

} // namespace measure {

#endif // #ifndef _MEASURE_VISUALIZER_H_
