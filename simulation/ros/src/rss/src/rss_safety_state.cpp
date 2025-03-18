#include <rss_safety_state.h>

namespace rss {

void ToSafetyStateMsg(
    const SafetyState &safetyState,
    rss_msgs::SafetyState &outputMsg)
{
    outputMsg.is_lateral_left_safe = safetyState.isLateralLeftSafe;
    outputMsg.is_lateral_right_safe = safetyState.isLateralRightSafe;
    outputMsg.is_longitudinal_safe = safetyState.isLongitudinalSafe;
}

} // namespace rss {
