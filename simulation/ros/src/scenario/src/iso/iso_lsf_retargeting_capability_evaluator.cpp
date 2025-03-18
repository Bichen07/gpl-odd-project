#include <iso_lsf_retargeting_capability_evaluator.h>

namespace iso {
namespace lsf {


// public func.

RetargetingCapabilityEvaluator::RetargetingCapabilityEvaluator()
    : mEgoVehicleObserver{nullptr}
    , mWaypoint3ds{}
    , mWaypoint2ds{}
    , mFrenetTransformer{}
{

}


RetargetingCapabilityEvaluator::~RetargetingCapabilityEvaluator()
{
}


void RetargetingCapabilityEvaluator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const std::shared_ptr<AgentManager> &agentManager,
    const PerformanceClassId &performanceClassId,
    const std::vector<math::Vector3d_t> &waypoint3ds)
{
    if (nullptr == egoVehicleObserver)
    {
        ROS_ERROR_STREAM("egoVehicleObserver is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (PerformanceClass::Null == performanceClassId)
    {
        ROS_ERROR_STREAM("invalid " << performanceClassId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (waypoint3ds.empty())
    {
        ROS_ERROR_STREAM("waypoint3ds is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    mEgoVehicleObserver = egoVehicleObserver;
    mAgentManager = agentManager;
    mPerformanceClassId = performanceClassId;
    mWaypoint3ds = waypoint3ds;
    mWaypoint2ds.resize(mWaypoint3ds.size());
    std::transform(
        mWaypoint3ds.cbegin(),
        mWaypoint3ds.cend(),
        mWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    mFrenetTransformer.Configure(mWaypoint2ds);
}

void RetargetingCapabilityEvaluator::Evaluate()
{
}

// protected func.

// private func.

} // namespace lsf {
} // namespace iso {
