#ifndef _ISO_LKAS_LANE_KEEPING_EVALUATOR_H_
#define _ISO_LKAS_LANE_KEEPING_EVALUATOR_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoVehicleState.h>
#include <scenario/IsoLkasLaneKeepingPerformance.h>
#include <actor_ego_vehicle_observer.h>
#include <iso_vehicle_state.h>
#include <math_frenet_transformer.h>
#include <map_navigation_path.h>

namespace iso{
namespace lkas{

class LaneKeepingEvaluator final
{

public:
    LaneKeepingEvaluator();
    LaneKeepingEvaluator(const LaneKeepingEvaluator &) = delete;
    LaneKeepingEvaluator &operator=(const LaneKeepingEvaluator &) = delete;
    virtual ~LaneKeepingEvaluator();

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<map::NavigationPath> &navigationPath,
        const math::real_t timeStep);

    void Evaluate();

private:

    std::string CheckLaneChanged();
    math::real_t CalculateRateOfDeparture(const motion::State state);
    scenario::IsoLkasLaneKeepingPerformance CheckPerformance();

    ros::NodeHandle mNodeHandle;
    ros::Publisher mPerformancePublisher;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::shared_ptr<map::NavigationPath> mNavigationPath;
    std::vector<math::Vector3d_t> mWaypoint3ds;
    std::vector<math::Vector2d_t> mWaypoint2ds;

    uint32_t mMsgSequenceCount;
    bool mStarted;
    bool mIsFailed;
    bool mLaneChanged;
    bool mOutOfBoundary;
    math::real_t mCruiseVelocity;
    math::real_t mTimeStep;
    math::real_t mLastLongitudinalAcceleration;
    math::real_t mLastLateralAcceleration;
    math::real_t mLastDistanceToLaneCenter;
    math::FrenetTransformer mFrenetTransformer;

};

} // namespace lkas{
} // namespace iso{

#endif // #ifndef _ISO_LKAS_LANE_KEEPING_EVALUATOR_H_