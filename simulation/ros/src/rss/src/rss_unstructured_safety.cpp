#include <rss_unstructured_safety.h>

namespace rss {

void ToUnstructuredSafetyMsg(
    const UnstructuredSafety &unstructuredSafety,
    rss_msgs::UnstructuredSafety &outputMsg)
{
    outputMsg.status = static_cast<typename std::underlying_type<SafetyStatus>::type>(
        unstructuredSafety.status);
    outputMsg.response =
        static_cast<typename std::underlying_type<ad::rss::state::UnstructuredSceneResponse>::type>(
            unstructuredSafety.response);
    outputMsg.begin_heading_angle = unstructuredSafety.headingRange.begin;
    outputMsg.end_heading_angle = unstructuredSafety.headingRange.end;
    outputMsg.brake_trajectory_set.resize(unstructuredSafety.brakeTrajectorySet.size());
    std::transform(
        unstructuredSafety.brakeTrajectorySet.cbegin(),
        unstructuredSafety.brakeTrajectorySet.cend(),
        outputMsg.brake_trajectory_set.begin(),
        [](const geometry::Vector2d &input)
        {return input.ToPoint(double{0.0});});

    outputMsg.continue_forward_trajectory_set.resize(
        unstructuredSafety.continueForwardTrajectorySet.size());
    std::transform(
        unstructuredSafety.continueForwardTrajectorySet.cbegin(),
        unstructuredSafety.continueForwardTrajectorySet.cend(),
        outputMsg.continue_forward_trajectory_set.begin(),
        [](const geometry::Vector2d &input)
        {return input.ToPoint(double{0.0});});
}

} // namespace rss {
