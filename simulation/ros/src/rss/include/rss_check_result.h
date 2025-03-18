#ifndef _RSS_CHECK_RESULT_H_
#define _RSS_CHECK_RESULT_H_

#include <vector>
#include <rss_msgs/CheckResult.h>
#include <rss_check_result_ego_vehicle_state.h>
#include <rss_check_result_object_state.h>
#include <geometry_vector_3d.h>

namespace rss {

struct CheckResult final
{
    CheckResultEgoVehicleState egoVehicleState;
    std::vector<CheckResultObjectState> objectStates;

    CheckResult()
        : egoVehicleState{}
        , objectStates{}
    {
    }
    explicit CheckResult(
        const CheckResultEgoVehicleState &inputEgoVehicleState,
        const std::vector<CheckResultObjectState> &inputObjectStates)
        : egoVehicleState{inputEgoVehicleState}
        , objectStates{inputObjectStates}
    {
    }
    CheckResult(const CheckResult &) = default;
    CheckResult &operator=(const CheckResult &) = default;
    virtual ~CheckResult() = default;
};

void ToCheckResultMsg(
    const CheckResult &checkResult,
    rss_msgs::CheckResult &outputMsg);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const CheckResult &checkResult)
{
    ostream << "[CheckResult]" << '\n' <<
        "egoVehicleState" << '\n' <<
        checkResult.egoVehicleState << '\n' <<
        "objectStates" << std::endl;
    std::copy(
        checkResult.objectStates.cbegin(),
        checkResult.objectStates.cend(),
        std::ostream_iterator<CheckResultObjectState>(ostream));
    return ostream;
}

} // namespace rss {

#endif // #ifndef _RSS_CHECK_RESULT_H_
