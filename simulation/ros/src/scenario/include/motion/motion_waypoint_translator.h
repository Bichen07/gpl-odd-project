#ifndef _MOTION_WAYPOINT_TRANSLATOR_H_
#define _MOTION_WAYPOINT_TRANSLATOR_H_

#include <math_type.h>
#include <math_frenet_coord.h>

namespace motion {

class WaypointTranslator final
{

public:

    WaypointTranslator();
    WaypointTranslator(const WaypointTranslator &) = delete;
    WaypointTranslator &operator=(const WaypointTranslator &) = delete;
    virtual ~WaypointTranslator();

    std::vector<math::Vector3d_t> Compute(
        const std::vector<math::Vector3d_t> &inputWaypoints,
        const math::FrenetCoord &offset,
        const int32_t refWaypointIdx) const;

protected:

private:

    bool IsValidWaypointIdx(
        const std::vector<math::Vector3d_t> &inputWaypoints,
        const int32_t idx) const;
};

} // namespace motion {

#endif // #ifndef _MOTION_WAYPOINT_TRANSLATOR_H_
