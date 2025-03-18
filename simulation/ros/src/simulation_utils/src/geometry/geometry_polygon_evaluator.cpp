#include <geometry_polygon_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>
#include <geometry_utils.h>

namespace geometry {

// public func.

PolygonEvaluator::PolygonEvaluator()
    : mPointSequence3d{}
    , mPointSequence2d{}
    , mFrenetTransformer{}
{
}

PolygonEvaluator::~PolygonEvaluator()
{
}

Polygon2d PolygonEvaluator::Compute(
    const math::real_t beginLongitudinalDistance,
    const math::real_t lateralWidth,
    const math::real_t forwardDistance) const
{
    if (mFrenetTransformer.IsEmpty())
    {
        ROS_ERROR_STREAM("mFrenetTransformer is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (beginLongitudinalDistance < 0.0)
    {
        ROS_ERROR_STREAM("invalid beginLongitudinalDistance: " << beginLongitudinalDistance);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (lateralWidth < 1.0e-2)
    {
        ROS_ERROR_STREAM("invalid lateralWidth: " << lateralWidth);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const math::FrenetCoord beginFrenetCenter(beginLongitudinalDistance, 0.0);
    const math::FrenetCoord endFrenetCenter(
        beginLongitudinalDistance + forwardDistance, 0.0);
    const auto indices = mFrenetTransformer.ComputeWaypointIdx(
        beginFrenetCenter,
        endFrenetCenter);

    if (1u == indices.size())
    {
        const math::real_t halfLateralWidth = 0.5 * lateralWidth;
        const auto beginCorner = mFrenetTransformer.ConvertToCartesianCoord(
            math::FrenetCoord(beginFrenetCenter.s(), beginFrenetCenter.d() + halfLateralWidth));
        const auto endCorner = mFrenetTransformer.ConvertToCartesianCoord(
            math::FrenetCoord(beginFrenetCenter.s(), beginFrenetCenter.d() - halfLateralWidth));

        const std::vector<math::Vector2d_t> polygonCorners(
            {beginCorner, endCorner, beginCorner});

        return geometry::ComputePolygon(polygonCorners);
    }

    std::vector<math::FrenetCoord> intermediateFrenetCenters;
    intermediateFrenetCenters.reserve(indices.size());
    std::transform(
        indices.begin() + 1,
        indices.end(),
        std::back_inserter(intermediateFrenetCenters),
        [this](const int32_t index)
        {return mFrenetTransformer.WaypointSd(index);});

    std::vector<math::FrenetCoord> frenetCenters;
    frenetCenters.reserve(indices.size() + 1ul);

    const bool isClosedBeginFrenetCenter = math::IsApprox(
        beginFrenetCenter.s(),
        intermediateFrenetCenters.front().s(),
        0.2);
    if (!isClosedBeginFrenetCenter)
    {
        frenetCenters.push_back(beginFrenetCenter);
        //ROS_ERROR_STREAM("begin frenet diff: "
        //     << beginFrenetCenter.s() - intermediateFrenetCenters.front().s());
    }
    //else
    //{
    //    ROS_ERROR_STREAM("closed begin frenet diff: "
    //         << beginFrenetCenter.s() - intermediateFrenetCenters.front().s());
    //}

    frenetCenters.insert(
        frenetCenters.end(),
        intermediateFrenetCenters.begin(),
        intermediateFrenetCenters.end());

    const bool isClosedEndFrenetCenter = math::IsApprox(
        endFrenetCenter.s(),
        intermediateFrenetCenters.back().s(),
        0.2);

    if (!isClosedEndFrenetCenter)
    {
        frenetCenters.push_back(endFrenetCenter);
        //ROS_ERROR_STREAM("end frenet diff: "
        //    << endFrenetCenter.s() - intermediateFrenetCenters.back().s());
    }
    //else
    //{
    //    ROS_ERROR_STREAM("closed end frenet diff: "
    //        << endFrenetCenter.s() - intermediateFrenetCenters.back().s());
    //}

    const math::real_t halfLateralWidth = 0.5 * lateralWidth;

    std::vector<math::Vector2d_t> positivePolygonCorners(frenetCenters.size());
    std::vector<math::Vector2d_t> negativePolygonCorners(frenetCenters.size());
    auto positivePolygonCorner{positivePolygonCorners.begin()};
    auto negativePolygonCorner{negativePolygonCorners.begin()};

    //ROS_ERROR_STREAM("");
    for (auto frenetCenter{frenetCenters.begin()};
         frenetCenter != frenetCenters.end();
         ++frenetCenter, ++positivePolygonCorner, ++negativePolygonCorner)
    {
        const auto positiveFrenetCoord{
            math::FrenetCoord(frenetCenter->s(), frenetCenter->d() + halfLateralWidth)};
        const auto negativeFrenetCoord{
            math::FrenetCoord(frenetCenter->s(), frenetCenter->d() - halfLateralWidth)};
        *positivePolygonCorner = mFrenetTransformer.ConvertToCartesianCoord(
            positiveFrenetCoord);
        *negativePolygonCorner = mFrenetTransformer.ConvertToCartesianCoord(
            negativeFrenetCoord);
        //ROS_WARN_STREAM(
        //    "frenetCenter: " << *frenetCenter << '\n' <<
        //    "positiveFrenetCoord: " << positiveFrenetCoord << '\n' <<
        //    "negativeFrenetCoord: " << negativeFrenetCoord);
    }
    //ROS_ERROR_STREAM("");

//    {
//        ROS_WARN_STREAM('\n' <<
//            "positivePolygonCorners.size: " << positivePolygonCorners.size() << '\n' <<
//            "negativePolygonCorners.size: " << negativePolygonCorners.size());
//
//        if (positivePolygonCorners.size() == 2ul)
//        {
//            ROS_WARN_STREAM('\n' <<
//                "positivePolygonCorners: " << positivePolygonCorners.front().transpose() << '\n' <<
//                "positivePolygonCorners: " << positivePolygonCorners.back().transpose() << '\n' <<
//                "negativePolygonCorners: " << negativePolygonCorners.front().transpose() << '\n' <<
//                "negativePolygonCorners: " << negativePolygonCorners.back().transpose());
//        }
//    }

    std::vector<math::Vector2d_t> polygonCorners;
    polygonCorners.reserve(positivePolygonCorners.size() + negativePolygonCorners.size() + 1ul);
    polygonCorners.insert(
        polygonCorners.end(),
        positivePolygonCorners.begin(),
        positivePolygonCorners.end());
    polygonCorners.insert(
        polygonCorners.end(),
        negativePolygonCorners.rbegin(),
        negativePolygonCorners.rend());
    polygonCorners.push_back(polygonCorners.front());

    const Polygon2d polygon = geometry::ComputePolygon(polygonCorners);

    return polygon;
}

void PolygonEvaluator::Configure(const std::vector<math::Vector3d_t> &pointSequence)
{
    mPointSequence3d = pointSequence;
    mPointSequence2d.resize(mPointSequence3d.size());
    std::transform(
        mPointSequence3d.begin(),
        mPointSequence3d.end(),
        mPointSequence2d.begin(),
        [](const math::Vector3d_t &point3d)
        {return math::Vector2d_t(point3d.x(), point3d.y());});
    mFrenetTransformer.Configure(
        mPointSequence2d,
        utils::FileLineNumPairInstance());
}

// protected func.

// private func.

} // namespace geometry {
