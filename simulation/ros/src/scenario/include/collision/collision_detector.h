#ifndef _COLLISION_DETECTOR_H_
#define _COLLISION_DETECTOR_H_

#include <list>
#include <geometry_convex_hull_2d.h>
#include <geometry_intersection_evaluator.h>
#include <actor_agent_manager.h>
#include <actor_ego_vehicle_observer.h>

namespace collision {

class Detector final
{

public:

    Detector();
    Detector(const Detector &) = delete;
    Detector &operator=(const Detector &) = delete;
    virtual ~Detector();

    std::list<std::string> CollidedAgentIdList() const;
    bool HasEgoVehicleCollision() const;

    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
        const std::shared_ptr<actor::AgentManager> &agentManager);

    void Update();
    void ClearDetectedCollision();

protected:

private:

    //geometry::ConvexHull2d ComputeAgentBoundingConvexHull(const actor::Agent &agent) const;

    std::list<std::string> mCollidedAgentIdList;
    bool mHasEgoVehicleCollision;

    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::shared_ptr<actor::AgentManager> mAgentManager;

    geometry::IntersectionEvaluator mIntersectionEvaluator;
};

} // namespace collision {

#endif // #ifndef _COLLISION_DETECTOR_H_
