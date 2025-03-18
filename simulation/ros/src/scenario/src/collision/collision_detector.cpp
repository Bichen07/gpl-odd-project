#include <collision_detector.h>
#include <ros/console.h>
#include <geometry_convex_hull_2d.h>
#include <geometry_utils.h>

namespace collision {

// public func.

Detector::Detector()
    : mCollidedAgentIdList{}
    , mHasEgoVehicleCollision{false}

    , mEgoVehicleObserver{nullptr}
    , mAgentManager{nullptr}
    , mIntersectionEvaluator{}
{
}

Detector::~Detector()
{
}

std::list<std::string> Detector::CollidedAgentIdList() const
{
    return mCollidedAgentIdList;
}

bool Detector::HasEgoVehicleCollision() const
{
    return mHasEgoVehicleCollision;
}

void Detector::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const std::shared_ptr<actor::AgentManager> &agentManager)
{
    mEgoVehicleObserver = egoVehicleObserver;
    mAgentManager = agentManager;
}

void Detector::Update()
{
    static constexpr math::real_t centroidDistanceThreshold{15.0};
    const geometry::ConvexHull2d egoVehicleConvexHull(
        geometry::ExtractCorners(mEgoVehicleObserver->GetWorldBoundingRect2d()));
        //geometry::ConvertToPoints(mEgoVehicleObserver->GetWorldBoundingRect2d()));
        //mEgoVehicleObserver->GetWorldBoundingRect2d());

    const auto agents{mAgentManager->GetAgents()};
    for (const auto &agent: agents)
    {
        const math::real_t centroidDistance =
            (egoVehicleConvexHull.GetCentroid() - agent->GetTransform2d().translation()).norm();
        if (centroidDistance < centroidDistanceThreshold)
        {
            //const auto agentBoundingConvexHull{
            //    this->ComputeAgentBoundingConvexHull(*agent)};
            const auto agentBoundingConvexHull{
                geometry::ConvexHull2d(geometry::ExtractCorners(agent->GetWorldBoundingRect2d()))};
                //geometry::ConvexHull2d(geometry::ConvertToPoints(agent->GetWorldBoundingRect2d()))};
            const math::real_t overlappingArea = mIntersectionEvaluator.ComputeArea(
                egoVehicleConvexHull.GetPolygon(),
                agentBoundingConvexHull.GetPolygon());

            if (overlappingArea > 0.0)
            {
                mCollidedAgentIdList.push_back(agent->GetAttribute().id);
                mHasEgoVehicleCollision = true;
            }
        }
    }
}

void Detector::ClearDetectedCollision()
{
    mCollidedAgentIdList.clear();
    mHasEgoVehicleCollision = false;
}

// protected func.

// private func.

//geometry::ConvexHull2d Detector::ComputeAgentBoundingConvexHull(const actor::Agent &agent) const
//{
//    const math::real_t offsetX{0.5 * agent.GetAttribute().size.x()};
//    const math::real_t offsetY{0.5 * agent.GetAttribute().size.y()};
//    const std::vector<math::real_t> cornerOffsetsX(
//        {-offsetX, -offsetX, +offsetX, +offsetX});
//    const std::vector<math::real_t> cornerOffsetsY(
//        {+offsetY, -offsetY, -offsetY, +offsetY});
//
//    std::vector<math::Vector2d_t> worldCorners(cornerOffsetsX.size());
//    for (std::size_t idx{0ul}; idx < worldCorners.size(); ++idx)
//    {
//        const math::Vector2d_t localVertex(
//            cornerOffsetsX[idx],
//            cornerOffsetsY[idx]);
//        worldCorners[idx] = agent.GetTransform2d() * localVertex;
//    }
//
//    return geometry::ConvexHull2d(worldCorners);
//}

} // namespace collision {
