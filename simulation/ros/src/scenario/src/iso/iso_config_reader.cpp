#include <iso_config_reader.h>
#include <ros/console.h>
#include <utils_json.h>

namespace iso {

bool ParseAgentId(
    const Json::Value &configJsonValue,
    std::string *outputAgentId)
{
    if (nullptr == outputAgentId)
    {
        ROS_WARN_STREAM("outputAgentId is nullptr");
        return false;
    }

    static constexpr const char *isoAgentIdKey{"iso_agent_id"};
    if (!utils::IsMemberKey(configJsonValue, isoAgentIdKey))
    {
        outputAgentId->clear();
        ROS_WARN_STREAM(isoAgentIdKey << " is not valid key");
        return false;
    }

    *outputAgentId = utils::GetStringJsonValue(configJsonValue[isoAgentIdKey]);

    return true;
}

bool ParseAgentIds(
    const Json::Value &configJsonValue,
    std::vector<std::string> *outputAgentIds)
{
    if (nullptr == outputAgentIds)
    {
        ROS_WARN_STREAM("outputAgentIds is nullptr");
        return false;
    }

    outputAgentIds->clear();
    if (configJsonValue.empty())
    {
        ROS_WARN_STREAM("configJsonValue is empty");
        return false;
    }

    outputAgentIds->resize(configJsonValue.size());
    auto outputAgentId{outputAgentIds->begin()};
    for (const auto &value: configJsonValue)
    {
        if (!iso::ParseAgentId(value, &(*outputAgentId)))
        {
            outputAgentIds->clear();
        }
        ++outputAgentId;
    }

    return true;
}

} // namespace iso {
