#include <carla_topic_manager.h>
#include <stdexcept>
#include <ros/console.h>

namespace carla {

// public func.

TopicManager::TopicManager()
{
}

TopicManager::~TopicManager()
{
}

std::string TopicManager::Generate(
    const TopicPrefixId &topicPrefixId,
    const std::string &roleName,
    const TopicId &topicId) const
{
    const std::string outputTopic =
        this->QueryTopicPrefix(topicPrefixId) +
        "/" + roleName +
        this->QueryTopic(topicId);

    return outputTopic;
}

// protected func.

// private func.

std::string TopicManager::QueryTopicPrefix(const TopicPrefixId &topicPrefixId) const
{
    static const std::map<TopicPrefixId, const char *> topicPrefixMap =
    {
        {TopicPrefix::Carla, "carla"},
        {TopicPrefix::Mmsl,  "mmsl"},
    };

    const auto foundPrefix{topicPrefixMap.find(topicPrefixId)};
    if (topicPrefixMap.end() == foundPrefix)
    {
        ROS_ERROR_STREAM("invalid " << topicPrefixId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return std::string(foundPrefix->second);
}

std::string TopicManager::QueryTopic(const TopicId &topicId) const
{
    static const std::map<TopicId, const char *> topicMap =
    {
        {Topic::AckermannCmd,      "/ackermann_cmd"},
        {Topic::VehicleControlCmd, "/vehicle_control_cmd"},
        {Topic::VehicleStatus,     "/vehicle_status"},
        {Topic::VehicleInfo,       "/vehicle_info"},
        {Topic::VehiclePose,       "/vehicle_pose"},
        {Topic::CarState,          "/car_state"},
        {Topic::Imu,               "/imu"},
    };

    const auto foundTopic{topicMap.find(topicId)};
    if (topicMap.end() == foundTopic)
    {
        ROS_ERROR_STREAM("invlid " << topicId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return std::string(foundTopic->second);
}

} // namespace carla {
