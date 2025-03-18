#include <visilibity_utils.h>
#include <algorithm>

namespace VisiLibity {

math::Vector2d_t ConvertToVector2d(const Point &point)
{
    return math::Vector2d_t(point.x(), point.y());
}

std::vector<math::Vector2d_t> ConvertToVector2ds(const std::vector<Point> &points)
{
    std::vector<math::Vector2d_t> outputs(points.size());
    std::transform(
        points.begin(),
        points.end(),
        outputs.begin(),
        [](const Point &point)
        {return math::Vector2d_t(point.x(), point.y());});

    return outputs;
}

Point ConvertToPoint(const math::Vector2d_t &vector2d)
{
    return Point(vector2d.x(), vector2d.y());
}

std::vector<Point> ConvertToPoints(const std::vector<math::Vector2d_t> &vector2ds)
{
    std::vector<Point> outputs(vector2ds.size());
    std::transform(
        vector2ds.begin(),
        vector2ds.end(),
        outputs.begin(),
        [](const math::Vector2d_t &vector2d)
        {return Point(vector2d.x(), vector2d.y());});

    return outputs;
}

std::vector<math::Vector2d_t> ExtractCorners(const Polygon &polygon)
{
    std::vector<math::Vector2d_t> corners(polygon.n());
    for (std::size_t idx{0ul}; idx < polygon.n(); ++idx)
    {
        corners[idx] = VisiLibity::ConvertToVector2d(polygon[idx]);
    }

    return corners;
}

} // namespace VisiLibity {
