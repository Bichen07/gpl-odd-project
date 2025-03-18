#ifndef _PATH_OPPOSITE_LANE_BUILDER_H_
#define _PATH_OPPOSITE_LANE_BUILDER_H_

#include <map>
#include <string>
#include <path_type.h>
#include <path_lanes_navgroad.h>
#include <path_connected_lane_evaluator.h>

namespace path {

class OppositeLaneBuilder final
{

public:

    OppositeLaneBuilder();
    OppositeLaneBuilder(const OppositeLaneBuilder &other) = delete;
    OppositeLaneBuilder &operator=(const OppositeLaneBuilder &other) = delete;
    virtual ~OppositeLaneBuilder() = default;

    void Configure(
        const std::string &lanesNavgroadsFileName,
        ConnectedLaneEvaluator::Ptr &connectedLaneEvaluator);
    void ComputeOppositeLaneIdsArray(
        const LaneIds &forwardLaneIds,
        LaneIdsArray &oppositeLaneIdsArray);

protected:

private:

    LaneIds QueryOppositeLanes(const LanesNavgroad &lanesNavgroad) const;
    void AppendOppositeLanes(
        const LaneIds &newLaneIds,
        LaneIdsArray &outputLaneIdsArray);

    std::map<int32_t, LanesNavgroad> mLanesNavgroadMap;
    std::multimap<int32_t, LanesNavgroad> mBeginNavgroadMap;
    ConnectedLaneEvaluator::Ptr mConnectedLaneEvaluator;
};

} // namespace path {

#endif // #ifndef _PATH_OPPOSITE_LANE_BUILDER_H_
