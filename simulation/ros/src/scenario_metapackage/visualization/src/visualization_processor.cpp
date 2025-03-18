#include <visualization_processor.h>

namespace visualization {

// public func.

Processor::Processor()
    : mDefaultLifetime{DefaultLifetime()}
    , mVisMarkerStampMap{}
{
}

// protected func.

int32_t Processor::QueryMarkerId(const std::string &key)
{
    static MarkerIdManager markerIdManager;
    if (!markerIdManager.IsInitialized())
    {
        markerIdManager.Configure(
            MarkerIdManager::IdType_t{1001},
            std::numeric_limits<MarkerIdManager::IdType_t>::max());
    }

    return markerIdManager.QueryId(key);
}

std::vector<visualization_msgs::Marker>::iterator
    Processor::QueryVisualizationMarker(
        visualization_msgs::MarkerArray &visMarkerArray,
        const int32_t queryMarkerId)
{
    std::vector<visualization_msgs::Marker>::iterator foundVisMsg =
        std::find_if(
            visMarkerArray.markers.begin(),
            visMarkerArray.markers.end(),
            [&queryMarkerId](const visualization_msgs::Marker &visMarker)
            {return visMarker.id == queryMarkerId;});

    return foundVisMsg;
}

void Processor::AddVisMarkerUpdateStatus(const int32_t markerId)
{
    if (!mVisMarkerStampMap.emplace(markerId, ros::Time::now().toSec()).second)
    {
        ROS_WARN_STREAM("duplicaed markerId: " << markerId);
    }
}

void Processor::RecordVisMarkerUpdate(const int32_t markerId)
{
    auto foundPair{mVisMarkerStampMap.find(markerId)};
    if (mVisMarkerStampMap.end() == foundPair)
    {
        ROS_WARN_STREAM("no matched markerId: " << markerId);
        return;
    }

    foundPair->second = ros::Time::now().toSec();
}

void Processor::RemoveOutdatedVisMarkers(
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    const double currentSec{ros::Time::now().toSec()};
    std::vector<int32_t> outdatedMarkerIds;
    outdatedMarkerIds.reserve(outputVisualizationMsg.markers.size());
    for (auto visMarkerStampPair{mVisMarkerStampMap.begin()};
         visMarkerStampPair != mVisMarkerStampMap.end();
         ++visMarkerStampPair)
    {
        const double elapsedSec = currentSec - visMarkerStampPair->second;
        if (elapsedSec > MaxMarkerElapsedSec())
        {
            auto foundVisMarker = std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&visMarkerStampPair](const visualization_msgs::Marker &visMarker)
                {return visMarker.id == visMarkerStampPair->first;});
            if (outputVisualizationMsg.markers.end() != foundVisMarker)
            {
                outdatedMarkerIds.push_back(visMarkerStampPair->first);
                outputVisualizationMsg.markers.erase(foundVisMarker);
            }
            else
            {
                ROS_WARN_STREAM(
                    "no matched markerId: " << visMarkerStampPair->first);
            }
        }
    }

    for (auto outdatedMarkerId{outdatedMarkerIds.cbegin()};
         outdatedMarkerId != outdatedMarkerIds.cend();
         ++outdatedMarkerId)
    {
        mVisMarkerStampMap.erase(*outdatedMarkerId);
    }
}

// private func.

} // namespace visualization {
