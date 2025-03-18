#include <rss_generator.h>
#include <stdexcept>
#include <ros/console.h>
#include <ad/map/match/AdMapMatching.hpp>

namespace rss {

void GenerateENUObjectPosition(
    const ad::map::point::ENUPoint &centerPoint,
    const ad::map::point::ENUHeading &heading,
    const ad::map::point::GeoPoint &enuReferencePoint,
    const ad::physics::Dimension3D &dimension,
    ad::map::match::ENUObjectPosition &outputEnuObjectPosition)
{
    outputEnuObjectPosition.centerPoint = centerPoint;
    outputEnuObjectPosition.heading = heading;
    outputEnuObjectPosition.enuReferencePoint = enuReferencePoint;
    outputEnuObjectPosition.dimension = dimension;
}

void GenerateMapMatchObject(
    const ad::map::match::ENUObjectPosition &enuObjectPosition,
    const ad::physics::Distance &samplingDistance,
    ad::map::match::Object &outputObject)
{
    outputObject.enuPosition = enuObjectPosition;
    ad::map::match::AdMapMatching mapMatching;
    outputObject.mapMatchedBoundingBox = mapMatching.getMapMatchedBoundingBox(
        outputObject.enuPosition,
        samplingDistance);

    static constexpr std::size_t minReferencePointSize{
        static_cast<std::size_t>(ad::map::match::ObjectReferencePoints::Center)};
    if (outputObject.mapMatchedBoundingBox.referencePointPositions.size() < minReferencePointSize)
    {
        ROS_ERROR_STREAM(
            "referencePointPositions size: " <<
            outputObject.mapMatchedBoundingBox.referencePointPositions.size() << '\n' <<
            "minReferencePointSize" << minReferencePointSize);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    static constexpr std::size_t centerIdx{
        static_cast<std::size_t>(ad::map::match::ObjectReferencePoints::Center)};
    if (outputObject.mapMatchedBoundingBox.referencePointPositions[centerIdx].size() < 0u)
    {
        ROS_ERROR_STREAM(
            "referencePointPositions[center].size: " <<
            outputObject.mapMatchedBoundingBox.referencePointPositions[centerIdx].size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

ad::rss::world::LateralRssAccelerationValues GenerateLateralRssAccelerationValues(
    const ad::physics::Acceleration &accelMax,
    const ad::physics::Acceleration &brakeMin)
{
    ad::rss::world::LateralRssAccelerationValues output;
    output.accelMax = accelMax;
    output.brakeMin = brakeMin;

    return output;
}

ad::rss::world::LongitudinalRssAccelerationValues GenerateLongitudinalRssAccelerationValues(
    const ad::physics::Acceleration &accelMax,
    const ad::physics::Acceleration &brakeMax,
    const ad::physics::Acceleration &brakeMin,
    const ad::physics::Acceleration &brakeMinCorrect)
{
    ad::rss::world::LongitudinalRssAccelerationValues output;
    output.accelMax = accelMax;
    output.brakeMax = brakeMax;
    output.brakeMin = brakeMin;
    output.brakeMinCorrect = brakeMinCorrect;

    return output;
}

} // namespace rss {
