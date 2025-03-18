#ifndef _VISUALIZATION_AGENT_MARKER_H_
#define _VISUALIZATION_AGENT_MARKER_H_

#include <ros/time.h>
#include <ros/duration.h>
#include <scenario_msgs/AgentData.h>

namespace visualization {

struct AgentDataConfig final
{
    scenario_msgs::AgentData dataMsg;
    int32_t dataId;
    ros::Time stamp;
    std::string ns;
    ros::Duration lifetime;

    AgentDataConfig()
        : dataMsg{}
        , dataId{0}
        , stamp{}
        , ns{}
        , lifetime{}
    {
    }
    AgentDataConfig(
        const scenario_msgs::AgentData &inputAgentDataMsg,
        const int32_t inputDataId,
        const ros::Time &inputStamp,
        const std::string &inputNs,
        const ros::Duration &inputLifetime)
        : dataMsg{inputAgentDataMsg}
        , dataId{inputDataId}
        , stamp{inputStamp}
        , ns{inputNs}
        , lifetime{inputLifetime}
    {
    }
    AgentDataConfig(const AgentDataConfig &other) = default;
    AgentDataConfig &operator=(const AgentDataConfig &other) = default;
    ~AgentDataConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_AGENT_MARKER_H_
