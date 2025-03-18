#ifndef _PATH_LANE_PAIR_PLANNED_OUTPUT_H_
#define _PATH_LANE_PAIR_PLANNED_OUTPUT_H_

#include <path_msgs/LanePairPlannedOutput.h>
#include <path_type.h>
#include <path_lane_pair.h>

namespace path {

struct LanePairPlannedOutput final
{
    LanePair lanePair;
    LaneIds plannedLaneIds;
    WaypointsArray plannedWaypointsArray;

    LanePairPlannedOutput()
        : lanePair{}
        , plannedLaneIds{}
        , plannedWaypointsArray{}
    {
    }
    explicit LanePairPlannedOutput(
        const LanePair &inputLanePair,
        const LaneIds &inputPlannedIds,
        const WaypointsArray &inputPlannedWaypointsArray)
        : lanePair{inputLanePair}
        , plannedLaneIds{inputPlannedIds}
        , plannedWaypointsArray{inputPlannedWaypointsArray}
    {
    }
    LanePairPlannedOutput(const LanePairPlannedOutput &other) = default;
    LanePairPlannedOutput &operator=(const LanePairPlannedOutput &other) = default;
    ~LanePairPlannedOutput() = default;
};

void ToLanePairPlannedOutputMsg(
    const LanePairPlannedOutput &input,
    path_msgs::LanePairPlannedOutput &outputMsg);
void ToLanePairPlannedOutputMsgs(
    const std::vector<LanePairPlannedOutput> &inputs,
    std::vector<path_msgs::LanePairPlannedOutput> &outputMsgs);

} // namespace path {

#endif // #ifndef _PATH_LANE_PAIR_PLANNED_OUTPUT_H_
