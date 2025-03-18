#ifndef _ISO_ADAPTIVE_CRUISE_CONTROL_H_
#define _ISO_ADAPTIVE_CRUISE_CONTROL_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoAccPerformanceEvaluation.h>
#include <math_frenet_transformer.h>
#include <actor_ego_vehicle_observer.h>
#include <iso_type.h>
#include <iso_vehicle_state.h>
#include <iso_adaptive_cruise_control_performance.h>

namespace iso {

class AdaptiveCruiseControl final
{

public:

    AdaptiveCruiseControl();
    AdaptiveCruiseControl(const AdaptiveCruiseControl &) = delete;
    AdaptiveCruiseControl &operator=(const AdaptiveCruiseControl &) = delete;
    virtual ~AdaptiveCruiseControl();

    AdaptiveCruiseControlPerformance Evaluate(const VehicleState &vehicleState);

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const PerformanceClassId &performanceClassId,
        const std::vector<math::Vector3d_t> &waypoint3ds);

protected:

private:

    bool RunPerformanceEvaluationService(
        scenario::IsoAccPerformanceEvaluation::Request &request,
        scenario::IsoAccPerformanceEvaluation::Response &response);

    math::real_t ComputeTimeGap(
        const actor::EgoVehicleObserver &egoVehicleObserver,
        const VehicleState &vehicleState) const;
    math::real_t ComputeClearance(
        const actor::EgoVehicleObserver &egoVehicleObserver,
        const VehicleState &vehicleState) const;

    bool EvaluateSuccessfulTimeGap(
        const PerformanceClassId &performanceClassId,
        const math::real_t timeGap) const;

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mPerformanceEvaluationService;

    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    PerformanceClassId mPerformanceClassId;
    std::vector<math::Vector3d_t> mWaypoint3ds;
    std::vector<math::Vector2d_t> mWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
};

} // namespace iso {

#endif // #ifndef _ISO_ADAPTIVE_CRUISE_CONTROL_H_
