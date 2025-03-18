#ifndef _ISO_LSF_RETARGETING_CAPABILITY_EVALUATOR_H_
#define _ISO_LSF_RETARGETING_CAPABILITY_EVALUATOR_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoVehicleAttribute.h>
#include <scenario/IsoVehicleState.h>
#include <actor_ego_vehicle_observer.h>
#include <iso_type.h>
#include <iso_agent_manager.h>
#include <math_frenet_transformer.h>
#include <math_frenet_coord.h>
#include <map_navigation_path.h>
#include <queue>

namespace iso {
namespace lsf {

class RetargetingCapabilityEvaluator final
{

public:

    RetargetingCapabilityEvaluator();
    RetargetingCapabilityEvaluator(const RetargetingCapabilityEvaluator &) = delete;
    RetargetingCapabilityEvaluator &operator=(const RetargetingCapabilityEvaluator &) = delete;
    virtual ~RetargetingCapabilityEvaluator();


     void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<AgentManager> &agentManager,
        const PerformanceClassId &performanceClassId,
        const std::vector<math::Vector3d_t> &waypoint3ds);

    void Evaluate();

protected:

private:
    ros::NodeHandle mNodeHandle;
    ros::Publisher mPerformancePublisher;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::vector<math::Vector3d_t> mWaypoint3ds;
    std::vector<math::Vector2d_t> mWaypoint2ds;
    PerformanceClassId mPerformanceClassId;
    std::shared_ptr<AgentManager> mAgentManager;
    math::FrenetTransformer mFrenetTransformer;
};

} // namespace lsf {
} // namespace iso {

#endif // #ifndef _ISO_LSF_RETARGETING_CAPABILITY_EVALUATOR_H_
