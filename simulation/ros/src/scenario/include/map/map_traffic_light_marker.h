#ifndef _MAP_TRAFFIC_LIGHT_MARKER_H_
#define _MAP_TRAFFIC_LIGHT_MARKER_H_

#include <math_type.h>
#include <map_traffic_light_state.h>

namespace map {

struct TrafficLightMarker final
{
    math::HomoXfm3d_t pose;
    TrafficLightStateId state;

    TrafficLightMarker()
        : pose{math::HomoXfm3d_t::Identity()}
        , state{TrafficLightState::Null}
    {
    }
    TrafficLightMarker(
        const math::HomoXfm3d_t &inputPose,
        const TrafficLightStateId &inputState)
        : pose{inputPose}
        , state{inputState}
    {
    }
    TrafficLightMarker(const TrafficLightMarker &other) = default;
    TrafficLightMarker &operator=(const TrafficLightMarker &other) = default;
    ~TrafficLightMarker() = default;
};

} // namespace map {

#endif // #ifndef _MAP_TRAFFIC_LIGHT_MARKER_H_
