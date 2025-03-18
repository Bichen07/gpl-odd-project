#include <ros/init.h>
#include <ros/node_handle.h>
#include <scenario_updater_node.h>
#include <backward.hpp>

int main(int argc, char **argv)
{
    backward::SignalHandling signalHandling;
    ros::init(argc, argv, "scenario_updater_node");

    scenario::UpdaterNode updaterNode;
    updaterNode.Configure();
    updaterNode.RunMainLoop();

    return 0;
}
