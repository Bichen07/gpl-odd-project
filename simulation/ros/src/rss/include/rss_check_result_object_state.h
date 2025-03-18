#ifndef _RSS_CHECK_RESULT_OBJECT_STATE_H_
#define _RSS_CHECK_RESULT_OBJECT_STATE_H_

#include <ad/rss/situation/Situation.hpp>
#include <ad/rss/state/RssState.hpp>
#include <actor_object_class_id.h>
#include <rss_msgs/CheckResultObjectState.h>
#include <geometry_transform_3d.h>
#include <rss_structured_safety.h>
#include <rss_unstructured_safety.h>

namespace rss
{

    struct CheckResultObjectState final
    {
        uint32_t                      detectedObjectId;
        StructuredSafety              structuredSafety;
        UnstructuredSafety            unstructuredSafety;
        geometry::Transform3d         transform;
        actor::ObjectClassId          objectClassId;
        ad::rss::situation::Situation rssSituation;
        ad::rss::state::RssState      rssState;
        std::string                   name;
        float                         speedLon = 0.0;
        float                         speedLat = 0.0;

        CheckResultObjectState()
            : detectedObjectId{0ul},
              structuredSafety{},
              unstructuredSafety{},
              transform{},
              objectClassId{actor::ObjectClass::Null},
              rssSituation{},
              rssState{},
              name{}
        {
        }
        explicit CheckResultObjectState(const uint32_t                      &inputDetectedObjectId,
                                        const StructuredSafety              &inputStructuredSafety,
                                        const UnstructuredSafety            &inputUnstructuredSafety,
                                        const geometry::Transform3d         &inputTransform,
                                        const actor::ObjectClassId          &inputObjectClassId,
                                        const ad::rss::situation::Situation &inputRssSituation,
                                        const std::string                   &name,
                                        const ad::rss::state::RssState      &inputRssState)
            : detectedObjectId{inputDetectedObjectId},
              structuredSafety{inputStructuredSafety},
              unstructuredSafety{inputUnstructuredSafety},
              transform{inputTransform},
              objectClassId{inputObjectClassId},
              rssSituation{inputRssSituation},
              rssState{inputRssState},
              name{name}
        {
        }
        CheckResultObjectState(const CheckResultObjectState &)            = default;
        CheckResultObjectState &operator=(const CheckResultObjectState &) = default;
        ~CheckResultObjectState()                                         = default;
    };

    void ToCheckResultObjectStateMsg(const CheckResultObjectState &objectState, rss_msgs::CheckResultObjectState &outputMsg);

    template <typename charT, typename traits>
    std::basic_ostream<charT, traits> &operator<<(std::basic_ostream<charT, traits> &ostream, const CheckResultObjectState &state)
    {
        ostream << std::boolalpha << "[CheckResultObjectState]" << '\n'
                << "detectedObjectId: " << state.detectedObjectId << '\n'
                << "structuredSafety: " << state.structuredSafety << '\n'
                << "unstructuredSafety: " << state.unstructuredSafety << '\n'
                << "transform: " << state.transform << '\n'
                << "objectClassId: " << state.objectClassId << '\n'
                << "rssSituation: " << state.rssSituation << '\n'
                << "rssState: " << state.rssState << '\n'
                << "name: " << state.name;
        return ostream;
    }

}  // namespace rss

#endif  // #ifndef _RSS_CHECK_RESULT_OBJECT_STATE_H_
