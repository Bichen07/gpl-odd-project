#include <motion_move_trigger.h>
#include <ros/console.h>

namespace motion {

// public func.

MoveTrigger::MoveTrigger()
    : mMoveTriggerCondition{}
{
}

MoveTrigger::MoveTrigger(const MoveTriggerCondition &moveTriggerCondition)
    : mMoveTriggerCondition{moveTriggerCondition}
{
}

bool MoveTrigger::operator()(const MoveTriggerState &state)
{
    bool isSatisfiedCondition{false};
    if (state.spatialRelationId != mMoveTriggerCondition.spatialRelationId)
    {
        return isSatisfiedCondition;
    }

    if (SpatialRelation::BehindEgoVehicle == state.spatialRelationId)
    {
        if (state.distance > mMoveTriggerCondition.distance)
        {
            isSatisfiedCondition = true;
        }
    }
    else if (SpatialRelation::AheadOfEgoVehicle == state.spatialRelationId)
    {
        if (state.distance < mMoveTriggerCondition.distance)
        {
            isSatisfiedCondition = true;
        }
    }
    else
    {
        ROS_WARN_STREAM("invalid " << state.spatialRelationId);
    }

    return isSatisfiedCondition;
}

geometry::Vector3d MoveTrigger::GetRefPosition() const
{
    return mMoveTriggerCondition.triggerRefPosition->Evaluate();
}

void MoveTrigger::Configure(const MoveTriggerCondition &moveTriggerCondition)
{
    mMoveTriggerCondition = moveTriggerCondition;
}

// protected func.

// private func.

} // namespace motion {
