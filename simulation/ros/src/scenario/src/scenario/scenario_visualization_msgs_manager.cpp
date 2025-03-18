#include <scenario_visualization_msgs_manager.h>
#include <limits>

namespace scenario {

// public func.

VisualizationMsgsManager::VisualizationMsgsManager()
    : mNodeHandle{}
    , mMarkerArrayPublisher{}
    , mMarkerIdManager{}
{
    mMarkerArrayPublisher = mNodeHandle.advertise<visualization_msgs::MarkerArray>(
        "scenario_visualization",
        DefaultQueueSize());

    constexpr int32_t markerBeginId{1001};
    mMarkerIdManager.Configure(
        markerBeginId,
        std::numeric_limits<int32_t>::max());
}

void VisualizationMsgsManager::Reset()
{
    constexpr int32_t markerBeginId{1001};
    mMarkerIdManager.Configure(
        markerBeginId,
        std::numeric_limits<int32_t>::max());
}

void VisualizationMsgsManager::Publish(const visualization_msgs::Marker &marker)
{
    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.reserve(1ul);
    markerArray.markers.push_back(marker);
    mMarkerArrayPublisher.publish(markerArray);
}

void VisualizationMsgsManager::Publish(const visualization_msgs::MarkerArray &markerArray)
{
    mMarkerArrayPublisher.publish(markerArray);
}

int32_t VisualizationMsgsManager::QueryMarkerId(const std::string &objectId)
{
    return mMarkerIdManager.QueryMarkerId(objectId);
}

// protrected func.

// private func.

} // namespace scenario {
