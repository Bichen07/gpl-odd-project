#include <ros/init.h>
#include <ros/ros.h>
#include <ros/param.h>
#include <frenet_trajectory_agent_generator.h>
#include <math_type.h>
#include <string>
#include <iostream>
#include <vector>

geometry_msgs::Vector3 split_size(std::string const input);

int main(int argc, char** argv)
{
    ros::init(
        argc, argv,
        "frenet_trajectory_agent_generator_node",
        ros::init_options::AnonymousName);

    std::string agentName = "agent_scensrch";
    std::string agentSuffix;
    ros::param::param<std::string>("~agent_suffix", agentSuffix, "");
    if (agentSuffix.size())
    {
        agentName = agentName + "_" + agentSuffix;
    }
    std::string agentSize;
    ros::param::param<std::string>("~agent_size", agentSize, "3.6 1.8 1.7");
    ROS_INFO_STREAM("[Scenario Search] Agent name: " << agentName);
    ROS_INFO_STREAM("[Scenario Search] Agent size: " << agentSize);

    bool automaticallyGenerateAgentWithRandomWaypoints = true;

    ros::param::param<bool>("/scenario_search/auto_generate",
        automaticallyGenerateAgentWithRandomWaypoints, true);

    scen_srch::FrenetTrajectoryAgentGenerator generator(
        agentName, split_size(agentSize));
    generator.CleanAgentsWithSameName();
    generator.MainLoop(automaticallyGenerateAgentWithRandomWaypoints);

    return 0;
}


geometry_msgs::Vector3 split_size(std::string const input)
{
    std::istringstream ss(input);
    std::string word;
    std::vector<math::real_t> splitted;
    while(ss >> word)
    {
        math::real_t item(std::stof(word));
        splitted.push_back(item);
    }
    geometry_msgs::Vector3 ret;
    ret.x = splitted[0];
    ret.y = splitted[1];
    ret.z = splitted[2];
    return ret;
}