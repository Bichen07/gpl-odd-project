#ifndef _MOTION_MOVE_TIRGGER_H_
#define _MOTION_MOVE_TIRGGER_H_

#include <memory>
#include <motion_move_trigger_condition.h>
#include <motion_move_trigger_state.h>

namespace motion {

class MoveTrigger final
{

public:

    typedef std::shared_ptr<MoveTrigger> Ptr;

    MoveTrigger();
    explicit MoveTrigger(const MoveTriggerCondition &moveTriggerCondition);
    MoveTrigger(const MoveTrigger &) = delete;
    MoveTrigger &operator=(const MoveTrigger &) = delete;
    virtual ~MoveTrigger() = default;

    bool operator()(const MoveTriggerState &state);
    geometry::Vector3d GetRefPosition() const;
    bool IsTriggered() const;

    void Configure(const MoveTriggerCondition &moveTriggerCondition);

protected:

private:

    MoveTriggerCondition mMoveTriggerCondition;
};

} // namespace motion {

#endif // #ifndef _MOTION_MOVE_TIRGGER_H_
