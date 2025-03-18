#include <ros/init.h>
#include <ros/console.h>
#include <utils_ros_param.h>
#include <rss_verification_node.h>

int main(int argc, char **argv)
{
    ROS_ERROR_STREAM("RSS VERFI IN MAIN");
    ros::init(argc, argv, "rss");
    if (ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME, ros::console::levels::Debug))
    {
        ros::console::notifyLoggerLevelsChanged();
    }
    ros::Time::init();
    spdlog::set_level(spdlog::level::err);
    const double          nodeFrequency{utils::GetRosParam<double>("rss/verification_node/node_frequency")};
    rss::VerificationNode node;
    node.Configure(nodeFrequency);
    node.RunMainLoop();

    return 0;
}
