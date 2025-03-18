#include <rss_structured_safety.h>
#include <rss_safety_state.h>

namespace rss {

void ToStructuredSafetyMsg(
    const StructuredSafety &structuredSafety,
    rss_msgs::StructuredSafety &outputMsg)
{
    outputMsg.status = static_cast<typename std::underlying_type<SafetyStatus>::type>(
        structuredSafety.status);
    rss::ToSafetyStateMsg(
        structuredSafety.state,
        outputMsg.state);
}

} // namespace rss {
