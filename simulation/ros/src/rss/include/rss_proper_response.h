#ifndef _RSS_PROPER_RESPONSE_H_
#define _RSS_PROPER_RESPONSE_H_

#include <rss_msgs/ProperResponse.h>
#include <ad/rss/state/ProperResponse.hpp>

namespace rss
{
    void ToProperResponseMsg(const ad::rss::state::ProperResponse &checkResult, rss_msgs::ProperResponse &outputMsg);
}  // namespace rss

#endif  // #ifndef _RSS_PROPER_RESPONSE_H_
