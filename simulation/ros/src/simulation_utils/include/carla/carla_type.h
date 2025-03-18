#ifndef _CARLA_TYPE_H_
#define _CARLA_TYPE_H_

#include <map>
#include <ostream>

namespace carla {

typedef enum class TopicPrefix: int32_t
{
    Carla,
    Mmsl,
    Num,
    Null = Num,
} TopicPrefixId;

typedef enum class Topic: int32_t
{
    AckermannCmd,
    VehicleControlCmd,
    VehicleStatus,
    VehicleInfo,
    VehiclePose,
    CarState,
    Imu,
    Num,
    Null = Num,
} TopicId;

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const TopicPrefixId &topicPrefixId)
{
    static const std::map<TopicPrefixId, const char *> topicPrefixIdMap =
    {
        {TopicPrefix::Carla, "TopicPrefix::Carla"},
        {TopicPrefix::Mmsl,  "TopicPrefix::Mmsl"},
        {TopicPrefix::Null,  "TopicPrefix::Null"},
    };

    ostream << topicPrefixIdMap.find(topicPrefixId)->second;
    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const TopicId &topicId)
{
    static const std::map<TopicId, const char *> topicIdMap =
    {
        {Topic::AckermannCmd,      "Topic::AckermannCmd"},
        {Topic::VehicleControlCmd, "Topic::VehicleControlCmd"},
        {Topic::VehicleStatus,     "Topic::VehicleStatus"},
        {Topic::VehicleInfo,       "Topic::VehicleInfo"},
        {Topic::VehiclePose,       "Topic::VehiclePose"},
        {Topic::CarState,          "Topic::CarState"},
        {Topic::Imu,               "Topic::Imu"},
        {Topic::Null,              "Topic::Null"},
    };

    ostream << topicIdMap.find(topicId)->second;
    return ostream;
}

} // namespace carla {

#endif // #ifndef _CARLA_TYPE_H_
