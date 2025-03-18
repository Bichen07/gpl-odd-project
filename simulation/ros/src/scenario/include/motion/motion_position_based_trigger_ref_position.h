#ifndef _MOTION_POSITION_BASED_TRIGGER_REF_POSITION_H_
#define _MOTION_POSITION_BASED_TRIGGER_REF_POSITION_H_

#include <motion_trigger_ref_position.h>

namespace motion {

class PositionBasedTriggerRefPosition final : public TriggerRefPosition
{

public:

    typedef std::shared_ptr<PositionBasedTriggerRefPosition> Ptr;

    PositionBasedTriggerRefPosition();
    explicit PositionBasedTriggerRefPosition(const geometry::Vector3d &refPosition);
    PositionBasedTriggerRefPosition(const PositionBasedTriggerRefPosition &) = delete;
    PositionBasedTriggerRefPosition &operator=(const PositionBasedTriggerRefPosition &) = delete;
    virtual ~PositionBasedTriggerRefPosition() = default;

    virtual TriggerRefPosition::TypeId GetTypeId() const override;
    virtual geometry::Vector3d Evaluate() override;

    void Configure(const geometry::Vector3d &refPosition);

protected:

private:

    geometry::Vector3d mRefPosition;
};

} // namespace motion {

#endif // #ifndef _MOTION_POSITION_BASED_TRIGGER_REF_POSITION_H_
