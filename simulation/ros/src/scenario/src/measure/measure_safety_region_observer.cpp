#include <measure_safety_region_observer.h>
#include <ros/console.h>
#include <math_utils.h>
#include <geometry_utils.h>

namespace measure {

// public func.

SafetyRegionObserver::SafetyRegionObserver()
    : mAgentSafetyRegionDatas{}

    , mEgoVehicleObserver{nullptr}
    , mAgentManager{nullptr}

    , mIntersectionEvaluator{}
{
}

SafetyRegionObserver::~SafetyRegionObserver()
{
}

const std::vector<SafetyRegionData> &SafetyRegionObserver::GetAgentSafetyRegionDatas() const
{
    return mAgentSafetyRegionDatas;
}

void SafetyRegionObserver::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const std::shared_ptr<actor::AgentManager> &agentManager)
{
    mEgoVehicleObserver = egoVehicleObserver;
    mAgentManager = agentManager;
}

void SafetyRegionObserver::Update()
{
    if (!mEgoVehicleObserver)
    {
        ROS_ERROR_STREAM("mEgoVehicleObserver is nullptr");
    }

    if (!mAgentManager)
    {
        ROS_ERROR_STREAM("mAgentManager is nullptr");
    }

    static constexpr math::real_t centroidDistanceThreshold{20.0};
    const geometry::ConvexHull2d egoVehicleConvexHull(
        geometry::ExtractCorners(mEgoVehicleObserver->GetWorldBoundingRect2d()));
        //geometry::ConvertToPoints(mEgoVehicleObserver->GetWorldBoundingRect2d()));
        //mEgoVehicleObserver->GetWorldBoundingRect2d());

    const auto agents{mAgentManager->GetAgents()};

    for (const auto agent: agents)
    {
        if (!this->IsZeroSafetyMargin(*agent))
        {
            SafetyConvexHullMap agentSafetyConvexHullMap;
            this->ComputeAgentSafetyConvexHull(
                *agent,
                &agentSafetyConvexHullMap);
            this->ComputeAgentSafetyRegion3d(
                agentSafetyConvexHullMap,
                agent->GetTransform3d().translation(),
                &mAgentSafetyRegionDatas);
            const math::real_t centroidDistance =
                (egoVehicleConvexHull.GetCentroid() - agent->GetTransform2d().translation()).norm();

            if (centroidDistance < centroidDistanceThreshold)
            {
                for (const auto &convexHullPair: agentSafetyConvexHullMap)
                {
                    const auto overlappingArea = mIntersectionEvaluator.ComputeArea(
                        egoVehicleConvexHull.GetPolygon(),
                        convexHullPair.second.GetPolygon());
                    if (overlappingArea > 0.0)
                    {
                        const auto foundConfig = std::find_if(
                            mAgentSafetyRegionDatas.begin(),
                            mAgentSafetyRegionDatas.end(),
                            [&convexHullPair](const SafetyRegionData &data)
                            {return data.id == convexHullPair.first;});
                        foundConfig->isSafe = false;
                    }
                }
            }
        }
    }
}

void SafetyRegionObserver::Clear()
{
    mAgentSafetyRegionDatas.clear();
}

// protected func.

// private func.

geometry::ConvexHull2d SafetyRegionObserver::ComputeAgentSafetyConvexHull(const actor::Agent &agent) const
{
    const math::real_t sizeOffsetX{0.5 * agent.GetAttribute().size.x()};
    const math::real_t sizeOffsetY{0.5 * agent.GetAttribute().size.y()};
    const std::vector<math::real_t> cornerOffsetXs(
        {
            -sizeOffsetX - agent.GetAttribute().safetyMargin.rear,
            -sizeOffsetX - agent.GetAttribute().safetyMargin.rear,
            +sizeOffsetX + agent.GetAttribute().safetyMargin.front,
            +sizeOffsetX + agent.GetAttribute().safetyMargin.front
        });
    const std::vector<math::real_t> cornerOffsetYs(
        {
            +sizeOffsetY + agent.GetAttribute().safetyMargin.left,
            -sizeOffsetY - agent.GetAttribute().safetyMargin.right,
            -sizeOffsetY - agent.GetAttribute().safetyMargin.right,
            +sizeOffsetY + agent.GetAttribute().safetyMargin.left
        });

    std::vector<math::Vector2d_t> worldCorners(cornerOffsetXs.size());
    for (std::size_t idx{0ul}; idx < worldCorners.size(); ++idx)
    {
        const math::Vector2d_t localCorner(
            cornerOffsetXs[idx],
            cornerOffsetYs[idx]);
        worldCorners[idx] = agent.GetTransform2d() * localCorner;
    }

    return geometry::ConvexHull2d(worldCorners);
}

std::vector<math::Vector3d_t> SafetyRegionObserver::ComputeAgentSafetyRegion3d(
    const geometry::ConvexHull2d &safetyRegionConvexHull,
    const math::Vector3d_t &agentPosition) const
{
    const auto corner2ds{safetyRegionConvexHull.GetCorners()};
    std::vector<math::Vector3d_t> outputRegion3d(corner2ds.size());
    std::transform(
        corner2ds.begin(),
        corner2ds.end(),
        outputRegion3d.begin(),
        [&agentPosition](const math::Vector2d_t &corner2d)
        {return math::Vector3d_t(corner2d.x(), corner2d.y(), agentPosition.z());});

    return outputRegion3d;
}

void SafetyRegionObserver::ComputeAgentSafetyConvexHull(
    const actor::Agent &agent,
    SafetyConvexHullMap *agentSafetyConvexHullMap) const
{
    if (nullptr == agentSafetyConvexHullMap)
    {
        ROS_ERROR_STREAM("agentSafetyConvexHullMap is nullptr");
        return;
    }

    const math::real_t sizeOffsetX{0.5 * agent.GetAttribute().size.x()};
    const math::real_t sizeOffsetY{0.5 * agent.GetAttribute().size.y()};

    static constexpr math::real_t epsilon{1.0e-6};
    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.left, epsilon))
    {
        const std::vector<math::real_t> cornerOffsetXs(
            {-sizeOffsetX, -sizeOffsetX, +sizeOffsetX, +sizeOffsetX});
        const std::vector<math::real_t > cornerOffsetYs(
            {
                +sizeOffsetY + agent.GetAttribute().safetyMargin.left,
                -sizeOffsetY,
                -sizeOffsetY,
                +sizeOffsetY + agent.GetAttribute().safetyMargin.left
            });

        std::vector<math::Vector2d_t> leftWorldCorners(cornerOffsetXs.size());
        for (std::size_t idx{0ul}; idx < leftWorldCorners.size(); ++idx)
        {
            const math::Vector2d_t leftLocalCorner(
                cornerOffsetXs[idx],
                cornerOffsetYs[idx]);
            leftWorldCorners[idx] = agent.GetTransform2d() * leftLocalCorner;
        }

        agentSafetyConvexHullMap->emplace(
            agent.GetAttribute().id + "_left_safety_margin",
            geometry::ConvexHull2d(leftWorldCorners));
    }

    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.right, epsilon))
    {
        const std::vector<math::real_t> cornerOffsetXs(
            {-sizeOffsetX, -sizeOffsetX, +sizeOffsetX, +sizeOffsetX});
        const std::vector<math::real_t> cornerOffsetYs(
            {
                +sizeOffsetY,
                -sizeOffsetY - agent.GetAttribute().safetyMargin.right,
                -sizeOffsetY - agent.GetAttribute().safetyMargin.right,
                +sizeOffsetY
            });

        std::vector<math::Vector2d_t> rightWorldCorners(cornerOffsetXs.size());
        for (std::size_t idx{0ul}; idx < rightWorldCorners.size(); ++idx)
        {
            const math::Vector2d_t rightLocalCorner(
                cornerOffsetXs[idx],
                cornerOffsetYs[idx]);
            rightWorldCorners[idx] = agent.GetTransform2d() * rightLocalCorner;
        }

        agentSafetyConvexHullMap->emplace(
            agent.GetAttribute().id + "_right_safety_margin",
            geometry::ConvexHull2d(rightWorldCorners));
    }

    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.front, epsilon))
    {
        const std::vector<math::real_t> cornerOffsetXs(
            {
                -sizeOffsetX,
                -sizeOffsetX,
                +sizeOffsetX + agent.GetAttribute().safetyMargin.front,
                +sizeOffsetX + agent.GetAttribute().safetyMargin.front
            });
        const std::vector<math::real_t> cornerOffsetYs(
            {+sizeOffsetY, -sizeOffsetY, -sizeOffsetY, +sizeOffsetY});
        
        std::vector<math::Vector2d_t> frontWorldCorners(cornerOffsetXs.size());
        for (std::size_t idx{0ul}; idx < frontWorldCorners.size(); ++idx)
        {
            const math::Vector2d_t frontLocalCorner(
                cornerOffsetXs[idx],
                cornerOffsetYs[idx]);
            frontWorldCorners[idx] = agent.GetTransform2d() * frontLocalCorner;
        }

        agentSafetyConvexHullMap->emplace(
            agent.GetAttribute().id + "_front_safety_margin",
            geometry::ConvexHull2d(frontWorldCorners));
    }

    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.rear, epsilon))
    {
        const std::vector<math::real_t> cornerOffsetXs(
            {
                -sizeOffsetX - agent.GetAttribute().safetyMargin.rear,
                -sizeOffsetX - agent.GetAttribute().safetyMargin.rear,
                +sizeOffsetX,
                +sizeOffsetX
            });
        const std::vector<math::real_t> cornerOffsetYs(
            {+sizeOffsetY, -sizeOffsetY, -sizeOffsetY, +sizeOffsetY});
        std::vector<math::Vector2d_t> rearWorldCorners(cornerOffsetXs.size());
        for (std::size_t idx{0ul}; idx < rearWorldCorners.size(); ++idx)
        {
            const math::Vector2d_t rearLocalCorner(
                cornerOffsetXs[idx],
                cornerOffsetYs[idx]);
            rearWorldCorners[idx] = agent.GetTransform2d() * rearLocalCorner;
        }

        agentSafetyConvexHullMap->emplace(
            agent.GetAttribute().id + "_rear_safety_margin",
            geometry::ConvexHull2d(rearWorldCorners));
    }
}

void SafetyRegionObserver::ComputeAgentSafetyRegion3d(
    const SafetyConvexHullMap &agentSafetyConvexHullMap,
    const math::Vector3d_t &agentPosition,
    std::vector<SafetyRegionData> *agentSafetyRegionDatas) const
{
    agentSafetyRegionDatas->resize(agentSafetyConvexHullMap.size());

    auto agentSafetyRegionData{agentSafetyRegionDatas->begin()};
    for (const auto &convexHullPair: agentSafetyConvexHullMap)
    {
        agentSafetyRegionData->id = convexHullPair.first;
        agentSafetyRegionData->isSafe = true;
        const auto corner2ds{convexHullPair.second.GetCorners()};
        agentSafetyRegionData->safetyRegion.resize(corner2ds.size());
        std::transform(
            corner2ds.begin(),
            corner2ds.end(),
            agentSafetyRegionData->safetyRegion.begin(),
            [&agentPosition](const math::Vector2d_t &corner2d)
            {return math::Vector3d_t(corner2d.x(), corner2d.y(), agentPosition.z());});
        ++agentSafetyRegionData;
    }
}

bool SafetyRegionObserver::IsZeroSafetyMargin(const actor::Agent &agent) const
{
    static constexpr math::real_t epsilon{1.0e-6};
    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.left, epsilon))
    {
        return false;
    }

    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.right, epsilon))
    {
        return false;
    }

    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.front, epsilon))
    {
        return false;
    }

    if (!math::IsApproxZero(agent.GetAttribute().safetyMargin.rear, epsilon))
    {
        return false;
    }

    return true;
}

} // namespace measure {
