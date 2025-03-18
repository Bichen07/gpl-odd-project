#ifndef _MEASURE_SAFETY_REGION_OBSERVER_H_
#define _MEASURE_SAFETY_REGION_OBSERVER_H_

#include <vector>
#include <map>
#include <geometry_convex_hull_2d.h>
#include <geometry_intersection_evaluator.h>
#include <actor_agent_manager.h>
#include <actor_ego_vehicle_observer.h>
#include <measure_safety_region_data.h>

namespace measure {

class SafetyRegionObserver final
{

public:

    SafetyRegionObserver();
    SafetyRegionObserver(const SafetyRegionObserver &) = delete;
    SafetyRegionObserver &operator=(const SafetyRegionObserver &) = delete;
    virtual ~SafetyRegionObserver();

    const std::vector<SafetyRegionData> &GetAgentSafetyRegionDatas() const;

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<actor::AgentManager> &agentManager);

    void Update();
    void Clear();

protected:

private:

    using SafetyConvexHullMap = std::map<std::string, geometry::ConvexHull2d>;

    geometry::ConvexHull2d ComputeAgentSafetyConvexHull(const actor::Agent &agent) const;
    std::vector<math::Vector3d_t> ComputeAgentSafetyRegion3d(
        const geometry::ConvexHull2d &safetyRegionConvexHull,
        const math::Vector3d_t &agentPosition) const;

    void ComputeAgentSafetyConvexHull(
        const actor::Agent &agent,
        SafetyConvexHullMap *agentSafetyConvexHullMap) const;
    void ComputeAgentSafetyRegion3d(
        const SafetyConvexHullMap &agentSafetyConvexHullMap,
        const math::Vector3d_t &agentPosition,
        std::vector<SafetyRegionData> *agentSafetyRegionDatas) const;

    bool IsZeroSafetyMargin(const actor::Agent &agent) const;

    std::vector<SafetyRegionData> mAgentSafetyRegionDatas;

    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::shared_ptr<actor::AgentManager> mAgentManager;

    geometry::IntersectionEvaluator mIntersectionEvaluator;
};

} // namespace measure {

#endif // #ifndef _MEASURE_SAFETY_REGION_OBSERVER_H_
