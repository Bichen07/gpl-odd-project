#ifndef _SCENARIO_UTILS_H_
#define _SCENARIO_UTILS_H_

#include <math_type.h>
#include <map_crosswalk.h>
#include <actor_agent.h>
#include <actor_ego_vehicle_observer.h>
#include <measure_frenet_distance_evaluator.h>
#include <scenario_type.h>

namespace scenario {

math::Vector3d_t ExtractClosestCrosswalkCorner(
    const measure::FrenetDistanceEvaluator &frenetDistanceEvaluator,
    const map::Crosswalk &crosswalk,
    const math::Vector3d_t &observerPoint);

} // namespace scenario {

#endif // #ifndef _SCENARIO_UTILS_H_
