#ifndef _METRIC_UTILS_H_
#define _METRIC_UTILS_H_

#include <metric_type.h>

namespace metric {

void ExtractTrajectories(
    const Trajectory &wholeTrajectory,
    const std::vector<Indexes> &indexesSet,
    Trajectories &outputTrajectories);

} // namespace metric {

#endif // #ifndef _METRIC_UTILS_H_
