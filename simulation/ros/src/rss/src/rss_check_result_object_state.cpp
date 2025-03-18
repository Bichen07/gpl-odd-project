#include <rss_check_result_object_state.h>
#include <stdexcept>
#include <ros/console.h>
#include <rss_converter.h>

namespace rss
{

    void ToCheckResultObjectStateMsg(const CheckResultObjectState &objectState, rss_msgs::CheckResultObjectState &outputMsg)
    {
        // outputMsg.detected_object_id = objectState.detectedObjectId;
        outputMsg.name     = objectState.name;
        outputMsg.speedLon = objectState.speedLon;
        outputMsg.speedLat = objectState.speedLat;
        outputMsg.situation_type =
            static_cast<typename std::underlying_type<ad::rss::situation::SituationType>::type>(objectState.rssSituation.situationType);
        rss::ToStructuredSafetyMsg(objectState.structuredSafety, outputMsg.structured_safety);
        rss::ToUnstructuredSafetyMsg(objectState.unstructuredSafety, outputMsg.unstructured_safety);
        rss::ToRssStateMsg(objectState.rssState, outputMsg.rss_state);
        // if (actor::ObjectClass::Null == objectState.objectClassId)
        // {
        //     ROS_ERROR_STREAM("invalid " << objectState.objectClassId);
        //     throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        // }
        // outputMsg.object_class_id =
        //     static_cast<typename std::underlying_type<actor::ObjectClass>::type>(
        //         objectState.objectClassId);
    }

}  // namespace rss
