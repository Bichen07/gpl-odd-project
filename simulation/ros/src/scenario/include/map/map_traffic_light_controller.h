#ifndef _MAP_TRAFFIC_LIGHT_CONTROLLER_H_
#define _MAP_TRAFFIC_LIGHT_CONTROLLER_H_

#include <std_msgs/ColorRGBA.h>
#include <map_traffic_light_state.h>

namespace map {

class TrafficLightController final
{

public:

    TrafficLightController();
    TrafficLightController(const TrafficLightController &) = delete;
    TrafficLightController &operator=(const TrafficLightController &) = delete;
    virtual ~TrafficLightController() = default;

    void ComputeUpdatedSignal(
        const TrafficLightStateId &stateId,
        std_msgs::ColorRGBA &redLight,
        std_msgs::ColorRGBA &yellowLight,
        std_msgs::ColorRGBA &greenLight);

protected:

private:

    bool IsFlashingState(const TrafficLightStateId &stateId) const;

    TrafficLightStateId mPreviousStateId;
    double mPreviousSeconds;
    bool mIsFlashingOn;
};

} // namespace map {

#endif // #ifndef _MAP_TRAFFIC_LIGHT_CONTROLLER_H_
