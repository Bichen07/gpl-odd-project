#include <ctrl_waypoint_follower_manager.h>
#include <stdexcept>
#include <ros/console.h>

namespace ctrl {

// public func.

template<typename WaypointFollowerType>
WaypointFollowerManager<WaypointFollowerType>::WaypointFollowerManager()
    : mWaypointFollowerMap{}
{
}

template<typename WaypointFollowerType>
WaypointFollowerManager<WaypointFollowerType>::~WaypointFollowerManager()
{
}

template<typename WaypointFollowerType>
std::shared_ptr<WaypointFollowerType> &WaypointFollowerManager<WaypointFollowerType>::QueryWaypointFollower(
    const std::string &id)
{
    auto foundPair = mWaypointFollowerMap.find(id);
    if (mWaypointFollowerMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid id: " << id);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

template<typename WaypointFollowerType>
void WaypointFollowerManager<WaypointFollowerType>::Register(
    const std::string &id,
    const std::shared_ptr<WaypointFollowerType> &waypointFollower)
{
    const auto foundPair = mWaypointFollowerMap.find(id);
    if (mWaypointFollowerMap.end() != foundPair)
    {
        ROS_ERROR_STREAM(id << " has been registered");
        return;
    }

    mWaypointFollowerMap.emplace(id, waypointFollower);
}

// protected func.

// private func.

// explicit instantiation

class WaypointFollower;
class CollisionAvoidanceWaypointFollower;
template class WaypointFollowerManager<WaypointFollower>;
template class WaypointFollowerManager<CollisionAvoidanceWaypointFollower>;

} // namespace ctrl {
