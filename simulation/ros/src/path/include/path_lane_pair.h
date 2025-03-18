#ifndef _PATH_LANE_PAIR_H_
#define _PATH_LANE_PAIR_H_

#include <path_msgs/LanePair.h>
#include <path_interpolator_id.h>
#include <geometry_vector_3d.h>

namespace path {

struct LanePair final
{
    int32_t beginLaneId;
    int32_t endLaneId;
    InterpolatorId interpolatorId;
    std::vector<geometry::Vector3d> controlPoints;

    LanePair()
        : beginLaneId{0}
        , endLaneId{0}
        , interpolatorId{Interpolator::Null}
        , controlPoints{}
    {
    }
    LanePair(
        const int32_t inputBeginLaneId,
        const int32_t inputEndLaneId,
        const InterpolatorId &inputInterpolatorId,
        const std::vector<geometry::Vector3d> &inputControlPoints)
        : beginLaneId{inputBeginLaneId}
        , endLaneId{inputEndLaneId}
        , interpolatorId{inputInterpolatorId}
        , controlPoints{inputControlPoints}
    {
    }
    LanePair(const LanePair &other) = default;
    LanePair &operator=(const LanePair &other) = default;
    ~LanePair() = default;
};

void ToLanePair(
    const path_msgs::LanePair &msg,
    LanePair &output);
void ToLanePairs(
    const std::vector<path_msgs::LanePair> &msgs,
    std::vector<LanePair> &outputLanePairs);
void ToLanePairMsg(
    const LanePair &lanePair,
    path_msgs::LanePair &outputMsg);
void ToLanePairMsgs(
    const std::vector<LanePair> &lanePairs,
    std::vector<path_msgs::LanePair> &outputMsgs);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const LanePair &lanePair)
{
    ostream << "[LanePair]" << '\n' <<
        "beginLaneId: " << lanePair.beginLaneId << '\n' <<
        "endLaneId: " << lanePair.endLaneId << '\n' <<
        "interpolatorId: " << lanePair.interpolatorId << '\n' <<
        "controlPoints size: " << lanePair.controlPoints.size();
    std::copy(
        lanePair.controlPoints.cbegin(),
        lanePair.controlPoints.cend(),
        std::ostream_iterator<geometry::Vector3d>(ostream, "\n"));
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_LANE_PAIR_H_
