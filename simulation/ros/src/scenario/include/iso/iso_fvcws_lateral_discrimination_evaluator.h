#ifndef _ISO_FVCWS_LATERAL_DISCRIMINATION_EVALUATOR_H_
#define _ISO_FVCWS_LATERAL_DISCRIMINATION_EVALUATOR_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoFvcwsLateralDiscriminationEvaluation.h>
#include <scenario/IsoVehicleAttribute.h>
#include <scenario/IsoVehicleState.h>
#include <math_frenet_transformer.h>
#include <iso_type.h>
#include <iso_acc_time_gap_evaluator.h>
#include <iso_agent_manager.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>

namespace iso {
namespace fvcws {

class LateralDiscriminationEvaluator final
{

public:

    LateralDiscriminationEvaluator();
    LateralDiscriminationEvaluator(const LateralDiscriminationEvaluator &) = delete;
    LateralDiscriminationEvaluator &operator=(const LateralDiscriminationEvaluator &) = delete;
    virtual ~LateralDiscriminationEvaluator();

    LateralDiscriminationStateId Evaluate(
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState,
        const VehicleAttribute &forwardVehicleAttribute,
        const VehicleState &forwardVehicleState);
    bool RunService(
        scenario::IsoFvcwsLateralDiscriminationEvaluation::Request &request,
        scenario::IsoFvcwsLateralDiscriminationEvaluation::Response &response);

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<AgentManager> &agentManger,
        const std::vector<math::Vector3d_t> &egoVehicleWaypoints);

protected:

private:

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mService;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::shared_ptr<AgentManager> mAgentManager;
    math::FrenetTransformer mFrenetTransformer;
    LateralDiscriminationStateId mPreviousLateralDiscriminationStateId;
    acc::TimeGapEvaluator mTimeGapEvaluator;
};

} // namespace fvcws {
} // namespace iso {

#endif // #ifndef _ISO_FVCWS_LATERAL_DISCRIMINATION_EVALUATOR_H_
