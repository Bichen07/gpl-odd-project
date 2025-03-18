#include <rss_unstructured_safety_corrector.h>
#include <ros/console.h>
#include <geometry_convex_hull_2d.h>
#include <geometry_utils.h>
#include <math_utils.h>

namespace rss {

// public func.

UnstructuredSafetyCorrector::UnstructuredSafetyCorrector()
{
}

bool UnstructuredSafetyCorrector::Execute(CheckResult &checkResult)
{
    static const bool canShowDebugMessage{false};
    bool hasCorrectedObjectUnstructuredSafety{false};
    if (checkResult.egoVehicleState.brakeTrajectorySet.empty())
    {
        for (auto objectState{checkResult.objectStates.begin()};
             objectState != checkResult.objectStates.end();
             ++objectState)
        {
            if (rss::SafetyStatus::Dangerous == objectState->unstructuredSafety.status)
            {
                ROS_DEBUG_STREAM_COND(
                    canShowDebugMessage,
                    "detectedObjectId: " << objectState->detectedObjectId << '\n' <<
                    "correct SafetyStatus" << '\n' <<
                    "original: " << objectState->unstructuredSafety.status << '\n' <<
                    "corrected: " << rss::SafetyStatus::Safe);
                objectState->unstructuredSafety.status = rss::SafetyStatus::Safe;
                hasCorrectedObjectUnstructuredSafety = true;
            }

            if (ad::rss::state::UnstructuredSceneResponse::Brake ==
                objectState->unstructuredSafety.response)
            {
                ROS_DEBUG_STREAM_COND(
                    canShowDebugMessage,
                    "detectedObjectId: " << objectState->detectedObjectId << '\n' <<
                    "correct UnsturcturedSceneResponse" << '\n' <<
                    "original: " << objectState->unstructuredSafety.response << '\n' <<
                    "corrected: " << ad::rss::state::UnstructuredSceneResponse::ContinueForward);
                objectState->unstructuredSafety.response =
                    ad::rss::state::UnstructuredSceneResponse::ContinueForward;
                hasCorrectedObjectUnstructuredSafety = true;
            }
        }

        return hasCorrectedObjectUnstructuredSafety;
    }

    std::vector<math::Vector2d_t> egoVehicleBrakeTrajectorySet(
        checkResult.egoVehicleState.brakeTrajectorySet.size());
    std::transform(
        checkResult.egoVehicleState.brakeTrajectorySet.cbegin(),
        checkResult.egoVehicleState.brakeTrajectorySet.cend(),
        egoVehicleBrakeTrajectorySet.begin(),
        [](const geometry::Vector2d &input)
        {return math::Vector2d_t(input);});
    const auto egoVehicleBrakeTrajectoryConvexHull = geometry::ConvexHull2d(
        egoVehicleBrakeTrajectorySet);
    for (auto objectState{checkResult.objectStates.begin()};
         objectState != checkResult.objectStates.end();
         ++objectState)
    {
        if (objectState->unstructuredSafety.brakeTrajectorySet.empty())
        {
            if (rss::SafetyStatus::Dangerous == objectState->unstructuredSafety.status)
            {
                ROS_DEBUG_STREAM_COND(
                    canShowDebugMessage,
                    "detectedObjectId: " << objectState->detectedObjectId << '\n' <<
                    "correct SafetyStatus" << '\n' <<
                    "original: " << objectState->unstructuredSafety.status << '\n' <<
                    "corrected: " << rss::SafetyStatus::Safe);
                objectState->unstructuredSafety.status = rss::SafetyStatus::Safe;
                hasCorrectedObjectUnstructuredSafety = true;
            }

            if (ad::rss::state::UnstructuredSceneResponse::Brake ==
                objectState->unstructuredSafety.response)
            {
                ROS_DEBUG_STREAM_COND(
                    canShowDebugMessage,
                    "detectedObjectId: " << objectState->detectedObjectId << '\n' <<
                    "correct UnsturcturedSceneResponse" << '\n' <<
                    "original: " << objectState->unstructuredSafety.response << '\n' <<
                    "corrected: " << ad::rss::state::UnstructuredSceneResponse::ContinueForward);
                objectState->unstructuredSafety.response =
                    ad::rss::state::UnstructuredSceneResponse::ContinueForward;
                hasCorrectedObjectUnstructuredSafety = true;
            }
            continue;
        }
        std::vector<math::Vector2d_t> objectBrakeTrajectorySet(
            objectState->unstructuredSafety.brakeTrajectorySet.size());
        std::transform(
            objectState->unstructuredSafety.brakeTrajectorySet.cbegin(),
            objectState->unstructuredSafety.brakeTrajectorySet.cend(),
            objectBrakeTrajectorySet.begin(), [](const geometry::Vector2d &input)
            {return math::Vector2d_t(input);});
        const auto objectBrakeTrajectoryConvexHull = geometry::ConvexHull2d(
            objectBrakeTrajectorySet);

        const math::real_t intersectionArea{
            geometry::ComputeIntersectionArea(
                egoVehicleBrakeTrajectoryConvexHull.GetPolygon(),
                objectBrakeTrajectoryConvexHull.GetPolygon())};
        if (math::IsApproxZero(intersectionArea, math::real_t{1.0e-3}))
        {
            if (rss::SafetyStatus::Dangerous == objectState->unstructuredSafety.status)
            {
                ROS_DEBUG_STREAM_COND(
                    false,
                    "correct SafetyStatus" << '\n' <<
                    "detectedObjectId: " << objectState->detectedObjectId << '\n' <<
                    "original: " << objectState->unstructuredSafety.status << '\n' <<
                    "corrected: " << rss::SafetyStatus::Safe);
                objectState->unstructuredSafety.status = rss::SafetyStatus::Safe;
                hasCorrectedObjectUnstructuredSafety = true;
            }

            if (ad::rss::state::UnstructuredSceneResponse::Brake ==
                objectState->unstructuredSafety.response)
            {
                ROS_DEBUG_STREAM_COND(
                    false,
                    "correct UnsturcturedSceneResponse" << '\n' <<
                    "detectedObjectId: " << objectState->detectedObjectId << '\n' <<
                    "original: " << objectState->unstructuredSafety.response << '\n' <<
                    "corrected: " << ad::rss::state::UnstructuredSceneResponse::ContinueForward);
                objectState->unstructuredSafety.response =
                    ad::rss::state::UnstructuredSceneResponse::ContinueForward;
                hasCorrectedObjectUnstructuredSafety = true;
            }
        }
    }

    return hasCorrectedObjectUnstructuredSafety;
}

// protected func.

// private func.

} // namespace rss {
