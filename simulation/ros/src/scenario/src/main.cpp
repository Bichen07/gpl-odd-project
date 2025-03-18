#include <stdexcept>
#include <ros/init.h>
#include <ros/console.h>
#include <simulation_node.h>
#include <scenario_simulator_manager.h>

int main(int argc, char** argv)
{
    ros::init(argc, argv, "scenario");

    bool useSimTime{false};
    if (ros::param::get("/use_sim_time", useSimTime))
    {
        if (useSimTime)
        {
            // ROS_ERROR_STREAM("invalid /use_sim_time: " << useSimTime);
            // throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }

    scenario::SimulatorManager simulatorManager;
    simulatorManager.Configure();

    SimulationNode simulation;

    throw std::invalid_argument(std::string("deprecated node"));
    simulation.MainLoop();

    return 0;
}
