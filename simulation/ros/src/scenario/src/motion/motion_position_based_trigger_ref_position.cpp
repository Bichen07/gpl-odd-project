#include <motion_position_based_trigger_ref_position.h>

namespace motion {

// public func.

PositionBasedTriggerRefPosition::PositionBasedTriggerRefPosition()
    : TriggerRefPosition()
    , mRefPosition{}
{
}

PositionBasedTriggerRefPosition::PositionBasedTriggerRefPosition(const geometry::Vector3d &refPosition)
    : TriggerRefPosition()
    , mRefPosition{refPosition}
{
}

TriggerRefPosition::TypeId PositionBasedTriggerRefPosition::GetTypeId() const
{
    return TriggerRefPosition::Type::PositionBased;
}

geometry::Vector3d PositionBasedTriggerRefPosition::Evaluate()
{
    return mRefPosition;
}

void PositionBasedTriggerRefPosition::Configure(const geometry::Vector3d &refPosition)
{
    mRefPosition = refPosition;
}

// protected func.

// private func.

} // namespace motion {
