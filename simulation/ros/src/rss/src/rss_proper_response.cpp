#include <rss_msgs/ProperResponse.h>
#include <ad/rss/state/ProperResponse.hpp>

namespace rss
{

    void ToProperResponseMsg(const ad::rss::state::ProperResponse &properResponse, rss_msgs::ProperResponse &outputProperResponseMsg)
    {
        outputProperResponseMsg.lateralResponseLeft       = int32_t(properResponse.lateralResponseLeft);
        outputProperResponseMsg.lateralResponseRight      = int32_t(properResponse.lateralResponseRight);
        outputProperResponseMsg.longitudinalResponse      = int32_t(properResponse.longitudinalResponse);
        outputProperResponseMsg.unstructuredSceneResponse = int32_t(properResponse.unstructuredSceneResponse);
    }

}  // namespace rss
