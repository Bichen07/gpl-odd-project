#include <backward.hpp>
#include <ros/init.h>
#include <simulation_node.h>

int
main(int argc, char** argv)
{
    backward::SignalHandling signalHandling;
    ros::init(argc, argv, "simulation_adv");

    SimulationNode simulationNode;
    simulationNode.Configure();

    simulationNode.MainLoop();

    return 0;
}
