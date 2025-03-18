#ifndef _RSS_OBJECT_INTEGRATOR_H_
#define _RSS_OBJECT_INTEGRATOR_H_

#include <ad/rss/state/RssStateVector.hpp>
#include <ad/rss/situation/SituationVector.hpp>

namespace rss {

class RssObjectIntegrator final
{

public:

    RssObjectIntegrator();
    RssObjectIntegrator(const RssObjectIntegrator &) = delete;
    RssObjectIntegrator &operator=(const RssObjectIntegrator &) = delete;
    virtual ~RssObjectIntegrator() = default;

    void Compute(
        const ad::rss::situation::SituationVector &individualResponses,
        const ad::rss::state::RssStateVector &rssStates,
        ad::rss::situation::SituationVector &integratedIndividualResponses,
        ad::rss::state::RssStateVector &integratedRssStates);

protected:

private:

    std::vector<ad::rss::world::ObjectId> ExtractUniqueObjectIds(
        const ad::rss::state::RssStateVector &rssStates) const;
};

} // namespace rss {

#endif // #ifndef _RSS_OBJECT_INTEGRATOR_H_
