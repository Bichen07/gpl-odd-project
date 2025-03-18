#ifndef _ISO_ACC_TIME_GAP_EVALUATOR_H_
#define _ISO_ACC_TIME_GAP_EVALUATOR_H_

#include <memory>
#include <map>
#include <math_frenet_transformer.h>
#include <actor_ego_vehicle_observer.h>
#include <iso_type.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>
#include <iso_acc_time_gap_performance.h>

namespace iso {
namespace acc {

class TimeGapEvaluator final
{

public:

    TimeGapEvaluator();
    TimeGapEvaluator(const TimeGapEvaluator &) = delete;
    TimeGapEvaluator &operator=(const TimeGapEvaluator &) = delete;
    virtual ~TimeGapEvaluator();

    TimeGapPerformance Evaluate(
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState) const;
    math::real_t ComputeTimeGap(
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState) const;
    math::real_t ComputeClearance(
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState) const;

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const PerformanceClassId &performanceClassId,
        const std::vector<math::Vector3d_t> &waypoint3ds);

protected:

private:

    math::real_t ComputeTimeGap(
        const actor::EgoVehicleObserver &egoVehicleObserver,
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState) const;
    math::real_t ComputeClearance(
        const actor::EgoVehicleObserver &egoVehicleObserver,
        const VehicleAttribute &targetVehicleAttribute,
        const VehicleState &targetVehicleState) const;
    TimeGapStateId EvaluateTimeGapState(const math::real_t timeGap) const;

    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    PerformanceClassId mPerformanceClassId;
    std::vector<math::Vector3d_t> mWaypoint3ds;
    std::vector<math::Vector2d_t> mWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
    std::vector<math::real_t> mTimeGaps;
};

} // namespace acc {
} // namespace iso {

#endif // #ifndef _ISO_ACC_TIME_GAP_EVALUATOR_H_
