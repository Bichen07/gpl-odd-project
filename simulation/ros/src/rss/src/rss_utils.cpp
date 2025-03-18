#include <rss_utils.h>
#include <ros/console.h>
#include <map>
#include <iomanip>
#include "scenario/AgentState.h"
#include <math_utils.h>
#include <utils_converter.h>
#include <utils_default_color.h>
#include <geometry_utils.h>
#include <rss_converter.h>
#include <rss_rss_object_integrator.h>

namespace rss
{

    SafetyState EvaluateSceneSafetyState(const ad::rss::state::RssStateSnapshot &rssSnapshot)
    {
        SafetyState outputSafetyState(true, true, true);
        for (auto individualResponse{rssSnapshot.individualResponses.cbegin()}; individualResponse != rssSnapshot.individualResponses.cend();
             ++individualResponse)
        {
            if (!individualResponse->lateralStateLeft.isSafe)
            {
                outputSafetyState.isLateralLeftSafe = individualResponse->lateralStateLeft.isSafe;
            }

            if (!individualResponse->lateralStateRight.isSafe)
            {
                outputSafetyState.isLateralRightSafe = individualResponse->lateralStateRight.isSafe;
            }

            if (!individualResponse->longitudinalState.isSafe)
            {
                outputSafetyState.isLongitudinalSafe = individualResponse->longitudinalState.isSafe;
            }
        }

        return outputSafetyState;
    }

    SafetyStatus EvaluateSafetyStatus(const ad::rss::state::RssState &rssState)
    {
        SafetyStatus outputStatus{SafetyStatus::Null};
        const bool   isLateralSafe = rssState.lateralStateLeft.isSafe && rssState.lateralStateRight.isSafe;
        if (isLateralSafe && rssState.longitudinalState.isSafe)
        {
            outputStatus = SafetyStatus::Safe;
        }
        else if (!isLateralSafe && !rssState.longitudinalState.isSafe)
        {
            outputStatus = SafetyStatus::Dangerous;
        }
        else
        {
            outputStatus = SafetyStatus::Warning;
        }

        return outputStatus;
    }

    SafetyState EvaluateSafetyState(const ad::rss::state::RssState &rssState)
    {
        SafetyState outputSafetyState;
        outputSafetyState.isLateralLeftSafe  = rssState.lateralStateLeft.isSafe;
        outputSafetyState.isLateralRightSafe = rssState.lateralStateRight.isSafe;
        outputSafetyState.isLongitudinalSafe = rssState.longitudinalState.isSafe;

        return outputSafetyState;
    }

    void EvaluateStructuredSafety(const ad::rss::state::RssState &rssState, StructuredSafety &outputSafety)
    {
        outputSafety.status = rss::EvaluateSafetyStatus(rssState);
        outputSafety.state  = rss::EvaluateSafetyState(rssState);
    }

    void EvaluateUnstructuredSafety(const scenario::AgentState     &agentState,
                                    const ad::rss::state::RssState &rssState,
                                    UnstructuredSafety             &outputSafety)
    {
        // std::cout << "evaluate unstructuredSafety AS first line" << std::endl;

        outputSafety.status       = rssState.unstructuredSceneState.isSafe ? SafetyStatus::Safe : SafetyStatus::Dangerous;
        outputSafety.response     = rssState.unstructuredSceneState.response;
        outputSafety.headingRange = rssState.unstructuredSceneState.headingRange;

        // std::cout << "to geometry vector2d" << std::endl;
        rss::ToGeometryVector2ds(rssState.unstructuredSceneState.rssStateInformation.brakeTrajectorySet, outputSafety.brakeTrajectorySet);
        rss::ToGeometryVector2ds(rssState.unstructuredSceneState.rssStateInformation.continueForwardTrajectorySet,
                                 outputSafety.continueForwardTrajectorySet);
        // std::cout << "complete to geometry vector2d" << std::endl;

        static constexpr math::real_t speedEpsilon{1.0e-1};
        static const math::real_t     maxRadianDiff{math::ToRadian(math::real_t{15.0})};
        const bool                    isApproxStationary{math::IsApproxZero(agentState.speed, speedEpsilon)};
        const geometry::Vector2d      objectForwardVector = geometry::Vector3d(sin(agentState.h), cos(agentState.h), 0).ToVectorXy();

        if (!outputSafety.brakeTrajectorySet.empty() && isApproxStationary)
        {
            const auto brakeTrajectorySetVector{
                rss::ComputeTrajectorySetForwardVector(outputSafety.brakeTrajectorySet, math::Vector3d_t(agentState.x, agentState.y, agentState.z))};
            const auto brakeTrajectorySetAngleDiff{math::ComputeRotationalAngle(brakeTrajectorySetVector, objectForwardVector)};
            if (std::fabs(brakeTrajectorySetAngleDiff) > maxRadianDiff)
            {
                rss::TransformTrajectorySet(agentState, outputSafety.brakeTrajectorySet);
            }
        }
        if (!outputSafety.continueForwardTrajectorySet.empty() && isApproxStationary)
        {
            const auto continueForwardTrajectorySetVector{
                rss::ComputeTrajectorySetForwardVector(outputSafety.continueForwardTrajectorySet,
                                                       math::Vector3d_t(agentState.x, agentState.y, agentState.z))};
            const auto continueForwardTrajectorySetAngleDiff{math::ComputeRotationalAngle(continueForwardTrajectorySetVector, objectForwardVector)};
            if (std::fabs(continueForwardTrajectorySetAngleDiff) > maxRadianDiff)
            {
                rss::TransformTrajectorySet(agentState, outputSafety.continueForwardTrajectorySet);
            }
        }
    }

    void EvaluateUnstructuredSafety(const ObjectInputParam         &objectInputParam,
                                    const ad::rss::state::RssState &rssState,
                                    UnstructuredSafety             &outputSafety)
    {
        outputSafety.status       = rssState.unstructuredSceneState.isSafe ? SafetyStatus::Safe : SafetyStatus::Dangerous;
        outputSafety.response     = rssState.unstructuredSceneState.response;
        outputSafety.headingRange = rssState.unstructuredSceneState.headingRange;

        rss::ToGeometryVector2ds(rssState.unstructuredSceneState.rssStateInformation.brakeTrajectorySet, outputSafety.brakeTrajectorySet);
        rss::ToGeometryVector2ds(rssState.unstructuredSceneState.rssStateInformation.continueForwardTrajectorySet,
                                 outputSafety.continueForwardTrajectorySet);

        static constexpr math::real_t speedEpsilon{1.0e-1};
        static const math::real_t     maxRadianDiff{math::ToRadian(math::real_t{15.0})};
        const bool                    isApproxStationary{math::IsApproxZero(objectInputParam.linearVelocity.norm(), speedEpsilon)};
        const geometry::Vector2d      objectForwardVector = geometry::Vector3d(objectInputParam.transform.linear().col(0)).ToVectorXy();

        if (!outputSafety.brakeTrajectorySet.empty() && isApproxStationary)
        {
            const auto brakeTrajectorySetVector{
                rss::ComputeTrajectorySetForwardVector(outputSafety.brakeTrajectorySet, objectInputParam.transform.GetPosition())};
            const auto brakeTrajectorySetAngleDiff{math::ComputeRotationalAngle(brakeTrajectorySetVector, objectForwardVector)};
            if (std::fabs(brakeTrajectorySetAngleDiff) > maxRadianDiff)
            {
                rss::TransformTrajectorySet(objectInputParam.transform, outputSafety.brakeTrajectorySet);
            }
        }

        if (!outputSafety.continueForwardTrajectorySet.empty() && isApproxStationary)
        {
            const auto continueForwardTrajectorySetVector{
                rss::ComputeTrajectorySetForwardVector(outputSafety.continueForwardTrajectorySet, objectInputParam.transform.GetPosition())};
            const auto continueForwardTrajectorySetAngleDiff{math::ComputeRotationalAngle(continueForwardTrajectorySetVector, objectForwardVector)};
            if (std::fabs(continueForwardTrajectorySetAngleDiff) > maxRadianDiff)
            {
                rss::TransformTrajectorySet(objectInputParam.transform, outputSafety.continueForwardTrajectorySet);
            }
        }
    }

    void EvaluateCheckResult(const ad::rss::situation::SituationSnapshot                &situationSnapshot,
                             const ad::rss::state::RssStateSnapshot                     &rssStateSnapshot,
                             const EgoVehicleInputParam                                 &egoVehicleInputParam,
                             const std::map<ad::rss::world::ObjectId, ObjectInputParam> &objectInputParamMap,
                             CheckResult                                                &outputCheckResult)
    {
        // std::cout << "Evaluate CheckResultEgoVehicleState" << std::endl;
        rss::EvaluateCheckResultEgoVehicleState(egoVehicleInputParam, rssStateSnapshot, outputCheckResult.egoVehicleState);
        // std::cout << "Finish Evaluate CheckResultEgoVehicleState" << std::endl;
        // std::cout << "Evaluate CheckResult ObjectStates" << std::endl;
        rss::EvaluateCheckResultObjectStates(situationSnapshot, rssStateSnapshot, objectInputParamMap, outputCheckResult.objectStates);
        // std::cout << "Finish Evaluate ObjectStates" << std::endl;
    }

    void EvaluateCheckResultForAS(const ad::rss::situation::SituationSnapshot                    &situationSnapshot,
                                  const ad::rss::state::RssStateSnapshot                         &rssStateSnapshot,
                                  const EgoVehicleInputParam                                     &egoVehicleInputParam,
                                  const std::map<ad::rss::world::ObjectId, scenario::AgentState> &objectInputParamMap,
                                  std::map<std::string, ad::rss::world::Object>                  &rssWorldObjectMap,
                                  CheckResult                                                    &outputCheckResult)
    {
        rss::EvaluateCheckResultEgoVehicleState(egoVehicleInputParam, rssStateSnapshot, outputCheckResult.egoVehicleState);
        // std::cout << "Finish Evaluate CheckResultEgoVehicleState AS" << std::endl;
        // std::cout << "Evaluate CheckResult ObjectStates AS" << std::endl;
        rss::EvaluateCheckResultObjectStatesForAS(situationSnapshot,
                                                  rssStateSnapshot,
                                                  objectInputParamMap,
                                                  rssWorldObjectMap,
                                                  outputCheckResult.objectStates);
        // std::cout << "Finish Evaluate ObjectStates AS" << std::endl;
    }

    void EvaluateCheckResultEgoVehicleState(const EgoVehicleInputParam             &egoVehicleInputParam,
                                            const ad::rss::state::RssStateSnapshot &rssStateSnapshot,
                                            CheckResultEgoVehicleState             &outputEgoVehicleState)
    {
        outputEgoVehicleState.transform = egoVehicleInputParam.transform;
        rss::ToGeometryVector2ds(rssStateSnapshot.unstructuredSceneEgoInformation.brakeTrajectorySet, outputEgoVehicleState.brakeTrajectorySet);
        rss::ToGeometryVector2ds(rssStateSnapshot.unstructuredSceneEgoInformation.continueForwardTrajectorySet,
                                 outputEgoVehicleState.continueForwardTrajectorySet);

        static constexpr math::real_t speedEpsilon{1.0e-1};
        static const math::real_t     maxRadianDiff{math::ToRadian(math::real_t{15.0})};
        const bool                    isApproxStationary{math::IsApproxZero(egoVehicleInputParam.linearVelocity.norm(), speedEpsilon)};
        const geometry::Vector2d      egoVehicleForwardVector = geometry::Vector3d(outputEgoVehicleState.transform.linear().col(0)).ToVectorXy();

        if (!outputEgoVehicleState.brakeTrajectorySet.empty() && isApproxStationary)
        {
            const auto brakeTrajectorySetVector{
                rss::ComputeTrajectorySetForwardVector(outputEgoVehicleState.brakeTrajectorySet, outputEgoVehicleState.transform.GetPosition())};
            const auto brakeTrajectorySetAngleDiff{math::ComputeRotationalAngle(brakeTrajectorySetVector, egoVehicleForwardVector)};
            if (std::fabs(brakeTrajectorySetAngleDiff) > maxRadianDiff)
            {
                rss::TransformTrajectorySet(egoVehicleInputParam.transform, outputEgoVehicleState.brakeTrajectorySet);
            }
        }

        if (!outputEgoVehicleState.continueForwardTrajectorySet.empty() && isApproxStationary)
        {
            const auto continueForwardTrajectorySetVector{rss::ComputeTrajectorySetForwardVector(outputEgoVehicleState.continueForwardTrajectorySet,
                                                                                                 outputEgoVehicleState.transform.GetPosition())};
            const auto continueForwardTrajectorySetAngleDiff{
                math::ComputeRotationalAngle(continueForwardTrajectorySetVector, egoVehicleForwardVector)};
            if (std::fabs(continueForwardTrajectorySetAngleDiff) > maxRadianDiff)
            {
                rss::TransformTrajectorySet(egoVehicleInputParam.transform, outputEgoVehicleState.continueForwardTrajectorySet);
            }
        }
    }

    void EvaluateCheckResultObjectStates(const ad::rss::situation::SituationSnapshot                &situationSnapshot,
                                         const ad::rss::state::RssStateSnapshot                     &rssStateSnapshot,
                                         const std::map<ad::rss::world::ObjectId, ObjectInputParam> &objectInputParamMap,
                                         std::vector<CheckResultObjectState>                        &outputObjectStates)
    {
        // std::cout << "in EvaluateCheckResultObjectStates first line..." << std::endl;
        if (situationSnapshot.situations.size() != rssStateSnapshot.individualResponses.size())
        {
            ROS_ERROR_STREAM("diff. object size b/t situationSnapshot and rssStateSnapshot"
                             << '\n'
                             << "situationSnapshot: " << situationSnapshot.situations.size() << '\n'
                             << "rssStateSnapshot: " << rssStateSnapshot.individualResponses.size());
        }

        // std::cout << "rssObjectIntegrator compute..." << std::endl;
        rss::RssObjectIntegrator            rssObjectIntegrator;
        ad::rss::situation::SituationVector uniqueSituations;
        ad::rss::state::RssStateVector      uniqueRssStates;
        rssObjectIntegrator.Compute(situationSnapshot.situations, rssStateSnapshot.individualResponses, uniqueSituations, uniqueRssStates);
        // std::cout << "compute complete" << std::endl;

        // std::cout << "unique situations sizes" << std::endl;
        std::cout << uniqueSituations.size() << std::endl;
        // std::cout << "unique rss states sizes" << std::endl;
        std::cout << uniqueRssStates.size() << std::endl;

        outputObjectStates.resize(uniqueSituations.size());
        auto outputObjectState{outputObjectStates.begin()};
        auto uniqueSituation{uniqueSituations.cbegin()};
        auto uniqueRssState{uniqueRssStates.cbegin()};
        for (; uniqueRssState != uniqueRssStates.cend(); ++outputObjectState, ++uniqueSituation, ++uniqueRssState)
        {
            const auto rssObjectId = uniqueRssState->objectId;
            // outputObjectState->detectedObjectId = objectInputParamMap.at(rssObjectId).detectedObjectId;
            // std::cout << "evaluate strucuted safety" << std::endl;
            rss::EvaluateStructuredSafety(*uniqueRssState, outputObjectState->structuredSafety);
            // std::cout << "complete evaluate strucuted safety" << std::endl;
            // std::cout << "evaluate unstrucuted safety" << std::endl;
            rss::EvaluateUnstructuredSafety(objectInputParamMap.at(rssObjectId), *uniqueRssState, outputObjectState->unstructuredSafety);
            // std::cout << "complete evaluate unstrucuted safety" << std::endl;
            // outputObjectState->transform     = objectInputParamMap.at(rssObjectId).transform;
            // outputObjectState->objectClassId = objectInputParamMap.at(rssObjectId).objectClassId;
            outputObjectState->rssSituation = *uniqueSituation;
            outputObjectState->rssState     = *uniqueRssState;
        }
    }

    void EvaluateCheckResultObjectStatesForAS(const ad::rss::situation::SituationSnapshot                    &situationSnapshot,
                                              const ad::rss::state::RssStateSnapshot                         &rssStateSnapshot,
                                              const std::map<ad::rss::world::ObjectId, scenario::AgentState> &objectInputParamMap,
                                              std::map<std::string, ad::rss::world::Object>                  &rssWorldObjectMap,
                                              std::vector<CheckResultObjectState>                            &outputObjectStates)
    {
        // std::cout << "in EvaluateCheckResultObjectStates AS first line..." << std::endl;
        if (situationSnapshot.situations.size() != rssStateSnapshot.individualResponses.size())
        {
            ROS_ERROR_STREAM("diff. object size b/t situationSnapshot and rssStateSnapshot"
                             << '\n'
                             << "situationSnapshot: " << situationSnapshot.situations.size() << '\n'
                             << "rssStateSnapshot: " << rssStateSnapshot.individualResponses.size());
        }

        // std::cout << "rssObjectIntegrator compute..." << std::endl;
        rss::RssObjectIntegrator            rssObjectIntegrator;
        ad::rss::situation::SituationVector uniqueSituations;
        ad::rss::state::RssStateVector      uniqueRssStates;
        rssObjectIntegrator.Compute(situationSnapshot.situations, rssStateSnapshot.individualResponses, uniqueSituations, uniqueRssStates);
        // std::cout << "compute complete" << std::endl;

        // std::cout << "unique situations sizes" << std::endl;
        // std::cout << uniqueSituations.size() << std::endl;
        // std::cout << "unique rss states sizes" << std::endl;
        // std::cout << uniqueRssStates.size() << std::endl;

        outputObjectStates.resize(uniqueSituations.size());
        auto outputObjectState{outputObjectStates.begin()};
        auto uniqueSituation{uniqueSituations.cbegin()};
        auto uniqueRssState{uniqueRssStates.cbegin()};
        for (; uniqueRssState != uniqueRssStates.cend(); ++outputObjectState, ++uniqueSituation, ++uniqueRssState)
        {
            const auto rssObjectId = uniqueRssState->objectId;
            // outputObjectState->detectedObjectId = objectInputParamMap.at(rssObjectId).detectedObjectId;
            // std::cout << "rssObjectId" << std::endl;
            // std::cout << rssObjectId << std::endl;
            // std::cout << "evaluate strucuted safety" << std::endl;
            outputObjectState->name = objectInputParamMap.at(rssObjectId).name;
            rss::EvaluateStructuredSafety(*uniqueRssState, outputObjectState->structuredSafety);
            // std::cout << "complete evaluate strucuted safety" << std::endl;
            // std::cout << "evaluate unstrucuted safety" << std::endl;
            rss::EvaluateUnstructuredSafety(objectInputParamMap.at(rssObjectId), *uniqueRssState, outputObjectState->unstructuredSafety);
            // std::cout << "complete evaluate unstrucuted safety" << std::endl;
            // outputObjectState->transform     = objectInputParamMap.at(rssObjectId).transform;
            // outputObjectState->objectClassId = objectInputParamMap.at(rssObjectId).objectClassId;
            outputObjectState->rssSituation = *uniqueSituation;
            outputObjectState->rssState     = *uniqueRssState;
            outputObjectState->speedLon     = objectInputParamMap.at(rssObjectId).speedLon;
            outputObjectState->speedLat     = objectInputParamMap.at(rssObjectId).speedLat;
        }
    }

    geometry::Vector2d ComputeTrajectorySetForwardVector(const std::vector<geometry::Vector2d> &inputTrajectorySet,
                                                         const geometry::Vector3d              &objectPosition)
    {
        if (inputTrajectorySet.empty())
        {
            return geometry::Vector2d::Zero();
        }

        const geometry::Vector2d objectPosition2d{objectPosition.ToVectorXy()};
        auto                     sortedTrajectorySet{inputTrajectorySet};
        std::sort(sortedTrajectorySet.begin(),
                  sortedTrajectorySet.end(),
                  [&objectPosition2d](const geometry::Vector2d &first, const geometry::Vector2d &second)
                  {
                      const auto firstVector{first - objectPosition2d};
                      const auto secondVector{second - objectPosition2d};
                      return firstVector.norm() > secondVector.norm();
                  });

        const auto               maxPairCenter              = double{0.5} * (sortedTrajectorySet[0] + sortedTrajectorySet[1]);
        const geometry::Vector2d trajectorySetForwardVector = (maxPairCenter - objectPosition2d).normalized();

        return trajectorySetForwardVector;
    }

    void TransformTrajectorySet(const geometry::Transform3d &transform3d, std::vector<geometry::Vector2d> &trajectorySet)
    {
        // std::cout << "TransformTrajectorySetNOTFORAS" << std::endl;
        const geometry::Vector2d refPos2d(transform3d.translation().x(), transform3d.translation().y());
        const math::RotMat2d_t   rotmat2d{transform3d.linear().topLeftCorner<2, 2>()};

        for (auto corner{trajectorySet.begin()}; corner != trajectorySet.end(); ++corner)
        {
            const auto offsetVector = (*corner) - refPos2d;
            *corner                 = refPos2d + rotmat2d * offsetVector;
        }
    }

    void TransformTrajectorySet(const scenario::AgentState &agentState, std::vector<geometry::Vector2d> &trajectorySet)
    {
        // std::cout << "TransformTrajectorySetFORAS" << std::endl;
        const geometry::Vector2d refPos2d(agentState.x, agentState.y);
        const auto               theta = agentState.h;

        for (auto corner{trajectorySet.begin()}; corner != trajectorySet.end(); ++corner)
        {
            const auto offsetVector   = (*corner) - refPos2d;
            auto       cornerPosition = refPos2d;
            cornerPosition.set_x(refPos2d.x() + offsetVector.x() * cos(theta));
            cornerPosition.set_y(refPos2d.y() + offsetVector.y() * sin(theta));
            *corner = cornerPosition;
        }
    }

}  // namespace rss
