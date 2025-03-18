#include <ros/init.h>
#include <ros/node_handle.h>
#include <scenario_mr_vil_testing_node.h>
#include <backward.hpp>

int main(int argc, char **argv)
{
    backward::SignalHandling signalHandling;
    ros::init(argc, argv, "mr_vil_testing");

    scenario::MrVilTestingNode mrVilTestingNode;
    mrVilTestingNode.Configure();
    mrVilTestingNode.RunMainLoop();

    return 0;
}
