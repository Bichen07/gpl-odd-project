#ifndef _CARLA_TOPIC_MANAGER_H_
#define _CARLA_TOPIC_MANAGER_H_

#include <string>
#include <carla_type.h>

namespace carla {

class TopicManager final
{

public:

    TopicManager();
    TopicManager(const TopicManager &) = delete;
    TopicManager &operator=(const TopicManager &) = delete;
    virtual ~TopicManager();

    std::string Generate(
        const TopicPrefixId &topicPrefixId,
        const std::string &roleName,
        const TopicId &topicId) const;

protected:

private:

    std::string QueryTopicPrefix(const TopicPrefixId &topicPrefixId) const;
    std::string QueryTopic(const TopicId &topoicId) const;
};

} // namespace carla {

#endif // #ifndef _CARLA_TOPIC_MANAGER_H_
