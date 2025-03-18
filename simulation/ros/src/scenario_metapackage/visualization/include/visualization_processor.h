#ifndef _VISUALIZATION_PROCESSOR_H_
#define _VISUALIZATION_PROCESSOR_H_

#include <memory>
#include <map>
#include <ros/time.h>
#include <visualization_msgs/MarkerArray.h>
#include <utils_object_id_manager.h>

namespace visualization {

class Processor
{
    static const double DefaultLifetime()
    {return double{0.1};}
    static const double MaxMarkerElapsedSec()
    {return double{1.0};}

public:

    using Ptr = std::shared_ptr<Processor>;
    using MarkerIdManager = utils::ObjectIdManager<std::string, int32_t>;

    Processor();
    Processor(const Processor &) = delete;
    Processor &operator=(const Processor &) = delete;
    virtual ~Processor() = default;

protected:

    int32_t QueryMarkerId(const std::string &key);
    std::vector<visualization_msgs::Marker>::iterator
        QueryVisualizationMarker(
            visualization_msgs::MarkerArray &visMarkerArray,
            const int32_t queryMarkerId);
    void AddVisMarkerUpdateStatus(const int32_t markerId);
    void RecordVisMarkerUpdate(const int32_t markerId);
    void RemoveOutdatedVisMarkers(
        visualization_msgs::MarkerArray &outputVisualizationMsg);

    ros::Duration mDefaultLifetime;
    std::map<int32_t, double> mVisMarkerStampMap;

private:

};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_PROCESSOR_H_
