#ifndef _MOTION_MOVE_TRIGGER_CONDITION_H_
#define _MOTION_MOVE_TRIGGER_CONDITION_H_

#include <memory>
#include <iostream>
#include <jsoncpp/json/json.h>
#include <motion_spatial_relation_id.h>
#include <motion_trigger_ref_position.h>

namespace motion {

struct MoveTriggerCondition
{
    TriggerRefPosition::Ptr triggerRefPosition;
    SpatialRelationId spatialRelationId;
    double distance;

    MoveTriggerCondition()
        : triggerRefPosition{nullptr}
        , spatialRelationId{SpatialRelation::Null}
        , distance{0.0}
    {
    }
    MoveTriggerCondition(
        const TriggerRefPosition::Ptr &inputTriggerRefPosition,
        const SpatialRelationId &inputSpatialRelationId,
        const double inputDistance)
        : triggerRefPosition{inputTriggerRefPosition}
        , spatialRelationId{inputSpatialRelationId}
        , distance{inputDistance}
    {
    }
    MoveTriggerCondition(const MoveTriggerCondition &other) = default;
    MoveTriggerCondition &operator=(const MoveTriggerCondition &other) = default;
    virtual ~MoveTriggerCondition() = default;
};

void ParseMoveTriggerCondition(
    const Json::Value &configJsonValue,
    MoveTriggerCondition &outputCondition);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const MoveTriggerCondition &condition)
{
    ostream << "[motion::MoveTriggerCondition]" << '\n';
    if (condition.triggerRefPosition)
    {
        ostream << condition.triggerRefPosition->GetTypeId() << '\n' <<
            condition.triggerRefPosition->Evaluate().transpose() << '\n';
    }
    else
    {
        ostream << TriggerRefPosition::Type::Null << '\n';
    }
    ostream << condition.spatialRelationId << '\n' <<
        "distance: " << condition.distance;

    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_MOVE_TRIGGER_CONDITION_H_
