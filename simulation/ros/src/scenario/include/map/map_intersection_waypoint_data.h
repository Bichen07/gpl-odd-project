#ifndef _MAP_INTERSECTION_WAYPOINT_DATA_H_
#define _MAP_INTERSECTION_WAYPOINT_DATA_H_

#include <vector>
#include <utility>
#include <math_type.h>

namespace map {

struct IntersectionWaypointData final
{
    std::pair<int32_t, int32_t> index;
    std::vector<math::Vector3d_t> waypoints;
    std::vector<math::real_t> curvatures;
    std::vector<math::real_t> headings;

    IntersectionWaypointData()
        : index{std::make_pair(0, 0)}
        , waypoints{}
        , curvatures{}
        , headings{}
    {
    }
    explicit IntersectionWaypointData(
        const std::pair<int32_t, int32_t> &inputIndex,
        const std::vector<math::Vector3d_t> &inputWaypoints,
        const std::vector<math::real_t> &inputCurvatures,
        const std::vector<math::real_t> &inputHeadings)
        : index{inputIndex}
        , waypoints{inputWaypoints}
        , curvatures{inputCurvatures}
        , headings{inputHeadings}
    {
    }
    IntersectionWaypointData(const IntersectionWaypointData &other) = default;
    IntersectionWaypointData &operator=(const IntersectionWaypointData &other) = default;
    ~IntersectionWaypointData() = default;
};

} // namespace map {

#endif // #ifndef _MAP_INTERSECTION_WAYPOINT_DATA_H_
