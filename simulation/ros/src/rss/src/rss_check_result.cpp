#include <rss_check_result.h>

namespace rss {

void ToCheckResultMsg(
    const CheckResult &checkResult,
    rss_msgs::CheckResult &outputMsg)
{
    rss::ToCheckResultEgoVehicleStateMsg(
        checkResult.egoVehicleState,
        outputMsg.ego_vehicle_state);
    outputMsg.object_states.resize(checkResult.objectStates.size());
    auto objectMsg{outputMsg.object_states.begin()};
    auto objectState{checkResult.objectStates.cbegin()};
    for (; objectState != checkResult.objectStates.cend();
         ++objectMsg, ++objectState)
    {
        rss::ToCheckResultObjectStateMsg(
            *objectState,
            *objectMsg);
    }
}

} // namespace rss {
