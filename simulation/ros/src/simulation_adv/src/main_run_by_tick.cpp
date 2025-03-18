#include <ros/init.h>
#include <simulation_node.h>

int main(int argc, char** argv)
{
    ros::init(argc, argv, "simulation_adv");

    SimulationNode simulationNode;
    simulationNode.Configure();

    simulationNode.RunByTick();

    return 0;
}
