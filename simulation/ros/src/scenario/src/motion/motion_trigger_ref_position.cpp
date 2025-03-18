#include <motion_trigger_ref_position.h>
#include <cctype>
#include <string>
#include <algorithm>
#include <ros/console.h>

namespace motion {

// public func.

void TriggerRefPosition::Configure(const boost::any &config)
{
    ROS_WARN_STREAM("no implementation: " << __func__);
}

// protected func.

// private func.

// non-member func.

TriggerRefPosition::TypeId ToTriggerRefPositionTypeId(const std::string &key)
{
    std::string lowercaseKey{key};
    std::transform(
        key.cbegin(),
        key.cend(),
        lowercaseKey.begin(),
        [](const char input)
        {return std::tolower(input);});
    static const std::map<std::string, TriggerRefPosition::TypeId> typeIdMap =
    {
        {
            ToTriggerRefPositionTypeLabel(TriggerRefPosition::Type::PositionBased),
            TriggerRefPosition::Type::PositionBased
        },
        {
            ToTriggerRefPositionTypeLabel(TriggerRefPosition::Type::AgentBased),
            TriggerRefPosition::Type::AgentBased
        },
    };

    const auto foundPair{typeIdMap.find(lowercaseKey)};
    if (foundPair == typeIdMap.end())
    {
        ROS_ERROR_STREAM(
            "invalid key: " << key << '\n' <<
            "return TriggerRefPosition::Null instead");
        return TriggerRefPosition::Type::Null;
    }

    return foundPair->second;
}

std::string ToTriggerRefPositionTypeLabel(const TriggerRefPosition::TypeId &typeId)
{
    static const std::map<TriggerRefPosition::TypeId, const char *> typeIdLabelMap =
    {
        {TriggerRefPosition::Type::PositionBased, "position_based"},
        {TriggerRefPosition::Type::AgentBased,    "agent_based"},
    };

    const auto foundPair{typeIdLabelMap.find(typeId)};
    if (typeIdLabelMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid " << typeId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

} // namespace motion {
