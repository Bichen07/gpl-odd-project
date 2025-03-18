#ifndef _RSS_CHECK_RESULT_EGO_VEHICLE_STATE_H_
#define _RSS_CHECK_RESULT_EGO_VEHICLE_STATE_H_

#include <vector>
#include <rss_msgs/CheckResultEgoVehicleState.h>
#include <geometry_transform_3d.h>
#include <geometry_vector_2d.h>

namespace rss
{

    struct CheckResultEgoVehicleState final
    {
        geometry::Transform3d           transform;
        std::vector<geometry::Vector2d> brakeTrajectorySet;
        std::vector<geometry::Vector2d> continueForwardTrajectorySet;
        float                           speedLon;
        float                           speedLat;

        CheckResultEgoVehicleState() : transform{}, brakeTrajectorySet{}, continueForwardTrajectorySet{}
        {
        }
        explicit CheckResultEgoVehicleState(const geometry::Transform3d           &inputTransform,
                                            const std::vector<geometry::Vector2d> &inputBrakeTrajectorySet,
                                            const std::vector<geometry::Vector2d> &inputContinueForwardTrajectorySet)
            : transform{inputTransform},
              brakeTrajectorySet{inputBrakeTrajectorySet},
              continueForwardTrajectorySet{inputContinueForwardTrajectorySet}
        {
        }
        CheckResultEgoVehicleState(const CheckResultEgoVehicleState &)            = default;
        CheckResultEgoVehicleState &operator=(const CheckResultEgoVehicleState &) = default;
        virtual ~CheckResultEgoVehicleState()                                     = default;
    };

    void ToCheckResultEgoVehicleStateMsg(const CheckResultEgoVehicleState &egoVehicleState, rss_msgs::CheckResultEgoVehicleState &outputMsg);

    template <typename charT, typename traits>
    std::basic_ostream<charT, traits> &operator<<(std::basic_ostream<charT, traits> &ostream, const CheckResultEgoVehicleState &state)
    {
        ostream << "[CheckResultEgoVehicleState]" << '\n' << "transform: " << state.transform;
        return ostream;
    }

}  // namespace rss

#endif  // #ifndef _RSS_CHECK_RESULT_EGO_VEHICLE_STATE_H_
