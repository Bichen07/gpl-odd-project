#ifndef __WAYPOINT_FOLLOWER_H__
#define __WAYPOINT_FOLLOWER_H__

#include<itri_msgs/Path.h>
#include<map>
#include<memory>
#include<sim_vehicle.h>

class WaypointFollower
{
public:
    WaypointFollower(
        const itri_msgs::Path &);
    void SetSteeringCommand(Vehicle &);

protected:
    void FindClosestWaypointIndex(Vehicle &);

private:
    std::map<std::string, int> mClosestWaypointIndex;
    itri_msgs::Path mPath;
};

#endif // __WAYPOINT_FOLLOWER_H__
