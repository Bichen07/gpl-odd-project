#ifndef _CTRL_WAYPOINT_FOLLOWER_MANAGER_H_
#define _CTRL_WAYPOINT_FOLLOWER_MANAGER_H_

#include <memory>
#include <string>
#include <map>
#include <ctrl_waypoint_follower.h>

namespace ctrl {

template<typename WaypointFollowerType>
class WaypointFollowerManager final
{

public:

    WaypointFollowerManager();
    WaypointFollowerManager(const WaypointFollowerManager &) = delete;
    WaypointFollowerManager &operator=(const WaypointFollowerManager &) = delete;
    virtual ~WaypointFollowerManager();

    std::shared_ptr<WaypointFollowerType> &QueryWaypointFollower(const std::string &id);

    void Register(
        const std::string &id,
        const std::shared_ptr<WaypointFollowerType> &waypointFollower);

protected:

private:

    using WaypointFollowerMap = std::map<std::string, std::shared_ptr<WaypointFollowerType>>;

    WaypointFollowerMap mWaypointFollowerMap;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_WAYPOINT_FOLLOWER_MANAGER_H_
