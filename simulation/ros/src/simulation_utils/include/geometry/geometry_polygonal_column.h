#ifndef _GEOMETRY_POLYGONAL_COLUMN_H_
#define _GEOMETRY_POLYGONAL_COLUMN_H_

#include <math_type.h>
#include <geometry_type.h>

namespace geometry {

class PolygonalColumn final
{

public:

    PolygonalColumn();
    explicit PolygonalColumn(
        const std::vector<math::Vector3d_t> &topPolygonCorners,
        const math::real_t height);
    PolygonalColumn(const PolygonalColumn &other);
    PolygonalColumn &operator=(const PolygonalColumn &other);
    virtual ~PolygonalColumn();

    math::real_t GetHeight() const;
    const math::Vector3d_t &GetCentroid3d() const;
    const std::vector<math::Vector3d_t> &GetTopPolygonCorners() const;
    const std::vector<math::Vector3d_t> &GetBottomPolygonCorners() const;
    const Polygon2d &GetPolygon2d() const;

    void Configure(
        const std::vector<math::Vector3d_t> &topPolygonCorners,
        const math::real_t height);

protected:

private:

    std::vector<math::Vector3d_t> mTopPolygonCorners;
    std::vector<math::Vector3d_t> mBottomPolygonCorners;
    math::real_t mHeight;
    math::Vector3d_t mCentroid3d;
    Polygon2d mPolygon2d;
};

} // namespace geometry {

#endif // #ifndef _GEOMETRY_POLYGONAL_COLUMN_H_
