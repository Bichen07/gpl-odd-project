#ifndef _VISUALIZATION_AUXILIARY_PROCESSOR_H_
#define _VISUALIZATION_AUXILIARY_PROCESSOR_H_

#include <visualization_processor.h>
#include <scenario_msgs/LineStripMarkerArray.h>
#include <scenario_msgs/PointMarkerArray.h>
#include <scenario_msgs/TextMarkerArray.h>

namespace visualization {

class AuxiliaryProcessor final : public Processor
{

public:

    using Ptr = std::shared_ptr<AuxiliaryProcessor>;

    AuxiliaryProcessor();
    AuxiliaryProcessor(
        const AuxiliaryProcessor &) = delete;
    AuxiliaryProcessor &operator=(
        const AuxiliaryProcessor &) = delete;
    virtual ~AuxiliaryProcessor() = default;

    void Update(
        const ros::Time &stamp,
        const scenario_msgs::LineStripMarkerArray &lineStripMarkerArray,
        visualization_msgs::MarkerArray &outputVisualizationMsg);
    void Update(
        const ros::Time &stamp,
        const scenario_msgs::PointMarkerArray &pointMarkerArray,
        visualization_msgs::MarkerArray &outputVisualizationMsg);
    void Update(
        const ros::Time &stamp,
        const scenario_msgs::TextMarkerArray &textMarkerArray,
         visualization_msgs::MarkerArray &outputVisualizationMsg);

protected:

private:

};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_AUXILIARY_PROCESSOR_H_
