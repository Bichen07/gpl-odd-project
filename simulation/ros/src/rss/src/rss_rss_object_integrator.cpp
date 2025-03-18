#include <rss_rss_object_integrator.h>
#include <stdexcept>
#include <ros/console.h>

namespace rss {

// public func.

RssObjectIntegrator::RssObjectIntegrator()
{
}

void RssObjectIntegrator::Compute(
    const ad::rss::situation::SituationVector &individualResponses,
    const ad::rss::state::RssStateVector &rssStates,
    ad::rss::situation::SituationVector &integratedIndividualResponses,
    ad::rss::state::RssStateVector &integratedRssStates)
{
    if (individualResponses.size() != rssStates.size())
    {
        ROS_ERROR_STREAM(
            "diff. size between individualResponses and rssStates" << '\n' <<
            "individualResponses: " << individualResponses.size() << '\n' <<
            "rssStates: " << rssStates.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto uniqueObjectIds{
        this->ExtractUniqueObjectIds(rssStates)};
    if (uniqueObjectIds.size() == rssStates.size())
    {
        integratedIndividualResponses = individualResponses;
        integratedRssStates = rssStates;
        return;
    }

    integratedIndividualResponses.resize(uniqueObjectIds.size());
    integratedRssStates.resize(uniqueObjectIds.size());
    auto integratedResponse{integratedIndividualResponses.begin()};
    auto integratedRssState{integratedRssStates.begin()};
    for (auto uniqueObjectId{uniqueObjectIds.cbegin()};
         uniqueObjectId != uniqueObjectIds.cend();
         ++uniqueObjectId, ++integratedResponse, ++integratedRssState)
    {
        const auto foundSituation = std::find_if(
            individualResponses.cbegin(),
            individualResponses.cend(),
            [&uniqueObjectId](const ad::rss::situation::Situation &response)
            {return response.objectId == *uniqueObjectId;});
        if (individualResponses.cend() == foundSituation)
        {
            ROS_ERROR_STREAM("invalid uniqueObjectId: " << *uniqueObjectId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
        *integratedResponse = *foundSituation;

        const auto foundRssState = std::find_if(
            rssStates.cbegin(),
            rssStates.cend(),
            [&uniqueObjectId](const ad::rss::state::RssState &rssState)
            {return rssState.objectId == *uniqueObjectId;});
        if (rssStates.cend() == foundRssState)
        {
            ROS_ERROR_STREAM("invalid uniqueObjectId: " << *uniqueObjectId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
        *integratedRssState = *foundRssState;
    }
}

// protected func.

// private func.

std::vector<ad::rss::world::ObjectId> RssObjectIntegrator::ExtractUniqueObjectIds(
    const ad::rss::state::RssStateVector &rssStates) const
{
    std::vector<ad::rss::world::ObjectId> uniqueObjectIds;
    uniqueObjectIds.reserve(rssStates.size());
    for (auto rssState{rssStates.cbegin()};
         rssState != rssStates.cend();
         ++rssState)
    {
        const bool hasThisObjectId{
            std::any_of(
                uniqueObjectIds.cbegin(),
                uniqueObjectIds.cend(),
                [&rssState](const ad::rss::world::ObjectId &objectId)
                {return rssState->objectId == objectId;})};
        if (!hasThisObjectId)
        {
            uniqueObjectIds.push_back(rssState->objectId);
        }
    }

    uniqueObjectIds.shrink_to_fit();
    return uniqueObjectIds;
}

} // namespace rss {
