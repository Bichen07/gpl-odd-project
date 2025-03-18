#ifndef _METRIC_TYPE_H_
#define _METRIC_TYPE_H_

#include <vector>
#include <math_type.h>

namespace metric {

typedef std::vector<int32_t> Indexes;
typedef std::vector<math::Vector3d_t> Trajectory;
typedef std::vector<Trajectory> Trajectories;

} // namespace metric {

#endif // #ifndef _METRIC_TYPE_H_
