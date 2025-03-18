#include <ros/init.h>
#include <ros/console.h>
#include <metric_min_bounding_envelope_node.h>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "metric");
    if (ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME, ros::console::levels::Debug))
    {
        ros::console::notifyLoggerLevelsChanged();
    }

    ros::Time::init();
    metric::MinBoundingEnvelopeNode node;
    node.Configure();
    node.RunMainLoop();

    return 0;
}
