#include <ros/init.h>
#include <signal.h>
#include <visualization_node.h>

int main(int argc, char **argv)
{
    ros::init(
        argc,
        argv,
        "scenario_visualization",
        ros::init_options::NoSigintHandler);
    if (ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME, ros::console::levels::Debug))
    {
        ros::console::notifyLoggerLevelsChanged();
    }
    ros::Time::init();
    signal(
        SIGINT,
        visualization::Node::ShuttingDownClearMarkers);

    double frequency{
        visualization::Node::DefaultFrequency()};
    ros::param::get(
        "/scenario/visualization_frequency",
        frequency);
    ROS_INFO_STREAM("visualization_frequency: " << frequency);
    visualization::Node visualizationNode;
    visualizationNode.Configure();
    visualizationNode.RunMainLoop();

    return 0;
}
