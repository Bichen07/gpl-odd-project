#include <rss_intersection.h>
#include <limits>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>

namespace rss {

// public func.

Intersection::Intersection()
    : mId{std::numeric_limits<int32_t>::max()}
    , mCorners{}
    , mConvexHull2d{}
    , mCornerPoints{}
{
}

Intersection::Intersection(
    const int32_t id,
    const std::vector<geometry::Vector3d> &corners)
    : mId{std::numeric_limits<int32_t>::max()}
    , mCorners{}
    , mConvexHull2d{}
    , mCornerPoints{}
{
    this->Compute(id, corners);
}

int32_t Intersection::GetId() const
{
    return mId;
}

const std::vector<geometry_msgs::Point> &Intersection::GetCornerPoints() const
{
    return mCornerPoints;
}

const geometry::Polygon2d &Intersection::GetPolygon() const
{
    return mConvexHull2d.GetPolygon();
}

void Intersection::Compute(
    const int32_t id,
    const std::vector<geometry::Vector3d> &corners)
{
    if (corners.size() != CornerSize())
    {
        ROS_ERROR_STREAM("invalid corners size: " << corners.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mId = id;
    std::vector<math::Vector2d_t> corner2ds(corners.size());
    std::transform(
        corners.cbegin(),
        corners.cend(),
        corner2ds.begin(),
        [](const geometry::Vector3d &corner2d)
        {return math::Vector2d_t(corner2d.x(), corner2d.y());});

    mConvexHull2d.Compute(corner2ds);
    if ((CornerSize() + 1ul) != mConvexHull2d.GetCornerSize())
    {
        ROS_ERROR_STREAM(
            "invalid corner size of mConvexHull2d: " <<
            mConvexHull2d.GetCornerSize() << '\n' <<
            " of id: " << mId);
        std::copy(
            mConvexHull2d.GetCorners().cbegin(),
            mConvexHull2d.GetCorners().cend(),
            std::ostream_iterator<math::Vector2d_t>(std::cout, "\n"));
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mCorners = this->SyncCorners(
        mConvexHull2d.GetCorners(),
        corners);

    mCornerPoints.resize(mCorners.size());
    std::transform(
        mCorners.cbegin(),
        mCorners.cend(),
        mCornerPoints.begin(),
        [](const geometry::Vector3d &vector3d)
        {return vector3d.ToPoint();});
}

// protected func.

// private func.

std::vector<geometry::Vector3d> Intersection::SyncCorners(
    const std::vector<math::Vector2d_t> &convexHullCorners,
    const std::vector<geometry::Vector3d> &inputCorner3ds) const
{
    //if (CornerSize() != convexHullCorners.size() ||
    //    convexHullCorners.size() != inputCorner3ds.size())
    //{
    //    ROS_ERROR_STREAM(
    //        "diff. corner sizes" << '\n' <<
    //        "convexHullCorners: " << convexHullCorners.size() << '\n' <<
    //        "inputCorners3ds: " << inputCorner3ds.size());
    //    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    //}

    std::vector<geometry::Vector3d> outputs{convexHullCorners.size() - 1ul};
    auto output{outputs.begin()};
    for (auto convexHullCorner{convexHullCorners.cbegin()};
         convexHullCorner != convexHullCorners.cend() - 1;
         ++convexHullCorner, ++output)
    {
        const auto foundCorner3d{
            std::find_if(
                inputCorner3ds.cbegin(),
                inputCorner3ds.cend(),
                [&convexHullCorner](const geometry::Vector3d &corner3d)
                {return math::IsApprox(geometry::Vector2d(*convexHullCorner), corner3d.ToVectorXy(), 10.e-5);})};
        if (inputCorner3ds.end() == foundCorner3d)
        {
            ROS_ERROR_STREAM(
                "no matched corner2d and corner3d pairs" << '\n' <<
                "convexHullCorner: " << convexHullCorner->transpose() << '\n' <<
                "conrer3d: ");
            std::copy(
                inputCorner3ds.cbegin(),
                inputCorner3ds.cend(),
                std::ostream_iterator<geometry::Vector3d>(std::cout, "\n"));
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        *output = *foundCorner3d;
    }

    return outputs;
}

} // namespace rss {
