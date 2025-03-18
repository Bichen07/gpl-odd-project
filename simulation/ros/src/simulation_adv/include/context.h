#ifndef __CONTEXT_H__
#define __CONTEXT_H__

#include <car.h>
#include <sim_vehicle.h>
#include <cstdint>
#include <itri_msgs/Path.h>
#include <jsoncpp/json/json.h>
#include <map>
#include <memory>
#include <mutex>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/point_cloud.h>
#include <string>
#include <vector>
#include <waypoint_follower.h>

enum class PlayStatus
{
    PAUSE,
    FORWARD,
    BACKWARD,
    RESET
};

struct ControlCommand
{
    std::string carId;
    float steering;
    float speed;
    bool isOperable;
    ControlCommand(){}
    ControlCommand(const std::string & id, const float steerCmd,
        const float speedCmd, const bool operateAuthority)
        : carId(id)
        , steering(steerCmd)
        , speed(speedCmd)
        , isOperable(operateAuthority)
    {}
};

struct StatusOneStep
{
    std::map<std::string, CarStatus> status;
    StatusOneStep(const std::map<std::string, std::shared_ptr<Vehicle>> & carList)
        : status()
    {
        for (const auto car : carList)
        {
            status[car.first] = car.second->GetStatus();
        }
    }
};

struct GlobalPathHandler
{
    std::mutex mutex;
    itri_msgs::Path globalPath;
    pcl::KdTreeFLANN<pcl::PointXYZ> globalPathKdtree;
    std::shared_ptr<WaypointFollower> waypointFollower;
};

#endif // __CONTEXT_H__
