#ifndef _RSS_CONFIGURATION_H_
#define _RSS_CONFIGURATION_H_

#include <map>
#include <ad/rss/situation/SituationSnapshot.hpp>
#include <ad/rss/state/ProperResponse.hpp>
#include <ad/rss/state/RssStateSnapshot.hpp>
#include <ad/rss/world/LateralRssAccelerationValues.hpp>
#include <ad/rss/world/LongitudinalRssAccelerationValues.hpp>
#include <ad/rss/world/RssDynamics.hpp>
#include <ad/rss/world/UnstructuredSettings.hpp>

namespace rss {

class Configuration final
{

public:

    using MapId = std::string;

    Configuration();
    Configuration(const Configuration &) = delete;
    Configuration &operator=(const Configuration &) = delete;
    virtual ~Configuration() = default;

    const ad::rss::world::RssDynamics &GetEgoVehicleRssDynamics() const;
    const ad::rss::world::RssDynamics &GetOtherVehicleRssDynamics() const;
    const ad::rss::world::RssDynamics &GetPedestrianRssDynamics() const;
    const ad::rss::world::RssDynamics &GetArtificialObjectRssDynamics() const;

    const std::string QueryOpenDriveMapFile(const MapId &mapId) const;

protected:

private:

    using OpenDriveMapDict = std::map<MapId, std::string>;

    void ParseRssDynamics(
        const std::string &objectPrefix,
        ad::rss::world::RssDynamics &output) const;
    void ParseAlphaLon(
        const std::string &objectPrefix,
        ad::rss::world::LongitudinalRssAccelerationValues &output) const;
    void ParseAlphaLat(
        const std::string &objectPrefix,
        ad::rss::world::LateralRssAccelerationValues &output) const;
    void ParseLateralFluctuationMargin(
        const std::string &objectPrefix,
        ad::physics::Distance &output) const;
    void ParseResponseTime(
        const std::string &objectPrefix,
        ad::physics::Duration &output) const;
    void ParseMaxSpeedOnAcceleration(
        const std::string &objectPrefix,
        ad::physics::Speed &output) const;
    void ParseUnstructedSettings(
        const std::string &objectPrefix,
        ad::rss::world::UnstructuredSettings &output) const;
    void ParseOpenDriveMapDict(
        const std::string &objectPrefix,
        OpenDriveMapDict &outputOpenDriveMapDict) const;

    ad::rss::world::RssDynamics mEgoVehicleRssDynamics;
    ad::rss::world::RssDynamics mOtherVehicleRssDynamics;
    ad::rss::world::RssDynamics mPedestrianRssDynamics;
    OpenDriveMapDict mOpenDriveMapDict;
};

} // namespace rss {

#endif // #ifndef _RSS_CONFIGURATION_H_
