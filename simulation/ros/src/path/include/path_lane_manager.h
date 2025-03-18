#ifndef _PATH_LANE_MANAGER_H_
#define _PATH_LANE_MANAGER_H_

#include <vector>
#include <map>
#include <string>
#include <path_navgroad_endpoint.h>

namespace path {

class LaneManager final
{

public:

    using NavgroadPair = std::pair<NavgroadEndpoint, NavgroadEndpoint>;

    LaneManager();
    LaneManager(const LaneManager &) = delete;
    LaneManager &operator=(const LaneManager &) = delete;
    virtual ~LaneManager() = default;

    void Configure(
        const std::string &lanesInfoFileName,
        const std::string &lanesNavgroadsFilesName);
    const NavgroadPair &QueryNavgroad(const int32_t laneId) const;
    bool IsConnectedLaneIdPair(
        const int32_t precedingLaneId,
        const int32_t succeedingLaneId) const;
    bool IsAdjacentLanePair(
        const int32_t firstLaneId,
        const int32_t secondLaneId) const;
    bool IsOppositeLanePair(
        const int32_t forwardLaneId,
        const int32_t oppositeLaneId) const;

protected:

private:

    using LaneIds = std::vector<int32_t>;
    using LaneNavgroadMap = std::map<int32_t, NavgroadPair>;

    void ParseLanesInfo(const std::string &lanesInfoFileName);
    void ParseLaneNavgroads(const std::string &lanesNavgroadFileName);

    std::map<int32_t, LaneIds> mNextLaneIdMap;
    LaneNavgroadMap mLaneNavgroadMap;
};

} // namespace path {

#endif // #ifndef _PATH_LANE_MANAGER_H_
