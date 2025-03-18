#ifndef _GEOMETRY_CONVEX_HULL_2D_H_
#define _GEOMETRY_CONVEX_HULL_2D_H_

#include <limits>
#include <vector>
#include <geometry_msgs/Polygon.h>
#include <math_type.h>
#include <geometry_type.h>

namespace geometry {

class ConvexHull2d final
{

public:

    ConvexHull2d();
    explicit ConvexHull2d(const std::vector<math::Vector2d_t> &points);
    ConvexHull2d(const geometry_msgs::Polygon &inputPolygon);
    ConvexHull2d(const ConvexHull2d &other);
    ConvexHull2d &operator=(const ConvexHull2d &other);
    virtual ~ConvexHull2d();

    int32_t GetCornerSize() const;
    const Polygon2d &GetPolygon() const;
    const std::vector<math::Vector2d_t> &GetCorners() const;
    const math::Vector2d_t &GetCentroid() const;

    void Compute(const std::vector<math::Vector2d_t> &points);

protected:

private:

    Polygon2d ComputeConvexHull(const std::vector<math::Vector2d_t> &points);

    Polygon2d mPolygon;
    std::vector<math::Vector2d_t> mCorners;
    math::Vector2d_t mCentroid;
};

} // namespace geometry {

#endif // #ifndef _GEOMETRY_CONVEX_HULL_2D_H_
