#include <geometry_utils.h>
#include <stdexcept>
#include <boost/foreach.hpp>
#include <ros/console.h>
#include <math_utils.h>

namespace geometry {

Edge3d ConvertToEdge3d(const Edge2d &edge2d, const math::real_t positionZ)
{
    const math::Vector3d_t beginPosition3d(
        edge2d.GetBeginPosition().x(),
        edge2d.GetBeginPosition().y(),
        positionZ);
    const math::Vector3d_t direction3d(
        edge2d.GetDirection().x(),
        edge2d.GetDirection().y(),
        0.0);

    Edge3d outputEdge3d(
        beginPosition3d,
        direction3d,
        edge2d.GetNorm());

    return outputEdge3d;
}

Rect2d ConvertToRect2d(const Rect3d &rect3d)
{
    Rect2d outputRect2d;

    outputRect2d.topLeft =
        math::Vector2d_t(rect3d.topLeft.x(), rect3d.topLeft.y());
    outputRect2d.topRight =
        math::Vector2d_t(rect3d.topRight.x(), rect3d.topRight.y());
    outputRect2d.bottomLeft =
        math::Vector2d_t(rect3d.bottomLeft.x(), rect3d.bottomLeft.y());
    outputRect2d.bottomRight =
        math::Vector2d_t(rect3d.bottomRight.x(), rect3d.bottomRight.y());

    return outputRect2d;
}

Rect3d ConvertToRect3d(const Rect2d &rect2d, const math::real_t positionZ)
{
    Rect3d outputRect3d;
    outputRect3d.topLeft = math::Vector3d_t(
        rect2d.topLeft.x(),
        rect2d.topLeft.y(),
        positionZ);
    outputRect3d.topRight = math::Vector3d_t(
        rect2d.topRight.x(),
        rect2d.topRight.y(),
        positionZ);
    outputRect3d.bottomLeft = math::Vector3d_t(
        rect2d.bottomLeft.x(),
        rect2d.bottomLeft.y(),
        positionZ);
    outputRect3d.bottomRight = math::Vector3d_t(
        rect2d.bottomRight.x(),
        rect2d.bottomRight.y(),
        positionZ);

    return outputRect3d;
}

Rect2d ComputeBoundingRect2d(const math::HomoXfm2d_t &xfm2d, const math::Vector2d_t &size)
{
    Rect2d outputRect2d;
    outputRect2d.topLeft =
        xfm2d * math::Vector2d_t(0.5 * size.x(), 0.5 * size.y());
    outputRect2d.topRight =
        xfm2d * math::Vector2d_t(0.5 * size.x(), -0.5 * size.y());
    outputRect2d.bottomLeft =
        xfm2d * math::Vector2d_t(-0.5 * size.x(), 0.5 * size.y());
    outputRect2d.bottomRight =
        xfm2d * math::Vector2d_t(-0.5 * size.x(), -0.5 * size.y());

    return outputRect2d;
}

Rect2d ComputeBoundingRect2d(
    const math::HomoXfm2d_t &xfm2d,
    const math::Vector2d_t &size,
    const math::Vector2d_t &localOffset)
{
    Rect2d outputRect2d;
    outputRect2d.topLeft =
        xfm2d *
        math::Vector2d_t(0.5 * size.x() + localOffset.x(), 0.5 * size.y() + localOffset.y());
    outputRect2d.topRight =
        xfm2d *
        math::Vector2d_t(0.5 * size.x() + localOffset.x(), -0.5 * size.y() + localOffset.y());
    outputRect2d.bottomLeft =
        xfm2d *
        math::Vector2d_t(-0.5 * size.x() + localOffset.x(), 0.5 * size.y() + localOffset.y());
    outputRect2d.bottomRight =
        xfm2d *
        math::Vector2d_t(-0.5 * size.x() + localOffset.x(), -0.5 * size.y() + localOffset.y());

    return outputRect2d;
}

Rect3d ComputeBoundingRect3d(const math::HomoXfm3d_t &xfm3d, const math::Vector2d_t &size)
{
    Rect3d outputRect3d;
    outputRect3d.topLeft =
        xfm3d * math::Vector3d_t(0.5 * size.x(), 0.5 * size.y(), 0.0);
    outputRect3d.topRight =
        xfm3d * math::Vector3d_t(0.5 * size.x(), -0.5 * size.y(), 0.0);
    outputRect3d.bottomLeft =
        xfm3d * math::Vector3d_t(-0.5 * size.x(), 0.5 * size.y(), 0.0);
    outputRect3d.bottomRight =
        xfm3d * math::Vector3d_t(-0.5 * size.x(), -0.5 * size.y(), 0.0);

    return outputRect3d;
}

template<typename VectorType>
std::vector<VectorType> ExtractCcwCorners(const Rect<VectorType> &rect)
{
    const std::vector<VectorType> outputCorners =
    {
        rect.topLeft,
        rect.bottomLeft,
        rect.bottomRight,
        rect.topRight
    };

    return outputCorners;
}
template std::vector<math::Vector2d_t> ExtractCcwCorners(const Rect<math::Vector2d_t> &);
template std::vector<math::Vector3d_t> ExtractCcwCorners(const Rect<math::Vector3d_t> &);

template<typename VectorType>
std::vector<VectorType> ExtractClosedCcwCorners(const Rect<VectorType> &rect)
{
    const std::vector<VectorType> outputCorners =
    {
        rect.topLeft,
        rect.bottomLeft,
        rect.bottomRight,
        rect.topRight,
        rect.topLeft
    };

    return outputCorners;
}
template std::vector<math::Vector2d_t> ExtractClosedCcwCorners(const Rect<math::Vector2d_t> &);
template std::vector<math::Vector3d_t> ExtractClosedCcwCorners(const Rect<math::Vector3d_t> &);

template<typename VectorType>
std::vector<VectorType> ExtractCwCorners(const Rect<VectorType> &rect)
{
    const std::vector<VectorType> outputCorners =
    {
        rect.topLeft,
        rect.topRight,
        rect.bottomRight,
        rect.bottomLeft
    };

    return outputCorners;
}
template std::vector<math::Vector2d_t> ExtractCwCorners(const Rect<math::Vector2d_t> &);
template std::vector<math::Vector3d_t> ExtractCwCorners(const Rect<math::Vector3d_t> &);

template<typename VectorType>
std::vector<VectorType> ExtractClosedCwCorners(const Rect<VectorType> &rect)
{
    const std::vector<VectorType> outputCorners =
    {
        rect.topLeft,
        rect.topRight,
        rect.bottomRight,
        rect.bottomLeft,
        rect.topLeft
    };

    return outputCorners;
}
template std::vector<math::Vector2d_t> ExtractClosedCwCorners(const Rect<math::Vector2d_t> &);
template std::vector<math::Vector3d_t> ExtractClosedCwCorners(const Rect<math::Vector3d_t> &);

template<typename VectorType>
std::vector<VectorType> GenerateClosedCorners(const std::vector<VectorType> &unclosedCorners)
{
    static constexpr math::real_t epsilon{1.0e-5};
    if (math::IsApprox(unclosedCorners.front(), unclosedCorners.back(), epsilon))
    {
        ROS_WARN_STREAM(
            "unclosedCorners have approximate front and back" << '\n' <<
            "front: " << unclosedCorners.front() << '\n' <<
            "back: " << unclosedCorners.back());
        return unclosedCorners;
    }
    std::vector<VectorType> closedCorners(unclosedCorners.size() + 1ul);
    std::copy(
        unclosedCorners.cbegin(),
        unclosedCorners.cend(),
        closedCorners.begin());
    closedCorners.back() = unclosedCorners.front();

    return closedCorners;
}
template std::vector<math::Vector2d_t> GenerateClosedCorners(const std::vector<math::Vector2d_t> &);
template std::vector<math::Vector3d_t> GenerateClosedCorners(const std::vector<math::Vector3d_t> &);

Polygon2d ComputePolygon(const Rect2d &rect2d)
{
    return geometry::ComputePolygon(
        geometry::ExtractPolygonClosedCorners(rect2d));
}

Polygon2d ComputePolygon(const std::vector<math::Vector2d_t> &closedCwCorners)
{
    Polygon2d outputPolygon;
    boost::geometry::append(
        outputPolygon.outer(),
        closedCwCorners);

    boost::geometry::validity_failure_type failure;
    const bool valid = boost::geometry::is_valid(outputPolygon, failure);
    //const bool not_closed = boost::geometry::failure_not_closed == failure;
    //const bool wrong_orientation = boost::geometry::failure_wrong_orientation == failure;
    //std::cout << "is valid? " << (valid ? "yes" : "no") << std::endl;
    //std::cout << "boost::geometry::failure_not_closed: " << boost::geometry::failure_not_closed << '\n' <<
    //    "boost::geometry::failure_wrong_orientation: " << boost::geometry::failure_wrong_orientation << '\n' <<
    //    "failure: " << failure << std::endl;

    if (!valid)
    {
        const bool could_be_fixed =
            boost::geometry::failure_not_closed == failure ||
            boost::geometry::failure_wrong_orientation == failure;
        std::string invalid_reason;
        boost::geometry::is_valid(outputPolygon, invalid_reason);
        if (!could_be_fixed)
        {
            const bool isFewPoints =
                (boost::geometry::failure_few_points == failure) &&
                (3u == closedCwCorners.size());

            if (!isFewPoints)
            {
                ROS_WARN_STREAM(
                    "geometry failure could not be fixed, failure: " << failure << '\n' <<
                    "reason: " << invalid_reason);

                //if (boost::geometry::failure_self_intersections == failure)
                //{
                //    ROS_ERROR_STREAM("failure self intersections");
                //    for (auto corner{closedCwCorners.begin()};
                //         corner != closedCwCorners.end();
                //         ++corner)
                //    {
                //        std::cout << std::setprecision(5) << std::fixed <<
                //            corner->transpose() << '\n';
                //    }
                //    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
                //}

                //if (boost::geometry::failure_wrong_topological_dimension == failure)
                //{
                //    ROS_ERROR_STREAM("failure wrong topological dimension");
                //    for (auto corner{closedCwCorners.cbegin()};
                //         corner != closedCwCorners.cend();
                //         ++corner)
                //    {
                //        std::cout << std::setprecision(5) << std::fixed <<
                //            corner->transpose() << '\n';
                //    }
                //    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
                //}
            }
        }
        else
        {
            boost::geometry::correct(outputPolygon);
            ROS_WARN_STREAM("failure: " << failure);
            std::cout << "after correction: " <<
                (boost::geometry::is_valid(outputPolygon) ? "valid" : "still invalid") <<
                std::endl;
        }
    }

    return outputPolygon;
}

math::real_t ComputeArea(const Polygon2d &polygon)
{
    return boost::geometry::area(polygon);
}

math::real_t ComputeIntersectionArea(const Polygon2d &first, const Polygon2d &second)
{
    std::deque<Polygon2d> outputs;
    boost::geometry::intersection(first, second, outputs);

    math::real_t intersectionArea{0.0};
    BOOST_FOREACH(Polygon2d const &output, outputs)
    {
        intersectionArea += boost::geometry::area(output);
    }

    return intersectionArea;
}

template<typename VectorType>
std::vector<VectorType> ExtractPolygonClosedCorners(const Rect<VectorType> &inputRect)
{
    const std::vector<VectorType> outputCorners =
    {
        inputRect.bottomLeft,
        inputRect.topLeft,
        inputRect.topRight,
        inputRect.bottomRight,
        inputRect.bottomLeft,
    };

    return outputCorners;
}
template std::vector<math::Vector2d_t> ExtractPolygonClosedCorners(const Rect<math::Vector2d_t> &);
template std::vector<math::Vector3d_t> ExtractPolygonClosedCorners(const Rect<math::Vector3d_t> &);

template<typename VectorType>
std::vector<VectorType> ExtractCorners(const Rect<VectorType> &inputRect)
{
    std::vector<VectorType> outputPoints =
    {
//        inputRect.topLeft,
//        inputRect.bottomLeft,
//        inputRect.bottomRight,
//        inputRect.topRight
//
        inputRect.bottomLeft,
        inputRect.topLeft,
        inputRect.topRight,
        inputRect.bottomRight,
    };

    return outputPoints;
}
template std::vector<math::Vector2d_t> ExtractCorners(const Rect<math::Vector2d_t> &);
template std::vector<math::Vector3d_t> ExtractCorners(const Rect<math::Vector3d_t> &);

template<typename VectorType>
bool IsZero(const Rect<VectorType> &inputRect)
{
    const math::real_t width = (inputRect.topLeft - inputRect.topRight).norm();
    if (math::IsApproxZero(width, 1.0e-6))
    {
        return true;
    }

    const math::real_t length = (inputRect.topLeft - inputRect.bottomLeft).norm();
    if (math::IsApproxZero(length, 1.0e-6))
    {
        return true;
    }

    return false;
}
template bool IsZero(const Rect<math::Vector2d_t> &);
template bool IsZero(const Rect<math::Vector3d_t> &);

template<> bool IsValidSize(const math::Vector2d_t &inputSize, const math::real_t epsilon)
{
    if (epsilon < 0.0)
    {
        ROS_ERROR_STREAM("invalid epsilon: " << epsilon);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        return false;
    }

    if (inputSize.x() < epsilon)
    {
        ROS_WARN_STREAM("invalid inputSize.x(): " << inputSize.x());
        return false;
    }

    if (inputSize.y() < epsilon)
    {
        ROS_WARN_STREAM("invalid inputSize.y(): " << inputSize.y());
        return false;
    }

    return true;
}
template<> bool IsValidSize(const math::Vector3d_t &inputSize, const math::real_t epsilon)
{
    if (epsilon < 0.0)
    {
        ROS_ERROR_STREAM("invalid epsilon: " << epsilon);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        return false;
    }

    if (inputSize.x() < epsilon)
    {
        ROS_WARN_STREAM("invalid inputSize.x(): " << inputSize.x());
        return false;
    }

    if (inputSize.y() < epsilon)
    {
        ROS_WARN_STREAM("invalid inputSize.y(): " << inputSize.y());
        return false;
    }

    if (inputSize.z() < epsilon)
    {
        ROS_WARN_STREAM("invalid inputSize.z(): " << inputSize.z());
        return false;
    }

    return true;
}

template<typename VectorType>
std::vector<VectorType> SortPoints(
    const std::vector<math::Vector2d_t> &refPoint2ds,
    const std::vector<VectorType> &unarrangedPoints,
    const math::real_t distanceXyEpsilon)
{
    if (refPoint2ds.size() != unarrangedPoints.size())
    {
        ROS_ERROR_STREAM(
            "refPoint2ds and unarrangedPoints have diff. size" << '\n' <<
            "refPoint2ds: " << refPoint2ds.size() << '\n' <<
            "unarrangedPoints: " << unarrangedPoints.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    std::vector<VectorType> arrangedPoints(unarrangedPoints.size());
    auto arrangedPoint{arrangedPoints.begin()};
    for (auto refPoint2d{refPoint2ds.cbegin()};
         refPoint2d != refPoint2ds.cend();
         ++refPoint2d, ++arrangedPoint)
    {
        const auto foundUnarrangedPoint = std::find_if(
            unarrangedPoints.cbegin(),
            unarrangedPoints.cend(),
            [&refPoint2d, &distanceXyEpsilon](const VectorType &unarrangedPoint)
            {
                const math::real_t distance = std::hypot(
                    refPoint2d->x() - unarrangedPoint.x(),
                    refPoint2d->y() - unarrangedPoint.y());
                return distance < distanceXyEpsilon;
            });

        if (unarrangedPoints.cend() == foundUnarrangedPoint)
        {
            ROS_WARN_STREAM("refPoint2ds and unarrangedPoints are not closed in Xy-plane");
            return std::vector<VectorType>();
        }

        *arrangedPoint = *foundUnarrangedPoint;
    }

    return arrangedPoints;
}
template std::vector<math::Vector2d_t> SortPoints(
    const std::vector<math::Vector2d_t> &,
    const std::vector<math::Vector2d_t> &,
    const math::real_t);
template std::vector<math::Vector3d_t> SortPoints(
    const std::vector<math::Vector2d_t> &,
    const std::vector<math::Vector3d_t> &,
    const math::real_t);

} // namespace geometry {
