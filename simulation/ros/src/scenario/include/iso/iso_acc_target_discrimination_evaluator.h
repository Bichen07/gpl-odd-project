#ifndef _ISO_ACC_TARGET_DISCRIMINATION_EVALUATOR_H_
#define _ISO_ACC_TARGET_DISCRIMINATION_EVALUATOR_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoAccTargetDiscriminationEvaluation.h>
#include <scenario/IsoVehicleAttribute.h>
#include <scenario/IsoVehicleState.h>
#include <math_frenet_transformer.h>
#include <math_frenet_coord.h>
#include <actor_ego_vehicle_observer.h>
#include <iso_type.h>
#include <iso_acc_time_gap_evaluator.h>
#include <iso_agent_manager.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>

namespace iso {
namespace acc {

class TargetDiscriminationEvaluator final
{

public:

    TargetDiscriminationEvaluator();
    TargetDiscriminationEvaluator(const TargetDiscriminationEvaluator &) = delete;
    TargetDiscriminationEvaluator &operator=(const TargetDiscriminationEvaluator &) = delete;
    virtual ~TargetDiscriminationEvaluator();

    TargetDiscriminationStateId Evaluate(
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState,
        const VehicleAttribute &forwardVehicleAttribute,
        const VehicleState &forwardVehicleState);
    bool RunService(
        scenario::IsoAccTargetDiscriminationEvaluation::Request &request,
        scenario::IsoAccTargetDiscriminationEvaluation::Response &response);

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<AgentManager> &agentManger,
        const PerformanceClassId &performanceClassId,
        const std::vector<math::Vector3d_t> &waypoint3ds,
        const math::real_t desiredVehicleEndMps);

protected:

private:

    VehicleAttribute ExtractVehicleAttribute(
        const std::string &id,
        const std::vector<scenario::IsoVehicleAttribute> &msg) const;
    VehicleState ExtractVehicleState(
        const std::string &id,
        const std::vector<scenario::IsoVehicleState> &msg) const;
    bool CheckTimeGapPerformance(
        const TimeGapPerformance &timeGapPerformance) const;
    bool IsSubjectExceedingForwardVehicle(
        const math::FrenetCoord &egoVehicleFrenetCoord,
        const math::FrenetCoord &forwardVehicleFrenetCoord,
        const math::real_t targetVehicleLength) const;

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mService;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    PerformanceClassId mPerformanceClassId;
    std::vector<math::Vector3d_t> mWaypoint3ds;
    std::vector<math::Vector2d_t> mWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
    math::real_t mDesiredVehicleEndMps;
    math::real_t mDesiredVehicleBeginMps;
    TimeGapEvaluator mTimeGapEvaluator;
    TargetDiscriminationStateId mPreviousTargetDiscriminationStateId;
    std::shared_ptr<AgentManager> mAgentManager;
};

} // namespace acc {
} // namespace iso {

#endif // #ifndef _ISO_ACC_TARGET_DISCRIMINATION_EVALUATOR_H_
