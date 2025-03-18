#ifndef _ISO_FVCWS_LONGITUDINAL_DISCRIMINATION_EVALUATOR_H_
#define _ISO_FVCWS_LONGITUDINAL_DISCRIMINATION_EVALUATOR_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoFvcwsLongitudinalDiscriminationEvaluation.h>
#include <scenario/IsoVehicleAttribute.h>
#include <scenario/IsoVehicleState.h>
#include <math_frenet_transformer.h>
#include <utils_time_step_evaluator.h>
#include <iso_type.h>
#include <iso_acc_time_gap_evaluator.h>
#include <iso_agent_manager.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>

namespace iso {
namespace fvcws {

class LongitudinalDiscriminationEvaluator final
{

public:

    LongitudinalDiscriminationEvaluator();
    LongitudinalDiscriminationEvaluator(const LongitudinalDiscriminationEvaluator &) = delete;
    LongitudinalDiscriminationEvaluator &operator=(const LongitudinalDiscriminationEvaluator &) = delete;
    virtual ~LongitudinalDiscriminationEvaluator();

    LongitudinalDiscriminationStateId Evaluate(
        const VehicleAttribute &nearTargetVehicleAttribute,
        const VehicleState &nearTargetVehicleState);
    bool RunService(
        scenario::IsoFvcwsLongitudinalDiscriminationEvaluation::Request &request,
        scenario::IsoFvcwsLongitudinalDiscriminationEvaluation::Response &response);

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<AgentManager> &agentManger,
        const std::vector<math::Vector3d_t> &egoVehicleWaypoints);

protected:

private:

    VehicleAttribute ExtractVehicleAttribute(
        const std::string &id,
        const std::vector<scenario::IsoVehicleAttribute> &msg) const;
    VehicleState ExtractVehicleState(
        const std::string &id,
        const std::vector<scenario::IsoVehicleState> &msg) const;
    bool IsValidWarningDistance(
        const actor::EgoVehicleObserver &egoVehicleObserver,
        const VehicleAttribute &nearTargetVehicleAttribute,
        const VehicleState &nearTargetVehicleState) const;

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mService;
    ros::Publisher mSubjectAccelerationWarningPublisher;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::shared_ptr<AgentManager> mAgentManager;
    acc::TimeGapEvaluator mTimeGapEvaluator;
    LongitudinalDiscriminationStateId mPreviousLongitudinalDiscriminationStateId;
    math::FrenetTransformer mFrenetTransformer;
    utils::TimeStepEvaluator mTimeStepEvaluator;
    math::real_t mCurrentEgoVehicleSpeed;
    math::real_t mPreviousEgoVehicleSpeed;
    math::real_t mStableInitFollowingTime;
    math::real_t mStableInitFollowingElapsedTime;
    math::real_t mBeforeTargetDecelerationStableFollowingTime;
};

} // namespace fvcws {
} // namespace iso {

#endif // #ifndef _ISO_FVCWS_LONGITUDINAL_DISCRIMINATION_EVALUATOR_H_
