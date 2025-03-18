#ifndef _UTILS_AUXILIARY_VISUALIZER_H_
#define _UTILS_AUXILIARY_VISUALIZER_H_

#include <memory>
#include <ros/ros.h>
#include <utils_line_strip_marker.h>
#include <utils_point_marker.h>
#include <utils_text_marker.h>

namespace utils {

class AuxiliaryVisualizer final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    AuxiliaryVisualizer();
    AuxiliaryVisualizer(const AuxiliaryVisualizer &) = delete;;
    AuxiliaryVisualizer &operator=(const AuxiliaryVisualizer &) = delete;
    virtual ~AuxiliaryVisualizer() = default;

    void AppendLineStripMarker(const LineStripMarker &marker);
    void AppendPointMarker(const PointMarker &marker);
    void AppendTextMarker(const TextMarker &marker);

    void Publish();

protected:

private:

    void PublishLineStripMarkers();
    void PublishPointMarkers();
    void PublishTextMarkers();

    ros::NodeHandle mNodeHandle;
    ros::Publisher mLineStripMarkerArrayPublisher;
    ros::Publisher mPointMarkerArrayPublisher;
    ros::Publisher mTextMarkerArrayPublisher;
    std::vector<LineStripMarker> mLineStripMarkers;
    std::vector<PointMarker> mPointMarkers;
    std::vector<TextMarker> mTextMarkers;
};

} // namespace utils {

#endif // #ifndef _UTILS_AUXILIARY_VISUALIZER_H_
