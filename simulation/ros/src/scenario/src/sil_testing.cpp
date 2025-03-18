#include <ros/init.h>
#include <math_coord.h>
#include <utils_ros_param.h>
#include <scenario_detected_object_coord.h>
#include <scenario_sil_testing_node.h>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "sil_testing");
    if (ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME, ros::console::levels::Debug))
    {
        ros::console::notifyLoggerLevelsChanged();
    }

    const double nodeFrequency{
        utils::GetRosParam<double>(
            "sil_testing/node_frequency")};
    const double detectedObjectFrequency{
        utils::GetRosParam<double>(
            "sil_testing/detected_object_frequency")};
    const double visualizationFrequency{
        utils::GetRosParam<double>(
            "sil_testing/visualization_frequency")};
    const scenario::DetectedObjectCoord detectedObjectCoord
    {
        .pose = ToCoord(
            utils::GetRosParam<std::string>("sil_testing/detected_object_pose_coord")),
        .velocity = ToCoord(
            utils::GetRosParam<std::string>("sil_testing/detected_object_velocity_coord")),
    };
    const int32_t detectedObjectIdOffset{
        utils::GetRosParam<int32_t>(
            "sil_testing/detected_object_id_offset")};

    ROS_DEBUG_STREAM_COND(
        true,
        "node_frequency: " << nodeFrequency << '\n' <<
        "detected_object_frequency: " << detectedObjectFrequency << '\n' <<
        "visualizatoin_frequency: " << visualizationFrequency << '\n' <<
        detectedObjectCoord << '\n' <<
        "detected_object_id_offset: " << detectedObjectIdOffset);

    scenario::SilTestingNode silTestingNode;
    silTestingNode.Configure(
        nodeFrequency,
        detectedObjectFrequency,
        visualizationFrequency,
        detectedObjectCoord,
        detectedObjectIdOffset);
    silTestingNode.RunMainLoop();

    return 0;
}
