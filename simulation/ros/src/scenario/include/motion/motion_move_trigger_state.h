#ifndef _MOTIN_MOVE_TRIGGER_STATE_H_
#define _MOTIN_MOVE_TRIGGER_STATE_H_

#include <iostream>
#include <motion_spatial_relation_id.h>

namespace motion {

struct MoveTriggerState
{
    SpatialRelationId spatialRelationId;
    double distance;

    MoveTriggerState()
        : spatialRelationId{SpatialRelation::Null}
        , distance{0.0}
    {
    }
    MoveTriggerState(
        const SpatialRelationId &inputSpatialRelationId,
        const double inputDistance)
        : spatialRelationId{inputSpatialRelationId}
        , distance{inputDistance}
    {
    }
    MoveTriggerState(const MoveTriggerState &other) = default;
    MoveTriggerState &operator=(const MoveTriggerState &other) = default;
    ~MoveTriggerState() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const MoveTriggerState &state)
{
    ostream << "[motion::MoveTriggerState]" << '\n' <<
        state.spatialRelationId << '\n' <<
        "distance: " << state.distance;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTIN_MOVE_TRIGGER_STATE_H_
