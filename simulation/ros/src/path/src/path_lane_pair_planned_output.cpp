#include <path_lane_pair_planned_output.h>

namespace path {

void ToLanePairPlannedOutputMsg(
    const LanePairPlannedOutput &input,
    path_msgs::LanePairPlannedOutput &outputMsg)
{
    path::ToLanePairMsg(
        input.lanePair,
        outputMsg.lane_pair);
    outputMsg.planned_lane_ids = input.plannedLaneIds;

    outputMsg.planned_waypoints_array.resize(input.plannedWaypointsArray.size());
    auto inputWaypoints{input.plannedWaypointsArray.cbegin()};
    auto outputWaypoints{outputMsg.planned_waypoints_array.begin()};
    for (; inputWaypoints != input.plannedWaypointsArray.cend();
         ++inputWaypoints, ++outputWaypoints)
    {
        geometry::ToGeometryMsgsArray(
            *inputWaypoints,
            outputWaypoints->points);
    }
}

void ToLanePairPlannedOutputMsgs(
    const std::vector<LanePairPlannedOutput> &inputs,
    std::vector<path_msgs::LanePairPlannedOutput> &outputMsgs)
{
    outputMsgs.resize(inputs.size());
    auto input{inputs.cbegin()};
    auto outputMsg{outputMsgs.begin()};
    for (; input != inputs.cend(); ++input, ++outputMsg)
    {
        path::ToLanePairPlannedOutputMsg(
            *input,
            *outputMsg);
    }
}

} // namespace path {
