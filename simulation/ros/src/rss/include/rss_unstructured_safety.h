#ifndef _RSS_UNSTRUCTURED_SAFETY_H_
#define _RSS_UNSTRUCTURED_SAFETY_H_

#include <vector>
#include <ad/rss/state/HeadingRange.hpp>
#include <ad/rss/state/UnstructuredSceneResponse.hpp>
#include <rss_msgs/UnstructuredSafety.h>
#include <geometry_vector_2d.h>
#include <rss_safety_status.h>

namespace rss {

struct UnstructuredSafety
{
    SafetyStatus status;
    ad::rss::state::UnstructuredSceneResponse response;
    ad::rss::state::HeadingRange headingRange;
    std::vector<geometry::Vector2d> brakeTrajectorySet;
    std::vector<geometry::Vector2d> continueForwardTrajectorySet;

    UnstructuredSafety()
        : status{SafetyStatus::Null}
        , response{ad::rss::state::UnstructuredSceneResponse::None}
        , headingRange{}
        , brakeTrajectorySet{}
        , continueForwardTrajectorySet{}
    {
    }
    explicit UnstructuredSafety(
        const SafetyStatus &inputStatus,
        const ad::rss::state::UnstructuredSceneResponse &inputResponse,
        const ad::rss::state::HeadingRange &inputHeadingRange,
        const std::vector<geometry::Vector2d> &inputBrakeTrajectorySet,
        const std::vector<geometry::Vector2d> &inputContinueForwardTrajectorySet)
        : status{inputStatus}
        , response{inputResponse}
        , headingRange{inputHeadingRange}
        , brakeTrajectorySet{inputBrakeTrajectorySet}
        , continueForwardTrajectorySet{inputContinueForwardTrajectorySet}
    {
    }
    UnstructuredSafety(const UnstructuredSafety &other) = default;
    UnstructuredSafety &operator=(const UnstructuredSafety &other) = default;
    ~UnstructuredSafety() = default;
};

void ToUnstructuredSafetyMsg(
    const UnstructuredSafety &unstructuredSafety,
    rss_msgs::UnstructuredSafety &outputMsg);

} // namespace rss {


#endif // #ifndef _RSS_UNSTRUCTURED_SAFETY_H_
