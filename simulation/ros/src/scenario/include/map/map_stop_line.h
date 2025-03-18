#ifndef _MAP_STOP_LINE_H_
#define _MAP_STOP_LINE_H_

#include <vector>
#include <map>
#include <math_vector_matcher.h>
#include <geometry_type.h>
#include <geometry_convex_hull_2d.h>

namespace map {

class StopLine final
{

public:

    StopLine();
    explicit StopLine(const std::vector<math::Vector3d_t> &inputCorner3ds);
    explicit StopLine(
        const std::vector<math::Vector3d_t> &inputCorner3ds,
        const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap);
    StopLine(const StopLine &other);
    StopLine &operator=(const StopLine &other);
    virtual ~StopLine();

    const std::vector<math::Vector3d_t> &GetCorner3ds() const;
    const math::Vector3d_t &GetCentroid3d() const;
    const std::map<int32_t, std::vector<int32_t>> &GetLanePointIdMap() const;

    void Configure(const std::vector<math::Vector3d_t> &inputCorner3ds);
    void Configure(
        const std::vector<math::Vector3d_t> &inputCorner3ds,
        const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap);

protected:

private:

    std::vector<math::Vector3d_t> mCorner3ds;
    math::Vector3d_t mCentroid3d;
    geometry::ConvexHull2d mConvexHull2d;
    std::map<int32_t, std::vector<int32_t>> mLanePointIdMap;
    math::VectorMatcher mVectorMatcher;
};

} // namespace map {

#endif // #ifndef _MAP_STOP_LINE_H_
