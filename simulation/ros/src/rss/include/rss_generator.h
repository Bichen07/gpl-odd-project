#ifndef _RSS_GENERATOR_H_
#define _RSS_GENERATOR_H_

#include <ad/map/match/ENUObjectPosition.hpp>
#include <ad/map/match/Object.hpp>
#include <ad/physics/Acceleration.hpp>
#include <ad/physics/Dimension3D.hpp>
#include <ad/rss/world/LateralRssAccelerationValues.hpp>
#include <ad/rss/world/LongitudinalRssAccelerationValues.hpp>
#include <ad/rss/map/RssObjectData.hpp>

namespace rss {

void GenerateENUObjectPosition(
    const ad::map::point::ENUPoint &centerPoint,
    const ad::map::point::ENUHeading &heading,
    const ad::map::point::GeoPoint &enuReferencePoint,
    const ad::physics::Dimension3D &dimension,
    ad::map::match::ENUObjectPosition &outputEnuObjectPosition);
void GenerateMapMatchObject(
    const ad::map::match::ENUObjectPosition &enuObjectPosition,
    const ad::physics::Distance &samplingDistance,
    ad::map::match::Object &outputObject);

ad::rss::world::LateralRssAccelerationValues GenerateLateralRssAccelerationValues(
    const ad::physics::Acceleration &accelMax,
    const ad::physics::Acceleration &brakeMin);
ad::rss::world::LongitudinalRssAccelerationValues GenerateLongitudinalRssAccelerationValues(
    const ad::physics::Acceleration &accelMax,
    const ad::physics::Acceleration &brakeMax,
    const ad::physics::Acceleration &brakeMin,
    const ad::physics::Acceleration &brakeMinCorrect);

} // namespace rss {

#endif // #ifndef _RSS_GENERATOR_H_
