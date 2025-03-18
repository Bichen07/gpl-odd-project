#ifndef _ISO_ACC_CURVE_CAPABILITY_EVALUATOR_H_
#define _ISO_ACC_CURVE_CAPABILITY_EVALUATOR_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoAccCurveCapabilityEvaluation.h>
#include <scenario/IsoVehicleAttribute.h>
#include <scenario/IsoVehicleState.h>
#include <math_frenet_transformer.h>
#include <actor_ego_vehicle_observer.h>
#include <iso_type.h>
#include <iso_acc_time_gap_evaluator.h>
#include <iso_agent_manager.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>

namespace iso {
namespace acc {

class CurveCapabilityEvaluator final
{

public:

    CurveCapabilityEvaluator();
    CurveCapabilityEvaluator(const CurveCapabilityEvaluator &) = delete;
    CurveCapabilityEvaluator &operator=(const CurveCapabilityEvaluator &) = delete;
    virtual ~CurveCapabilityEvaluator();

    math::real_t GetTestTrackRadius(
        const PerformanceClassId &performanceClassId) const;
    math::real_t GetMaxLateralAcceleration(
        const PerformanceClassId &performanceClassId) const;
    math::real_t ComputeTargetVehicleBeginSpeed(
        const PerformanceClassId &performanceClassId) const;

    TimeGapPerformance Evaluate(
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState) const;
    bool RunService(
        scenario::IsoAccCurveCapabilityEvaluation::Request &request,
        scenario::IsoAccCurveCapabilityEvaluation::Response &response);

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<AgentManager> &agentManger,
        const PerformanceClassId &performanceClassId,
        const std::vector<math::Vector3d_t> &waypoint3ds);

protected:

private:

    VehicleAttribute ExtractVehicleAttribute(
        const std::string &id,
        const std::vector<scenario::IsoVehicleAttribute> &msg) const;
    VehicleState ExtractVehicleState(
        const std::string &id,
        const std::vector<scenario::IsoVehicleState> &msg) const;

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mService;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    PerformanceClassId mPerformanceClassId;
    std::vector<math::Vector3d_t> mWaypoint3ds;
    std::vector<math::Vector2d_t> mWaypoint2ds;
    TimeGapEvaluator mTimeGapEvaluator;
    std::shared_ptr<AgentManager> mAgentManager;
};

} // namespace acc {
} // namespace iso {

#endif // #ifndef _ISO_ACC_CURVE_CAPABILITY_EVALUATOR_H_
