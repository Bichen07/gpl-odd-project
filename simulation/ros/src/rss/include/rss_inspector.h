#ifndef _RSS_INSPECTOR_H_
#define _RSS_INSPECTOR_H_

#include <sstream>
#include <ad/rss/situation/SituationSnapshot.hpp>
#include <ad/rss/state/RssStateSnapshot.hpp>
#include <ad/rss/world/RssDynamics.hpp>

namespace rss {

class Inspector final
{

public:

    Inspector();
    Inspector(const Inspector &) = delete;
    Inspector &operator=(const Inspector &) = delete;
    virtual ~Inspector() = default;

    void Check(
        const ad::rss::situation::SituationSnapshot &situationSnapshot,
        const ad::rss::state::RssStateSnapshot &stateSnapshot) const;
    void Configure(
        const ad::rss::world::RssDynamics &egoVehicleRssDynamics,
        const ad::rss::world::RssDynamics &otherVehicleRssDynamics);

protected:

private:

    struct RssDynamicsCheckList
    {
        bool alphaLon = true;
        bool alphaLat = true;
        bool maxSpeedOnAcceleration = true;
        bool unstructuredSettings = true;
    };

    void CheckSnapshotRssDynamics(
        const ad::rss::situation::SituationSnapshot &situationSnapshot,
        const ad::rss::state::RssStateSnapshot &stateSnapshot) const;
    void CheckSituationRssDynamics(
        const ad::rss::situation::SituationSnapshot &situationSnapshot) const;
    void CheckPriority(
        const ad::rss::situation::SituationSnapshot &situationSnapshot) const;
    bool IsEqualRssDynamics(
        const ad::rss::world::RssDynamics &ref,
        const ad::rss::world::RssDynamics &test) const;

    ad::rss::world::RssDynamics mEgoVehicleRssDynamics;
    ad::rss::world::RssDynamics mOtherVehicleRssDynamics;
    mutable std::stringstream mUnequalInfo;
    mutable RssDynamicsCheckList mRssDynamicsCheckList;
};

} // namespace rss {

#endif // #ifndef _RSS_INSPECTOR_H_
