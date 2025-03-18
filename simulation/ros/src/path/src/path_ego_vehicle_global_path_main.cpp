#include <ros/init.h>
#include <path_ego_vehicle_waypoint_manager_node.h>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "path_ego_vehicle_global_path_node");
    if (ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME, ros::console::levels::Debug))
    {
        ros::console::notifyLoggerLevelsChanged();
    }

    ros::Time::init();
    path::EgoVehicleWaypointManagerNode egoVehicleWaypointManagerNode;
    egoVehicleWaypointManagerNode.Configure();

    ros::spin();

    return 0;
}
