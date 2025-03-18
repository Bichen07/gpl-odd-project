#include <geometry_convex_hull_2d.h>
#include <algorithm>
#include <boost/geometry/algorithms/convex_hull.hpp>
#include <ros/console.h>

namespace geometry {

// public func.

ConvexHull2d::ConvexHull2d()
    : mPolygon{}
    , mCorners{}
    , mCentroid{}
{
}

ConvexHull2d::ConvexHull2d(const std::vector<math::Vector2d_t> &points)
    : mPolygon{}
    , mCorners{}
    , mCentroid{}
{
    this->Compute(points);
}

ConvexHull2d::ConvexHull2d(const geometry_msgs::Polygon &inputPolygon)
    : mPolygon{}
    , mCorners{}
    , mCentroid{}
{
    std::vector<math::Vector2d_t> points(inputPolygon.points.size());
    std::transform(
        inputPolygon.points.cbegin(),
        inputPolygon.points.cend(),
        points.begin(),
        [](const geometry_msgs::Point32 &point32)
        {return math::Vector2d_t(point32.x, point32.y);});
}

ConvexHull2d::ConvexHull2d(const ConvexHull2d &other)
    : mPolygon{other.GetPolygon()}
    , mCorners{other.GetCorners()}
    , mCentroid{other.GetCentroid()}
{
}

ConvexHull2d &ConvexHull2d::operator=(const ConvexHull2d &other)
{
    if (&other == this)
    {
        return *this;
    }

    mPolygon = other.GetPolygon();
    mCorners = other.GetCorners();
    mCentroid = other.GetCentroid();

    return *this;
}

ConvexHull2d::~ConvexHull2d()
{
}

int32_t ConvexHull2d::GetCornerSize() const
{
    return static_cast<int32_t>(mCorners.size());
}

const Polygon2d &ConvexHull2d::GetPolygon() const
{
    return mPolygon;
}

const std::vector<math::Vector2d_t> &ConvexHull2d::GetCorners() const
{
    return mCorners;
}

const math::Vector2d_t &ConvexHull2d::GetCentroid() const
{
    return mCentroid;
}

void ConvexHull2d::Compute(const std::vector<math::Vector2d_t> &points)
{
    if (points.empty())
    {
        mPolygon = Polygon2d();
        mCorners.clear();
        mCentroid = math::Vector2d_t::Zero();
        return;
    }

    mPolygon = this->ComputeConvexHull(points);
    boost::geometry::centroid(mPolygon, mCentroid);

    mCorners.resize(mPolygon.outer().size());

    std::transform(
        mPolygon.outer().begin(),
        mPolygon.outer().end(),
        mCorners.begin(),
        [](const math::Vector2d_t &outer)
        {return outer;});
}

// protected func.

// private func.

Polygon2d ConvexHull2d::ComputeConvexHull(const std::vector<math::Vector2d_t> &points)
{
    Polygon2d candidate_polygon2d;
    boost::geometry::append(candidate_polygon2d, points);
    // Polygons should be closed and directed clockwise.
    // If you're not sure if that is the case, call the correct algorithm
    boost::geometry::correct(candidate_polygon2d);
    Polygon2d extracted_convex_hull;
    boost::geometry::convex_hull(candidate_polygon2d, extracted_convex_hull);

    return extracted_convex_hull;
}

} // namespace geometry {
