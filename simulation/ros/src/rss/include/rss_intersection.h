#ifndef _RSS_INTERSECTION_H_
#define _RSS_INTERSECTION_H_

#include <memory>
#include <vector>
#include <geometry_msgs/Point.h>
#include <geometry_convex_hull_2d.h>
#include <geometry_intersection_evaluator.h>
#include <geometry_vector_3d.h>

namespace rss {

class Intersection final
{

public:

    using Ptr = std::shared_ptr<Intersection>;

    static constexpr std::size_t CornerSize()
    {return uint32_t{4ul};}

    Intersection();
    Intersection(
        const int32_t id,
        const std::vector<geometry::Vector3d> &corners);
    Intersection(const Intersection &) = delete;
    Intersection &operator=(const Intersection &) = delete;
    virtual ~Intersection() = default;

    int32_t GetId() const;
    const std::vector<geometry_msgs::Point> &GetCornerPoints() const;
    const geometry::Polygon2d &GetPolygon() const;
    void Compute(
        const int32_t id,
        const std::vector<geometry::Vector3d> &conrers);

protected:

private:

    std::vector<geometry::Vector3d> SyncCorners(
        const std::vector<math::Vector2d_t> &convexHullCorners,
        const std::vector<geometry::Vector3d> &inputCorenr3ds) const;

    int32_t mId;
    std::vector<geometry::Vector3d> mCorners;
    geometry::ConvexHull2d mConvexHull2d;
    std::vector<geometry_msgs::Point> mCornerPoints;
};

} // namespace rss {

#endif // #ifndef _RSS_INTERSECTION_H_
