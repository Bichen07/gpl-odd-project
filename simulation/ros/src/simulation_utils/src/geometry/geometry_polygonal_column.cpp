#include <geometry_polygonal_column.h>
#include <stdexcept>
#include <utils_converter.h>
#include <geometry_utils.h>

namespace geometry {

// public func.

PolygonalColumn::PolygonalColumn()
    : mTopPolygonCorners{}
    , mBottomPolygonCorners{}
    , mHeight{0.0}
    , mCentroid3d{}
    , mPolygon2d{}
{
}

PolygonalColumn::PolygonalColumn(
    const std::vector<math::Vector3d_t> &topPolygonCorners,
    const math::real_t height)
    : mTopPolygonCorners{}
    , mBottomPolygonCorners{}
    , mHeight{0.0}
    , mCentroid3d{}
    , mPolygon2d{}
{
    this->Configure(
        topPolygonCorners,
        height);
}

PolygonalColumn::PolygonalColumn(const PolygonalColumn &other)
    : mTopPolygonCorners{other.GetTopPolygonCorners()}
    , mBottomPolygonCorners{other.GetBottomPolygonCorners()}
    , mHeight{other.GetHeight()}
    , mCentroid3d{other.GetCentroid3d()}
    , mPolygon2d{other.GetPolygon2d()}
{
}

PolygonalColumn &PolygonalColumn::operator=(const PolygonalColumn &other)
{
    if (&other == this)
    {
        return *this;
    }

    mTopPolygonCorners = other.GetTopPolygonCorners();
    mBottomPolygonCorners = other.GetBottomPolygonCorners();
    mHeight = other.GetHeight();
    mCentroid3d = other.GetCentroid3d();
    mPolygon2d = other.GetPolygon2d();

    return *this;
}

PolygonalColumn::~PolygonalColumn()
{
}

math::real_t PolygonalColumn::GetHeight() const
{
    return mHeight;
}

const math::Vector3d_t &PolygonalColumn::GetCentroid3d() const
{
    return mCentroid3d;
}

const std::vector<math::Vector3d_t> &PolygonalColumn::GetTopPolygonCorners() const
{
    return mTopPolygonCorners;
}

const std::vector<math::Vector3d_t> &PolygonalColumn::GetBottomPolygonCorners() const
{
    return mBottomPolygonCorners;
}

const Polygon2d &PolygonalColumn::GetPolygon2d() const
{
    return mPolygon2d;
}

void PolygonalColumn::Configure(
    const std::vector<math::Vector3d_t> &topPolygonCorners,
    const math::real_t height)
{
    if (height < 0.0)
    {
        ROS_ERROR_STREAM("invalid height: " << height);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mTopPolygonCorners = topPolygonCorners;
    mHeight = height;
    mBottomPolygonCorners.resize(mTopPolygonCorners.size());
    std::transform(
        mTopPolygonCorners.begin(),
        mTopPolygonCorners.end(),
        mBottomPolygonCorners.begin(),
        [this](const math::Vector3d_t &topCorner)
        {return math::Vector3d_t(topCorner.x(), topCorner.y(), topCorner.z() - mHeight);});
    mPolygon2d = geometry::ComputePolygon(
        utils::ConvertToVector2ds(mTopPolygonCorners));

    math::Vector2d_t centroid2d;
    boost::geometry::centroid(mPolygon2d, centroid2d);
    mCentroid3d = math::Vector3d_t(
        centroid2d.x(),
        centroid2d.y(),
        mTopPolygonCorners.front().z() - 0.5 * mHeight);
}

// protected func.

// private func.

} // namespace geometry {
