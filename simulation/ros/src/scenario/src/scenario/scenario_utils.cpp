#include <scenario_utils.h>
#include <limits>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <actor_utils.h>
#include <motion_utils.h>

namespace scenario {

math::Vector3d_t ExtractClosestCrosswalkCorner(
    const measure::FrenetDistanceEvaluator &frenetDistanceEvaluator,
    const map::Crosswalk &crosswalk,
    const math::Vector3d_t &observerPoint)
{
    const auto corners{crosswalk.GetCorners()};

    math::real_t minDistance{std::numeric_limits<math::real_t>::max()};
    math::Vector3d_t outputCorner;
    for (const auto &corner: corners)
    {
        measure::FrenetDistanceData frenetDistanceData;
        frenetDistanceEvaluator.Compute(
            corner,
            observerPoint,
            true,
            &frenetDistanceData);
        if (std::fabs(frenetDistanceData.distance.s()) < minDistance)
        {
            minDistance = std::fabs(frenetDistanceData.distance.s());
            outputCorner = corner;
        }
    }

    return outputCorner;
}

} // namespace scenario {
