#include <ros/init.h>
#include <ros/console.h>
#include <path_planner_node.h>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "path_planner_node");
    if (ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME, ros::console::levels::Debug))
    {
        ros::console::notifyLoggerLevelsChanged();
    }
    ros::Time::init();
    path::PlannerNode plannerNode;
    plannerNode.Configure();
    
    ros::spin();

    return 0;
}
