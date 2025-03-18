#ifndef _RSS_UTILS_H_
#define _RSS_UTILS_H_

#include <ad/rss/world/Object.hpp>
#include <ad/rss/situation/SituationSnapshot.hpp>
#include <ad/rss/state/RssStateSnapshot.hpp>
#include <math_type.h>
#include <geometry_vector_3d.h>
#include <rss_object_input_param.h>
#include <rss_ego_vehicle_input_param.h>
#include <rss_check_result.h>
#include <rss_check_result_ego_vehicle_state.h>
#include <rss_check_result_object_state.h>
#include <rss_safety_state.h>
#include <rss_safety_status.h>
#include <rss_structured_safety.h>
#include <rss_unstructured_safety.h>
#include <scenario/AgentState.h>

namespace rss
{

    SafetyState  EvaluateSceneSafetyState(const ad::rss::state::RssStateSnapshot &rssSnapshot);
    SafetyStatus EvalauteSafetyStatus(const ad::rss::state::RssState &rssState);
    SafetyState  EvaluateSafetyState(const ad::rss::state::RssState &rssState);
    void         EvaluateStructuredSafety(const ad::rss::state::RssState &rssState, StructuredSafety &outputSafety);
    void         EvaluateUnstructuredSafety(const ObjectInputParam         &objectInputParam,
                                            const ad::rss::state::RssState &rssState,
                                            UnstructuredSafety             &outputSafety);
    void         EvaluateUnstructuredSafety(const scenario::AgentState     &objectInputParam,
                                            const ad::rss::state::RssState &rssState,
                                            UnstructuredSafety             &outputSafety);
    void         EvaluateCheckResult(const ad::rss::situation::SituationSnapshot                &situationSnapshot,
                                     const ad::rss::state::RssStateSnapshot                     &rssStateSnapshot,
                                     const EgoVehicleInputParam                                 &egoVehicleInputParam,
                                     const std::map<ad::rss::world::ObjectId, ObjectInputParam> &objectInputParamMap,
                                     CheckResult                                                &outputCheckResult);
    void         EvaluateCheckResultForAS(const ad::rss::situation::SituationSnapshot                    &situationSnapshot,
                                          const ad::rss::state::RssStateSnapshot                         &rssStateSnapshot,
                                          const EgoVehicleInputParam                                     &egoVehicleInputParam,
                                          const std::map<ad::rss::world::ObjectId, scenario::AgentState> &objectInputParamMap,
                                          std::map<std::string, ad::rss::world::Object>                  &rssWorldObjectMap,
                                          CheckResult                                                    &outputCheckResult);

    void EvaluateCheckResultEgoVehicleState(const EgoVehicleInputParam             &egoVehicleInputParam,
                                            const ad::rss::state::RssStateSnapshot &rssStateSnapshot,
                                            CheckResultEgoVehicleState             &outputEgoVehicleState);

    void EvaluateCheckResultObjectStates(const ad::rss::situation::SituationSnapshot                &situationSnapshot,
                                         const ad::rss::state::RssStateSnapshot                     &rssStateSnapshot,
                                         const std::map<ad::rss::world::ObjectId, ObjectInputParam> &objectInputParamMap,
                                         std::vector<CheckResultObjectState>                        &outputObjectStates);
    void EvaluateCheckResultObjectStatesForAS(const ad::rss::situation::SituationSnapshot                    &situationSnapshot,
                                              const ad::rss::state::RssStateSnapshot                         &rssStateSnapshot,
                                              const std::map<ad::rss::world::ObjectId, scenario::AgentState> &objectInputParamMap,
                                              std::map<std::string, ad::rss::world::Object>                  &rssWorldObjectMap,
                                              std::vector<CheckResultObjectState>                            &outputObjectStates);

    geometry::Vector2d ComputeTrajectorySetForwardVector(const std::vector<geometry::Vector2d> &inputTrajectorySet,
                                                         const geometry::Vector3d              &objectPosition);
    void               TransformTrajectorySet(const geometry::Transform3d &transform3d, std::vector<geometry::Vector2d> &trajectorySet);
    void               TransformTrajectorySet(const scenario::AgentState &agentState, std::vector<geometry::Vector2d> &trajectorySet);

}  // namespace rss

#endif  // #ifndef _RSS_UTILS_H_
