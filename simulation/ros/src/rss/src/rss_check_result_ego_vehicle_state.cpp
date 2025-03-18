#include <rss_check_result_ego_vehicle_state.h>
#include <algorithm>

namespace rss
{

    void ToCheckResultEgoVehicleStateMsg(const CheckResultEgoVehicleState &egoVehicleState, rss_msgs::CheckResultEgoVehicleState &outputMsg)
    {
        outputMsg.speedLon = egoVehicleState.speedLon;
        outputMsg.speedLat = egoVehicleState.speedLat;
        outputMsg.brake_trajectory_set.resize(egoVehicleState.brakeTrajectorySet.size());
        std::transform(egoVehicleState.brakeTrajectorySet.cbegin(),
                       egoVehicleState.brakeTrajectorySet.cend(),
                       outputMsg.brake_trajectory_set.begin(),
                       [](const geometry::Vector2d &input) { return input.ToPoint(double{0.0}); });
        outputMsg.continue_forward_trajectory_set.resize(egoVehicleState.continueForwardTrajectorySet.size());
        std::transform(egoVehicleState.continueForwardTrajectorySet.cbegin(),
                       egoVehicleState.continueForwardTrajectorySet.cend(),
                       outputMsg.continue_forward_trajectory_set.begin(),
                       [](const geometry::Vector2d &input) { return input.ToPoint(double{0.0}); });
    }

}  // namespace rss
