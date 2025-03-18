#include <path_lane_pair.h>

namespace path {

void ToLanePair(
    const path_msgs::LanePair &msg,
    LanePair &output)
{
    output.beginLaneId = msg.begin_lane_id;
    output.endLaneId = msg.end_lane_id;
    output.interpolatorId = static_cast<InterpolatorId>(msg.interpolator_id);
    output.controlPoints.resize(msg.control_points.size());
    std::transform(
        msg.control_points.cbegin(),
        msg.control_points.cend(),
        output.controlPoints.begin(),
        [](const geometry_msgs::Point &input)
        {return geometry::Vector3d(input);});
}

void ToLanePairs(
    const std::vector<path_msgs::LanePair> &msgs,
    std::vector<LanePair> &outputLanePairs)
{
    outputLanePairs.resize(msgs.size());
    auto msg{msgs.cbegin()};
    auto outputLanePair{outputLanePairs.begin()};
    for (; msg != msgs.cend(); ++msg, ++outputLanePair)
    {
        path::ToLanePair(
            *msg,
            *outputLanePair);
    }
}

void ToLanePairMsg(
    const LanePair &lanePair,
    path_msgs::LanePair &outputMsg)
{
    outputMsg.begin_lane_id = lanePair.beginLaneId;
    outputMsg.end_lane_id = lanePair.endLaneId;
    outputMsg.interpolator_id = static_cast<typename std::underlying_type<InterpolatorId>::type>(
        lanePair.interpolatorId);
    outputMsg.control_points.resize(
        lanePair.controlPoints.size());
    std::transform(
        lanePair.controlPoints.cbegin(),
        lanePair.controlPoints.cend(),
        outputMsg.control_points.begin(),
        [](const geometry::Vector3d &input)
        {return input.ToPoint();});
}

void ToLanePairMsgs(
    const std::vector<LanePair> &lanePairs,
    std::vector<path_msgs::LanePair> &outputMsgs)
{
    outputMsgs.resize(lanePairs.size());
    auto lanePair{lanePairs.cbegin()};
    auto outputMsg{outputMsgs.begin()};
    for (; lanePair != lanePairs.cend(); ++lanePair, ++outputMsg)
    {
        path::ToLanePairMsg(
            *lanePair,
            *outputMsg);
    }
}

} // namespace path {
