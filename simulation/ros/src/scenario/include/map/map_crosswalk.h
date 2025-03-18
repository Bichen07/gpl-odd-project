#ifndef _MAP_CROSSWALK_H_
#define _MAP_CROSSWALK_H_

#include <vector>
#include <math_vector_matcher.h>
#include <geometry_type.h>
#include <geometry_convex_hull_2d.h>

namespace map {

class Crosswalk final
{

public:

    Crosswalk();
    explicit Crosswalk(const std::vector<math::Vector3d_t> &inputCorners);
    Crosswalk(const Crosswalk &other);
    Crosswalk &operator=(const Crosswalk &other);
    virtual ~Crosswalk();

    const std::vector<math::Vector3d_t> &GetCorners() const;
    const math::Vector3d_t &GetCentroid() const;
    const std::vector<geometry::Edge3d> &GetEdges() const;

    void Configure(const std::vector<math::Vector3d_t> &inputCorners);

protected:

private:

    math::real_t ComputerAverageHeight(const std::vector<math::Vector3d_t> &vector3ds) const;

    std::vector<math::Vector3d_t> mCorners;
    geometry::ConvexHull2d mConvexHull2d;
    math::Vector3d_t mCentroid3d;
    std::vector<geometry::Edge3d> mEdges;
    math::VectorMatcher mVectorMatcher;
};

} // namespace map {

#endif // #ifndef _MAP_CROSSWALK_H_
